Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695993963C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhEaPdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 11:33:42 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:49474 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbhEaPbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 11:31:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 08FA018052B6E;
        Mon, 31 May 2021 17:22:21 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n3hnY5gWstd2; Mon, 31 May 2021 17:22:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id C627D18052B55;
        Mon, 31 May 2021 17:22:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de C627D18052B55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622474540; bh=JWKOn3uUgrg4AeUkxITdXMYXTadKVCJl3vAycI5Y5mA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oq16SGsp8KANbwUtwoXKRuewUH28o6j3LlxHO/tN0o0r0CA+09ExmMbcc7OYbdGS2
         4xPybmZXtoeQaObt8Hle3Am+PTjFgIzYclIQDIOgI+WV0JmiYI229CpZZWoyD/FkRy
         XhiF9v0+M8JNd7E97llmQXgHWp4AcNiWDPL6GmzQp7exq9L7KUyGZpqjrdkXvNWSpT
         y3S2Ft9xdWObNWhFH39zcA+Sdv/msIc8cPl6AsjiauZST+kxtmHgMoL3Y/v/Ej9hko
         z33f9piVAejcqLwuzGt4zPjqd42Kd/GO0MFzrI4AAkLa2mpE1BtHfyeR6KgurqhXp0
         Cqz2uJ2otQaoA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AMvP6ogz2xXk; Mon, 31 May 2021 17:22:20 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 9F10518052FAF;
        Mon, 31 May 2021 17:22:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 69AE7823B2E7;
        Mon, 31 May 2021 17:22:22 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HbCta0phBSsO; Mon, 31 May 2021 17:22:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 43471820C8B3;
        Mon, 31 May 2021 17:22:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 43471820C8B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622474542; bh=JWKOn3uUgrg4AeUkxITdXMYXTadKVCJl3vAycI5Y5mA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=TEM2jpNEvwQhYaq36jYzMtLhKS7PIU1sH8zFjKpCcF9z/h6Qen3tG3hvbiyB48Knz
         3ptLpWTcMQITkwLTEir1XsU4phSqoHC79T3GVlcIIOf0fVcGB2IDNoU9hGdX/Z30VM
         kvYOwX/LhmFrcgjfEMjk/r6eIgbEtmFUkar1DmgAi0YEBJg8GPioE8ija29qNUWdGv
         RQ5OfscumqeUbJC5HFaDIBMcfh3Pp9sZXtPm3kTCQlIccsK6jkjvs6ZUz3/kEvgetO
         D/s/W0NHiLShpKGfgID6iKsInpeCdjeoOrrMNkP9W1WM/sVAyzS9r1yw8rc0rtOttZ
         3vcTlZjqXxqsA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MAVukcCUR2Mz; Mon, 31 May 2021 17:22:22 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 1CF89823B2E7;
        Mon, 31 May 2021 17:22:22 +0200 (CEST)
Date:   Mon, 31 May 2021 17:22:21 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <979845074.86836005.1622474541676.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <ec27dd03-6178-c94c-4dd9-dd98be8b4a46@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de> <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com> <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de> <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com> <1010673982.84485777.1622216164892.JavaMail.zimbra@helmholtz-muenchen.de> <ec27dd03-6178-c94c-4dd9-dd98be8b4a46@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_86836007_1201912692.1622474541989"
X-Originating-IP: [146.107.25.174]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: LyrHI1JqagbTAJ8Ddj2SeGRtcZwMXw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_86836007_1201912692.1622474541989
Date: Mon, 31 May 2021 17:22:21 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Remi Gauvin <remi@georgianit.com>
Cc: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <979845074.86836005.1622474541676.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <ec27dd03-6178-c94c-4dd9-dd98be8b4a46@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de> <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com> <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de> <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com> <1010673982.84485777.1622216164892.JavaMail.zimbra@helmholtz-muenchen.de> <ec27dd03-6178-c94c-4dd9-dd98be8b4a46@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.25.174]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: LyrHI1JqagbTAJ8Ddj2SeGRtcZwMXw==


----- On May 28, 2021, at 5:55 PM, Remi Gauvin remi@georgianit.com wrote:

> On 2021-05-28 11:36 a.m., Lentes, Bernd wrote:
>> 
> 
>> I try to follow your guide another time, and just before the reboot i will check
>> grub-mkrelpath to see if it has changed to @. If yes i will start grub-mkconfig,
>> so that @ is set in the rootflags.
>> I will also check /boot/grub/grub.cfg.
>> 
> 
> The grub-mkrelpath will be @_bad so long as are still booted in that
> subvolume,,, but grub.cfg should not change on reboot.. Ie, it it was
> subvol=@ when we started, it should still be the same when rebooting.
> 
> Something changed it when you rebooted while following the steps I
> outlined. (Or there was some kind of kernel related package updates
> running at the time you were doing this.)

Hi Remi,

i finally suceeded. My collegue started accidentally an upgrade from 16.04 to 18.04.
This upgrade didn't finished because the disk got full.
First i had to free up some disk space.
Then i saw that during shutdown the upgrade continued. This is surely the culprit for updating my grub.cfg.
Today i booted with a live cd, changed grub.cfg to '@' instead of '@_bad', and afterwards PC bootet into the right configuration without any problem.

Thank you very much for your help. Great !


Bernd
------=_Part_86836007_1201912692.1622474541989
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
CQUxDxcNMjEwNTMxMTUyMjIyWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCBSCN1NWOrd0Pfmyv16G4XzlONO4qkh/9bgiOunOGxw
5DA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQAe4+OA3PYqHySR3Ap2oo9wWoDIXX/JIr56v8o3Zm+IeV7v4ncXPjwH
kt6SLX0YvZNxfY2nBjl9M6gUCq77FeESrVd/6o0YFG3zkVCUEStJ6v5dN+dnjaXUx0/wtAFxMTYC
Hf6hLUDOql6dUywPfRIic0M21nfC7JoPA/VzVsAdHPnlx2mqe8jEBkyRqdTxDmjEGBwaW0ScSkkM
MPTDUiROwlLOnHfM0uvIVIaObvXoaA0dE2BlWesaTHSdoKDB8n3eXEm+U2VjOw1P3WNBQ0ZFnLeg
USP5pCERJfqElwJUwvgnZV4NKxJDLaJioWl0fJeJMa5AZNXXFEGMq+GoIFRWAAAAAAAA
------=_Part_86836007_1201912692.1622474541989--
