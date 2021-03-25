Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6B434961C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhCYPxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 11:53:07 -0400
Received: from mx-relay81-hz1.antispameurope.com ([94.100.132.251]:45033 "EHLO
        mx-relay81-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhCYPxD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 11:53:03 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 11:53:02 EDT
Received: from unknown ([91.239.177.110]) by mx-relay81-hz1.antispameurope.com;
 Thu, 25 Mar 2021 16:47:24 +0100
Received: from dehwlwmsx02.claas.local (10.1.34.82) by dehwlwmsx02.claas.local
 (10.1.34.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 25 Mar
 2021 16:47:20 +0100
Received: from dehwlwmsx02.claas.local ([fe80::61e8:27a9:8d68:938]) by
 dehwlwmsx02.claas.local ([fe80::61e8:27a9:8d68:938%4]) with mapi id
 15.01.2176.009; Thu, 25 Mar 2021 16:47:20 +0100
From:   "Wulfhorst, Heiner" <Heiner.Wulfhorst@claas.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Why doesn't btrfs find additional space after (VMware) disk
 extension?
Thread-Topic: Why doesn't btrfs find additional space after (VMware) disk
 extension?
Thread-Index: AdchjfubWkhUqWyOSe+KO47leh9ppA==
Date:   Thu, 25 Mar 2021 15:47:20 +0000
Message-ID: <8a4b55eb42bd42d181abe9d7c208607c@claas.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.0.62]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_003F_01D72196.84B64DF0"
MIME-Version: 1.0
X-cloud-security-sender: heiner.wulfhorst@claas.com
X-cloud-security-recipient: linux-btrfs@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay81-hz1.antispameurope.com with 838C4824BF5
X-cloud-security-connect: unknown[91.239.177.110], TLS=1, IP=91.239.177.110
X-cloud-security-Digest: 1dde099ed3d29bc173aa3167b63432f6
X-cloud-security: scantime:1.659
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_NextPart_000_003F_01D72196.84B64DF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi list,

i am new to btrfs and really need help extending my fs on my openSUSE Leap
15.2 VMware VM.
It has one big btrfs on multiple disks:

# btrfs filesystem show /
Label: none  uuid: 26c2b9c2-7ef7-476c-825d-9931b6344c37
        Total devices 3 FS bytes used 125.09GiB
        devid    1 size 47.51GiB used 47.51GiB path /dev/sdb2
        devid    2 size 32.00GiB used 32.00GiB path /dev/sdc
        devid    3 size 100.00GiB used 47.52GiB path /dev/sdd

# btrfs subvolume list /
ID 256 gen 32 top level 5 path @
ID 259 gen 6438 top level 256 path @/var
ID 260 gen 6245 top level 256 path @/usr/local
ID 261 gen 6433 top level 256 path @/tmp
ID 262 gen 6313 top level 256 path @/srv
ID 263 gen 6418 top level 256 path @/root
ID 264 gen 34 top level 256 path @/opt
ID 265 gen 34 top level 256 path @/home
ID 266 gen 271 top level 256 path @/boot/grub2/x86_64-efi
ID 267 gen 28 top level 256 path @/boot/grub2/i386-pc
ID 268 gen 6422 top level 256 path @/.snapshots
ID 269 gen 6438 top level 268 path @/.snapshots/1/snapshot
ID 285 gen 6314 top level 259 path @/var/cache


I ran out of space and got disk /dev/sdd resized from 100 to 500 gb.
I ran # echo 1 > /sys/block/sdd/device/rescan
	and also rebooted multiple times after resizing.

OS got new size:
# lsblk /dev/sdd
NAME MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sdd    8:48   0  500G  0 disk

But btrfs won't extend its filesystem:
# btrfs filesystem resize max /
Resize '/' of 'max'

# btrfs filesystem resize +1g /
Resize '/' of '+1g'
ERROR: unable to resize '/': no enough free space

# btrfs filesystem usage /
Overall:
    Device size:                 179.51GiB
    Device allocated:            127.02GiB
    Device unallocated:           52.49GiB
    Device missing:                  0.00B
    Used:                        125.42GiB
    Free (estimated):             52.73GiB      (min: 26.49GiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:               24.03MiB      (used: 0.00B)

Data,RAID0: Size:125.01GiB, Used:124.76GiB
   /dev/sdb2      46.51GiB
   /dev/sdc       31.99GiB
   /dev/sdd       46.51GiB

Metadata,RAID1: Size:1.00GiB, Used:333.58MiB
   /dev/sdb2       1.00GiB
   /dev/sdd        1.00GiB

System,RAID1: Size:8.00MiB, Used:16.00KiB
   /dev/sdc        8.00MiB
   /dev/sdd        8.00MiB

Unallocated:
   /dev/sdb2       1.00MiB
   /dev/sdc        1.00MiB
   /dev/sdd       52.48GiB

- How can I use the 52 gb shown above as unallocated/free?
- What must I do to be able to use the 400 gb i added to /dev/sdd?


Here is a list of all btrfs commands I have tried/used by now:
btrfs balance start -dusage=0 -musage=0 /
btrfs balance start /
btrfs check
btrfs check --force /dev/sdd
btrfs check --repair
btrfs check --repair --force /dev/sdd
btrfs check --repair /dev/sdd
btrfs check /
btrfs check /dev/sdd
btrfs check /dev/sdd --force
btrfs device add /dev/sdd /
btrfs device scan
btrfs device scan
btrfs device scan -d
btrfs device stats
btrfs device stats /
btrfs device stats /dev/sdd
btrfs device usage
btrfs device usage /
btrfs fi df /
btrfs fi show /dev/sdd
btrfs filesystem df
btrfs filesystem df /
btrfs filesystem df /var
btrfs filesystem resize +10g /
btrfs filesystem resize +1g /
btrfs filesystem resize +5g /
btrfs filesystem resize /
btrfs filesystem resize / 3:max
btrfs filesystem resize / max
btrfs filesystem resize max /
btrfs filesystem resize max /var
btrfs filesystem show /
btrfs filesystem show /dev/sdd
btrfs filesystem usage
btrfs filesystem usage /
btrfs fs label
btrfs fs label /
btrfs fs label /dev/sdd
btrfs fs resize /
btrfs fs resize / max
btrfs fs resize / max|less
btrfs fs resize max /
btrfs subvolume delete /.snapshots/1/snapshot
btrfs subvolume delete /.snapshots/10/snapshot
btrfs subvolume delete /.snapshots/2/snapshot
btrfs subvolume delete /.snapshots/21/snapshot
btrfs subvolume delete /.snapshots/22/snapshot
btrfs subvolume delete /.snapshots/9/snapshot
btrfs subvolume delete @/.snapshots/2/snapshot
btrfs subvolume list
btrfs subvolume list /
btrfs subvolume show
btrfs subvolume show /
btrfs subvolume sync
btrfsck /
btrfsck /dev/sdd



Thanks for any help!
Heiner

------=_NextPart_000_003F_01D72196.84B64DF0
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
MBwGCSqGSIb3DQEJBTEPFw0yMTAzMjUxNTQ3MThaMCMGCSqGSIb3DQEJBDEWBBTMgXsblqZ9GItv
iBtp/2YMtqg6ejBjBgkrBgEEAYI3EAQxVjBUMD0xCzAJBgNVBAYTAkRFMRQwEgYDVQQKDAtDTEFB
UyBHcm91cDEYMBYGA1UEAwwPQ0xBQVMgU3ViIENBIDAyAhMzAAKIea1OsmcGg8nAAAAAAoh5MGUG
CyqGSIb3DQEJEAILMVagVDA9MQswCQYDVQQGEwJERTEUMBIGA1UECgwLQ0xBQVMgR3JvdXAxGDAW
BgNVBAMMD0NMQUFTIFN1YiBDQSAwMgITMwACiHmtTrJnBoPJwAAAAAKIeTCBkwYJKoZIhvcNAQkP
MYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCBuMNzC24E3LJ+yzDuIDiJ
Jgmd6KZnijQfXo3Ws5cN2IN3v0MMv6YCL79ficbcu3TAEawtKG5vfRJzGIAu3+DNZ5ho3Td2TdHT
YygsDwVUg0AsSlnEcE/njns+zI8WgkuW3FRkXJkrDKpYjgvOhgGJ4gjNr8GQr9BonXpB8GMNPTYC
V0+9pjihXCA2z4O1q1KaePuCpw6VuRToaEjhxN5WQkauH67+aaE3Yfv6VMYuJKixEhHg6lXsZgXq
Sn8bGVKCkoqVasLt2OYYCenCKIS8YTZq/8mUqbFRrvLvbBwPwlaG5vxsN38AISpxCuD9V41/H+r0
oW2+5l42GKd2kRc+AAAAAAAA

------=_NextPart_000_003F_01D72196.84B64DF0--
