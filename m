Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80967CA2
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 03:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfGNBaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 21:30:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:53947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfGNBaP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 21:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563067808;
        bh=BKPMk76Xe2CM8/1xXYCuxdNWF+ny24fHVVcDhh7GGXw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BL463Hj5ztWrTF6XTUACBnJJq6TGlOECdre/SQpFSo79J9qjjfqIXKvukBd3wIQYt
         1/OGC7gkQbxpnFaRtwZHDHczNvgmcc4BG0ByaQ2Kccg4f5p9739/xV/Ch8VDiWrx24
         VAfSbDAO9AZ/k6OAgBytNSmViJLzedhYY9YKq6Fo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MKpQ4-1hmTL50KNU-0000WU; Sun, 14
 Jul 2019 03:30:08 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Alexander Wetzel <alexander.wetzel@web.de>,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
Date:   Sun, 14 Jul 2019 09:30:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gCWZNd8M2loc9BCSDq9FUYZnzqqTtjxb7"
X-Provags-ID: V03:K1:KLeSVxWHcFnVMALAzVCEoAJ4IwKcpyzWBhJI3B2/0/RQWQM+u0U
 apCIN5thKXrQE/j9zog4skDNG78W+e7u84udKFh6gXJ4+Y+v2P7ANJCjRuiIRFOs2lwknBB
 8J10DlSIXHuCKWcgXEJI6Q8at9DehWR5OiKaMCsULNiBZb8x+ptpcCqo7C4d4ieBVi9pP2b
 dHyoRrrm9nnUbqwjy1kig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKGRGhMYswk=:cIGO0BzwZMHNbfuA9yusf5
 ZyUzctyGZmpgNL4kW7OeIkWyzBijypuGFgjsOLJ2Bx/eQVSupLn1Ftb+x+5fckK7EERbwOE8Z
 4iMBaplyIRSUczBtKGv2C+Z8QgFfncwV0t79FJ5iqeRM0erCiZWAPSHUi3Xf958pCRV6ph9bM
 Lh942l7VHrGUpTxlQD1J5xMP3fOXEt1AjzO+7WulH1EX+SYwK+jdYaacfIvV32V10URnxsbwD
 sJZtN10hzIpUkL92SWJ4dEMYco+hL33m/btZ+Kw57GDQAphzmLy/8/jUtZe8aB6FEexEX770Q
 P6+RKQ6Ulrdm7/8YjtYL15CDchzvOihtdH3/iJlrrBoD06Y33Azk8kdlIjJuefnko2GjE/xx1
 Konxwnv+JAoekwXnWNH0RcBnw/7dJHudBLaCBSYqMc6ZZuN1jmzoc4ov2rxA9fpi5IwFLHar9
 PzoJ93Si+wmhV5CyHBe7wxKJ62TDcJ6a1VMhavUG9czSOTWWEQQPfSOaOUKHdLa3Ov4qAzWe3
 7Upcvsmo91lGq5kOffarumbAmSPy7x8crsGTxmGBMkt5LSQmrc4ql8HzkjdfjM8D32QAZyBeS
 zTDxe3cD8adVB/BAzJRbpAA6+u6tO34MR04Gq/0k1kqh9dF+3uU4nWiXgv9NQPyKv49C/dbCY
 Wv//6RqLscwTAKtryM+PWeWLeTgjX346vrYe3A0HyU+SKif0wY32Iw9sz3VP/0VirubFl3Y4j
 eyb39CWFFfhzSarPsPpsjvdvY7zTlcccHBzCwMnHpK5xXPKn5EEIK+YNiETwRwKU+Wv2tvq57
 3tShsciq3QIUJNBMtXRFZj+3aP0SQSuRpEJEBc+l6hbLZD5bTt8grLUmvaBquWmy3l4honv0h
 IE92hjLJc7y4kRDuwf/tDipR76Jk/MkMFddMOcr30Oe+LlreurdCWU4gl2ydg4AQOM2GxKIRY
 rZU+l5xDfj5pE1YM5um70yw14ryKHdavD4otWrRYFtxpOj/QtI69CvoLx+dQuIrh5h78HPopd
 VPobaKdN/HTPHidOFGDpnrH421OP1wYv5Eopr+9lMqlgU5+qVEqvwyueFbluqvaqkUWLsndNc
 Awo5ZDhMJjEAX0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gCWZNd8M2loc9BCSDq9FUYZnzqqTtjxb7
