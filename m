Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68C542E220
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhJNTpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 15:45:21 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:59922 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhJNTpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 15:45:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 2334C1805180A
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:42:56 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9U_hMtjcSekr for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:42:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id E491F18051804
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:42:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de E491F18051804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1634240575; bh=9Z9Apww1DZVA8K65RTmJYIgouWTU9qXUel6jxhAoEAk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FzvqVmxZ2zDexBW1mqKoP95MGRrtbuHdmc0LFqPP52HCkOwwjtd5VE4j4lruHXogR
         AFJnCNP1r6FIg7quyFIeBDpGsyAaDjWsKMqrVVFlPlgnAceVLlnWQMPr7KKigljbrl
         R22w3vbGcyTcdTWRUfz1ErqvHmT3kph9ysxkZY5Tf9gz55e5mcSJKPXSWPcPWW5gom
         K/FyJTsxsyoG40OH18iknL21s9i/xmuVtKYPUD47vduCqe4s8CmJZhFLnNTG4/0U2b
         Vo9evaTmXAVzB0UC2d5aYQoAQRdFJXUoGf5VW73+gdmbkGp38RaI9FLQ6uBX+Gz+CS
         fhkq4PU6dDQtw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ha5SKEKIXTzA for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:42:55 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id B21CF18051B3F
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:42:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 12491823B31E
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:43:11 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pUy-KdBprOuf for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:43:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id E084B823B31B
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:43:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de E084B823B31B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1634240590; bh=9Z9Apww1DZVA8K65RTmJYIgouWTU9qXUel6jxhAoEAk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oGelDYwq8e0CzrHrebzt5WkgX+S5selFlSzz3XMUjt/toEWvidNvGamaxC8wi8cVU
         PtOSA1SYmiJbKmGfXv+neMEspGusF/bAJS1ZKGjTusvAX0qs2tYiAgdoLpoDOBGf3Z
         iG7jddkLl3EjCzmpAA/BYbycXeAqj8FZqzZOVI0jM9tiSxdXYrs4nectlhKmhZ6G9b
         IpS67k0Wj4ze5WepQVuzDqYZVgnE/Df8Eu+HWv+y+kbzoruYLC7i5o/V25/p32m9TG
         DRdTc/s9bvNb4WsMoH623LXVuZ1lJMzuERj/YnDaV6IF4qVmtEplHRfJX38qtnZ/Gk
         yyaP4pAJsqTWg==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SENvju5IHKf0 for <linux-btrfs@vger.kernel.org>;
        Thu, 14 Oct 2021 21:43:10 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id C2561823B4AC
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 21:43:10 +0200 (CEST)
Date:   Thu, 14 Oct 2021 21:43:10 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <646607072.59364188.1634240590439.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <20211014134032.GB3478@savella.carfax.org.uk>
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de> <20211014134032.GB3478@savella.carfax.org.uk>
Subject: Re: some principal understanding problems (balance and free space)
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_59364190_1979860484.1634240590752"
X-Originating-IP: [146.107.127.138]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4007)
Thread-Topic: some principal understanding problems (balance and free space)
Thread-Index: y8KoOhlixFUJQyTTFzliYk53ggY84A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_59364190_1979860484.1634240590752
Date: Thu, 14 Oct 2021 21:43:10 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <646607072.59364188.1634240590439.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <20211014134032.GB3478@savella.carfax.org.uk>
References: <1920407503.58357312.1634216278641.JavaMail.zimbra@helmholtz-muenchen.de> <20211014134032.GB3478@savella.carfax.org.uk>
Subject: Re: some principal understanding problems (balance and free space)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.127.138]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC94 (Win)/8.8.15_GA_4007)
Thread-Topic: some principal understanding problems (balance and free space)
Thread-Index: y8KoOhlixFUJQyTTFzliYk53ggY84A==


----- On Oct 14, 2021, at 3:40 PM, Hugo Mills hugo@carfax.org.uk wrote:
>   Hugo.


Thanks, great explaination.

Bernd 

------=_Part_59364190_1979860484.1634240590752
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
CQUxDxcNMjExMDE0MTk0MzEwWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCAk4afQtxIzneECTmZ+9ccy4D9gKPIIEKhyO9Ept8+d
/jA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQCo766j/4+xqdzIQQ4aONa/t+b+EIPcaCbSxAvMoHRIRBE3Qc0x7EnO
o3zn4tsbqTOzmWbsbcNrglVbccYdDt5j7tWebMVr15M0f5/E6rY3Yafk0Z6egE/E3bLlqdTICDik
I+wlDjbI+d95853W3qtDIaAex1YeltIViI8DvK9fWuSxsmJ+Mo88in3JDn5z/Vh0J0QkAiC2Dtdc
6I2nCLlh8mU2OyS+qRuknvk86oAcRvAakMrjN7hy7XxkNh95D8eA131cqJtxQ3ZOWDdpEqV9W90n
XSu8tNzpton3DFDHVBEygeCiN4ICCVnkA41SBBoaWrgzgqjkoHQMFgfYnd1iAAAAAAAA
------=_Part_59364190_1979860484.1634240590752--
