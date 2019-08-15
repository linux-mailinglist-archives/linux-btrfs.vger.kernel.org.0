Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3878EE9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfHOOq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 10:46:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:38855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOOq2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 10:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565880361;
        bh=wagrL2ArP7JbB12WsOlCVpG57pD0gmdCjCOgS/xGD5A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WyBze8fqeTMZLtHLItiT7ycuML61jX8kKFuVzXFh8a403imvAX/ln4nhdpMnTsmZe
         pxoOheixQaiV/uODnkbUdsJP3LQ7pCaTJOUk1DQb8OrUXNhxd79xsSO7EhWWT6KxWP
         CKiyxB7x90YFYJ8tECANl6tyLfVymIA0CqkD9lFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1hhReH1ALN-00LBNn; Thu, 15
 Aug 2019 16:46:01 +0200
Subject: Re: recovering from "parent transid verify failed"
To:     Tim Walberg <twalberg@comcast.net>
Cc:     linux-btrfs@vger.kernel.org
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
 <20190815135251.GC2731@comcast.net>
 <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
 <20190815142105.GE2731@comcast.net>
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
Message-ID: <1ce8ace9-b86a-19fb-0b4c-f6315c8e73b2@gmx.com>
Date:   Thu, 15 Aug 2019 22:45:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815142105.GE2731@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bJYcnJ2MeH7djPcuKID2FLBGjs9HxnevU"
X-Provags-ID: V03:K1:oFUDqXJOFT0+XYS5dEPBxpE49XR7LTuaZnJEy7Q2EdJ5nADf7Ap
 uyDaluiWYoFv25uPM4TnCogb9LjBKfxngBgbIxCthd5s5p80voSxp7m4LnuJ1JUPbjrxEda
 uXpiZHItnbMbxGnk93I+ZkeZZuoWazkcpgpWGu24b20pH4D0AQiVk06kX0pTbCx6Xm2DBpP
 LTzSuWoEEN+joK1xcErCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zA+Dyzel+Ik=:VF/DuIQKSpWU+wwvZqgx0Q
 Y89mKqj8ldcVTq3BsmpNLBCVQWOmZDE4i6D/7oVaGEB19kwvsUd9YzdW3Yddl6aCcjfr6nmsN
 a+cQxGG3lY7QF7zRtnf6x9iqBWlBEDRr+VYUPtuwOdWxSYDPLMhlDQrovlysDF+jkdZNS+jdi
 kV+qyL65mLGrcY7MU25tDLOat/T2wx9KQffTXkk/BIPd5Fv19gIsu/HvgIf5UQtXlN4hA/E0L
 iwN0ulKEJrnL4dUiPLFGYJetnB9P5HaP2GvcQKFZKkvfDaMBeSuF3SOG2LUAwB3HvbdDBlT5F
 UWUwfT3FTmXYD3OMStVj8QhkT8jsOdHx+Ki/+HOqQrs8jTvFq6uwBfnWXh3MqgpzDxB8TtGWp
 8mQkvhosONLJZaQcWWVjXqGsIV20T1V9iRADDhPyWJF6HJEDMoOo6iksPp7iyZQEZGNf8/8IS
 LocTo2GJDSOnuVqfiGtKaDYk0LvvMw7rtVU3b6Kvwo0yzKCPsu6BPqr9sdOcLSuXo67nIH7jl
 EbbIFg0LvKnq1I5zWDr4rD/b7tD3J3+og+hFrEDdeOv0ZaOtEmVx6IAuj/VZTtdnZFvu2/nqw
 IZFDt3t+TxfTO/k9LUVV+n54GL41kuT7z3hUqrh0kfHgRyCOe+gIXcFkce70m8OOZkD/68GVA
 DAEdQTXkAoa8PnJPcPGojm0qx1g8RG9UOlAM3C4utCiABLSa536nhflvrGZ1ORaFBiKY/2SQe
 jTkPPiDz49nRgGuzr98VnL76zeInGln2pclZxIknvaNQ+r/3l7kfLH9P0In8zNGo3CMnfQJZ7
 /mB1xi/P3bXxkXh8+s+BKQ9uKUQnl4pPJBL4cwLfYktiYCs/w62tOyvVxHvQ2yk7oKO7JUYsq
 lTOXLuov3KlOmsL3yRV9GheSxMBTYaCEDREx6RjPPpvNQxjtxoWPqsunOR/2rvcKMWgTh7x7d
 hz7W6D3yaUcv5tSSfyFKdmH/rpQejO+P1QLKMkTSl9JK8+hgEmF38jW8CF2fwpEei6Dv0pYD3
 PeuvpE6FkDDOaqQqN76mJJOdyg850aenTjXhwLchqw6LeyaBAQWO4VIVh8kdKKIV6jX0cHODT
 7F26B6pnxhNIUIeapBfiDA4eOilOwSnNQN6C9zi0zdoTr7DOiw+z7x/GQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bJYcnJ2MeH7djPcuKID2FLBGjs9HxnevU
