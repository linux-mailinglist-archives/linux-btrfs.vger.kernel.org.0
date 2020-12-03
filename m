Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7152CCBF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLCCHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:07:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:46063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLCCHk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606961164;
        bh=vJUoh3cO/eNjm/ix19BwrLYoIJTdR8mxGIKizkEUHTc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=H2BTqeJNDOkkpMEySA7TI5DW+rUgloOHb9Da4Tv3iTnN5OhaEvtREAMHImFeFSQbU
         D5eWoNDxniXozyR0Vh5ZyfPZh5c6eNrpCthpJHzh0HswmHf05hwfYwPAIzYe1zywQr
         shi9QixRBj/hjZknNtTSlAL6UrKzkhaRKk8Ld004=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8obG-1k8pB72gp4-015qRJ; Thu, 03
 Dec 2020 03:06:04 +0100
Subject: Re: [PATCH v3 05/54] btrfs: noinline btrfs_should_cancel_balance
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <4657a485af5665a07682c4d7a5eb14ef241995a5.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <5b7fd208-ad5d-5509-4547-e4ebcd17121c@gmx.com>
Date:   Thu, 3 Dec 2020 10:06:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4657a485af5665a07682c4d7a5eb14ef241995a5.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lIwxzGSaUusLbiQxdqLkCk9Fs9NEfwzGZ"
X-Provags-ID: V03:K1:aopg0FTbdlOTvaffNQIQcqxEB2Ei5tlCrZ+85eX+0n70V03oE6Y
 yglaZ1tc38oSXTkAz/aK6BLl5Ygm0a3DtkhjDzUWL4IBT6vnKP4g7D4eeVfoZ+MNwGU3e9h
 4aQxz6Fp60qz/WDVMS7t+WpGhm65U5p0ONAvNj+S3PngXk+RVIQ1vDhewbnM7GcxiJzX6Hn
 jINE/t4Zj+s43twkKIZ/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:frvY03Gg8ug=:LHNaD4iCxTDiyTWA4xwVx5
 Y4uXsZgXbJnjZJE3KITnAXzE0GBwMVLnLTmKkv9nosiuKSiGShDz3F/5DKvHLpSpwIpuLJ5ow
 ub9x1vFgUVGvMwrSwUyuumrya5Dwp6OTKeCGbub5wTJEK0yPmGdCIgQw479SD6XznWGHGF3jq
 agWkRsLbxlh2fCpW2tt9m9vAKQhw8DECmXoZiHdF4wAxn/KuOWllJQ3BSB4IHY6c7CW1WyWfL
 LF6ZvJlXL/mIzm6lYtAxGY7ot9rJklw0K6MmV/gbmLsgw23wqnK/cZul/7TRrGgLSoDqvv0di
 edizHPeW7aeHjq3H6S3s+rwokgCuC5GMqX39PUHJq+YUHwozKJjiryAWosSVxtIRsZ1nyh+Kp
 zH7fh422IgtPrAElaxh0pQspvTJ3nBvb/n0i49b2ahfHgfJpiZt1KHfTu1RukdoP/LYjg04o2
 Hgw+44bmz5Piug/Z9+Hp4uxGChiEVSbwItwA2wyAk+HCE3oVorbB5x6E0T0hPaebiTvdtqCFk
 X49jsnDAAcHL9nDsEWpc+OExq596CAZG+SvQ4MDk2MwXfmU9Zn7QZiWbprzoGFqcoC3BNTcCV
 Naf2EuD03tEXGSrLWvKra4n+AY4BUFqJ7o09AAi4gRqrJQrmlGBfLv6/USS3Tp2cBb28aZsg8
 Y4TIR2pYM1659GRBRLgCWdFbpoqyemUauVv66Uyr+vyTjEnC72JAiISD4Fn54EyrwlpZyKh8x
 guPnNtFLV0kwTwskrjUjakEnaNClLE01tfaUfiPQMY3e7FlJaKrQbB7qNOcUoiSnv4y0WP+fU
 qJnCUnMzUIfPrTW+aL1sHO5ENwN+Mzpinrjlbia6+T80lu9azdsZnCyJWGs61/+GBJttYg20x
 1jSxfqw7MXtEztXz12mg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lIwxzGSaUusLbiQxdqLkCk9Fs9NEfwzGZ
Content-Type: multipart/mixed; boundary="ERNcYKeqY3cWoXYuKrayYMRKmfTOlu98S"

--ERNcYKeqY3cWoXYuKrayYMRKmfTOlu98S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> I was attempting to reproduce a problem that Zygo hit, but my error
> injection wasn't firing for a few of the common calls to
> btrfs_should_cancel_balance.  This is because the compiler decided to
> inline it at these spots.  Keep this from happening by explicitly
> noinline'ing the function so that error injection will always work.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Oh, I should have added noinline for the error injection I introduced.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for the fix.
Qu

> ---
>  fs/btrfs/relocation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 2b30e39e922a..ce935139d87b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2617,7 +2617,7 @@ int setup_extent_mapping(struct inode *inode, u64=
 start, u64 end,
>  /*
>   * Allow error injection to test balance cancellation
>   */
> -int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
> +noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info=
)
>  {
>  	return atomic_read(&fs_info->balance_cancel_req) ||
>  		fatal_signal_pending(current);
>=20


--ERNcYKeqY3cWoXYuKrayYMRKmfTOlu98S--

--lIwxzGSaUusLbiQxdqLkCk9Fs9NEfwzGZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/ISAgACgkQwj2R86El
/qig4wgAj0j6olh9nAKJZRwpn6x2z85W7zXo+gF9dGx0A0vcWm3ToZlcLE0T8sDO
ohpMl7q3UM4TZ8jTKj3rlJkoGKwY+0OG0Yu65XUk9DZS5+UDNCbA5dzlxQSi+D76
xBXrcdbBgFDpVSsikYykL3KmZ2G6P8oWR6N0p1gK1/xBJNK7ckOVumY+FyFIujz5
ziDyhUEl2P5TkCoTxk1Q75S1/dHgHo7Z3YRt1Hvh18NNGXtKgLuY3V59OwX/r8QV
oJR40LAGmJ7qwWD/WHFC+BiacLYJvwbcNQD/7Wlpjwkx3T0haTS5aDPr1eAVAXGD
4EzktPSVy42qj9POKBiLIgMJiu0jMA==
=o9KD
-----END PGP SIGNATURE-----

--lIwxzGSaUusLbiQxdqLkCk9Fs9NEfwzGZ--
