Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267F339452B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhE1Phn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 11:37:43 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:54260 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhE1Phl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 11:37:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id A4BA81803CC91;
        Fri, 28 May 2021 17:35:49 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yeF_Q884YKLP; Fri, 28 May 2021 17:35:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 773AE1800C9BD;
        Fri, 28 May 2021 17:35:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 773AE1800C9BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622216149; bh=OOoMOeoXMoirytbqS3lQJluixYxWbTM5ScfxifuDndM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=VfiipEAZQVSOs891WJLReblF5Oiw9G5BQce+mux3WIHBucsjdUyHBbqW1joFVKHek
         9bN5abehtnRw44LXcQRtMPCpF0aJ665WldCZNdjYsoj899tsRVVQiXftmJYPWsPa8/
         b6ACpLyuCh867YdCXmv/qjDbILpsKAokLxFdX+TCW0VVyiUU86L9FCor9cX0orAd3t
         b9IzUxznIXu3ybzfdxgfkPEYtURY7zkoXF6WIm6jTQhpzTFX3pg2STiUR0+nJOjpjC
         uunAvkCZOk7fg2QJIxjOd1TpLKUQ53xt2XkNSPRvPo+lj61YndvoVbJ8NcXBPCg+X9
         IlztqHb6S+TdQ==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MiT70w7fc5-f; Fri, 28 May 2021 17:35:49 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 3E9AC1800C9B6;
        Fri, 28 May 2021 17:35:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 4E0AC82556A3;
        Fri, 28 May 2021 17:36:05 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FgK0GFjkfNQj; Fri, 28 May 2021 17:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 25BB682556A9;
        Fri, 28 May 2021 17:36:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 25BB682556A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622216165; bh=OOoMOeoXMoirytbqS3lQJluixYxWbTM5ScfxifuDndM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FsmlNz3vhEwKfljid3MdM9cegGS4XbOHB380hLpMSPig7uHHeBwrJNyaDpqeNgUj6
         DQvq4Bx3rM2tdp0dgjwBDXZGFx4aFjh6atN6BkWdoEiBz452xkYrGznsaN/dhvtxKF
         ks1EYJLd+I1ym5eUKrg7Je9k40Qk1l27EwUevvIXNY/dEP13Mna0K+PJ35FYaHMMiO
         CXk7XeKRj6dkZQUZxeHkbU0bD6ugBoKsjYRKSYI9WzeI070pLWU3hRICIatW1uIky2
         wNmKnMmcHJhjZxgZAQ2PKI8qDhtuBbL9cZlco7KUCxtcjbuPFplgiLvXJXdRNRcSdw
         4la9Ang5Nk8Fw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jXHXkK50mOBT; Fri, 28 May 2021 17:36:05 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 0428882556A3;
        Fri, 28 May 2021 17:36:05 +0200 (CEST)
Date:   Fri, 28 May 2021 17:36:04 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1010673982.84485777.1622216164892.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de> <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com> <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de> <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_84485779_815101485.1622216164954"
X-Originating-IP: [146.107.25.174]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: 6MO6SwF0+GTuGkEkwLLeNCei33MZQQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_84485779_815101485.1622216164954
Date: Fri, 28 May 2021 17:36:04 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Remi Gauvin <remi@georgianit.com>
Cc: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1010673982.84485777.1622216164892.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de> <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com> <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de> <14cf1027-f83c-76e7-2733-14764a155a14@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.25.174]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: 6MO6SwF0+GTuGkEkwLLeNCei33MZQQ==



----- On May 28, 2021, at 4:56 PM, Remi Gauvin remi@georgianit.com wrote:

> On 2021-05-28 10:33 a.m., Lentes, Bernd wrote:
> 
>>>
>>> If that's the case, you should also check the /boot/grub/grub.cfg and
>>> verify that the kernel boot options specify: rootflags=subvol=@
>> 
>> root@pc65472:~# grep -i '@_bad' /boot/grub/grub.cfg
>>     font="/@_bad/usr/share/grub/unicode.pf2"
>>         linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro
>>         rootflags=subvol=@_bad  splash=verbose   <=== !!!!
>>                 linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro
>>                 rootflags=subvol=@_bad  splash=verbose   <=== !!!
>>                 linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro recovery
>>                 nomodeset dis_ucode_ldr rootflags=subvol=@_bad
>> 
>> I'm hesitating to manipulate grub.cfg directly, because of:
>> 
>> #
>> # DO NOT EDIT THIS FILE
>> #
>> # It is automatically generated by grub-mkconfig using templates
>> # from /etc/grub.d and settings from /etc/default/grub
>> #
> 
> It's relatively safe to edit the grub.cfg directly... Just be aware that
> next time something runs update-grub, your changes will not persist.
> 
> But here, the question I'm left with, is why your grub.cfg changed
> between the time you renamed the subvolumes and rebooted... You might
> have something that does, in fact, execute an update-grub on shutdown?
> 

I don't think so ...

> You can try editing the grub.cfg and reboot and see if that fixes the
> problem... but if it reverts to @_bad, you'll either have to
> find/disable the script that is updating grub, or change it at boot time
> interactively, (which means, needs boots on the floor)

I try to follow your guide another time, and just before the reboot i will check
grub-mkrelpath to see if it has changed to @. If yes i will start grub-mkconfig, so that @ is set in the rootflags.
I will also check /boot/grub/grub.cfg.

I will keep you informed.

Thanks for your great help.

Bernd
------=_Part_84485779_815101485.1622216164954
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
CQUxDxcNMjEwNTI4MTUzNjA1WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCA/u647P2wZPgi9yub1wpi1CEtid1beLokLjV/F2b/K
JDA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQAXfDxhWvwRggQncYVn8hBQp0AZ4ErSknH3G15tB+4IgWBd0dpo33Af
wa0S9KM7neoc46OQmgxQuJjTVt9SmhLG6JhQS6xZ45lNoEb2ZSKvCTnDZHZKV1v3x/dg7kuA2nEd
FU1nnDHbNOsSH9ARUABNQn2vGQHpzPpdEhnVX+ryQdRY34R6Dq/kOlWMIvw+XHkwJeMlAWkl2xQk
+O5YLbB3hrII899sXEh6tXEDMw2lPMlSEHSrILHVvp2YF6KuNma3dYm+NIdTkB29eWXMEVPulYO5
0pn3CQvgF2UyqoOQ/o71FPjuDWenUl23GcmsV6whqFzLxwE8Lp+If1kO6vcsAAAAAAAA
------=_Part_84485779_815101485.1622216164954--
