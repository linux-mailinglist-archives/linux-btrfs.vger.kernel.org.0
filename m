Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE33D17331A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 09:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1Ilh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 03:41:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:43531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1Ilh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 03:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582879288;
        bh=TdNes+75c1hh89dP0/XUyrszPizxUjTwDL4xGsIcODY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WPbN09qpF/8AS+BeLUBsFRBum7im9joYjqPvJy+0c9Y3TXHL48SpjfBDNdWF2I+jb
         pKRlLMB0K6YB1hOECj2h4a5ej/xG0x8dSojhqKyLLp0BGTJ11fZFqAtq+jUH6mFnKh
         pyOFcRGXBWlR8zOo3duPZmoYZlO7hQZjURaMkvng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1jnqm52T9O-00kzIL; Fri, 28
 Feb 2020 09:41:28 +0100
Subject: Re: [PATCH 2/4] btrfs: simplify tree block checksumming loop
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582832619.git.dsterba@suse.com>
 <4f450bbeec245479a3bc2b40d023d1979d622587.1582832619.git.dsterba@suse.com>
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
Message-ID: <a21a2263-c2d1-084b-4ebe-6f909da4afcb@gmx.com>
Date:   Fri, 28 Feb 2020 16:41:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4f450bbeec245479a3bc2b40d023d1979d622587.1582832619.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZmfEJ3DPv6rluK2IEI3H4Vq8ggc4NJPFl"
X-Provags-ID: V03:K1:odEKCSz9/r9Xg2I4B2bWz2Zwhw0DiTkGkNG2txCSrxhgsuUa9Dq
 6Uoaf/Bh26feXKX6BfzINuyhATN9MlwNyR8P7GGO1BbdftssspE++ElbQVln15iQNZIfkBG
 SckP7ygpEeZw+dwdcFM7M4zPZuV0zHRU7m/xYEt1LCaOSL4lV2+d3ZkBsZIxfxPvURbI3UM
 pdtmyvYnWUqpIO4TofscQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nm3fF6fMNa8=:oXnSp8elF/t4Gp/+kEov5o
 PlKl+lcengnbFZGMNoRWx5yu5uVHCBe2gUREwfjsE2M6NAz47iqrU64VC6zpYdM2r6nxJC+q+
 U47OMtKtIY4pfycYJFaJDP7p4HSW+eFYvQk5rzt79p7DwjSIOp7wemtWDLnMpQsUPYfgIUv0I
 QB1mxj440u7jMJYmRbxJnh7Gg6keVdg/Fwvcfcrc+AJxRgE/CH0TTlZnf76fOsfs6JJV+hcAA
 0yf/bnQOS+lOPL5wPchjBfufNXhiiCK5VWJVhggSKqrIrvs1rE0/2t6U2mkjJB9OIPph3uM6m
 yHxHixCOwzzK/i/21WS/PartKyWTCWRE4gFkWQeidGWKNGPW8wPUWpkAuXnT3w3Pf6Nd3o7dt
 EFrzvyMeqC5QV3nFbbJ2P39W1oYX33ubuoru5ncZM11BIzvRHoPfzeLIYC7ppEr4VfTM4bYtS
 ybH8rV2SDKldl3bPVBzs/NkIeDFJGPv4mvsiZ0K6+H6PA7mzgqmXZeOg3qT/n0DjsTnlCQ8P7
 Vg1qUPbBkXtzOmZKoea6Cc7KnyDcTuWVa1KB/5f7Yst+S6xmdMSDKwqbhQ4IHjLg6OXCRElRu
 8KALfUmAY7Nunq6wnMUCHyBITj71jr8o73NN6mzfDMlOzC6cLcoWlEnf0LLUr4sWrZasjoXec
 xZdGMttedhhAF75OcWOZ4iRPE7mfD1N4agLbLugoAKKtZnNF8rcChc8zJrEMsp/OxIV4Gc5W2
 tgNHJPoN71VN9iSQn6sCZKm4AtMcdna/kSN8bEaLfYZQezldfxWqMc/xMHwyoO6UMXm/aXjp4
 ktSzHGqq0MdFN4EgjHKkuKuMRKd8QCdiVvu0FSI4MoKrAoBPFfHCA8uF1XLMg7TyLZemVZV26
 GPflVPISLN3AOM8aU2r2ayyu82Qqbn9ydDMqDCH6e0etvq/Ti7XeqK+PaAM97bqkhem4m9XC2
 PIvi+k4uUOYd4B2HVhbjdVqnZpkbyqDnPpGFtjyWGfOWq26MsDyV9LAOyMudBTbEi9CX/rGr/
 +lAi/4kwy/0fAomHPdENS4+fieC0AqQuUo2t0A2YVkO9+dRGIdoxb4fDmIBB3j2TE/sqJXSB5
 HEXdChWJCGcbRaw+lbHAzT7H9KSf1/UOd8Ma0x2yXjdkMeGkSdS72jw9DOHjVvtD+3dh+sjTv
 TdMRIgohzZ85rDbumYaAjWZh2Jhia09Qz+LwwmcJ9arzwANYfcMihjDXHbZtIxOgG/oBsMHjg
 S6vdzfLk/hg/1B2A5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZmfEJ3DPv6rluK2IEI3H4Vq8ggc4NJPFl
