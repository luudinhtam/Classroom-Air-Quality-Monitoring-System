/**
 * Standards & Live Alert Simulation Script
 * Classroom Air Monitoring System (AirRoom)
 */

document.addEventListener("DOMContentLoaded", () => {
    // 1. Tab Switching
    const tabBtns = document.querySelectorAll(".standards-tab-btn");
    const panels = document.querySelectorAll(".tab-content-panel");

    tabBtns.forEach(btn => {
        btn.addEventListener("click", () => {
            const target = btn.dataset.tab;
            tabBtns.forEach(b => b.classList.remove("active"));
            panels.forEach(p => p.classList.remove("active"));

            btn.classList.add("active");
            const targetPanel = document.getElementById("panel-" + target);
            if (targetPanel) targetPanel.classList.add("active");
        });
    });

    // 2. Metric Simulator Handlers
    initTempSimulator();
    initHumidSimulator();
    initCo2Simulator();
    initCoSimulator();

    // 3. Hamburger Sidebar & Profile Dropdown
    const btnToggle = document.getElementById("btnSidebarToggle");
    if (btnToggle) {
        btnToggle.addEventListener("click", () => {
            document.body.classList.toggle("sidebar-collapsed");
        });
    }

    const userMenuToggle = document.getElementById("userMenuToggle");
    const userDropdownMenu = document.getElementById("userDropdownMenu");
    if (userMenuToggle && userDropdownMenu) {
        userMenuToggle.addEventListener("click", (e) => {
            e.stopPropagation();
            userDropdownMenu.classList.toggle("show");
        });
        document.addEventListener("click", (e) => {
            if (!userDropdownMenu.contains(e.target)) {
                userDropdownMenu.classList.remove("show");
            }
        });
    }
});

/* =============================================================================
   1. TEMPERATURE SIMULATOR
   ============================================================================= */
function initTempSimulator() {
    const slider = document.getElementById("sliderTemp");
    const valDisplay = document.getElementById("dispTempVal");
    const box = document.getElementById("previewBoxTemp");
    const titleEl = document.getElementById("titleTemp");
    const codeEl = document.getElementById("codeTemp");
    const msgEl = document.getElementById("msgTemp");
    const hintEl = document.getElementById("hintTemp");
    const presets = document.querySelectorAll("[data-preset-temp]");

    function update(val) {
        val = parseFloat(val);
        valDisplay.innerHTML = val.toFixed(1) + "&deg;C";

        box.className = "alert-preview-box";
        if (val < 20.0) {
            box.classList.add("box-warning");
            titleEl.textContent = "Cold Room Notice";
            codeEl.textContent = "NOTICE-TEMP-LOW";
            msgEl.textContent = "Room temperature is low (" + val.toFixed(1) + "\u00B0C). Students may feel cold.";
            hintEl.textContent = "Advice: Turn up the air conditioner or turn off extra fans.";
        } else if (val <= 28.0) {
            box.classList.add("box-normal");
            titleEl.textContent = "Comfortable Temperature";
            codeEl.textContent = "STATUS-NORMAL";
            msgEl.textContent = "Room temperature (" + val.toFixed(1) + "\u00B0C) is good for class (20 \u2013 28\u00B0C).";
            hintEl.textContent = "Advice: Everything looks good. No action needed.";
        } else if (val < 32.0) {
            box.classList.add("box-warning");
            titleEl.textContent = "Warm Room Notice";
            codeEl.textContent = "WARN-TEMP-ELEVATED";
            msgEl.textContent = "Room temperature (" + val.toFixed(1) + "\u00B0C) is getting warm, close to 32.0\u00B0C.";
            hintEl.textContent = "Advice: Open windows or turn on the air conditioner.";
        } else {
            box.classList.add("box-critical");
            titleEl.textContent = "High Temperature Warning";
            codeEl.textContent = "TEMPERATURE";
            msgEl.textContent = "Room temperature is too hot: " + val.toFixed(1) + "\u00B0C (Safe limit: \u2264 32.0\u00B0C).";
            hintEl.textContent = "Action Needed: Turn on fans, check the air conditioner, and open doors for cooler air.";
        }
    }

    if (slider) {
        slider.addEventListener("input", (e) => {
            update(e.target.value);
            presets.forEach(p => p.classList.remove("active"));
        });
    }

    presets.forEach(btn => {
        btn.addEventListener("click", () => {
            presets.forEach(p => p.classList.remove("active"));
            btn.classList.add("active");
            const v = parseFloat(btn.dataset.presetTemp);
            slider.value = v;
            update(v);
        });
    });

    update(slider ? slider.value : 25.0);
}

