Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B142613D978
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 13:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgAPMA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 07:00:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:47235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPMA5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 07:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579176053;
        bh=Q+PcaI9rSucZ/tvpFDo2nT6ce1F3hApHl5A6Hs1/qVo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DoocIO8Ntx8+uDWM4Mf7599XRs4bHH1FQogKn6/gPGxwJNC8owM3xTT4HqfysIASR
         xafgpnHNmS2Ac2QHaY+V3BgwoVa31GNyAIHeQfHxZi4mGwPqy+Z7v9ioeuPpkcJy+c
         mjWbYgC/gRc/CD+/ChdVUdgwUmRgHeCTXA0CXkMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQIv-1jOwj536iF-00oWSS; Thu, 16
 Jan 2020 13:00:53 +0100
Subject: Re: [PATCH] Btrfs: always copy scrub arguments back to user space
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200116112920.30400-1-fdmanana@kernel.org>
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
Message-ID: <cdc9bb1b-994e-ddbc-4274-be0886df67da@gmx.com>
Date:   Thu, 16 Jan 2020 20:00:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116112920.30400-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="grj4DKtEd83EYAPgXAFTD23hTzSMjofzh"
X-Provags-ID: V03:K1:g9oY8tvlzWfh2jQkYUMDYKkv/8FyToWpmDRbkihqvSBN0qvMYGX
 rxVILud0INhYyRbcTh2S/DCZUwYtpEvwOTBX6rvhe7rbyQFaK7xXxkwQ+reNrMNBI4jy7bg
 XxDKn4/bVOEi8O0lvpx1ybFp9HmumF3TIM7PJiy/U4GLsh+8ze9ITTts8UOuiZvigYKeLfp
 NBeKDhFNeEfICidU5hGTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zIjQyXCTmDI=:lT6IDuXAVDnTXqSTBJE1xR
 pZvwWi28v2MOc2TSNhLMC8dWIlxachzPLEzcz3xRqsw78NJsnm9Y4ZLmKfNJxziZEgGqR0fv9
 BgF6Z8/9mWu6MT0TqG11RQgKn6QQbuKhHTLQZrHqAw5zcQzNVj/dbqEFg3zTPO+wkmAg2L62Q
 mgFw/OGleB37l4dmgdaVc0gss9gx5ySl7YD9yDrTUw+VkS4QD8lVsquFZB9MyrvmNDawOAtDv
 1ktXu/lKXY+m6hhYRGiPcTzsrYtr2yZho0u8S0jgMfpWDUSDKYSdAfX3kGfBNZZf3yQsvP+4l
 IchPHk13i5uBtRMBgUK3Cp+ksTWpJVDUrFLglG7AFhRGU4/CqWNXD7DTPSJEngtuv+2GSVXC0
 EXVEL0472K7beIsYMfjEUcdW84AUesTs/7wJug4p05exuDRDK10ET1FnVNFxrADsMRsQSSHLv
 bJUmULCg+TmdE6ti9DqLOrJpCcA9ECCFXGNM/i51SKhmiY4JPLZju+YazYp0nMVgXFEcs2tvE
 SOiGyo01PT6Sev/xaBJK7BCPCEDTX4afDSDY7UqSrEMCQGUc+6m9oDdB38ERg82R1q+fqrUxv
 S6OELb8nQ5JQP/S62A+fkfbvGEPKqHzAlbHyxlTr7vuCg/v2y4RCwDIy+gKCo/XiN1tX2KBYl
 LbjTdGeauBqsz22W3bxI9riJyZsUzlIOu504KUTXxuvsHP7zeFb3cowmimnH9G8x9XuVyE+cc
 YXgVSvEdZA30LEjJP5FdsThIKDFrp+DaDO20+b2Yy0yBA/aqTtomdxOFFV0jzKjt7ie+unnFh
 VeEDccMZPQHYk+3n0nNDTvHaXIgF+UzycJLXJCya9G8G+GdKW7PS/in7dCSAWYUJD4IzOxPVp
 T2WG9jzRl9KB4IL/MsHVnHi860eMq4gB1gog77kC7tZi16RnZRtNVYM9QlsL0kDbUytaeaXHE
 0/YtH8kd872uilfuMBByaEakOyU33frQPLf1w5BYG7ftUW3omVk7KpY1OexY8QS99IIhlfYR8
 yaLVRuK2Zj+tQl95FsNpxXtiNXf3Vz2zY5ZLZVC4BYpUnIwPS13Cq6dDgydjmPJmpD/D6ZgBr
 SQWKv/tD1GFSJpl5iHqtwSeDo3lnOlXkRGeZ4iZsX0UnOW4J2+X4+AkH+4tZGwe7Lionp1XfF
 P+/tl02B0xkOro0NlUVBrAZmstTqubEnYTym9kUsZ2MYPTCyWwbnsgYe1/bZYxSKzakI/T5M4
 1ELi68XQsR+9xt0/mnBo5wQ0fhCr41S6cu/sxhHSeVpHtYRdVoVsCIyD5Llw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--grj4DKtEd83EYAPgXAFTD23hTzSMjofzh
