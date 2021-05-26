Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75439187E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhEZNGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 09:06:52 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:34806 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhEZNGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 09:06:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 0BB3318054F28
        for <linux-btrfs@vger.kernel.org>; Wed, 26 May 2021 15:05:01 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AhQvUjnJp7eD for <linux-btrfs@vger.kernel.org>;
        Wed, 26 May 2021 15:05:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id CF49418054F16
        for <linux-btrfs@vger.kernel.org>; Wed, 26 May 2021 15:05:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de CF49418054F16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622034300; bh=ORei5wShXUPsQlVyyZQuLATBE3nX+K/nNG6q+D2AIJE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=feLXG3XiDFUXkoC/dmKvozS5mDlT2eqSdUVt3VWFP8sDCS+cmmCx5rkqn57FgllZE
         KosEhNjaidQ0z1dHM6xqx99P8McAmiM9GpJJWURwgV1irT3v6qNU2fzZy5IxD1QEiM
         YiJVA6oc/tpz0xIyAA3RaYSdXiWdwbYHw0esFtGtDX1oLdIlBQ5IGAaURrSA0HfaPO
         qh3VWzTUqEDvq9o+OQnE1MuwNYey/BJrYb/kyye4p5pbbhD6j/QESh95R3zWuk8ixf
         S/13DdaBsByaPRd9LOxwuBUbs0MSnmaMWdUvp6+0608hRSMjZ7kdeLK51R3+a5LpVU
         oKFLwJ+bmF6MA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SPWPszOYKyGN for <linux-btrfs@vger.kernel.org>;
        Wed, 26 May 2021 15:05:00 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id A480918054F28
        for <linux-btrfs@vger.kernel.org>; Wed, 26 May 2021 15:05:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id CFF8C8252E02
        for <linux-btrfs@vger.kernel.org>; Wed, 26 May 2021 15:05:14 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gVz8oR4rZM62 for <linux-btrfs@vger.kernel.org>;
        Wed, 26 May 2021 15:05:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id A32D78252E05
        for <linux-btrfs@vger.kernel.org>; Wed, 26 May 2021 15:05:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de A32D78252E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622034314; bh=ORei5wShXUPsQlVyyZQuLATBE3nX+K/nNG6q+D2AIJE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q8HNrxHKoNCzvSNknYb1KsRkjAEaK1wxJrxm1NtPEsrbcYtLHAIlDa3OedhBCO8sd
         0BLu/jKolI/bdcd1oMhPaHyqe9PeL7TbvbGoIw1z1+4ogpcQ+5cVIqeMgMqpCjan4f
         Q8YMIzf/xbrWYn7Cn9hFZbhiqaYKJIIHaE2Hw7keZm1gl0fV700D8fZhFmz8ZigD1Q
         j2npZWX2z2Bi28lBdqzRX7g4LRn64xVkmXwWQoStDWQBEa8r1sbL30yT+TP4/GQNPL
         tzX4Qh1lxcJeZtOQ+fErqCw46vAsNGCnSxkmPUYXt1t8oSpXvjCdlvd43kA4Y9OkhZ
         HBtE/prqUsLRA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ekZAUFDj9XFv for <linux-btrfs@vger.kernel.org>;
        Wed, 26 May 2021 15:05:14 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 7ECFF8252E02
        for <linux-btrfs@vger.kernel.org>; Wed, 26 May 2021 15:05:14 +0200 (CEST)
Date:   Wed, 26 May 2021 15:05:11 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_79893367_1075743580.1622034311977"
X-Originating-IP: [146.107.126.162]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Index: mRJ2EjcDesO59enHl25//2+CWoa7Rg==
Thread-Topic: how to rollback / to a snapshot ?
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_79893367_1075743580.1622034311977
Date: Wed, 26 May 2021 15:05:11 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [146.107.126.162]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Index: mRJ2EjcDesO59enHl25//2+CWoa7Rg==
Thread-Topic: how to rollback / to a snapshot ?

Hi,

