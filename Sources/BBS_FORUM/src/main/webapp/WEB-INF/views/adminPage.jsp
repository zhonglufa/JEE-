<%--
  Created by IntelliJ IDEA.
  User: 爱锅粥粥
  Date: 2025/6/16
  Time: 1:15
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>论坛管理后台</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary: #4361ee;
      --primary-dark: #3a56d4;
      --secondary: #ff5a5f;
      --secondary-dark: #e04b53;
      --success: #10b981;
      --warning: #f59e0b;
      --dark: #1e293b;
      --light: #f8fafc;
      --sidebar-bg: #1e293b;
      --sidebar-text: #cbd5e1;
      --sidebar-active: #4361ee;
      --card-bg: #ffffff;
      --border: #e2e8f0;
      --text-primary: #334155;
      --text-secondary: #64748b;
      --radius: 8px;
      --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', 'Noto Sans SC', sans-serif;
    }

    body {
      background-color: #f1f5f9;
      color: var(--text-primary);
      display: grid;
      grid-template-columns: 240px 1fr;
      min-height: 100vh;
    }

    /* 侧边栏样式 */
    .sidebar {
      background: var(--sidebar-bg);
      color: var(--sidebar-text);
      padding: 1.5rem 0;
      position: sticky;
      top: 0;
      height: 100vh;
      overflow-y: auto;
    }

    .logo {
      padding: 0 1.5rem 1.5rem;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      margin-bottom: 1.5rem;
    }

    .logo h1 {
      font-size: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .logo i {
      color: var(--primary);
    }

    .nav-links {
      display: flex;
      flex-direction: column;
      gap: 0.25rem;
      padding: 0 0.75rem;
    }

    .nav-link {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      padding: 0.85rem 1rem;
      border-radius: var(--radius);
      text-decoration: none;
      color: var(--sidebar-text);
      transition: all 0.2s;
      font-weight: 500;
    }

    .nav-link:hover {
      background: rgba(255, 255, 255, 0.05);
    }

    .nav-link.active {
      background: var(--primary);
      color: white;
    }

    .nav-link i {
      width: 24px;
      text-align: center;
    }

    /* 主内容区 */
    .main-content {
      padding: 1.5rem;
      overflow-y: auto;
      max-height: 100vh;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid var(--border);
    }

    .header h2 {
      font-size: 1.75rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .header-actions {
      display: flex;
      gap: 0.75rem;
    }

    .btn {
      padding: 0.65rem 1.25rem;
      border-radius: var(--radius);
      border: none;
      font-weight: 500;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      transition: all 0.2s;
    }

    .btn-primary {
      background: var(--primary);
      color: white;
    }

    .btn-primary:hover {
      background: var(--primary-dark);
    }

    .btn-danger {
      background: var(--secondary);
      color: white;
    }

    .btn-danger:hover {
      background: var(--secondary-dark);
    }

    /* 卡片样式 */
    .card {
      background: var(--card-bg);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      overflow: hidden;
      margin-bottom: 1.5rem;
    }

    .card-header {
      padding: 1rem 1.5rem;
      border-bottom: 1px solid var(--border);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .card-title {
      font-size: 1.1rem;
      font-weight: 600;
    }

    .card-body {
      padding: 1.5rem;
    }

    /* 表格样式 */
    .table-container {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    thead {
      background-color: #f8fafc;
    }

    th {
      padding: 0.85rem 1rem;
      text-align: left;
      font-weight: 600;
      color: var(--text-secondary);
      font-size: 0.85rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    td {
      padding: 1rem;
      border-top: 1px solid var(--border);
      color: var(--text-primary);
      font-size: 0.95rem;
    }

    tr:hover {
      background-color: #f8fafc;
    }

    .badge {
      display: inline-block;
      padding: 0.3rem 0.75rem;
      border-radius: 50px;
      font-size: 0.8rem;
      font-weight: 500;
    }

    .badge-success {
      background: #dcfce7;
      color: #166534;
    }

    .badge-warning {
      background: #fef3c7;
      color: #854d0e;
    }

    .badge-danger {
      background: #fee2e2;
      color: #b91c1c;
    }

    .badge-info {
      background: #dbeafe;
      color: #1e40af;
    }

    .actions {
      display: flex;
      gap: 0.5rem;
    }

    .action-btn {
      width: 32px;
      height: 32px;
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.2s;
      border: 1px solid var(--border);
      background: white;
    }

    .action-btn:hover {
      background: #f1f5f9;
      transform: translateY(-2px);
    }

    .action-btn.delete:hover {
      color: var(--secondary);
      border-color: #fee2e2;
      background: #fee2e2;
    }

    /* 搜索和筛选 */
    .filters {
      display: flex;
      gap: 1rem;
      margin-bottom: 1.5rem;
      flex-wrap: wrap;
    }

    .search-box {
      flex: 1;
      min-width: 250px;
      position: relative;
    }

    .search-box input {
      width: 100%;
      padding: 0.75rem 1rem 0.75rem 2.5rem;
      border: 1px solid var(--border);
      border-radius: var(--radius);
      font-size: 0.95rem;
    }

    .search-box i {
      position: absolute;
      left: 1rem;
      top: 50%;
      transform: translateY(-50%);
      color: var(--text-secondary);
    }

    .filter-select {
      min-width: 180px;
      padding: 0.75rem 1rem;
      border: 1px solid var(--border);
      border-radius: var(--radius);
      background: white;
      color: var(--text-primary);
      font-size: 0.95rem;
    }

    /* 分页 */
    .pagination {
      display: flex;
      justify-content: center;
      gap: 0.5rem;
      margin-top: 2rem;
    }

    .page-btn {
      width: 36px;
      height: 36px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 6px;
      background: white;
      border: 1px solid var(--border);
      cursor: pointer;
      transition: all 0.2s;
    }

    .page-btn:hover, .page-btn.active {
      background: var(--primary);
      color: white;
      border-color: var(--primary);
    }

    /* 统计卡片 */
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 1.5rem;
      margin-bottom: 1.5rem;
    }

    .stat-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      padding: 1.5rem;
      display: flex;
      align-items: center;
      gap: 1rem;
    }

    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
    }

    .comments .stat-icon {
      background: #e0f2fe;
      color: #0369a1;
    }

    .posts .stat-icon {
      background: #dcfce7;
      color: #166534;
    }

    .logs .stat-icon {
      background: #fef3c7;
      color: #854d0e;
    }

    .users .stat-icon {
      background: #ede9fe;
      color: #6d28d9;
    }

    .stat-info h3 {
      font-size: 1.5rem;
      font-weight: 600;
      margin-bottom: 0.25rem;
    }

    .stat-info p {
      color: var(--text-secondary);
      font-size: 0.9rem;
    }

    /* 空状态 */
    .empty-state {
      text-align: center;
      padding: 3rem;
      color: var(--text-secondary);
    }

    .empty-state i {
      font-size: 3rem;
      opacity: 0.3;
      margin-bottom: 1rem;
    }

    /* 响应式设计 */
    @media (max-width: 992px) {
      body {
        grid-template-columns: 1fr;
      }

      .sidebar {
        position: fixed;
        left: -240px;
        z-index: 100;
        transition: left 0.3s;
      }

      .sidebar.active {
        left: 0;
      }

      .mobile-toggle {
        display: block;
      }
    }

    @media (max-width: 768px) {
      .header {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
      }

      .header-actions {
        width: 100%;
        justify-content: space-between;
      }

      .stats {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 576px) {
      .main-content {
        padding: 1rem;
      }

      .filters {
        flex-direction: column;
      }

      .search-box, .filter-select {
        min-width: 100%;
      }
    }

    /* 移动端菜单切换 */
    .mobile-toggle {
      display: none;
      position: fixed;
      bottom: 1.5rem;
      right: 1.5rem;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background: var(--primary);
      color: white;
      z-index: 90;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    }

    @media (max-width: 992px) {
      .mobile-toggle {
        display: flex;
      }
    }
  </style>
</head>
<body>
<!-- 侧边栏 -->
<aside class="sidebar" id="sidebar">
  <div class="logo">
    <h1><i class="fas fa-shield-alt"></i> 管理后台</h1>
  </div>
  <nav class="nav-links">
    <a href="#" class="nav-link active" data-target="dashboard">
      <i class="fas fa-tachometer-alt"></i> 控制面板
    </a>
    <a href="#" class="nav-link" data-target="comments">
      <i class="fas fa-comments"></i> 评论管理
    </a>
    <a href="#" class="nav-link" data-target="posts">
      <i class="fas fa-file-alt"></i> 文章管理
    </a>
    <a href="#" class="nav-link" data-target="logs">
      <i class="fas fa-clipboard-list"></i> 操作日志
    </a>
    <a href="#" class="nav-link">
      <i class="fas fa-users"></i> 用户管理
    </a>
    <a href="#" class="nav-link">
      <i class="fas fa-cog"></i> 系统设置
    </a>
    <div style="margin-top: 2rem; padding: 0 1rem;">
      <a href="#" class="btn btn-primary" style="width: 100%; justify-content: center;">
        <i class="fas fa-sign-out-alt"></i> 退出登录
      </a>
    </div>
  </nav>
</aside>

<!-- 主内容区 -->
<main class="main-content">
  <!-- 控制面板头部 -->
  <div class="header">
    <h2><i class="fas fa-tachometer-alt"></i> 管理控制面板</h2>
    <div class="header-actions">
      <div class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="搜索...">
      </div>
      <div>
        <button class="btn btn-primary">
          <i class="fas fa-sync-alt"></i> 刷新
        </button>
      </div>
    </div>
  </div>

  <!-- 统计卡片 -->
  <div class="stats">
    <div class="stat-card comments">
      <div class="stat-icon">
        <i class="fas fa-comments"></i>
      </div>
      <div class="stat-info">
        <h3>1,248</h3>
        <p>待审评论</p>
      </div>
    </div>
    <div class="stat-card posts">
      <div class="stat-icon">
        <i class="fas fa-file-alt"></i>
      </div>
      <div class="stat-info">
        <h3>582</h3>
        <p>待审文章</p>
      </div>
    </div>
    <div class="stat-card logs">
      <div class="stat-icon">
        <i class="fas fa-clipboard-list"></i>
      </div>
      <div class="stat-info">
        <h3>24,891</h3>
        <p>操作日志</p>
      </div>
    </div>
    <div class="stat-card users">
      <div class="stat-icon">
        <i class="fas fa-users"></i>
      </div>
      <div class="stat-info">
        <h3>5,872</h3>
        <p>注册用户</p>
      </div>
    </div>
  </div>

  <!-- 评论管理 -->
  <div class="card" id="comments">
    <div class="card-header">
      <div class="card-title">
        <i class="fas fa-comments"></i> 评论管理
      </div>
      <div>
        <select class="filter-select">
          <option>所有状态</option>
          <option>待审核</option>
          <option>已通过</option>
          <option>已删除</option>
        </select>
      </div>
    </div>
    <div class="card-body">
      <div class="filters">
        <div class="search-box">
          <i class="fas fa-search"></i>
          <input type="text" placeholder="搜索评论内容...">
        </div>
        <select class="filter-select">
          <option>所有文章</option>
          <option>热门文章</option>
          <option>最新文章</option>
        </select>
        <select class="filter-select">
          <option>所有用户</option>
          <option>注册用户</option>
          <option>游客</option>
        </select>
      </div>

      <div class="table-container">
        <table>
          <thead>
          <tr>
            <th>评论内容</th>
            <th>所属文章</th>
            <th>评论用户</th>
            <th>发布时间</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>这篇文章非常有帮助！感谢分享。</td>
            <td>如何学习前端开发</td>
            <td>前端小白</td>
            <td>2023-10-15 14:23</td>
            <td><span class="badge badge-success">已通过</span></td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>内容包含不当言论，需要处理</td>
            <td>最新技术趋势分析</td>
            <td>匿名用户</td>
            <td>2023-10-16 09:45</td>
            <td><span class="badge badge-danger">待审核</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="通过">
                  <i class="fas fa-check"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>我不同意作者的观点，我认为应该...</td>
            <td>人工智能的未来发展</td>
            <td>科技爱好者</td>
            <td>2023-10-14 18:12</td>
            <td><span class="badge badge-success">已通过</span></td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>广告内容：点击链接获取优惠...</td>
            <td>2023年最佳编程语言</td>
            <td>推广账号</td>
            <td>2023-10-17 11:30</td>
            <td><span class="badge badge-danger">待审核</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="通过">
                  <i class="fas fa-check"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>这篇文章有几个错误的地方...</td>
            <td>JavaScript高级技巧</td>
            <td>资深开发者</td>
            <td>2023-10-13 16:54</td>
            <td><span class="badge badge-warning">已标记</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="通过">
                  <i class="fas fa-check"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <div class="page-btn active">1</div>
        <div class="page-btn">2</div>
        <div class="page-btn">3</div>
        <div class="page-btn">4</div>
        <div class="page-btn"><i class="fas fa-chevron-right"></i></div>
      </div>
    </div>
  </div>

  <!-- 文章管理 -->
  <div class="card" id="posts">
    <div class="card-header">
      <div class="card-title">
        <i class="fas fa-file-alt"></i> 文章管理
      </div>
      <div>
        <select class="filter-select">
          <option>所有状态</option>
          <option>已发布</option>
          <option>草稿</option>
          <option>已删除</option>
        </select>
      </div>
    </div>
    <div class="card-body">
      <div class="filters">
        <div class="search-box">
          <i class="fas fa-search"></i>
          <input type="text" placeholder="搜索文章标题...">
        </div>
        <select class="filter-select">
          <option>所有分类</option>
          <option>技术文章</option>
          <option>资源分享</option>
          <option>行业新闻</option>
        </select>
        <select class="filter-select">
          <option>所有作者</option>
          <option>管理员</option>
          <option>普通用户</option>
        </select>
      </div>

      <div class="table-container">
        <table>
          <thead>
          <tr>
            <th>文章标题</th>
            <th>作者</th>
            <th>分类</th>
            <th>发布时间</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>2023年前端开发趋势分析</td>
            <td>技术编辑</td>
            <td>技术文章</td>
            <td>2023-10-10 09:30</td>
            <td><span class="badge badge-success">已发布</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="编辑">
                  <i class="fas fa-edit"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>如何学习React框架：从入门到精通</td>
            <td>前端导师</td>
            <td>技术文章</td>
            <td>2023-10-12 14:15</td>
            <td><span class="badge badge-success">已发布</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="编辑">
                  <i class="fas fa-edit"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>最新JavaScript特性解析</td>
            <td>JS开发者</td>
            <td>技术文章</td>
            <td>2023-10-15 11:20</td>
            <td><span class="badge badge-warning">草稿</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="编辑">
                  <i class="fas fa-edit"></i>
                </div>
                <div class="action-btn" title="发布">
                  <i class="fas fa-upload"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>广告：购买我们的编程课程...</td>
            <td>推广账号</td>
            <td>资源分享</td>
            <td>2023-10-16 16:45</td>
            <td><span class="badge badge-danger">已删除</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="恢复">
                  <i class="fas fa-undo"></i>
                </div>
                <div class="action-btn delete" title="永久删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>不实信息：关于AI取代程序员...</td>
            <td>匿名用户</td>
            <td>行业新闻</td>
            <td>2023-10-17 08:10</td>
            <td><span class="badge badge-danger">待审核</span></td>
            <td>
              <div class="actions">
                <div class="action-btn" title="通过">
                  <i class="fas fa-check"></i>
                </div>
                <div class="action-btn delete" title="删除">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <div class="page-btn active">1</div>
        <div class="page-btn">2</div>
        <div class="page-btn">3</div>
        <div class="page-btn">4</div>
        <div class="page-btn"><i class="fas fa-chevron-right"></i></div>
      </div>
    </div>
  </div>

  <!-- 操作日志 -->
  <div class="card" id="logs">
    <div class="card-header">
      <div class="card-title">
        <i class="fas fa-clipboard-list"></i> 操作日志
      </div>
      <div>
        <select class="filter-select">
          <option>最近7天</option>
          <option>今天</option>
          <option>本月</option>
          <option>全部</option>
        </select>
      </div>
    </div>
    <div class="card-body">
      <div class="filters">
        <div class="search-box">
          <i class="fas fa-search"></i>
          <input type="text" placeholder="搜索操作内容...">
        </div>
        <select class="filter-select">
          <option>所有操作类型</option>
          <option>删除评论</option>
          <option>删除文章</option>
          <option>用户管理</option>
        </select>
        <select class="filter-select">
          <option>所有操作者</option>
          <option>管理员</option>
          <option>系统自动</option>
        </select>
      </div>

      <div class="table-container">
        <table>
          <thead>
          <tr>
            <th>操作内容</th>
            <th>操作类型</th>
            <th>操作者</th>
            <th>操作时间</th>
            <th>IP地址</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>删除了ID为235的评论</td>
            <td><span class="badge badge-danger">删除评论</span></td>
            <td>admin</td>
            <td>2023-10-17 14:23:05</td>
            <td>192.168.1.101</td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除日志">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>删除了文章《虚假广告信息》</td>
            <td><span class="badge badge-danger">删除文章</span></td>
            <td>admin</td>
            <td>2023-10-17 10:15:32</td>
            <td>192.168.1.101</td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除日志">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>通过了文章《React最佳实践》</td>
            <td><span class="badge badge-success">审核文章</span></td>
            <td>moderator</td>
            <td>2023-10-16 16:45:11</td>
            <td>192.168.1.102</td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除日志">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>禁用了用户spam_account</td>
            <td><span class="badge badge-warning">用户管理</span></td>
            <td>admin</td>
            <td>2023-10-16 09:30:45</td>
            <td>192.168.1.101</td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除日志">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>系统自动备份数据库</td>
            <td><span class="badge badge-info">系统操作</span></td>
            <td>system</td>
            <td>2023-10-16 03:00:00</td>
            <td>127.0.0.1</td>
            <td>
              <div class="actions">
                <div class="action-btn delete" title="删除日志">
                  <i class="fas fa-trash"></i>
                </div>
              </div>
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <div class="page-btn active">1</div>
        <div class="page-btn">2</div>
        <div class="page-btn">3</div>
        <div class="page-btn">4</div>
        <div class="page-btn"><i class="fas fa-chevron-right"></i></div>
      </div>
    </div>
  </div>
</main>

<!-- 移动端菜单切换按钮 -->
<div class="mobile-toggle" id="mobileToggle">
  <i class="fas fa-bars"></i>
</div>

<script>
  // 移动端菜单切换
  document.getElementById('mobileToggle').addEventListener('click', function() {
    document.getElementById('sidebar').classList.toggle('active');
    this.innerHTML = document.getElementById('sidebar').classList.contains('active') ?
            '<i class="fas fa-times"></i>' : '<i class="fas fa-bars"></i>';
  });

  // 导航菜单切换
  document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();

      // 更新活动菜单项
      document.querySelectorAll('.nav-link').forEach(item => {
        item.classList.remove('active');
      });
      this.classList.add('active');

      // 滚动到对应部分
      const target = this.getAttribute('data-target');
      if(target) {
        document.getElementById(target).scrollIntoView({behavior: 'smooth'});
      }
    });
  });

  // 删除按钮确认
  document.querySelectorAll('.action-btn.delete').forEach(btn => {
    btn.addEventListener('click', function() {
      const row = this.closest('tr');
      if(confirm('确定要删除此项吗？此操作不可撤销。')) {
        row.style.opacity = '0';
        setTimeout(() => {
          row.remove();
        }, 300);
      }
    });
  });
</script>
</body>
</html></html>