Content-Type: multipart/mixed; boundary="lm576WCyOeJa6THeof6zfJF1pE2soeLcu"

--lm576WCyOeJa6THeof6zfJF1pE2soeLcu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=884:00, David Sterba wrote:
> Thw whole point of csum_tree_block is to iterate over all extent buffer=

> pages and pass it to checksumming functions. The bytes where checksum i=
s
> stored must be skipped, thus map_private_extent_buffer. This complicate=
s
> further offset calculations.
>=20
> As the first page will be always present, checksum the relevant bytes
> unconditionally and then do a simple iteration over the remaining pages=
=2E

The new operation looks much better.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/disk-io.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3952e4a2f3d7..5f74eb69f2fe 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -259,38 +259,22 @@ struct extent_map *btree_get_extent(struct btrfs_=
inode *inode,
>  static int csum_tree_block(struct extent_buffer *buf, u8 *result)
>  {
>  	struct btrfs_fs_info *fs_info =3D buf->fs_info;
> +	const int num_pages =3D fs_info->nodesize >> PAGE_SHIFT;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	unsigned long len;
> -	unsigned long cur_len;
> -	unsigned long offset =3D BTRFS_CSUM_SIZE;
>  	char *kaddr;
> -	unsigned long map_start;
> -	unsigned long map_len;
> -	int err;
> +	int i;
> =20
>  	shash->tfm =3D fs_info->csum_shash;
>  	crypto_shash_init(shash);
> +	kaddr =3D page_address(buf->pages[0]);
> +	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> +			    PAGE_SIZE - BTRFS_CSUM_SIZE);
> =20
> -	len =3D buf->len - offset;
> -
> -	while (len > 0) {
> -		/*
> -		 * Note: we don't need to check for the err =3D=3D 1 case here, as
> -		 * with the given combination of 'start =3D BTRFS_CSUM_SIZE (32)'
> -		 * and 'min_len =3D 32' and the currently implemented mapping
> -		 * algorithm we cannot cross a page boundary.
> -		 */
> -		err =3D map_private_extent_buffer(buf, offset, 32,
> -					&kaddr, &map_start, &map_len);
> -		if (WARN_ON(err))
> -			return err;
> -		cur_len =3D min(len, map_len - (offset - map_start));
> -		crypto_shash_update(shash, kaddr + offset - map_start, cur_len);
> -		len -=3D cur_len;
> -		offset +=3D cur_len;
> +	for (i =3D 1; i < num_pages; i++) {
> +		kaddr =3D page_address(buf->pages[i]);
> +		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>  	}
>  	memset(result, 0, BTRFS_CSUM_SIZE);
> -
>  	crypto_shash_final(shash, result);
> =20
>  	return 0;
>=20


--lm576WCyOeJa6THeof6zfJF1pE2soeLcu--

--ZmfEJ3DPv6rluK2IEI3H4Vq8ggc4NJPFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Y0jMACgkQwj2R86El
/qgNjAgAiv43xMINCXPvi+qRHG9wwy5+l4DdsGaAjkmlbxCYwwI4SF57E5afdwE/
/z8ShkByd9wNmYc1ufpibSVaSHxKay5Bg8CHPaufzQlFQ7PGc1DVnb0WcpoDc/cX
tQ3B/o20zrCwMf+Wgl9PI0MwDXIz8A3Hr1OLXb3OUj1QzK/M2V8Wa9x9OUeJZV+O
L/JrjwUZGDz6p5uRmp63sjCXOx1A7ap//sAdwSw6Q5w7viIQbYhbz2l6nZ2Y0Ruq
0OZoNqSCIw72oKUKVi6eEpWw/QOEyKapSUoy9xbDjs9Rvu87uuDQoQQxdnMTIow8
fEdnkvq5wEVKWnt3z+NXt1gziPNjxQ==
=5nsK
-----END PGP SIGNATURE-----

--ZmfEJ3DPv6rluK2IEI3H4Vq8ggc4NJPFl--
