Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD634A4C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCZJmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 05:42:39 -0400
Received: from mx-relay87-hz1.antispameurope.com ([94.100.132.254]:34435 "EHLO
        mx-relay87-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhCZJm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 05:42:28 -0400
Received: from unknown ([91.239.177.110]) by mx-relay87-hz1.antispameurope.com;
 Fri, 26 Mar 2021 10:42:23 +0100
Received: from dehwlwmsx02.claas.local (10.1.34.82) by dehwlwmsx02.claas.local
 (10.1.34.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 26 Mar
 2021 10:42:18 +0100
Received: from dehwlwmsx02.claas.local ([fe80::61e8:27a9:8d68:938]) by
 dehwlwmsx02.claas.local ([fe80::61e8:27a9:8d68:938%4]) with mapi id
 15.01.2176.009; Fri, 26 Mar 2021 10:42:18 +0100
From:   "Wulfhorst, Heiner" <Heiner.Wulfhorst@claas.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: Why doesn't btrfs find additional space after (VMware) disk
 extension?
Thread-Topic: Why doesn't btrfs find additional space after (VMware) disk
 extension?
Thread-Index: AdchjfubWkhUqWyOSe+KO47leh9ppP//8suA//7vGDCAAinQgP//4fUQ
Date:   Fri, 26 Mar 2021 09:42:18 +0000
Message-ID: <cb24366003a74b63a1db3ff8018c9692@claas.com>
References: <8a4b55eb42bd42d181abe9d7c208607c@claas.com>
        <20210325205857.412ab914@natsu> <f50ee91d04c94feda3a6ce413332e83d@claas.com>
 <20210326134421.24cd109a@natsu>
In-Reply-To: <20210326134421.24cd109a@natsu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.11.186]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_008D_01D7222C.B0A55690"
MIME-Version: 1.0
X-cloud-security-sender: heiner.wulfhorst@claas.com
X-cloud-security-recipient: linux-btrfs@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay87-hz1.antispameurope.com with 5F195E21A91
X-cloud-security-connect: unknown[91.239.177.110], TLS=1, IP=91.239.177.110
X-cloud-security-Digest: 08a3ff99175d3d955a104d9bb8e05235
X-cloud-security: scantime:1.572
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_NextPart_000_008D_01D7222C.B0A55690
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks, Roman, you got me back on Track!

I am new to btrfs so I was assuming RAID0 means there is no need for equally
sized disks.

After `btrfs balance start -dconvert=single -dlimit=10 /' output of `btrfs
filesystem usage /' now shows:

Overall:
    Device size:                 579.51GiB
    Device allocated:            126.99GiB
    Device unallocated:          452.52GiB
    Device missing:                  0.00B
    Used:                        125.42GiB
    Free (estimated):            452.72GiB      (min: 226.46GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:               24.05MiB      (used: 0.00B)

Data,single: Size:19.00GiB, Used:18.98GiB
   /dev/sdd       19.00GiB

Data,RAID0: Size:105.97GiB, Used:105.79GiB
   /dev/sdb2      36.99GiB
   /dev/sdc       31.99GiB
   /dev/sdd       36.99GiB

Metadata,RAID1: Size:1.00GiB, Used:333.61MiB
   /dev/sdb2       1.00GiB
   /dev/sdd        1.00GiB

System,RAID1: Size:8.00MiB, Used:16.00KiB
   /dev/sdc        8.00MiB
   /dev/sdd        8.00MiB

Unallocated:
   /dev/sdb2       9.52GiB
   /dev/sdc        1.00MiB
   /dev/sdd      443.00GiB



And finally:
# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        3.9G  8.0K  3.9G   1% /dev
tmpfs           3.9G     0  3.9G   0% /dev/shm
tmpfs           3.9G   17M  3.9G   1% /run
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sdb2       580G  126G   20G  87% /
/dev/sdb2       580G  126G   20G  87% /.snapshots
/dev/sdb2       580G  126G   20G  87% /usr/local
/dev/sdb2       580G  126G   20G  87% /opt
/dev/sdb2       580G  126G   20G  87% /root
/dev/sdb2       580G  126G   20G  87% /boot/grub2/i386-pc
/dev/sdb2       580G  126G   20G  87% /boot/grub2/x86_64-efi
/dev/sdb2       580G  126G   20G  87% /srv
/dev/sdb2       580G  126G   20G  87% /var
/dev/sdb2       580G  126G   20G  87% /tmp
/dev/sdb2       580G  126G   20G  87% /home
/dev/sdb2       580G  126G   20G  87% /var/cache
/dev/sdb1       500M  5.3M  495M   2% /boot/efi
tmpfs           796M     0  796M   0% /run/user/0

Thanks a lot! I will now read further documentation regarding "btrfs single
vs RAID*" to understand exactly why and how and also convert remaining space
to single (it's just a test
system).

Thanks a lot!

BR,
Heiner

------=_NextPart_000_008D_01D7222C.B0A55690
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
Wa8PwnlBNZD5yC9YYoO4E4fIDByGIE9cAh1TMPjFniRkcDM7VQIDAQABo4ICuDCCArQwPAYJKwYB
BAGCNxUHBC8wLQYlKwYBBAGCNxUIhfDJI5/9S4HdkRuHx/VJh53qd1uD/q9Gh+v0QgIBZAIBCzAT
BgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBSAwDAYDVR0TAQH/BAIwADBABgNVHSAE
OTA3MDUGDSsGAQQBgtFAg31kCgEwJDAiBggrBgEFBQcCARYWaHR0cDovL3BraS5jbGFhcy5jb20v
ADAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMEMIGUBgkqhkiG9w0BCQ8EgYYwgYMwCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBLTALBglghkgBZQMEARYwCwYJYIZIAWUDBAEZMAsGCWCGSAFlAwQB
AjALBglghkgBZQMEAQUwCgYIKoZIhvcNAwcwBwYFKw4DAgcwDgYIKoZIhvcNAwICAgCAMA4GCCqG
SIb3DQMEAgICADAdBgNVHQ4EFgQUq0NeFfmAnEjQje/tS91EoRj0zK8wHwYDVR0jBBgwFoAUyT+H
ZqfPCniFjAmTLNo/OlnfKIQwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL3BraS5jbGFhcy5jb20v
Y2RwL0NMQUFTJTIwU3ViJTIwQ0ElMjAwMi5jcmwwegYIKwYBBQUHAQEEbjBsMD4GCCsGAQUFBzAC
hjJodHRwOi8vcGtpLmNsYWFzLmNvbS9haWEvQ0xBQVMlMjBTdWIlMjBDQSUyMDAyLmNydDAqBggr
BgEFBQcwAYYeaHR0cDovL29jc3AucGtpLmNsYWFzLmNvbS9vY3NwMEoGA1UdEQRDMEGgIwYKKwYB
BAGCNxQCA6AVDBNJMDEyOTExQGNsYWFzLmxvY2FsgRpoZWluZXIud3VsZmhvcnN0QGNsYWFzLmNv
bTANBgkqhkiG9w0BAQUFAAOCAgEANOYyJ2eveRhO/vQpwg2ZavXf30vanHU9Rcd+b5ivHo1cVmCs
6X/Ssftc2fRimJsA8TTI+Bqa9FIcF3aee14fwEiDDDxm6hIXiHuuIKi697SvZFgQxTXFon8yWe3Y
3zp2Yya2ceNVSDASEdi9bPuv1lGLvAZfQuJM0F1uhc0norlISqiT6PuALP4ErbSZyFnI0bFI4eRK
9GyC9Jn7Poo5dcahv29yqODImn3ISSLOEiPLemLXeFk0i96loDDhorbur6OkL9heczPBLIUjkIOo
l2DAWH5cELF28rCbwwbrU01nwSf62oXPdg0PQ1+I7FZo2e7VJecUtbrXjT/kQdeDuW79IXYSrNc/
4ZIbSTBM1j4X2+gCpeQPrIqnQ085CQs7hyDd9/GbwY3AeoewVpf/5rQJL65Jz83MQ9qfrFnS79Tz
KlqqB55AHEv1N1iWKDgKTKIMCtA+/O1pmnlkiucV6KfNmsE4RzyLQ3BZE1D4COlMxWRdqvBj2lsE
7WiXkBGSRsuFjsxSpGd2npitSAkBxarkhbF9ARAUwyTnowbUeIibL964UdlkQ9+jHxkOv5ZPXcFc
eaPHdmy29PszzpSS3USeWy1h8sPwWUFEGJyqEivPk9bakUr9yklyHS5sl1F/f/bOygeIlfczYQUo
JjHJffIcOSyecGZvj+OU+nyHIX8wggbwMIIE2KADAgECAhNDAAAAA2+gGgq8aZO3AAAAAAADMA0G
CSqGSIb3DQEBBQUAMD4xCzAJBgNVBAYTAkRFMRQwEgYDVQQKDAtDTEFBUyBHcm91cDEZMBcGA1UE
AwwQQ0xBQVMgUm9vdCBDQSAwMTAeFw0xNTA3MDIxMTIzNDdaFw0yNTA3MDIxMTMzNDdaMD0xCzAJ
BgNVBAYTAkRFMRQwEgYDVQQKDAtDTEFBUyBHcm91cDEYMBYGA1UEAwwPQ0xBQVMgU3ViIENBIDAy
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAuYWxNMo7fvGR2bEpracOoen3OOi/1O2w
P7fMBNbAGJX9RnsavDNrtlNTEtaMRD97Ypv+np9ZJFAqA+MnYPWFsgkdJny358kJqr/UZI+EEmS9
I6wHs9FSEOh8rB7rtoc7W6fca4AXmh4LjYbr1vZXTTN8QBjOklwoK9dYpifw2RXYRz1KFLrujvJ6
2KTVkKu+2OoxyN6rw/3Se59GEKqMSrpM0mbBs7owGrEmhhtxYu5Voh3p6QY+6teKrYvgeR1szbjd
n6v9sxhpLLnurgTAP583p29ruY9xls0mJOdgGtw8voOzZyxGKluErkJvbXZT8Iw8TRmOB6DOMGlg
+SuPp3kKfuApTTC7englWlpDtQBz+STNGeQcsUptsp5Ej8M2fu8tgfVrmKXHAKYDclk2gzAE3oFE
PDy9fS6E3NDaQXXyTOgnaCIM3m6U/dl1E7ApRucj0pTlOqlc3wzeK9LTbAq4H4dIYOY0mb/LTRJV
I+kksdQxcYM8vikBSTVQQODiydBfV/ASCbw5hz/YhpYKxko4T03O3yRqGepKo4/aNfxn/A6t0kis
mW7E82imrjgGe8+n/IbfnCcJ+cr4K0wJlqDTnI9+Oh0UyQRDwKmxsc5yQQSwC94eYovYkhNUUWFp
QB7x/msmYCu2ymzkyzBYNi21l4FRX+pw4NZobRyIotMCAwEAAaOCAeYwggHiMA4GA1UdDwEB/wQE
AwIBBjAdBgNVHQ4EFgQUyT+HZqfPCniFjAmTLNo/OlnfKIQwgeQGA1UdIASB3DCB2TCB1gYNKwYB
BAGC0UCDfWQKATCBxDAhBggrBgEFBQcCARYVaHR0cDovL3BraS5jbGFhcy5jb20AMIGeBggrBgEF
BQcCAjCBkR6BjgBDAGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAG8AbABpAGMAeQAgAGEAbgBkACAA
QwBlAHIAdABpAGYAaQBjAGEAdABpAG8AbgAgAFAAcgBhAGMAdABpAGMAZQAgAFMAdABhAHQAZQBt
AGUAbgB0ACAAbwBmACAAQwBMAEEAQQBTACAARwByAG8AdQBwAC4wEgYDVR0TAQH/BAgwBgEB/wIB
ADAfBgNVHSMEGDAWgBQRn1tLL1IbHAdFyuHemosYxnjMDzBEBgNVHR8EPTA7MDmgN6A1hjNodHRw
Oi8vcGtpLmNsYWFzLmNvbS9jZHAvQ0xBQVMlMjBSb290JTIwQ0ElMjAwMS5jcmwwTwYIKwYBBQUH
AQEEQzBBMD8GCCsGAQUFBzAChjNodHRwOi8vcGtpLmNsYWFzLmNvbS9haWEvQ0xBQVMlMjBSb290
JTIwQ0ElMjAwMS5jcnQwDQYJKoZIhvcNAQEFBQADggIBAAuP/mmNItTaIx3rAFjAHN8r8djT3zhI
qDeTXYCa9a7gICZ62DivNBcSW0aU44Pr7KKHkFg22ZvPwC1QmJS9SYIcLd2wK2dIWHfezhVGQJQY
/8b2LTZXfweN9l9uIbMcrv9iyICbs8xHNjsGoDZosyGqE7/AljKUtd4fwrfUs/BZtf3XkcXnJziv
QMyXxr98DlAPif3hSeYJJu7ofzBWXLei6xX4VOTtAgbXobLHr2dm21IRCg2oXkbcvzwdmLa6x0xU
tWl84DshERZH5HNbbDLPw6VnVGc9sg2zclO1v3qf0T8W8RNd5C4PLkr5jqfWBbAQcwTarP2G6bKu
2hRI+uDYBPhfGlmY7AQvTTDwUNNKAjf1tGJvW/fqMriouRbtg0sdMe67OnCmJVBJ46noYwQQpJkb
a1jwTYoCKQKo6bKi48ziHRU5zOc4wXAJSyQogHiMnEwNEoS60ME2JW2GRPGGqMKO0SIco9Iezq/R
jkbefjqdHUCMaO71BuqW5SQY78/q/lH9eYcyafOc1WkCTf08jvSFpjRKAN/UE/X+2W5Nw2Eu5yKn
8dUuaoynOodeVxLDnMbWecytzNE7XLL8wFX0QVUwhmro1K14MPxGlnUKNbQinLS6ybEHN7dhYMST
ErrKTKZUeR5skJJwsyaTQbyNQpRej4E60vPMQ9y9piMhMYIDPjCCAzoCAQEwVDA9MQswCQYDVQQG
EwJERTEUMBIGA1UECgwLQ0xBQVMgR3JvdXAxGDAWBgNVBAMMD0NMQUFTIFN1YiBDQSAwMgITMwAC
iHpj86Kdk86bNgAAAAKIejAJBgUrDgMCGgUAoIIBvzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMTAzMjYwOTQyMTZaMCMGCSqGSIb3DQEJBDEWBBTIPqyptqDe8MwH
mpXDovTyx7cHkzBjBgkrBgEEAYI3EAQxVjBUMD0xCzAJBgNVBAYTAkRFMRQwEgYDVQQKDAtDTEFB
UyBHcm91cDEYMBYGA1UEAwwPQ0xBQVMgU3ViIENBIDAyAhMzAAKIea1OsmcGg8nAAAAAAoh5MGUG
CyqGSIb3DQEJEAILMVagVDA9MQswCQYDVQQGEwJERTEUMBIGA1UECgwLQ0xBQVMgR3JvdXAxGDAW
BgNVBAMMD0NMQUFTIFN1YiBDQSAwMgITMwACiHmtTrJnBoPJwAAAAAKIeTCBkwYJKoZIhvcNAQkP
MYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDGq3fE/7XQTJ94XJ0LYmOG
Vvrj3GIQRxtWF0OjeDVP2veOVO5pT+lrfiWVZQIHZPbFAfy8+G+PaMepi3UctJvjVIcOrOLewXtx
ASZwl4auekKN/qjpAMt7dPvhJ7z49H+6mwda56RYd7H83YOBMoq124FFIPfmPO1uPfeaWRp0FFq5
GRWZ/mUleAVsj7xmg2zm1YDKJuCmtp1wjxxw6q99fqN0F+dRdilmgbDmeoET8cCVuq2t+ojogV4f
IhpXemJaJCb2KiPczIgTVfYZ1Y2Swhz6c7rwSSxhQTD4CQj3vBTO3CWFYwM3Tbn5J7RFo8sDG1Yq
jYbfGX9IoHtxtVBFAAAAAAAA

------=_NextPart_000_008D_01D7222C.B0A55690--
