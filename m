Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650D9173323
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgB1Inb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 03:43:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:35821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1Inb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 03:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582879405;
        bh=qKqqxBTxiabUhtsTrS62OUSIlFO7oXgUrw9jezo/0fM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lTp1VESxGyc4/9kID5xENuCNBj8V5kAevH6V3sLlVlC4cMkhvFfJk7LEX4zuWe39s
         /lA6rOW/pfjHK9g9LWpvsDxRcPeBFnRuXF618sLLiAABHTPahIVwF964sDKc1A2yvR
         8M2jNLv0QH8P0s7pwPKTSozzSfQkRZRfKwD7orrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1jME9K1c5G-00x0YX; Fri, 28
 Feb 2020 09:43:25 +0100
Subject: Re: [PATCH 4/4] btrfs: balance: factor out convert profile validation
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582832619.git.dsterba@suse.com>
 <0432001929a87bd8fc75019ca67257d21d1b1315.1582832619.git.dsterba@suse.com>
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
Message-ID: <2a6dc262-d355-b488-d342-6402014e8cf4@gmx.com>
Date:   Fri, 28 Feb 2020 16:43:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0432001929a87bd8fc75019ca67257d21d1b1315.1582832619.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="flc4dH1nVfSaWyuGbk3axTgE224D1oc16"
X-Provags-ID: V03:K1:VYdCl6Nt3ZiqUiJfiRuUoJQscdhp0ZQTrzXkoOOyF5c1UkVYCMf
 dJ3H6swZPeCeJa/65UV7J7lK+ffWXEanVnarwAUXBACGO8KO2VJNRHJL7Chw3zopMrsO3ai
 SbE15ehG+eMQ4lDijdp1ohKPIFQZmD3O6LnLkrJtlSEVh3vmH/+Il4XhFcFZDH+ln6RrS72
 scBzvh+5s7XDJf+8r1/ig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+GpA+r9KRe4=:p3ZYNpjHwL5UZmzd7ZKARM
 WLIs9OUJRV1IcFzZoK1FOYB9drz5dbI6f4CXiQZBieS7BYMucg2keFBWO1FApIuup34JAwi/g
 rQI3Nw1Di5jzbUzGejXm0AqFoW2rblBz6MZIswxBvJhPnszm4MKV7foAzzpluqdUe6T/xBf1W
 QeWP1lAX3M7gv73xY0uYN1+kNwbpFjWOiAPxC/62p83SkeX8hqy0xwpovqxhPE44AjyrMgIlc
 6FM40xl6bJjEPKv0HqGZ+1ZCUmuEIfcfPURsE9U+b8IAv6I5ZoBgaFEBSGD3kqbuaz7DME75h
 laheQy2D5GfuH0usU2kvanrlzVYNDX8R/L8HSGxcMBahjqz6B3Hai8EtAwcPl1bbyL74X+XZV
 hYT8eJdkLoJG2Q1+zPk/87PbnyVDuWly+sKpkwH0wOTh2orGAWAyWVq6gwk/ho+7U3OsmjgWn
 yzXQ/BMRCBrIt8PBSdHymdXZ9f1/aPpuHGokItYO1+T43tMvJk6fDYS2mgwbvVje4IcoLkTDR
 cdHQoG7UCRYkKIlP8ecxO2Q4AU9W/X+o80BBBblZQHpTUV+lWBq6an340jSVP+SQobL04C2jw
 O2CWXwzr6q6nOXWeL0XdVV/YvBQfBqWMCbHMS8Ry+NsEsJ5RFejuKAudLhgqCNC8fqlc4ErDR
 55Zfpdv8GB6EgXg+3NweFaoy81ysNieTmFYvQ6byNkoHGPLYeIx3kzD6p96HjEOuvVTCzRWTB
 uoKZjzYYF3xnGNdmekHjegP5EYizmtlyxDf4u/GfaESdzAhYqsCEscddKeiQON0wGOh3dWrGd
 ghka9EnIoeoLmmTkSRj+o6r0Li8CJpc6Xa/B2RomYECXlaJPRRGzUnh4QaGofqoIENwYfH5zM
 64FyXmsazEsUFlGCv0TMo9ljBk9FJGZ0/70n2vfxYtJmaoQP9CmI7F0WS/a8py4GUfkMIfnu+
 pq4GSWhLf6SOAt4m56yU1Se0SgcdnkB/Q/Q3tlsqhg8EeEuC7IovjtiJjYUVbyomaZe6ThRgT
 ywJeiNCQDBp2Y5cRosRDlH6ZbmlS4pJoLyjWee4EOzgN1QIxzk/WoLjgiTRBBOLCLDyIZvZSJ
 gdIPvmTljt+GGQMq/FskiZ7Wp1QPGZQBGpiwLIWitqoruEBfhDNTb4KaBMualdeEi8+jcvxt6
 ikIPGivUqIctO1KGsfOnfmxE4qODAWpo75nPNBzItLQrKDWLl6sP9TwgT6DXVyIEiU5OGAXfF
 l+3IYxBUXX7djPujs
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--flc4dH1nVfSaWyuGbk3axTgE224D1oc16
Content-Type: multipart/mixed; boundary="TedWhMpvHPijUWplHHmz5iJ21W2SgMKPc"