/* =============================================================================
   2. HUMIDITY SIMULATOR
   ============================================================================= */
function initHumidSimulator() {
    const slider = document.getElementById("sliderHumid");
    const valDisplay = document.getElementById("dispHumidVal");
    const box = document.getElementById("previewBoxHumid");
    const titleEl = document.getElementById("titleHumid");
    const codeEl = document.getElementById("codeHumid");
    const msgEl = document.getElementById("msgHumid");
    const hintEl = document.getElementById("hintHumid");
    const presets = document.querySelectorAll("[data-preset-humid]");

    function update(val) {
        val = parseInt(val, 10);
        valDisplay.textContent = val + "%";

        box.className = "alert-preview-box";
        if (val < 40) {
            box.classList.add("box-warning");
            titleEl.textContent = "Dry Air Notice";
            codeEl.textContent = "NOTICE-HUMID-LOW";
            msgEl.textContent = "Room humidity is low (" + val + "%). Dry air can make throats dry and skin itchy.";
            hintEl.textContent = "Advice: Turn off dry mode on the air conditioner if possible.";
        } else if (val <= 70) {
            box.classList.add("box-normal");
            titleEl.textContent = "Healthy Air Humidity";
            codeEl.textContent = "STATUS-NORMAL";
            msgEl.textContent = "Room humidity (" + val + "%) is healthy and comfortable (40 \u2013 70%).";
            hintEl.textContent = "Advice: No action needed. The air is fresh and dry enough to stop mold.";
        } else if (val < 80) {
            box.classList.add("box-warning");
            titleEl.textContent = "High Humidity Notice";
            codeEl.textContent = "WARN-HUMID-HIGH";
            msgEl.textContent = "Room humidity is high (" + val + "%), close to the 80% safe limit.";
            hintEl.textContent = "Advice: Turn on dry mode on the air conditioner or open windows for air flow.";
        } else {
            box.classList.add("box-critical");
            titleEl.textContent = "High Humidity Warning";
            codeEl.textContent = "HUMID";
            msgEl.textContent = "Room humidity is too high: " + val + "% (Safe limit: \u2264 80.0%).";
            hintEl.textContent = "Action Needed: Check for rain or wet spots. Turn on the air conditioner in dry mode.";
        }
    }

    if (slider) {
        slider.addEventListener("input", (e) => {
            update(e.target.value);
            presets.forEach(p => p.classList.remove("active"));
        });
    }

    presets.forEach(btn => {
        btn.addEventListener("click", () => {
            presets.forEach(p => p.classList.remove("active"));
            btn.classList.add("active");
            const v = parseInt(btn.dataset.presetHumid, 10);
            slider.value = v;
            update(v);
        });
    });

    update(slider ? slider.value : 55);
}

/* =============================================================================
   3. CO2 SIMULATOR & VOLATILE OIL (VOC SPIKE) DETECTION
   ============================================================================= */
