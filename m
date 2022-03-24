Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0B4E63A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 13:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbiCXMtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347497AbiCXMti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 08:49:38 -0400
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 05:48:06 PDT
Received: from mtaextp1.scidom.de (mtaextp1.scidom.de [146.107.3.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9225CC
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 05:48:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 96E2218001D65
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:38:25 +0100 (CET)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wWADdCqF0Zpy for <linux-btrfs@vger.kernel.org>;
        Thu, 24 Mar 2022 13:38:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 6751118CD8F0F
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:38:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 6751118CD8F0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1648125505; bh=IeqIByezPZUq97wsVKe4oric8khqHOxkQ/olLJ+jvQw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rptyZsgPkbkJ03VViTZudf0JvCw2Nwu8AQ2N6ymCWT1ClENABV9IYMTTxFuLUPiYx
         X+6a3yPwJztfwc1PAlRF5+Q3G7zkxAAIzXqdY9XFR3pFcrXD+gbvDjxSBMHRAN9g9E
         dSYteZt4xRJLDaEirPThNdoDuma5j64eLMQ/Ti2CG6dRubkIG6VrOMHwbPajqOWedQ
         f3tHErQwuiB8ew2BlPGjqMBcEVVp2ZZSDhK6RmxDCekTgdMAFyMEVraf8ijeiSYRLN
         JyCFHkXkH4bAGv8Jq5HrjUA4oc+gSMCee/3x18QSt+9EiP0U2SclV5Q+i11eL3//vr
         dAR485CAOcAZA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lmqXQMy2wKAZ for <linux-btrfs@vger.kernel.org>;
        Thu, 24 Mar 2022 13:38:25 +0100 (CET)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 4211918057A09
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:38:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 107B58268250
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:38:33 +0100 (CET)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WZ1nBq3Lhqlk for <linux-btrfs@vger.kernel.org>;
        Thu, 24 Mar 2022 13:38:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id DDAFF838F059
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:38:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de DDAFF838F059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1648125512; bh=IeqIByezPZUq97wsVKe4oric8khqHOxkQ/olLJ+jvQw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Rwf9KPBAn91Z2TDBjZxNyOcv/g3qSVCyMriKOdXOq+H73yv6dIzK1/4H1vKpVmxg1
         yi90pT6xZj/mgYfMh+VZ50SyHgAc8AXrhaZ2lihgPGh6lDzdvd/hLC+5+xsRUrzt5Q
         IK212nmDAMRy4ODmw90bp/a2oMnHs8BhixHyXAMoPnnZUDe+nZhFWy6H0jDsz00q6y
         Q0EARoxc9npb8Dj4VncjyC0E04izSzygVtKbUx7kjgbVnqowRTiIsybIrSS6notsNi
         hwgU0xL/6GKY90sQ2ugNP8TCHupCSBAjIXaljHK7ifEW9uZgm0offBe/Klbe3LV56B
         kCMSdjN107NKg==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XW0OCnEeamWb for <linux-btrfs@vger.kernel.org>;
        Thu, 24 Mar 2022 13:38:32 +0100 (CET)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id BFD0C8268250
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 13:38:32 +0100 (CET)
Date:   Thu, 24 Mar 2022 13:38:32 +0100 (CET)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <587892959.1863318.1648125512532.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: what mens gen and ogen in btrfs sub list / ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_1863328_174847465.1648125512746"
X-Originating-IP: [146.107.159.74]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC98 (Win)/8.8.15_GA_4232)
Thread-Index: AqPWMDCDLeUl24/5ier5p2tf+Tv0hw==
Thread-Topic: what mens gen and ogen in btrfs sub list / ?
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_1863328_174847465.1648125512746
Date: Thu, 24 Mar 2022 13:38:32 +0100 (CET)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <587892959.1863318.1648125512532.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: what mens gen and ogen in btrfs sub list / ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [146.107.159.74]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - GC98 (Win)/8.8.15_GA_4232)
Thread-Index: AqPWMDCDLeUl24/5ier5p2tf+Tv0hw==
Thread-Topic: what mens gen and ogen in btrfs sub list / ?


Hi,

i'd like to write a script in which, beneath other stuff, the oldest snapsh=
ot(s) are deleted.
So i'm looking for a way to sort the list of the snapshots by date.
I read the manpage and stumbled across gen and ogen of snapshots.
But what does that mean and how can the values be interpreted ?
Or is there another way to list the snapshots by e.g. creation date ?

OS: Ubuntu 20.04
btrfs-progs: 5.4.1-2

root@nc-mcd:~/skripte# btrfs sub list -tcg /
ID      gen     cgen    top level       path
--      ---     ----    ---------       ----
273     1060462 170590  5               snapshots/pre_upgrade_27112020
279     1060464 1006204 5               snapshots/root-19102021


Thanks.

Bernd



--
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

------=_Part_1863328_174847465.1648125512746
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
CQUxDxcNMjIwMzI0MTIzODMyWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCD8WA7lsSj7e0/l0RyCfKvkPKakyXxnzy8b0Cm1OLlt
/TA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQCQ5a3C1+elP5UpG+LDXgDc1ca9M+eLallJRigrcVyZDbRbPXVyLPcc
PR1lEvzF/kx+UrQ9sodbrKhkKOZrjKNxNbxTNRJgqRykcNB+7IBt2NFGDCoKG9EucHQFS9C9EXRu
wW3nzRcYr9UeQfm9hLq0IZPyuD2iGU4mtWCVTuEIg9jm5kQYOdo8vgYqS6LGgzPsdQgod3Uz+wxi
XQ/6o2a58ViAwoY52TvTDJT4tCFfPNaUwQ9ztffOYMHhCMlY0ompC30rNwQIfYjcUL/uhqcONZRl
mQvLUE1NbIByOZs40cNz29PGQ8B9syNcpBKHLGPvOz6hwiYHkmCqflfUQQuzAAAAAAAA
------=_Part_1863328_174847465.1648125512746--