sorry for asking such a simple question, but ...
i didn't find that in the BTRFS wiki and googleing i found tons of ways, bu=
t all different, so now i'm more confused than before.
And it's the first time i have to do that.
I have an Ubuntu box where an upgrade didn't complete. System was 16.04 bef=
ore, now it "thinks" it's an 18.04, but it still uses the kernel from 16.04=
 !=20
System is up and running. I don't like to use a live linux for the rollback=
 because i'm currently in quarantine and i can't get physically to the box,=
 just with ssh.

This is my setup:

root@pc65472:/boot# mount |grep btrfs
/dev/mapper/vg1-lv_root on / type btrfs (rw,relatime,ssd,space_cache,subvol=
id=3D257,subvol=3D/@)
/dev/mapper/vg1-lv_root on /home type btrfs (rw,relatime,ssd,space_cache,su=
bvolid=3D258,subvol=3D/@home)
/dev/sdb1 on /data type btrfs (rw,relatime,space_cache,subvolid=3D258,subvo=
l=3D/@data)
/dev/sdc1 on /local type btrfs (rw,relatime,space_cache,subvolid=3D5,subvol=
=3D/)
/dev/mapper/vg1-lv_root on /var/lib/docker/btrfs type btrfs (rw,relatime,ss=
d,space_cache,subvolid=3D257,subvol=3D/@/var/lib/docker/btrfs)
/dev/mapper/vg1-lv_root on /mnt/snap type btrfs (rw,relatime,ssd,space_cach=
e,subvolid=3D767,subvol=3D/@apt-snapshot-release-upgrade-bionic-2021-05-21_=
10:38:10)
/dev/mapper/vg1-lv_root on /mnt/sub/root-volume type btrfs (rw,relatime,ssd=
,space_cache,subvolid=3D5,subvol=3D/)

/home, /data and /local are not involved, and /mnt/snap is the snapshot i w=
ant to rollback.

root@pc65472:/boot# btrfs sub list /
ID 257 gen 44758165 top level 5 path @
ID 258 gen 44758165 top level 5 path @home
 ...
ID 767 gen 44757961 top level 5 path @apt-snapshot-release-upgrade-bionic-2=
021-05-21_10:38:10
ID 768 gen 44757961 top level 5 path @apt-snapshot-release-upgrade-bionic-2=
021-05-21_10:38:13
ID 769 gen 44757961 top level 5 path @apt-snapshot-release-upgrade-bionic-2=
021-05-21_10:38:46

Is it sufficient to change the the default subvolume with btrfs sub set-def=
ault to the snapshot and reboot ?
Do i need additionally to modify grub and fstab ?

Or just modify grub and fstab, let it point to the snapshot and reboot ?

What is with mounting the snapshot and rsync it to the current / ?
I think that's not possible in a running system which has / mounted.

In some documents i read to create a snapshot from the snapshot i want roll=
back to, if something goes wrong.

/boot is on a ext3-partition, it is not involved.


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

------=_Part_79893367_1075743580.1622034311977
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
CQUxDxcNMjEwNTI2MTMwNTE0WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCAEworSzjibESAW1/G5wmHJkYMiE0JwfC/0hI6Gh1r6
aDA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQAK7XnI8e6jEJxgPJuo2EX4xHRSamhZk3BXRjVY+49kIGt8+L/mK0/K
ql1KlvQFn42eW9xMhL+KolF8hnQ75xbjpkePrqImV+pnbVGBmvzbzjcG16zpB/3xSMh/VcSCRUi3
VMdEYFhvXrJe7sXfT7Gz4oE2xrlMArzGvl8jv+2zEpXBdeV9kQ9HSnJvjD0i7hMfgN4FHKDiHlGP
2NWOx/H8YHB99qRWxdvwXTsGKDNa2U/aEpPDM2a+ovpBNMImzX+zkrlE9OuXir+pClGgpIA8pwFz
YXi7B8WsUNbaxOsngREUrtZq5LB7EWdxssNeTKVRy+kVPGrfOVkj5e/qeq2sAAAAAAAA
------=_Part_79893367_1075743580.1622034311977--
