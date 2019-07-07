Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED9C614E9
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2019 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfGGMP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jul 2019 08:15:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:41707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfGGMP6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jul 2019 08:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562501753;
        bh=zlW0Fq5b24WFUmjQJXeOP9RMPJWzqn4pP/qK0zuAEsw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NIWwYLpUZvPVDo6z7b+refOIRE3hK1Jne308X8jh1lmfnfyg2q22iTQ/+vUvnlwWa
         J51hgx+uB170YbQN6idLmY/vdNV0/N3SXY9yjzAlhSHDHRCPl85k7KlM7F/hpKXqxq
         uW/jCJczlv+LijJeWgy6EsF2eYL4i+q01F1iW2Oo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LqQzp-1iNIiH0O4v-00e4FP; Sun, 07
 Jul 2019 14:15:53 +0200
Subject: Re: syncfs() returns no error on fs failure
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016bc283c774-ca60b6ce-5179-4de8-8df3-80752411b5c0-000000@eu-west-1.amazonses.com>
 <0102016bc3d2f2a2-46c55025-ec28-468f-b1d2-82d655fa3a1c-000000@eu-west-1.amazonses.com>
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
Message-ID: <ecd6de71-e10f-e42d-7780-951a5a53923a@gmx.com>
Date:   Sun, 7 Jul 2019 20:15:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0102016bc3d2f2a2-46c55025-ec28-468f-b1d2-82d655fa3a1c-000000@eu-west-1.amazonses.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ir0piJerFlqgbT0cDTY9Zb4RB6LxQNBPB"
X-Provags-ID: V03:K1:duIm6NgOLsMgAOqFudk4XZEqASI09TIi9bigyl07mqQEOVBtVU6
 kVtKUS5OkPeRfkmV+SNEgCnPY4CsdRpkOxR0xwmBBF1hJvj1x5lhLus+/Zv61mM5zdkwK3n
 wnQhygKS/dsVecmecucUFvHWl96lPNudndDlsV5qp5QXeUSa3+XP2rNOpO4SyiXHBglFcq+
 ixt+YwuVMkZ9uoWSGqB3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JdaZn50Mz8Q=:POnqr9jNPNdDLdUlgnBb93
 Xdxpf6GnN1V20A4k+ncUQJohNwtv72SxI6coUvTqz7phENnoZZvbDW89E4B1dsaixE5m+7fft
 xo2X6WnFiNZTse15Qviwtu6DSRZZgvBu0y9lqJLHmLnpBm2sRg2r/3PyvEgIsd9k9QnTKDr1o
 HC60OV1hxRAqgMrmn293uNkRNJRUFc5ITwp/GusiTp5kgujyNSy+bcHnV9UgOhUqF1kyJ3e82
 HpvFCMqkg41idqt4bhQwh6utGhOqUv+MgflxC+U0ZcwUqhAogJJiyvUaKUW9PvGmBHXn4eiBk
 lfNhgWG6WSsu7if9HSM+lrG9RQVKU72z1aGpotJYmzg6fO5kOpW9OkO6ekR4HLQy0CYhVlhQs
 3iVFIz9zhtsOlGbsmzI+a4SVFa7MOluJfARXfcf+BcqWYPJ282MmETKzQYxANzP+iQPbdgKj8
 1snjJZVG9OTbiAixECGE6M10d9cfibKJEqZXi5kH86/oV2WRIafJKH6yPCLzRmziF1t5NiKYv
 /+CbJsumcDwxhjyUJm6yUY1ryf7QF1wEnsimhIjA/Q/TpPealCzTK/0EmsiiYx68JH11Y6poP
 sP9bMk/VAK5GrbhN5ifRMZzi1Xz6bDQUSt5A3fJxEUHK6V+RqksBV5e9XgGd3f/10peoV22OY
 kiV+fxBRoSaxdnQ8z6SGiusNXjnOnI7B9FUFBiAcjSIsQIP8HCDQOb1f7lk9mKpPexEdTo4An
 8SJQPy2KMCfvWLT24XJkc7KvCZmmMFsHOG4W7JouKQGsS+4BUUvnywR8lvo5enYtsZCkh18n6
 lWYfgGskYYFocRoPLb+hKAn4OkKy3vghOxZraM2/TGUwayUSN4nqMQzCtrYoVsU18WDhYTtfi
 Yu8QuDvIpKpGXtW3zkSoy5itA6r9zMAbZWJUBByxgRLVVDdeULn1dlFH2ekeRUNgiOkv7EUaY
 0Mh3TIekGMaz0NRWSRlvjHkvr6gftv57sSZr7DOD/e2J97OEHgtkN1bm6/zSkiScETSu+OCmb
 zyG34vUMpE/o42o9prwA0STCVCeZy/o5WwzFKRn8AQvcnph5JuPvDePgmOpbdK52feN0F1ZYq
 2bdxCsoswWv8Eo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ir0piJerFlqgbT0cDTY9Zb4RB6LxQNBPB
