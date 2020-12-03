Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79722CCD57
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 04:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgLCDa7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 22:30:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:47361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgLCDa6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 22:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606966163;
        bh=kKx74KfF6YTz620OYoFPImIsW09cNa7dxJ9AFeCjlHw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N9KzYcnRAZjaxC4rClXXoJWb5/gmmVqD9RIBsJYGyhdT5dAg6mg094VKR9rlPSUmU
         zNmWEFuHpUg2xZymsLjpzb/in1xkGisbi4j6LDue6ukedHX+c37TId2TaOEW3tK9Dw
         1smiZZWa6z3KthMkBl4hGLKRE2T2my7GTeIsqL0U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dsV-1k8X1b3XQz-015b1a; Thu, 03
 Dec 2020 04:29:23 +0100
Subject: Re: [PATCH v3 29/54] btrfs: do proper error handling in
 create_reloc_root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <045a0b4cb56d0d79728ad98749a022cdf664ad5a.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <a4678519-d543-5adb-fa90-23f4e4f52673@gmx.com>
Date:   Thu, 3 Dec 2020 11:29:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <045a0b4cb56d0d79728ad98749a022cdf664ad5a.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kGj3GCnNbdYromb8z9udillOLmS9Xc3QJ"
X-Provags-ID: V03:K1:h1ShCjGF8lTvdDjTIFYWueZ9mbh9fHn0dlSUCTRntJ0EFlWPZZR
 HsRY5BbCSzbBI9RBcSsIZh/5NBORFe51AlLWrZWNcNAIggNrjqwzNh2JinKm/d8+TNxu9Bo
 0oiaiVt2iGnLB8nargeH3MplWbgHSDJYItetWQ1i64ELzmCMi2Um+bCODSPouyotmhj2bhH
 xQ8l9FDMyvRete/n9My0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRXmWs6lSpw=:qXlmb4VOj1mWU5aaNNlFjK
 76f41Tsbm5NanU4Vh5ruEKUdnNKD/z3QqQMsWGNK4u4fM2uFuiFrWRK9FHs1nFjB9Sxkjz04M
 zHByRALCws9q3bH0sqEnSnn+it328Oz0BMPNl2EFKfU3ixz/SKTUAu/rrBWPVdRW2jDPFTXEB
 PRbp8A6pzzw4xCNawrQiVEbDO9NWFFMAGML6UZLo4Z6A+T6ZkwZba9CbBOjnpPved9fPf9UDz
 pFphsiI4w5YCuuTzjwLNJKR6wrndDMkZoHPjOlAfrPthOURxYcoVZp7/OPcBXcjtpnP0+YqeW
 EFPxdse5QGoaktKKN3O13wEo3atA5ZYkjy50x6GyOdXjaHtb90B7irfA6whQJSzGUxsOzuQom
 LOs3EMszwYgdIQuBhwpxAmfJq6WCvb0jH1ZskxDQGASaFpJHa82Zoefso8DRIeIpzg4Rgd+7P
 sCX58HCuVsbbfCW84vJsnBU1XVvilJAuxkTFB3OTNPUPkYrLdmpF9k7L57PUxnSrDD4xL0+1J
 KdisbAB9SayAHHcQ2jPiC9xpWYmdeG8/UWmlEzu21JhVMuOMd7UFkq5yuO0nHGR+lqQ0G99hQ
 doxswtnJj0qrRZgAZCdnqCq+5/4P7riQJ6eah+ADW7ZX4rysQPfI2wqS36MMZO8++HJe6RveD
 lGQC5/o8e0ruy6/IZU8EGzkD6lX5q5kAN0jb5V8ZuvvHfabxfwVIPqqD6AS7G/mL5ss6EwrmW
 /9dE49RRTL9tVUTBOE7nc3Jk3wbkJa8W+ggv4UppcBswOhG45AglxvPaeXMQJIRRalIKwvB4i
 aS7q+lfIsXHFt1HI3rZLsoEIwWOXikxDzG6LuK/xWk0FHlRMPaQgWq+/GF3mcQYFC2L4RnVc7
 HkjWJOn8IToU3uZ0LR4Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kGj3GCnNbdYromb8z9udillOLmS9Xc3QJ
Content-Type: multipart/mixed; boundary="lDZExIhKhcVTfqFv91FFx3aAlDDRzTq1A"

