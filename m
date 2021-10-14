Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9B42D9B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhJNNHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 09:07:46 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:33362 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhJNNHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 09:07:46 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Oct 2021 09:07:45 EDT
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 85ADC1805240B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 14:57:44 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ttl95MLiptQF for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 14:57:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 577E81805240C
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 14:57:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 577E81805240C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1634216264; bh=l4R5wBn2+QRidd8fxoHyGTavVNl4t3Mux6QzOmATQLM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GWRGz9lYMRFmu+LU/Intc6JAEaojmNPPwb5TulIKBgM3IajH6xPGX/kdJATYaFuTa
         vskFU4Farp8Uabz2dNmJvrx02b42LfHvBzqbqer8JvoNvzcYtwEh6sE5xkNESCyPb9
         CX8/1qSD/HgNwRF37EyLjbVkbRgEAj5fhl6Ji1pMow9NrmRdoDUQS9iEXZmGMiAm2C
         Agy4brI10WBjyeiI4HP/8MeHfLK5RKjNnvx/0WwE31sIZIrnqLZyqQ+ayTm0XeFJp3
         llVrz7OqbJn5npm3fqQYpE3Cgfjhw2l6/cFXL4uUEvtnjt2n73WvQ5AwtVZTzv1br9
         Ug2/4iHT8M+Nw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DNjNFxdZiSsR for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 14:57:44 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 314BA1805240B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 14:57:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 4B338823B4AD
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 14:57:59 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uUfHkAyLKyMa for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 14:57:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 2450D823B31E
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 14:57:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 2450D823B31E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1634216279; bh=l4R5wBn2+QRidd8fxoHyGTavVNl4t3Mux6QzOmATQLM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AvG9IFYkwOQw+PuR1Bwtzok1HwEO8sM0mDXsEMnKXDRBNEJgp8S1940IEoyjwC9Tk
         +T0+isQaixKQHApv75Db/FKPRJoZaAPwxoH6XFwBZR7sTBnmEpbbqFNmNnOfHc4hu3
         CCVcZpcTafpuIV5fSjOr7hgzG+rnlOvj6u4ak77dqidb35tk07Rg2q10YKgq09DstG
         dZdOfHh0q9F82dKkLXhX4vrmT4CUy3hoYxp6OW09ve64g2vs9Ldqw9/KYXuw6iiNc1
         L/u4puDe2O7kzFmVkDxSiTP9E4OxRABPRnScQjN2Cztqb621ilokw/OQOKy3B4RRxu
         wbpzUOxA2qdaA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ThcLH2Q4sTdD for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 14:57:59 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id EF512823B31B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 14:57:58 +0200 (CEST)
Date:   Thu, 14 Oct 2021 14:57:58 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: some principal understanding problems (balance and free space)
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_58357319_161395518.1634216278934"
X-Originating-IP: [146.107.127.138]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4007)
Thread-Index: KeDEvkLNDUSRqyo3v38eGXmkc8uegA==
Thread-Topic: some principal understanding problems (balance and free space)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_58357319_161395518.1634216278934
Date: Thu, 14 Oct 2021 14:57:58 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: some principal understanding problems (balance and free space)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [146.107.127.138]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4007)
Thread-Index: KeDEvkLNDUSRqyo3v38eGXmkc8uegA==
Thread-Topic: some principal understanding problems (balance and free space)

Hi,

OMG. Why is BTRFS in some cases so complicated? I just expect that a FS doe=
s its job, nothing else.
I read the wiki and Merlin's Blog, but the more i read the more i get confu=
sed.
Please help me, i'd like to use BTRFS, especially because of the snapshot f=
eature which i'm missing in the most others FS.
And i like to understand what i do.

Let's take this:

root@pc65472:~# btrfs fi df /
Data, single: total=3D361.00GiB, used=3D343.29GiB
System, single: total=3D32.00MiB, used=3D80.00KiB
Metadata, single: total=3D9.00GiB, used=3D7.10GiB
root@pc65472:~#
root@pc65472:~# btrfs fi show /
Label: none  uuid: 3a623645-a5e1-438e-b0f3-f02520f1a2eb
        Total devices 1 FS bytes used 350.39GiB
        devid    1 size 420.00GiB used 372.03GiB path /dev/mapper/vg1-lv_ro=
