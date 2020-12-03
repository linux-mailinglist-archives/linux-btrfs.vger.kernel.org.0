Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4D2CCCBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLCClq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:41:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:35627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgLCClq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963211;
        bh=popGg4e6YYisKqk2VcG9zsStrF2bjjAUBvZlKBhuRzg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YATsX1txTwPevMxwp9o2xg0H5DsSL6bJ1pAt91XAi7Nve1SXMIrfy6m4wISkzIFlE
         ma4Y+Kw+6WvpD37GD1hE+xnEm7J+pPCtwB2gCJXSek72doVBDSNoqtK23GJiDttQRd
         OgGzPku4zucCuULiP9yRUg1vNoxRFi9mrlkZkdz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzf6-1kcN681ILC-00R18l; Thu, 03
 Dec 2020 03:40:10 +0100
Subject: Re: [PATCH v3 17/54] btrfs: handle btrfs_record_root_in_trans failure
 in btrfs_rename_exchange
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <e83a6ba1f9c439ca8df808887912eff2feaf4a91.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <179aa5e4-1f9d-7002-f650-6ee659c7da4f@gmx.com>
Date:   Thu, 3 Dec 2020 10:40:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e83a6ba1f9c439ca8df808887912eff2feaf4a91.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q09ofv8o7QETPkVFdrzLVSvUeSK1luqBd"
X-Provags-ID: V03:K1:teEvsCENy+hJW/r62lQGVEd/b5/BH4ECNAKrSTMhR/U6eh5qeC0
 2GOzU9UFM/kcGeZW1GbvbQy0VauXqml6nO5I4agVM83w23JYBt3sKZbhEHORuauquX1Pa/A
 5VSs9Y2Edi8RsVgSlf6yYMYt8rSXoC2P7tJj7iXsfJJFFaZYfTOXXLyYDyAIuz/LlEC3G6G
 TZAFii0ENFOYr3dI0TR2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0R6hEMZACEA=:ECbL1gmh9qjQHWZMH1Z9w2
 n1kKsKJNWEakXk5h3ZQVj/Jj19r/kaR8aVQ7dvrUGRnjLpxt1EkdlHludDmiMuim517WyN8yb
 n2saYAAswzTlpPvomtDjYsUQi+2UjY9nbgbcTBMrxP2coQ+gH7vVo7ColMILcfUsMb0uoZvnp
 3rK102QLL7hcVXN7Sv8wBhyW54ydMD+2rHUptVsuAfSL9qBes+K3825UOlSK2tGmrA3DMD0Fd
 bDwN17PdZQ5rlcw+liPILWkVYthkEqj/s8U+uY+E5iJ1N118WRlEQ2hZN26MMA8RS/6Z44asc
 xtgwTC+auHxytukdWrxlnre/KmrG72y1pV+vneYBO4pXm6GuHbEgSwLwGpK/9LJZrvbl13gvT
 du6W/hXY11ilzLsxjXRnXm0FBXuUZIe92wUGO3oZYfoIL7CbMhRFaLV605fHfrd5vu8MCnFP9
 ctwcoEUCYe0k9jsE/69SZOYsguWBSHHwH/JpicAIIuPHuntyPFiBaJLuwx6HgCy44RXag4N/+
 sJ0G9Nt8bBEbJoaTevg52X3NeW/pZdFZs6yBQb2v1f1AgjE54mw/q/Uh8Jo6R+lNKBEr6LpRw
 VLFSI2lUPaZ96K1QSCdGFM5IsMyZQZPFDd8Z0psq34EI6MiTjtsXpAvvw+E2+tKKGO3e72blz
 F3VF2nFL6vkye7QeeVzfeRjBQgJWX52XpJ7pE285+Lf/r3q4PWvY4i/qw6d4Dp/GPd5jmvi/i
 mYtm1X1P4/3YMESBWtSeZWWY601E6MJk0kVUm6ZkGWOPpY13zzz04yUvuW7bj9I8I4Zumw++4
 loLA7r7tDdNPoNDNSNWczxeqtafJac55JsiAkd0/tvPofATK/Pn2CJyXvjqQ7ekmQiqsA/j8T
 u3ot35Clme9LMHdZTjDw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q09ofv8o7QETPkVFdrzLVSvUeSK1luqBd
Content-Type: multipart/mixed; boundary="bujpo0e4ivFB8w1ZELB2R0L7KtrBaexWz"

--bujpo0e4ivFB8w1ZELB2R0L7KtrBaexWz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_record_root_in_trans will return errors in the future, so handle
> the error properly in btrfs_rename_exchange.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0ce42d52d53e..d34cba37a08f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8878,8 +8878,11 @@ static int btrfs_rename_exchange(struct inode *o=
ld_dir,
>  		goto out_notrans;
>  	}
> =20
> -	if (dest !=3D root)
> -		btrfs_record_root_in_trans(trans, dest);
> +	if (dest !=3D root) {
> +		ret =3D btrfs_record_root_in_trans(trans, dest);
> +		if (ret)
> +			goto out_fail;
> +	}
> =20
>  	/*
>  	 * We need to find a free sequence number both in the source and
>=20


--bujpo0e4ivFB8w1ZELB2R0L7KtrBaexWz--

--q09ofv8o7QETPkVFdrzLVSvUeSK1luqBd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUAcACgkQwj2R86El
/qhERwf/fmMp4wgv/tpgrZ17IPrZ8DH22cG99UHBdfmhvJp+1bVeNXbfouzHMCc+
Cjw27z5ty1pPXZ1Ql3P0TsoCek9uprm9XG7payUCfMvUFXLfHzwg+nPwu97OptEd
nlNUlJM8+lzzh5T2BKCfYppyp1uh+cKA9A+wbzKqX1q95v0aedztWLg5XB4Pk5Lq
uxudlXD+GyqWFPFuo1dBEmXWc/gUGYeXoxmINtjKM0UGJZAvx+EIz2JkxUBOK+7Y
FP9UVMQTJpQpNkV+2vjJK+umf1YsyPSbFndemUojTuErniP2T1KueRgq4GPRRKrY
bCCaawhbJMPAtlN9sRD1iffPFKbf5g==
=oOzp
-----END PGP SIGNATURE-----

--q09ofv8o7QETPkVFdrzLVSvUeSK1luqBd--