Content-Type: multipart/mixed; boundary="8N60fE3nXoBuTa66MP4UfYXWlrGQOu3yw";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Martin Raiber <martin@urbackup.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <ecd6de71-e10f-e42d-7780-951a5a53923a@gmx.com>
Subject: Re: syncfs() returns no error on fs failure
References: <0102016bc283c774-ca60b6ce-5179-4de8-8df3-80752411b5c0-000000@eu-west-1.amazonses.com>
 <0102016bc3d2f2a2-46c55025-ec28-468f-b1d2-82d655fa3a1c-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016bc3d2f2a2-46c55025-ec28-468f-b1d2-82d655fa3a1c-000000@eu-west-1.amazonses.com>

--8N60fE3nXoBuTa66MP4UfYXWlrGQOu3yw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/6 =E4=B8=8A=E5=8D=884:28, Martin Raiber wrote:
> More research on this. Seems a generic error reporting mechanism for
> this is in the works https://lkml.org/lkml/2018/6/1/640 .

sync() system call is defined as void sync(void); thus it has no error
reporting.

syncfs() could report error.

>=20
> Wrt. to btrfs one should always use BTRFS_IOC_SYNC because only this on=
e
> seems to wait for delalloc work to finish:
> https://patchwork.kernel.org/patch/2927491/ (five year old patch where
> Filipe Manana added this to BTRFS_IOC_SYNC and with v2->v3 not to
> syncfs() ).
>=20
> I was smart enough to check if the filesystem is still writable after a=

> syncfs() (so the missing error return doesn't matter that much) but I
> guess the missing wait for delalloc can cause the application to think
> data is on disk even though it isn't.

Isn't syncfs() enough to return error for your use case?

Another solution is fsync(). It's ensured to return error if data
writeback or metadata update path has something wrong.
IIRC there are quite some fstests test cases using this way to detect fs
misbehavior.

Testing if the fs can be written after sync() is not enough in fact.
If you're doing buffer write, it only covers the buffered write part,
which normally just includes space preallocation and copy data to page
cache, doesn't include the data write back nor metadata update.

So I'd recommend to stick to fsync() if you want to make sure your data
reach disk. This does not only apply to btrfs, but all Linux filesystems.=


Thanks,
Qu

>=20
> On 05.07.2019 16:22 Martin Raiber wrote:
>> Hi,
>>
>> I realize this isn't a btrfs specific problem but syncfs() returns no
>> error even on complete fs failure. The problem is (I think) that the
>> return value of sb->s_op->sync_fs is being ignored in fs/sync.c. I kin=
d
>> of assumed it would return an error if it fails to write the file syst=
em
>> changes to disk.
>>
>> For btrfs there is a work-around of using BTRFS_IOC_SYNC (which I am
>> going to use now) but that is obviously less user friendly than syncfs=
().
>>
>> Regards,
>> Martin Raiber
>=20
>=20


--8N60fE3nXoBuTa66MP4UfYXWlrGQOu3yw--

--Ir0piJerFlqgbT0cDTY9Zb4RB6LxQNBPB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0h4nMACgkQwj2R86El
/qjfCgf5AVaZhRnWaXqRl5Vl3hkclMJ/WoBafHnwpprkwdxhXk4nNzSPcuUGO0Q7
BbOdrSl4PeRtMiloomvo/rk1FDap6Nu9uzVnRcWKg3j1E9gUma6h3nVnJkOam9s8
zjoTrCELCHjTdGmBAU6yraiRQbP+fE/0yvajzSR9Huw6b1VWbQdk0/4XpF6zGJ3Y
SmwjGCReMnM4xnOXCnzW9oM8GjIC9ySvlCYFzeh+KSudHt0Ks6QjU7xxPPqWuaVk
gE6vRjylSJpSc8wokuKamv27m9pEk6b/cZk94Jh9B67l9FM2I8xeVfR0HswcHELm
UKcN6F8dlDklNdzZ9bNSSRzqNILbYw==
=4kml
-----END PGP SIGNATURE-----

--Ir0piJerFlqgbT0cDTY9Zb4RB6LxQNBPB--
