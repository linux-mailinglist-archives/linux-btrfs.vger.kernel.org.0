Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5C17A45B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCELi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:38:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:33789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCELi2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583408303;
        bh=cRm3Pm6t/z0qISFr8N5FMUVXR6vK1leD617q74tpST4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M7gtvLL4dElO95TfhusfJ4ksFdnm9CQCf1zgkUhE0aXurjMOrsVns/3ZWydfPAACl
         g/CPxrkSHp+/kcrQ9pgV34BmHPdu/1CMfsQqFISdWuMefKiyhsaUJnudcF5LO47Sqi
         tCGUJNIIXFs+tMmPa3M3H/cpAXN9hYvc32SLTyv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1jkWgy34Mw-00b1zi; Thu, 05
 Mar 2020 12:38:23 +0100
Subject: Re: [PATCH 3/8] btrfs: unset reloc control if we fail to recover
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-4-josef@toxicpanda.com>
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
Message-ID: <78d28297-1c39-9150-b846-2b435b0b48d1@gmx.com>
Date:   Thu, 5 Mar 2020 19:38:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304161830.2360-4-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wavCRDs0U7fHmA8xeA21Na6csmacJRgv4"
X-Provags-ID: V03:K1:+WudUwc5+kj/J7am9HGTIpWQ0TyALjneF1ec3MSOyDKM/DcZej4
 EPIFMSbj3Uahr2yt8ryG5FnUlTwdgAL0YcZzEiZtopWTU/VngC1TKOxDSY6VEI1sTc0VjLN
 wrfrTF/VTZetGRtMJyJJcPO9RPnOEujBdVFvljOXq7sdC55nKcxrDtUpHn+NYiFJCZoUW4e
 kcSsj18286+QdywFEz6eQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3RiI2YId0w8=:FUCkvPewZYkmLnDR3ebwhZ
 32p8LCLPOqSzSET28uAoE1slxBNtVTdpDKgLC5meFYvjS5FdUaAMy/C/DIj899WGfpxLa0FT+
 e1Sp5KNxWGf2Od43vGG02S3JO2504at7cPd+Ah2X/mhTa14uL/9Q/uYoPypw//88oitENnTGW
 CbFkgAOK+rdqvvQ4Ac0boC7/M8x//Gfgp9hfKjnHQWoQXJcObrMn3ZGG5WNG/Rm2GNMQXq+J/
 SCGP3MxIJxtgtyevqQuul/vnv6m2gWDEjr3i2h8mq5owR4BHWZBT0i26cYHhBLyvQ/mIztpK/
 cB/UVjuWb5BtovHrvpUuyTIHOYTlS7NloLsaGVLG4D17t8OEZXrj+CxF9MKGmlWltzYFUVrTf
 QRV1DnpZr3QSfJGMff7UITaAZAAny1gRub8xbYOpBbfhuDwSCkRJePbVnhB0yYpukTIzc6jHb
 mej0Ug5fUb1/esyM4eWyiFaONEJqEZL0VJ2LQkahHymcxO74GNsqS1gl1YzAgNZ/Ga+9ABAX7
 zRjaC7sxrUVsOich6XlRG4Xf6L+6X+fTfpauFq7cVSsfoJzVvGvx4kYAhi53zgoAomvf7xKrX
 PduOc5rAuwHZ8OI2ziVeIQ2ac8q5CPDcmRiPktYFMPt/RNmfsXruGOzPLsszN/lcmuG3RV3ST
 KcbXMZe+I3ZXzxV62bMVC6iKFO8H4DrCirgzrXFk3DWro3TuIteJ6giOgx3VATWUEbgM3tF/S
 WnDS7398h9xHpYnFpqr5Xzk5wpr327WWUJ5EmwPmcbai0WnA+avA04CoaS0QNIHfLfCFCPii6
 5GoHsSvhcV0H/5a6z54hFlP4j3uJLk9Lnv5M1E4Qcalf2voL4223F3G92Os1PlyKqZAVMur9L
 QGUCyqq5ddr+dlr40opvZmZwhDBxKeNfJAe6zFzG2w91CtfHoqXuDDpLqS2KayrZh+tBzlSgw
 gEppOk9eiQizSbvNY0j9xFffx52Q1RqNs1Vu8iHTBMWHJxfhm1QOIOOIhpFmYdhg+HCo63unm
 z8A+f1yofN91IV1JkekqvDV2qZMEqS9jLf2q4MvdbQZ+gc0Bji3QoGfrtNG+lCxQOMMq03XqF
 UCvigWUHp09T/NToZBjpG45KDFNm/GYxlwiU2jsQYKRw+rp8eA8V/au1iIbw59wzyiWp2yeV0
 MBArpSbLJU9LuAT+vk9PDb9caoaUsUxhOdFIbO4IPrHeygKfBqD/QNm4SpYtrOM7ntvibQ74e
 S+MUgAKOvPV+goWJY
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wavCRDs0U7fHmA8xeA21Na6csmacJRgv4
Content-Type: multipart/mixed; boundary="EhLEijocj8PP9ksEDBc91J05zykMSuSmF"

