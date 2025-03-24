# HumanResourceEDA

## Project Overview
This repository contains an HR Analytics project focused on analyzing and visualizing key HR metrics, such as employee performance, retention rates, turnover, and recruitment effectiveness. The project uses MySQL to manage and query employee data, and Power BI for creating interactive dashboards that provide insights for HR decision-making.

## Dataset Description
The dataset includes the following key columns:

- **Employee Information**: 
  - `employee_id`, `first_name`, `last_name`, `birthdate`
  - `hire_date`, `termdate`, `age`

- **Job Details**: 
  - `jobtitle`, `department`, `salary`

## Tools Used
- **MySQL**: For managing company employee data and running exploratory data analysis queries.
- **Power BI**: For creating visualizations and dashboards for Human Resource insights.

## How to Set Up and Run the Project

### MySQL Setup
1. Download and install MySQL Workbench
2. Run the script `employee_analysis.sql` to create and populate the database with employee and recruitment data
3. Use the provided queries in `scripts/` to analyze HR metrics such as:
   - Turnover
   - Recruitment success rates
   - Employee performance

### Power BI Setup
1. Download and install Power BI Desktop (free version)
2. Open the `.pbix` file (`hr_dashboard.pbix`) in Power BI Desktop
3. Interact with the dashboard to explore HR metrics including:
   - Employee retention
   - Performance scores
   - Other KPIs

## Key Data Insights
The dataset includes key HR metrics such as:
- Employee demographics
- Performance ratings
- Salary information
- Recruitment data

Key metrics visualized include:

- **Employee Retention**: Analyzing the percentage of employees staying in the company over a period
- **Turnover Rate**: Tracking the rate at which employees leave the organization
- The average employment tenure for terminated employees is 8 years
- Department of Marketing and Accounting has the highest turnover rate at 65%
- Active employees total 17,000 out of 22,000 with the most employees in department of Ebgineering


Screenshots
<img width="1024" alt="Screenshot 2024-11-28 at 18 26 41" src="https://github.com/user-attachments/assets/8e093323-9c22-4e82-9bd2-5bce75f4ab90">


## Additional Notes

- The dataset is used solely for the purpose of demonstrating data analysis and visualization techniques
- For more advanced users, additional scripts and custom calculations are included in the project folder for deeper analysis

## License
This project is licensed under the [MIT License](LICENSE).
