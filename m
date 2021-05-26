Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8061B391ACE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhEZOzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 10:55:31 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:44268 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhEZOza (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 10:55:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id A0E1018053DB4;
        Wed, 26 May 2021 16:53:43 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id k4dvQ4qYTaRC; Wed, 26 May 2021 16:53:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 72FEC18053DB3;
        Wed, 26 May 2021 16:53:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 72FEC18053DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622040823; bh=E4Ewp6G+rMWUfJz3kDHIy0SeI5XbhLr7Y00zGPioLlw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=auenvvPLKdLYbiPmxup5GUIomDKSzhrlw98ii9E/dfu9fyz2nIF7Dn9cvlHQGTBzl
         VQVzJKIHCv1h8vcqwnJUosoqpQVFBQT4Chr+PqUBHMBdhs+bJMpclU/YpxQ4e87QH9
         64jXqABuK0aWSPkQdE4bSp187sX/qnOA4D7ZLHXhXbiNZpdjNYtPVlbsctx+4I9VpU
         8k+w/JqWx0C3cNsmpcs0yE3QJSDFB+tejuFpWSpHDjzANtXP/qyOvCE71slAoR50f6
         C5x0Jfo+ITGwQxrp6OxyaSZfDC/fU7OE4IVUwOZrMnoyCraO2CoxMlpCy63by2mbnR
         3ul9tIgUgibaw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gjKUMxh1XVLb; Wed, 26 May 2021 16:53:43 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 4D00D18053DB4;
        Wed, 26 May 2021 16:53:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 58C2282363D4;
        Wed, 26 May 2021 16:53:57 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fVVZ2C8ol3AT; Wed, 26 May 2021 16:53:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 2C36D82363FE;
        Wed, 26 May 2021 16:53:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 2C36D82363FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622040837; bh=E4Ewp6G+rMWUfJz3kDHIy0SeI5XbhLr7Y00zGPioLlw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XOP2M5acIunFb9E5VqV6QgQz2HF212ru7t37E6WWppBrpKuqNK11hBatRcZ8uBsQz
         OZSiPxldBk5YwMPz1Zh4MsUQxrfdRdAGdxHJWNAdndQmmnVZyq0daAbe9Ogsyi3Hdq
         jJyCJGj9BA0Xe6hg3eniViT5qJmXWaa7VGMIUgV4mZwHmndvRvUNMnv8HORBXk373S
         YaUi+HkbHrAABjo6QFNttwfvS8NFZZAmcK4z4LU5BTlBG4wI38Yj/G90e+jskBGcB5
         BETQhmXPB0KjPumAykDNjEPbVZDPJQIpIApJS1AsNJRT2DRbqIoE/yP26QotTDPhoY
         YMSej0cjPGaxw==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mzzx2YJUc4ux; Wed, 26 May 2021 16:53:56 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id B11BE82363DB;
        Wed, 26 May 2021 16:53:50 +0200 (CEST)
Date:   Wed, 26 May 2021 16:53:49 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_80084944_251108864.1622040830129"
X-Originating-IP: [146.107.126.162]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: m3RjxVxNfUF6fMZlzU2VuXlZvEWB7A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_80084944_251108864.1622040830129
Date: Wed, 26 May 2021 16:53:49 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Remi Gauvin <remi@georgianit.com>
Cc: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.126.162]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: m3RjxVxNfUF6fMZlzU2VuXlZvEWB7A==



----- On May 26, 2021, at 4:08 PM, Remi Gauvin remi@georgianit.com wrote:

> On 2021-05-26 9:05 a.m., Lentes, Bernd wrote:
 
