Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA5A3913E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhEZJmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 05:42:37 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:37794 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhEZJmg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 05:42:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 089C118055AEB;
        Wed, 26 May 2021 11:40:50 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O-aXlwesfmtn; Wed, 26 May 2021 11:40:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id CFF6118055AED;
        Wed, 26 May 2021 11:40:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de CFF6118055AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622022049; bh=JJFede3yjhTOzocqufSqH+SBeVIiHeBpSJf2aTIS1Bs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MiVytv/abHi93digA9itCOsIGvtuRbt7kHVcQzsVr02tQPp28Smfl3S1hKaY6NFrt
         e9ce3rTpym0cPQIW61scy4/iSGoZetAPUcH5fvHJaIfoUe93ntSoDDaWmXh6kWtZ7O
         I3FYlcIqmfyI7O1zYJBC8jK+niSYhf9ojW7hK+7RffY8FLNvqW/oMuSHZUg5xbMY/D
         H68x9BHYBPFqI0AVmgnwrYyNn0ay0k1w16fUujbAbNtz75+lPwcRFrVoy90E8s3LNi
         5WWhUh3pQ05tRZpZ0ilFMsGpqkYYCXG8n15pOMwvEm1oWAg8M7nOSC4dko3oNqNWeM
         GlHypV+TvkXOw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 37iHqB38NFM3; Wed, 26 May 2021 11:40:49 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 8FB5E18055AEB;
        Wed, 26 May 2021 11:40:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id A452182363C7;
        Wed, 26 May 2021 11:41:03 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TBT2bt0u6_jo; Wed, 26 May 2021 11:41:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 7C71982363CE;
        Wed, 26 May 2021 11:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 7C71982363CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622022063; bh=JJFede3yjhTOzocqufSqH+SBeVIiHeBpSJf2aTIS1Bs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bdCCSmrg/YgC9T2V+E/1dTpqmwd6SRBBA0xrrJIyxj3fPvhaPK2kA4BVAOJQz0Cr0
         vylqfbNp0mmdkzfwkK6D+Ajyn+tvlPY7uiA6qelZQ8H8ycfI6zaigHyesLg9Zk9/yZ
         fk+6aQOENCA3iD02u06vCgwcUF+qQXa0z3Utp4R5ccvrgA+DwvqsOxo1POHBd+UdR6
         GBIJKqZekNEGP7vJBW5ExMP0KmflJR3jgGnRbsfdLCg+5ozpc20uUFPX6PusoNdoh0
         PSlhueI3QJSbL5YP7Dms+wAYeHWDjKBHVT1J9g/1VWQ3Oh1GQqFEDmX+h6sZElW8gl
         yR+gU1V8VS4yg==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zO43Ia8G_PPF; Wed, 26 May 2021 11:41:03 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 56D8F82363C7;
        Wed, 26 May 2021 11:41:03 +0200 (CEST)
Date:   Wed, 26 May 2021 11:41:02 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     arvidjaar <arvidjaar@gmail.com>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <647580601.78931938.1622022062919.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <2c00a97f-ac79-147c-ddd2-7ff4a90ca941@gmail.com>
References: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de> <2c00a97f-ac79-147c-ddd2-7ff4a90ca941@gmail.com>
Subject: Re: some principal questions to "disk full"
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_78932200_423400243.1622022063300"
X-Originating-IP: [146.107.126.162]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: some principal questions to "disk full"
Thread-Index: 7dCu5P9sCjwiVEDHFCmwXNzCsTKRAQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_78932200_423400243.1622022063300
Date: Wed, 26 May 2021 11:41:02 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: arvidjaar <arvidjaar@gmail.com>
Cc: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <647580601.78931938.1622022062919.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <2c00a97f-ac79-147c-ddd2-7ff4a90ca941@gmail.com>
References: <1771321158.76542899.1621959622455.JavaMail.zimbra@helmholtz-muenchen.de> <2c00a97f-ac79-147c-ddd2-7ff4a90ca941@gmail.com>
Subject: Re: some principal questions to "disk full"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.126.162]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: some principal questions to "disk full"
Thread-Index: 7dCu5P9sCjwiVEDHFCmwXNzCsTKRAQ==



----- On May 26, 2021, at 7:36 AM, arvidjaar arvidjaar@gmail.com wrote:

> On 25.05.2021 19:20, Lentes, Bernd wrote:
 

>> What can i do to prevent a "disk full" situation ?
>> Running regulary "btrfs balance" in a cron job ?
>> 
> 
> If you are using more or less recent kernel version, you need not run
> btrfs balance at all except when possibly converting profiles or adding
> new device. btrfs became reasonably good at managing free space.

What is "more or less recent" ? Which version numbers ?

Bernd
------=_Part_78932200_423400243.1622022063300
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
CQUxDxcNMjEwNTI2MDk0MTAzWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCD6jrlRO6zeLw8zhzSY8q6rHlevYu5GjPc2fF8Wp4oK
ATA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQCYzWUx+Fl4oe/8jt+j+3+N/sUJNrtJnt5FywpHaQ+HlFCTOT1zLv8m
mCRBTvWMTaJXTEQ1EKYXjt5Xd4Nbv3sa+xZgvKyBUVVv2a/SeEF+NldRYfEyonOvwkUJVLSlKtFn
+uhN8asTKp3N5PRgDtJQAjXUR98zm+jc77PKMzTySOIGFGsnCELX730MZ7fkOIRRUX2E67bvHJYT
OHmQ5GU4eAYhqCE7rK0IcUFW2O2o6/4z+rSKcb6HyTsvL0U4jsOUqUI7nyeodXkJK4Bda46B5pkY
Etwp6aIOPdXgiQcIICkJdbr+xBcPq5XoapDd5mht1sx5FoRH95UM28iP8xodAAAAAAAA
------=_Part_78932200_423400243.1622022063300--