--TedWhMpvHPijUWplHHmz5iJ21W2SgMKPc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=884:00, David Sterba wrote:
> The validation follows the same steps for all three block group types,
> the existing helper validate_convert_profile can be enhanced and do mor=
e
> of the common things.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/volumes.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3d35466f34b0..b5d7dc561b68 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3762,13 +3762,25 @@ static inline int balance_need_close(struct btr=
fs_fs_info *fs_info)
>  		 atomic_read(&fs_info->balance_cancel_req) =3D=3D 0);
>  }
> =20
> -/* Non-zero return value signifies invalidity */
> -static inline int validate_convert_profile(struct btrfs_balance_args *=
bctl_arg,
> -		u64 allowed)
> +/*
> + * Validate target profile against allowed profiles and return true if=
 it's OK.
> + * Otherwise print the error message and return false.
> + */
> +static inline int validate_convert_profile(struct btrfs_fs_info *fs_in=
fo,
> +		const struct btrfs_balance_args *bargs,
> +		u64 allowed, const char *type)
>  {
> -	return ((bctl_arg->flags & BTRFS_BALANCE_ARGS_CONVERT) &&
> -		(!alloc_profile_is_valid(bctl_arg->target, 1) ||
> -		 (bctl_arg->target & ~allowed)));
> +	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
> +		return true;
> +
> +	/* Profile is valid and does not have bits outside of the allowed set=
 */
> +	if (alloc_profile_is_valid(bargs->target, 1) &&
> +	    (bargs->target & ~allowed) =3D=3D 0)
> +		return true;
> +
> +	btrfs_err(fs_info, "balance: invalid convert %s profile %s",
> +			type, btrfs_bg_type_to_raid_name(bargs->target));
> +	return false;
>  }
> =20
>  /*
> @@ -3984,24 +3996,9 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,=

>  		if (num_devices >=3D btrfs_raid_array[i].devs_min)
>  			allowed |=3D btrfs_raid_array[i].bg_flag;
> =20
> -	if (validate_convert_profile(&bctl->data, allowed)) {
> -		btrfs_err(fs_info,
> -			  "balance: invalid convert data profile %s",
> -			  btrfs_bg_type_to_raid_name(bctl->data.target));
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -	if (validate_convert_profile(&bctl->meta, allowed)) {
> -		btrfs_err(fs_info,
> -			  "balance: invalid convert metadata profile %s",
> -			  btrfs_bg_type_to_raid_name(bctl->meta.target));
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -	if (validate_convert_profile(&bctl->sys, allowed)) {
> -		btrfs_err(fs_info,
> -			  "balance: invalid convert system profile %s",
> -			  btrfs_bg_type_to_raid_name(bctl->sys.target));
> +	if (!validate_convert_profile(fs_info, &bctl->data, allowed, "data") =
||
> +	    !validate_convert_profile(fs_info, &bctl->meta, allowed, "metadat=
a") ||
> +	    !validate_convert_profile(fs_info, &bctl->sys,  allowed, "system"=
)) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
>=20


--TedWhMpvHPijUWplHHmz5iJ21W2SgMKPc--

--flc4dH1nVfSaWyuGbk3axTgE224D1oc16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Y0qUACgkQwj2R86El
/qioGAf/d3KlwliNmso2TJIbZbU12t+or32Tsv1HqX/Y2hT9xkRifBWQEgMIviJY
IeaYWUjQeToxsnfAUdpXNsYpNci91Gp5MlLcbMsoHtqVANZ9gc/bcOaTIGxqzDj5
hm61SKhJPd1nJ2wShPCgOPlAYBkXGBvDduLr2RRxIUw+ZW+8EvCGeFzSttFyCJg3
yctBOz3lF6cub+kyxGyjHefKUiXe580DT7UMWu+zBgAfnwRolfO6LCMpNSJNLUrN
SlIN7WHdmTQqncjWD7uemzmy2WdmpllM0nfJYLCRbbQBBdp9DmuzWFInE97zcy3R
RpwUPcEv80e8SsX8NiJ32RRwFWmTWw==
=/HeX
-----END PGP SIGNATURE-----

--flc4dH1nVfSaWyuGbk3axTgE224D1oc16--
