Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915BA1AEF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 04:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfEMCiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 May 2019 22:38:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:40795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfEMCiJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 May 2019 22:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557715077;
        bh=R9V9Ny/ZUroYbLRQOSEQBQphNs0gNRtZeIVjYGX8Hfo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gd7L4MJcK+howSnaEjf8/OhiLP2XSJyuEq8RFVuRNmYwVzKWwtseTENvg24LAtEeF
         XYnsHlKSszjRQWB2wHRJt2IKTidC9k+v0XZ02MerhQLiWrY2BR1uq4fgLv/BIEClHY
         G94YzKAtIf+AbF/+2rJ+cmXY6x2FZhh3OxQQAttM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oG5-1gVyO90tvh-00wjup; Mon, 13
 May 2019 04:37:57 +0200
Subject: Re: [PATCH] btrfs: extent-tree: Fix a bug that btrfs is unable to add
 pinned bytes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel test robot <rong.a.chen@intel.com>
References: <20190510044505.17422-1-wqu@suse.com>
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
Message-ID: <f5a901f0-640d-3eab-ed1c-5c116645f5c5@gmx.com>
Date:   Mon, 13 May 2019 10:37:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510044505.17422-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e7EFfwQVlMnCOsROL9WFavadPLS3RAGKE"
X-Provags-ID: V03:K1:fLweJw2mfsCfDGLjE9Llhipc8sBF6VHvg28kSvmRjiec5IHQZ1U
 wzyQu3rsouez+fPewRUwGtiJH1yQg02rOB599nAzDVuifVPrgXFPEqbCBCSXZmrLuhqXlXo
 gxKAZUNx86ADsHaA69LdGtrCDFEvYWeABAuT5TVA4mfWwsS/U45NNARCqUurtXDtxQ/WID7
 sDSdgtd32A2wQp/b6Apfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MMPswidV/P8=:PSsmU85K/bK+gnylv6AMnP
 gHpaCTchIJpMd64oYSbFLomPw7CA94dvVtNqX8xi7aN5DDWf/VJix5wmX9q2nNiIagpaKxQXv
 5Vs5LwXwzWqJ1lTKXYA0msGs2XviI0V7crW04I5saThurykrCQhFhF0esvByRNwW6C51nKfkA
 7RMBmXtf2YDO5aMiXaTLqXRL+tkK5Bjjt4iDJYXhZx1xwpkyIDQKOhraWr9M0QShZrmvnY0Vk
 eN5vKyVk+EBTxiuWuscSH+zLpKe8pmVuMF2H4pY7K+QdcdhrKVgd6OOjJbZNd0d4ELUlQkkag
 SL4glui0QIMRMCXCtlqtNgtKfDaaxBEOwhOIOjDL3BpG0Fz40D6RYzIo+rxy5mMil7JsrqB1x
 tXsqH8jEIYDK17toALpWr7TLV25/RQvFdJQDzUKt1JwaV1gYoVLRhZLXUXbh17U5tCKeyEYU2
 5Fr5PPilq+2cJ1SsdiTqkazMK+CSrtKakiRsppdRYvjjh1QTktliFAog5ZG5+9XDeK6dj89Wd
 j9s88tMGRYsFG7NeXrNsR7eR6whXIh5dlt5miYLaz02BTaGYehwuj57HLSfTybmTQSreJnJFk
 mYOg5tCN5rrf/vKE5p5GRDTIQ8/glrlR+dB6QiMTx48NnVUmrc606UsKxmxGIeSwiGNhctzQ/
 df5BFo3XyPCcRdLHOVBf19yyBOMdNAaT2ccKbdt4eJthC2mm/I3ailUSX/XcGWpZ6L610trqw
 fqWeOKTTp3uezmBMgcC0DuOfK54RqdI+LLH9isxoQrfeIu2NWIASuekm8xQ1Bxe7s+egozMgr
 In1hO7SoolxX53LTTMBSSDKlOLngwgtl5qriV/KRgGOZSKSd9rYjeKkxjl5UERkTIfMcd9x39
 05gih/rAQgS0mkUn21k9Y5qlIrxiPnOsPYSf5oTi6dHENPv4HEYkPxT2c8aFZK
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e7EFfwQVlMnCOsROL9WFavadPLS3RAGKE
Content-Type: multipart/mixed; boundary="tjs58isBLlfEjC3kt52AjkG2KdklqwR5u";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: kernel test robot <rong.a.chen@intel.com>
Message-ID: <f5a901f0-640d-3eab-ed1c-5c116645f5c5@gmx.com>
Subject: Re: [PATCH] btrfs: extent-tree: Fix a bug that btrfs is unable to add
 pinned bytes