ot

What does "Data, single: total=3D361.00GiB, used=3D343.29GiB" mean ?
Having 343GB pure data occupying 361GB ?
From what i've read before my understanding was that 361GB are reversed for=
 data allocation ("data will be stored there").
And 343GB are really used for data, so 18Gb pure data can still be saved. I=
s that correct ?
What if i save now 18GB, so the total and used value are equal ? Does BTRFS=
 claim new space so that the total value is growing ?

Or are the 18GB lost and unusable ?

I read that if Metadata is occupying more than 75% of the total value you n=
eed to react.
I did some "btrfs balance start / -dusage=3D5", increasing the value of dus=
age in steps of 5.
I expected that i get more total space or less used space for Metadata. But=
 it didn't.
What happened is that the total value for Data shrinked a bit, from 363GB t=
o 361GB.

I did then some "btrfs balance start / -musage=3D5" increasing in steps of =
5. I expected that "used" for Metadata decreased, but it didn't.
Finally the value "total" for Metadata decreased (from 9GB to 8GB), which i=
sn't completely contrary to what i've expected:

root@pc65472:~# btrfs fi df /
Data, single: total=3D361.00GiB, used=3D343.46GiB
System, single: total=3D32.00MiB, used=3D80.00KiB
Metadata, single: total=3D8.00GiB, used=3D7.10GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

That would mean that after my "btrfs balance ... musage=3D " there is now l=
ess space for Metadata than before. Why to balance then ?

OS is Ubuntu 16.04, kernel is 4.4.0-66-generic.

What is with the most recent kernels ? Is there an automatic "btrfs balance=
" or do i still have to check my BTRFS regulary ?

Thanks for helping me to sort that out.

Bernd


--=20

Bernd Lentes=20
System Administrator=20
Institute for Metabolism and Cell Death (MCD)=20
Building 25 - office 122=20
HelmholtzZentrum M=C3=BCnchen=20
bernd.lentes@helmholtz-muenchen.de=20
phone: +49 89 3187 1241=20
phone: +49 89 3187 3827=20
fax: +49 89 3187 2294=20
http://www.helmholtz-muenchen.de/mcd=20


Public key:=20