Content-Type: multipart/mixed; boundary="yxOruhrNGFzWgv6RUF9ojpel7cPpczqtV";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Alexander Wetzel <alexander.wetzel@web.de>, linux-btrfs@vger.kernel.org,
 wqu@suse.com
Message-ID: <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
In-Reply-To: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>

--yxOruhrNGFzWgv6RUF9ojpel7cPpczqtV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/14 =E4=B8=8A=E5=8D=884:48, Alexander Wetzel wrote:
> Hello,
>=20
> After updating one of my VMs from 5.1.16 to 5.2 btrfs is acting up stra=
nge:
> The system is using btrfs as root (also for /boot) and has compression
> enabled. (It's a gentoo virtual machine and not using an initrd.)
> Rebooting the system into 5.2 is able to bring up openssh, but not othe=
r
> services (like e.g. postfix).
>=20
> Redirecting dmesg to a file also failed. The file was created but empty=
,
> even when checked immediately. Rebooting the system into the old kernel=

> fully restores functionality and a btrfs srub shows no errors..
>=20
> When running a bad kernel the system is partially ro, but since I'm
> using selinux in strict mode it could also by caused by selinux unable
> to read some data.
>=20
> Here how a reboot via ssh looks for a broken kernel:
> xar /home/alex # shutdown -r now
> shutdown: warning: cannot open /var/run/shutdown.pid
>=20
> But deleting the "bad" kernel and running "grub-mkconfig -o
> /boot/grub/grub.cfg" works as it should and the system is using the
> previous kernel... So it still can write some things...
>=20
> I've bisected the problem to 496245cac57e (btrfs: tree-checker: Verify
> inode item)
>=20
> filtering for btrfs and removing duplicate lines just shows three uniq
> error messages:
> =C2=A0BTRFS critical (device vda3): corrupt leaf: root=3D300 block=3D86=
45398528
> slot=3D4 ino=3D259223, invalid inode generation: has 139737289170944 ex=
pect
> [0, 1425224]
> =C2=A0BTRFS critical (device vda3): corrupt leaf: root=3D300 block=3D86=
45398528
> slot=3D4 ino=3D259223, invalid inode generation: has 139737289170944 ex=
pect
> [0, 1425225]
> =C2=A0BTRFS critical (device vda3): corrupt leaf: root=3D300 block=3D86=
45398528
> slot=3D4 ino=3D259223, invalid inode generation: has 139737289170944 ex=
pect
> [0, 1425227]

The generation number is 0x7f171f7ba000, I see no reason why it would
make any sense.

I see no problem rejecting obviously corrupted item.

The problem is:
- Is that corrupted item?
  At least to me, it looks corrupted just from the dmesg.

- How and when this happens
  Obviously happened on some older kernel.
  V5.2 will report such problem before writing corrupted data back to
  disk, at least prevent such problem from happening.

Please provide the following dump:
 # btrfs ins dump-tree -b 8645398528 /dev/vda3

> =C2=A0BTRFS error (device vda3): block=3D8645398528 read time tree bloc=
k
> corruption detected
>=20
> All there errors are only there with commit 496245cac57e, booting a
> kernel without the patch after that just works normally again.
>=20
> I tried to reproduce the issue transferring the fs with btrfs
> send/receive to another system. I was able to mount the migrated Fs wit=
h
> a 5.2 kernel and also btrfs scub was ok...
>=20
> I tried to revert the commit but a simple revert is not working. So I'v=
e
> just verified that a kernel build on 496245cac57e shows the symptoms
> while using the commit before that is fine.
>=20
> I've not tried more, so I still can reproduce the issue when needed and=

> gather more data. (The system is now back running 5.1.16)
>=20
> Now I guess I could have some corruption only detected/triggered with
> the patch and btrfs check may fix it... shall I try that next?

Sorry, AFAIK btrfs doesn't check as strict as kernel tree-checker, as
corrupted data in kernel space could lead to system crash while in user
space it would only cause btrfs check to crash.

