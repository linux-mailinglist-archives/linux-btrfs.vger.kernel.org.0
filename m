Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28FE2CCCC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 03:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgLCCnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 21:43:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:55821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgLCCnv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 21:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606963336;
        bh=L9S1fdx+DzyTEjc0C1kX0JzyKp2eY1p64PsDf+MGDp0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CvfmAYALRAoymN1KM/3xGGDvaO3vaohqHzk/GqCLLSNJ1aGSkU0dBXCxz8gOEFLHg
         e1jj5IUZndlYMtOodbKFwfGmkOKJXTLLPrHneN8i+PMviczcRzZXFBVEtZsQud4EEv
         fWk2q092zNGDsi+S7k4sA0DQtgSRi+lFU+Bt0Ihk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lc9-1klTuu378F-000rT6; Thu, 03
 Dec 2020 03:42:16 +0100
Subject: Re: [PATCH v3 20/54] btrfs: handle btrfs_record_root_in_trans failure
 in btrfs_recover_log_trees
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <23564d0cd777eb33583aab981374438a47110c72.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <96bd748c-1e8b-8546-3ea0-6c81fe91cc9d@gmx.com>
Date:   Thu, 3 Dec 2020 10:42:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <23564d0cd777eb33583aab981374438a47110c72.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d8Vv7z9lTsuUdxN3Cwb9y10Ji3JRuniZM"
X-Provags-ID: V03:K1:/14UCZxwP4L8cz6ztUfhBzJUFCC1iQ7wS0OgZj2Z4aH6RL4+piN
 0yGdDvKmyuOY9h7d5Kc6e/ubj2tHrCMzrjJ/zChQTdLDp/p4JkQOosFHKzihx1hs6ZvDkpU
 NioNha2AHjYRXhWCvLG/AXZ18HQZLK/sMepG8+qRsor4JtFDhdU+rDtAZ3c2ist2NSB/ST1
 RA+9jgDcyWgFBX0JysOOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ww1vYprLwT4=:lG6Mhm0eWOyvWdAFfHsIXy
 BY5YDs+jJTMxPjoNO3WPvoh7aWV7V/WrRaSFo9c3FIibKGcAaHZjG0PAVIBzlls6PzmTpPE2Y
 d71PR7WChoCBBLcU6/5LFEnSa4Re+eA/ZsXnwUYWzvtSa9GeIYTQl4YjaoyCCf4vP1zHU5nx2
 egB9Gnlj0lZ1AcuAB9eRwCyLPn02xzPmngWfcJ+jjBaR9srrmHcm7TepOpz+FQ7wgfZ0zZOc4
 0U2iZPbiFcnogT/jW6+dfXBdbV8uqYYKOepJMWHr3ypV4Z5zvCj7Bz4JDYFna8jedtqhMqCjq
 aIJSvH9YCQegXb5jK9EsV9paNvhHBGaAh7I4XoNEKFeiBSB7KwHs6ghKRTyPN9FaoDbihiGnU
 dupDMEfAw/qVtjjJrU0Aeru1dB4Xxk9dNFsjbDywZDti5VkHW0BHjnZ2VV8B6pQ9Qiw1MfwFS
 qxN5QAFX3+PtDVD6T31PjJzVHD8eFK1e+cTOTOIv+T3A6Sb3vxyHlBHQPLZMfvDmKcOU0GEAD
 brCxNW1OajOsbIMfRhMwzP27b7woMlHaKPUYi+dW+xdy/0/gf5DLqTbH4BMQf3PVfZwOSGSBO
 0dThyUuGxKDg044tfB3pCtA/QdK2idxan7oguRadXj1fZPS9ZxW1qjgUKT22G7Y6M5Mf1ou/U
 VyeZoMeYeZuZVS3FMa2UiYmoc5e3QPCPVuT2pBOkWDhIYaBg9AEQhYT1H72xPYCrkDjn1jBkY
 rVtUr9b7sDPKtOmHAbGWJjv3w+SYzwlWWEkdBVEHSCXtZgOJrVsQJ1GrBLGHDRYJsEKwZGp+h
 F7LUryq4o/xPFWSBa1mfZ0Jy2vS63LXJPJEfRZiM81t0sXgZUAbapYyOV51MHpPZeZq2e5mYS
 6l4X4C7cHzPXiTU8K6og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8Vv7z9lTsuUdxN3Cwb9y10Ji3JRuniZM
Content-Type: multipart/mixed; boundary="ovvmJIfnGG4FTY7J9xXuD4MfTaLF0qapr"

--ovvmJIfnGG4FTY7J9xXuD4MfTaLF0qapr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:50, Josef Bacik wrote:
> btrfs_record_root_in_trans will return errors in the future, so handle
> the error properly in btrfs_recover_log_trees.
>=20
> This appears tricky, however we have a reference count on the
> destination root, so if this fails we need to continue on in the loop t=
o
> make sure the properly cleanup is done.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/tree-log.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 254c2ee43aae..77adeb3c988d 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6286,8 +6286,12 @@ int btrfs_recover_log_trees(struct btrfs_root *l=
og_root_tree)
>  		}
> =20
>  		wc.replay_dest->log_root =3D log;
> -		btrfs_record_root_in_trans(trans, wc.replay_dest);
> -		ret =3D walk_log_tree(trans, log, &wc);
> +		ret =3D btrfs_record_root_in_trans(trans, wc.replay_dest);
> +		if (ret)
> +			btrfs_handle_fs_error(fs_info, ret,
> +				"Couldn't record the root in the transaction.");
> +		else
> +			ret =3D walk_log_tree(trans, log, &wc);
> =20
>  		if (!ret && wc.stage =3D=3D LOG_WALK_REPLAY_ALL) {
>  			ret =3D fixup_inode_link_counts(trans, wc.replay_dest,
>=20


--ovvmJIfnGG4FTY7J9xXuD4MfTaLF0qapr--

--d8Vv7z9lTsuUdxN3Cwb9y10Ji3JRuniZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IUIQACgkQwj2R86El
/qhyiwf9F94/b2nJJ0etkeNzMGCC4wQj8qetaTREehvX1QL41cjlCqTq/wOiXM9x
ol76Eo2W1ot6SfF5qYEWQLvb5nfp5kUOqfvo/Ny6cs3vvg5KTRhw8Vb2VcW1zS8F
Do6iPB7EyiiZ2ue+m+T/UFQrlKpRddrDMM7RLzNVGluGdlTpGlCvfkTXtGFPDCW+
/dmAzLnF3YfuF+BHvb2Db+PiyxSmtmqzUEw8XVjLBzmNjIqWEkiQGUoi/1EZwMpw
JXgBc/vaSfFI23yMx2YZX1lp3ScWLeyydlSRbpEUNcw4/Ts2adkyz9gVblNDgy1R
Sw+Q6uJuiu12QVs8J9HcvFHKh6labQ==
=EEcC
-----END PGP SIGNATURE-----

--d8Vv7z9lTsuUdxN3Cwb9y10Ji3JRuniZM--
