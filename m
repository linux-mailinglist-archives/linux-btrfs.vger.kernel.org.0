Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6299DE9BC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfJ3Mrq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:47:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:47459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3Mrq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572439661;
        bh=XDDV5lHuD8nEbSCwFSCGof+nvaCbVbljTqGbPLfU2eI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FRJzwWPHrenKTV0qToCOxz9JemgKoxaj/Z4Ghg3FCHNNZKTQFJHrQkUQeY5+UCrr4
         xUNrd+QRT5Lt5Au9g5eWR1L+USSB20vfWD5WTGgLVZnpflEXfM1RxPpI+ut1WnLMCd
         Mh4sP8Nbptk6gA4HNvHXM1RteF+JyaLNPcS0NTSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLi8m-1ihSlH3iZk-00Hf3t; Wed, 30
 Oct 2019 13:47:40 +0100
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20191030122301.25270-1-fdmanana@kernel.org>
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
Message-ID: <82eb1c76-9aa9-a666-f33c-b38763d82d23@gmx.com>
Date:   Wed, 30 Oct 2019 20:47:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030122301.25270-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NJREc1O8gNFLU5k9uwaut1iHTPHAtNmi0"
X-Provags-ID: V03:K1:ZQdV3zJ6mJKG4gDkYYYhf+PbLFYqlAqrz6jUP/3dQUYmxbx5UdV
 q1RSyRJHEAU1NxERGzFCD1rHH0soUbhZtUtLBr9B8rPwVNFAIi8sGNUz/Rhm/M2MWyzny9x
 oOripDYXT8Vd76c+yXEr9qpwV/VQFpr1djGdQ9c6BNd1jO59gJnx5mvcWTkhvgrilIhEnKf
 RcZVef0FNFxi1uBCMXfaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zaiRKg6OGaQ=:FJUd5GBaet2U+5tvY0wshJ
 lKgzqqG54DYkxgsWUx/dqcGSCQv3H05WF7I9N2+l6DtVYdFzsaDp0SoPcEpN/W/havZZgsJWm
 ItGZfqfyxjI60dO06BLB/7n5f78/SKcOpDw07W97mLNUHtOEbLPa9r//JyNblRv2H6rTFBZDV
 AbgHww0lv/nbo5fHkf1JHlFeeafkvpjS1wV92l7VHY0PNwY8sTvRFhyeZeW8rVHWVr8YcKNFM
 Loh94c5BR3wXqCH4UxOAQIS66yu057q5I+KHSdJVdRqSXjGGG7BaG4wO5bU+KjOmwXzRtDtqm
 4PYaeTf4ISGHntgSNxkM4+grdHaxPovksh2QzloIBY7jX2EfeC3/M55sxM3czqSSB99VfOTab
 8tQLhqzKUbYl3GWbw9teLguESBk2VXy52PqlZlkvawQFUWDM/fK7J9l3TMzAUkWdRqMFCqL91
 XuxXxuZlrrO+MIRT1Cv4Ez54Nr9aUvAoUPAX3Fk7V5MJ3kWNuIuZerodo7HyUG4MLHk7a1wim
 QaPShwkSphTtFQfDJR2c4vfbkYgDNbXmTzQZIk+O3u0HjPfoOpvmQEvAWQZqhSZ6CjqKu23Ao
 1OcfLYzkAHoX2tovzBD01g2R7cldGgq6Ce/dWGmpnFcppBaSxB2mOko4HslY7djaSYD7R2Glf
 1p/kLiJ5Zm4RC2oSQ85Vs6hkqrAgT9IUxQTMkXyLTTLST9e9n+D7MaUlY8+W8O997U4+IvL4e
 n8rPorViGc5zyK0Iw9lgR1hg6IG93QeucE8tRt4ILZcQ2BLNT233In5G8Rp1gP9d1YmayfbCe
 d3QPJQo9er/pbO6hBlh0aBiXv9Iwj3w6JjN90T+THOW5uvHQ4DDCvwwtTVXTqOOycmqCCZzbL
 k1OqScBLnDcrliQCOvjFidwn0NXn2qN9hjElaE1YFAiF+dteiJ1HzQuDNTvH3CuQSATcE1k0z
 O4/KlqhcxNCnRNlOwivfic/dm0cQEu75q2QlLZrN+pGkhdPM9LBsv/TO0mvOLcKcXyTqN2oji
 CyXultsWvDZRFgpfWQW02toe1tqctqUcIyiM9jFjfm5faWB783vOas7JL92GmhhQzD80axtqe
 iIuDhQoerlcTI3zrsHPrtHQgZUUZkHd4IOhtm1pRSD0LFdwMdDCIHk/QlssOEYY5YiBlJHvOJ
 ruq1tLrhz6KFTowe9AULfYVQiB9EqNqBadZxVgxxnYd8XSqi5GRex1GBZnn+5wKJyQgOxzTJc
 ndjrfSnyWyS27XUUuFUlsB8Yi2rBCx2dHeFWKBy7wpcVGI0q4Cynnjwvt4hc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NJREc1O8gNFLU5k9uwaut1iHTPHAtNmi0
