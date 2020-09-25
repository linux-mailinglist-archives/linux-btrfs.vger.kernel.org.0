Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCBF277CF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 02:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIYAgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 20:36:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:49371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgIYAgV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 20:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600994177;
        bh=OOUKh1rPbif7loOuY2mDtXrc+m8Z3u45QLSjuteO9qM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Gb+y5OOEEjEc6c9svhJc/onLA90s0oD6BW9Mu52y3taefxC6KczYftlbJC2lHv2Jq
         bfgu+GEpB2cD0BTmzd+6w3oZ2YBtAygQTsvvb95sjSvSjxQ3/fXsuxtvhIXkugvpMl
         CDJRaYU/i8QnNOHbNowjes+AQFgv27jwk41Kmoeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRmjw-1jtaDy1YKI-00TE8J; Fri, 25
 Sep 2020 02:36:17 +0200
Subject: Re: [PATCH 1/5] btrfs: unify the ro checking for mount options
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <d307f1d95415232dabfb700e79cda73618aa7d50.1600961206.git.josef@toxicpanda.com>
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
Message-ID: <fad6a957-c1ad-60c8-c6d6-d66f506fc9fe@gmx.com>
Date:   Fri, 25 Sep 2020 08:36:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d307f1d95415232dabfb700e79cda73618aa7d50.1600961206.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pKu0RCboHYyUCdPAxdE0HKbMYvUCYRoio"
X-Provags-ID: V03:K1:eh3AO7Z6S/RzFs/g0yKhjHb6k6GxesP3hv+dyosYQ0F2QCZ8gm7
 +AHLfk9GBTJWsbAWbtLCTsfTovWg0YT1A/OxJLiK1wcgeb9GhOQHJqREoykDpD0O2LvncV4
 oF1BHM4xxJ3JN9duFLLYQyj9WGDyTk7eQ2zZ5wc7x6YkH4Ufu0MUoVVsdGyze6s+KCxv884
 s5AMw6NtGVU+5A+T5Q7Eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gcItatrIF9E=:uvH1Gt1XKukxgz1vhvSixh
 7UzJhg34IsiNse/VEKKQawr6I3zEoB9DR5jeL51azA54S2ZhyX9jbXEVY008l2616RRNe6Xi1
 ZL0sGGT/bDGfR67HfsEBcJlHacza6AwlR5aT+wL8SFHyEpNynMBqhhcWwjpEzZO0AFT+hYuF+
 DBhBct1+FRGJk4O/g5QjpjlHXoLSB0GupfRqNreFnyg/wAZJ6EdTZD0fqCRhufEfqMem7PIwT
 DwUxlLbOSToFAdqirtf6gMEON0y5/a4D/JBTz98z9YiOHBDQdaELgCAzVcaUSSJI4wrlB13Jg
 zAOwonOUWIQQUMDdyNGWXyyLCvDNaNAwv9kSzMluucybL4LAPvucJine6YmwZkwFKIldCLUzp
 ClxiuFCda6ba+kpMc7+CCrt0oFmRyUpFHmQatuNTSqcgy7iohFcOT0M+sZTca6EqLBe5KoCFA
 Abc08YJjXbHoBSTqvvxVHvcLL6+UMPWsHxGS1oWL1cE8Thi8Vwk4rl8vB0bFaz2Tb3wg6l3V3
 JB8PQ7iWYU2p2/U6Gbd8CHtEK8CaLwwawFuWnhtHBe7TU2LD2bS1vJxUUpqWv3hR1jTNm72B0
 ERO1vWqb7wz76R0uskfpkbuWmUKBCkpGEQ8y3woUtwsO7td9zYE1k6/iydue/vbS/Npe33Olo
 bHWayUyHGZas4EA1eapaHfN4X0TJNr02LqltMyIRNrue0TsjUficzKSREnMaonif8YHHAXg74
 AFwQQI0liT8LG5ANWBGGEYfYrtM7CWyzustXjJa7dl9b4jOfRonKjirNTcQOKlaS6tY4B5TCT
 N8rMezMEGzAYBIB4o8nmfMg7YOM1GDtzIhdvHcUT/kJGaAu6Yyadt7lDSgcYvjEfyFzdKV5qE
 P8D3LYDa/NA4XMO0PRW7WqkBH7PUR3BMe6FVfGYNUwloXcQjoRINd6SSvcs1MNScDnEgCO8mX
 1UENP/L32ieo6OA6GH3lhPx6wStLl2F2VRntQ61P93idiy5tXwlY8PrbTm8pWO/2MmVlQnrr9
 mtd38SnG+AWVNyM080Gb+nzmr8R26ByFYcHzICaAM9krEE3kZgnhsfdQ+8HSEwUvCGU+U+m30
 9Fw8f0ZRpGQwlOpScKzxgq7HG5I0irU+HU91oyuIoqnGfcelhDXCO4N7cYzbiChopTTjFAj4+
 kMAwEACdgdCu3qFnqRkwsYu6ba5MO3HLkCr5BNx0l0FnLMtZv90+Ln6KfS9kJoH3iZR2lTDvJ
 ekxZb/F8C0c65drlT05fX1SJlXhNNqMA9jkjWtA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pKu0RCboHYyUCdPAxdE0HKbMYvUCYRoio
