Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFEB3906AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhEYQbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 12:31:25 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:54720 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhEYQbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 12:31:24 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 12:31:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 0A764180569F9
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 18:20:10 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XIh3JupiFTcP for <linux-btrfs@vger.kernel.org>;
        Tue, 25 May 2021 18:20:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id D1651180569E0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 18:20:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de D1651180569E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1621959609; bh=7bbDWbFJcvmWktJDq/oSTmeIZ8UqI9kAsFa9ZC5REks=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Awhw3GNpgSpOfmDrHYkPmz/kLVSqqOBZc7Ar8jTm48sLbXpV03PT3ejtUNBBkupVi
         SAByrETyyhocFWvi0Yt5kTfGH12O3aLyH5zHvH2LCPLj/EB6xGJ9z/wJkw8Ddixct/
         YLuBV/PRhJU7r5hRTUthDL+2yGQ9ggLQnjjZfls+ew+J81smmUkaTe0GvnbElWoIT/
         W5Pf7seZOHJVDFmFPwTn62WnVLNlR1VP7PcTxcSRo3ghyHtd12n3FqcG85gwMhNCvC
         Rq5ijqe6VxC36dngaMWtwfS/ORVMCBjNHf2axSKNJ7L7aH3f16UmJOXXFrudbGSyHy
         Bgy2ErPCAlvEA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id saotL9eSW7jy for <linux-btrfs@vger.kernel.org>;
        Tue, 25 May 2021 18:20:09 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id A6DB8189775D3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 18:20:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 2E97482556A3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 18:20:23 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VpFSLSXmOy-B for <linux-btrfs@vger.kernel.org>;
        Tue, 25 May 2021 18:20:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 08ADA82556A9
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 18:20:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 08ADA82556A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1621959623; bh=7bbDWbFJcvmWktJDq/oSTmeIZ8UqI9kAsFa9ZC5REks=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mo+4FSyvTZRwgKeJ4xAOgvPGZwMtMbdoUbSFWAsKbQH49naDunis1KpbuAehJ+7+g
         B2No4/ulJzIjBlQb1PKlGxTW+EBLj4JZex/9OfWrcz6xlnCJewHtc61a/vCH4+NbHN
         8JOlIhVUbFO1x3UcJLI6i6ihSAnDofAUtMptcCdBT2xcNrenUfZBHcX7x7dnVV6Jn1
         +nLTBf0aUrzM/LqZLSaGGPS9b1dN4usVc+Whu7JgGOZFjViN2ucguCDFUfBJqyhThY
         T4D25Z+o8IfxPx3irVt7kBQDWCzao7bU1meSTuxW3moU04PeN6OSS3tShGg/QTyS2G
         aijTpC053sZZA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V1kngNMnTvzR for <linux-btrfs@vger.kernel.org>;
        Tue, 25 May 2021 18:20:22 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id DB42E82556A3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 May 2021 18:20:22 +0200 (CEST)
Date:   Tue, 25 May 2021 18:20:22 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: some principal questions to "disk full"
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_76542928_1123602251.1621959622805"
X-Originating-IP: [146.107.159.175]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Index: kyi8s52ozi1gcC6XEL5jnKt37GwTVA==
Thread-Topic: some principal questions to "disk full"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_76542928_1123602251.1621959622805
Date: Tue, 25 May 2021 18:20:22 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: some principal questions to "disk full"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [146.107.159.175]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Index: kyi8s52ozi1gcC6XEL5jnKt37GwTVA==
Thread-Topic: some principal questions to "disk full"

Hi guys,

it would be great if you can help me to sort out my understanding of BTRFS =
and its problems with "disk full".
I'm using BTRFS on several systems and this is now the first time that i ha=
ve a "full disk".
I'd really like to understand the problem and also how to solve it.
I gave my best to read and understand https://btrfs.wiki.kernel.org/index.p=
hp/FAQ.

My setup:
Ubuntu 18.04
kernel 4.4.0-66-generic
64 bit

My disk:
root@pc65472:/data# btrfs fi show /
Label: none  uuid: 3a623645-a5e1-438e-b0f3-f02520f1a2eb
        Total devices 2 FS bytes used 350.08GiB
        devid    1 size 420.00GiB used 420.00GiB path /dev/mapper/vg1-lv_ro=
ot
        devid    2 size 2.00GiB used 1.00GiB path /dev/loop0
(the loop device is from an effort of "btrfs balance" i will report later o=
n).

Is it correct that the 420GiB shown as "used" in the line of devid 1 means =
"allocated" ?
Allocated means ... "not usable, reserved" ?
What is "unallocated" ? A kind of "free, usable" ?

root@pc65472:/data# btrfs fi usage /
Overall:
    Device size:                 422.00GiB
    Device allocated:            421.00GiB
    Device unallocated:            1.00GiB
    Device missing:                  0.00B
    Used:                        350.08GiB
    Free (estimated):             70.29GiB      (min: 70.29GiB)
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:413.99GiB, Used:344.69GiB
   /dev/mapper/vg1-lv_root       413.99GiB

Metadata,single: Size:7.01GiB, Used:5.39GiB
   /dev/loop0      1.00GiB
   /dev/mapper/vg1-lv_root         6.01GiB

System,single: Size:4.00MiB, Used:80.00KiB
   /dev/mapper/vg1-lv_root         4.00MiB

Unallocated:
   /dev/loop0      1.00GiB
   /dev/mapper/vg1-lv_root           0.00B

"Device size" and "Device allocated" is slight bigger than shown with "btrf=
s fi show"
It seems the output of "btrfs usage /" adds the loop-device in its calculat=
ion, and "btrfs fi show" doesn't. Correct ?

I think the reason for "disk full" is the metadata:
Metadata,single: Size:7.01GiB, Used:5.39GiB
   /dev/loop0      1.00GiB
   /dev/mapper/vg1-lv_root         6.01GiB

Before i added the loop nearly all space for the metadata was occupied (5,4=
GiB from 6GiB). That's the problem ?
Only 600MB were free for metadata, that's roundabout the "Global Reserve", =
and that's, following the wiki, to little.

I deleted som old snapshots and now have enough space. I started a "btrfs b=
alance".
My first effort with an additional device (the loop device) didn't suceed.

What can i do to prevent a "disk full" situation ?
Running regulary "btrfs balance" in a cron job ?

Is there a way to transform allocated space to unallocated space ?

       =20
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

------=_Part_76542928_1123602251.1621959622805
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
CQUxDxcNMjEwNTI1MTYyMDIyWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCCH709LmQHidfGE4QEKFlleZMxFIq3vaS3pN4f+S9II
rDA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQB9kwloC0Ebx/M3H0HulhC0N9+XrMbRddxWxk0k/XN0ZMYAuHhYmdtg
OE6y9TFJluP2ZJlQSyS7vl9YRsh237ru9VTxurRnoJ8qyffQcAHsegBbw79t+/OBET/mqBsimeCJ
Vs4ev70MwYNnlrcqouiiC0D2aUQqVtU5AduPF7bvoVu+cYMJw9886MQZBtzUJTWdMCfzYAl9AaTQ
9GRNDg99ghCNExSY5FyyCHI1n8V/s34G8oowc7P3x7PyPVRTAtTq+sGhrb2rhVgDA053wtZ7vDDZ
kIeHTI7nHpcGg5/aKGvBBB+vbCuFzQKWLYRrE4iggXdR84Yi6iMFg99PMto1AAAAAAAA
------=_Part_76542928_1123602251.1621959622805--
