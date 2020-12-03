Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858F22CCCBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgLCCnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:43:08 -0500
Received: from mout.gmx.net ([212.227.15.18]:45925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgLCCnH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963291;
        bh=O7rRluCQPqKz2Q9s71tzjop/YngZ8C5+zKXV4dLovMU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CR8142004KlAG0loCysZhk2biBx9NB7Q/M8C0MTzPREX2+XfLTy0eB7GQ6L5AV64I
         EhkiV2mZBn5Rh7qBZr2yibhhwe8gQkxddPmdn2pW13X2BvpYjbjsejvwsgJvjQvB2d
         1VcMqhuMGHk/1PfyHQP8vPFH5K+Kj6JDtETmoWbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N95iH-1k94ft1KmF-0169DF; Thu, 03
 Dec 2020 03:41:30 +0100
Subject: Re: [PATCH v3 19/54] btrfs: handle btrfs_record_root_in_trans failure
 in btrfs_delete_subvolume
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <348d8accd247be56cbc57597aadaa46c85f0a5b8.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <abacd70d-4ed4-c6c1-efcd-e5badf71051b@gmx.com>
Date:   Thu, 3 Dec 2020 10:41:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <348d8accd247be56cbc57597aadaa46c85f0a5b8.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y0OyxPthB69CsjPC8o5TkCQcnKzTdK8hw"
X-Provags-ID: V03:K1:I2tAbw2Nzy2UB6vrbcql5Riii38KgfjVTXOEDqSK0aJhb43mQw8
 INw8rQ/+o0sTxo3Io9WOAbM8mTfUzoQf/BwZfLTXA1LJACFUp9orZo1xpPi9OVSY51HEklL
 dLlrpywsuDobjDhJbK20t2AhW+n+POFS77/lfHAW4f5VftDmrkoiEWazczpBnITW2loWXG+
 IhxUXQMeGzeVSLKafmjaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJj7bnB1xRo=:BxQ16Sb/ocAc74z5QbVanB
 92Iu1YfOL+M0w86imC6pxK4JlS9TObAqyQ/C8qbph5u/zG5GZDRNv2TjjK53Fq3HffxRhoQBq
 wIHfuVSC8OXF4+LQs2DsKuLXh1JnyLzFuaXjYvJl+LImS4e2ikdP7xReVelCXqsJYOZw76w76
 UbSV649fRq1XIzAGMWH+tQy6bnOvFnm42UgQUrkv35aRtRbcZEUT9ALYZgLIS6K/Rczj+QBKy
 ija7FyCF2mqk9m2KnB+zrYBRuhuxhKYMzIQHO8LeOXevpbWobopgaW/T63zeqXG1T2MGfpugK
 vu68+IhPLgC6Qmlji9qBTu+l74A+LDF6zdpa6G8mhmoqzIaZAglBUWkETLvICekFzLSsTXeqo
 bqR/Vfo9fwwzLW5G5mGQ2BSAm20qiRhRixgrVTrmZIMGFyARReyFmth4c5DrstVON+1VncjXl
 TBPGW0XorZ0AmS1q0uQxJbUEv0ashj/9X6/u3aVYPJ8nkZUhkRksYOV/VMx8qKNgzqOG/2PS0
 nZrxSoF8uTKNHfAJxc84lrBna6QuB49l8O8Tzz/e5lPyKCDl8NUZswI7CvNyNxFUaq1goZzTg
 uunvGHhDeAZ52IlHC/wrAq6mZycKDG2gcVDbHqScfItk/ga7KVjIdltr4ooZrHEpmC1fmOHAC
 bnA6ToWEv8Y58V5gBNmtfKonCDBkiaPuqPaZP/cEwmdcF+cKPL+BZKg3HEFkhmw7U5H0A9o7W
 +xLYENgeCkG1oazYIDz0LmbRXC/OtTkGBy6Vl/78+VzmGVfZW9yEKtF/yeXxnVov/AqE6K6pH
 zQVRhHj0fFxQxPERYxLkO0VkpmWO42gNpAWpstc2cVEfwwa0wh76xHTD5+XsZWryHklM3C/E1
 n5K8Hiinhw9s3F/bh+vA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y0OyxPthB69CsjPC8o5TkCQcnKzTdK8hw
Content-Type: multipart/mixed; boundary="oDjvgq4Dzu1LCtFuCxHYEXn6CK9vXzQFG"

--oDjvgq4Dzu1LCtFuCxHYEXn6CK9vXzQFG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_record_root_in_trans will return errors in the future, so handle
> the error properly in btrfs_delete_subvolume.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reveiwed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/inode.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 40601a0ff4f2..1f9fa63ef194 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4157,7 +4157,11 @@ int btrfs_delete_subvolume(struct inode *dir, st=
ruct dentry *dentry)
>  		goto out_end_trans;
>  	}
> =20
> -	btrfs_record_root_in_trans(trans, dest);
> +	ret =3D btrfs_record_root_in_trans(trans, dest);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto out_end_trans;
> +	}
> =20
>  	memset(&dest->root_item.drop_progress, 0,
>  		sizeof(dest->root_item.drop_progress));
>=20


--oDjvgq4Dzu1LCtFuCxHYEXn6CK9vXzQFG--

--y0OyxPthB69CsjPC8o5TkCQcnKzTdK8hw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUFcACgkQwj2R86El
/qgiiAf+NaDJ1Fm4dovQwZ0bZdg3tZLStHRRd09AMHU5D5/rP1ZhzID1u7SCP6DO
7Uh+NN8H/V+PKfWO16pGa4mJwlKKd3aaM3Nijdab2lzyLnFx+EYyBKxvYnP5vnCH
EJB5iBEQ4ggaO8xHoxBqIO2Kl+OoVATiL7ED+QGLjiRCNsuEEC0uZAFL3hr1WVwU
gOJM9K25mO+XtpYLrEipm0la3W8nPsATuXOO+5phCR4Ow9+diIpvIvVrsW4qUix8
ASmCylOnJp4sUA/ooQPU1+RklO2Y6HkGhW1HSPrLi5wxcorvHnzWTuAlqwbwJz6h
FM4+XXiX90dpB9y2YVggkV0qE0Xoeg==
=/ApE
-----END PGP SIGNATURE-----

--y0OyxPthB69CsjPC8o5TkCQcnKzTdK8hw--
