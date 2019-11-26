Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529031097E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 03:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKZCwD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 21:52:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:34875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKZCwC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 21:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574736427;
        bh=OfGDh7HVqjFgXd8CPkxmpBBq9tRQEopgwiYxtTmxf6E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KCXoI4SJG527oIJD48qwwoQUHO/c8Lqrx/xQ4+G1mrOu0ewp+8wU6x0AXze0lNp3N
         IPI2Dxdv+S7lxq/MkSVe47lqvQsdc7k8PA1J6q7pips3vNzjFQ3g6n/rstbFCB9OfC
         ZWBRFfjM4l/fQ0r717MGz5NKrhIbYyveLzBq7lIo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1i8Nqu3cfu-00jnzV; Tue, 26
 Nov 2019 03:47:07 +0100
Subject: Re: [PATCH 1/2] btrfs: qgroup: Cleanup quota_root checks
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, Marcos Paulo de Souza <mpdesouza@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <20191126005851.11813-1-marcos.souza.org@gmail.com>
 <20191126005851.11813-2-marcos.souza.org@gmail.com>
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
Message-ID: <2644e882-5ca1-0fa8-7dde-1edd64f8243d@gmx.com>
Date:   Tue, 26 Nov 2019 10:47:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191126005851.11813-2-marcos.souza.org@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xKebnEOD3xxEA9lRQraAfLXYN09tOT3fZ"
X-Provags-ID: V03:K1:RGwQ/WxCUwSd1+kHbxwxdl5laAyn2HbCqTjN4LafYwXG2FpA4fD
 yutiolg9/nXkMr1ncCJrchjzadzlC3vecHmPW+KXXsKkDzMfpPsVUiFvZErAnbuO3aJZm1H
 4zKbm0uTa3J+kaPhCELxCln5SdCYgxTdX6mz2dmS+e8lGNHOWymDoc70K8DBM4Wu39AbGiF
 h4U0NzC6933m4hoIrP8Tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBDeK099vww=:QEf9sdtAXy1lA/kzZdueBo
 dhe4QF1lQPCh6LljzVIdLMX0G10XMlS+Sw9KsynWgESGWUkP+9jNhhqSoXsJahNn7YnJCX0MG
 Lw1zJvZ04XSJ9Y0o+YsoLhgxfeJP/W9u3WFdRdO4/tLFfQI+nsB7lCcHV6Sjx520PKnNqrgd2
 ig1U+o9T2x7V9/sr4hjYtAwTyEs0E5jj1eoiMRpJQB6tslQffcWxT+iSjA4T6EjQFdj+vFrTy
 vG4aTK4+xJ1YgSylMkbCP4p1sg2q1WYD188xqLRAJRebwMHxrp5G7UrkBoDJjsz1GpxwRstbr
 A8id0He/21TiCsxwQ9G1fS5IH7oX3M5lnXzQksqg3iQhmHp4UP7B3BJ1h6hTEit+5SYhyVa2H
 /RxHQ2IVA7DXavciMSbKZnWL513PTmF0Wdd3zN/qsmFzOfniEuKledVE2KLScJQ+RfKu5ZFHM
 snZguWE/eU/VGr2tfkkogV4CYYC1SIJ+hG6VF0aKtciNx2DfeWP3UvAfimITWKZNjk01EdvT2
 UOAThcCGBWYzPMh79txZ8vNPmGIF3/1eRCeCMX1BRd3qr4vLYWcD6xTWvGEYK4+sGJiEI3Y8F
 aiaLZBFss8UERpUCGURaUhozWqm6LXCwTZq0AOdZj/hRevuxuWD1Ki4VtSTQn6Bo99BAk8aSL
 /G5T6CUHtdfEq/atKLKb5oo+9kWDu1fgWFqs1FjWLzGqOTZBcJNmdC4GOWnVl2q1hkM7wdPi9
 +Llxb1PNYPaOEo3t9N9MNa+wtjDi24qrqo7QahveDshKOJ4fIqdnGnBuPI1EZIIIcrFBGh7+z
 KPsTmgPDx4dC0V1ZEBzoTrwStXrM7rFslkHBNvVRHuszXqISJ7gCoAN9zOdS5fnfgmOH4kAoi
 OMubSmCX4E4Fg5+16FiH2iUbXLlKlsYF3m7WVCqgI22kyLP6EvhNN7Yah/NbVysh7rsy7poMR
 M10045XhlhxXtVBnLw4Dl9z0z0sJGSucRxxpZldmuenANK1Qn/fic9AW17p+bP1/Lb/ZTs+oV
 LMC1kc1ObwPhNmPGf5z7JShoEq7ztVAfbnPdAofaU6SfPmt9EWIHfKzCxlsk/ZiF6gOt3fAxR
 MC5PH7K2Zl5U7dCKo8FMceNM6USQWuK213wRZm76ewr/itPJkpn+MQc/gfLk7lCN3wqxWxK40
 /rQT1ffH4wFRSJWuuAnnb2KJgj7qwhA6rggoIi5ZrkbEuYRJ9h1+dUImNwvrLGR6ipWOOiMdV
 vs84stcXsTExpHAo4Er4v1beUXHmkb5C9DqMb3xeDGor44/esk6f5pHLAGkc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xKebnEOD3xxEA9lRQraAfLXYN09tOT3fZ
