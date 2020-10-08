Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4B286BEB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 02:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgJHAGh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 20:06:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:35375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJHAGh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Oct 2020 20:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602115588;
        bh=IfdleJ8K5otbbA9sCFajr/ldSIDh9pa42HFMdA87/cE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D/8Re+BaKdm3e0XMdR7Z2h9cz87Eql8swTVAwmxGly5sAIRn3lYtC19SGCIKquV7B
         u+51odrLC8UYYAoIhrMwjd48s4Tv5TvsBJ7PbFnHd1DGNRcHN36oxeIsKAmCqIzTXc
         gtANl7QiHQowq6BvRs0QuG0xRDgmUXWlXeUGd90M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbzyJ-1kw4ZI2ZKx-00dYnK; Thu, 08
 Oct 2020 02:06:28 +0200
Subject: Re: [PATCH] btrfs: Fix divide by zero
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, josef@toxicpanda.com
References: <20201007182531.2201548-1-dxu@dxuuu.xyz>
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
Message-ID: <a26e9e34-ff96-a8ae-0a26-bfc18393af00@gmx.com>
Date:   Thu, 8 Oct 2020 08:06:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201007182531.2201548-1-dxu@dxuuu.xyz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aKRnfA9HfE1npQR6qIeJn14SjDMSBdk6x"
X-Provags-ID: V03:K1:pVcfJFY+WTPjKwyzgL+Oes98UsMxY20L1GtVB2IYiGp3YSGr2Cc
 7S3gLle0GFj1nhjYgMmdVV6mHECDgCsTEj1rz+CN/O2aLHYC8QWRifsQMG23KatElnhSFJa
 KBnfGTY9tP02ejUtKODTURF1xbpB/ws1ASUjzjyrNURv+kaaRXJg+6piouDxK4tRECBhofp
 LMkg7ZIzVSzDyTsADNNsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7WhUrG0m88=:sL0KYHRfqk916KlemZ5o6N
 1jbrulxf7sjICSdBwYm8+lIisli0WtfqeEn0/nh7PHXLTSG/AMnzK1eQalRIPG+JUzP4h7baW
 74B2Fj6ifTe403i1RWjog70PM93A9iOAykCQDulo0i2e/92UDo/qzRo3UxczcYED5auqUslRF
 LFwempY+g6JZX06Siw8GUyQIt/mTgrmeDC6N5SekgBRT7ONzdBFfOngJtnN+8h65/McC2TSY5
 N8Cd1DzsoxVjSSMcngygbda7ZoJKXTuoTw2wHY+ttZZEENt3PSYAvMcQrKMxlbsgXiRF2YPzW
 SmmoptbhefxBjDUPQHF53x1rmv2r2pKFifDYiGEenRERZby5Fg2qcMMoiSmnpAgg5GWgsT4ft
 JbchHkHHYE/+ajcrR/3d+9pf/yqF0VFHYtPTlSz+k3HiHIofx3+LTOxPsUd4MH0UTrvK54SyJ
 3iAbxMOmS9LrLq0dt5S5Tb5hBQL/QtMtuC7WoBKEazkfpLG+eGkrLaPc1VvOiLsZxpVCYChWm
 TJyZWF9RVR1m5vKxfdb2MTjpiBBVzRsY/UuqXR2vxzohT4m46WPGERnf3R5frvz+Pp2Cwn8bQ
 J6RJScQWIV2mYJszTqy6ylird+yPqt4mogozuv0D76vpbRD7CHAuDNcztW/ktvNHLNTzwqaM/
 ciWaS/L28W/LvIdQGCOlIOupVp4d3YMEOezr/ysShtcT/HuTabh2bnXvfpJV2XZMn0qvxRIDz
 qiSdYoLxo1C5jDNWp6Ltp8FkjasPUUD9gVPkrQA4qT4J2gp6iRRZ+l2h/ILhNX7VvRRIb9taC
 Pqkcj+ex/9ihilIuwDwsU1KlDWHVu/jPy1W7+i9I3cCLNpaURbuNAJ72jSLl9dtP8CH8VszO0
 S9qdEOXbSWCds/zxDwQeap5QxyVIFsCQo3O0Hh1kzwYwC1moidvI3hBA4aPRvuM5+9cdXATVN
 a1AN6GiEnFYY0a5Fp6UYhJte0HaqR/BPZhVTsROFWIaiRaN0FHXIjPDS7bGtSMxnSQ4DJgxzs
 pXHZLv1qZBse4mTRH3YrJ1UjccuGUYE6S97R6nBfOp9nphBlzy9Z7JCQh/BEZ4VYU9sTUxUyO
 M5+AfPfOjAcu8zvMl4PHNFm0aD8xhc43OPq473XzkngIADUL44nuIAeEFDXJ6vhDxqd4dZqib
 nZI5f3qzXv4mng/rILSOBIMqgkZ7ARJAqChExGyEfLEVzx20i79828ixyo2b0pHV3g2iIrETd
 1YVOOpzJSg+09eGS/t/SL64tywm6FJamABZtUew==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aKRnfA9HfE1npQR6qIeJn14SjDMSBdk6x
