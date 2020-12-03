Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A42CCEC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgLCFoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:44:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:50155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgLCFoe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606974179;
        bh=QXPL22pMjak5wvKSOk86MtkcKATdSs5JXZUUfjzSqG8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QARMLaGvEg8dq2TH38/7blOQfk5+SRdt8SjcCjvgojPChIogFHcC63Zlq5oflZF5q
         plL27mJ5RdK5tW637EPHJAijih5Bf8FXtTdSPvUeQCRqa0Bx3/FF78BZQf9CP3JNy3
         AxdpGKfgxshliqPvIvHeyEsukRB7VO3lTMnaR2C4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1ksdTT1sUP-00CUfu; Thu, 03
 Dec 2020 06:42:59 +0100
Subject: Re: [PATCH v3 50/54] btrfs: check return value of
 btrfs_commit_transaction in relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <dd0d601ca7d0b24c316159e2c631f623863daafd.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <3ea9ba22-d9c5-2fca-7d3b-f7b227093c97@gmx.com>
Date:   Thu, 3 Dec 2020 13:42:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dd0d601ca7d0b24c316159e2c631f623863daafd.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xq5mcQyTlGogV38gikdu1BjpP92S3tl4o"
X-Provags-ID: V03:K1:OSCG9RlAss/R1i9cQpEcrnQEdS18nQv/tXB4KqIkcS47yk98jcp
 T/NP3EZNXA0cOPs47q0OGP4CprwMqrjDy7jMVnkUpQseanVEGAGj/Bd+KAGRq3Ldwzq1hJr
 blb2Qo5LYMwL93Cpa/YyPA03o6w0dYPdVMhbi0uj8lu+7Wo+g5z118uHkare2//yObPuvCl
 vUUDdTQoXQZqZpSPQjZfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kq9PzhcGPko=:xB3Ig3DBP7pKsbY4t483uW
 U9/kfEkhPMceIwV508Y78pSdtC2xgfGUXIx99D6PjuYpvEOhTqE0wTQ0WLeY5S4oYTioxR27I
 zm9fkm47uQzDjlR50vcvCOGoDSFt7pgLdJxckqg2nby5ogm+ZCEJMc9a7OKx8iIZGZ5IxQO94
 ushrgh7MZ8ilVRfOKw00CY9Rj94qHKv2nWS/OLJ/a2S+r78vhuWQI4j3XhEnFCoyGJL1kiL2y
 rMGcSSgzkpAAap2TueSld8PPapxXumVTU3Xt0OfW8GigxOAusJgVDz+oKU6n8q8Eh9eG4HUYI
 RveNUMC8i9vINiINNB1cH7bpEVWiCDzAPgwc8s1p+Oc/1GnZdZTLT99Q6w59ujR/S5DTFRi2V
 xfaDSmL7YdADXF2ZmSz8jLea/3tuu+2malpqa9iEuj9Sp8WqNw327CdE6gc07icj4uQfxUPsq
 Uu2Lnq7kiCxFLTS+KJmIbF2HVIRHygLMvTkKCLXx9HtpqlekJ1vWypeSXkvwMQhy+JcxngU6O
 Hq48VI8akUmhomxYjqmHaUc+X2qLOJ8YZmUhWrTwhBKsm4hXAWJGwh2qB8sAzD7I9gv35QKot
 pEx5IAo5uMg98MLkfHR0H11M9DuHdU4KYNlHavZYhI/nZTB3/Il67Ann4IegASHPtdWHEjyvY
 2PTGbxLeIaCFpV4kZGL5GNKr2SEsUaJVWmZ4Pziwscp2Xe+Vwp6Qkyja8UvgXG+/5XxQANMf0
 NS2278W3zkI3BbJw+fKGLULbD2MSYKnxMzIYdxpXwH9W65hxtivmh2/DzcVApU78pme5umBRl
 Ggxr9qHqdFB2aB04IPIj6zx6hg7NmFB0oGPb276ei7AHcO6l+3RZ49ausr13wjsYlaBCgLj0l
 dQqC4CwDeMabpzOCkPiFxNpjdmMOX09J/z3ZtrN9M=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xq5mcQyTlGogV38gikdu1BjpP92S3tl4o
Content-Type: multipart/mixed; boundary="6PylVhSnS2gdNT20VPHkVHXXE6SXsXks7"

--6PylVhSnS2gdNT20VPHkVHXXE6SXsXks7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> There's a few places where we don't check the return value of
> btrfs_commit_transaction in relocation.c.  Thankfully all these places
> have straightforward error handling, so simply change all of the sites
> at once.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 099a64b47020..15b6e54394b7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1905,7 +1905,7 @@ int prepare_to_merge(struct reloc_control *rc, in=
t err)
>  	list_splice(&reloc_roots, &rc->reloc_roots);
> =20
>  	if (!err)
> -		btrfs_commit_transaction(trans);
> +		err =3D btrfs_commit_transaction(trans);
>  	else
>  		btrfs_end_transaction(trans);
>  	return err;
> @@ -3436,8 +3436,7 @@ int prepare_to_relocate(struct reloc_control *rc)=

>  		 */
>  		return PTR_ERR(trans);
>  	}
> -	btrfs_commit_transaction(trans);
> -	return 0;
> +	return btrfs_commit_transaction(trans);
>  }
> =20
>  static noinline_for_stack int relocate_block_group(struct reloc_contro=
l *rc)
> @@ -3596,7 +3595,9 @@ static noinline_for_stack int relocate_block_grou=
p(struct reloc_control *rc)
>  		err =3D PTR_ERR(trans);
>  		goto out_free;
>  	}
> -	btrfs_commit_transaction(trans);
> +	ret =3D btrfs_commit_transaction(trans);
> +	if (ret && !err)
> +		err =3D ret;
>  out_free:
>  	ret =3D clean_dirty_subvols(rc);
>  	if (ret < 0 && !err)
>=20


--6PylVhSnS2gdNT20VPHkVHXXE6SXsXks7--

--Xq5mcQyTlGogV38gikdu1BjpP92S3tl4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/Iet8ACgkQwj2R86El
/qhSHwf/Xel6CiJi7Gfx3hs6O8j0IXjWmsY/w73nOEX0x07sIZ5XlWw5jc+AqAWH
162G3IXA7Wg4Z531ke38TiY9nUCv0FWQJWrDY/hVInyTD87ZSciYTwOhqEIhK+Bq
RdFGplcG1XVCPG1/qWhuQH/+bJJ2l/y8zNa9ktdDGkmC+vAMBLlvKXTVVOiLjLml
g+byZUwIV/A4bxkIEEA04Odlm8r4xPigz25jK66WhYHluc8236/EfhXyscrtmIc7
fbmtuzZb01fnjZugnSE0neWaZCN/ZEVsSBrwkt2p5uiTeRn8aSi6f7bQNdvgK14Z
AzIhO29DlRBTwWURA1HVsj4KHlwzyg==
=8o07
-----END PGP SIGNATURE-----

--Xq5mcQyTlGogV38gikdu1BjpP92S3tl4o--
