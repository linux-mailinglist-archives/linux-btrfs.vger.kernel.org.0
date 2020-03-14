Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1281B18533E
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Mar 2020 01:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCNASq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 20:18:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:41825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgCNASq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 20:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584145121;
        bh=l3rsTurRWmWdwaxBOFrCRCMIydRDRHZD1Jh58Bi3xHk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R57fBkXQ1HQ55jIFBZHEfjnvwduRaSeBQGEWG3Pj+7HekV0BPF6dzzE1KblN7+BMK
         1LgYPs7e19RJCGP8impVrq1VSlVsa33Nk3LLBL8Ug6MzQmVWO01xt+ZK7zGFoRFu0B
         rN1GKx/UgHGn+zTEisTVclixz1XC3EpFSffNJSa4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQvCv-1izWcS45Dz-00NyBn; Sat, 14
 Mar 2020 01:18:41 +0100
Subject: Re: [PATCH 1/2] btrfs: do not use READA for running delayed refs
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200313210954.148686-1-josef@toxicpanda.com>
 <20200313210954.148686-2-josef@toxicpanda.com>
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
Message-ID: <4b7a21f7-5676-c0e6-6e5a-75cb3fdcc377@gmx.com>
Date:   Sat, 14 Mar 2020 08:18:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313210954.148686-2-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="azDDdxoxfaYKiAUxpw4jhN2cZCMMuy2Ad"
X-Provags-ID: V03:K1:qlisU75095Z6po+H6DmVDszeutuhzz3MJOoPY37X9WFIQMil3T9
 wfO3/ov0vg7Dc71R0S16D4G9azHOGsX2DAHAaRPRTMPp7e+ROqjURgkOgVYzcqx51BR6klb
 4IR7dSdC1ByOX/H42baLQmG2IMM9GmrnmfD1UVfqLjkwi5QdGQvWxecUiip+XWxA+kp9BVF
 7quXO4WHTehpWBfRMpa8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zipKpmvcHT8=:IPwu5XWfOpaF3pEUrjv3ij
 5R6RBZ86Ld4UP9zzjmi09sOL2zVi5WBaeKs9WK9GquaV6UmORg0zWeEARa30R5lBC2FaeeSDC
 0GRcg+D6DXF8otKi+6frAQogdVWyuMfuqj47cstF7qACNunI99sLUO4/MCUadGMHotA9GS24S
 B9tE8lF/Ix78uWH/pCd+wgTXaik4H0CKnApW9bk0mNEofoWWXixn3a468opCBdXZGluTyjwr8
 9aAv2rls5FNsa/K10NVl0x+88zxmEKRKsxldhM1hqQRwULnO7320tz04mgEd9JR3H8DK7hqwI
 SpKdr/N1Ig8mMyFyDvkoPXoz/o6z804LXOS9vO0OkQFLUSidggc8MxBw4TR+H3TZ4HP9hF/CH
 pbM7BDQvibs2o6rCsHKjIC447FOZ1mD87x8Pttp5eJ1NulMstFYmQ0DIXXBcFGzE1VZ14a0h3
 OagKlWSvajTer6I5O4uBQsj96RELEzPojEd1rczFv9jrK+XVXitl6dvXOPop3Z5iyqKxp/mwq
 qXqch3cW1xlvUQRItyzoPrqGQiVUqvSjJPCewdjuE21dQqya13JGCp4lWKisFnSWcXsIbq60H
 KEo4T7KblqPH9o9MVDCgR4J6SauADuPxFqtu71JuUTck2G0q8h0cTZrO99ATwu/2awwhYB+uZ
 V+PDGsaD+C6dUf4GJPE0kfZxNyrZDuqjREgOfHfuJkUG8vU8Fgx4T0QiGhDn272DYJtpUlRSo
 rc4gHhq51FC5CN6SdyIrlZp4Zj4Vm20AQbonMl7XgzfBeDD5xnKzOmGouC7+hMMvnuwKQCXFh
 J5yqwLvJN4vGQydNuYMWjWtgaGXRXAviqeDqKdiIuduQ0cDJ1LNsrALtt+d8Tv6NDRWd478hT
 3NeOf/o8VsCiY2Nk2qmFWXgYwz1UDDNmjlPkcUp6eqfY7oG0dMVqh5MVIPdvq+LXwPigYLGel
 araE3WMEBnHFnpG/SKTDB94UMP7ZkaXoFjhUdYCJnRWQCuWg2eEDZJbrWL/hPoQUarvvT0vBv
 1UDrO0NSExloRhpDddivjupnHi/4geYMN4oiSWxstZM1Rz48KIwbeoHXs8phSADXNnbyAeMgm
 +KaTE0Y1JLSdy2QLfxqM5meG6tIsFAUFOKnvGyiZoaj3smTHgAvWiUMjEVIs4ODMlAnGohfqH
 yubOov9bT+odicigFJB12AcYfVIY8LrUZF/2IDRz9vcGYOTw4j6pULSBj1GMWsb0e6yAyvNqb
 +burbEIUz9esCekK5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--azDDdxoxfaYKiAUxpw4jhN2cZCMMuy2Ad
