Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3372A84B26
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfHGMD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 08:03:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:44785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHGMDz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 08:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565179428;
        bh=k4NRFq/JDGAvx1jZHQA4bG5rpsf+rPa4w1vpVLEZt08=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ez9EFGE7Vxsr+UN8E57otU9oo141yYwSYHHZls7MZLdi8Ih3a4OYb3rqAIYGGBctR
         OH0P+7xIOfINezetLzCnTJgn8JXEmPmDxJuWXqBA90xARz6+2PiMjmNOUbn7Gdo9nH
         d3JxVdFN0YCJxb1IvZTWMLmZEDY5JWp4ZnFLAbEM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MhNk6-1hhdJ32qR8-00Mf9u; Wed, 07
 Aug 2019 14:03:48 +0200
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190528082154.6450-1-wqu@suse.com>
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
Message-ID: <8c3ba53e-7718-514a-2d1a-765e84e0a75d@gmx.com>
Date:   Wed, 7 Aug 2019 20:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190528082154.6450-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iJz7nczvm4qxVpHGQlqJCnqdhWA1jcJaS"
X-Provags-ID: V03:K1:9pTtipt1I+W/1utpXsvbiIgiQIHE8zpjyBJ7pdQHIQDJwmuOIbA
 dPo0g7jtsxrLFdMJXX1f8r/8+xVzOLelnQebSdQoQX3+1oaNSuUp1eGwwPk3K/A06EFihxp
 Lx3t6Wh8ImcHv7XkbCIJnn2onb3wKXZmnfNDe5jhbuMOL+ziYjB+pbxH2Tu2d+OQf7ny8kR
 CSe6BVAl+i7DnhtesjocQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Q3OmhLwg/M=:wdxccaZzpUp2tRjSz2o88Z
 qhqDHlAxwq69t56t5UvxzfSlCCE+tCAriohFfU3N8lXfYWWXEKKha9cJhIIYz1OwP04hf9Y8q
 aQ4xiacuSSx6IRP4Z8oVsUyCdfY6HZvkpBb7jEEbf3sj6qfJd7L4eXgpzrSOTlTxD6VOg5uaJ
 HxwmId3ShzknAv294yUx9sqhBkH19tLrRVpeCpeIwBUfq7YD82tQOGwSwTgNuCSDeh0h96hlC
 ulIinnfE37+gjGO3vU4SAfmGdvjFQI63U0o7lltEue/zM/zm9XZifia6mIkSO9HlWlstgmd8X
 uly5lCUBTV1cuZh7j5G6kETx+xfaGvi1MHu8GdShfTU4jLSSKqHqeVMR/1drwZ/hjTf4/ZtNu
 xmJfG0JUh1UyjGBUGAfyvEdUyKfqy9fo4TH7Ak/fxVoqoRRyvxTm/YEwEWQ8/Lm0LO6e11b4Y
 IGB31HozEaMkgr8/NimIw92VwGS5HfpUVV2sDS6TvfcGhpXhRYFavBNDN3zC3W+0j5698tzGO
 CxcO0Te4YpAP+k+DY+JxjBxvSJ8nclvekkIMV/AgmGucXDrSjbXohGkUFvgxSqxDWyBlAtrQl
 MclUKjJ/Lky2bzRb7qAmTjCW979bEsGQTIRuoj1FHYxdCwwDSWS8SH+zK+tq3VSJAq2ed/HT5
 IL9Gze7v/A9m5yEOvf58uGagYpp5sRrL77B4ZcRvdA7K0Kvs2N+PBYj3SgHp25i4/KLI1Sb/Q
 NYk5heTiybCe8hSCENHOWN7DxiGpwA2/2lbZ4UFGYx6xyCRglyH1wGBp1kxcX7GMzPrs7xWLx
 1ALGgWWR08xBqAHq5kWg7h+j6TJf6QCfe8nX64TqQcHDwar94X0kd94YWDcbGjeAcHs319ZJ/
 HpRo89oE0g7ryP8Cq9FdAS+FVV27x1f9NwI4dU+pKb7DBJzHTcSWiajxd3Vp9pHLDTvDTfkKe
 6EbELVxvK+F64KlZaHfF+KTvG+Wr5PERjpxPhlcO/ylE3s9sYTKf/wQP8S/FYVOxhWRaqhvPx
 3F99fBoHuZjeKJlvJkOrdrw/OcXpQTqm9AanyW/YjIAXU/iYjp3dGxNNLpAiAhVu2If63f1Od
 GAbiQexsi0wAKCAL/qin5Wm62s6lFSh2CYHuXqrBZuDKmzB0pXtCKdmDQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iJz7nczvm4qxVpHGQlqJCnqdhWA1jcJaS
