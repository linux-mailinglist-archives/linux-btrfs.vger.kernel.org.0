Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D151CF602
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgELNnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 09:43:08 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44486 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELNnI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 09:43:08 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id CBB736BD83A; Tue, 12 May 2020 09:43:06 -0400 (EDT)
Date:   Tue, 12 May 2020 09:43:06 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Balance loops: what we know so far
Message-ID: <20200512134306.GV10769@hungrycats.org>
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 04:31:32PM +0800, Qu Wenruo wrote:
> Hi Zygo,
>=20
> Would you like to test this diff?
>=20
> Although I haven't find a solid reason yet, there is another report and
> with the help from the reporter, it turns out that balance hangs at
> relocating DATA_RELOC tree block.
>=20
> After some more digging, DATA_RELOC tree doesn't need REF_COW bit at all
> since we can't create snapshot for data reloc tree.
>=20
> By removing the REF_COW bit, we could ensure that data reloc tree always
> get cowed for relocation (just like extent tree), this would hugely
> reduce the complexity for data reloc tree.
>=20
> Not sure if this would help, but it passes my local balance run.

I ran it last night.  It did 30804 loops during a metadata block group
balance, and is now looping on a data block group as I write this.

> Thanks,
> Qu

> From 82f3b96a68561b2de9712262cb652192b8ea9b1b Mon Sep 17 00:00:00 2001
> From: Qu Wenruo <wqu@suse.com>
> Date: Mon, 11 May 2020 16:27:43 +0800
> Subject: [PATCH] btrfs: Remove the REF_COW bit for data reloc tree
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c    | 9 ++++++++-
>  fs/btrfs/inode.c      | 6 ++++--
>  fs/btrfs/relocation.c | 3 ++-
>  3 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 56675d3cd23a..cb90966a8aab 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1418,9 +1418,16 @@ static int btrfs_init_fs_root(struct btrfs_root *r=
oot)
>  	if (ret)
>  		goto fail;
> =20
> -	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
> +	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
> +	    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
>  		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
>  		btrfs_check_and_init_root_item(&root->root_item);
> +	} else if (root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTI=
D) {
> +		/*
> +		 * Data reloc tree won't be snapshotted, thus it's COW only
> +		 * tree, it's needed to set TRACK_DIRTY bit for it.
> +		 */
> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>  	}
> =20
>  	btrfs_init_free_ino_ctl(root);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5d567082f95a..71841535c7ca 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4129,7 +4129,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>  	 * extent just the way it is.
>  	 */
>  	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
> -	    root =3D=3D fs_info->tree_root)
> +	    root =3D=3D fs_info->tree_root ||
> +	    root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)
>  		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
>  					fs_info->sectorsize),
>  					(u64)-1, 0);
> @@ -4334,7 +4335,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
> =20
>  		if (found_extent &&
>  		    (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
> -		     root =3D=3D fs_info->tree_root)) {
> +		     root =3D=3D fs_info->tree_root ||
> +		     root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)) {
>  			struct btrfs_ref ref =3D { 0 };
> =20
>  			bytes_deleted +=3D extent_num_bytes;
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f25deca18a5d..a85dd5d465f6 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1087,7 +1087,8 @@ int replace_file_extents(struct btrfs_trans_handle =
*trans,
>  		 * if we are modifying block in fs tree, wait for readpage
>  		 * to complete and drop the extent cache
>  		 */
> -		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID) {
> +		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
> +		    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
>  			if (first) {
>  				inode =3D find_next_inode(root, key.objectid);
>  				first =3D 0;
> --=20
> 2.26.2
>=20





--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXrqn5QAKCRCB+YsaVrMb
nAZ8AJ9WQlc+4ioPZqed8i1cA4bVcU3V+wCcDJ5vAKzQn4oQ+cuknE9JE4YW+pY=
=mOaH
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
