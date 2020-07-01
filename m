Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E712109D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgGAK7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 06:59:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:34379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgGAK7O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 06:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593601139;
        bh=jRoVfpEBloscyNWfPT75+xick+M5QS51VLzCTyrqAVQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Dmv0g+qew2aVn38JcY/wsP9dk5BXlWut7cTOkzUET1AC79ArgS0Ml3y101YKartHy
         doMfnipjRtHECxQNkRWQt6ZBmixlyy6ls1uJkKNRzGdlt5VMCbJq3ygdY5hMtXo1HN
         LHnMfPI//t7pEStCtncb7c+jju/5Bdk5cZWG0Lrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGN2-1jYMoW2PWo-00JFhS; Wed, 01
 Jul 2020 12:58:59 +0200
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
To:     robbieko <robbieko@synology.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20200701092449.19545-1-robbieko@synology.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ddd19f85-7d55-38f2-3546-683a0229d51d@gmx.com>
Date:   Wed, 1 Jul 2020 18:58:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701092449.19545-1-robbieko@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VuMET84Vz89JlParkwtQUenoeOW8TScbu"
X-Provags-ID: V03:K1:y64oBjbiym5VBNbAB25snQS3awJBp4dYes51olvoBzUYIqoh5Hl
 o7cuZuO27Ix/o2aRtSt02jhLojgVPRFk4msCLXOkG0npmjhYXk1qBDvS7r9476uo5xy0RcJ
 GtTnGo49eFjVy2HeYC1fMAK28am/0TzB/Tl+7AqGqx/SFrUwC9ug603EDnkKrmIVCT3OPI1
 aBJPlwyIBLZjZStg9u6Zw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AcXrP/vefaE=:XnMyc8BsoUhZNJ0gO1N0PA
 AmmQO8IYG52QbLNRyu09apfX/xrI1h4rXRy3uLF/8LDijQkYMWHqN6v0ED53EkJXMI5EjeriZ
 vzJzwKcJmp8JnM16B1NBYWAZFKm9iImU2Lhaw20bOkqpCd3WQhx92WtUnddrE7B11Hw9uYo1I
 ifshScHpUdUp3ViWiE3rsoiRzuBcf/uqIztWSrBelw7I4loWS2IS/QBkM/gljMhSG4eLoSvSz
 n64U7Cv1dkIIiYx3f3Yo0Ysz4Ga1EOsm+Nacq21Zvv6QGNomxHg+4OFtWSyuPr4pBlnixYLoQ
 DzGK+8qiDOu2RBQUVKkeOGfYAudqK5xihoq8gk7fMEDfTX9inS6AzjRHxjcQfPccFqrxLFu+v
 G65KHVWtFOR7hYswae70rWr+pQ/qy0wX9df0qQ8nYpbIrHE04azsrIKVgf8utSX188OTy7OyN
 sdljNUuJJFmXYnek9FZlj2U8uHUe2WhjljJBI+Oxj/3niqPDwmj2xbNvfYXZC3zNHTqSWIqL8
 ixr4B3o+ABRO9YnBSRKnGNO4HY4XJtqCpFPIc+/Xc1ra23JqJ4P9MOphO+jO97HEbsQnATQxY
 7IsyZeDA2CGhD8kg61VGWJ/Gc1T2Y6j4YDEOdC6L2H9Ly2Dgpl94itlGVfW3cmQcylf8xVFnn
 loJcsl32v/10tQ9UmRSjFF6GH/lTM5NYA+NYxyS20y6tp3NPdE6KmBM9SV6O4qeAHU3r/pWun
 jM8y1XM73nvwdFiBJ7dXZORII2aAhcAjIssIDNVkMMTnCTYwk1mVG2HKYvrtlQlJSOfn8/soD
 bX6lxaOKQLqpWJA0TjDq02vnMMCEdwYoq1h5Rc9K6rsyG9xMBgdrpxeuKz7KKhE0huKD6jYvf
 RaMJ/C2ji3AaCBXSOefJ6yFtQWEDJo1PO2GSKlVK15RG3615iWepTU0ruKTabAfE7ll+fpIP4
 AwjXvBwlnQGu0Cexv8x5O3XOk8pm4O4aQYwn/wF/a0C0R9Dyg4Mk/JnlVLWNt9SwLQa29Waev
 r+HpTczh7bUsVmyKmVeqqp+o2dfXNDAM4O/een60kh9j3PRvXMKmTFFmp28E9l92Sm9Iddo3t
 LKkPyOhYWnv4OhbB3u5Ig73+msD6tWyaZZAGSNnrIS5A9xdKOiPbXQ2dgkw0xRK6hqn6aEyG1
 esFGxu3Sl+w22mXUVts2i64ExmicKlKQK75NHWX06K2ZG4Dl50hUf1c0PsdLp7I1CmTiy8bFb
 9JiO92UTguF5AybOFZzJuN5LOx8ZUy3d14ZvkXA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VuMET84Vz89JlParkwtQUenoeOW8TScbu