Content-Type: multipart/mixed; boundary="oBKixnlURIkIyhp2qAANcx1SVfdhheuDP";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <8c3ba53e-7718-514a-2d1a-765e84e0a75d@gmx.com>
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
References: <20190528082154.6450-1-wqu@suse.com>
In-Reply-To: <20190528082154.6450-1-wqu@suse.com>

--oBKixnlURIkIyhp2qAANcx1SVfdhheuDP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Gentle ping?

Thanks to the discussion with Anand, I find this patch is not merged yet.=


Thanks,
Qu

On 2019/5/28 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
> Normally the range->len is set to default value (U64_MAX), but when it'=
s
> not default value, we should check if the range overflows.
>=20
> And if overflows, return -EINVAL before doing anything.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f79e477a378e..62bfba6d3c07 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -11245,6 +11245,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info=
, struct fstrim_range *range)
>  	struct btrfs_device *device;
>  	struct list_head *devices;
>  	u64 group_trimmed;
> +	u64 range_end =3D U64_MAX;
>  	u64 start;
>  	u64 end;
>  	u64 trimmed =3D 0;
> @@ -11254,16 +11255,23 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_in=
fo, struct fstrim_range *range)
>  	int dev_ret =3D 0;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * Check range overflow if range->len is set.
> +	 * The default range->len is U64_MAX.
> +	 */
> +	if (range->len !=3D U64_MAX && check_add_overflow(range->start,
> +				range->len, &range_end))
> +		return -EINVAL;
> +
>  	cache =3D btrfs_lookup_first_block_group(fs_info, range->start);
>  	for (; cache; cache =3D next_block_group(cache)) {
> -		if (cache->key.objectid >=3D (range->start + range->len)) {
> +		if (cache->key.objectid >=3D range_end) {
>  			btrfs_put_block_group(cache);
>  			break;
>  		}
> =20
>  		start =3D max(range->start, cache->key.objectid);
> -		end =3D min(range->start + range->len,
> -				cache->key.objectid + cache->key.offset);
> +		end =3D min(range_end, cache->key.objectid + cache->key.offset);
> =20
>  		if (end - start >=3D range->minlen) {
>  			if (!block_group_cache_done(cache)) {
>=20


--oBKixnlURIkIyhp2qAANcx1SVfdhheuDP--

--iJz7nczvm4qxVpHGQlqJCnqdhWA1jcJaS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1Kvh0ACgkQwj2R86El
/qhcZAgAosh9FXhyMJdU7fRYP7sLq9rau4xEFzfWtqyPQ3/hHwhuGFDzbHpllBv0
rsuZ2xjqXG9HL5b8jYeA8QGXvsRAPWx+/FryDOl36tH/R/u7S81Lz37PoAh7BGvt
N7BhzDri08BhDx80mNqSYQTIc5ZFcfzhbesp9KUKij23mwNWhP84BTr7Ys4kDsSu
ZTeXomNy3zZbRndg3RAn31cPV4mU6euLXa9f1SDARCC0MUk4cR5cvMBQjLeYFR7h
wclDxxc19upwPdemGEswy0aVLp6UL8vg59DUxQAXtMUcWwf3rsQrr6K/yW4YdsG4
2RAN3F2e0XchfKmGjUkH5E2s4N0m4Q==
=DBXu
-----END PGP SIGNATURE-----

--iJz7nczvm4qxVpHGQlqJCnqdhWA1jcJaS--
