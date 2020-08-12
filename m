Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB68242DBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHLQ6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 12:58:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:54049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQ6T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 12:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597251498;
        bh=r8CkYY/epfo1JCQITS/8JwqDTurcrc2syxiM4z90NzM=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=MkSml0+xpp4Xphvw0xLwQtGivgcbPsnMIWmyOZFpdwXmYE0GGQbBnQbnf9nnH3jkj
         kOWRDePYSOLa8RRxdnAIA5f8oIbQvtW+M3B7q0yuu8cHDakKx7/UuXgYuc4lIuStPa
         ODCC2I4EYDZ99u3z/0jzKzJEPIWwXvGumNHdJZ4U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from BenjaminPC ([77.109.173.80]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1kDyZD0kFB-00Rmv6 for
 <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 18:58:18 +0200
From:   <benjamin.haendel@gmx.net>
To:     <linux-btrfs@vger.kernel.org>
Subject: Tree-checker Issue / Corrupt FS after upgrade ?
Date:   Wed, 12 Aug 2020 18:58:17 +0200
Message-ID: <004201d670c9$c69b9230$53d2b690$@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdZwybiKa8CAZs0bSIShgo7HGNEzTw==
Content-Language: de
X-Provags-ID: V03:K1:497G7/wjGE7Re2lmzayw57XaFXnbK1I2TBSVWzd57Yc9k4p9ZEl
 ftce0AmFTrlBOi2rP+Z0vU1QNpNW2oXLOfZyaRZD9id69IJ9nsH4zBi95jsDp7ytUN0NvEQ
 lTB8sqaFUk4lanZu1dfSEsDyvRHziAfIyNboy3mneZ2w7N/crx/TKsSaXPUGdZx3abdrCeA
 PqMhqRB2oSf1Af/47npCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tdtVA1HdK4U=:y13Q+BaUfm6cVDXt9QBJAE
 AEeQHDLwiuw0Bg7nfna5FebItk0+3UX9Jf29eF6STW4JXpTRC0W0EJjR5xI5YqJJk/M/zcn1p
 msPlbg4hcSuTHS9CSJEbJCl1j8pXJCljQb14u0GRHRgyXkv17lnTjHoyxsjmnEPzHYSgjnpLH
 CdPbcelkNZMOobgm08O3SBBJWjDBjb0/i5KGZMRNTS/4jPXPs4bdi8QHbgP+b6NGjp7VrdzL1
 M8D7A1If3qBwFWW7id9k0fNm3aAygA4cdYst6i0hWgdeoFQ0KEyh1Ma+Rbx3rvKLTAqVuSnqf
 35TaSDuD+dikYK0Bf9rJsSciNF4jpfl5f88BIZP6g+d4uUrD3HX+9EXJlKTtddCKnFBVVjzkp
 9yuTrI4mHZ2QmJ0aBdJwNx+gs4Ub8Tzz83vShwAG6DeqW/xXMKyMamzm/iJNiqBAHZdtYOEW7
 vAcagUr58p3MOiGMYJYDZfeXfM5wHle0xqcw2ts9z/AifqHzjsb5CEoKAgEGBFKSKo5DM/3kh
 MLiQLQSk7drW03oHn9y0Igt5Iv9xiwTC6/6E4+uKRKNXXT8LQfpC22UEPmzyIHGmX3bHKesQn
 q5Kdl6t4g5ct6QDrNTiTHloW9VB5FkXzetoXhl2M7XJhxtgMOtlj5TqnHG76WtzZObvWLk+IJ
 VF0pWOIkoVZQEZKYIRKt3gs6Rqxj3ygnHwnFeU1nNlriMd4uNJe1MK8HoFAZMSUOphbTtSZaT
 wF5W1mQQGlj52QoYSoCkKCfUC8tXApfYs7MO2ov8WBTR7dXpCqBlOtTaLp3BpYt0uqLafC70W
 HpnMHwXKIjMa4b3w+m0DhqFi3hP3A5/yde0N+CfH8RCLymaIDHBGEqVabjTgZpYGeTbOXExOL
 PfFAuaIh819nN8o8qpQHRh8vrL9xK8Armd65dAdq3+HGpOcidV54trK0tXJvlWOCNcQzuyKe4
 7CLOH+eG4xRHMLgMkiex+lWnU/sBRaPinDsHoGGticC3egF7upGc05BCIq3hGi3xwOz1sF5WI
 IlzYc5T8Sr/6jsFZyav9c/vf6NaQipvN8QXiz3fJ5SEDdgHt/+C/9i3Jp+5CJt7wJLYxIpHns
 wPfN85VJlaLtyAez5jiEaUT+wfhj3fmMsbSuEwVgU4hygVl+SYfffwTl+WYE7gkPOjL1suHR+
 B0jTgLEMtCSnlx1PXmw3UckQQ49lJ4MftDE3DTodsHV6ve9Ln8s4Rs9z5WdlcgypF3yux8Or7
 rFxmnfXov654iyqcCdjFc/JJ8sqhMMz2Uw6Zawg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

i have been running my little Storage (32TB) on a Ubuntu 18.04 LTS =
Machine
with btrfs-progs 4.17. I then did my monthly upgrade (apt dist-upgrade) =
and
after a reboot my Partition could not mount with the error message:=20
"root@Userv:/home/benjamin# mount -r ro btrfs /dev/mapper/Crypto
/media/Storage
mount: bad usage"

I then proceeded to run a btrfs check which gave thousands of errors and
then also a super-recover:
root@Userv:/home/benjamin# btrfs rescue super-recover -v =
/dev/mapper/Crypto
All Devices:
Device: id =3D 1, name =3D /dev/mapper/Crypto

Before Recovering:
[All good supers]:
device name =3D /dev/mapper/Crypto
superblock bytenr =3D 65536

device name =3D /dev/mapper/Crypto
superblock bytenr =3D 67108864

device name =3D /dev/mapper/Crypto
superblock bytenr =3D 274877906944

[All bad supers]:

All supers are valid, no need to recover

I now checked my dmesg log:
[45907.451840] BTRFS critical (device dm-0): corrupt leaf:
block=3D22751711027200 slot=3D1 extent bytenr=3D6754755866624 len=3D4096 =
invalid
generation, have 22795412619264 expect (0, 207589]
[45907.451848] BTRFS error (device dm-0): block=3D22751711027200 read =
time
tree block corruption detected
[45907.451892] BTRFS error (device dm-0): failed to read block groups: =
-5
[45907.510712] BTRFS error (device dm-0): open_ctree failed

Google inquiries to this topic led me to this link:
https://btrfs.wiki.kernel.org/index.php/Tree-checker
It tells me to mail here first so thats what i am doing. I kind of =
suspect
since everything worked perfect (Memtest also no errors) before the =
update,
it has to do something with that update. I am wondering if it would help =
if
i deleted my OS Disk and reinstalled an older Version of Ubuntu, like
16.04.6 LTS ?

Since then i upgraded to 20.04 LTS with BTRFS-PROGS 5.7 as a lot of =
forum
entries said it would be wise to use the newer versions as older were =
buggy.
That brought no help as well.

Since i am no Linux/Unix Expert i thought it might be better to ask now
first as advised in the link above before proceeding with any other =
plans.

I find it hard to believe that all data is gone, i feel its buggy =
behavior
as the partition and everything is still there:
root@Userv:/home/benjamin# btrfs fi show
Label: 'Storage'  uuid: 46c7d04a-d6ac-45be-94cc-724919faca2b
Total devices 1 FS bytes used 28.23TiB
devid    1 size 29.10TiB used 29.04TiB path /dev/mapper/Crypto

Best Regards,
Benjamin H=E4ndel

