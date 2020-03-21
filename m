Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634A818DD84
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCUBn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 21:43:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:59863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBn2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 21:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584755004;
        bh=QXWYnUyfsLupJ45vNhVnxutzSLeTg9O4i5mgMlBWGs8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZB+flwuKL2VM2epWn4vZBKkzPsb3Rg+Oc9W8yRJhcwgZcelKkM/vZn7z+a5ljAHQf
         bSx0x/WR5p8O/iVeiiWBeTibp3ZcBolaV8iCwFfeKrojmKcRjgfvYgvZ+4y4i0O+Ww
         eUnwrPbsBrFEl5+y7UauJVFSL4lw0UenFWbOMr9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Ux-1jSzsG3tKt-00wFi5; Sat, 21
 Mar 2020 02:43:24 +0100
Subject: Re: [PATCH] Btrfs: fix removal of raid[56|1c34} incompat flags after
 removing block group
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200320184348.845248-1-fdmanana@kernel.org>
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
Message-ID: <8107ef53-5317-327c-674e-d5bd1b9d1e4d@gmx.com>
Date:   Sat, 21 Mar 2020 09:43:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320184348.845248-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MeEpO1oCISjlHzIY0OhpRtvxAVBbf148T"
X-Provags-ID: V03:K1:L3xbgbeE18c61wCeqFiYHVImQ5k48fMR36+VONIpt6EFG2eCmP3
 /qxElVKSDuAKWdClTByuesUny8CmuyAImWZ24GAQgkXBiqArJ2jBB6nTYlSIUNgY7z6KuxP
 Cy0kVrIDLUMnoZU71d4rCe4mCjgQYU4u9a7CxBuK6h7TOIxuEJnCtIf7E1qh7HR9vWdG6bL
 QqCm3+XepEw6sE12+SDPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fw3N0ZxuURE=:T0qVoGkjIm1ocgfxpRKEvv
 KRuANv0OBqN4VnFppz0bI2qpUj7oHIO2gkI7b6B2Ah+gBgwEniI9hHpnI728/LGdnvXJj0baO
 1OhgFgWktjG2c+VUfQJnP/SE74DeYBiM8K0VZ5frTOvPGR1ewhZ1Z2mmRNYLW2R83OmWAWWjq
 0cJuAGrWIQik1NDxM0Dhxb7ZorTpf98YHxWG31JwfcDQKd9eXusdUjGPo5KJ7qOUWs0W+/gjE
 9G8qnm2z2a+MfrQzuK92OxswQa0vGy1VBBZdLg0XRy3G5xZB0M/AhDFI+i4TueCssexC4MgHa
 z9Sax9j0RLL30xLlNgyKrYa92Yb2lhx45VgMqyjcF+O6u/Tz9l1jn2kKeGcdH80Px74tmVkLz
 SU73v2c7aOs+7pNrYo+ogVm6k2BgQxNeRkpogET/EnrsDlHag3Vc+Zqe8P1hbwVIR751G1NSn
 3D37eLXl19LsappKsU8atF+hjVdMpLvTY52zayaLejAFLEuY172rqk/by0cKUJ6uzYlU8Iunr
 QB7KiM8z3Z878DLZ2qAsjC+l8ppMz1jHNxEWl/FDkDtDK1Su2gKkfZOz+IH13NdO+bw38NkXV
 5z96c2SM54Jn/fRS2kDaLWbKgGWCka0t5mZqrvdxALLMr1HUzb+5n3IsQPDz5/LOsPvEa9TW5
 rbtV1Ryn+eivNJTwoLqxzTV/a01xiICvEo4kOqbzqB/Zx7S3RMD9zA4Z8piEkM1fI+ImULedf
 oWOTl2JsrC+byiLx6FN9yobkIxX5yNcla3IVgBw1JMK3vkedA9sCHZWEqE3FONps55750JjRf
 bU09dL8jCpSADqvEKw4E3ew5bTc+Xj36jbemwaRKdELaaxQXJdsE1Z4blCI11KPy9aedIe9/o
 pk0YIWfO3S1/NSlxoy8iRx2NaRTG4BxMdxx6ZU78ONQwRzvHohqs029M/13mYhi8pzhJ4ghby
 EdIlGxYKF3t7mEOOFZek9cVxUFiVAW7WJT4BD93ZIJMoGcK0ED7UnMQ3eQpGw5fE2AXzpYNSh
 loqPLCH+8utZsK+v6QOmndKRIg7gGGUBnh3Ojs55DnoiF6O0dxDvU6F+DQIYdyojYZ+IAMsvO
 1Dp2rttlkLkQhCLhsqpdjYp5dfJNUirp4Vi4dU4Gh6u4eb7573B+eQJOM8qHeCiUqLSSRXzGW
 o2fLl3976g2Cx9Kjv2XPbHKlxKZZMKYFZl+tbEMXR4A2FbFJQdo9F4Xo48LpeCUD9CjvdQc2Z
 noqyC827ofJPs1pGb
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MeEpO1oCISjlHzIY0OhpRtvxAVBbf148T
Content-Type: multipart/mixed; boundary="UdOHNT0Oi4zcG3clQ3dFHzHnl2GgbaJnS"

