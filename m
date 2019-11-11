Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973E8F70AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 10:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKJ2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 04:28:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:51555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfKKJ2H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 04:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573464485;
        bh=A61BTWkb+MmD5hU6+5mQiyxo+jk9RouetskTfFJ/xWE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ORDDiWXTHG22Du+rXrKDFMJgZ6OSy9H5CP4M/APTOQYePvb15TE5WjFQYEDz1RukR
         6CXNDUQG/bEIS2VVmuBrMrkC5/uoav8UYuH55KBhVyU3B5xQmSOQ/Wuj9zJYcraGaa
         K0PTLvAtPjyQOZBvPo+l+MEVZDtk2QyYRkLMbX5o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLQxN-1iCqFr1mAV-00ISJJ; Mon, 11
 Nov 2019 10:28:05 +0100
Subject: Re: [PATCH 1/2] btrfs-progs: add comments of block group lookup
 functions
To:     damenly.su@gmail.com, linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
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
Message-ID: <97915605-5df1-ab83-ca98-3133b0648df9@gmx.com>
Date:   Mon, 11 Nov 2019 17:28:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111084226.475957-1-Damenly_Su@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Lfihqmgvglwmxy0HzEQQfr955I50GBqWv"
X-Provags-ID: V03:K1:mb1MsqIXgb7VQORkkzhDi7HoYo/HqZEJNlcg6aBDKBg8AmMliH/
 kAeA3/neB1LiuaQkdn3Swy33c7ruz/wptThy9pXLo9dbf50Szoil6w1AtUUNUGgNs3gxTNZ
 JHKc41swzjcGFeDBqptd219pPfOY63IktSAk+Fvl051VxQ3sDX0DP7xX2GZndFhhvCOO3ku
 slCUzbbDOEBSZnQxqoPbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WP4XUlyqlqg=:jJnVT7SrFyFQA+hTL4LIKq
 YXZ9HTdHc2CiqAQIk8Jgo2oRRQwOjr8SYb2wSXo3EGxvVO4hz8GkM4/qKIys8XS74El7KgkFD
 mXHsoxDovKmlkDUS8jXA8MzhUPHq6m0hVb6tUNjW+l/T9CfoiKx99a2+v/Nb7cqbGeCFs9e87
 58TMNNeQ5xIJ6DqZuEBe8OtOtPAOnGi1VL1YVgqXGgrFlrv4z8KgUCDOcldqh3gh2pBk8zR6m
 oP0Tqu7KDWwxcp5QVO/ef3eN5AtDzjbD/WYr2FZtvXwnUB6AExw0tqKYYNutRFxi7oopcwZNy
 pGIiIeZe1+ZTVlxFH7hS953/15dknD+TCXpiUVLURLf+sD66xfWRsHoK7yh6lUxIzmOBwyHZE
 ApQA/zgfHqA5rMz7vsQqAm8oz8l/7gdm42Kvh9DY/xBjQfRk9l1VBoYsWnmnXukJJ7MlRMA2t
 K3OuEHw9u1zEUj+z+4b6Uju50JXvnSrdEHmo+M9aM/oMzZt9JIc7++cxiHKTOUsr7ApOV/3fr
 W6/BB/vVIAPcu2p6i2JeoICt+4zUB7wS8APHMNuMX97LV0TT6OVaSL6ThoQY9+87vPFoXKqLk
 r3d+1PtVqND5egh41kky8g/M4LZVnnytJoDGSeHJiaBy7iDjxWRVdQJGuZE2JPF/CseLO31Qa
 b0JrB60qjNwvkLd+/N0BSLeAzwKWvT2aWluYydOTU9u6P2ixgslXOiijF72aaLCH3RXy3N3xu
 wyFmUAgfJeCw+mhKStaD+Pwno9PsWBsnbj2Sy2bDnGfGYDFEQiZUCx1xAYEvzH2fUxVqs4UoE
 fMEO4ZwRbu13iovw/16pib+1+5wZngkA26rs+IhySbDDbzVUo9J2opnFAm6zUbBJyFnMj3Jik
 4Rtj0i7O8NS8mJf3RcjJuaEXjFz/U2psRtW3MqsMIPMh7glzAM8ZfbvTaUVGdkafyB49NQMUd
 Sqfv2T2aQMaHK8OWFtTv01ISfhhWtc+8XdBWUbC5qYagrUOekhqHyjwIdI/iyW5TsNffrA/gY
 jlb5IqXXq0iLEGV+O5iI+xZYZzDOdHYuUSYPjBLP1jYbHU509s1Sczrs+aJHvPyq0Xl//zVXP
 VemL9D3Hi2tuBN/ZjQzfKZN+Lj69L8ijyQ90up6gVjkUWenePuQnKPz+Tgub206dD04oDS9j7
 3AuCbpU99jkg5LvoFMxoQmJIZZ2HZybnLPaEQ3KO58F9EqSn57iVSEXEvJAMOEF/8E02XkXEA
 E7Yja0xE5DkpAT4zuB5w+3fn3BdMY7UpXgt7E1dATKHcrBAXSpjMpFp1Xhxc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lfihqmgvglwmxy0HzEQQfr955I50GBqWv