Thus I made tree-checker way picky about irregular data, it's literally
checking every member and even unused member.
The dump mentioned above should help us to determine whether btrfs check
can detect and fix it.
(I believe it shouldn't be that hard to fix in btrfs-progs)

Thanks,
Qu

>=20
> Here the dmesg from the affected system (the first few lines still in
> the log buffer when I checked):
> [=C2=A0=C2=A0=C2=A0 8.963796] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 8.963799] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
> [=C2=A0=C2=A0=C2=A0 8.967487] audit: type=3D1400 audit(1563023702.540:1=
9): avc:=C2=A0 denied {
> write } for=C2=A0 pid=3D2154 comm=3D"cp" name=3D"localtime" dev=3D"vda3=
" ino=3D1061039
> scontext=3Dsystem_u:system_r:initrc_t tcontext=3Dsystem_u:object_r:loca=
le_t
> tclass=3Dfile permissive=3D0
> [=C2=A0=C2=A0=C2=A0 9.023608] audit: type=3D1400 audit(1563023702.590:2=
0): avc:=C2=A0 denied {
> mounton } for=C2=A0 pid=3D2194 comm=3D"mount" path=3D"/chroot/dns/run/n=
amed"
> dev=3D"vda3" ino=3D1061002 scontext=3Dsystem_u:system_r:mount_t
> tcontext=3Dsystem_u:object_r:named_var_run_t tclass=3Ddir permissive=3D=
0
> [=C2=A0=C2=A0=C2=A0 9.038235] audit: type=3D1400 audit(1563023702.610:2=
1): avc:=C2=A0 denied {
> getattr } for=C2=A0 pid=3D2199 comm=3D"start-stop-daem" path=3D"pid:[40=
26531836]"
> dev=3D"nsfs" ino=3D4026531836 scontext=3Dsystem_u:system_r:initrc_t
> tcontext=3Dsystem_u:object_r:nsfs_t tclass=3Dfile permissive=3D0
> [=C2=A0=C2=A0=C2=A0 9.100897] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 9.100900] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
> [=C2=A0=C2=A0=C2=A0 9.137974] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 9.137976] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
> [=C2=A0=C2=A0=C2=A0 9.138095] audit: type=3D1400 audit(1563023702.710:2=
2): avc:=C2=A0 denied {
> getattr } for=C2=A0 pid=3D2237 comm=3D"start-stop-daem" path=3D"pid:[40=
26531836]"
> dev=3D"nsfs" ino=3D4026531836 scontext=3Dsystem_u:system_r:initrc_t
> tcontext=3Dsystem_u:object_r:nsfs_t tclass=3Dfile permissive=3D0
> [=C2=A0=C2=A0=C2=A0 9.138477] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 9.138480] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
> [=C2=A0=C2=A0=C2=A0 9.161866] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 9.161868] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
> [=C2=A0=C2=A0=C2=A0 9.170228] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 9.170230] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
> [=C2=A0=C2=A0=C2=A0 9.214491] BTRFS critical (device vda3): corrupt lea=
f: root=3D300
> block=3D8645398528 slot=3D4 ino=3D259223, invalid inode generation: has=

> 139737289170944 expect [0, 1425224]
> [=C2=A0=C2=A0=C2=A0 9.214494] BTRFS error (device vda3): block=3D864539=
8528 read time
> tree block corruption detected
>=20
>=20
> Alexander


--yxOruhrNGFzWgv6RUF9ojpel7cPpczqtV--

--gCWZNd8M2loc9BCSDq9FUYZnzqqTtjxb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0qhZoACgkQwj2R86El
/qgtVggAp1ET5c2Vf2I8RNxscq/xW7x6jcxLUjuzN4wtKIWeyYO1sDa6QuVuwOd8
jCPMaf3uQ6wyxilryMwh085KZoFfmSHZFGxHdEn0Jc/E1iDwidtsieUzbZKUZVTT
P+2/mW7uMGU8MQVxjkTEvucsP0m/KBIAC/BzINspxMSBlLpyWpXe3sqToBFo82r/
VLmOEtPTJjxDEvy3UtEoVs8sI8TH30UVJ+D8+q95o3zYOBVH2CNUDIVhDPdxv9Ja
r4ABoZ10E/xTo/XOD+v2Hs/JMzRgLKUXqOmo8Uny9IUNbtWQOPn1lU/i/8+rjl5q
hy2CSey8oFenyyQvaLH3HbfbuYytMg==
=YUfH
-----END PGP SIGNATURE-----

--gCWZNd8M2loc9BCSDq9FUYZnzqqTtjxb7--
