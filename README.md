# BF Conversion Testing

Set of scripts to assist with testing Bibframe conversions (MARC to BF; BF to MARC).


## Getting Started

These scripts should be runnable directly on a server, but at the time of this 
writing (2 Sept 2020) that is untested.  The Docker approach, however, works.


### Prerequisites

* Docker 

OR

* Yaz MarcTools
* xsltproc
* xmllint


### Installing

```bash
git clone --recursive https://github.com/lcnetdev/bf-conversion-testing.git
cd bf-conversion-testing
cp config.default config
```

If you are not using Docker, alter the USE_DOCKERWRAPPER value in `config` to false.

To build docker image:
```bash
docker build -t lcnetdev:bf-conversion-testing .
```

### Running

There are three principle scripts, and a couple of helper scripts.

* `marc2bf` - Will convert a MARC record, fetched either from LC's LCCN service 
or SRU service, to Bibframe2.  It requires two parameters: identifer type and identifier.
Optionally, a third option - save - can be used to save the output to disk.
Examples:
```bash
./marc2bf bibid 5226            # Will output the result in RDF/XML
./marc2bf lccn 2020205006       # Will output the result in RDF/XML
./marc2bf bibid 5223 save       # Will save the result as RDF/XML
```

* `bf2marc` - Will convert a Bibframe resource to MARC.  The Bibframe resource is 
first converted from MARC only to be converted back to MARC.  It requires two 
parameters: identifer type and identifier.  Optionally, a third and/or fourth
option can be used to save the output to disk.  Using 'text' or 'txt' as the third 
parameter will serialize the MARC to a textual format.  The term "save" used either 
as the third or fourth option will save the output to disk.
Examples:
```bash
./bf2marc lccn 2020205006       # Will output the result in MARC/XML
./bf2marc lccn 2020205006 txt   # Will output the result as text
./bf2marc bibid 5226            # Will output the result in MARC/XML
./bf2marc bibid 5226 text       # Will output the result as text
./bf2marc bibid 5226 text save  # Will save the output as text
./bf2marc bibid 5226 save       # Will save the output as MARC/XML
```

### Maintenance

It is possible to generate a lot of files with the main scripts.  Two helper scripts 
exist for maintenance purposes:

```bash
./helpers/clean_in              # Will remove all files from the 'in' directory
./helpers/clean_out             # Will remove all files from the 'out' directory
```

Docker may also accumulate detritus so be aware of that.


## License
As a work of the United States government, this project is in the
public domain within the United States.

Additionally, we waive copyright and related rights in the work
worldwide through the CC0 1.0 Universal public domain dedication. 

[Legal Code (read the full text)](https://creativecommons.org/publicdomain/zero/1.0/legalcode).

You can copy, modify, distribute and perform the work, even for commercial
purposes, all without asking permission.