Content-Type: multipart/mixed; boundary="PUD6LJv30DH14K0vjDXHPlEIJWZ75Fd8T"

--PUD6LJv30DH14K0vjDXHPlEIJWZ75Fd8T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> We're going to be adding more options that require RDONLY, so add a
> helper to do the check and error out if we don't have RDONLY set.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/super.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 8840a4fa81eb..f99e89ec46b2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -458,6 +458,17 @@ static const match_table_t rescue_tokens =3D {
>  	{Opt_err, NULL},
>  };
> =20
> +static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned lo=
ng opt,
> +			    const char *opt_name)
> +{
> +	if (fs_info->mount_opt & opt) {
> +		btrfs_err(fs_info, "%s must be used with ro mount option",
> +			  opt_name);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static int parse_rescue_options(struct btrfs_fs_info *info, const char=
 *options)
>  {
>  	char *opts;
> @@ -968,14 +979,12 @@ int btrfs_parse_options(struct btrfs_fs_info *inf=
o, char *options,
>  		}
>  	}
>  check:
> -	/*
> -	 * Extra check for current option against current flag
> -	 */
> -	if (btrfs_test_opt(info, NOLOGREPLAY) && !(new_flags & SB_RDONLY)) {
> -		btrfs_err(info,
> -			  "nologreplay must be used with ro mount option");
> +	/* We're read-only, don't have to check. */
> +	if (new_flags & SB_RDONLY)
> +		goto out;
> +
> +	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay"))
>  		ret =3D -EINVAL;
> -	}
>  out:
>  	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
>  	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
>=20


--PUD6LJv30DH14K0vjDXHPlEIJWZ75Fd8T--

--pKu0RCboHYyUCdPAxdE0HKbMYvUCYRoio
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tO30ACgkQwj2R86El
/qh+lAf/el4Uppxe7qSmpMyZXIPH6ShwQQbXPSOvxdvV0yJy7M/BmwTwgn78eMKO
2yhX48k+UN3kmm4OaHPVj6+/rR80igdj/Upz2wUGq8FYalYP/YnflAkf+xsBCSvk
UVqQrqhjzhZM99yTEtZFhRnCSj3n+RryYo9aJCWMT3vIAHLWQJ/XML3zTjhuhwUv
l22fPjg3OrFBs4SX3dMPTTZg5KMLfbWv0vnyglBaaCOYkLSWUtTjx42e89inveWc
CKd47Ci3jtdh0qoetJHNj536cOWrvEV+VFf3Xo41uBWsDC6JCzJJkrp9/UsVPnDx
XZBDvL0OGSp1gZ1vltdqRmfXBNqW0Q==
=/nRh
-----END PGP SIGNATURE-----

--pKu0RCboHYyUCdPAxdE0HKbMYvUCYRoio--