Content-Type: multipart/mixed; boundary="IP1noLLq6loH1UJmvV9ZZONH2Zj5AGJLy"

--IP1noLLq6loH1UJmvV9ZZONH2Zj5AGJLy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/1 =E4=B8=8B=E5=8D=885:24, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
>=20
> When mounting, we always need to read the whole chunk tree,
> when there are too many chunk items, most of the time is
> spent on btrfs_read_chunk_tree, because we only read one
> leaf at a time.

Well, under most case it would be btrfs_read_block_groups(), unless all
data chunks are very compact with just several large data extents.

>=20
> We fix this by adding a new readahead mode READA_FORWARD_FORCE,
> which reads all the leaves after the key in the node when
> reading a level 1 node.
>=20
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/ctree.c   | 7 +++++--
>  fs/btrfs/ctree.h   | 2 +-
>  fs/btrfs/volumes.c | 1 +
>  3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3a7648bff42c..abb9108e2d7d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2194,7 +2194,7 @@ static void reada_for_search(struct btrfs_fs_info=
 *fs_info,
>  			if (nr =3D=3D 0)
>  				break;
>  			nr--;
> -		} else if (path->reada =3D=3D READA_FORWARD) {
> +		} else if (path->reada =3D=3D READA_FORWARD || path->reada =3D=3D RE=
ADA_FORWARD_FORCE) {
>  			nr++;
>  			if (nr >=3D nritems)
>  				break;
> @@ -2205,12 +2205,15 @@ static void reada_for_search(struct btrfs_fs_in=
fo *fs_info,
>  				break;
>  		}
>  		search =3D btrfs_node_blockptr(node, nr);
> -		if ((search <=3D target && target - search <=3D 65536) ||
> +		if ((path->reada =3D=3D READA_FORWARD_FORCE) ||
> +		    (search <=3D target && target - search <=3D 65536) ||
>  		    (search > target && search - target <=3D 65536)) {
>  			readahead_tree_block(fs_info, search);
>  			nread +=3D blocksize;
>  		}
>  		nscan++;
> +		if (path->reada =3D=3D READA_FORWARD_FORCE)
> +			continue;
>  		if ((nread > 65536 || nscan > 32))
>  			break;
>  	}
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d404cce8ae40..808bcbdc9530 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -353,7 +353,7 @@ struct btrfs_node {
>   * The slots array records the index of the item or block pointer
>   * used while walking the tree.
>   */
> -enum { READA_NONE, READA_BACK, READA_FORWARD };
> +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
>  struct btrfs_path {
>  	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
>  	int slots[BTRFS_MAX_LEVEL];
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0d6e785bcb98..78fd65abff69 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *f=
s_info)
>  	path =3D btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> +	path->reada =3D READA_FORWARD_FORCE;

Why not just use regular forward readahead?

Mind to share the reason here? Just to force reada for all tree leaves?

Thanks,
Qu

> =20
>  	/*
>  	 * uuid_mutex is needed only if we are mounting a sprout FS
>=20


--IP1noLLq6loH1UJmvV9ZZONH2Zj5AGJLy--

--VuMET84Vz89JlParkwtQUenoeOW8TScbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl78bG8ACgkQwj2R86El
/qiHdgf/ev9HZD/sxXKisxkr0vpKlEBQ07pCRnSQLINf3C/MDuaXxgSBSHxyIbDl
R7Od77JHtVCHwtibm5OYFQCC4SueRPMLLRYVr8VifV4+ZZFOR1y4Qd7Qmu9rhB6Q
5Wpz/1UGpzdJV0S11D6aHJXbi2NS2+mQppOMyPNrpfd8wuckZBjr5l61PE6yQaUg
MY93ZI85GmyXDMv3vGn4tUtpknCXyz2UruIAdNRzvRrkQIeLQFtbyfUqGicVKbTP
xBQeD3dzNqJGjRSHw1PM5AO4eo5+vNFX410tao1GVunJ+uBVMEyHnNjEWgfbzbf7
hcpOHjeTkub06eb0PDxjnu+t37dPug==
=3Hhr
-----END PGP SIGNATURE-----

--VuMET84Vz89JlParkwtQUenoeOW8TScbu--