Content-Type: multipart/mixed; boundary="L7uhQoz2o6B3XBi0cacPPOt3Qc6jybNME"

--L7uhQoz2o6B3XBi0cacPPOt3Qc6jybNME
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/11 =E4=B8=8B=E5=8D=884:42, damenly.su@gmail.com wrote:
> From: Su Yue <Damenly_Su@gmx.com>
>=20
> The progs side function btrfs_lookup_first_block_group() calls
> find_first_extent_bit() to find block group which contains bytenr
> or after the bytenr. This behavior differs from kernel code, so
> add the comments.
>=20
> Add the coments of btrfs_lookup_block_group() too, this one works
> like kernel side.
>=20
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> ---
>  extent-tree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/extent-tree.c b/extent-tree.c
> index d67e4098351f..f690ae999f37 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -164,6 +164,9 @@ err:
>  	return 0;
>  }
> =20
> +/*
> + * Return the block group that contains or after bytenr
> + */

What about "Return the block group thart starts at or after @bytenr" ?

Thanks,
Qu

>  struct btrfs_block_group_cache *btrfs_lookup_first_block_group(struct
>  						       btrfs_fs_info *info,
>  						       u64 bytenr)
> @@ -193,6 +196,9 @@ struct btrfs_block_group_cache *btrfs_lookup_first_=
block_group(struct
>  	return block_group;
>  }
> =20
> +/*
> + * Return the block group that contains the given bytenr
> + */
>  struct btrfs_block_group_cache *btrfs_lookup_block_group(struct
>  							 btrfs_fs_info *info,
>  							 u64 bytenr)
>=20


--L7uhQoz2o6B3XBi0cacPPOt3Qc6jybNME--

--Lfihqmgvglwmxy0HzEQQfr955I50GBqWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3JKaAACgkQwj2R86El
/qgNQgf/d+ZdDhuQTmKIqy56NqtYgzKGII7Mpu4k3U2fXVqUQl/RTJHnkQ05bJg5
7xAFByPWXUTZCwk5e+oKTfPk8DbXGEmwWVq6LZzKEMUYkg4gHVEWGPtz0cPJnLao
DdETE4044PWmP7ReKESWe8mJ7lLGO36+ifdwBd9N/t+r+oUw7bYOe3YKblXQl8Fk
peaZInaLcznOAiOCUkYUuJEmd78rVDyUdktMRqCg3dJ0gKIsDnnOHseedWEAiWhK
8E/lzOneiM7f2tlTd+cektOycWqLZk7p98GhzdoPcgOJs4G2sw9MtZKtueApDNGf
/rebwafyz8MZBTF6kR1oOOSjC2OQtA==
=p6g8
-----END PGP SIGNATURE-----

--Lfihqmgvglwmxy0HzEQQfr955I50GBqWv--
