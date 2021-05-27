Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D3393666
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhE0TjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 15:39:12 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:51604 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbhE0TjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 15:39:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 46F6618046720;
        Thu, 27 May 2021 21:37:21 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DlYY1kaQkjG0; Thu, 27 May 2021 21:37:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 168CC18046721;
        Thu, 27 May 2021 21:37:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 168CC18046721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622144241; bh=k3h+UJmuM1EB23NYHqns8FBnaL3GgkZOSlORrGonHCI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nZawRTn/nDne/Z7MC4tiLDRvnr7w1YxHzsZdAL98592S8Ocj4ptzlt/tTvx/IDNGI
         CYiA43pFN/jFY0dhm89e93fyo6Z0ygd1+FBPWHTX7LHj3V5iX7rM00PIY1gNmOlqNR
         tPskF8Cxn/tHulo5VTe3U5kPkq4/sFbe6nObJ50zbEK1AhO/k6d1gu5UM/hxXjSzWj
         TjnnjMkS3lZPplfjeZrfoz2Le1CamMx5ghoE/tfOL2JH2GJyhM/+qo6kDocDe2nRS7
         pMYwzC1bHkhaPtSwTyPAu2FmGkGcNPF2VdJweOvVIxYPO3hB6Yu+Yf86vwADK9D1Yi
         88zNlwqAbo4Yw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fvL3WGf7nMuP; Thu, 27 May 2021 21:37:20 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id D3DC618046720;
        Thu, 27 May 2021 21:37:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 2DC40823B4A1;
        Thu, 27 May 2021 21:37:36 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id khuvHhCDzOmn; Thu, 27 May 2021 21:37:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 0355D8CCEB95;
        Thu, 27 May 2021 21:37:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 0355D8CCEB95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622144256; bh=k3h+UJmuM1EB23NYHqns8FBnaL3GgkZOSlORrGonHCI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=L7bPsPskIB7DNxi0+93Hu32hoUn6N7b0qiMWuTpuETDMIEe3usohGOQC5AxGISVlm
         6UnelbwqKgI2F7DthyZxUjKrXqm6Y2aI5UPwQMSobwhifcPwIH/w0g9jl4YsFny15f
         vGQvUL4+UdtGLrmtNTeJYFrqioc3lBjX81ZpqtWTD++xpsf8mb/m8SW9EJse04lgiI
         Cnb7nWSUDxSjBDaZGfFGCARYvHF1739++hf0ftpLG9EC2/hsMxxL/tRsJLJXFauPxB
         fYsXLpU59wo9djJjzpFXckJMP7eWzdpNpjPJBBtBk5PwBVA1N2J0AGDM05UeHLMeST
         mn6V3/gjIQRlA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g_Rvykn8iJf8; Thu, 27 May 2021 21:37:35 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id D3BAB8238759;
        Thu, 27 May 2021 21:37:35 +0200 (CEST)
Date:   Thu, 27 May 2021 21:37:35 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_82945727_570711520.1622144255774"
X-Originating-IP: [146.107.159.224]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: h34JB0CMMpEHtuWvcBTRD6E6sdbozQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_82945727_570711520.1622144255774
Date: Thu, 27 May 2021 21:37:35 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Remi Gauvin <remi@georgianit.com>, Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.159.224]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: h34JB0CMMpEHtuWvcBTRD6E6sdbozQ==


----- On May 26, 2021, at 5:17 PM, Remi Gauvin remi@georgianit.com wrote:

> On 2021-05-26 10:53 a.m., Lentes, Bernd wrote:
> 
>> 
>> OK. Thanks, i will try that and keep you informed.
>> 
>> Bernd
>> 
> 
> Please note that I made a mistake.
> 
> 
> When you snapshot into a new @, it will already have an empty (not
> subvolume) @/var/lib/docker/btrfs directory.
> 
> You have to get that directory out of the way before you move the
> subvolume, otherwise, you'll end up with a  @/var/lib/docker/btrfs/btrfs
> and mount will fail.
> 
> rmdir /mnt/sub/root-volume/@/var/lib/docker/btrfs
> 
> *before* you do:
> 
> mv /mnt/sub/root-volume/@bad/var/lib/docker/btrfs
> /mnt/sub/root-volume/@/var/lib/docker/btrfs

Hi,

i followed your guide and tried a reboot remotely.
PC stuck in BIOS, someone in the office pressed F2, and system booted completely.
But unfortunately in the bad system and without X:

root@pc65472:~# mount|grep btrfs
/dev/mapper/vg1-lv_root on / type btrfs (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@_bad)
/dev/mapper/vg1-lv_root on /home type btrfs (rw,relatime,ssd,space_cache,subvolid=258,subvol=/@home)
/dev/sdb1 on /data type btrfs (rw,relatime,space_cache,subvolid=258,subvol=/@data)
/dev/sdc1 on /local type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)
/dev/mapper/vg1-lv_root on /var/lib/docker/btrfs type btrfs (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@_bad/var/lib/docker/btrfs)

Any idea ?

I will try tomorrow again, then i'm in front of the PC.

Bernd

------=_Part_82945727_570711520.1622144255774
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
CQUxDxcNMjEwNTI3MTkzNzM1WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCDzUqxn6B1tCjdbZT7g3MHSCVTs1DMxBdibvhYT3FeQ
TTA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQADUYheNFKTCyL4m72p9pOMG8DxyieFAPyGkNLTcqsHDRdR/Fj4B/7/
O2qab3Lq2iWUphzs462+kHzAJ7WyfHMHDq0kHbooHfcYlGgBmJczKnfZaEOuxgtycM2SkHaNz/lv
GfuxOVfIasi9u0rDpUolT6/duKRNtK34v8j0CvyZ+RtceG+qtDdgXWLjHyy6EduECtonqmOx79Ee
fsvl4YhbTgyTXZUA1wTBEMRF5y6WNCZzFVjAp9D+wU3X8b0TpH1unw5GaKDeKuJu7g2lCIIdLGY3
QWKMuBUacXqYzgiB08OnsFu0snO9umPlyryWzK/yetdmHN29jL0XlWvL9f8hAAAAAAAA
------=_Part_82945727_570711520.1622144255774--
