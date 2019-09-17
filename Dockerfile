# based on https://gitlab.com/gitlab-data/data-image/blob/master/dbt_image/Dockerfile
FROM python:3.7

# Copy in required files
COPY requirements.txt ./

# Install Python Requirements
RUN pip install -U pip
RUN pip install -r requirements.txt

# Install VIM and Bash completion
RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y bash-completion

# Install dbt completion script
RUN curl https://raw.githubusercontent.com/fishtown-analytics/dbt-completion.bash/master/dbt-completion.bash > ~/.dbt-completion.bash
RUN /bin/bash -c "source ~/.dbt-completion.bash"
RUN echo 'source ~/.dbt-completion.bash' >> ~/.bashrc

# Set the expected DBT_PROFILES_DIR
ENV DBT_PROFILES_DIR=/analytics/transform/snowflake-dbt/profile/

# Install the bash functions for dbt
COPY dbt_functions.sh ./
RUN cat dbt_functions.sh >> ~/.bashrc
RUN echo 'export -f dbt_run_changed' >> ~/.bashrc
