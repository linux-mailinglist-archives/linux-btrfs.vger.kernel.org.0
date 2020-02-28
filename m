Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0881817330F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgB1IjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 03:39:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:39979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1IjD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 03:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582879128;
        bh=RH7CSZiXqW0C4T/ypr5krHIp8KFrF58ypQQEtcp5xBk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bZQ57bhEqqRNdGacPTNlK9eUihJrR6puHuxkzytUafJL0H8dX/GjoBALL6Cl/D9ii
         8ihmWMeEQismjWPwp7wGfC0LwmDmOD99xEgSrw/eEARn8DR0IQaUodeDfqiOLjjyGd
         BrW9OiFDJIBM8g8eIfAFZJi3qCCLr4uS5vi9lO1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1jjzKN2FMy-00pvjN; Fri, 28
 Feb 2020 09:38:48 +0100
Subject: Re: [PATCH 1/4] btrfs: inline checksum name and driver definitions
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582832619.git.dsterba@suse.com>
 <91753cb284a2dbce72e5b5b31b658e1c50ef084e.1582832619.git.dsterba@suse.com>
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
Message-ID: <690a6f32-d219-b3d6-a4b0-795ba6aeeef4@gmx.com>
Date:   Fri, 28 Feb 2020 16:38:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <91753cb284a2dbce72e5b5b31b658e1c50ef084e.1582832619.git.dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pyOdW97sL22UylBrPoDLXPqxL3BIc0rrQ"
X-Provags-ID: V03:K1:bVs4g4HNUJBkQ4HoE47H5h3+xgE8q8qNmy0nhod59S6BroftJkL
 +e2M2125nGFXrBWFQE6+dtNg0TYtW1a/BWeUpdlSKRgYe6OM1YQfjvdlu2+k7NLV9KYD5cJ
 d6VSkD0adUYrPREtkJ/KvuA29qsCz4R4fKLJlpZE5guN5B+cbxc6NFeXocHXH8nBKZe/BLv
 9T5+hTgDKgcbGP8Trz9lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fms+CdVxz9Y=:NdZAK6N/siLIn8uGVmFxY7
 Ex0gB2PIqqZqY9NLIBuHCF1vv1JDZzUsIwmPh+JYJOHzgk2VQ7FteYAGm7XMX1Q+zEKF9jkxF
 DOq4k1TSEBsS9Hy0lsvuu5/+9LgoVpTP8BdYOFxCDAJOpovOVfGx3joZb5EQ34Z2Dv4CulUSY
 NdhTX6E1Lgp7K+90DvTVKiG+bASmDUbU4efUN6vegcOAImyADYnaUgHFweqXny/+dnsIagbna
 Ct3u/rJCVkUuMLqcyasZ6Q6BvTDIb+ItiNxgml7r+e6UgY9eCk0lYM04Qa/P0WWx8Z72wWizM
 RxmTePCbE91AG2r6JlsXLtppuqVEC62rKFSVEhh2nOPhTB9c1QcmL+znaJyfbqFbuUzD+hOKy
 y68gi13eUan996MIk5ZU/gcP3lPYh6bq+BwRW4O6InT3Ee9quPPOGdSWMX7qRKfFg6lFNqqLd
 /oAqMwyuMGVtrWC9k+Q0Je4gb8R/QtDTXzibTkoAXsbn5Ain56vh5YhyxUZg8KYPZQ4pNC+Fk
 4FU/CNsT3qREBvvxh39BIr2/hj1urGPQesOxgsnkQdE1B2ezr9cGRbk89m2CUIdcc5eTE49iq
 LnVjaqZJQyVcb8njF7J3/tK21jLib8/+ankWvAio/k7V9nOPraLUs4IA/f1QayXeVme84B66Y
 MTDi5l5cuKFY8l2JPfc29ZlIksec9rr7MbESSHWwbFPECtg4VfqqqCs9SqQ60GmG9Dfr/u7FW
 g+Oo0EIxL+3RrA5YJ9nI9jpmKFdcb64BfwICTLMK897iudD8fRb5On/0zrYz8jjYWUDr9t2z/
 P6g4b2mosGSN7xp22lZAyrWsEkmL5FavGJbnxAjfVHDzwBoFIglyd177uFysU95zB48jDAJnQ
 zqaL8Hx9hSWV8Vi/e0fjG9O0s8EWSchXunXTwYTx+etj+zvCwnOfvRC6UCKrl2EzX9mBALT0/
 9IBwTMCdauLvgSI9SFleOUpyESCozomUEaFEWci3kyalOgmlMESaMR6y+IyXb1J0XUbFL8pJB
 pZpG1kH2wThbm9FL8wFRHWfgh8BM0+yOghaNC7Xo+NvT0tdtDbwpd/M2Vai14ltkrwqw3rPOY
 apMR7sffMe+FKSVic8NedzDhA5hoPyApP6MsCHpnx9DqxmWb0Fd1ZNGNi+rZ82kxdLNi7IR1v
 a5z8H6kOj03AhbBG5XDojmwsO3nXi0vKWSDUPfP5BC+dsevmCYaXedMiHiq/ifPc/SnXpJ07V
 TeLXQweEQFT0UwXS9
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pyOdW97sL22UylBrPoDLXPqxL3BIc0rrQ
Content-Type: multipart/mixed; boundary="MraujC4WPO6RiUfs6202t3dWQhpds0DX3"

