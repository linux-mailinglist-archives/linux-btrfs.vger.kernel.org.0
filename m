Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658062A2C47
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKBOH0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:07:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:57511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKBOHZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604326040;
        bh=m1Hsb9rk/pOVPxEx2qfx8stemZ26nKP7TnbAD0XdGRE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Y0x6jeyd8tIlBQfxkWDsvdgdjZdCYQAnHf4eZtyJjdgGlnFsJ7koDteRj5+xzAfbh
         kBfYlBlVJnZfuGnSWDOYWQUJOHkIQiL2uNDhOCajWDWhzjVH+tFbgaB5LA7hWTCQ1m
         A7kr6iBYNoliN+LxUvjH06YU9Wlc5LvG+Kbq+d8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1k92ts3dnz-00hwPG; Mon, 02
 Nov 2020 15:07:20 +0100
Subject: Re: [PATCH 02/10] btrfs: replace div_u64 by shift in
 free_space_bitmap_size
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1603981452.git.dsterba@suse.com>
 <8eeec6dd99180d96b96168d24fc4205c0ed48f36.1603981453.git.dsterba@suse.com>
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
Message-ID: <d25cb311-83f0-4f74-4c73-5f5a58290048@gmx.com>
Date:   Mon, 2 Nov 2020 22:07:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8eeec6dd99180d96b96168d24fc4205c0ed48f36.1603981453.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oilv9E3e715uf6tATN8Bw2c50LstcSGKb"
X-Provags-ID: V03:K1:yReoiCCmqLnUUOYAC28gNRQ2hf6PzK8iQR5r1oQRdT7+rp5nN/b
 lQiPM5I8zZsGqwCU9PBU9uRGvPTI3cFyWiQzXuPPvHXzPJa884ljj6vcK+nx/UOR9iptHfN
 huwaxZ2eG3hdD1/gB3KAPJ9rYuhjTz7HZ6/ef5Twfushgq+AFd9GsJyhYMxy0GNRzFFmFDL
 GluNdt9wWaAZYOd7+N+PA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdo62LuDG0c=:I7rTV6zKNZo6Hj7T6Eu81R
 AA5sLv6C2CaeZyYpweFKD+Y0P7iPSbd4uUc90Z/CC/N/TDTAWyx6xifBNxbWPGUy74rhxBRY8
 MCJY+CelZwqhXOyE1IZ2zIxP8Gah5oxDsnc6OjB+lNcvKiqw9Mle+SVCb5t5k72HqZE/geYLP
 B07dCb2+w3VExV5pjyQEbagzHeX/sEVKgdzZFrx+OiTZ80WzzaO+7gunWv+dyUSj8Ou9u/omk
 yJFc3BaNf7loyRWLq4J2RwsIy7muP0V5Oxn5S/lGX7nshVgWz2qKmFRPr8opzly40V2njeVPx
 BCt/9MJvImtaM9xS9wAXi04+wxvbsYlp3deQXAHTnaSsLkWI83PaL69tyeT1qtXgG/b9iEelP
 LF7us4CY26E+d7KWAg5vUShk3f2s12Mg9fArVIJeGWs8a3o0MuO2X2NiAP5KSWiWyUwyzpGMt
 gNh6PvsIr6gC4+gwzVuEI1klMXTzLaRtu+dUKu3Os5xCzK/zpw5KdBNsOKSqyA7f9V7Pkclcp
 3KW19xNoGMlrhBukOZyvqdQ4+Nou4n9XIfpywp9X5+1xUERBEW/sv3rWvfBunBZu2TvyKA6Gj
 tIcrYdoHi9KARYBH+t9XBT/4OQjmzVTXFPe8oE6uIv/tSzOZEFfTuY+LGKViCeXEkpT8gSoFf
 HfQKR6eAThoU14f9s+W09voMm4QQftKa4t8QBW4MQnViKmdNtaaHGK9rIdd2XfTD81i8b+PDU
 /EYwWnvOxH9moxyBqA0VaSngwQ+9wRxAvLOySvb40YNccJ7F74TE+yeF+z8GGeUJYHyfpzkfP
 3dWeWvaBPHSOJt0AJ3PHFfJncbcN1BHOkgBQgPkN+36BzaX5fNbNLAfYwH9YQhu+YcUMfUR2B
 zmZWRSV1HDEusRFy6psw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oilv9E3e715uf6tATN8Bw2c50LstcSGKb
Content-Type: multipart/mixed; boundary="3rI29nNYLaw1VTuLDnOJe0LBJpEEb2tVF"

