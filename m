Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B403393677
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 May 2021 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhE0TpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 15:45:12 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:52572 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhE0TpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 15:45:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 6C6D218046722;
        Thu, 27 May 2021 21:43:22 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YaPBSL9EOeF7; Thu, 27 May 2021 21:43:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 3CA3418046721;
        Thu, 27 May 2021 21:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 3CA3418046721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622144602; bh=qO3DhPDRgR/SsCfC7avp3fKdM8hk6DhnQMYI3zAUyXc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Mq/2++B77TMZYe4JmjdUhbsn/WGx0dQ2P9m8jnWxZo+JNBZLKyd+tHadRWwvMIgIj
         c0hTOwJVEvtky+5h7M7CaO3koHKeFD01wv+I2ZQEAecBmCmuWFUnpTt1rfwDfDVEBc
         TIBCtAH50Hnf/8Ceakdp1dgahFo3gWfkjV9tDPUb+u00+E/qaX/JG/JWSwPsgP8y3h
         93Inh7yHaYR7VRVueUj/V2hS+UZ56oW+zD8vumGtk34fCUm6LeqSjqI7hR6hgX3iyW
         Gt0T5wKyTotra1+bc8M0fAeS3jwnl3ujEZO0VTwDIUCdfYMDeB97FGsj/eGF9D6Xa6
         HJybLr06hnZsA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cC6hM6bOseCI; Thu, 27 May 2021 21:43:22 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 1346A18046722;
        Thu, 27 May 2021 21:43:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 61F678238759;
        Thu, 27 May 2021 21:43:37 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NAGteo6OdLfv; Thu, 27 May 2021 21:43:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 3B91E823B4AD;
        Thu, 27 May 2021 21:43:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 3B91E823B4AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622144617; bh=qO3DhPDRgR/SsCfC7avp3fKdM8hk6DhnQMYI3zAUyXc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=udESrfIfBrKlm+Kza6O8onZsoowXcVIUfk6JF1Rmcj9B3lR5L6RAY6XMz0k7/ivrE
         hJv1SGzQxZVT8Uh3W07I0GPwtwE6QMshPim4YKXh4AoFG5Ijgb+ICiTMsQBhLDvrkr
         LZdUsguFEs8Gc4c0I2sPw8EWqXSSd5MUS3Id+7KGWwpdMvNoK6LyKqhx+UvG/H7qG2
         wFavfS/ZhccaUx7R1z/3s6gqlADlGZV2SV5uz4jCZkwjD9zxndp0nmaYfMFEybsjMM
         fNVu5daVbycknj6HQ4smEGg2FozQfQIkCu0K5Yna9T486GS3vc63dxLF4z7sR5Src6
         k0gKxTMnD7YiQ==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qvnU2LE1L1Hd; Thu, 27 May 2021 21:43:37 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 184F7823B4A1;
        Thu, 27 May 2021 21:43:37 +0200 (CEST)
Date:   Thu, 27 May 2021 21:43:36 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1947766225.82957242.1622144616972.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_82957244_240848364.1622144617042"
X-Originating-IP: [146.107.159.224]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: h34JB0CMMpEHtuWvcBTRD6E6sdbozWXeKKm/
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_82957244_240848364.1622144617042
Date: Thu, 27 May 2021 21:43:36 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Remi Gauvin <remi@georgianit.com>, Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1947766225.82957242.1622144616972.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.159.224]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: h34JB0CMMpEHtuWvcBTRD6E6sdbozWXeKKm/



----- On May 27, 2021, at 9:37 PM, Bernd Lentes bernd.lentes@helmholtz-muenchen.de wrote:

> ----- On May 26, 2021, at 5:17 PM, Remi Gauvin remi@georgianit.com wrote:
> 

> Hi,
> 
> i followed your guide and tried a reboot remotely.
> PC stuck in BIOS, someone in the office pressed F2, and system booted
> completely.
> But unfortunately in the bad system and without X:
> 
> root@pc65472:~# mount|grep btrfs
> /dev/mapper/vg1-lv_root on / type btrfs
> (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@_bad)
> /dev/mapper/vg1-lv_root on /home type btrfs
> (rw,relatime,ssd,space_cache,subvolid=258,subvol=/@home)
> /dev/sdb1 on /data type btrfs
> (rw,relatime,space_cache,subvolid=258,subvol=/@data)
> /dev/sdc1 on /local type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)
> /dev/mapper/vg1-lv_root on /var/lib/docker/btrfs type btrfs
> (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@_bad/var/lib/docker/btrfs)
> 
> Any idea ?
> 
> I will try tomorrow again, then i'm in front of the PC.
> 
> Bernd

journalctl -xb:

 ...
Mai 27 09:51:38 pc65472 kernel: BTRFS error (device dm-0): could not find root 8
Mai 27 09:51:38 pc65472 kernel: BTRFS error (device dm-0): could not find root 8
 ...

Bernd
------=_Part_82957244_240848364.1622144617042
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
CQUxDxcNMjEwNTI3MTk0MzM3WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCDym1Lt9ivkdf2Hzp1l6JUVrUL1lFv5ACRdGjxmclqP
GjA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQBEDA8gH1lIwxMJCh+hPqJv7x0b+KixbUhKIbYSDhE0IRAd0bU03suG
rTac3rm0FgRQn2AE4LaN7M+QexI/n6ZVMOzr0rR4R98O6kkT2jskWjaputOBxUyU9K5KpgUP9iDc
5fP78RhGQgGEv1UhpUjJ81tI84FLiclqM5gZXtK4H9XqgGiGJsiJUyfQCAkl2PczBaO0pJc99FfG
0XhhWOtVLjT6s7nuSZSXkULP1VvpsBD8431pX2NZ1poLhkLuzZje8MoXc6WmudmKhS95fBRuSDNp
X1ueYa491N7VkxmUa+qsAWI492l3gvJs+bjxu4Ov/mRwGramqjxxOP52oZL6AAAAAAAA
------=_Part_82957244_240848364.1622144617042--