> Step 1: List the subvolumes that are directly in your @, those will have
> to be moved or snapshoted back into the new root.
> 
> # btrfs sub list -o /
> 
> 
> Hopefully, /@/var/lib/docker/btrfs is the only one, and you can just
> move that whole subvolume
> 
> # mv /mnt/sub/root-volume/@  /mnt/sub/root-volume/@bad
> 
> # btrfs sub snap
> /mnt/sub/root-volume/@apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:10
> /mnt/sub/root-volume/@
> 
> I'm assuming that docker itself has subvolumes, (you truncated the
> subvolume list.)  If it does not, you can just snapshot it into the new
> @.  If it does have subvolumes, you have to move the whole thing.  Only
> do this to a directory/subvolume found with the sub list -o command.
> 

It has:

root@pc65472:/mnt/sub/root-volume/@apt-snapshot-release-upgrade-bionic-2021-05-21_10:38:10# btrfs sub list -o /
ID 724 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/861e224ff669e010d4f88459fcef35a53a13f06a0bae9738c5109442e25d22ef
ID 725 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/e29c8a1388d14e5c609ec699ee646bc435d41f1c856c6622c402941d9a462001-init
ID 726 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/e29c8a1388d14e5c609ec699ee646bc435d41f1c856c6622c402941d9a462001
ID 727 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/0d604657c3d1de047d0e25592701d580c5e25ba80efc7957317d50448e3292fe
ID 728 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/14eb3fffe7da6aff12182b49b28bc4632fdf21a8045f532b5819375f8405f5b2
ID 729 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/b3620e2dad03b2db17c01e27eb005e054948c2deec480c70a6a399802f06cea9
ID 730 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/0e76b1fe113e0801762bb19f444fa911431c309c7f07796866b152be93d7c231
ID 731 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/d06aa183056d47960c53beffd7f1e4765bdda7457b9d80eb5253ae24a41fed11
ID 732 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/2cc3bd6cc3ba6f7b6d59f24d0a1341094dbe85f6378ca77e989efc0072db574f
ID 733 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/5caa7d6a8b6ed674c90eaaa381f9c5f14a16921d5a06a35c3d83ebf330a8e68f
ID 734 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/2f953e73e108714c7f9f3b3b95358ef4352fc29df4372cf7dfec91267bc70954
ID 735 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/df83a5c69bee2d0b06695bf2645b79b93611beeb8aa1a157dfb5ac4253a30928
ID 736 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/e6197fb42e2a624e23a41c0e7cd86d5b5c65b420dfd3d6e1a373c716e79d4311
ID 737 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/ededd3b8d9c0b39f2f2dba0102eec282e134a7cef1d3218e3a0c4266f271396e
ID 738 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/56d73f1207841c59cefc190f380eb62516983e25e0e9806b8166c790d999592c
ID 739 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/f0f3f683697dce3ae18304be732d9cfc3f0aa663d90dca7d351505c15989d9e6
ID 740 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/a9f458390614c253b7d06bbf82da48387220ce455693286bb92ea8373d8c2df3
ID 741 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/9042f96c1bd673d3ba0ca54b9ed82111fbd979338bc94201e5a78aedf4e3e46b
ID 742 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/5e88b78a7a177a1bc902fb0e864d6214777b536c509602552845f3a6e5c70442
ID 743 gen 44757961 top level 257 path @/var/lib/docker/btrfs/subvolumes/3b58a0c99f6345599c3a8295e49cbed58b5c48e5e9c55a0580c1c290db38e7a5
ID 744 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/2609ce598882f98706cdfecdcec4111d7efc41bb7499190f75f62409b3854ad2
ID 745 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/50f1708e7da7690edb8925e9b35417d052681a22c71b45f4ab11a215e9ddae7e
ID 746 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/eb58f0f899885e4b30a2396ab7af6cb0e64a3c28120cd7d08a19bbbc7d6fc244
ID 747 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/a12aa99c06a1851d27811df8494c1e8d45f84148a2089296789ae6621b0cfa0f
ID 748 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/e1509bdf7aa715f881a651cf3e052081641513c8be4eaad9a9fb30430228ca2d
ID 749 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/596b5dce434692b4c2b9c571fcb23c47514ef43bfeb4c8bbde8a0c50fc19aadf
ID 750 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/4e92db3bb0240df49da798dc8297d644ddb7d608e10a0f4ee7bae7320a36e5d8
ID 751 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/169072a0c2c1b4daa16f9cd4be60c7e63dfc2a5fb4198d0ea71f3a25c91bab8e
ID 752 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/f98753db60820b0f45201fb1d76544ccce19cddd5a6acc62e4acdef5a8b60ba2
ID 753 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/145e9aa53bf55045ad73b4d230883be59da59471101f94eada05c0c21db81e6c
ID 754 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/d349cc5329b14b3cc6550ed43c94ae2445c441c6463cb090fb533860102da0fd
ID 755 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/ef7367319f3cea933a873cc94d9a6db0e4108fe5b72ea361e6b42097baff6664
ID 756 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/31bcf7fce390941ab6c335ebcc117b40a011c28849ee63c5d1eb9487b2e83120
ID 757 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/94bcd2a480c89bd2226af9a3b7dd1a645fe5c1ba5a363d6a9542de63fea3d2fc
ID 758 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/cb31c7297ff761a298ecbcefe0ab47314d479b3200ab6af30a4c1b77503e9d37
ID 759 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/f73cb52db8e0bc5a3356a5284d7f733b9b7ba2f6494617fdb0a3004691d080b2
ID 760 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/65416a53d7da4949897c45d390802d24f2fae704d9a64176fd05d8241ed3aacd
ID 761 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/183e345921700ffea88943d1d1fdc8958038245f145cb78dbf0b292059546c3e
ID 762 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/22ffacbd4e0c0778d1610da9637f2b6058375fff58f07035a431258f0aec49ab
ID 763 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/d4eccdcd6659628ea02834929f6187e0c60fdbcb950a2b498973c4a806ed90f3
ID 764 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/b85f5e75207d899700515ebada8dcec8dd8f38f268da9bb382835f3101243d95
ID 765 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/5f66e708001a623ae8f219fcbf5a9a9b020bc12403c2cb9ad788880caa79b912-init
ID 766 gen 44757962 top level 257 path @/var/lib/docker/btrfs/subvolumes/5f66e708001a623ae8f219fcbf5a9a9b020bc12403c2cb9ad788880caa79b912


