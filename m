Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBCA2CCCBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLCClC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:41:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:32775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbgLCClB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963165;
        bh=SP/6IED8LmWASJfQYw9PAH/XnAYv8keg+qUPYC7GwpE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=cRbuplnjdGJUroswbhh5KCKaH7bwEwZLKWBoskGBDLe2fekIjmQt30+Fu4nQo69ep
         HVroUN8TKbKbkOk0Dq1GmVgyKi5tOc1PQblphT064ZQylAkrHndlZQH05jBG9wE/TD
         6CvZvwvlPKHwkFNP/8dxTahJ7vtbFkBtjyG0N6Es=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiacH-1kHvTf3FpP-00fiWy; Thu, 03
 Dec 2020 03:39:25 +0100
Subject: Re: [PATCH v3 16/54] btrfs: do proper error handling in
 record_reloc_root_in_trans
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <cf1b90302fa68b6ea40aa86d37153294bd4717f9.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <c4beb172-90cd-a61b-d852-9571e9d38128@gmx.com>
Date:   Thu, 3 Dec 2020 10:39:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cf1b90302fa68b6ea40aa86d37153294bd4717f9.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CSOx0JFt5JEUzitkV7hguVq0noYUSIwfk"
X-Provags-ID: V03:K1:0JJiLdvH6c0YmMlyDHlrCKh08a25CuRDYagzsC6Op2F9c7mEG8s
 wUlMLICF+lv7IO4jp2RR3H9cmwHv0knr8wUq8RyRYLRRvXHneaO54Ddo+RnWPTyoc6g+PdZ
 MPHpxOs2ynSND51b1QnDSYudwUG0JtxSKnPifgZ3z/sgCFhey+kZRmqA5l0d0AXbBIGGCuf
 rX8TOCZe8gWVpYAjyW9qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5vTvH5F2kew=:rl/XHppTXJRlRMGxlGZrNp
 TFm9rccbsHv6kevjrfTmITnZVAdcpSY5lUg8axFIS7P6rB2PC8LjEIYm+ZCAuI+z801qJAtXd
 FSmeMbPl6b/ihSdS+PQDp3cdDn6r+KWttd6E+Sm2OqpLuXzLV+Mw5ro05zHh+/hQcDNP7NhzB
 lrQGIVQCii1ZmAjUPMBhRSK7g6Ge0kSlFmcsVTqqtvf+N8NwKDrOG0y89Z61EAgeGsWgVgqSx
 cw5rxAd5QUIZn/A95hj0i2nLEDLx6Kg+Thq2UO/9tBWC/ayIyBottrcsNz5PJDclvAsX5NXn8
 HC3Xzpm9nKeUu6YphZYyIhXUwHbINLxiHG4oMwCpxzYxPlZZCXeYpLi4CaxRys5wiAlXeg1+c
 u6gfSL3GoX9zrPCG+T3lkE+FsdHQLgxGG/r7rk864Oy7E2CL/SdVd/XFBfPdq09iRDv6xjy2x
 nULMhtW4Khh3BkmwnBkcYQBEdcYZPjKwe5rKvwIyk7mNCVNtb6XJMDMrATmzfNmvIXHgSPv6U
 SFjgUcru9pg94gtQWtIa2Y26xPWw9SAM5lkCFBazfv+GbGuuVA3uN/bngxNy15ZEvMJtiIzgU
 jRqWrGBy/d4oKUgwElvUgfP4AtREJkMIIvF3porK5+8GdazOkpTrzou/H8FcnS/hCDZDf+lbq
 ElIOoWsmOkm/ZnAiRZEmBDvals0cJLAVX32Ne/mrrQekktMifKopQAZEBMOmcQEFCpskwRH3a
 v+4KNdgP5DJfDHnUt3jisAsqnxtBhMWY2KDYJBLTJ/QY6tGEC7+QFZdQKkJ8OktIINIBDVDzZ
 VwgB7Lsx0nlw4gJsPtwCxSBnmw1tKW1vlfhMPKndJrsm5k3Bhj08CVhnY0nLQGiXvh3V+mLgv
 TvT0UbqHsBLf5d/JRN9g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CSOx0JFt5JEUzitkV7hguVq0noYUSIwfk
Content-Type: multipart/mixed; boundary="uloQj5DbPchvZzPNxdVtpl8PknHzGHlza"

--uloQj5DbPchvZzPNxdVtpl8PknHzGHlza
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> Generally speaking this shouldn't ever fail, the corresponding fs root
> for the reloc root will already be in memory, so we won't get -ENOMEM
> here.
>=20
> However if there is no corresponding root for the reloc root then we
> could get -ENOMEM when we try to allocate it or we could get -ENOENT
> when we look it up and see that it doesn't exist.
>=20
> Convert these BUG_ON()'s into ASSERT()'s + proper error handling for th=
e
> case of corruption.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d663d8fc085d..5a4b44857522 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1973,8 +1973,30 @@ static int record_reloc_root_in_trans(struct btr=
fs_trans_handle *trans,
>  		return 0;
> =20
>  	root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, fals=
e);
> -	BUG_ON(IS_ERR(root));
> -	BUG_ON(root->reloc_root !=3D reloc_root);
> +
> +	/*
> +	 * This should succeed, since we can't have a reloc root without havi=
ng
> +	 * already looked up the actual root and created the reloc root for t=
his
> +	 * root.
> +	 *
> +	 * However if there's some sort of corruption where we have a ref to =
a
> +	 * reloc root without a corresponding root this could return -ENOENT.=

> +	 *
> +	 * The ASSERT()'s are to catch this case in testing, because it could=

> +	 * indicate a bug, but for non-developers it indicates corruption and=
 we
> +	 * should error out.

The same mention of ASSERT() now looks really overkilled.
> +	 */
> +	ASSERT(!IS_ERR(root));
> +	ASSERT(root->reloc_root =3D=3D reloc_root);
> +	if (IS_ERR(root))
> +		return PTR_ERR(root);
> +	if (root->reloc_root !=3D reloc_root) {

ASSERT(0) would be easier to read here IMHO.

Despite that looks good to me.

Thanks,
Qu
> +		btrfs_err(fs_info,
> +			  "root %llu has two reloc roots associated with it",
> +			  reloc_root->root_key.offset);
> +		btrfs_put_root(root);
> +		return -EUCLEAN;
> +	}
>  	ret =3D btrfs_record_root_in_trans(trans, root);
>  	btrfs_put_root(root);
> =20
>=20


--uloQj5DbPchvZzPNxdVtpl8PknHzGHlza--

--CSOx0JFt5JEUzitkV7hguVq0noYUSIwfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IT9kACgkQwj2R86El
/qgrSwgAl0TLGZS4cC+XAXci+e5cTIUSNf/1298g9CHA47bCH2ndRedc3zgjwTbE
vLJ4IC5nIyzk7wdMntynsh6MtXSn6HzCnJPmal1I2i6NXpyrHKAkWwaxLslTUBiT
CPl1GnvcPWyHO1QqCdjabVmjsUjGOCejNrcjCsDigvwqS1mSuKqvkXlZ8a9z7FxG
AYeWcu8ZFmSOtw9xIP2hB5NvPWhMSOyaRlCnjN5eQ8IF3C8lWLczSEKwCZ/NORqH
nEiezUp7WxMltaCGgcsuInIG/P4LT/N8L2g2fclTi1Mu0+105jWzFD5CTb8YoBa1
g3t52dyYfHxaLGpz84WvaexXULB8mw==
=cLt5
-----END PGP SIGNATURE-----

--CSOx0JFt5JEUzitkV7hguVq0noYUSIwfk--