Content-Type: multipart/mixed; boundary="VCmgluOMF22ONX1GdTS6aE5U5G1MV4wXC";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Tim Walberg <twalberg@comcast.net>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <1ce8ace9-b86a-19fb-0b4c-f6315c8e73b2@gmx.com>
Subject: Re: recovering from "parent transid verify failed"
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
 <20190815135251.GC2731@comcast.net>
 <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
 <20190815142105.GE2731@comcast.net>
In-Reply-To: <20190815142105.GE2731@comcast.net>

--VCmgluOMF22ONX1GdTS6aE5U5G1MV4wXC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/15 =E4=B8=8B=E5=8D=8810:21, Tim Walberg wrote:
> 'dump-super -Ffa' from all three devices attached.
>=20
> 'btrfs restore' did appear to recover most of the main data, minus
> snapshots, which would have greatly increased the required time and
> capacity, since I was recovering to XFS.

That's why I recommend that experimental patchset, it will make the fs
mountable (RO though), with all btrfs snapshots available.

>=20
> 'btrfs rescue chunk-recover' ran, but failed to fix anything.
> 'btrfs rescue super-recover' says all supers are fine.

Those are useless for your case.

>=20
> Initial corruption was due to a hard hang, which didn't leave enough
> crumbs to determine the source - might have been btrfs, might have
> been nvidia, might have been something completely different.

Anyway, the corruption is a little strange.

First of all, even hard hang/power loss shouldn't cause btrfs to
overwrite its tree block, thus even hard hang/power loss happens, btrfs
should be corrupted.

But that's definitely not the case. (We have quite some such report, but
haven't pinned down the cause yet)

Secondly, the generation of your fs is strange.
The latest geneartion of your tree root is 49750, matches with your
corrupted tree block, but your extent tree is definitely older.

So it looks like, your super blocks (all nine!) reach disk before some
tree blocks reach the disk.

Finally, the superblock doesn't record previous transaction correctly.
It doesn't has transaction of 49749 in its backup roots.

Not 100% sure, but looks somewhat like the problem fixed by this patch:
Btrfs: fix race leading to fs corruption after transaction abortion

It should get backported to all stable release recently.

Thanks,
Qu

>=20
>=20
> On 08/15/2019 22:07 +0800, Qu Wenruo wrote:
>>> =09
>>> =09
>>> 	On 2019/8/15 ??????9:52, Tim Walberg wrote:
>>> 	> Had to wait for 'btrfs recover' to finish before I proceed farther=
=2E
>>> 	>=20
>>> 	> Kernel is 4.19.45, tools are 4.19.1
>>> 	>=20
>>> 	> File system is a 3-disk RAID10 with WD3003FZEX (WD Black 3TB)
>>> 	>=20
>>> 	> Output from attempting to mount:
>>> 	>=20
>>> 	> # mount -o ro,usebackuproot /dev/sdc1 /mnt
>>> 	> mount: wrong fs type, bad option, bad superblock on /dev/sdc1,
>>> 	>        missing codepage or helper program, or other error
>>> 	>=20
>>> 	>        In some cases useful info is found in syslog - try
>>> 	>        dmesg | tail or so.
>>> 	>=20
>>> 	> Kernel messages from the mount attempt:
>>> 	>=20
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): trying to use=
 backup root at mount time
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): disk space ca=
ching is enabled
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): has skinny ex=
tents
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent trans=
id verify failed on 229846466560 wanted 49749 found 49750
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent trans=
id verify failed on 229846466560 wanted 49749 found 49750
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): failed to re=
ad block groups: -5
>>> =09
>>> 	Extent tree corruption.
>>> =09
>>> 	So if that's the only corruption, you have a very high chance to rec=
over
>>> 	most of your data.
>>> =09
>>> 	Btrfs rescue can work, or you can try the experimental patches which=

