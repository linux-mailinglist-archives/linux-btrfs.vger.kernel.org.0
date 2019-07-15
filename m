Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3607A681FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 03:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfGOBHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 21:07:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:57609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfGOBHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 21:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563152850;
        bh=2ob330LC4JT69wFlqFbMFAEJBRJrvRPyDZcFxCZwzEk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OTgNkGkfoQERD9izuVgYeX9c2h2jcmojn82yIS39BRWbHIcUHOASTQ9X2AZypuCE/
         cDInYfGhLlc47bP5a19l8TsD2TEJMl3daZgHuz8nRmbOrAsIQVUThSivBP9jf1C3d3
         fOmIec7RSyasYgcNb9GSJROxRKULCCSUODs5DtcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MYg42-1hzQdX3IPq-00VSZ2; Mon, 15
 Jul 2019 03:07:30 +0200
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Alexander Wetzel <alexander.wetzel@web.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, wqu@suse.com
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
 <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
 <CAJCQCtTNrF-Oj_WQ71_ApRRpVikwdG7mYW4iiz2iA+N1AAWkmQ@mail.gmail.com>
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
Message-ID: <6f7968ec-af22-77e9-a8e3-e58a385b53cf@gmx.com>
Date:   Mon, 15 Jul 2019 09:07:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTNrF-Oj_WQ71_ApRRpVikwdG7mYW4iiz2iA+N1AAWkmQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="asbWAXbz8atvaPQYRV4hM43CZMVM4mWVd"
X-Provags-ID: V03:K1:wJIhOaUOltXmVYGLK0sqRV2m/egGdYwJotXW+/vj49pInlIxSrj
 eHBx1mBBQIQXI85BuK5/Eoe6S8tOFzGopbcteS3ZwZtON8zynKWs+km1PdtMY92L1YBF8ol
 CQ7eu7nB2Aqh+PKpobrr4y5/6Lvek80OZeGlQpewpfPSk8pQYger6pONYh1klr9B4VvyLp3
 zlhnK4Og2HNJn/QKtaYSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WgiBfCyHlCk=:RoovsyldoOXzIznlcgDmFn
 o4SHe/fwkQIApRNToeu6m0SvjM4udIN+VRhwNdisbU6SY9Pm9tKniQFSZm9K42/ydHXLc17tE
 G+kiIIawlER9ec7AgkkNybCmti7HMrPeg4d682b8Mm5EuXVjdgJLdg5yoQCGyZdTlov/qv/3q
 pxW0aCh0HX45BrRJS+taS5o2lbynQ4q+zFCMrj+2r3fvTEBt87+boy4wCsS8UJoqSdabjg3sx
 V+bIfxr99ed5ti+QGL5rS5rZSv90P6KzRcEuf7xoIEHc+CKsMUrhG141gLeBLlylhNOMLKmfI
 mjkPNOf0ZWGYxoThEJzzjCn+xQsVDxMOvl9VAuDnEiXX2FRspe3+gju6U/ask1lBcr67/n0Zm
 Sjh6OI2bE2HcjOn9MfsUgCMECa5lZ5Iptwka0s4F9xnl4UniNZ7VgLCqNdC/WNs0tUAODbAC5
 oAFFHiM8Y8EC95N9bNP2ZEHwYFkhnzOP+roklnE4uC0qGot3lHcISOEv0M/Kt+jEIH5OPwobE
 dEFaWsgsiaB5HXnrQaCWDEidMSmZh2cwrms/V+Jl6VmzWno3Lm6YeWhdYMMQ2zcehPRkh8BvR
 PjXGAsWHWHC9PIOVm6YORzT3otK/Afhr054yMvAs57QlHQykRP+9bY+tZwf1MJ5hsnQFmOXJh
 n7w48GebhrtmGGMWowbyhNGg6jyOT2fg72WJsTrtE5ClzxBipuOqHWzdY2907aqXPB8/Prp0p
 6ALxQZq+d1JmdsN4RWRTqPD6q74+dRSqVcUtgnEtvfjgJ5koxSA98N5DTiOJ6fN68mFYm0cwt
 KwYThrNNdLoGzLAYs35epVIjdXWYJgr3ec346j8J5sOqjRIOWpBvKGy3T/as3Sjf6C0qeAVIK
 4GjfWe/1KGM2Y5TyE+FxoyAVdNG8kU7C/AORXz0vtOee5GacZzGwPdiQmChs+QmvL8f31Obm+
 YhWcHCjzO1QFXpVdEnfDB6MYj2Kce3foPKNv4h+EPEujMlQ/kvwXJMiBAc7QP0SAGRiq3FgNi
 +XO0c/R2EgPWBEUIiPsisu47O34xJbW/pc/W4wxujPCuZwJhX0ImHPnuRgGvrS4Em2lZvIrKb
 Fze9dNiM24jyQ0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--asbWAXbz8atvaPQYRV4hM43CZMVM4mWVd
