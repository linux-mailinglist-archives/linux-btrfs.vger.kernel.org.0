Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD2E277D23
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 02:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIYArQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 20:47:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:37237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgIYArP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 20:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600994831;
        bh=BvawnFVoC5Cfle46NJVjcyukKNsRci3KPvfp6QQ0eEs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NKjIVXYO3WY00vMFoCM1U7Xp4WR+lBITj+2GCnnspsa/CMv4NK0CPyjFmnmRpHWiP
         0n6jGmQDY19EG7ynqlxzAcixcASeubesaBRlnZkxbpxEq48R2RA3l1iBTKrL975LD5
         xK1J3CtjYYizyLpbY79MpgZc6UELpL1YMe+NCwsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0FxV-1kgy653hgN-00xNkJ; Fri, 25
 Sep 2020 02:47:11 +0200
Subject: Re: [PATCH 3/5] btrfs: introduce rescue=ignorebadroots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
 <b7b5dfb5542c3eb965cd2d8a9baa2999b6bae638.1600961206.git.josef@toxicpanda.com>
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
Message-ID: <b6710997-5150-d082-e260-9fbbaee74e4c@gmx.com>
Date:   Fri, 25 Sep 2020 08:47:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b7b5dfb5542c3eb965cd2d8a9baa2999b6bae638.1600961206.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dyYSH39J9IuiaxDYAmwKgib9Abpq2v1qP"
X-Provags-ID: V03:K1:mKNsnxFJ5OPWvn64Dli33WaogkK8t95FwuZAQdSHeB31dPTNFsF
 Q1KalZy9S2oHsadLOdvTABiVxJUrV6hVFf8mtcH8ovSMNI7R3v02pYSHAlpBirZ0hMc2bBM
 i/7rYrSz1vN2QUR3tIW8Q1TvnyokdtSwfbq1cahlWqrvurmM27SmgEWc/Tn03Oaogylq4RU
 nWr5r/FhrV3FV1wUeGZfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUkFTgO2Bf8=:5wDtGXJS6caHmlvuMj3p9/
 znSrtOK27wP6ya0gf64EeFpCXBZPOHCv+dMTRolZhTwS9JFtphTUdZ/w1iPGEpIZEZUvF33tx
 Weu3OfSgCfX4ljjgkVnu8qvbhpTaJmmaLLzb59ac/Bi1KhKR4csCVAK0qXTkHI96+auxixDjB
 zaGLP8N+lb/po7uq/dIU4BijkLZx7JycfYKU3VUEHkWJVRG5uz5InLuuavnFVhgs3Rq3xJ8pf
 4yqDVGE6xjv6v99hL3IXAkhPUCiBG7cqCx5KCfSWR9NiZ+5YWLq5/i4bUnlHG6ECQaI+LmR0/
 rwU+5l1CHUXX8q4KjzL3Xj+mImVFPUIafPrgORgUarxIfpc4LatKxRnExsYJ+WlaU1/znasLU
 LqFDy66dgIXwTtflhn7DfVeZ6eX5rxpEhhIlnX7x0XmSbTefUQGE4IRhbwfCRVG/ji0PLzH3d
 BTP1IukEC9B4fVmZtKLMADRojtmvpTCRi8HULsUiCV1/7l0fuwvdQpM52tblH//SW8ZNwaDlt
 WbBjCOnmxBd9kzWLszCEZoQKEkTBRFRM/9pJ6bewAyva2KLcmesEQAP5sKpMH0yYQARx0vROR
 Z8/duTsT5fC3xl2bd8Vhod8WnJaripSArhLfmC6pEzpVEyYS6aUQ7oG3eFjQjnFw2JO84Knh3
 sFRYaxyp64RTK9tPkpIOFczM3qLln9kQ0ijhGHlo567bTxvZEoG+7L805yYJPQTpm6MPPM/SH
 0BtQBXBRYE239bd7PZvkQ51dDw4Vy6/guhixz4DpK2itAMTchp81kOFuu9C2QeX3UkoUv/BCT
 9b5wMRMqSGLrnpe5ia1O2AUyOnBWHzcWQnocVEvWdPJaqcVx4cizYMzsudNNQxt0FhW+ueUIP
 70FdBA7e7E75HK5rfS1qZNKFKU9cr8xJ0ZUL3GQ1V1A2ENw7jfUEif0/0/NQaJinpZJoHv+ZM
 xTK7HoYfmgzTEXTlKPKMf/m7fub90OEYEgpglPZ20qVQdEvLm5Is9Mw+Wn5tTAh3gE4GlnJ+p
 FgFRLCvyw53rch98cUpaXwznH+1xk3S5ggmoOLA6AFoH8L72M5/7Og+kvsX4Qdf8ow32FBjmf
 1GJ4+KGcSI03kCKYs3vUUnjYTl1mU2uPVNTe3ZNYh/T1qUvnYx7L4oovnjBIcMDsj3TDShxbg
 /TULYLwxBcvqHvyTJl6QdS/1CaQ1rZ8HQ54eGGcsX5fc81qH4NC3xhaiTF+UL+Xw89pPOl1/W
 SErY4vUzsnSNe9Uz6ZniBP+eGC+KSMaA0YQxKBg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dyYSH39J9IuiaxDYAmwKgib9Abpq2v1qP