--lDZExIhKhcVTfqFv91FFx3aAlDDRzTq1A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> We do memory allocations here, read blocks from disk, all sorts of
> operations that could easily fail at any given point.  Instead of
> panicing the box, simply return the error back up the chain, all caller=
s
> at this point have proper error handling.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 6d3a80d54b32..cebf8e9d7d96 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -737,10 +737,11 @@ static struct btrfs_root *create_reloc_root(struc=
t btrfs_trans_handle *trans,
>  	struct extent_buffer *eb;
>  	struct btrfs_root_item *root_item;
>  	struct btrfs_key root_key;
> -	int ret;
> +	int ret =3D 0;
> =20
>  	root_item =3D kmalloc(sizeof(*root_item), GFP_NOFS);
> -	BUG_ON(!root_item);
> +	if (!root_item)
> +		return ERR_PTR(-ENOMEM);
> =20
>  	root_key.objectid =3D BTRFS_TREE_RELOC_OBJECTID;
>  	root_key.type =3D BTRFS_ROOT_ITEM_KEY;
> @@ -752,7 +753,9 @@ static struct btrfs_root *create_reloc_root(struct =
btrfs_trans_handle *trans,
>  		/* called by btrfs_init_reloc_root */
>  		ret =3D btrfs_copy_root(trans, root, root->commit_root, &eb,
>  				      BTRFS_TREE_RELOC_OBJECTID);
> -		BUG_ON(ret);
> +		if (ret)
> +			goto fail;
> +
>  		/*
>  		 * Set the last_snapshot field to the generation of the commit
>  		 * root - like this ctree.c:btrfs_block_can_be_shared() behaves
> @@ -773,7 +776,8 @@ static struct btrfs_root *create_reloc_root(struct =
btrfs_trans_handle *trans,
>  		 */
>  		ret =3D btrfs_copy_root(trans, root, root->node, &eb,
>  				      BTRFS_TREE_RELOC_OBJECTID);
> -		BUG_ON(ret);
> +		if (ret)
> +			goto fail;
>  	}
> =20
>  	memcpy(root_item, &root->root_item, sizeof(*root_item));
> @@ -793,14 +797,20 @@ static struct btrfs_root *create_reloc_root(struc=
t btrfs_trans_handle *trans,
> =20
>  	ret =3D btrfs_insert_root(trans, fs_info->tree_root,
>  				&root_key, root_item);
> -	BUG_ON(ret);
> +	if (ret)
> +		goto fail;
> +
>  	kfree(root_item);
> =20
>  	reloc_root =3D btrfs_read_tree_root(fs_info->tree_root, &root_key);
> -	BUG_ON(IS_ERR(reloc_root));
> +	if (IS_ERR(reloc_root))
> +		return reloc_root;
>  	set_bit(BTRFS_ROOT_SHAREABLE, &reloc_root->state);
>  	reloc_root->last_trans =3D trans->transid;
>  	return reloc_root;
> +fail:
> +	kfree(root_item);
> +	return ERR_PTR(ret);
>  }
> =20
>  /*
>=20


--lDZExIhKhcVTfqFv91FFx3aAlDDRzTq1A--

--kGj3GCnNbdYromb8z9udillOLmS9Xc3QJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IW48ACgkQwj2R86El
/qiTygf/YrQYEvBDBTTtw9/3WzZS1vST8SvI3/+Y0PBWYJGvMkR+xzGaDynMOEmQ
VDVjYVQ7dXj2sKUBRd0KAdatrLVT2ayfqa0wsNEAvfe/VIY9xjcNYSctNXLVEPcf
mxIjiRvEKeHY8rZp/q/yKvD4VNT036gYGVwTNPLFb8+X3nfDQpT74xfAtGUIgGhV
OhjRuCM5ST1xYtnFhsRD+x6yv8w+EkycEMghrQew62KK2CEw2CvUAAbNsPNI9AJa
+pEon0xCe6ArEd9i9t2xg1lCWaMeT+W8y7ZOKUnM6sDXWaY57xiDLMa1y45rZDsG
H+t5b/cZSXozXHg1mQaS9/H4F0zvZg==
=rH/h
-----END PGP SIGNATURE-----

--kGj3GCnNbdYromb8z9udillOLmS9Xc3QJ--