--MraujC4WPO6RiUfs6202t3dWQhpds0DX3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=884:00, David Sterba wrote:
> There's an unnecessary indirection in the checksum definition table,
> pointer and the string itself. The strings are short and the overall
> size of one entry is now 24 bytes.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index f948435e87df..bfedbbe2311f 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -31,8 +31,8 @@ static void del_ptr(struct btrfs_root *root, struct b=
trfs_path *path,
> =20
>  static const struct btrfs_csums {
>  	u16		size;
> -	const char	*name;
> -	const char	*driver;
> +	const char	name[10];

Just a nitpick, the longest name I haven seen is "xxhash64" which is
only 8 chars, +1 for '\n'.
Thus we can save one extra byte here.

Despite that.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> +	const char	driver[12];
>  } btrfs_csums[] =3D {
>  	[BTRFS_CSUM_TYPE_CRC32] =3D { .size =3D 4, .name =3D "crc32c" },
>  	[BTRFS_CSUM_TYPE_XXHASH] =3D { .size =3D 8, .name =3D "xxhash64" },
> @@ -63,7 +63,8 @@ const char *btrfs_super_csum_name(u16 csum_type)
>  const char *btrfs_super_csum_driver(u16 csum_type)
>  {
>  	/* csum type is validated at mount time */
> -	return btrfs_csums[csum_type].driver ?:
> +	return btrfs_csums[csum_type].driver[0] ?
> +		btrfs_csums[csum_type].driver :
>  		btrfs_csums[csum_type].name;
>  }
> =20
>=20


--MraujC4WPO6RiUfs6202t3dWQhpds0DX3--

--pyOdW97sL22UylBrPoDLXPqxL3BIc0rrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5Y0ZQACgkQwj2R86El
/qjVqgf+N47IUyvBgh5V6gwekoi8HzQ4wxVSzYobg1+GQiBg6u9iHJnowzYx9G5m
wCocYae8U9ev+myU6zolwvDAf0FKWG0gEpQT4PENFqv0hRjzzo5j3Y3AkhAqsFfd
7TW8TsJWbhzuXHS4Jn3o4HoJ3MxIXC+Yo88/gCPgr8yeSZ0l6DrTs9poufEti00Q
cbxhI/0WlHp84bX2QFJV/mtbjNeqsEHNcMcwXRKbONYRG0X4mmqoRcKFjEqAMM4a
At5VPNrYTUBQdL9rk8+oVwM6CNIZy9jFRKXpSLCxPABjcYcMgubiW8k2vEYXelh9
wQRykZBE9G2Yczo7RWEsoK1MD74dSA==
=HOqY
-----END PGP SIGNATURE-----

--pyOdW97sL22UylBrPoDLXPqxL3BIc0rrQ--