Content-Type: multipart/mixed; boundary="Q1R4NMqOEMGxzlYvluspbDwpLFetRSrTr"

--Q1R4NMqOEMGxzlYvluspbDwpLFetRSrTr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/14 =E4=B8=8A=E5=8D=885:09, Josef Bacik wrote:
> READA will generate a lot of extra reads for adjacent nodes, but when
> running delayed refs we have no idea if the next ref is going to be
> adjacent or not, so this potentially just generates a lot of extra IO.
> To make matters worse each ref is truly just looking for one item, it
> doesn't generally search forward, so we simply don't need it here.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/extent-tree.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a24ef1cef9fa..8e5b49baad98 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1469,7 +1469,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_tr=
ans_handle *trans,
>  	if (!path)
>  		return -ENOMEM;
> =20
> -	path->reada =3D READA_FORWARD;
>  	path->leave_spinning =3D 1;
>  	/* this will setup the path even if it fails to insert the back ref *=
/
>  	ret =3D insert_inline_extent_backref(trans, path, bytenr, num_bytes,
> @@ -1494,7 +1493,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_tr=
ans_handle *trans,
>  	btrfs_mark_buffer_dirty(leaf);
>  	btrfs_release_path(path);
> =20
> -	path->reada =3D READA_FORWARD;
>  	path->leave_spinning =3D 1;
>  	/* now insert the actual backref */
>  	ret =3D insert_extent_backref(trans, path, bytenr, parent, root_objec=
tid,
> @@ -1604,7 +1602,6 @@ static int run_delayed_extent_op(struct btrfs_tra=
ns_handle *trans,
>  	}
> =20
>  again:
> -	path->reada =3D READA_FORWARD;
>  	path->leave_spinning =3D 1;
>  	ret =3D btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0,=
 1);
>  	if (ret < 0) {
> @@ -2999,7 +2996,6 @@ static int __btrfs_free_extent(struct btrfs_trans=
_handle *trans,
>  	if (!path)
>  		return -ENOMEM;
> =20
> -	path->reada =3D READA_FORWARD;
>  	path->leave_spinning =3D 1;
> =20
>  	is_data =3D owner_objectid >=3D BTRFS_FIRST_FREE_OBJECTID;
>=20


--Q1R4NMqOEMGxzlYvluspbDwpLFetRSrTr--

--azDDdxoxfaYKiAUxpw4jhN2cZCMMuy2Ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5sItwACgkQwj2R86El
/qhGZwf6AiMHOpGS3IjttRIGFlCr6EfykCrEoKMoIwCdEADqc5lTScfLuOsuh4z4
92tcGfj4H/1pUmia8Ue3z799YoLRpHE4IEWsYnz612T7jtEYqthnyw1e/WOum0Hk
ShUQpFvtX6tRpyRgemaXxgdjwNGQi9oG3lFjoQxrLNdVQtugpBhcJO4WmbnG1vQD
JoAB79TmxhQinVkKqHIAsI3dZethnXuiJ6iNvprhxCjzz13Cuo2QQSlxv5Vm9Maa
1eKReC67c7MiEbOm9BjrJhQ91nbaiZR1WlZvetqaeLZ9PBfSvb7Apab7BU/NOY37
3Fe3COTRnbl9S/um37C6sXi5Cuxetw==
=dhFn
-----END PGP SIGNATURE-----

--azDDdxoxfaYKiAUxpw4jhN2cZCMMuy2Ad--