Content-Type: multipart/mixed; boundary="SxjPij1Qw3bvr4vbV0enyxU8I2opCizDY"

--SxjPij1Qw3bvr4vbV0enyxU8I2opCizDY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/30 =E4=B8=8B=E5=8D=888:23, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Backreference walking, which is used by send to figure if it can issue
> clone operations instead of write operations, can be very slow and use =
too
> much memory when extents have many references. This change simply skips=

> backreference walking when an extent has more than 64 references, in wh=
ich
> case we fallback to a write operation instead of a clone operation. Thi=
s
> limit is conservative and in practice I observed no signicant slowdown
> with up to 100 references and still low memory usage up to that limit.
>=20
> This is a temporary workaround until there are speedups in the backref
> walking code, and as such it does not attempt to add extra interfaces o=
r
> knobs to tweak the threshold.
>=20
> Reported-by: Atemu <atemu.main@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQ=
gKaW3JGp3SGdoinVo=3DC9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492=
c65782be3fa
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

The workaround is much better than the old
completely-disable-reflink-detection one.

Thanks,
Qu

> ---
>  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 123ac54af071..518ec1265a0c 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -25,6 +25,14 @@
>  #include "compression.h"
> =20
>  /*
> + * Maximum number of references an extent can have in order for us to =
attempt to
> + * issue clone operations instead of write operations. This currently =
exists to
> + * avoid hitting limitations of the backreference walking code (taking=
 a lot of
> + * time and using too much memory for extents with large number of ref=
erences).
> + */
> +#define SEND_MAX_EXTENT_REFS	64
> +
> +/*
>   * A fs_path is a helper to dynamically build path names with unknown =
size.
>   * It reallocates the internal buffer on demand.
>   * It allows fast adding of path elements on the right side (normal pa=
th) and
> @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sct=
x,
>  	struct clone_root *cur_clone_root;
>  	struct btrfs_key found_key;
>  	struct btrfs_path *tmp_path;
> +	struct btrfs_extent_item *ei;
>  	int compressed;
>  	u32 i;
> =20
> @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sct=
x,
>  	ret =3D extent_from_logical(fs_info, disk_byte, tmp_path,
>  				  &found_key, &flags);
>  	up_read(&fs_info->commit_root_sem);
> -	btrfs_release_path(tmp_path);
> =20
>  	if (ret < 0)
>  		goto out;
> @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *sc=
tx,
>  		goto out;
>  	}
> =20
> +	ei =3D btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
> +			    struct btrfs_extent_item);
> +	/*
> +	 * Backreference walking (iterate_extent_inodes() below) is currently=

> +	 * too expensive when an extent has a large number of references, bot=
h
> +	 * in time spent and used memory. So for now just fallback to write
> +	 * operations instead of clone operations when an extent has more tha=
n
> +	 * a certain amount of references.
> +	 */
> +	if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS)=
 {
> +		ret =3D -ENOENT;
> +		goto out;
> +	}
> +	btrfs_release_path(tmp_path);
> +
>  	/*
>  	 * Setup the clone roots.
>  	 */
>=20


--SxjPij1Qw3bvr4vbV0enyxU8I2opCizDY--

--NJREc1O8gNFLU5k9uwaut1iHTPHAtNmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl25hmcACgkQwj2R86El
/qgQ+Af/b7bFlj5sK9tSqjL9Hsi7bNsA7Q279PDSPR2jBprNlBAXL5aFkAw5EHhT
7KIhx3VjqQy2sazUnfI8j69eIBnHz96rKOsivHsPM6HOL/EhzCHfJ6s/Wl63A8Sy
Jlum1wI53Eq1cEW4Tva04yZ6WVXPP9wrXTrurvd7ZffsCiKRxUTDwAMq6tdex/Ia
p5eHnWq6wh4+smLOfolhJtn5nX/adrvJtVeOc/8X9bcBE5EQXjLJIU+8fZRufIme
e2WFL1lFePwcTS6cSTBtTEQ8B9c0N1pOEhqrPKdAhO/GeQzsHT3y0Szp8pCo5EZH
eP1w8ZwxbFIbfXqRtYAZByBaeQkNHA==
=ja5/
-----END PGP SIGNATURE-----

--NJREc1O8gNFLU5k9uwaut1iHTPHAtNmi0--
