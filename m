Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7152AB4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiEQSzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiEQSzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 14:55:14 -0400
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 11:55:12 PDT
Received: from mtaextp1.scidom.de (mtaextp1.scidom.de [146.107.3.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85354EA24
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 11:55:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 7110118052B46
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 20:45:49 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GsIZUsY_eBR1 for <linux-btrfs@vger.kernel.org>;
        Tue, 17 May 2022 20:45:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 3FCCC18052B72
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 20:45:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 3FCCC18052B72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1652813149; bh=o6HjKYnGThAIllqKOWCpEKffF3QDv54j66jzJWsTi+c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dH6OVZFVTrChHJEjLF5U1DgouYbVpXwmWe3wcGYoie/A7+0pghbgoSap475gJGJ+q
         /pprubxIyaAR+NcIZnyLVZcTvzOdl5ve43GZvtM44e53xs7eDe+VwyC/cZhKWIdfXQ
         si6bnA4MI2aJmn2O6OCCQ8NGR2lTHU/jq1vH8y1rASwaX3NeALj7/C7jwOw25Wr1tD
         ZHVOW6ilYjoTMV1W8DSv5P7kRw4dTMNGr5u4di7uxAKp9khQrOccSoD5/vXGL5/NJA
         trpsjlMZz6KJP0dniWhbKfqxMjQ77XnZMdg14LpS2qiMM3qcKPfImawmtLmo9dDwtU
         6rtgLGuDIlLNg==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R9jBkeC5KlH2 for <linux-btrfs@vger.kernel.org>;
        Tue, 17 May 2022 20:45:49 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 1867918052B46
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 20:45:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 0D8D28253275
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 20:45:57 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id k00qR939QnBd for <linux-btrfs@vger.kernel.org>;
        Tue, 17 May 2022 20:45:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id DC38A8253264
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 20:45:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de DC38A8253264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1652813156; bh=o6HjKYnGThAIllqKOWCpEKffF3QDv54j66jzJWsTi+c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ryQrnqfSOcsLaf3bZWBUKa0PD+sbQVVgdBj7ON1W+iIg/QYqoQxXXys+UPdgBspcH
         6xyEm6BICZpwZT3i591AWXOaU4HdKsoSN2h+NxCghHe1+VWLirsiLDKEH3fOV5JLtd
         UTpzGxHWyQmcKYVMatxjFvtufDBbRYv0Qif6z8gfUiFb6xTTf1IQL/xYrLN5TPjoa3
         lyI/Flx58p4n7RM7S041PsAQDnDL8IToi/e354F4j6ghjwpYbUGV2n8GLtukp7jDUL
         TvAa4quK7dgNZ9vB3OfwbuE05FoBb5GRgDIgsXWXwudSvDj43UPFk3Mp2kg3/aYhyl
         O1kw783BzkgQg==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rGDznNKxn_TT for <linux-btrfs@vger.kernel.org>;
        Tue, 17 May 2022 20:45:56 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id BF5978252E1C
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 20:45:56 +0200 (CEST)
Date:   Tue, 17 May 2022 20:45:56 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1489308571.65954054.1652813156598.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: extend BTRFS partition
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_65954056_1848410647.1652813156738"
X-Originating-IP: [146.107.158.190]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC101 (Win)/8.8.15_GA_4232)
Thread-Index: Nv+tevYe04aCR8odozJ8ZI3FAtwZzw==
Thread-Topic: extend BTRFS partition
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_65954056_1848410647.1652813156738
Date: Tue, 17 May 2022 20:45:56 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1489308571.65954054.1652813156598.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: extend BTRFS partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [146.107.158.190]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC101 (Win)/8.8.15_GA_4232)
Thread-Index: Nv+tevYe04aCR8odozJ8ZI3FAtwZzw==
Thread-Topic: extend BTRFS partition

Hi,

i have a BTRFS partition on a harddisk which is filling up.
I read in the man-pages from btrfs that i can add another harddisk/partitio=
n.

Can i do s.th. like "btrfs device add /dev/vda[x] /path_to_BTRFS_filesystem=
" ?
Is there something to take care off ?

Bernd

--=20

Bernd Lentes=20
System Administrator=20
Institute for Metabolism and Cell Death (MCD)=20
Building 25 - office 122=20
HelmholtzZentrum M=C3=BCnchen=20
bernd.lentes@helmholtz-muenchen.de=20
phone: +49 89 3187 1241=20
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

------=_Part_65954056_1848410647.1652813156738
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
CQUxDxcNMjIwNTE3MTg0NTU2WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCCEloa2T3I5O89PCinEhh6Y9TnN4Tjrr1lSHg0nNWjd
YTA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQBt1QZoWIMOLV1TJOvtaVTDneoJP+NRh1M9uORzheKoC3hPxAknvq7z
cI1b9M+sBtmVrxX9fSzU1VTFcWSVlhXZUgMAyQdhb9xdhOREc6YzatGKKTPj4d2OBxWp4XPUNOo1
WQQoQJdj5Iw+15CL5xTk5J9n1OLd3V9tkutw8n5pkWeihrW8Ynk+G0VaRHXFsmqqk0ovEw/GCNyV
fOwjaNffDxdZ6pkaxIm9bX4od8QBDGvhWL7cXBxr2HT+fhM6Jwiea4PTK+uBStl3DJpjaJgnzvtZ
RhvOtKm+xb/kz7AuA4N6IaxDz9brVRq+Ml79fxMORzHVOZg7q9umJ3JtQcYxAAAAAAAA
------=_Part_65954056_1848410647.1652813156738--