Content-Type: multipart/mixed; boundary="VUbJe72XqvIYbK46L7VWOq6S50jjXWAx0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chris Murphy <lists@colorremedies.com>
Cc: Alexander Wetzel <alexander.wetzel@web.de>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>, wqu@suse.com
Message-ID: <6f7968ec-af22-77e9-a8e3-e58a385b53cf@gmx.com>
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
 <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
 <CAJCQCtTNrF-Oj_WQ71_ApRRpVikwdG7mYW4iiz2iA+N1AAWkmQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTNrF-Oj_WQ71_ApRRpVikwdG7mYW4iiz2iA+N1AAWkmQ@mail.gmail.com>

--VUbJe72XqvIYbK46L7VWOq6S50jjXWAx0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/14 =E4=B8=8B=E5=8D=8811:40, Chris Murphy wrote:
> On Sun, Jul 14, 2019 at 3:49 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>> I totally understand that the solution I'm going to provide sounds
>> aweful, but I'd recommend to use a newer enough kernel but without tha=
t
>> check, to copy all the data to another btrfs fs.
>>
>> It could be more safe than waiting for a btrfs check to repair it.
>=20
> Does the problem affect all trees? If so, then merely creating new
> subvolumes, and then 'cp -a --relink oldsubvol newsubvol', and then
> delete old subvolumes, won't fix it.

Not 100% sure yet, but from your dump, it's affecting INODE_ITEM and
DIR_INDEX/DIR_ITEM.

For other trees, only root tree and data reloc tree has INODE_ITEM.
They may get affected but shouldn't be a problem.

>=20
> I wonder where the ideas are for online or even out of band fsck.
> Offline fsck is too slow and does not scale, a known problem. And both
> copying old file system to new file system; as well as restoring
> backups to a new file system, is astronomically slower because data
> must also be copied, not just metadata. Also a known problem.
>=20
> What about a variation on btrfs send/receive with --no-data option, to
> read out all the old metadata and rewrite all new metadata to the same
> file system, taking advantage of COW, but without having to copy out
> the data? And then after all of that is done, delete the old file
> subvolumes?

It looks possible, but the use case also looks very limited.
Just the case you're hitting, not a generic use case.

So I'm afraid it won't be possible in short term.

Thanks,
Qu

>=20
> Or a variation on seed/sprout, without requiring additional devices.
> The seed part "snapshots" the whole original file system (all trees),
> and create two read-write file systems: current online mounted volume,
> and in-progress offline repair volume. If the repair fails, it's
> straightforward to clean up everything while retaining the changes -
> at least it's not worse off. If the repair succeeds, then there'd need
> to be some means of merging the two read-write file systems - that
> could be complicated. But even if in the short term that merge
> required an unmount, and perform the merge offline, that would be way
> more tolerable than the way things are now.
>=20
>=20


--VUbJe72XqvIYbK46L7VWOq6S50jjXWAx0--

--asbWAXbz8atvaPQYRV4hM43CZMVM4mWVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0r0c0ACgkQwj2R86El
/qiduQgAlEX0ftM2VKWaZKDItagl9ke0h22NNOM19Kv84dpb5LquvQfIqvsV07Yl
69PqhxaexkvqjIFMVKFP0E5CVN8IxwNee4lcCfe27En+A18gwFu9/1Ns5+d1dcqf
3qCglQBw1w8PQqyj4nNczYTdSUGc65635/u6ZWFbJIV4KqWCyHIoceRdIR2+q6SY
sqHEgOQUKhDjZzhhMPnZHpsrd4NDgn4A3mQRfksOI1cxsjRRAhO4ExdzCYHBSJPa
Qi/Qgooj35sJz8iUB2IgRDCA+tIhzDbQodhPHCVfBlW6jeLh39t2y6qqCMIbNt7j
soc6v1ALgu5i6+sCTGx7jCRW7WQQ2Q==
=IxTi
-----END PGP SIGNATURE-----

--asbWAXbz8atvaPQYRV4hM43CZMVM4mWVd--
