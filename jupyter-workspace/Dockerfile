# Use an official Python runtime as a parent image
FROM python:3.13.2-alpine
# Set the working directory to /app
WORKDIR /app

# allow jupyter to run as user, instead of root
ARG USERNAME=jupyter
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd -g ${USER_GID} ${USERNAME} && \
    useradd -u ${USER_UID} -g ${USERNAME} -m ${USERNAME}

# copy requirements for pip
COPY requirements.txt .

RUN chown -R ${USERNAME}:${USERNAME} /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 11469

# Define environment variable
# Enable JupyterLab
ENV JUPYTER_ENABLE_LAB=yes

# Set the user to run the command as
USER ${USERNAME}

# Run Jupyter Notebook when the container launches
# TODO: set these args: --IdentityProvider.token='' --ServerApp.password='' --allow-root
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=11469", "--no-browser"]
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=11469", "--no-browser"]