--UdOHNT0Oi4zcG3clQ3dFHzHnl2GgbaJnS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/21 =E4=B8=8A=E5=8D=882:43, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We are incorrectly dropping the raid56 and raid1c34 incompat flags when=

> there are still raid56 and raid1c34 block groups, not when we do not an=
y
> of those anymore. The logic just got unintentionally broken after addin=
g
> the support for the raid1c34 modes.
>=20
> Fix this by clear the flags only if we do not have block groups with th=
e
> respective profiles.
>=20
> Fixes: 9c907446dce3 ("btrfs: drop incompat bit for raid1c34 after last =
block group is gone")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

The fix is OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just interesting do we really need to remove such flags?
To me, keep the flag is completely sane.

Thanks,
Qu
> ---
>  fs/btrfs/block-group.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7b003a2df79e..b8f39a679064 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -856,9 +856,9 @@ static void clear_incompat_bg_bits(struct btrfs_fs_=
info *fs_info, u64 flags)
>  				found_raid1c34 =3D true;
>  			up_read(&sinfo->groups_sem);
>  		}
> -		if (found_raid56)
> +		if (!found_raid56)
>  			btrfs_clear_fs_incompat(fs_info, RAID56);
> -		if (found_raid1c34)
> +		if (!found_raid1c34)
>  			btrfs_clear_fs_incompat(fs_info, RAID1C34);
>  	}
>  }
>=20


--UdOHNT0Oi4zcG3clQ3dFHzHnl2GgbaJnS--

--MeEpO1oCISjlHzIY0OhpRtvxAVBbf148T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl51cTkACgkQwj2R86El
/qg8FQf9HKLJmeEnUFbgYawOrWhVZ4/lw7DEdvRcLFXZiUS592wRGk3Yt+OgxLEH
Fsur/OcOUKiU/5P83bB/XzauNf1uoIhkVkxNG/6XX7Akt2dznwfvHAfTClPCoPjC
96/fiBCoXULr0FhPysBx+SCCXe/D7AiDA1+Na0XbCsh3Kd3kAoN1XjpFSkSwtOgM
qPVhB9dwUWlAyD8N5XZIE0lEMyNEXR6WP7OtOMcoeCUcA0i7qZx6LkguPFJbFoKV
1RP6kpH7sZtmbmzHjxcR6EaFeSpva7KwUxbCRtZbNbQ0hdUYFY4DbrTJ0lE3DVGX
mkGiJFOmSnzcrRZGEU3SJ6wg+t62ew==
=ImHi
-----END PGP SIGNATURE-----

--MeEpO1oCISjlHzIY0OhpRtvxAVBbf148T--
