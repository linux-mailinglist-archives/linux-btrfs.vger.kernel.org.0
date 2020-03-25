Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA4191EBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 02:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgCYB46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 21:56:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:47341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbgCYB46 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 21:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585101398;
        bh=3q4Skcp1uuejpP4vLIlXa8IwxSa7x3xfyurREyB1ViE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B9O5/sqYXHsFv2c3siEwlDSQL4BI6Eqn8yd0cg3vI78vt4OJaKM6SRLKs6JofJdM7
         gqMJiDltL0nfgZow474+3TB10YiSxIw1SJaTou+MqOMcLIJ98nHeQ9lMDxWZP341Q6
         PKu3Dwq14px0WpcJvngyA8KyOtAsrQf8C5KZ/1gM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1ipjMe3kz7-00TyZ5; Wed, 25
 Mar 2020 02:56:38 +0100
Subject: Re: [PATCH RFC] btrfs: send: Emit all xattr of an inode if the
 uid/gid changed
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200325015251.28838-1-marcos@mpdesouza.com>
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
Message-ID: <598cd0e6-a49b-7ca1-623e-991567c4259e@gmx.com>
Date:   Wed, 25 Mar 2020 09:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325015251.28838-1-marcos@mpdesouza.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wkeq1ERD1MivdJoP8a0d2G1w1qXVlyTP1"
X-Provags-ID: V03:K1:A/h6dz2QqHvKdX6b/ySEZXtwXVcjvfQjIhO2ZXN2EoGtOSAoFjW
 sN36w6IzSV9vpj6ejzL1eVgVMTGUKP1i+nWC5mSl/HpcrwOf8LPgPf82raU28zZajvIpGYb
 dCTJicO75J0GJQSl5eZsZDyTR2X5DhvUQAsnsC9lxhed0xQbJnEkMH/hoQqNODLgRq5UBry
 m5lgqGrUv6rIHCOQrWzAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vGjwX4kTjQo=:qP8GdFLswxMpV/tlfSE5Gi
 mfHIXMgeWWHrNGNYaJIu5Q2LoFrYYAMbEYGMDSwji4WFoZ651esTsBpdfD2oMwlgEakNX+fsO
 KUoaaXHwQusObWz6ez67a5RV7IAun6myq3n8WfZ2DolTp7E+YMw1bSqytqnBAd6UX2sN1Lh9F
 XUVGOZZM5bpm3NPCN8q8gVxvEbaCcSkDDBaSaVKuuL9fADMgj1YLuWYMeAseh2Ju1rq2N+gvt
 EjcvAy4bIjB6yIIIM/iz/XdJItYqN+J7EobNFGLZJ5WlucEnwST91Stifi03vG9Z646iyp/zY
 HiTskZGslse8bDMgspNhAGMHpTGtyaVvG/ZCHncdjetZq1slVkQSkpISCO90QvSLJv4YStqJ0
 5ZBRrtClUyEHWR7PGHJNmMML1Pv5JcYbfy/c/rHgYM2fFeENT6Ho2dUM8HTAxEO6eUcDJKzYw
 1zNU40C89QzY2ox84WQFHh8/Udi/JKolex+xj8OI84vqjzcaJSH2KbX4C1ac3AuuUbLFeHsaM
 DrKspjc0T13SynL68huw9a/zhNc/Bqy8oftZJ9yrxg/ZlWFoIAckokBZxeI/rcrWO6PhlXoeq
 0oKvRU46eFl2latCG1EqSK2fbGr/TrT0ZGRI0emz5AAoz9VzV9WfVW82727z5HKCuhoR2JmT+
 xgZSlmgqet6EKwolj0HF5j5hqxRJ84w9tcnzFhDCn4pFry2qjepzdERBZ27W6isz9Y4BIDdSs
 feMGfQudl/ZdGKaC6pWBGpPlsgbqxpUU+t1hHZMWlK2jDfpj5obfBk1mKFJjLeyLl30uaChRc
 nWtq8w4QNNtQdtCa8VF+RMx9WfwnQqPlPzhe0tbwo5WqArgHj2rhnuNAtPPd9fYKyoO5Zic+f
 eeTBwZwWfk751wq5lOGYsp9CXduRtVjP85QwTNmpMXld38IwDpJZtF3yLm2AN+08nvOFgV/bO
 SUt67/58mzYnMEYlOc0YRsMWmXT8GXEHmiDrpNJb8i8Wt40V/Nx0AmNcde94SlSf7OnIaVGY8
 Q0K2KB0N+W3DS6psw3XhACl8Atf2nZTYE9X8sEaoQlTQvyBMEIplLNIBxkt40d73Hbl1EoIUM
 3mz66eLDcI5CMxAT8IMlCD05Y/l3gySNrvUnqW3Kx1YM+p0A4Sx9bz5TZ/VRS+8tK519ovAJC
 omRgPpubI0SCSa+IkTLQkVMy8fB5tdq9JTIMB5jwhBd7J7ZjU7ohSMCViTkVWZlEkTojkiEAC
 sgaIWV6pqR82zK33q
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wkeq1ERD1MivdJoP8a0d2G1w1qXVlyTP1
Content-Type: multipart/mixed; boundary="4lt6ZXygdyUm9YCPlsflmw8zRrsUcsdYV"