> 
> mv /mnt/sub/root-volume/@bad/var/lib/docker/btrfs
> /mnt/sub/root-volume/@/var/lib/docker/btrfs
> 
> You need to repeat this for any other subvolumes found in the first sub
> list command.

OK. What is their purpose ?
> 
> Reboot

OK. Thanks, i will try that and keep you informed.

Bernd
------=_Part_80084944_251108864.1622040830129
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
CQUxDxcNMjEwNTI2MTQ1MzUxWjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCBooKI8ZNnPaivkIZufjb3v5RYtA6Z0i0PmKwv2TlNg
vjA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQA59ScBzmZ5fw/DCChQtpVQCVd7Eg9oII+PgIhLq0loUPcNqOo0ZtBj
ZH8ywSjfOAgrepgO30Trzv4dy1v8uF2JttJgOoRW7ClzMNHGd5N5ica+xZyAIsv2f4Lebo42JAVO
IeLx3thJS02+6hHc/Hh+oUMjgPKZzbPHzh7xc7oZcr3bKTO0t330IHpBHUV0/n8KQj5QBRxgpxCA
BYE9zbT3NT52ITPcJIhanH25mGS/9m2mBHG7vx2ahD9RWgW7Vho8ahgbNcMjj0xwpD5jdvmdj8W0
s8N00Tv7hj06c2JMRNGwhLadpKjWGzSpUJtil8vUl5tAQUPE6EHxkLvvIgHYAAAAAAAA
------=_Part_80084944_251108864.1622040830129--
