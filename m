Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAB2CCEA5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgLCF1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:27:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:45461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgLCF1Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606973124;
        bh=ghMSo9qjYzWGt0J+oXm6qSAsHX1L3/YH/NOPQvgdnPY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DINhyeKB4fmr+X9nGNw3RSLieaKcbZzp+nZgXqde8gbmZF7RlXkA2sqVQOeMWWU7y
         HxU0YHncBXXALvkIu3AApbbBMbdi9iZvxMqaKhfNj5EYgwZfoSQdRD5CZ3xvuNyU4N
         LzbuG742Jxy4KF0+Bb4Lfq5nRpSF5wPgNPZFb7xI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17Ye-1k15UP3xP8-012ZAG; Thu, 03
 Dec 2020 06:25:24 +0100
Subject: Re: [PATCH v3 44/54] btrfs: do proper error handling in
 create_reloc_inode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1606938211.git.josef@toxicpanda.com>
 <497be2d1fd745d88d6cbeda5d77168781b5522df.1606938211.git.josef@toxicpanda.com>
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
Message-ID: <9ec262a0-3dac-869d-5ed7-c0f69e9218e7@gmx.com>
Date:   Thu, 3 Dec 2020 13:25:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <497be2d1fd745d88d6cbeda5d77168781b5522df.1606938211.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tr27T8kdSRR4zERwKykoDOXRe1InTct6b"
X-Provags-ID: V03:K1:iVpCcw0lnxYdLdHuEzjGO+9Tr8A2hYbgVgoBdtyCXMGkh1piI14
 InLH1dbg5P6HehbOkpeN5N+31dSLVJ+7hUyazccvlppR6SCRlw7jTPBJorKvXPyQ2Xm63Pl
 3XI8K5Jq+VxVJm9MsxOXELzv1lHxhX9uZ3mIumlLKXmMp/l/VaOcbLKtlto1WA4W9YGyhg9
 jJVhg++SwPkp0v+sQUvNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ew+GlpWE0Fg=:AuBuP0EyuDL7nQNpixjn4b
 npi3kuk2Sl/OlkfkNxcjknaCtfjtVZu1LfwoeXQvwtdFimXI2MFshgAiAJKkUbsmyWYTNgger
 8WNZBVggV+Q+6mNcswaWOMt42JbL8LdPG3vmy3VBW8nb1MQsQI/ByzotLDR3mytZToZpYtDnm
 /VnXnaCkoIkhA7JBR/o1A/1azU1MKvNUNZI0HOQASgaUczOVVLN2Jbtc1cwEn0LhuvASXqvX8
 d621nAPvDVZpIJ7vm5VGInTeMcDzV+vGgDyL2Jjm7jXKv4Jl1lwDaTKa8+o6dSwvrpacLPk2e
 tin6sTY7Uzr0nn/VdKa/YVHUubrUo1onrLRKNQEEiZHLxzjjwL8UGMmAySD/BcDyf0CDMyKvc
 ubt5qAx2lHsRHw8NOaVewPR63LY7728ujKpwpT30hMkYD4dXVJVXZu/ntNCx9psi3DQ8J4lTC
 FnKB8vBC6GYcEq3NjsQLjYCBTHpsoAmbg2uAoefvtU6O8g1MooS7vNpWP19Cv26risaqdaGxE
 QmZCb4U1z3dFozItDBPqNglmp84nESqFZoCvlenWUHMH53BpBgOLWAcfuzM4U8hCWD7M7ADN+
 R/g/j7HOLY7A8pXJMmyNYnT71EaSey4TinBCKA5RnJ8XxRClrLcgc240cnSl2kWMRkQGvhRB1
 lz4QiySyzbkWEFONsWKsnhFJ/NOr36ZPmEkW4MwxrgHhp5KG5JECHdqOYc4mwMDwf0HKr+Qz3
 gH3ceLTwt5dtZUbRNElIOu2gtmbIMRvrPe8Asyi8QlILQv56zPhnjWe4d128a/lVlR377PN2R
 9uK/kkXB8N1xqOT5pDvtw/lc0wO+A/7lqvy/ag/RBqLalX/FkfahQUfv65rgP3OMLqBu9rtHd
 pOXy0xyPAXbP9rk8VBODnhLX5PHa5uoPDaMI1l0KY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tr27T8kdSRR4zERwKykoDOXRe1InTct6b
Content-Type: multipart/mixed; boundary="hPhZ0dlMvZu4wIRtxzIR1f8VTnJZlLwvw"

--hPhZ0dlMvZu4wIRtxzIR1f8VTnJZlLwvw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/3 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
> We already handle some errors in this function, and the callers do the
> correct error handling, so clean up the rest of the function to do the
> appropriate error handling.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8f4f1e21c770..bcced4e436af 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3634,10 +3634,15 @@ struct inode *create_reloc_inode(struct btrfs_f=
s_info *fs_info,
>  		goto out;
> =20
>  	err =3D __insert_orphan_inode(trans, root, objectid);
> -	BUG_ON(err);
> +	if (err)
> +		goto out;
> =20
>  	inode =3D btrfs_iget(fs_info->sb, objectid, root);
> -	BUG_ON(IS_ERR(inode));
> +	if (IS_ERR(inode)) {

When error happens here, we have already inserted an inode item into the
data reloc root, without the orphan item to clean it up.

It won't cause any problem, since we have u64 to store almost endless
inodes in a mostly empty tree.

But I guess we'd still better try to delete the inserted inode item, or
data reloc tree may one day become a landfill with all those inode items.=


Thanks,
Qu
> +		err =3D PTR_ERR(inode);
> +		inode =3D NULL;
> +		goto out;
> +	}
>  	BTRFS_I(inode)->index_cnt =3D group->start;
> =20
>  	err =3D btrfs_orphan_add(trans, BTRFS_I(inode));
>=20


--hPhZ0dlMvZu4wIRtxzIR1f8VTnJZlLwvw--

--Tr27T8kdSRR4zERwKykoDOXRe1InTct6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/IdsEACgkQwj2R86El
/qiEAwgAiBxc1Q6KL2i3oibJ7WLiXAAqd10sm/Z4IL4QGJRrFYgJbcsxxJS4nLDX
WDLULG9l0iyXIZFDXVSQCC+hYf76IuMoTYyKPGCmOvmAsUFm+wMq138e0dhcJt1+
VaFZXzB6JWfqqa47lz9XeFo6BOa01AsW8JrWp5bxet5TtYj7vREivSpPXB3ms+JS
ipyVTbY/0BUO7SI2eQcubhVqI/lTAGezQfqorkzmh4dW1wvk5x+H67sVQXy/y4JI
uib/CvtdJfmFicRK+SUYQSRp0658n5dg4ZF0CEy3TKKnwIjE2q6m+EYQTc5T1Sbz
8HM+2qcgFxJKEIpRH9HPAT1glT7lQw==
=q4Zd
-----END PGP SIGNATURE-----

--Tr27T8kdSRR4zERwKykoDOXRe1InTct6b--