--EhLEijocj8PP9ksEDBc91J05zykMSuSmF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/5 =E4=B8=8A=E5=8D=8812:18, Josef Bacik wrote:
> If we fail to load an fs root, or fail to start a transaction we can
> bail without unsetting the reloc control, which leads to problems later=

> when we free the reloc control but still have it attached to the file
> system.
>=20
> In the normal path we'll end up calling unset_reloc_control() twice, bu=
t
> all it does is set fs_info->reloc_control =3D NULL, and we can only hav=
e
> one balance at a time so it's not racey.
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
> index 2141519a9dd0..c496f8ed8c7e 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4657,9 +4657,8 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> =20
>  	trans =3D btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> -		unset_reloc_control(rc);
>  		err =3D PTR_ERR(trans);
> -		goto out_free;
> +		goto out_unset;
>  	}
> =20
>  	rc->merge_reloc_tree =3D 1;
> @@ -4679,7 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
>  		if (IS_ERR(fs_root)) {
>  			err =3D PTR_ERR(fs_root);
>  			list_add_tail(&reloc_root->root_list, &reloc_roots);
> -			goto out_free;
> +			goto out_unset;
>  		}
> =20
>  		err =3D __add_reloc_root(reloc_root);
> @@ -4690,7 +4689,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> =20
>  	err =3D btrfs_commit_transaction(trans);
>  	if (err)
> -		goto out_free;
> +		goto out_unset;
> =20
>  	merge_reloc_roots(rc);
> =20
> @@ -4706,6 +4705,8 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
>  	ret =3D clean_dirty_subvols(rc);
>  	if (ret < 0 && !err)
>  		err =3D ret;
> +out_unset:
> +	unset_reloc_control(rc);
>  out_free:
>  	kfree(rc);
>  out:
>=20


--EhLEijocj8PP9ksEDBc91J05zykMSuSmF--

--wavCRDs0U7fHmA8xeA21Na6csmacJRgv4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5g5KkACgkQwj2R86El
/qgEmAgAgI8KmVGJE8mtDHxgEhoyKkHhFUv/6SNdNZEaiKCaPCbH0jAxf1jkghxu
dXHNdu65/kJaAQDQocdpUBJeaWb9UvV7STMd2dqU4vx5FuhQxCjc0VAZYUEmPuaA
6kYfACrPiyC/Wcl6gHyIRzUEXxLhGPElV5qSbPjMDUjoGNYPsO/im4/tf1XRyrgk
h8Zbz4awZUeT4RP6NXJBzwq38vxstR/OMHFD0bi2VwxPxuUvudyM8mDLMmHVFBLA
tzxQNWKtEalFnuik+JHhCCel+/wZFt4tImtiRAw+ImE2VTe9ATSAQRA/gEQ/Xuc2
iSdYt/+gl9wLel+cgWAvfrnx3coqsw==
=Iznt
-----END PGP SIGNATURE-----

--wavCRDs0U7fHmA8xeA21Na6csmacJRgv4--