References: <20190510044505.17422-1-wqu@suse.com>
In-Reply-To: <20190510044505.17422-1-wqu@suse.com>

--tjs58isBLlfEjC3kt52AjkG2KdklqwR5u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/10 =E4=B8=8B=E5=8D=8812:45, Qu Wenruo wrote:
> Commit ddf30cf03fb5 ("btrfs: extent-tree: Use btrfs_ref to refactor
> add_pinned_bytes()") refactored add_pinned_bytes(), but during that
> refactor, there are two callers which add the pinned bytes instead
> of subtracting.
>=20
> That refactor misses those two caller, causing incorrect pinned bytes
> calculation and resulting unexpected ENOSPC error.
>=20
> Fix it by adding a new parameter @sign to restore the original behavior=
=2E
>=20
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: ddf30cf03fb5 ("btrfs: extent-tree: Use btrfs_ref to refactor add=
_pinned_bytes()")

Gentle ping.

This patch is needed to fix generic/108 and should reach current rc.

Thanks,
Qu

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f79e477a378e..8592d31e321c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -757,12 +757,14 @@ static struct btrfs_space_info *__find_space_info=
(struct btrfs_fs_info *info,
>  }
> =20
>  static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
> -			     struct btrfs_ref *ref)
> +			     struct btrfs_ref *ref, int sign)
>  {
>  	struct btrfs_space_info *space_info;
> -	s64 num_bytes =3D -ref->len;
> +	s64 num_bytes;
>  	u64 flags;
> =20
> +	ASSERT(sign =3D=3D 1 || sign =3D=3D -1);
> +	num_bytes =3D sign * ref->len;
>  	if (ref->type =3D=3D BTRFS_REF_METADATA) {
>  		if (ref->tree_ref.root =3D=3D BTRFS_CHUNK_TREE_OBJECTID)
>  			flags =3D BTRFS_BLOCK_GROUP_SYSTEM;
> @@ -2063,7 +2065,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handl=
e *trans,
>  	btrfs_ref_tree_mod(fs_info, generic_ref);
> =20
>  	if (ret =3D=3D 0 && old_ref_mod < 0 && new_ref_mod >=3D 0)
> -		add_pinned_bytes(fs_info, generic_ref);
> +		add_pinned_bytes(fs_info, generic_ref, -1);
> =20
>  	return ret;
>  }
> @@ -7190,7 +7192,7 @@ void btrfs_free_tree_block(struct btrfs_trans_han=
dle *trans,
>  	}
>  out:
>  	if (pin)
> -		add_pinned_bytes(fs_info, &generic_ref);
> +		add_pinned_bytes(fs_info, &generic_ref, 1);
> =20
>  	if (last_ref) {
>  		/*
> @@ -7238,7 +7240,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *=
trans, struct btrfs_ref *ref)
>  		btrfs_ref_tree_mod(fs_info, ref);
> =20
>  	if (ret =3D=3D 0 && old_ref_mod >=3D 0 && new_ref_mod < 0)
> -		add_pinned_bytes(fs_info, ref);
> +		add_pinned_bytes(fs_info, ref, 1);
> =20
>  	return ret;
>  }
>=20


--tjs58isBLlfEjC3kt52AjkG2KdklqwR5u--

--e7EFfwQVlMnCOsROL9WFavadPLS3RAGKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzY2H4ACgkQwj2R86El
/qiRrAf+I+mo3UVrse7yGcOe6T1nQVW5uFjv57sxdLB/kYo87px3escxZ0fRbTmI
7ldUFvIjikii3TURcw2M0UCyUPeZnAmQfkyLS5gGA3GqPNefnXVRmDDvOPeuYNf5
A/fmXp0c/h4fycZJ7giPuP7kwkWYKkDkzgsQE4MthmvMFmIKl+YisMojoiBMJ+Gw
2wMLmvUc/VbxfpqTpcBa1JTmyrIbc0d0ySLMTTQn6Do2qp3doLg1ZUHv1BBHgjlh
IOmnvGplEcpd2iZa8mKJ4Xtn+QfNwyel/n7l+NVcWXfON8nBvozUNHPPJSjT8ceo
5GTypO3d8883wD1rXsqmE2O/suXAoQ==
=E7WN
-----END PGP SIGNATURE-----

--e7EFfwQVlMnCOsROL9WFavadPLS3RAGKE--