>>> 	provides rescue=3Dskip_bg mount option to allow you mount the fs RO =
and
>>> 	receive your data (later is way faster than user space rescue)
>>> 	https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D1306=
37
>>> =09
>>> 	Also, for your dump super output, it doesn't provide too much info.
>>> =09
>>> 	You would like to use -Ffa option for more info.
>>> 	Also, you could also try that on all 3 devices, to find out which on=
e
>>> 	has lower generation.
>>> =09
>>> 	Also, please provide the history of the corruption.
>>> 	One generation corruptions is a little rare. Is sudden power loss
>>> 	involved in this case?
>>> =09
>>> 	Thanks,
>>> 	Qu
>>> =09
>>> 	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): open_ctree f=
ailed
>>> 	>=20
>>> 	> Output from 'btrfs check -p /dev/sdc1':
>>> 	>=20
>>> 	> # btrfs check -p /dev/sdc1
>>> 	> Opening filesystem to check...
>>> 	> parent transid verify failed on 229846466560 wanted 49749 found 49=
750
>>> 	> Ignoring transid failure
>>> 	> ERROR: child eb corrupted: parent bytenr=3D229845336064 item=3D0 p=
arent level=3D1 child level=3D2
>>> 	> ERROR: cannot open file system
>>> 	>=20
>>> 	>=20
>>> 	>=20
>>> 	> On 08/15/2019 10:35 +0800, Qu Wenruo wrote:
>>> 	>>> =09
>>> 	>>> =09
>>> 	>>> 	On 2019/8/15 ??????2:32, Tim Walberg wrote:
>>> 	>>> 	> Most of the recommendations I've found online deal with when =
"wanted" is
>>> 	>>> 	> greater than "found", which, if I understand correctly means =
that one or
>>> 	>>> 	> more transactions were interrupted/lost before fully committe=
d.
>>> 	>>> =09
>>> 	>>> 	No matter what the case is, a proper transaction shouldn't have=
 any tree
>>> 	>>> 	block overwritten.
>>> 	>>> =09
>>> 	>>> 	That means, either the FLUSH/FUA of the hardware/lower block la=
yer is
>>> 	>>> 	screwed up, or the COW of tree block is already screwed up.
>>> 	>>> =09
>>> 	>>> 	>=20
>>> 	>>> 	> Are the recommendations for recovery the same if the system i=
s reporting a
>>> 	>>> 	> "wanted" that is less than "found"?
>>> 	>>> 	>=20
>>> 	>>> 	The salvage is no difference than any transid mismatch, no matt=
er if
>>> 	>>> 	it's larger or smaller.
>>> 	>>> =09
>>> 	>>> 	It depends on the tree block.
>>> 	>>> =09
>>> 	>>> 	Please provide full dmesg output and btrfs check for further ad=
vice.
>>> 	>>> =09
>>> 	>>> 	Thanks,
>>> 	>>> 	Qu
>>> 	>>> =09
>>> 	>=20
>>> 	>=20
>>> 	>=20
>>> 	>=20
>>> =09
>=20
>=20
>=20
> End of included message
>=20
>=20
>=20


--VCmgluOMF22ONX1GdTS6aE5U5G1MV4wXC--

--bJYcnJ2MeH7djPcuKID2FLBGjs9HxnevU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1VcCQACgkQwj2R86El
/qh0iAf/WUeVLuqqIb68sUCFgRX82V+kTZ89vEEEgrzhpQ19SBhxa2u2iX+Jq9xX
s+lNUFiuOI8GCagTp9Y+1HwIQqRLSRT4IyKojbgenuT/+//P0wJSG/LN9/fQMl/M
OUiWr1QCeRuvadgcfLLdBSAyFzA2VpayoVeCE8QI2cEWxKvU2smPQMzB/ohpoNqD
PbPy/pg/zU9eeE9VIybpiB3TlShKn1Z2rkvESKn15Zd/D9nKSqJAUicPMYFB62tb
2a+02TTu2JwuUoV0eXmmPy1rJ3L0ai3dFDOf8qFjE3kVOsPFkFFUDjB95ofB/5NH
Pg7c/Wxxu3N0UzIn7L1sNfv9fUT+Ng==
=IotF
-----END PGP SIGNATURE-----

--bJYcnJ2MeH7djPcuKID2FLBGjs9HxnevU--