Content-Type: multipart/mixed; boundary="P7cUfWo0THEZfMh6Cb5uYzhjMGM1fu7oC"

--P7cUfWo0THEZfMh6Cb5uYzhjMGM1fu7oC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/16 =E4=B8=8B=E5=8D=887:29, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> If scrub returns an error we are not copying back the scrub arguments
> structure to user space. This prevents user space to know how much prog=
ress
> scrub has done if an error happened - this includes -ECANCELED which is=

> returned when users ask for scrub to stop. A particular use case, which=
 is
> used in btrfs-progs, is to resume scrub after it is canceled, in that c=
ase
> it relies on checking the progress from the scrub arguments structure a=
nd
> then use that progress in a call to resume scrub.
>=20
> So fix this by always copying the scrub arguments structure to user spa=
ce,
> overwriting the value returned to user space with -EFAULT only if copyi=
ng
> the structure failed to let user space know that either that copying di=
d
> not happen, and therefore the structure is stale, or it happened partia=
lly
> and the structure is probably not valid and corrupt due to the partial
> copy.
>=20
> Reported-by: Graham Cobb <g.btrfs@cobb.uk.net>
> Link: https://lore.kernel.org/linux-btrfs/d0a97688-78be-08de-ca7d-bcb4c=
7fb397e@cobb.uk.net/
> Fixes: 06fe39ab15a6a4 ("Btrfs: do not overwrite scrub error with fault =
error in scrub ioctl")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/ioctl.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3a4bd5cd67fa..173758d86feb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4253,7 +4253,19 @@ static long btrfs_ioctl_scrub(struct file *file,=
 void __user *arg)
>  			      &sa->progress, sa->flags & BTRFS_SCRUB_READONLY,
>  			      0);
> =20
> -	if (ret =3D=3D 0 && copy_to_user(arg, sa, sizeof(*sa)))
> +	/*
> +	 * Copy scrub args to user space even if btrfs_scrub_dev() returned a=
n
> +	 * error. This is important as it allows user space to know how much
> +	 * progress scrub has done. For example, if scrub is canceled we get
> +	 * -ECANCELED from btrfs_scrub_dev() and return that error back to us=
er
> +	 * space. Later user space can inspect the progress from the structur=
e
> +	 * btrfs_ioctl_scrub_args and resume scrub from where it left off
> +	 * previously (btrfs-progs does this).
> +	 * If we fail to copy the btrfs_ioctl_scrub_args structure to user sp=
ace
> +	 * then return -EFAULT to signal the structure was not copied or it m=
ay
> +	 * be corrupt and unreliable due to a partial copy.
> +	 */
> +	if (copy_to_user(arg, sa, sizeof(*sa)))
>  		ret =3D -EFAULT;
> =20
>  	if (!(sa->flags & BTRFS_SCRUB_READONLY))
>=20


--P7cUfWo0THEZfMh6Cb5uYzhjMGM1fu7oC--

--grj4DKtEd83EYAPgXAFTD23hTzSMjofzh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4gUHEACgkQwj2R86El
/qhKjAf/QH2rQD2SYdQAKNdZgGcMsqMcj47QRn1RjTdqXWpFHNmPVAePxb1IJLyt
D9LRTkBRSH3B2MrlgnDyNDjJCeXYIydy3UC5xsKWZGZ0xHLevMjzOCgCxicPYAtu
vPnDSyg74tz7WaOgX70d9V/sa8cvWR9x4zBhLKgPYtmC805VlT+hHqxzkQfgORr2
/miQt5rmW2dzzUEt1ziajRapN4modY9xX4L6tpmp2mjGxOEcxepuzghOP+2D0ZqR
cgtxw8ds0xCNhSnTsarKIM31EALErQ/HKSaEanwxNwxj9fN1FTP5NB6XJReCbWfi
VD7doxVQhcn8ymJj77J6uubqM7UHZw==
=iOJC
-----END PGP SIGNATURE-----

--grj4DKtEd83EYAPgXAFTD23hTzSMjofzh--