Content-Type: multipart/mixed; boundary="tHk04mSoEcp53aBV4fQBhsKMwn2beMAen"

--tHk04mSoEcp53aBV4fQBhsKMwn2beMAen
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/8 =E4=B8=8A=E5=8D=882:25, Daniel Xu wrote:
> If there's no parity and num_stripes < ncopies, an btrfs image can
> trigger a divide by zero in calc_stripe_length().
>=20
> Here's a zstd compressed image to reproduce the error:
> https://www.dropbox.com/s/p11kayzhuia80xr/ubsan-divide-by-0.zst?dl=3D0

It would be better to submit the image to bugs.kernel.org and add it as
Link: tag.

>=20
> The image was generated through fuzzing.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Despite that, the patch looks good enough.

After fixing the link and tag, feel free to add my reviewed by tag:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 7b1fee630f97..e03c3807921f 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -760,18 +760,36 @@ int btrfs_check_chunk_valid(struct extent_buffer =
*leaf,
>  	u64 type;
>  	u64 features;
>  	bool mixed =3D false;
> +	int raid_index;
> +	int nparity;
> +	int ncopies;
> =20
>  	length =3D btrfs_chunk_length(leaf, chunk);
>  	stripe_len =3D btrfs_chunk_stripe_len(leaf, chunk);
>  	num_stripes =3D btrfs_chunk_num_stripes(leaf, chunk);
>  	sub_stripes =3D btrfs_chunk_sub_stripes(leaf, chunk);
>  	type =3D btrfs_chunk_type(leaf, chunk);
> +	raid_index =3D btrfs_bg_flags_to_raid_index(type);
> +	ncopies =3D btrfs_raid_array[raid_index].ncopies;
> +	nparity =3D btrfs_raid_array[raid_index].nparity;
> =20
>  	if (!num_stripes) {
>  		chunk_err(leaf, chunk, logical,
>  			  "invalid chunk num_stripes, have %u", num_stripes);
>  		return -EUCLEAN;
>  	}
> +	if (num_stripes < ncopies) {
> +		chunk_err(leaf, chunk, logical,
> +			  "invalid chunk num_stripes < ncopies, have %u < %d",
> +			  num_stripes, ncopies);
> +		return -EUCLEAN;
> +	}
> +	if (nparity && num_stripes =3D=3D nparity) {
> +		chunk_err(leaf, chunk, logical,
> +			  "invalid chunk num_stripes =3D=3D nparity, have %u =3D=3D %d",
> +			  num_stripes, nparity);
> +		return -EUCLEAN;
> +	}
>  	if (!IS_ALIGNED(logical, fs_info->sectorsize)) {
>  		chunk_err(leaf, chunk, logical,
>  		"invalid chunk logical, have %llu should aligned to %u",
>=20


--tHk04mSoEcp53aBV4fQBhsKMwn2beMAen--

--aKRnfA9HfE1npQR6qIeJn14SjDMSBdk6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9+V/8ACgkQwj2R86El
/qgE5wf/TKmTRNvia8yezQ1IqKXW+zEGBR0/Jn9sF//O6nUnUNAj8sJUolWLEFVo
cDNQ0xvxTs7U9RkBwIR2VZ7YSYCWcFknst8UtEIqZPYkYPGixBY+4Urt+smXdVSJ
hPaCNo4OzeQtuBb1pSSpshl3QuYcXheEACXvarrdtiUss2PgPcWqawRyO7+kF4/E
6yuqrQpVSvclcQxiTh817YZgb5+LTl51DW9T7+xaZ7YAo1K2Qk0qN0dYq5ThtsbN
Vz7xj8Ml3iXXJHVf+4/1peKgCo8lGikn2m9RmbOwcdLX7vaOnZNSQNfdK7taZoHm
eu3ikQXo6CyD+GAyzSuIj9KDGNdyTw==
=16iy
-----END PGP SIGNATURE-----

--aKRnfA9HfE1npQR6qIeJn14SjDMSBdk6x--
