Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74A42E225
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhJNTrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 15:47:10 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:60178 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhJNTrJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 15:47:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 4278D1805180A
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:44:48 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id x82iOxN7vb03 for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:44:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 127AC1805180D
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:44:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 127AC1805180D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1634240688; bh=8SVV4HzQRNo8S6W7P+APRQatqz8vBgPZlONEpJcwk0Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GjzvH66MGxnLslKThCiL6qxrfREHMj4n3nuylc1xEfc7+mi2lhS5BdlxO1SCjWsTb
         NOpBWtbay2cUym8gsJsw3KtGuxqEkbFocOctKuTgPQuQqsNvUBtjJQNwXSb6FCkQBJ
         33Wd9uZaIJmH/aiNpsTefQuhyx1j8T7Yx7GcDHCqVXejzofVjQHldUyJ3/R6HmyZRj
         iRaft3lonL3PIqmcM+4UWu8bCGx64vy/I4t06yFmV4WYlrp5QsXoafjUsZht/A6FYY
         /CN15GVeUXLiTwdZXpo74zwn+G4COLtJq+I4CC5YbtxTuZ7VtH6F8XKVeuVM2mYS0F
         +YoTZJN8mDF5g==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v2VV4a2o7xQd for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:44:47 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id D74C91805180A
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:44:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 37328823B4AD
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:45:03 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LFnAFg9F0QEI for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:45:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 0F408823B4AC
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 0F408823B4AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1634240703; bh=8SVV4HzQRNo8S6W7P+APRQatqz8vBgPZlONEpJcwk0Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dBttX7kz32hXPlntrUY3pgy/NeyP1Nnt+sgmX14qyTDl5B8PRk1NeEEdOZXSWIILZ
         UQfoiIK5ExNxDUKl4XA283qIF2Om1pU1uR121mxE0CxDQ1SRjWIhl7jzszfDXPlBpJ
         JYDvhy6IBnMuZ60ssbJah34hy49+HR0iuc/sYiKeJuUo5vEWfGGFsAF9aJTEQXOmPy
         Ogw50fgOqu5hxIZ29H/bUU9vlhwd7wgL5EoFu+GptO3wX49k2XosNh+AxLBbLbhnXS
         LIDD/rVGi/UN7T98KU7jgtKgWhab1ZhnDlym7A3XDOagKcHE0k6mMnbXR5vFUF/M5v
         hN8BZQkgIhjJA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hM1OwBhptgrT for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:45:02 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id E4CF4823B31B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:45:02 +0200 (CEST)
Date:   Thu, 14 Oct 2021 21:45:02 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1225415707.59364315.1634240702817.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <79a27c00-5475-12e0-8227-7eb9aa3b080e@suse.com>
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de> <79a27c00-5475-12e0-8227-7eb9aa3b080e@suse.com>
Subject: Re: some principal understanding problems (balance and free space)
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_59364317_1101846086.1634240702874"
X-Originating-IP: [146.107.127.138]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4007)
Thread-Topic: some principal understanding problems (balance and free space)
Thread-Index: 7xvdh2j8T+JkYR94dlfkdBsoC/Y3Rg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_59364317_1101846086.1634240702874
Date: Thu, 14 Oct 2021 21:45:02 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1225415707.59364315.1634240702817.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <79a27c00-5475-12e0-8227-7eb9aa3b080e@suse.com>
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de> <79a27c00-5475-12e0-8227-7eb9aa3b080e@suse.com>
Subject: Re: some principal understanding problems (balance and free space)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.127.138]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4007)
Thread-Topic: some principal understanding problems (balance and free space)
Thread-Index: 7xvdh2j8T+JkYR94dlfkdBsoC/Y3Rg==

----- On Oct 14, 2021, at 3:25 PM, Nikolay Borisov nborisov@suse.com wrote:

 
> Does that answer your question?

It does. Thanks a lot.

Bernd
------=_Part_59364317_1101846086.1634240702874
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
CQUxDxcNMjExMDE0MTk0NTAyWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCDXIkp9mF0NXIWjRt/lHgL8spUa5C+PLnnOxxyqcxkR
9TA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQAKsmwQ+s2E2/xxTl7sIXKxNTbi+0pSpt/0RIqH9BrLbJ3hqQv8zUCb
FlGtfv3ltsG2i7O/JcXyxZUfV2jZwNhXF575UGLKQ2Ju0JZTDib+l6d8o3crhV5W2EAVjQmjonlI
/vSwi/oLP2ZupaSfH44/b20NwSoqHVCVaztPKZZS9ajXPDelmyZyZDLLeZwa2Rrmbek6QQGfMfZj
eii8a9Sw4QeI+v3uIteRZVqvWG6P1CZFoS3mruUgH/d8AZ/tkznjJVcXyiSHj/3iCBMyGEcsBPxb
oc9fdpled/Egiu9GJzaEoXB5XM9Vk9Gc8ZMhpuehUMBBPMt2b87bX32BzzqiAAAAAAAA
------=_Part_59364317_1101846086.1634240702874--
