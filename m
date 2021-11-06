Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51111446B8E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 01:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhKFA0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 20:26:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:44025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhKFA0h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 20:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636158231;
        bh=yqXhMo4oE6nO6uamOZ3/aRpbKalBN1wsgaTvoj+4M+c=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=A2GDJLp6trk6qKCGExQ5C0XIX2KgTiIhQXPyfZ0iPi3iSaXi2fH/TQsBgNJx61pSX
         KdoN/wG0tF+0VdAxGeRvKZbqikXCii5Gyqd+bjIpzDB1EYsxFmtIWluEkVAazXixXo
         1lvvv1k6w5ZqneP9k8pbsZXydDG1edvNsmV5Eg3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1mNt6p1HQr-00qC4Q; Sat, 06
 Nov 2021 01:23:51 +0100
Message-ID: <8a4a9842-fbc4-f652-d4ca-842ff63b571f@gmx.com>
Date:   Sat, 6 Nov 2021 08:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 07/20] btrfs-progs: stop accessing ->csum_root directly
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <9785c0745f91699cb45ab398d6a32b44645ace39.1636143924.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9785c0745f91699cb45ab398d6a32b44645ace39.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oLfxJqclcPxLbiMtz8yrwxTRJrVQ6T2AJK8OaDz6NWeUfx3O2R4
 qto/VSQxeICfhtNRJCLa1iK5vUo2uXU8OE0s+KbpsKoaWk2Gn3N7ROpreCfwVwqyCfpEJgE
 ZbwAjsfCMhDd/05afuwx0ksopPWSNS+tUsSofq43a1iJtlzRDa/rursLv9My/TdNA7FW0Xv
 C5iMzgoIUJOsuGciJl6Vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Iy5dvu1HNY=:Git69LHI90hWaf2+sfhr4K
 e/v4g4/0JQi0kgFYHzMz4Ws02IKObD6+mrkWFKutSvhJSUXG0srC1AY3L1JcisvPayVVa0Cn6
 y6NFHRjrtcLRzXGvwYQCnMw3U0ucXq2bPDf5f5Ncy7HKtEyLDHPh2T/WqtsGrSJ+v4Qf3Xoqv
 bRLHqvQrfV57HyTW5TGgePlGovAlR1rArZiOnp5rZB0v8L9OtqplFfbIupu2WQtElmvo3fsQc
 TKeeF5x4q4iEKPmk86eNRgP8KJcUiXFMgvYcu3MhCmNP1CCtIIxDYTNs6nGC3Vt5U+CtDurnP
 Idh0jY2wTWIUrc9Ey8WabgTk/u0lruS5ZguQ0T5VFgV2ZpBwmyvYOeqmDg11/1/+iIKPBHPDS
 lU4uuN2q0U3M2GqL9vStxatvlF3YOvFDwjeJdQmGoDUFMq8l1N7OSIdhDkK78iIsvIaGN8Mt2
 euem0ErZjJxHAMQ2SWkClNJGO3USMIkPkc9j5vV4tQL1y6jgc06q8slCB4Q9JYB/tAwfSC80U
 0xNBAzqzQsscJq3gX0kpijVwFPiSdJprsoYWY8c4jvV11aNbo1MyMWQDroVpA95iwdp3sudFr
 sk1SDdmZItDueguvAohOvqtsYbmy3DzMlLmynEuBuTKPl0nkeW3+RnkhltvI4wYJ1sbeh7oKV
 h7X8MVGJFCLxi4Y6xuLjJy0DfnfzOCNu6K/RWNcWsn0R58OcWlf8vWns4FGeUbZ8XjPPAHdeb
 VJsvVvv9fAwFs6/GSmswQOAJXAo1TFQDSxLg4RcZHvJGCdjTtnF4lwkkVlapqyApnSI/aLe9U
 qbrhHOhV/aJuXvqzK0XY2vcPru0n+oQy8/wAVuq/v0jZ8PRKfLqI+2/QYn3MXlPe9uSNrcpSa
 fguhCsf93sngO5EUyTFnP3aHjZgTrQlg0N+3j8VO5qXymVGQifhaoC4ZMckWLsCc/UDuysB0E
 DOtz2eqPpm+khlDIOIsnplC+ArXQTOnGFx5GonawahsgKKtLB2oWE8jc39uLJPPDag0W2YPjc
 JwDgjhVnQ+juxwAdyXIp8040nilH7EmZWd3Bp0/biNGkmw/6TKARgfAtdhXsANSm6HoNm0P52
 UMZFIQwFBbXBpk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:28, Josef Bacik wrote:
> With extent tree v2 we will have per-block group checksums,

I guess you mean per block group checksum tree?

> so add a
> helper to access the csum root and rename the fs_info csum_root to
> _csum_root to catch all the places that are accessing it directly.
> Convert everybody to use the helper except for internal things.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Currently a lot of locations are still passing 0 to btrfs_csum_root(),
which would need to be converted later.

Thus it doesn't look correct to be in the preparation patchset.

Mind to move this patch into the real extent-tree-v2 patchset?

Thanks,
Qu

> ---
>   btrfs-corrupt-block.c       |  2 +-
>   check/main.c                | 15 ++++++++++-----
>   check/mode-common.c         |  6 +++---
>   cmds/rescue-chunk-recover.c | 17 ++++++++---------
>   kernel-shared/ctree.h       |  2 +-
>   kernel-shared/disk-io.c     | 28 +++++++++++++++++-----------
>   kernel-shared/disk-io.h     |  2 +-
>   kernel-shared/file-item.c   |  4 ++--
>   mkfs/main.c                 |  3 ++-
>   9 files changed, 45 insertions(+), 34 deletions(-)
>
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index c1624ee1..d7904b6f 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -1031,7 +1031,7 @@ static int delete_csum(struct btrfs_root *root, u6=
4 bytenr, u64 bytes)
>   	struct btrfs_trans_handle *trans;
>   	int ret;
>
> -	root =3D root->fs_info->csum_root;
> +	root =3D btrfs_csum_root(root->fs_info, bytenr);
>   	trans =3D btrfs_start_transaction(root, 1);
>   	if (IS_ERR(trans)) {
>   		fprintf(stderr, "Couldn't start transaction %ld\n",
> diff --git a/check/main.c b/check/main.c
> index 22306cf4..632dfba0 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5988,7 +5988,7 @@ static int check_csums(struct btrfs_root *root)
>   	unsigned long leaf_offset;
>   	bool verify_csum =3D !!check_data_csum;
>
> -	root =3D gfs_info->csum_root;
> +	root =3D btrfs_csum_root(gfs_info, 0);
>   	if (!extent_buffer_uptodate(root->node)) {
>   		fprintf(stderr, "No valid csum tree found\n");
>   		return -ENOENT;
> @@ -9496,7 +9496,7 @@ static int populate_csum(struct btrfs_trans_handle=
 *trans,
>   static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *=
trans,
>   					   struct btrfs_root *cur_root)
>   {
> -	struct btrfs_root *csum_root =3D gfs_info->csum_root;
> +	struct btrfs_root *csum_root;
>   	struct btrfs_path path;
>   	struct btrfs_key key;
>   	struct extent_buffer *node;
> @@ -9532,6 +9532,7 @@ static int fill_csum_tree_from_one_fs_root(struct =
btrfs_trans_handle *trans,
>   		start =3D btrfs_file_extent_disk_bytenr(node, fi);
>   		len =3D btrfs_file_extent_disk_num_bytes(node, fi);
>
> +		csum_root =3D btrfs_csum_root(gfs_info, start);
>   		ret =3D populate_csum(trans, csum_root, buf, start, len);
>   		if (ret =3D=3D -EEXIST)
>   			ret =3D 0;
> @@ -9618,7 +9619,7 @@ out:
>   static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans=
)
>   {
>   	struct btrfs_root *extent_root =3D gfs_info->extent_root;
> -	struct btrfs_root *csum_root =3D gfs_info->csum_root;
> +	struct btrfs_root *csum_root;
>   	struct btrfs_path path;
>   	struct btrfs_extent_item *ei;
>   	struct extent_buffer *leaf;
> @@ -9668,6 +9669,7 @@ static int fill_csum_tree_from_extent(struct btrfs=
_trans_handle *trans)
>   			continue;
>   		}
>
> +		csum_root =3D btrfs_csum_root(gfs_info, key.objectid);
>   		ret =3D populate_csum(trans, csum_root, buf, key.objectid,
>   				    key.offset);
>   		if (ret)
> @@ -10688,7 +10690,8 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>
>   		if (init_csum_tree) {
>   			printf("Reinitialize checksum tree\n");
> -			ret =3D btrfs_fsck_reinit_root(trans, gfs_info->csum_root);
> +			ret =3D btrfs_fsck_reinit_root(trans,
> +						btrfs_csum_root(gfs_info, 0));
>   			if (ret) {
>   				error("checksum tree initialization failed: %d",
>   						ret);
> @@ -10719,7 +10722,9 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>   		err |=3D !!ret;
>   		goto close_out;
>   	}
> -	if (!extent_buffer_uptodate(gfs_info->csum_root->node)) {
> +
> +	root =3D btrfs_csum_root(gfs_info, 0);
> +	if (!extent_buffer_uptodate(root->node)) {
>   		error("critical: csum_root, unable to check the filesystem");
>   		ret =3D -EIO;
>   		err |=3D !!ret;
> diff --git a/check/mode-common.c b/check/mode-common.c
> index 0059672c..0c3bd38b 100644
> --- a/check/mode-common.c
> +++ b/check/mode-common.c
> @@ -287,6 +287,7 @@ out:
>    */
>   int count_csum_range(u64 start, u64 len, u64 *found)
>   {
> +	struct btrfs_root *csum_root =3D btrfs_csum_root(gfs_info, start);
>   	struct btrfs_key key;
>   	struct btrfs_path path;
>   	struct extent_buffer *leaf;
> @@ -302,8 +303,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
>   	key.offset =3D start;
>   	key.type =3D BTRFS_EXTENT_CSUM_KEY;
>
> -	ret =3D btrfs_search_slot(NULL, gfs_info->csum_root,
> -				&key, &path, 0, 0);
> +	ret =3D btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
>   	if (ret < 0)
>   		goto out;
>   	if (ret > 0 && path.slots[0] > 0) {
> @@ -317,7 +317,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
>   	while (len > 0) {
>   		leaf =3D path.nodes[0];
>   		if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
> -			ret =3D btrfs_next_leaf(gfs_info->csum_root, &path);
> +			ret =3D btrfs_next_leaf(csum_root, &path);
>   			if (ret > 0)
>   				break;
>   			else if (ret < 0)
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 03c7f48f..115d91d7 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -1801,7 +1801,7 @@ static int btrfs_rebuild_chunk_stripes(struct reco=
ver_control *rc,
>   	return ret;
>   }
>
> -static int next_csum(struct btrfs_root *root,
> +static int next_csum(struct btrfs_root *csum_root,
>   		     struct extent_buffer **leaf,
>   		     struct btrfs_path *path,
>   		     int *slot,
> @@ -1811,10 +1811,9 @@ static int next_csum(struct btrfs_root *root,
>   		     struct btrfs_key *key)
>   {
>   	int ret =3D 0;
> -	struct btrfs_root *csum_root =3D root->fs_info->csum_root;
>   	struct btrfs_csum_item *csum_item;
> -	u32 blocksize =3D root->fs_info->sectorsize;
> -	u16 csum_size =3D btrfs_super_csum_size(root->fs_info->super_copy);
> +	u32 blocksize =3D csum_root->fs_info->sectorsize;
> +	u16 csum_size =3D btrfs_super_csum_size(csum_root->fs_info->super_copy=
);
>   	int csums_in_item =3D btrfs_item_size_nr(*leaf, *slot) / csum_size;
>
>   	if (*csum_offset >=3D csums_in_item) {
> @@ -1994,7 +1993,6 @@ static int rebuild_raid_data_chunk_stripes(struct =
recover_control *rc,
>   	LIST_HEAD(unordered);
>   	LIST_HEAD(candidates);
>
> -	csum_root =3D root->fs_info->csum_root;
>   	btrfs_init_path(&path);
>   	list_splice_init(&chunk->dextents, &candidates);
>   again:
> @@ -2005,6 +2003,7 @@ again:
>   	key.type =3D BTRFS_EXTENT_CSUM_KEY;
>   	key.offset =3D start;
>
> +	csum_root =3D btrfs_csum_root(root->fs_info, start);
>   	ret =3D btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
>   	if (ret < 0) {
>   		fprintf(stderr, "Search csum failed(%d)\n", ret);
> @@ -2022,8 +2021,8 @@ again:
>   			} else if (ret > 0) {
>   				slot =3D btrfs_header_nritems(leaf) - 1;
>   				btrfs_item_key_to_cpu(leaf, &key, slot);
> -				if (item_end_offset(root, &key, leaf, slot)
> -								> start) {
> +				if (item_end_offset(csum_root, &key,
> +						    leaf, slot) > start) {
>   					csum_offset =3D start - key.offset;
>   					csum_offset /=3D blocksize;
>   					goto next_csum;
> @@ -2061,8 +2060,8 @@ again:
>   			goto out;
>   	}
>   next_csum:
> -	ret =3D next_csum(root, &leaf, &path, &slot, &csum_offset, &tree_csum,
> -			end, &key);
> +	ret =3D next_csum(csum_root, &leaf, &path, &slot, &csum_offset,
> +			&tree_csum, end, &key);
>   	if (ret < 0) {
>   		fprintf(stderr, "Fetch csum failed\n");
>   		goto fail_out;
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 73904255..d2d1a006 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -1161,7 +1161,7 @@ struct btrfs_fs_info {
>   	struct btrfs_root *tree_root;
>   	struct btrfs_root *chunk_root;
>   	struct btrfs_root *dev_root;
> -	struct btrfs_root *csum_root;
> +	struct btrfs_root *_csum_root;
>   	struct btrfs_root *quota_root;
>   	struct btrfs_root *free_space_root;
>   	struct btrfs_root *uuid_root;
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 1f940221..c1d55692 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -744,6 +744,12 @@ int btrfs_fs_roots_compare_roots(struct rb_node *no=
de1, struct rb_node *node2)
>   	return btrfs_fs_roots_compare_objectids(node1, (void *)&root->objecti=
d);
>   }
>
> +struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
> +				   u64 bytenr)
> +{
> +	return fs_info->_csum_root;
> +}
> +
>   struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
>   				      struct btrfs_key *location)
>   {
> @@ -761,7 +767,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_f=
s_info *fs_info,
>   	if (location->objectid =3D=3D BTRFS_DEV_TREE_OBJECTID)
>   		return fs_info->dev_root;
>   	if (location->objectid =3D=3D BTRFS_CSUM_TREE_OBJECTID)
> -		return fs_info->csum_root;
> +		return btrfs_csum_root(fs_info, location->offset);
>   	if (location->objectid =3D=3D BTRFS_UUID_TREE_OBJECTID)
>   		return fs_info->uuid_root ? fs_info->uuid_root : ERR_PTR(-ENOENT);
>   	if (location->objectid =3D=3D BTRFS_QUOTA_TREE_OBJECTID)
> @@ -797,7 +803,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_inf=
o)
>   	free(fs_info->extent_root);
>   	free(fs_info->chunk_root);
>   	free(fs_info->dev_root);
> -	free(fs_info->csum_root);
> +	free(fs_info->_csum_root);
>   	free(fs_info->free_space_root);
>   	free(fs_info->uuid_root);
>   	free(fs_info->super_copy);
> @@ -817,7 +823,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable=
, u64 sb_bytenr)
>   	fs_info->extent_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->chunk_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->dev_root =3D calloc(1, sizeof(struct btrfs_root));
> -	fs_info->csum_root =3D calloc(1, sizeof(struct btrfs_root));
> +	fs_info->_csum_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->quota_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->free_space_root =3D calloc(1, sizeof(struct btrfs_root));
>   	fs_info->uuid_root =3D calloc(1, sizeof(struct btrfs_root));
> @@ -825,7 +831,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable=
, u64 sb_bytenr)
>
>   	if (!fs_info->tree_root || !fs_info->extent_root ||
>   	    !fs_info->chunk_root || !fs_info->dev_root ||
> -	    !fs_info->csum_root || !fs_info->quota_root ||
> +	    !fs_info->_csum_root || !fs_info->quota_root ||
>   	    !fs_info->free_space_root || !fs_info->uuid_root ||
>   	    !fs_info->super_copy)
>   		goto free_all;
> @@ -993,11 +999,11 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs=
_info, u64 root_tree_bytenr,
>   	}
>   	fs_info->dev_root->track_dirty =3D 1;
>
> -	ret =3D setup_root_or_create_block(fs_info, flags, fs_info->csum_root,
> +	ret =3D setup_root_or_create_block(fs_info, flags, fs_info->_csum_root=
,
>   					 BTRFS_CSUM_TREE_OBJECTID, "csum");
>   	if (ret)
>   		return ret;
> -	fs_info->csum_root->track_dirty =3D 1;
> +	fs_info->_csum_root->track_dirty =3D 1;
>
>   	ret =3D find_and_setup_root(root, fs_info, BTRFS_UUID_TREE_OBJECTID,
>   				  fs_info->uuid_root);
> @@ -1072,8 +1078,8 @@ void btrfs_release_all_roots(struct btrfs_fs_info =
*fs_info)
>   		free_extent_buffer(fs_info->free_space_root->node);
>   	if (fs_info->quota_root)
>   		free_extent_buffer(fs_info->quota_root->node);
> -	if (fs_info->csum_root)
> -		free_extent_buffer(fs_info->csum_root->node);
> +	if (fs_info->_csum_root)
> +		free_extent_buffer(fs_info->_csum_root->node);
>   	if (fs_info->dev_root)
>   		free_extent_buffer(fs_info->dev_root->node);
>   	if (fs_info->extent_root)
> @@ -1854,11 +1860,11 @@ static void backup_super_roots(struct btrfs_fs_i=
nfo *info)
>   	btrfs_set_backup_dev_root_level(root_backup,
>   				       btrfs_header_level(info->dev_root->node));
>
> -	btrfs_set_backup_csum_root(root_backup, info->csum_root->node->start);
> +	btrfs_set_backup_csum_root(root_backup, info->_csum_root->node->start)=
;
>   	btrfs_set_backup_csum_root_gen(root_backup,
> -			       btrfs_header_generation(info->csum_root->node));
> +			       btrfs_header_generation(info->_csum_root->node));
>   	btrfs_set_backup_csum_root_level(root_backup,
> -			       btrfs_header_level(info->csum_root->node));
> +			       btrfs_header_level(info->_csum_root->node));
>
>   	btrfs_set_backup_total_bytes(root_backup,
>   			     btrfs_super_total_bytes(info->super_copy));
> diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
> index e113d842..38abbca5 100644
> --- a/kernel-shared/disk-io.h
> +++ b/kernel-shared/disk-io.h
> @@ -217,5 +217,5 @@ int btrfs_fs_roots_compare_roots(struct rb_node *nod=
e1, struct rb_node *node2);
>   struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
>   				     struct btrfs_fs_info *fs_info,
>   				     u64 objectid);
> -
> +struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 b=
ytenr);
>   #endif
> diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
> index 5bf6aab4..12932e1d 100644
> --- a/kernel-shared/file-item.c
> +++ b/kernel-shared/file-item.c
> @@ -185,7 +185,7 @@ fail:
>   int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
>   			  u64 alloc_end, u64 bytenr, char *data, size_t len)
>   {
> -	struct btrfs_root *root =3D trans->fs_info->csum_root;
> +	struct btrfs_root *root =3D btrfs_csum_root(trans->fs_info, bytenr);
>   	int ret =3D 0;
>   	struct btrfs_key file_key;
>   	struct btrfs_key found_key;
> @@ -401,7 +401,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans=
, u64 bytenr, u64 len)
>   	int ret;
>   	u16 csum_size =3D btrfs_super_csum_size(trans->fs_info->super_copy);
>   	int blocksize =3D trans->fs_info->sectorsize;
> -	struct btrfs_root *csum_root =3D trans->fs_info->csum_root;
> +	struct btrfs_root *csum_root =3D btrfs_csum_root(trans->fs_info, byten=
r);
>
>
>   	path =3D btrfs_alloc_path();
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ce86a0db..c6cc51e9 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -268,6 +268,7 @@ static int recow_roots(struct btrfs_trans_handle *tr=
ans,
>   		       struct btrfs_root *root)
>   {
>   	struct btrfs_fs_info *info =3D root->fs_info;
> +	struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0);
>   	int ret;
>
>   	ret =3D __recow_root(trans, info->fs_root);
> @@ -285,7 +286,7 @@ static int recow_roots(struct btrfs_trans_handle *tr=
ans,
>   	ret =3D __recow_root(trans, info->dev_root);
>   	if (ret)
>   		return ret;
> -	ret =3D __recow_root(trans, info->csum_root);
> +	ret =3D __recow_root(trans, csum_root);
>   	if (ret)
>   		return ret;
>   	if (info->free_space_root) {
>