--3rI29nNYLaw1VTuLDnOJe0LBJpEEb2tVF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/29 =E4=B8=8B=E5=8D=8810:27, David Sterba wrote:
> Change free_space_bitmap_size to take btrfs_fs_info so we can get the
> sectorsize_bits to do calculations.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/free-space-tree.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index f09f62e245a0..0f6a2ee6f235 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -136,9 +136,10 @@ static int btrfs_search_prev_slot(struct btrfs_tra=
ns_handle *trans,
>  	return 0;
>  }
> =20
> -static inline u32 free_space_bitmap_size(u64 size, u32 sectorsize)
> +static inline u32 free_space_bitmap_size(const struct btrfs_fs_info *f=
s_info,
> +					 u64 size)
>  {
> -	return DIV_ROUND_UP((u32)div_u64(size, sectorsize), BITS_PER_BYTE);
> +	return DIV_ROUND_UP(size >> fs_info->sectorsize_bits, BITS_PER_BYTE);=

>  }
> =20
>  static unsigned long *alloc_bitmap(u32 bitmap_size)
> @@ -200,8 +201,7 @@ int convert_free_space_to_bitmaps(struct btrfs_tran=
s_handle *trans,
>  	int done =3D 0, nr;
>  	int ret;
> =20
> -	bitmap_size =3D free_space_bitmap_size(block_group->length,
> -					     fs_info->sectorsize);
> +	bitmap_size =3D free_space_bitmap_size(fs_info, block_group->length);=

>  	bitmap =3D alloc_bitmap(bitmap_size);
>  	if (!bitmap) {
>  		ret =3D -ENOMEM;
> @@ -290,8 +290,7 @@ int convert_free_space_to_bitmaps(struct btrfs_tran=
s_handle *trans,
>  		u32 data_size;
> =20
>  		extent_size =3D min(end - i, bitmap_range);
> -		data_size =3D free_space_bitmap_size(extent_size,
> -						   fs_info->sectorsize);
> +		data_size =3D free_space_bitmap_size(fs_info, extent_size);
> =20
>  		key.objectid =3D i;
>  		key.type =3D BTRFS_FREE_SPACE_BITMAP_KEY;
> @@ -339,8 +338,7 @@ int convert_free_space_to_extents(struct btrfs_tran=
s_handle *trans,
>  	int done =3D 0, nr;
>  	int ret;
> =20
> -	bitmap_size =3D free_space_bitmap_size(block_group->length,
> -					     fs_info->sectorsize);
> +	bitmap_size =3D free_space_bitmap_size(fs_info, block_group->length);=

>  	bitmap =3D alloc_bitmap(bitmap_size);
>  	if (!bitmap) {
>  		ret =3D -ENOMEM;
> @@ -383,8 +381,8 @@ int convert_free_space_to_extents(struct btrfs_tran=
s_handle *trans,
>  						     fs_info->sectorsize *
>  						     BITS_PER_BYTE);
>  				bitmap_cursor =3D ((char *)bitmap) + bitmap_pos;
> -				data_size =3D free_space_bitmap_size(found_key.offset,
> -								   fs_info->sectorsize);
> +				data_size =3D free_space_bitmap_size(fs_info,
> +								found_key.offset);
> =20
>  				ptr =3D btrfs_item_ptr_offset(leaf, path->slots[0] - 1);
>  				read_extent_buffer(leaf, bitmap_cursor, ptr,
>=20


--3rI29nNYLaw1VTuLDnOJe0LBJpEEb2tVF--

--oilv9E3e715uf6tATN8Bw2c50LstcSGKb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gEpQACgkQwj2R86El
/qirGQf/YOZEjzvMn+Yy1N1nAYEEAMNj3haldLJkskhvbjS3SMKWWtKTY164imzx
m38zs5ePChH+OAYj4kV50VO7WYbbAE4H1DjgToD8v+2IKyRLoKmtSi9KL2bsSKAO
Xn1Y8SQIbZg4POn0JkNyjXK7f4iOB7f9mdHo1nPfwiL8zFzKESAAvpU87ByqGnHW
dEu53tXd7tt5/glAya4rMBlNT/PPidI6sMCIVSX1yGcRGHWY/gldBe56kd3x3VYm
KTv2kdLbAiBtYSoeicR+DJ2s0aNPkyTmN5iJW8puNHq7rMPgEEQ0GGaw446IfLgY
03t2cO9cLuZ0+LUY+V/uc/V6ugnNCQ==
=+mNr
-----END PGP SIGNATURE-----

--oilv9E3e715uf6tATN8Bw2c50LstcSGKb--