Content-Type: multipart/mixed; boundary="5zfscdzPYDemRP0Q6Y2h2F6Isb6tFYid3"

--5zfscdzPYDemRP0Q6Y2h2F6Isb6tFYid3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/26 =E4=B8=8A=E5=8D=888:58, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Remove some variables that are set only to be checked later, and never
> used.

Indeed.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/qgroup.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index d4282e12f2a6..417fafb4b4f6 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1243,7 +1243,6 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_=
handle *trans, u64 src,
>  			      u64 dst)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *parent;
>  	struct btrfs_qgroup *member;
>  	struct btrfs_qgroup_list *list;
> @@ -1259,8 +1258,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_=
handle *trans, u64 src,
>  		return -ENOMEM;
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root) {
> +	if (!fs_info->quota_root) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> @@ -1307,7 +1305,6 @@ static int __del_qgroup_relation(struct btrfs_tra=
ns_handle *trans, u64 src,
>  				 u64 dst)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *parent;
>  	struct btrfs_qgroup *member;
>  	struct btrfs_qgroup_list *list;
> @@ -1320,8 +1317,7 @@ static int __del_qgroup_relation(struct btrfs_tra=
ns_handle *trans, u64 src,
>  	if (!tmp)
>  		return -ENOMEM;
> =20
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root) {
> +	if (!fs_info->quota_root) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> @@ -1387,11 +1383,11 @@ int btrfs_create_qgroup(struct btrfs_trans_hand=
le *trans, u64 qgroupid)
>  	int ret =3D 0;
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root) {
> +	if (!fs_info->quota_root) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> +	quota_root =3D fs_info->quota_root;
>  	qgroup =3D find_qgroup_rb(fs_info, qgroupid);
>  	if (qgroup) {
>  		ret =3D -EEXIST;
> @@ -1416,14 +1412,12 @@ int btrfs_create_qgroup(struct btrfs_trans_hand=
le *trans, u64 qgroupid)
>  int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid=
)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *qgroup;
>  	struct btrfs_qgroup_list *list;
>  	int ret =3D 0;
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root) {
> +	if (!fs_info->quota_root) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> @@ -1465,7 +1459,6 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle =
*trans, u64 qgroupid,
>  		       struct btrfs_qgroup_limit *limit)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *qgroup;
>  	int ret =3D 0;
>  	/* Sometimes we would want to clear the limit on this qgroup.
> @@ -1475,8 +1468,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle =
*trans, u64 qgroupid,
>  	const u64 CLEAR_VALUE =3D -1;
> =20
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root) {
> +	if (!fs_info->quota_root) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> @@ -2578,10 +2570,9 @@ int btrfs_qgroup_account_extents(struct btrfs_tr=
ans_handle *trans)
>  int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *quota_root =3D fs_info->quota_root;
>  	int ret =3D 0;
> =20
> -	if (!quota_root)
> +	if (!fs_info->quota_root)
>  		return ret;
> =20
>  	spin_lock(&fs_info->qgroup_lock);
> @@ -2875,7 +2866,6 @@ static bool qgroup_check_limits(struct btrfs_fs_i=
nfo *fs_info,
>  static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool=
 enforce,
>  			  enum btrfs_qgroup_rsv_type type)
>  {
> -	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *qgroup;
>  	struct btrfs_fs_info *fs_info =3D root->fs_info;
>  	u64 ref_root =3D root->root_key.objectid;
> @@ -2894,8 +2884,7 @@ static int qgroup_reserve(struct btrfs_root *root=
, u64 num_bytes, bool enforce,
>  		enforce =3D false;
> =20
>  	spin_lock(&fs_info->qgroup_lock);
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root)
> +	if (!fs_info->quota_root)
>  		goto out;
> =20
>  	qgroup =3D find_qgroup_rb(fs_info, ref_root);
> @@ -2962,7 +2951,6 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_in=
fo *fs_info,
>  			       u64 ref_root, u64 num_bytes,
>  			       enum btrfs_qgroup_rsv_type type)
>  {
> -	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *qgroup;
>  	struct ulist_node *unode;
>  	struct ulist_iterator uiter;
> @@ -2980,8 +2968,7 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_in=
fo *fs_info,
>  	}
>  	spin_lock(&fs_info->qgroup_lock);
> =20
> -	quota_root =3D fs_info->quota_root;
> -	if (!quota_root)
> +	if (!fs_info->quota_root)
>  		goto out;
> =20
>  	qgroup =3D find_qgroup_rb(fs_info, ref_root);
> @@ -3681,7 +3668,6 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *=
root, int num_bytes,
>  static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref=
_root,
>  				int num_bytes)
>  {
> -	struct btrfs_root *quota_root =3D fs_info->quota_root;
>  	struct btrfs_qgroup *qgroup;
>  	struct ulist_node *unode;
>  	struct ulist_iterator uiter;
> @@ -3689,7 +3675,7 @@ static void qgroup_convert_meta(struct btrfs_fs_i=
nfo *fs_info, u64 ref_root,
> =20
>  	if (num_bytes =3D=3D 0)
>  		return;
> -	if (!quota_root)
> +	if (!fs_info->quota_root)
>  		return;
> =20
>  	spin_lock(&fs_info->qgroup_lock);
>=20


--5zfscdzPYDemRP0Q6Y2h2F6Isb6tFYid3--

--xKebnEOD3xxEA9lRQraAfLXYN09tOT3fZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3ckiUACgkQwj2R86El
/qg0JAf/VYCk2/6KH6DHv2K2nuDXxpKUBvJsqRWB9ARob7yZ4WGYqYiZHOsdXRml
5NsVFpaGDpQrZ082IsDbn3VS3RrJdGkOE3m+vs+U+3gjE84aGcK0dZ70veGpKQ5S
rukEgePWUhxZ+VTfbIelV7v/FE6jsS+giJBbhlSpiRwl0SgXFV3hb4STfAOX6w0F
K/j7aeiL3w5FrAsQfzrYeco8m46awBGgb4AmaGtaUVe12zNoUJ/OVfktBnr7zTST
178schItJYB8wIQVGmmBC5UYSGuzCzSm1kybU4bXIHIP6E2EJ639DVf1oP7yctRs
r9fHuIvcUIspSl7frQRCfoN5PGvuvA==
=Z4IN
-----END PGP SIGNATURE-----

--xKebnEOD3xxEA9lRQraAfLXYN09tOT3fZ--
