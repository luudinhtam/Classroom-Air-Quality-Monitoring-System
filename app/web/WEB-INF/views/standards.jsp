<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.AppUser, util.Web"%>
<%
    String ctx = request.getContextPath();
    AppUser me = (AppUser) session.getAttribute("user");
    String userName = (me != null && me.getFullName() != null) ? me.getFullName() : "Admin User";
    String userRole = (me != null && me.getRoleCode() != null) ? me.getRoleCode() : "ADMIN";
    boolean isAdmin = "ADMIN".equals(userRole);

    int openAlertCount = (request.getAttribute("openAlertCount") != null) ? (Integer) request.getAttribute("openAlertCount") : dao.AlertDAO.getOpeningAlertCount();
    String jDateStr = (request.getAttribute("jDateStr") != null) ? (String) request.getAttribute("jDateStr") : "Thursday, 12 November 2026";
    String jTimeStr = (request.getAttribute("jTimeStr") != null) ? (String) request.getAttribute("jTimeStr") : "12:00";
    String jSidebarDateTime = (request.getAttribute("jSidebarDateTime") != null) ? (String) request.getAttribute("jSidebarDateTime") : "Thursday, 12/11/2026, 12:00";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Safety Standards & Alert Preview - AirRoom</title>
    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/dashboard.css">
    <link rel="stylesheet" href="<%= ctx %>/assets/css/standards.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- 1. FIXED LEFT SIDEBAR (235px) -->
    <aside class="sidebar" id="sidebar">
        <!-- Logo Header -->
        <div class="sidebar-logo">
            <div class="logo-box">
                <!-- Thermometer SVG Icon -->
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 14.76V3.5a2.5 2.5 0 0 0-5 0v11.26a4.5 4.5 0 1 0 5 0z"/>
                    <circle cx="11.5" cy="17.5" r="1.5" fill="#2563eb"/>
                </svg>
            </div>
            <div class="logo-text">
                <span class="brand-title">Classroom Temp</span>
                <span class="brand-sub">Monitoring System</span>
            </div>
        </div>

        <!-- Vertical Menu Navigation -->
        <nav class="sidebar-menu">
            <!-- Dashboard -->
            <a href="<%= ctx %>/dashboard" class="menu-item" title="Dashboard">
                <svg class="menu-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                    <polyline points="9 22 9 12 15 12 15 22"/>
                </svg>
                <span>Dashboard</span>
            </a>

            <!-- Classrooms -->
            <a href="<%= ctx %>/admin/rooms" class="menu-item" title="Classrooms">
                <svg class="menu-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="3" y="3" width="7" height="7" rx="1.5"/>
                    <rect x="14" y="3" width="7" height="7" rx="1.5"/>
                    <rect x="14" y="14" width="7" height="7" rx="1.5"/>
                    <rect x="3" y="14" width="7" height="7" rx="1.5"/>
                </svg>
                <span>Classrooms</span>
            </a>

            <!-- Alerts -->
            <a href="<%= ctx %>/alerts" class="menu-item" title="Alerts">
                <svg class="menu-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
                </svg>
                <span>Alerts</span>
                <span class="sidebar-badge" id="sidebarAlertBadge"><%= openAlertCount %></span>
            </a>

            <!-- ACTIVE ITEM: Standards & Alert Preview -->
            <a href="<%= ctx %>/standarts" class="menu-item active" title="Safety Standards & Alert Preview">
                <svg class="menu-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                    <polyline points="9 12 11 14 15 10"/>
                </svg>
                <span>Standards</span>
            </a>

            <!-- Devices -->
            <% if (isAdmin) { %>
            <a href="<%= ctx %>/admin/devices" class="menu-item" title="Devices">
                <svg class="menu-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <rect x="4" y="4" width="16" height="16" rx="2"/>
                    <rect x="9" y="9" width="6" height="6"/>
                    <path d="M9 1v3M15 1v3M9 20v3M15 20v3M20 9h3M20 14h3M1 9h3M1 14h3"/>
                </svg>
                <span>Devices</span>
            </a>

            <!-- Users -->
            <a href="<%= ctx %>/admin/users" class="menu-item" title="Users">
                <svg class="menu-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                <span>Users</span>
            </a>
            <% } %>
        </nav>

        <!-- Sidebar Footer Status -->
        <div class="sidebar-footer">
            <div class="status-live">
                <span class="live-dot"></span>
                <span class="live-text">System Online</span>
            </div>
            <div class="status-time" id="sidebarLastUpdate"><%= jSidebarDateTime %></div>
        </div>
    </aside>

    <!-- 2. MAIN CONTENT AREA -->
    <main class="main-content" id="mainContent">
        <!-- TOP BAR -->
        <header class="top-bar">
            <!-- Left: Hamburger Toggle & Breadcrumb -->
            <div class="top-bar-left">
                <button class="hamburger-btn" id="btnSidebarToggle" title="Toggle Sidebar">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="3" y1="12" x2="21" y2="12"/>
                        <line x1="3" y1="6" x2="21" y2="6"/>
                        <line x1="3" y1="18" x2="21" y2="18"/>
                    </svg>
                </button>

                <nav class="breadcrumb">
                    <a href="<%= ctx %>/dashboard" class="breadcrumb-item breadcrumb-home" title="Home">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                            <polyline points="9 22 9 12 15 12 15 22"/>
                        </svg>
                    </a>
                    <span class="breadcrumb-separator">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="9 18 15 12 9 6"/>
                        </svg>
                    </span>
                    <span class="breadcrumb-item breadcrumb-current">Standards</span>
                </nav>
            </div>

            <!-- Right: Notifications & User Profile -->
            <div class="top-bar-right">
                <a href="<%= ctx %>/alerts" class="icon-btn-round" title="Alerts">
                    <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="#4b5563" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/>
                        <path d="M13.73 21a2 2 0 0 1-3.46 0"/>
                    </svg>
                    <span class="notif-badge" id="topBellBadge"><%= openAlertCount %></span>
                </a>

                <div class="user-profile-badge" id="userMenuToggle">
                    <div class="user-avatar-circle">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                            <circle cx="12" cy="7" r="4"/>
                        </svg>
                    </div>
                    <span class="user-name"><%= Web.esc(userName) %></span>
                    <svg class="dropdown-chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="6 9 12 15 18 9"/>
                    </svg>

                    <!-- User Dropdown Menu -->
                    <div class="user-dropdown-menu" id="userDropdownMenu">
                        <div class="user-dropdown-header">
                            Role: <%= Web.esc(userRole) %>
                        </div>
                        <a href="<%= ctx %>/logout" class="user-dropdown-item logout">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                                <polyline points="16 17 21 12 16 7"/>
                                <line x1="21" y1="12" x2="9" y2="12"/>
                            </svg>
                            <span>Logout</span>
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- 3. PAGE TITLE SECTION -->
        <section class="page-title-section">
            <div class="title-left-group">
                <div class="title-icon-box">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                        <polyline points="9 12 11 14 15 10"/>
                    </svg>
                </div>
                <div class="title-text-group">
                    <h1 class="page-main-heading">Safety Standards &amp; Alert Preview</h1>
                    <p class="page-subheading">Safe classroom air levels and easy alert preview.</p>
                </div>
            </div>

            <!-- Date & Time Card -->
            <div class="datetime-card">
                <div class="datetime-item">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#6b7280" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                        <line x1="16" y1="2" x2="16" y2="6"/>
                        <line x1="8" y1="2" x2="8" y2="6"/>
                        <line x1="3" y1="10" x2="21" y2="10"/>
                    </svg>
                    <span class="datetime-date"><%= jDateStr %></span>
                </div>
                <div class="datetime-divider"></div>
                <div class="datetime-item">
                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"/>
                        <polyline points="12 6 12 12 16 14"/>
                    </svg>
                    <span class="datetime-time"><%= jTimeStr %></span>
                </div>
            </div>
        </section>

        <!-- 4. METRIC NAVIGATION TABS (4 TABS) -->
        <nav class="standards-tab-bar">
            <button type="button" class="standards-tab-btn active" data-tab="temp">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M14 14.76V3.5a2.5 2.5 0 0 0-5 0v11.26a4.5 4.5 0 1 0 5 0z"/>
                </svg>
                <span>Temperature</span>
                <span class="tab-badge">&deg;C</span>
            </button>

            <button type="button" class="standards-tab-btn" data-tab="humid">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"/>
                </svg>
                <span>Humidity</span>
                <span class="tab-badge">%</span>
            </button>

            <button type="button" class="standards-tab-btn" data-tab="co2">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/>
                </svg>
                <span>CO&#8322; (Air Freshness)</span>
                <span class="tab-badge">ppm</span>
            </button>

            <button type="button" class="standards-tab-btn" data-tab="co">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="9"/>
                    <path d="M12 7v10M7 12h10"/>
                </svg>
                <span>CO (Dangerous Gas)</span>
                <span class="tab-badge">ppm</span>
            </button>
        </nav>

        <!-- 5. TAB 1: TEMPERATURE -->
        <section class="tab-content-panel active" id="panel-temp">
            <div class="standards-grid-2col">
                <!-- Card 1: Standard Table -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M14 14.76V3.5a2.5 2.5 0 0 0-5 0v11.26a4.5 4.5 0 1 0 5 0z"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Temperature Standards</h3>
                                <p class="card-desc-text">Good temperature ranges for classroom comfort</p>
                            </div>
                        </div>
                    </div>

                    <table class="levels-table">
                        <thead>
                            <tr>
                                <th>Status</th>
                                <th>Range</th>
                                <th>How It Feels in Class</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="level-tag tag-low">Cold</span></td>
                                <td class="level-range-val">&lt; 20.0&deg;C</td>
                                <td>Room is cold; students may need warm clothes.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-optimal">Good</span></td>
                                <td class="level-range-val">20.0&deg;C &ndash; 28.0&deg;C</td>
                                <td>Best room temperature; easy to focus and study.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-warning">Warm</span></td>
                                <td class="level-range-val">28.1&deg;C &ndash; 31.9&deg;C</td>
                                <td>Room feels warm; students may feel sleepy.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-critical">Too Hot</span></td>
                                <td class="level-range-val">&ge; 32.0&deg;C</td>
                                <td>Room is too hot; students get tired quickly.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Card 2: Interactive Alert Simulator -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Alert Preview &amp; Test</h3>
                                <p class="card-desc-text">Move the slider or click buttons to see how alerts look</p>
                            </div>
                        </div>
                    </div>

                    <div class="sim-controls-panel">
                        <div class="sim-slider-row">
                            <input type="range" class="sim-slider" id="sliderTemp" min="16" max="38" step="0.5" value="25">
                            <span class="sim-val-display" id="dispTempVal">25.0&deg;C</span>
                        </div>
                        <div class="sim-presets-row">
                            <span class="sim-preset-label">Quick Test:</span>
                            <button type="button" class="sim-btn-preset" data-preset-temp="18.0">Cold (18&deg;C)</button>
                            <button type="button" class="sim-btn-preset active" data-preset-temp="25.0">Good (25&deg;C)</button>
                            <button type="button" class="sim-btn-preset" data-preset-temp="29.5">Warm (29.5&deg;C)</button>
                            <button type="button" class="sim-btn-preset" data-preset-temp="33.5">Too Hot (33.5&deg;C)</button>
                        </div>
                    </div>

                    <!-- Alert Preview Box -->
                    <div class="alert-preview-container">
                        <div class="alert-preview-box box-normal" id="previewBoxTemp">
                            <div class="preview-icon-wrapper">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M14 14.76V3.5a2.5 2.5 0 0 0-5 0v11.26a4.5 4.5 0 1 0 5 0z"/>
                                </svg>
                            </div>
                            <div class="preview-content">
                                <div class="preview-header-line">
                                    <span class="preview-alert-title" id="titleTemp">Comfortable Temperature</span>
                                    <span class="preview-code-pill" id="codeTemp">STATUS-NORMAL</span>
                                </div>
                                <p class="preview-message-text" id="msgTemp">Room temperature (25.0&deg;C) is good for class (20 &ndash; 28&deg;C).</p>
                                <div class="preview-action-hint" id="hintTemp">Advice: Everything looks good. No action needed.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 6. TAB 2: HUMIDITY -->
        <section class="tab-content-panel" id="panel-humid">
            <div class="standards-grid-2col">
                <!-- Card 1: Standard Table -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Humidity Standards</h3>
                                <p class="card-desc-text">Safe air humidity to stop mold and stay healthy</p>
                            </div>
                        </div>
                    </div>

                    <table class="levels-table">
                        <thead>
                            <tr>
                                <th>Status</th>
                                <th>Range</th>
                                <th>How It Feels in Class</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="level-tag tag-low">Dry</span></td>
                                <td class="level-range-val">&lt; 40%</td>
                                <td>Air is dry; can cause dry eyes and sore throat.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-optimal">Good</span></td>
                                <td class="level-range-val">40% &ndash; 70%</td>
                                <td>Best air humidity; easy to breathe and stay healthy.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-warning">High</span></td>
                                <td class="level-range-val">71% &ndash; 79%</td>
                                <td>Air feels sticky and humid, like before rain.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-critical">Too High</span></td>
                                <td class="level-range-val">&ge; 80%</td>
                                <td>Very humid; mold can grow on walls and desks.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Card 2: Interactive Alert Simulator -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Alert Preview &amp; Test</h3>
                                <p class="card-desc-text">Move the slider or click buttons to see how alerts look</p>
                            </div>
                        </div>
                    </div>

                    <div class="sim-controls-panel">
                        <div class="sim-slider-row">
                            <input type="range" class="sim-slider" id="sliderHumid" min="20" max="98" step="1" value="55">
                            <span class="sim-val-display" id="dispHumidVal">55%</span>
                        </div>
                        <div class="sim-presets-row">
                            <span class="sim-preset-label">Quick Test:</span>
                            <button type="button" class="sim-btn-preset" data-preset-humid="32">Dry (32%)</button>
                            <button type="button" class="sim-btn-preset active" data-preset-humid="55">Good (55%)</button>
                            <button type="button" class="sim-btn-preset" data-preset-humid="75">High (75%)</button>
                            <button type="button" class="sim-btn-preset" data-preset-humid="88">Too Humid (88%)</button>
                        </div>
                    </div>

                    <!-- Alert Preview Box -->
                    <div class="alert-preview-container">
                        <div class="alert-preview-box box-normal" id="previewBoxHumid">
                            <div class="preview-icon-wrapper">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"/>
                                </svg>
                            </div>
                            <div class="preview-content">
                                <div class="preview-header-line">
                                    <span class="preview-alert-title" id="titleHumid">Healthy Air Humidity</span>
                                    <span class="preview-code-pill" id="codeHumid">STATUS-NORMAL</span>
                                </div>
                                <p class="preview-message-text" id="msgHumid">Room humidity (55%) is in a healthy range (40 &ndash; 70%).</p>
                                <div class="preview-action-hint" id="hintHumid">Advice: No action needed. The air is fresh and dry enough.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 7. TAB 3: CO2 & VOLATILE OIL TRANSIENT SPIKE -->
        <section class="tab-content-panel" id="panel-co2">
            <div class="standards-grid-2col">
                <!-- Card 1: Standard Table -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">CO&#8322; Air Freshness Standards</h3>
                                <p class="card-desc-text">Fresh air levels and detecting strong smell spikes</p>
                            </div>
                        </div>
                    </div>

                    <table class="levels-table">
                        <thead>
                            <tr>
                                <th>Status</th>
                                <th>Range</th>
                                <th>Air Quality in Class</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="level-tag tag-optimal">Fresh Air</span></td>
                                <td class="level-range-val">&lt; 700 ppm</td>
                                <td>Very fresh air; students stay awake and active.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-optimal">Good Air</span></td>
                                <td class="level-range-val">700 &ndash; 1,000 ppm</td>
                                <td>Normal fresh air for a full classroom.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-warning">Stuffy Air</span></td>
                                <td class="level-range-val">&gt; 1,000 ppm</td>
                                <td>Air is getting stuffy; students start yawning and feel tired.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-critical">Very Stuffy</span></td>
                                <td class="level-range-val">&gt; 1,500 ppm</td>
                                <td>Air is very stuffy; can cause headaches and sleepiness.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-spike">Smell Spike (Oil)</span></td>
                                <td class="level-range-val">&Delta; &gt; 300 ppm/min</td>
                                <td><strong>Medicated Oil / Alcohol Spike:</strong> Quick jump in &lt;30s from oil or perfume; not bad air.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Card 2: Interactive Alert Simulator -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Alert Preview &amp; Test</h3>
                                <p class="card-desc-text">Move the slider or click buttons to see how alerts look</p>
                            </div>
                        </div>
                    </div>

                    <div class="sim-controls-panel">
                        <div class="sim-slider-row">
                            <input type="range" class="sim-slider" id="sliderCo2" min="450" max="2200" step="25" value="650">
                            <span class="sim-val-display" id="dispCo2Val">650 ppm</span>
                        </div>
                        <div class="sim-presets-row">
                            <span class="sim-preset-label">Quick Test:</span>
                            <button type="button" class="sim-btn-preset active" data-preset-co2="650">Fresh (650)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co2="920">Good (920)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co2="1250">Stuffy (1,250)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co2="1750">Very Stuffy (1,750)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co2="oil" style="border-color: #8b5cf6; color: #7c3aed; font-weight: 700;">Oil Smell (1,680*)</button>
                        </div>
                    </div>

                    <!-- Alert Preview Box -->
                    <div class="alert-preview-container">
                        <div class="alert-preview-box box-normal" id="previewBoxCo2">
                            <div class="preview-icon-wrapper">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"/>
                                </svg>
                            </div>
                            <div class="preview-content">
                                <div class="preview-header-line">
                                    <span class="preview-alert-title" id="titleCo2">Fresh Classroom Air</span>
                                    <span class="preview-code-pill" id="codeCo2">STATUS-NORMAL</span>
                                </div>
                                <p class="preview-message-text" id="msgCo2">CO&#8322; level (650 ppm) is low. The air is clean and fresh.</p>
                                <div class="preview-action-hint" id="hintCo2">Advice: Great air quality. Students can study with high focus.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 8. TAB 4: CARBON MONOXIDE (CO) -->
        <section class="tab-content-panel" id="panel-co">
            <div class="standards-grid-2col">
                <!-- Card 1: Standard Table -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="9"/>
                                    <path d="M12 7v10M7 12h10"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Carbon Monoxide (CO) Safety Standards</h3>
                                <p class="card-desc-text">Safety limits for dangerous gas from smoke or engines</p>
                            </div>
                        </div>
                    </div>

                    <table class="levels-table">
                        <thead>
                            <tr>
                                <th>Status</th>
                                <th>Range</th>
                                <th>Safety &amp; Health Risk</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="level-tag tag-optimal">Safe Air</span></td>
                                <td class="level-range-val">&lt; 4.0 ppm</td>
                                <td>Clean air with no dangerous gas; 100% safe.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-warning">Small Smell</span></td>
                                <td class="level-range-val">4.0 &ndash; 8.9 ppm</td>
                                <td>Light smoke or exhaust coming in; please check outside.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-critical">Danger Level</span></td>
                                <td class="level-range-val">&ge; 9.0 ppm</td>
                                <td>Dangerous gas; can cause dizziness, headaches, and sickness.</td>
                            </tr>
                            <tr>
                                <td><span class="level-tag tag-critical">Leave Now</span></td>
                                <td class="level-range-val">&gt; 25.0 ppm</td>
                                <td>Emergency level; everyone must walk outside right now.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Card 2: Interactive Alert Simulator -->
                <div class="standards-card">
                    <div class="card-heading-row">
                        <div class="card-title-group">
                            <div class="card-icon-pill">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="card-main-title">Alert Preview &amp; Test</h3>
                                <p class="card-desc-text">Move the slider or click buttons to see how alerts look</p>
                            </div>
                        </div>
                    </div>

                    <div class="sim-controls-panel">
                        <div class="sim-slider-row">
                            <input type="range" class="sim-slider" id="sliderCo" min="0" max="20" step="0.5" value="1.2">
                            <span class="sim-val-display" id="dispCoVal">1.2 ppm</span>
                        </div>
                        <div class="sim-presets-row">
                            <span class="sim-preset-label">Quick Test:</span>
                            <button type="button" class="sim-btn-preset active" data-preset-co="1.2">Safe (1.2 ppm)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co="6.5">Light Smoke (6.5 ppm)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co="9.8">Danger (9.8 ppm)</button>
                            <button type="button" class="sim-btn-preset" data-preset-co="16.0">Emergency (16.0 ppm)</button>
                        </div>
                    </div>

                    <!-- Alert Preview Box -->
                    <div class="alert-preview-container">
                        <div class="alert-preview-box box-normal" id="previewBoxCo">
                            <div class="preview-icon-wrapper">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="9"/>
                                    <path d="M12 7v10M7 12h10"/>
                                </svg>
                            </div>
                            <div class="preview-content">
                                <div class="preview-header-line">
                                    <span class="preview-alert-title" id="titleCo">Safe Air &ndash; No Harmful Gas</span>
                                    <span class="preview-code-pill" id="codeCo">STATUS-SAFE</span>
                                </div>
                                <p class="preview-message-text" id="msgCo">Carbon monoxide level (1.2 ppm) is normal. The air is completely safe.</p>
                                <div class="preview-action-hint" id="hintCo">Advice: No action needed. There is no smoke or gas leak in class.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <script src="<%= ctx %>/assets/js/standards.js?v=<%= System.currentTimeMillis() %>" charset="UTF-8"></script>
</body>
</html>