--4lt6ZXygdyUm9YCPlsflmw8zRrsUcsdYV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/25 =E4=B8=8A=E5=8D=889:52, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> [PROBLEM]
> When doing incremental send with a file with capabilities, there is a
> situation where the capability can be lost in the receiving side. The
> sequence of actions bellow show the problem:
>=20
> $ mount /dev/sda fs1
> $ mount /dev/sdb fs2
>=20
> $ touch fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
> $ btrfs subvol snap -r fs1 fs1/snap_init
> $ btrfs send fs1/snap_init | btrfs receive fs2
>=20
> $ chgrp adm fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
>=20
> $ btrfs subvol snap -r fs1 fs1/snap_complete
> $ btrfs subvol snap -r fs1 fs1/snap_incremental
>=20
> $ btrfs send fs1/snap_complete | btrfs receive fs2
> $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2
>=20
> At this point fs/snap_increment/foo.bar lost the capability, since a
> chgrp was emitted by "btrfs send". The current code only checks for the=

> items that changed, and as the XATTR kept the value only the chgrp chan=
ge
> is emitted.
>=20
> [FIX]
> In order to fix this issue, check if the uid/gid of the inode change,
> and if yes, emit all XATTR again, including the capability.
>=20
> Fixes: https://github.com/kdave/btrfs-progs/issues/202
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  I'm posting this patch as a RFC because I had some questions
>  * Is this the correct place to fix?
>  * Also, emitting all XATTR of the inode seems overkill...
>  * Should it be fixed in userspace?

+1 for fixing it in userspace.

To me, although not an expert in send, the send stream looks more like a
diff between two subvolumes, other than instructions to rebuild a subvolu=
me.

So in above case, since the XATTR is not changed, not sending the XATTR
is OK.
Thus it's the receiver side to workaround the missing XATTR.

And it shouldn't be that complex for user space to backup the XATTR, and
restore it after gid/uid change.

Although the main chanllege is how to distinguish plain uid/gid change
(with XATTR dropped) and uid/gid change with XATTR restored.

Thanks,
Qu

>=20
>  fs/btrfs/send.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index c5f41bd86765..5cffe5da91cf 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6187,6 +6187,14 @@ static int changed_inode(struct send_ctx *sctx,
>  		sctx->cur_inode_mode =3D btrfs_inode_mode(
>  				sctx->right_path->nodes[0], right_ii);
>  	} else if (result =3D=3D BTRFS_COMPARE_TREE_CHANGED) {
> +		u64 left_uid =3D btrfs_inode_uid(sctx->left_path->nodes[0],
> +					left_ii);
> +		u64 left_gid =3D btrfs_inode_gid(sctx->left_path->nodes[0],
> +					left_ii);
> +		u64 right_uid =3D btrfs_inode_uid(sctx->right_path->nodes[0],
> +					right_ii);
> +		u64 right_gid =3D btrfs_inode_gid(sctx->right_path->nodes[0],
> +					right_ii);
>  		/*
>  		 * We need to do some special handling in case the inode was
>  		 * reported as changed with a changed generation number. This
> @@ -6236,15 +6244,12 @@ static int changed_inode(struct send_ctx *sctx,=

>  			sctx->send_progress =3D sctx->cur_ino + 1;
> =20
>  			/*
> -			 * Now process all extents and xattrs of the inode as if
> +			 * Now process all extents of the inode as if
>  			 * they were all new.
>  			 */
>  			ret =3D process_all_extents(sctx);
>  			if (ret < 0)
>  				goto out;
> -			ret =3D process_all_new_xattrs(sctx);
> -			if (ret < 0)
> -				goto out;
>  		} else {
>  			sctx->cur_inode_gen =3D left_gen;
>  			sctx->cur_inode_new =3D 0;
> @@ -6255,6 +6260,22 @@ static int changed_inode(struct send_ctx *sctx,
>  			sctx->cur_inode_mode =3D btrfs_inode_mode(
>  					sctx->left_path->nodes[0], left_ii);
>  		}
> +
> +		/*
> +		 * Process all XATTR of the inode if the generation or owner
> +		 * changed.
> +		 *
> +		 * If the inode changed it's uid/gid, but kept a
> +		 * security.capability xattr, only the uid/gid will be emitted,
> +		 * causing the related xattr to deleted. For this reason always
> +		 * emit the XATTR when an inode has changed.
> +		 */
> +		if (sctx->cur_inode_new_gen || left_uid !=3D right_uid ||
> +		    left_gid !=3D right_gid) {
> +			ret =3D process_all_new_xattrs(sctx);
> +			if (ret < 0)
> +				goto out;
> +		}
>  	}
> =20
>  out:
>=20


--4lt6ZXygdyUm9YCPlsflmw8zRrsUcsdYV--

--wkeq1ERD1MivdJoP8a0d2G1w1qXVlyTP1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl56ulEACgkQwj2R86El
/qjSBgf/ZerpWWN+pSWVPdS3z+IU2VB6ondy6RXaCZzq4pN/Vnqtgnd/cIZWHrxV
6J1Pq4QRu/VCyN6vZJ5RAXkQSmNfHXP7A69da6j+JiR9YfwmclWhpAWbnanfUzzp
IHWivw2TELfbt68dFYrSWF/myAm/C9qJyxskq7e4TdllluHnMH7mjSIPOa2Zc6u6
fvVEdlY2Oq5DGfiiS+F6mKPw9SOAy/udud89HWmR6QAUKJm18rJ4exfKMKXEqrBH
CAgCsDY86jKHbZ8GAo2Qr4NBmfZtiIg5zyJTsssaFErcG9Fb6q2qMt/vDC3EMSeM
gfo1oCeXzdf9T/wn74FF9aTgFV0Zaw==
=MDLm
-----END PGP SIGNATURE-----

--wkeq1ERD1MivdJoP8a0d2G1w1qXVlyTP1--
