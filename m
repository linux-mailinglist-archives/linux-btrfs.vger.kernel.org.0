Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB89C741CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 00:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfGXWzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 18:55:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:59065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfGXWzu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 18:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564008943;
        bh=InN4d7jUtO/yIaovxbP3RKWWy2zVYfYgWq0LQ3QVKSk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BpRWEQrkpTCCe9zzav6Tdh77YbVkBwXywNKvFdIcluYV5fPa1rLUkB5NfujJ3BXrk
         Fttclw7iSUQOAMZHGbZHQsCQryeLNf9n8HCUHObMn3crP+8gpjIMw5UM6oWs4ImniX
         qxd52dIeLWghjYPvVrMzVZRYa85hSY5WMetEgAbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6DWi-1hjqb810PI-006eDL; Thu, 25
 Jul 2019 00:55:43 +0200
Subject: Re: [PATCH] btrfs: extent-tree: Add comment for walk_control to
 explain how btrfs drops a subvolume.
To:     Diego Calleja <diegocg@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190723075721.9383-1-wqu@suse.com>
 <3769531.JR3RUOJnLt@archlinux>
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
Message-ID: <dd9d30cc-21d7-d216-da5f-024bdca360b6@gmx.com>
Date:   Thu, 25 Jul 2019 06:55:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3769531.JR3RUOJnLt@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Btz6ce8M9h2pnT38V7UoFblrMV9zMtjAY"
X-Provags-ID: V03:K1:785iVbeNl57sXlaS902NHs6yJbbZZlaX+PshrU72+zgRux+4hJY
 rOme6wzADIx0nOS1MRQ+BzA02Z19cWkAzY+F+RghDJttvZgPzX16IhrKBe4EcT3kgDS2aKJ
 r5AElv3bk+s0xSB3eRWwBsaci+Uk/vI1C3Tgm2s3hxAiif68v/Uk4Iah7kCBZpk6xK+pR/i
 owcl+93tJbqFcfE304XZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MWPA2rh2QVM=:URQ6B4Wts36BkJtrWtY5Vf
 tmG9j2oGKHFXO1oLC12zfszSGW9zZm2pccvV4Er1sO7tj277U0i+Blrop9fMwU6EBVzZcCuNy
 0WXQY0qXUM16kVBYZRTr0dIKN4+ZR+eFx3atxLYEAGt30LfKozxGP14aD+qQ4P1M7pWW0+MU6
 Q+I7jC5m/k2HOoJjnuiiXfBdZ/4PnJrWGVnuFBNRiXVAsK01V5pN5iZzSHDURf3U9/4+IpUrJ
 5YgYBJ8UakhpV/YyNdAsv+XILu/QnLIFXIAOdnCQ08lgY3QHCqjpDrJeAdxxGXPt2JwZZ2at6
 yVu3kunoqwdiO/MZby5BVsHdEgryabwL/YMY4s2ua5Or8vohTVCcFHKLR/jNhnaI9wd4E7mZi
 YKXUEHR03oyFF8+9CLOgxOpfWYuxlHXWhkEAAbk2CwEYEzYqerEaE1kMrnmo+FeLE5dJrLxnA
 5eo/yQA2B695Fu3KTepbP91Pek0455afTZXnzYxkF/jBzww1nOsf0Tgb1OZ7U3E6QYUkGNnYZ
 KP9zzdTs2ErwiXUw0s/mLp/N5AqDbS439wfzSWWcjai0pJ9hOEKOe3jqi4GMxdGI8M1YQk1bM
 Sifqz/+pY+0aWwmPRlNRIwty3CJeW4TlVcHIRIjFChovME32VfzGBJcfcBzCsChx1DnfmlWmN
 Kt3o0mtt4LK2J0nxXVxLjfnlUy6OR9uyQXUv3hD/ghXn4J9fFAjaruHyXuB2xPk9S56ictxGA
 8vbqBNBxSjjmv9Y1iGE8WkPA0ruUVI4OdoWUQF4blDTCbI3xZpYvb9UhT1fYmqwhsGbYQo4xC
 TAbOFWxVZ/DgnJPTNus2x6MOwyGScQfYq33sQdX0mfKExdLxiRwX4LCh04wRqjpf/xjCbY2xf
 70wIaMFKQXYmEWvV90wQdwPpV/CcCvUPhMIQY3N8/MxfqCKi8VfdwbzLdEaEGa2fZueOOuzjR
 oWY5102QQbJqtdX600fqXlf58EqAJ9BFU/ufzMBDgUuNrKoYQRM2jL6QNMOtKD7piGskEHjsf
 APrpdQ9XbanFQdfVM/UM0E4Pnocg4dRXVaCP+/nu2DG1o6rPG47c5uvD5hMvTgh/nGHxO11Lz
 JOmLPrgDwWDwTA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Btz6ce8M9h2pnT38V7UoFblrMV9zMtjAY
Content-Type: multipart/mixed; boundary="9o5qTsqPLWvdm8s3JqEZnyKVe2TsGCkkm";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Diego Calleja <diegocg@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <dd9d30cc-21d7-d216-da5f-024bdca360b6@gmx.com>
Subject: Re: [PATCH] btrfs: extent-tree: Add comment for walk_control to
 explain how btrfs drops a subvolume.
References: <20190723075721.9383-1-wqu@suse.com>
 <3769531.JR3RUOJnLt@archlinux>
In-Reply-To: <3769531.JR3RUOJnLt@archlinux>

--9o5qTsqPLWvdm8s3JqEZnyKVe2TsGCkkm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/25 =E4=B8=8A=E5=8D=886:25, Diego Calleja wrote:
> El martes, 23 de julio de 2019 9:57:21 (CEST) Qu Wenruo escribi=C3=B3:
>> + *       A	<- tree root, level 2
>> + *      / \
>> + *     B   C    <- tree nodes, level 1
>> + *    / \ / \
>> + *    D E F G   <- tree leaves, level 0
>> + *
>> + * 1) Basic dropping.
>> + *    All above tree blocks are owned exclusively.
>> + *    Drop tree blocks using LRN iteration.
>> + *    Tree drop sequence is: D E B F C G A.
>=20
> Excuse me if I am wrong, but there seems to be a small typo, shouldn't
> it be "F G C"?

My bad, nice catch!

Thanks,
Qu


--9o5qTsqPLWvdm8s3JqEZnyKVe2TsGCkkm--

--Btz6ce8M9h2pnT38V7UoFblrMV9zMtjAY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl044eoACgkQwj2R86El
/qg2JQgAkEveKLYYs5dhSzzY6Gibp0kwAsQTQxXNTWDKAUiZhu4nq/Fz/SFGytBI
bBuvdg3eikZsFyLUoZtU5K5Kr1J50q7d0OybX09qTxUHZCUsaTqNgsnOmp76Jrw5
7HyxyJu3owDLg9eaTjFwuK/tjvV2YSrFFKiCbZblDhkUOy4+WWFrRwUtE055xUSV
isvA/xs8AOrKfWVmjB86AsP5D7j4WxXKwfGGAiEi7pvI1g/AcD/oEUD9tPvLnAbq
5QL+xZSxhUdLnRIwL3JoJ5eCzjGKY8falGrVe044aMPJqyED2tTJ+CA2fb5PKA/A
ZQKn3azpdiizmiFig5q0pcWYoSrOBg==
=2NhI
-----END PGP SIGNATURE-----

--Btz6ce8M9h2pnT38V7UoFblrMV9zMtjAY--
