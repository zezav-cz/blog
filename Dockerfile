FROM python:3

RUN mkdir book out
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt
VOLUME [ "/out" ]
VOLUME [ "/book" ]

CMD [ "jupyter-book", "build", "--path-output", "/out", "/book" ]