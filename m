Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D2A1769E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 02:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCCBMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 20:12:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:43181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgCCBMb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 20:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583197945;
        bh=m9WK1Bbqx8o6mElJj6xpaLWcShhvDL5H+zFdsERa3nA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=N6g5GVO91PMqYnOWUlPVgnYT5clZe/wkK+e9+Y+YNgT4ycI3poWzsHQEksBJ9AwhR
         cT21pRX0tP9SUW0JjZEF16yJQ3eQW2/GP8VOizSfONi+jjoq9pBf+r695biXBA12Yx
         wZbeTaT8oPQazHwwl8jOJ4CHv33W2WhBZSJg9d+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmKh-1iovJZ349Z-00K6mo; Tue, 03
 Mar 2020 02:12:25 +0100
Subject: Re: [PATCH 6/7] btrfs: hold a ref on the root->reloc_root
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20200302184757.44176-1-josef@toxicpanda.com>
 <20200302184757.44176-7-josef@toxicpanda.com>
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
Message-ID: <1b3545b5-ab19-6f0d-7dd3-d80fe20a865e@gmx.com>
Date:   Tue, 3 Mar 2020 09:12:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302184757.44176-7-josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DBoqneUcLlIENKIEB6QOnVr2Y6p5sQ4cw"
X-Provags-ID: V03:K1:0uDut/u2YVTIm1l/dGMFaeOpVhqTrY5DF4XacNuspZk3VXgKQWB
 z7AQQOqWlCTjAmffleM7wgVrpxtlI95TsKhgG+OL/gwtrzMTrUGPb1T+dkju2InWe5AFSj9
 mnvp534ZVfU9skxD6NM06YR2OPaLvXlMeCxdPY3736FZ3M0etLB0H0O1IqU+N6CWMwWSDJK
 DfAzKMIvs8iH1mAxWDaVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:257DKAVuT98=:rM0G1uCJaNM+oG+VrDIg+U
 1DHKq59E5O7AmmguWJCMoVj4ICL/05SiOue/H7Wm5zctseWshUzWqv/5veNnlcCUt6Eu6wsHS
 TMby13B+7ujn7f6PjSvAxSN2VmqHsl7HmK+YcQdaOLFf7GhSAzahNOGc9bXvjb2n7syzR9Y80
 JH1cm8srf6sXqX4O29R6W0FmYl8sQwiZXdolTZ2UnyKSn68OF6n8sL8DzZEPObp4iBem81ppo
 l6giTIEMOMyxNON936u6AErGx+qp98MRz+873RzbWeHWMTxm8Fx0eklZHAHHE023g64egRPQh
 XnUH4P0kDg8zwXEy2LrYwWBGd+ngMrIs0Erj8JdVKTBcEEAxUaZeu0M9W+mY6lPzkAX8Plip6
 wujrr59NGJ5b0O9aEchzNBCDX8kp9vVAcMRbV+nApH33stxlgOpWlzT5/6NykIgg3Eo28X3GG
 gWgrzMQ/Yzg2axclIQsu2zQmWpUR+z7oYBFdPS+EEVQPfnhIC9PBdrd7Oy/Qxe0FwOxn/q+q9
 r8FKmDFfKx1nuyLFfXLVKHuVeNJ8tFUy4D8AcVNG0L8lswMnPiFBH4+d2m9Bj+5/u1YI8skZ9
 u3hRcm2JaMxjJjThhP0MAxMJnzlHtNv1vi2yO625NW6icJxv6C/5lWS+0+xGqvbf1s/Z7RGoo
 73QVmuwNDVdsgQ3vk8Yv6AEaUpqlLz4/Mg5O5oWYGhZZ9iAQoDczhN3tlaOfYNR2l4GN7WhFB
 rI8XmxPCUkxPMEXZS/3qx804JprX4cdEc0rkI0A/NvvwYGWPLoztwMO8LUIqBNBoFFLubVPV7
 /oxOvthWsWMBBlIXYP0ShNoeGK3J5lziDtyy5DDfvceo45N/JriAZLFAP1zsAQFxQ8H9GL69P
 z1YBCbq4ILKfRWc4ZCUmbF1OM7l0ScU/BqnXX26YWOwJX3f+5wBtE1m7Oeb+rWyYO7NqxegFz
 Qx895ZpGHQ67Imvw7t45WAXFljr/3ZaUapVuBA3CNeFn74m+42IVm40OjGanLU1I6uwM8y8gk
 LFf+UO8t3A7DPkF5bF0GukZS2SrXMA4XBv1xLpJs1p04mj6ZsnmzkFuZJtz0GgY/lECOjwl0e
 B99zmhpUvN/egCDdGWUOJY96Yk4cNckIUDcQMK0X3s+BqVpqH6fwTs4VMXyv4biqNhiy1CN+c
 Hh8Z5I3xkwq4x7q2tQEkAS4iTNehimMEQqXdbGtB0/bwJ5psL0S5S9J3YJ/5jd2z0xMNXTuaZ
 Qbra/p5ggJbsOUPoZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBoqneUcLlIENKIEB6QOnVr2Y6p5sQ4cw