Content-Type: multipart/mixed; boundary="v2QVVYR2IscpfnjFYHhF6mfcZbc5ITthw"

--v2QVVYR2IscpfnjFYHhF6mfcZbc5ITthw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> In the face of extent root corruption, or any other core fs wide root
> corruption we will fail to mount the file system.  This makes recovery
> kind of a pain, because you need to fall back to userspace tools to
> scrape off data.  Instead provide a mechanism to gracefully handle bad
> roots, so we can at least mount read-only and possibly recover data fro=
m
> the file system.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Mostly OK, but still a small problem inlined below.
[...]
> index 46f4efd58652..08b3ca60f3df 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7656,6 +7656,13 @@ int btrfs_verify_dev_extents(struct btrfs_fs_inf=
o *fs_info)
>  	u64 prev_dev_ext_end =3D 0;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * We don't have a dev_root because we mounted with ignorebadroots an=
d
> +	 * failed to load the root, so skip the verification.
> +	 */
> +	if (!root)
> +		return 0;
> +

The check itself is mostly for write, to ensure we won't have
missing/unnecessary dev extents to mess up chunk allocation.

For RO operations, the check makes little sense, and can be safely
ignored for ignorebadroots.

Furthermore this only handles the case where the device tree root is
corrupted.
But if only part of the device tree is corrupted, we still continue
checking and fail to mount.

It's better to skip the whole check for dev extents if we're using
ignorebadroots rescue option.
No matter if the root is corrupted or not.


Thanks,
Qu

>  	key.objectid =3D 1;
>  	key.type =3D BTRFS_DEV_EXTENT_KEY;
>  	key.offset =3D 0;
>=20


--v2QVVYR2IscpfnjFYHhF6mfcZbc5ITthw--

--dyYSH39J9IuiaxDYAmwKgib9Abpq2v1qP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tPgsACgkQwj2R86El
/qipNAgAq10SXaFhTu2a4K5loFcQC8yB7xnKEbsOAR+XhpqFjOMh/OJpmg8e7mtD
ONZygsTwbP6yjvpwRWZZlXVapQxUzBDm/evAYAZDqwI9mxMB5j3Mhw7OeMf0JFrE
fafhZoKR3tLoFyIb4vNxY6CLck7VyRL8MncmLNdinhqYMWdzTVjoFDxe2zqqkTnO
YOah3b4cA27I5eh4CkP1M+Pv+elXgi0W7WRX0Ehf47vQrcdy6o2oheTs8LG3Cr4s
fmoNg2tNQKsUTtx6BrSToKqz1t9cgjFMI1X/XKaqTyrqPSWcXuGXKF4lA087XwCl
AKIkrutWkh7SWUYJQSmJebDCThFUUQ==
=lbhG
-----END PGP SIGNATURE-----

--dyYSH39J9IuiaxDYAmwKgib9Abpq2v1qP--