30 82 01 0a 02 82 01 01 00 b3 72 3e ce 2c 0a 6f 58 49 2c 92 23 c7 b9 c1 ff =
6c 3a 53 be f7 9e e9 24 b7 49 fa 3c e8 de 28 85 2c d3 ed f7 70 03 3f 4d 82 =
fc cc 96 4f 18 27 1f df 25 b3 13 00 db 4b 1d ec 7f 1b cf f9 cd e8 5b 1f 11 =
b3 a7 48 f8 c8 37 ed 41 ff 18 9f d7 83 51 a9 bd 86 c2 32 b3 d6 2d 77 ff 32 =
83 92 67 9e ae ae 9c 99 ce 42 27 6f bf d8 c2 a1 54 fd 2b 6b 12 65 0e 8a 79 =
56 be 53 89 70 51 02 6a eb 76 b8 92 25 2d 88 aa 57 08 42 ef 57 fb fe 00 71 =
8e 90 ef b2 e3 22 f3 34 4f 7b f1 c4 b1 7c 2f 1d 6f bd c8 a6 a1 1f 25 f3 e4 =
4b 6a 23 d3 d2 fa 27 ae 97 80 a3 f0 5a c4 50 4a 45 e3 45 4d 82 9f 8b 87 90 =
d0 f9 92 2d a7 d2 67 53 e6 ae 1e 72 3e e9 e0 c9 d3 1c 23 e0 75 78 4a 45 60 =
94 f8 e3 03 0b 09 85 08 d0 6c f3 ff ce fa 50 25 d9 da 81 7b 2a dc 9e 28 8b =
83 04 b4 0a 9f 37 b8 ac 58 f1 38 43 0e 72 af 02 03 01 00 01
------=_Part_58357319_161395518.1634216278934
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
yDCCBLCgAwIBAgIMIgdroMAv99uEUtszMA0GCSqGSIb3DQEBCwUAMIGNMQswCQYDVQQGEwJERTFF
MEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdz
bmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2Jh
bCBJc3N1aW5nIENBMB4XDTE5MTIwNDE3MzQwOVoXDTIyMTIwMzE3MzQwOVowVzELMAkGA1UEBhMC
REUxIzAhBgNVBAoMGkhlbG1ob2x0eiBaZW50cnVtIE11ZW5jaGVuMQwwCgYDVQQLDANJREcxFTAT
BgNVBAMMDEJlcm5kIExlbnRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALNyPs4s
Cm9YSSySI8e5wf9sOlO+957pJLdJ+jzo3iiFLNPt93ADP02C/MyWTxgnH98lsxMA20sd7H8bz/nN
6FsfEbOnSPjIN+1B/xif14NRqb2GwjKz1i13/zKDkmeerq6cmc5CJ2+/2MKhVP0raxJlDop5Vr5T
iXBRAmrrdriSJS2IqlcIQu9X+/4AcY6Q77LjIvM0T3vxxLF8Lx1vvcimoR8l8+RLaiPT0vonrpeA
o/BaxFBKReNFTYKfi4eQ0PmSLafSZ1Pmrh5yPungydMcI+B1eEpFYJT44wMLCYUI0Gzz/876UCXZ
2oF7KtyeKIuDBLQKnze4rFjxOEMOcq8CAwEAAaOCAlswggJXMD4GA1UdIAQ3MDUwDwYNKwYBBAGB
rSGCLAEBBDAQBg4rBgEEAYGtIYIsAQEEBDAQBg4rBgEEAYGtIYIsAgEEBDAJBgNVHRMEAjAAMA4G
A1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFIbj
udERXYhU7DMaI17GPlWqLTQVMB8GA1UdIwQYMBaAFGs6mIv58lOJ2uCtsjIeCR/oqjt0MC0GA1Ud
EQQmMCSBImJlcm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNoZW4uZGUwgY0GA1UdHwSBhTCBgjA/
oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2Fj
cmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHVi
L2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2Nz
cC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUH
MAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2Nh
Y2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAG9FaTFBh6Yp8cNfWoaMF6GhZRFiARkPSNlvI8BJ
y+tS5W9urRKluF0mtgseNk1Eff3AD1bqicMIzThTuScwq1WhY5ZCGlD/qYLf+FY3VnPTjk6ZVruE
KuoA4bKJaVrXGkfBmw+oSMh6rfw6pwnchLXP7l40hDQ5tQ2/8BcpZYcykC4ziIga3hqe7vN4vhF6
gYKN6lET83QXYoh0IGCfFw3fIdTJk1IStMqe0Cd7eXpfwKQfjtzK8M5Qccj46923WGIwo0zSRiJR
R1J97qDZZxBsGJfj3tC5X/FkWhn3fDiPZYeTlvmFrzSyLSw/FBR/D2o/bUz+eaeVmenc32vxYmEA
ADGCApswggKXAgEBMIGeMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2Vy
ZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdE
Rk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwiB2ugwC/324RS
2zMwDQYJYIZIAWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjExMDE0MTI1NzU4WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCDwHVk0I10cQ5rvoixgheatJdkI3Dm1nuaD0ahkvchz
dDA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQBuJMr5htWWoibJGdzPrbc0s1y6rVAG1AS5XyzrFG2R/D695fljGBjA
xjNZS5W6JYAld9sLsQSeNcS1LZbCyR9Qy255M7yefguDZetWBgfLQ4oZLhsFwdfCGlJTuPKsGNvh
ud8vHvUdMCrMOUuHuKrUgX0ZHdzvxNrWJcftKMgGQONRpDZXFbc2FxxqRD+wfhrsDGC1HdpBKDnt
d3aqG7s8gU9T56nBgPKhoWLnhR5CXm5IN33LVHFaidsEJvefH2SOXuw0P1oLIMhKPbKjnVGTu7ex
y5YahOMZ8RDK9apLzw7mWpV/UNZZ0JE+5vCbfsqpd2ubUaQog9WGYCf1sMWhAAAAAAAA
------=_Part_58357319_161395518.1634216278934--
