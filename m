Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127142CCE6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgLCFVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:21:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:41415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgLCFVy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606972818;
        bh=saJTMNgFieV0iIWhAvVF1am6tTzMMK2m9EEFR6QE9Sw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SI7u44XIqQVyxHxxtkl7bbEhv7ME0ltmcZTbNe3AhMM0Y4XnsMPdvq02izf3BoVy0
         ptXQan/TxeTn5758p5nPrhmJqQeeVzirjf1fFKnK/k9RzuCNsSeAKh1dpWznLZ60Mr
         w3SCNzg3eKkYEF1Wpr646xNqEyJ/B3x/fuS3tFes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1kNgUw0onM-00prgF; Thu, 03
 Dec 2020 06:20:18 +0100
Subject: Re: [PATCH v3 43/54] btrfs: remove the extent item sanity checks in
 relocate_block_group
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <09013ee34800bd1bd6354254a1b6a29ddf68f09f.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <6081dbb7-f962-ea30-752a-fcde1db9aabd@gmx.com>
Date:   Thu, 3 Dec 2020 13:20:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <09013ee34800bd1bd6354254a1b6a29ddf68f09f.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9SWRa3kvSH9QyyTuCFG9GPP1neXcOSyKo"
X-Provags-ID: V03:K1:+JPb8EkV8lnVLzK4RjBZaBPDPuRQgT3/wz/eC9brlbeP74LeSCg
 wGRSVmHqY/Bi1pwvg6fo07q2iXBxrCq67pfdGvytJe2M/SF4UjDG93FOjzTNx4CIqquzjva
 XkmnPr+zBIwif+YViwyC/piE+Yu3GuYZ5YRKtusMW8teAnBqX2QMsPdhb/d3GsOJ4GiKT9n
 FScKyBI0WL4WUQolEXfLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:99RDJPO88Pg=:5Wri90W4Bu/IjMMIDoxzG1
 S10tm9veq76xIgdT1Z61e0e+UO0nChUtfUo9dAopd7zVsMePhxcNffvisEwZLSOghaYKDetbB
 Fqt8ik8sT9ioxUwX6R2RfTQYUz8I/bHVLR4kYGegL+mpT1XWFpFfM/msDIT81i6o4c+iBDMYg
 JDNjLjsUMdXEhETtBhrLsoDAzggATEzMzeErji735bW8qqrBFBbTA3WytoGOPPkt6FjRJih+D
 46Rqfwr6OmAHM3Oou/qAmbN3yj9WOTtNFfE2jZdCzUuCGRWbUHFh/CNOzZxACE4p+onc2QpXl
 UXJTz4EZyZEEaRs3nBNWlwstW0535sPuf02QxcCZz5T0rdFbuLCQJunrSMNkSd231g187rQ8D
 vHqvmPxTivIUuK0Js6dAeRhjzH2/CnkNbGqz/HStX5upCT7DMupBGMTMZdR8t305gkrXOu+PZ
 C3t5I1SJ785dvNIhi4g9Ec/m+3b+jOg+NyJrAq/Pl+JQpnvJEmC64m2fAOGcWZ/zX4E1THzpR
 nNRX7GCueDOmxMV9Gih/fEbS6VtHH9bYUSsD1uL/MLk0YlvXSpdpAY8gphrTlKy6OuqRj3JAN
 sULa3LC7SpxHU5O0DuEVJnk+JQA3kwtWvAftpKes4CcFFuY7YHUwClmqCWkBsVtfbvtgBGxus
 laXwKSfhXCoGXWqsRM8WnY1RVlQscowPKaZpG3O7xRgt4t4JLWLdQ7AwucWxDigVRF6bSs4EA
 8zfo/xFzzoMXbHBMkNEtiBFiyogQqDnqKUWWR2oeU2Kx65gPZw6KOfK/Ar5YVDfgpZUPjsF8/
 7w8bdh95XAcB3kABVjSiwj0Hz20lFjuAjG0mkeGk9M9WXxGc7mzqRhJyI4rKs7xPBoB8XoyRa
 AplgElntO6+fs/C7/lG5Hlc57NVzVb+F0cnZjVEHw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9SWRa3kvSH9QyyTuCFG9GPP1neXcOSyKo