function initCo2Simulator() {
    const slider = document.getElementById("sliderCo2");
    const valDisplay = document.getElementById("dispCo2Val");
    const box = document.getElementById("previewBoxCo2");
    const titleEl = document.getElementById("titleCo2");
    const codeEl = document.getElementById("codeCo2");
    const msgEl = document.getElementById("msgCo2");
    const hintEl = document.getElementById("hintCo2");
    const presets = document.querySelectorAll("[data-preset-co2]");
    let isOdorSpikeMode = false;

    function update(val, isSpike) {
        val = parseInt(val, 10);
        valDisplay.textContent = val + " ppm";
        box.className = "alert-preview-box";

        if (isSpike) {
            box.classList.add("box-spike");
            titleEl.textContent = "Temporary Smell Spike (Medicated Oil)";
            codeEl.textContent = "VOC_SPIKE";
            msgEl.textContent = "Temporary Spike: Quick jump to " + val + " ppm in under 30 seconds while temperature and humidity stay steady. This is usually caused by medicated oil, perfume, or hand sanitizer, not bad air.";
            hintEl.textContent = "Advice: Check if someone opened medicated oil or hand sanitizer in class. The number will drop back to normal in 2 to 5 minutes. No need to leave the room.";
            return;
        }

        if (val < 700) {
            box.classList.add("box-normal");
            titleEl.textContent = "Fresh Classroom Air";
            codeEl.textContent = "STATUS-NORMAL";
            msgEl.textContent = "CO\u2082 level (" + val + " ppm) is low. The air is clean and fresh.";
            hintEl.textContent = "Advice: Great air quality. Students can study with high focus.";
        } else if (val <= 1000) {
            box.classList.add("box-normal");
            titleEl.textContent = "Good Air Quality";
            codeEl.textContent = "STATUS-NORMAL";
            msgEl.textContent = "CO\u2082 level (" + val + " ppm) is in the safe range for a classroom (\u2264 1000 ppm).";
            hintEl.textContent = "Advice: The room has enough fresh air for all students.";
        } else if (val <= 1400) {
            box.classList.add("box-warning");
            titleEl.textContent = "Stuffy Air Warning";
            codeEl.textContent = "CO2";
            msgEl.textContent = "Room CO\u2082 is getting high: " + val + " ppm (Safe limit: \u2264 1000 ppm). The air is stuffy.";
            hintEl.textContent = "Action Needed: Open doors and windows, and turn on fans for fresh air.";
        } else {
            box.classList.add("box-critical");
            titleEl.textContent = "Very Stuffy Air Warning";
            codeEl.textContent = "CO2";
            msgEl.textContent = "Room CO\u2082 is very high: " + val + " ppm. The room is very stuffy, making students tired and sleepy.";
            hintEl.textContent = "Action Needed: Open all doors and windows right away for fresh air flow.";
        }
    }

    if (slider) {
        slider.addEventListener("input", (e) => {
            isOdorSpikeMode = false;
            update(e.target.value, false);
            presets.forEach(p => p.classList.remove("active"));
        });
    }

    presets.forEach(btn => {
        btn.addEventListener("click", () => {
            presets.forEach(p => p.classList.remove("active"));
            btn.classList.add("active");

            if (btn.dataset.presetCo2 === "oil") {
                isOdorSpikeMode = true;
                slider.value = 1680;
                update(1680, true);
            } else {
                isOdorSpikeMode = false;
                const v = parseInt(btn.dataset.presetCo2, 10);
                slider.value = v;
                update(v, false);
            }
        });
    });

    update(slider ? slider.value : 650, false);
}

/* =============================================================================
   4. CARBON MONOXIDE (CO) SIMULATOR
   ============================================================================= */
function initCoSimulator() {
    const slider = document.getElementById("sliderCo");
    const valDisplay = document.getElementById("dispCoVal");
    const box = document.getElementById("previewBoxCo");
    const titleEl = document.getElementById("titleCo");
    const codeEl = document.getElementById("codeCo");
    const msgEl = document.getElementById("msgCo");
    const hintEl = document.getElementById("hintCo");
    const presets = document.querySelectorAll("[data-preset-co]");

    function update(val) {
        val = parseFloat(val);
        valDisplay.textContent = (val % 1 === 0 ? val.toFixed(0) : val.toFixed(1)) + " ppm";

        box.className = "alert-preview-box";
        if (val < 4.0) {
            box.classList.add("box-normal");
            titleEl.textContent = "Safe Air \u2013 No Harmful Gas";
            codeEl.textContent = "STATUS-SAFE";
            msgEl.textContent = "Carbon monoxide level (" + val.toFixed(1) + " ppm) is normal. The air is completely safe.";
            hintEl.textContent = "Advice: No action needed. There is no smoke or gas leak in class.";
        } else if (val < 9.0) {
            box.classList.add("box-warning");
            titleEl.textContent = "Low Gas Level Notice";
            codeEl.textContent = "WARN-CO-ELEVATED";
            msgEl.textContent = "Low level of carbon monoxide detected: " + val.toFixed(1) + " ppm, close to the 9.0 ppm limit.";
            hintEl.textContent = "Advice: Check for smoke, vehicle exhaust, or burning smells coming into the room.";
        } else {
            box.classList.add("box-critical");
            titleEl.textContent = "Dangerous Gas Warning (High CO)";
            codeEl.textContent = "CO";
            msgEl.textContent = "Carbon monoxide is above the safe limit: " + val.toFixed(1) + " ppm (Safe limit: \u2264 9.0 ppm).";
            hintEl.textContent = "CRITICAL: Have everyone leave the room right now, open windows, and find where the smoke comes from.";
        }
    }

    if (slider) {
        slider.addEventListener("input", (e) => {
            update(e.target.value);
            presets.forEach(p => p.classList.remove("active"));
        });
    }

    presets.forEach(btn => {
        btn.addEventListener("click", () => {
            presets.forEach(p => p.classList.remove("active"));
            btn.classList.add("active");
            const v = parseFloat(btn.dataset.presetCo);
            slider.value = v;
            update(v);
        });
    });

    update(slider ? slider.value : 1.2);
}
