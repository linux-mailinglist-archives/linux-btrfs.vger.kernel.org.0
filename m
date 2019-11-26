Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8149B1097E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 03:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKZCvx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 21:51:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:48551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKZCvx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 21:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574736612;
        bh=IZGlcWAzopY37dn0OGa0aVHUhtF1bI8GYL4mj5nX1kM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ldpTWakWy2DhYY48jhFvK+am9fW6ZHqdT5ar+B2/VneCDOZaRDS8t0ZAp19317zzC
         1CXlxlcwiGOn/gX3OxcjDi/ePV5kZB7N7c+VXgPQHzNhgGrlZkujkDRz/nU8pZcdua
         ZI9YIb8KHGprdiF2/rGZ6JMx0CW0XgjdSOJ71bjo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1hdbPx2r8Y-00x0G0; Tue, 26
 Nov 2019 03:50:12 +0100
Subject: Re: [PATCH 2/2] btrfs: qgroup: Return -ENOTCONN instead of -EINVAL
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, Marcos Paulo de Souza <mpdesouza@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <20191126005851.11813-1-marcos.souza.org@gmail.com>
 <20191126005851.11813-3-marcos.souza.org@gmail.com>
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
Message-ID: <e0c355ac-6446-9b27-12fc-82e05c9e8212@gmx.com>
Date:   Tue, 26 Nov 2019 10:50:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126005851.11813-3-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rxi7JT67L3O8p9aWRcN3scgVICvfBVYEI"
X-Provags-ID: V03:K1:swRJilVEj+iyhGNliLPhBn8W75JVeggj+5M9zFvK9W/umAtD2Zj
 VdHQJHRTQdoNh7TLsJKM53N2FVV9qILrYIojoKVc148rECiG9uGb5qIktHNpgcH2vIF4X1j
 MOs4fIRE7M49s0KQkzUaEcMbAKg2S6etUJw51hpzsuEkPZ+glqh6uViH82YxNijCcwGdDX3
 W9Nj0zhmg8GJ4PQfDfAmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0MQZ4LSmFYo=:W+lwffKRLjAKEH26+k6JFH
 PYLxohe+ZOuBiCPDAtDF9rzrRwCdQ3PahXiznAWGZo5b//jJ+ungMWd8o0pHAY3bJPIarC9yS
 3w122DTOhD0Sb7fugeDP7ldasu2inF+uoqKyTvghd/IavhCbNsfV2kHvDaArzqOR8rAawwLrT
 +Fp6GTvc7MHuGJFECeqNkDXhUYHZVijikBS31jkanSZqnNOjGPytlHEQvUT8H15Z3WT7Q5Nxm
 PI//dIS1YOUw5OOJ9M/mblupH6QTxGaObyyMNV+CVs1XBZkIAFbyjyGCp/iFG04r+/bJCHNQe
 8hEVU3FLvPOjjohvC6E/CBbDqBNWWRm4Eku1o7FCJMKCJovSpQV7XDpkd8hJvYkgZyX6QAhxM
 oPasHttYMwO4J4xNP0P4eqVLJEPk6EFuPvUulag5Vua2fxgyg5SyAdp1uDZyk9llE6Q/wy/1M
 CoxfKNEhF7NcRLpdTjexLMS5P1Oke6RiXaV2B96tpMjMIjmlKLDiue2Q8ayE4y61wGK+1AEDJ
 scd20zWhXIx8lAv6UwYsHhlxT5whziGdnzPsYFXhccLdLLOnQQeohQhQxCba9fSu/yIlV4/cf
 FvG46lXpHq+RO7o5qD5HLmXYyVluL7TG179cjhEp+mildVRjQ5320wY4JFu4+GT4Q7ik/4muM
 Xpz2UnVKKEGEs0/YX598YlVIyvzE6o0pk1pdnlt+gAFmPKDM1dJPwj7E2uScHh8lH6ynQxj+b
 PXriMy5D5fVi9CXIdq4krY9O1YfeT9ujK8S9Os3bqNWvgqK2xcZa8DKD6Ewfr33Q5+WH4oE7f
 TNJRH74rZLttaEOXbRDgo1MHm60HulAvztpKZCvcAuKdfPuSzl7TmSZNphRftkdhI8+9DaB6A
 9S/Y8BvW7FSce5vBCgM1YNs8dI/2LQyT9UIS2PpLSuNm/TUFFlMdEOnBU6J1pUdC1LoMLOGKR
 auA/z806TwZ4UeCqLQRN8eXKtc3NQ2N4CCGlEQRnHC7k2BRRzg1ZqUjSoJKYMOBGWS6nyEPEU
 CjJ0BimmU3+1SYL3jkFQ7Uw2WCcOW4KawlytoI6jH9XLYK7IGjE/nW1LFgf1SDZTERN+Lh/iA
 FYzr3FHqd3JhLXn0OGhTDBW2ShuidvnY3IKDC1x5DPADvz5jf/OlP/yLCsjoRG1xWe4xHa43x
 ZZe8MHprRmC3CZsdMGjosre7URtVALQEA/xFJRqmn4tGU5LN63eemyTAo6DhCUXZAqZbbZwBY
 4ZQOnoSG7ArOiTo7ImxtfcLoi+CceTRH6Vd63CpcefCd08aADmkbzkMBf4b0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rxi7JT67L3O8p9aWRcN3scgVICvfBVYEI