Content-Type: multipart/mixed; boundary="oA3lzUXdEhckj4cR0jymXLVPoUry5BHeO"

--oA3lzUXdEhckj4cR0jymXLVPoUry5BHeO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> These checks are all taken care of for us by the tree checker code.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Yeah! Finally see a day where tree-checker is involved in removing
duplicated checks.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/relocation.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3159f6517588..8f4f1e21c770 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3370,20 +3370,6 @@ static void unset_reloc_control(struct reloc_con=
trol *rc)
>  	mutex_unlock(&fs_info->reloc_mutex);
>  }
> =20
> -static int check_extent_flags(u64 flags)
> -{
> -	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
> -	    (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
> -		return 1;
> -	if (!(flags & BTRFS_EXTENT_FLAG_DATA) &&
> -	    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
> -		return 1;
> -	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
> -	    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
> -		return 1;
> -	return 0;
> -}
> -
>  static noinline_for_stack
>  int prepare_to_relocate(struct reloc_control *rc)
>  {
> @@ -3435,7 +3421,6 @@ static noinline_for_stack int relocate_block_grou=
p(struct reloc_control *rc)
>  	struct btrfs_path *path;
>  	struct btrfs_extent_item *ei;
>  	u64 flags;
> -	u32 item_size;
>  	int ret;
>  	int err =3D 0;
>  	int progress =3D 0;
> @@ -3484,19 +3469,7 @@ static noinline_for_stack int relocate_block_gro=
up(struct reloc_control *rc)
> =20
>  		ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>  				    struct btrfs_extent_item);
> -		item_size =3D btrfs_item_size_nr(path->nodes[0], path->slots[0]);
> -		if (item_size >=3D sizeof(*ei)) {
> -			flags =3D btrfs_extent_flags(path->nodes[0], ei);
> -			ret =3D check_extent_flags(flags);
> -			BUG_ON(ret);
> -		} else if (unlikely(item_size =3D=3D sizeof(struct btrfs_extent_item=
_v0))) {
> -			err =3D -EINVAL;
> -			btrfs_print_v0_err(trans->fs_info);
> -			btrfs_abort_transaction(trans, err);
> -			break;
> -		} else {
> -			BUG();
> -		}
> +		flags =3D btrfs_extent_flags(path->nodes[0], ei);
> =20
>  		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
>  			ret =3D add_tree_block(rc, &key, path, &blocks);
>=20


--oA3lzUXdEhckj4cR0jymXLVPoUry5BHeO--

--9SWRa3kvSH9QyyTuCFG9GPP1neXcOSyKo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IdY8ACgkQwj2R86El
/qhj+Qf/eSI+6qs16Ygg3Vzq/IGpLSI79qwU64M2/reCEQvT3CJvzJUcXds6XTQN
/cvJQ5sdNuXosBAdkxhZ2u56OjdVyG2TrjKdiE3qoOVUu2ew+thjJxltUS/VgU0U
+6MD9N5lsGLg2xN7EpbEV361t745EKGSqWShxr2HcBFmp6wgbpPEo/oesVgVqdYM
np7Iu2cykEYbOld34sRc0aLDmuStLGVsM90L8qtD+CEBhYpZiRD993gdXRfOszeP
e/w598ZI5XjDqPaoMOx+DoUChGBjOVnC5/szF7m5bRC4Q1cUWPIZXcA4JaDxG4Dg
D+86mk9Y7b1HVPUYytuKrbstDzITSQ==
=i0JI
-----END PGP SIGNATURE-----

--9SWRa3kvSH9QyyTuCFG9GPP1neXcOSyKo--
