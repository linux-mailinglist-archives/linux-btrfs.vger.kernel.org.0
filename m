Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073232CCC53
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgLCCPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:15:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:54765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgLCCPv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606961655;
        bh=Is/86eXtIgzMXRiASBBKLPDM/MsdpyJ+fV2k7di26lk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LanGvXCF0Mn5sz2C+NETCxytyFjY8AbTQSdDkOqnKOLX6MhKcL4Svh0bo/4mvlNP2
         mNzmgc7FaeaC7MvykzqBSLBmEy8rWJKUt1gDhsMzfKDt1x1CXKEJYRD5H6+iwatj3b
         6SB6gWT6/yAbVyp0GJJ6J1Qq9SrOUKhHPkMxYHis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6ux-1kNSBh3XDf-00ph3S; Thu, 03
 Dec 2020 03:14:15 +0100
Subject: Re: [PATCH v3 10/54] btrfs: convert some BUG_ON()'s to ASSERT()'s in
 do_relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <416807404fa65b6f122249f7c9d76834248be5ee.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <885df6e1-67b7-a93f-6820-4fe0e9dd7759@gmx.com>
Date:   Thu, 3 Dec 2020 10:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <416807404fa65b6f122249f7c9d76834248be5ee.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ja0T9uKgfZJH7lcyqjkwdWauu3FGEflzi"
X-Provags-ID: V03:K1:qYcTkoeBx9PQUeR4+skQTbcQpgYbV7pu++wJKnxTLGL622QxNdm
 ik6U0ODMv3IsZN6A3A2QF9sDplKxgUZ2S0UTI0q1JY0Dlneyq8hf34Uksy9WqsroyENObld
 l4Aq7YSdkHuryAqrWeDE/9eMD8wZKizIaVm2PHDackcUvtKlUeh27HeLSKC4GfzyACfi5nF
 7T8BzzsQhH9uM35kLhMNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oFWtzYGP0uM=:yHObLCQgm8OHWXVPcOjCgv
 717hGgl+ONw6leZxRhpmdPm6942XFEG+ycTbUKx1TaTEJ4Hdhyc/7qjQS5+pNRFLMB0APC85p
 xIrkhsaS73/VrxCd7a/x8T3VrJnlNZEVs+gK6OaUkauvsD7jR4TIc424RFphfOGUN28CcPl82
 1CWU1LBu/XqvLjXiBcJ/lFuH7LF/4aBLu7naCK1DsCm2/B4aJVkAw1p8u2kV8DPjDrRNq/NNN
 KyFa1VeGGq32c8kvRU1GLCzPLbT3yBUJJnx+bn3fL6lEBn/1xpGws6lmJZzpiX+aW9/ynie5G
 ySNR+c1diVAM5PVD3/7hLa0UFrIE89bz8fYRKLHeC0UJzqyVnOPfsgODO1PvRxNA7uZxpBQV9
 nhrYxOY5W6GmqjeofrsYlw1Fi+veEwecLVAS1taNcOL4unBVpAvq2/SBj3H7pmJ01z/y4F23J
 sR5Q68XX+L5Z3dQVFgqfyKxxZUj/WVrInZ5RLGKlvSUH0wmAKjbBoLmDmmeQp19xpPh8hu1VG
 o5f4iP2sfXxJGP4fND6bUhJZ3LjqCMgpnAA0g0Ph66EYvkIZUYmIiaS5BjhMCoH0kboS/aCvt
 o+g+MXhvZPbBZcRtYni/Icx473cdsJNfXP4SXI/WTwbvLauDPALbG6ZYeZ6A28NbjOULhnfGJ
 MZfo4EWNxuG2Uq9Eddg7RDMAeU8Zk9m4UGCj1DgsLJQoHKAnTTU7XwuJfRK/so8ujr7CiSiq/
 mwmDC07HA8VYbmHrOUUrQEohKyUp/pkoxdHPfwRq9FH3BshO7mgItlae9fQfEcEykU3OsM65H
 O+9Z9bSZToQykARsqk79gK2aZgKTaLmO5BfOJzXuoBaeqa7UbwPghwfJGvPnPcNX+H22VJ5N7
 MXuPq3cHSR/paoZw4uJw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ja0T9uKgfZJH7lcyqjkwdWauu3FGEflzi
Content-Type: multipart/mixed; boundary="YscYSTlJ4xNmWD9ebEpEi1Ru0BeHEClAS"

--YscYSTlJ4xNmWD9ebEpEi1Ru0BeHEClAS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> A few of these are checking for correctness, and won't be triggered by
> corrupted file systems, so convert them to ASSERT() instead of BUG_ON()=

> and add a comment explaining their existence.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index ce935139d87b..d0ce771a2a8d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2183,7 +2183,11 @@ static int do_relocation(struct btrfs_trans_hand=
le *trans,
>  	int slot;
>  	int ret =3D 0;
> =20
> -	BUG_ON(lowest && node->eb);
> +	/*
> +	 * If we are lowest then this is the first time we're processing this=

> +	 * block, and thus shouldn't have an eb associated with it yet.
> +	 */
> +	ASSERT(!lowest || !node->eb);
> =20
>  	path->lowest_level =3D node->level + 1;
>  	rc->backref_cache.path[node->level] =3D node;
> @@ -2268,7 +2272,11 @@ static int do_relocation(struct btrfs_trans_hand=
le *trans,
>  			free_extent_buffer(eb);
>  			if (ret < 0)
>  				goto next;
> -			BUG_ON(node->eb !=3D eb);
> +			/*
> +			 * We've just cow'ed this block, it should have updated
> +			 * the correct backref node entry.
> +			 */
> +			ASSERT(node->eb =3D=3D eb);
>  		} else {
>  			btrfs_set_node_blockptr(upper->eb, slot,
>  						node->eb->start);
> @@ -2304,7 +2312,12 @@ static int do_relocation(struct btrfs_trans_hand=
le *trans,
>  	}
> =20
>  	path->lowest_level =3D 0;
> -	BUG_ON(ret =3D=3D -ENOSPC);
> +
> +	/*
> +	 * We should have allocated all of our space in the block rsv and thu=
s
> +	 * shouldn't ENOSPC.
> +	 */
> +	ASSERT(ret !=3D -ENOSPC);
>  	return ret;
>  }
> =20
>=20


--YscYSTlJ4xNmWD9ebEpEi1Ru0BeHEClAS--

--ja0T9uKgfZJH7lcyqjkwdWauu3FGEflzi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ISfMACgkQwj2R86El
/qj0ewgAk+0yJdqOsYtGDEWcexH5FdUr9rKz/Um27Q3D1q28fxmRHuuKud0XCMP6
eEL70c2ovAtGvj873gk8v+avsImzjoSC2JdbCcKZg3M7hXqamqL3n752aST0kpHt
DfGVDEmpUr8jepilSyGhDBzpqKQOKvalHvh18Qx4o5FQezWa0/8bkozW6IfzDFQw
RPDUdUxU2Mb23EgXEZYbsF6BehzjRzisfXHcOPit3pP55Re9FLDmBbMfDp656wJF
G72dgme40+KIadlDhBwJ6T1UGP1qbiVNSDJbRZUdlKZeTxYtNoiJzwQcnwc1bqLr
RmSQnqeHf7z6LIbW3YL4AviiPjx3wQ==
=lY3S
-----END PGP SIGNATURE-----

--ja0T9uKgfZJH7lcyqjkwdWauu3FGEflzi--
