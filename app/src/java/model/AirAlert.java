package model;

import java.sql.Timestamp;

public class AirAlert {
    private int alertId;
    private Integer sessionId;
    private String alertCode;
    private String alertType;
    private String ruleCode;
    private String message;
    private String status;
    private Integer handledBy;
    private String handledByName;
    private String note;
    private Timestamp createdAt;
    private String deviceCode;
    private String severity;

    public AirAlert() {}

    public int getAlertId() { return alertId; }
    public void setAlertId(int alertId) { this.alertId = alertId; }

    public Integer getSessionId() { return sessionId; }
    public void setSessionId(Integer sessionId) { this.sessionId = sessionId; }

    public String getAlertCode() { return alertCode; }
    public void setAlertCode(String alertCode) { this.alertCode = alertCode; }

    public String getAlertType() { return alertType; }
    public void setAlertType(String alertType) { this.alertType = alertType; }

    public String getType() { return alertType != null ? alertType : ruleCode; }
    public void setType(String type) { this.alertType = type; }

    public String getRuleCode() { return ruleCode != null ? ruleCode : (alertType != null ? alertType : alertCode); }
    public void setRuleCode(String ruleCode) { this.ruleCode = ruleCode; }

    public String getSeverity() { return severity != null ? severity : (alertType != null ? alertType : "WARNING"); }
    public void setSeverity(String severity) { this.severity = severity; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Integer getHandledBy() { return handledBy; }
    public void setHandledBy(Integer handledBy) { this.handledBy = handledBy; }

    public String getHandledByName() { return handledByName; }
    public void setHandledByName(String handledByName) { this.handledByName = handledByName; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getHandledNote() { return note; }
    public void setHandledNote(String handledNote) { this.note = handledNote; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getDeviceCode() { return deviceCode; }
    public void setDeviceCode(String deviceCode) { this.deviceCode = deviceCode; }

    private String roomCode;
    private Integer roomId;

    public String getRoomCode() { return roomCode; }
    public void setRoomCode(String roomCode) { this.roomCode = roomCode; }

    public Integer getRoomId() { return roomId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }

    // Dữ liệu số đo thực tế từ Air_Session tại thời điểm phát sinh alert
    private Double temperature;
    private Double humid;
    private Integer co;
    private Integer co2;

    public Double getTemperature() { return temperature; }
    public void setTemperature(Double temperature) { this.temperature = temperature; }

    public Double getHumid() { return humid; }
    public void setHumid(Double humid) { this.humid = humid; }

    public Integer getCo() { return co; }
    public void setCo(Integer co) { this.co = co; }

    public Integer getCo2() { return co2; }
    public void setCo2(Integer co2) { this.co2 = co2; }

    /**
     * Lấy giá trị số đo của chỉ số tương ứng với alert này.
     * Ưu tiên từ session trong DB (temperature, humid, co, co2).
     * Nếu không có trong session, fallback trích xuất số từ message.
     */
    public Double getMetricValue() {
        String type = getAlertType();
        if (type == null) type = getRuleCode();
        if (type == null) type = "";
        String upper = type.toUpperCase();

        if (upper.contains("TEMP")) {
            if (temperature != null) return temperature;
            return extractNumberFromMessage();
        } else if (upper.contains("HUMID")) {
            if (humid != null) return humid;
            return extractNumberFromMessage();
        } else if (upper.contains("CO2") || upper.contains("CARBON")) {
            if (co2 != null) return co2.doubleValue();
            return extractNumberFromMessage();
        } else if (upper.equals("CO")) {
            if (co != null) return co.doubleValue();
            return extractNumberFromMessage();
        }
        return extractNumberFromMessage();
    }

    private Double extractNumberFromMessage() {
        if (message == null || message.trim().isEmpty()) return null;
        try {
            java.util.regex.Pattern p = java.util.regex.Pattern.compile("(\\d+(?:\\.\\d+)?)");
            java.util.regex.Matcher m = p.matcher(message);
            if (m.find()) {
                return Double.parseDouble(m.group(1));
            }
        } catch (Exception ignored) {}
        return null;
    }

    /**
     * Đánh giá trạng thái chỉ số (Metric Status) theo đúng 100% định mức trang Standards.
     */
    public String getMetricStatus() {
        String type = getAlertType();
        if (type == null) type = getRuleCode();
        if (type == null) type = "";
        String upper = type.toUpperCase();

        // Kiểm tra biến thiên đột ngột mùi dầu / cồn cho CO2
        if (upper.contains("CO2") || upper.contains("CARBON")) {
            String msgLower = message != null ? message.toLowerCase() : "";
            String rule = ruleCode != null ? ruleCode.toUpperCase() : "";
            if (msgLower.contains("oil") || msgLower.contains("dầu") || msgLower.contains("spike")
                || msgLower.contains("cồn") || msgLower.contains("alcohol") || rule.contains("SPIKE")) {
                return "Smell Spike (Oil)";
            }
        }

        Double val = getMetricValue();
        if (val == null) {
            // Giá trị mặc định theo loại alert khi không xác định được số đo
            if (upper.contains("TEMP")) return "Too Hot";
            if (upper.contains("HUMID")) return "Too High";
            if (upper.contains("CO2")) return "Stuffy Air";
            if (upper.equals("CO")) return "Danger Level";
            return "Warning";
        }

        if (upper.contains("TEMP")) {
            if (val < 20.0) return "Cold";
            if (val <= 28.0) return "Good";
            if (val < 32.0) return "Warm";
            return "Too Hot";
        } else if (upper.contains("HUMID")) {
            if (val < 40.0) return "Dry";
            if (val <= 70.0) return "Good";
            if (val < 80.0) return "High";
            return "Too High";
        } else if (upper.contains("CO2") || upper.contains("CARBON")) {
            if (val < 700.0) return "Fresh Air";
            if (val <= 1000.0) return "Good Air";
            if (val <= 1500.0) return "Stuffy Air";
            return "Very Stuffy";
        } else if (upper.equals("CO")) {
            if (val < 4.0) return "Safe Air";
            if (val < 9.0) return "Small Smell";
            if (val <= 25.0) return "Danger Level";
            return "Leave Now";
        }

        return "Warning";
    }

    /**
     * CSS class màu badge đồng bộ từ trang Standards
     */
    public String getMetricBadgeClass() {
        String st = getMetricStatus();
        switch (st) {
            case "Cold":
            case "Dry":
                return "tag-low";
            case "Good":
            case "Fresh Air":
            case "Good Air":
            case "Safe Air":
                return "tag-optimal";
            case "Warm":
            case "High":
            case "Stuffy Air":
            case "Small Smell":
                return "tag-warning";
            case "Too Hot":
            case "Too High":
            case "Very Stuffy":
            case "Danger Level":
            case "Leave Now":
                return "tag-critical";
            case "Smell Spike (Oil)":
                return "tag-spike";
            default:
                return "tag-warning";
        }
    }
}