Content-Type: multipart/mixed; boundary="VD83qaxGGpE41CRHUOoto4boDG8a3CisL"

--VD83qaxGGpE41CRHUOoto4boDG8a3CisL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/3 =E4=B8=8A=E5=8D=882:47, Josef Bacik wrote:
> We previously were relying on root->reloc_root to be cleaned up by the
> drop snapshot, or the error handling.  However if btrfs_drop_snapshot()=

> failed it wouldn't drop the ref for the root.  Also we sort of depend o=
n
> the right thing to happen with moving reloc roots between lists and the=

> fs root they belong to, which makes it hard to figure out who owns the
> reference.
>=20
> Fix this by explicitly holding a reference on the reloc root for
> roo->reloc_root.  This means that we hold two references on reloc roots=
,
> one for whichever reloc_roots list it's attached to, and the
> root->reloc_root we're on.
>=20
> This makes it easier to reason out who owns a reference on the root, an=
d
> when it needs to be dropped.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

A small question inlined below, despite that,

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>  fs/btrfs/relocation.c | 44 ++++++++++++++++++++++++++++++++-----------=

>  1 file changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index acd21c156378..c8ff28930677 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1384,6 +1384,7 @@ static void __del_reloc_root(struct btrfs_root *r=
oot)
>  	struct rb_node *rb_node;
>  	struct mapping_node *node =3D NULL;
>  	struct reloc_control *rc =3D fs_info->reloc_ctl;
> +	bool put_ref =3D false;
> =20
>  	if (rc && root->node) {
>  		spin_lock(&rc->reloc_root_tree.lock);
> @@ -1400,8 +1401,13 @@ static void __del_reloc_root(struct btrfs_root *=
root)
>  	}
> =20
>  	spin_lock(&fs_info->trans_lock);
> -	list_del_init(&root->root_list);
> +	if (!list_empty(&root->root_list)) {

Can we make the ref of reloc root completely free from the list operation=
?
It still looks like a compromise between fully ref counted reloc root
and original non-ref counted one.

Thanks,
Qu

> +		put_ref =3D true;
> +		list_del_init(&root->root_list);
> +	}
>  	spin_unlock(&fs_info->trans_lock);
> +	if (put_ref)
> +		btrfs_put_root(root);
>  	kfree(node);
>  }
> =20
> @@ -1555,7 +1561,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_hand=
le *trans,
> =20
>  	ret =3D __add_reloc_root(reloc_root);
>  	BUG_ON(ret < 0);
> -	root->reloc_root =3D reloc_root;
> +	root->reloc_root =3D btrfs_grab_root(reloc_root);
>  	return 0;
>  }
> =20
> @@ -1576,6 +1582,13 @@ int btrfs_update_reloc_root(struct btrfs_trans_h=
andle *trans,
>  	reloc_root =3D root->reloc_root;
>  	root_item =3D &reloc_root->root_item;
> =20
> +	/*
> +	 * We are probably ok here, but __del_reloc_root() will drop its ref =
of
> +	 * the root.  We have the ref fro root->reloc_root, but just in case

s/fro/for/

> +	 * hold it while we update the reloc root.
> +	 */
> +	btrfs_grab_root(reloc_root);
> +
>  	/* root->reloc_root will stay until current relocation finished */
>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>  	    btrfs_root_refs(root_item) =3D=3D 0) {
> @@ -1597,7 +1610,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_ha=
ndle *trans,
>  	ret =3D btrfs_update_root(trans, fs_info->tree_root,
>  				&reloc_root->root_key, root_item);
>  	BUG_ON(ret);
> -
> +	btrfs_put_root(reloc_root);
>  out:
>  	return 0;
>  }
> @@ -2297,19 +2310,28 @@ static int clean_dirty_subvols(struct reloc_con=
trol *rc)
>  			 */
>  			smp_wmb();
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
> -
>  			if (reloc_root) {
> -
> +				/*
> +				 * btrfs_drop_snapshot drops our ref we hold for
> +				 * ->reloc_root.  If it fails however we must
> +				 * drop the ref ourselves.
> +				 */
>  				ret2 =3D btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
> -				if (ret2 < 0 && !ret)
> -					ret =3D ret2;
> +				if (ret2 < 0) {
> +					btrfs_put_root(reloc_root);
> +					if (!ret)
> +						ret =3D ret2;
> +				}
>  			}
>  			btrfs_put_root(root);
>  		} else {
>  			/* Orphan reloc tree, just clean it up */
>  			ret2 =3D btrfs_drop_snapshot(root, NULL, 0, 1);
> -			if (ret2 < 0 && !ret)
> -				ret =3D ret2;
> +			if (ret2 < 0) {
> +				btrfs_put_root(root);
> +				if (!ret)
> +					ret =3D ret2;
> +			}
>  		}
>  	}
>  	return ret;
> @@ -4687,7 +4709,7 @@ int btrfs_recover_relocation(struct btrfs_root *r=
oot)
> =20
>  		err =3D __add_reloc_root(reloc_root);
>  		BUG_ON(err < 0); /* -ENOMEM or logic error */
> -		fs_root->reloc_root =3D reloc_root;
> +		fs_root->reloc_root =3D btrfs_grab_root(reloc_root);
>  		btrfs_put_root(fs_root);
>  	}
> =20
> @@ -4912,7 +4934,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_=
handle *trans,
> =20
>  	ret =3D __add_reloc_root(reloc_root);
>  	BUG_ON(ret < 0);
> -	new_root->reloc_root =3D reloc_root;
> +	new_root->reloc_root =3D btrfs_grab_root(reloc_root);
> =20
>  	if (rc->create_reloc_tree)
>  		ret =3D clone_backref_node(trans, rc, root, reloc_root);
>=20


--VD83qaxGGpE41CRHUOoto4boDG8a3CisL--

--DBoqneUcLlIENKIEB6QOnVr2Y6p5sQ4cw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5drvUACgkQwj2R86El
/qjHKgf/QYX66GrrnmM7IxQ4N4cPS0mOf9ezYid33bE8jpsd3/FbpfeubJ7UbwLN
PErNCMFKcJyLi7s/0fburJKxXREIGFk+V6tRxu2udZfyp9vAEchU9C8G+CyJH6md
wSS+cjA7WNP8Zm/P9Ki5/ZwSk3sPgh+AI7R+F3XFMAORBjQPUwhG2hnpqilQ4JCt
PleXwT40mxzpmW99PMGjeXWKc5S6M/OjWhpuzPSRCUSh7tlBeu7LEuUzMRKcqd73
xl2iHNGqM2+QDRrqbVim03BURy2HTs3w3htYTquuKVFHHNUqHs0vXSSENevJyRsJ
39rPoQKvPDXQwOFuMEl3DEYA3i8EVQ==
=FxLg
-----END PGP SIGNATURE-----

--DBoqneUcLlIENKIEB6QOnVr2Y6p5sQ4cw--