Content-Type: multipart/mixed; boundary="sk88EurChcutzdNOXDs8TfY1Sv8Udc1zh"

--sk88EurChcutzdNOXDs8TfY1Sv8Udc1zh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/26 =E4=B8=8A=E5=8D=888:58, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> [PROBLEM]
> qgroup create/remove code is currently returning EINVAL when the user
> tries to create a qgroup on a subvolume without quota enabled. EINVAL i=
s
> already being used for too many error scenarios so that is hard to depi=
ct
> what is the problem.
>=20
> [FIX]
> Currently scrub and balance code return -ENOTCONN when the user tries t=
o
> cancel/pause and no scrub or balance is currently running for the desir=
ed
> subvolume. Do the same here by returning -ENOTCONN  when a user
> tries to create/delete/assing/list a qgroup on a subvolume without quot=
a
> enabled.

The generic error string for ENOTCONN is "Transport endpoint is not
connected", not something user can directly know.

So don't forget to modify btrfs-progs to interprete the error number to
"qgroup not enabled" error string.

Despite that, I think it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/qgroup.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 417fafb4b4f6..b046b04d7cce 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1259,7 +1259,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_=
handle *trans, u64 src,
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -EINVAL;
> +		ret =3D -ENOTCONN;
>  		goto out;
>  	}
>  	member =3D find_qgroup_rb(fs_info, src);
> @@ -1318,7 +1318,7 @@ static int __del_qgroup_relation(struct btrfs_tra=
ns_handle *trans, u64 src,
>  		return -ENOMEM;
> =20
>  	if (!fs_info->quota_root) {
> -		ret =3D -EINVAL;
> +		ret =3D -ENOTCONN;
>  		goto out;
>  	}
> =20
> @@ -1384,7 +1384,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -EINVAL;
> +		ret =3D -ENOTCONN;
>  		goto out;
>  	}
>  	quota_root =3D fs_info->quota_root;
> @@ -1418,7 +1418,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle=
 *trans, u64 qgroupid)
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -EINVAL;
> +		ret =3D -ENOTCONN;
>  		goto out;
>  	}
> =20
> @@ -1469,7 +1469,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle =
*trans, u64 qgroupid,
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
>  	if (!fs_info->quota_root) {
> -		ret =3D -EINVAL;
> +		ret =3D -ENOTCONN;
>  		goto out;
>  	}
> =20
>=20


--sk88EurChcutzdNOXDs8TfY1Sv8Udc1zh--

--rxi7JT67L3O8p9aWRcN3scgVICvfBVYEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3ckt0ACgkQwj2R86El
/qgTlwf+KQ6kjSF/4Y2yiY16xTaeo5m4901C/GLFz4ZbVViglte642Zf6GvSg7ei
kyAOWaTMF0dCzY8S7CeE3nAQyQSxRGlLWEB8ji6xInbkYT/joYV4UR+s5+X2RiCr
ZyAXeTro0CSJc3EnALg8JTGnouE0qVxaP/yIYcXg5XC7hHdzpfM9Lplia+dKzV98
jXGY2uA9fzSguI2t97EA2zby5XVuHGijx3SiIV4/LlKWfq3wa+7PysUHJEoSLSvC
uS9S8MY5lL76lH55oDmkUoijLprNQ/9kb80z3aETDi6fX5MS4zdIzTVQ7+InMCns
Pxc3P7JBvZc1u9+fi8MXN3hOla/Kbg==
=PLLN
-----END PGP SIGNATURE-----

--rxi7JT67L3O8p9aWRcN3scgVICvfBVYEI--
