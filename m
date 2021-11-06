Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0778446BC2
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 02:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhKFBVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 21:21:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:56871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhKFBUw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 21:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636161487;
        bh=hbLshCvAj9WrRh0QUzQvYvppKMVotlKTc7pwEy5NPpI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=aAhzWJ2oJ+VduL8f+70wRPnZ5UB4JGbjoYptD85ykAf7KGUvj0ErXQo0CgimNeglD
         GO+Q4ndavFGk/LeplsvXLLnhzmIpiPlrWSsyPJcoj7mDDGkktKV/53vFjycBESntqK
         T+c5U5uNaAB/wTArKd6PCfei/tJM6Y5gkpfy+L7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26rD-1ml69P2Tdp-002Z68; Sat, 06
 Nov 2021 02:18:07 +0100
Message-ID: <0595f1b5-2d5c-c5ca-cfad-efb753afec1b@gmx.com>
Date:   Sat, 6 Nov 2021 09:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 8/8] btrfs: add support for multiple global roots
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636145221.git.josef@toxicpanda.com>
 <a6f403691bdec22e8e052f699ae52f18875cb870.1636145221.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a6f403691bdec22e8e052f699ae52f18875cb870.1636145221.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J+bd64i5ZTGGFzp4cGp2UhhukSl9fj0ZH1knu77vDjEMUfq17rR
 65xwhI/53zgiGDWRwgeFyTXI4lsXNjcdowAGlcRXzlo2lFPnKuHkagBpt1WzAR7ywJyssz0
 lt3vYTPJxs6e2LwK8JW4J4Vva4gh3fUM8JxrdYqVpJYXFniDwQiE5TZVgXRQI8wmNbI1Rg5
 VBVSP6X0VLW5GbUMM7wSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gT5R2JXyVek=:TIJCsu1ozN2MdJgZ8lLvxu
 RNkEceKzp87GI7hrBJ0iGJ7kFbpGLAh4xEOuObU7WxXK+UgmrPRQdGR+oUJ3UydOUto76br5b
 GGZkIhaMjyzMJq9NrgaKlNurghGDhXM8eDWIZoueB/mY9AT6W9uMyChR/toyhJdqgrbeGdmq+
 dWa/vEUd8uy70id3f/CMfdTyLqYC5H0qf1667vqypQuEF91PbZMZkKUns7YDoSbDyxgZw98un
 UGJaBx+RoZWgMi4bJhSaOOnvpsyNmeli0JUILIHuh2nZX0P9coCnfMvh3bF5sC3EOk/A4YJYJ
 j4FH3H5yXm0qe26zFKm2a+TTFedq1w+0BRhHv3AjrdcC+yzCVTBpzVMDQP91dtCNe0g9ytxUt
 0fACnjuh8aTiluuqWuZh6Dkj9QrO0LKk2IQWFytnIqanso3pLEnmBVXb1rwTA5mc5pdg32L7e
 EjTAkWiAWwPUvcEFVrUzGjQbCeYV7T1cMYiZI/ERbAzp1Ctb4PacvJIYFWW450GygfdMp0+Xi
 +9HNzBl1eENXTa9qYUAIwmVfmD5ZJGaNJirAt65lieOlQo8esQuzWcuzo/mqXltIR9PPVcvOo
 Nj4wRK3WtvXPVZUvnhAB0VReit/Cg4rAxchtpAxQhrwXw6Asd5ZmSMS4lxnXdECS9H3v+vBCN
 qJYzjGy359PRCHgwJrAl6WCrKosC1qFBiMuqFRMDndgD8CKrQpuM9aClCd2V0ktTP3wvO3nuP
 fuhXnhBc+DpYRB5T3LIp+xeS2PydcI5O+yZnmKfuUeBjSsgVUc/rUzM85m3VXyOhCqIUnVI6X
 BkSGNpbCUcm7soXwoT5gE+dkYwHgj9XqS/sF1G0Sil43vriSwZVgU7lOWmA5WuuYHetTE+r9Q
 Q3NA8FBKy3ME9ox0AZZRPpjp0fl+HOis3LP72o7Phelfkv9diHEKecaIDMdiS09sqsSns2GNN
 kVuLZKanHxR9dxGrTrpQDrRRoHYVkNxpeLYZ1XQx7LqBU7xwS/mF5Pb1/DQWSCZvbMNWn3Acx
 Puh3uJ4eRYM0TdC85p8212FZnjZjiOCQjzC56muNK7cSwZaXKklLWImdo7nJ1ikeLvhHrluIk
 QQ8mGqJ+JyPvm4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:49, Josef Bacik wrote:
> With extent tree v2 you will be able to create multiple csum, extent,
> and free space trees.  They will be used based on the block group, which
> will now use the block_group_item->chunk_objectid to point to the set of
> global roots that it will use.  When allocating new block groups we'll
> simply mod the gigabyte offset of the block group against the number of
> global roots we have and that will be the block groups global id.
>
>  From there we can take the bytenr that we're modifying in the respectiv=
e
> tree, look up the block group and get that block groups corresponding
> global root id.  From there we can get to the appropriate global root
> for that bytenr.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/block-group.c     | 11 +++++++--
>   fs/btrfs/block-group.h     |  1 +
>   fs/btrfs/ctree.h           |  2 ++
>   fs/btrfs/disk-io.c         | 49 +++++++++++++++++++++++++++++++-------
>   fs/btrfs/free-space-tree.c |  2 ++
>   fs/btrfs/transaction.c     | 15 ++++++++++++
>   fs/btrfs/tree-checker.c    | 21 ++++++++++++++--
>   7 files changed, 88 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7eb0a8632a01..85516f2fd5da 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_in=
fo *info,
>   	cache->length =3D key->offset;
>   	cache->used =3D btrfs_stack_block_group_used(bgi);
>   	cache->flags =3D btrfs_stack_block_group_flags(bgi);
> +	cache->global_root_id =3D btrfs_stack_block_group_chunk_objectid(bgi);
>
>   	set_free_space_tree_thresholds(cache);
>
> @@ -2284,7 +2285,7 @@ static int insert_block_group_item(struct btrfs_tr=
ans_handle *trans,
>   	spin_lock(&block_group->lock);
>   	btrfs_set_stack_block_group_used(&bgi, block_group->used);
>   	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
> +						   block_group->global_root_id);
>   	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
>   	key.objectid =3D block_group->start;
>   	key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
> @@ -2460,6 +2461,12 @@ struct btrfs_block_group *btrfs_make_block_group(=
struct btrfs_trans_handle *tran
>   	cache->flags =3D type;
>   	cache->last_byte_to_unpin =3D (u64)-1;
>   	cache->cached =3D BTRFS_CACHE_FINISHED;
> +	cache->global_root_id =3D BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> +
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +		cache->global_root_id =3D div64_u64(cache->start, SZ_1G) %
> +			fs_info->nr_global_roots;
> +

Any special reason for this complex global_root_id calculation?

My initial assumption for global trees is pretty simple, just something
like (CSUM_TREE, ROOT_ITEM, bg bytenr) or (EXTENT_TREE, ROOT_ITEM, bg
bytenr) as their root key items.

But this is definitely not the case here.

Thus I'm wondering why we're not using something more simple.

Thanks,
Qu

>   	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
>   		cache->needs_free_space =3D 1;
>
> @@ -2676,7 +2683,7 @@ static int update_block_group_item(struct btrfs_tr=
ans_handle *trans,
>   	bi =3D btrfs_item_ptr_offset(leaf, path->slots[0]);
>   	btrfs_set_stack_block_group_used(&bgi, cache->used);
>   	btrfs_set_stack_block_group_chunk_objectid(&bgi,
> -			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
> +						   cache->global_root_id);
>   	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
>   	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>   	btrfs_mark_buffer_dirty(leaf);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 5878b7ce3b78..93aabc68bb6a 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -68,6 +68,7 @@ struct btrfs_block_group {
>   	u64 bytes_super;
>   	u64 flags;
>   	u64 cache_generation;
> +	u64 global_root_id;
>
>   	/*
>   	 * If the free space extent count exceeds this number, convert the bl=
ock
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b57367141b95..7de0cd2b87ec 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1057,6 +1057,8 @@ struct btrfs_fs_info {
>   	spinlock_t relocation_bg_lock;
>   	u64 data_reloc_bg;
>
> +	u64 nr_global_roots;
> +
>   	spinlock_t zone_active_bgs_lock;
>   	struct list_head zone_active_bgs;
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 45b2bde43150..a8bc00d17b26 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1295,13 +1295,33 @@ struct btrfs_root *btrfs_global_root(struct btrf=
s_fs_info *fs_info,
>   	return root;
>   }
>
> +static u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 byte=
nr)
> +{
> +	struct btrfs_block_group *block_group;
> +	u64 ret;
> +
> +	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +		return 0;
> +
> +	if (likely(bytenr))
> +		block_group =3D btrfs_lookup_block_group(fs_info, bytenr);
> +	else
> +		block_group =3D btrfs_lookup_first_block_group(fs_info, bytenr);
> +	ASSERT(block_group);
> +	if (!block_group)
> +		return 0;
> +	ret =3D block_group->global_root_id;
> +	btrfs_put_block_group(block_group);
> +	return ret;
> +}
> +
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
>   				   u64 bytenr)
>   {
>   	struct btrfs_key key =3D {
>   		.objectid =3D BTRFS_CSUM_TREE_OBJECTID,
>   		.type =3D BTRFS_ROOT_ITEM_KEY,
> -		.offset =3D 0,
> +		.offset =3D btrfs_global_root_id(fs_info, bytenr),
>   	};
>
>   	return btrfs_global_root(fs_info, &key);
> @@ -1313,7 +1333,7 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_=
fs_info *fs_info,
>   	struct btrfs_key key =3D {
>   		.objectid =3D BTRFS_EXTENT_TREE_OBJECTID,
>   		.type =3D BTRFS_ROOT_ITEM_KEY,
> -		.offset =3D 0,
> +		.offset =3D btrfs_global_root_id(fs_info, bytenr),
>   	};
>
>   	return btrfs_global_root(fs_info, &key);
> @@ -2094,7 +2114,6 @@ static void backup_super_roots(struct btrfs_fs_inf=
o *info)
>   {
>   	const int next_backup =3D info->backup_root_index;
>   	struct btrfs_root_backup *root_backup;
> -	struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0);
>
>   	root_backup =3D info->super_for_commit->super_roots + next_backup;
>
> @@ -2128,6 +2147,7 @@ static void backup_super_roots(struct btrfs_fs_inf=
o *info)
>   			btrfs_header_level(info->block_group_root->node));
>   	} else {
>   		struct btrfs_root *extent_root =3D btrfs_extent_root(info, 0);
> +		struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0);
>
>   		btrfs_set_backup_extent_root(root_backup,
>   					     extent_root->node->start);
> @@ -2135,6 +2155,12 @@ static void backup_super_roots(struct btrfs_fs_in=
fo *info)
>   				btrfs_header_generation(extent_root->node));
>   		btrfs_set_backup_extent_root_level(root_backup,
>   					btrfs_header_level(extent_root->node));
> +
> +		btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
> +		btrfs_set_backup_csum_root_gen(root_backup,
> +					       btrfs_header_generation(csum_root->node));
> +		btrfs_set_backup_csum_root_level(root_backup,
> +						 btrfs_header_level(csum_root->node));
>   	}
>
>   	/*
> @@ -2156,12 +2182,6 @@ static void backup_super_roots(struct btrfs_fs_in=
fo *info)
>   	btrfs_set_backup_dev_root_level(root_backup,
>   				       btrfs_header_level(info->dev_root->node));
>
> -	btrfs_set_backup_csum_root(root_backup, csum_root->node->start);
> -	btrfs_set_backup_csum_root_gen(root_backup,
> -				       btrfs_header_generation(csum_root->node));
> -	btrfs_set_backup_csum_root_level(root_backup,
> -					 btrfs_header_level(csum_root->node));
> -
>   	btrfs_set_backup_total_bytes(root_backup,
>   			     btrfs_super_total_bytes(info->super_copy));
>   	btrfs_set_backup_bytes_used(root_backup,
> @@ -2550,6 +2570,7 @@ static int load_global_roots_objectid(struct btrfs=
_root *tree_root,
>   {
>   	struct btrfs_fs_info *fs_info =3D tree_root->fs_info;
>   	struct btrfs_root *root;
> +	u64 max_global_id =3D 0;
>   	int ret;
>   	struct btrfs_key key =3D {
>   		.objectid =3D objectid,
> @@ -2586,6 +2607,13 @@ static int load_global_roots_objectid(struct btrf=
s_root *tree_root,
>   			break;
>   		btrfs_release_path(path);
>
> +		/*
> +		 * Just worry about this for extent tree, it'll be the same for
> +		 * everybody.
> +		 */
> +		if (objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID)
> +			max_global_id =3D max(max_global_id, key.offset);
> +
>   		found =3D true;
>   		root =3D read_tree_root_path(tree_root, path, &key);
>   		if (IS_ERR(root)) {
> @@ -2603,6 +2631,9 @@ static int load_global_roots_objectid(struct btrfs=
_root *tree_root,
>   	}
>   	btrfs_release_path(path);
>
> +	if (objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID)
> +		fs_info->nr_global_roots =3D max_global_id + 1;
> +
>   	if (!found || ret) {
>   		if (objectid =3D=3D BTRFS_CSUM_TREE_OBJECTID)
>   			set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index cf227450f356..60a73bcffaf1 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -24,6 +24,8 @@ static struct btrfs_root *btrfs_free_space_root(
>   		.type =3D BTRFS_ROOT_ITEM_KEY,
>   		.offset =3D 0,
>   	};
> +	if (btrfs_fs_incompat(block_group->fs_info, EXTENT_TREE_V2))
> +		key.offset =3D block_group->global_root_id;
>   	return btrfs_global_root(block_group->fs_info, &key);
>   }
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index ba8dd90ac3ce..e343ff8db05d 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1827,6 +1827,14 @@ static void update_super_roots(struct btrfs_fs_in=
fo *fs_info)
>   		super->cache_generation =3D 0;
>   	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
>   		super->uuid_tree_generation =3D root_item->generation;
> +
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +		root_item =3D &fs_info->block_group_root->root_item;
> +
> +		super->block_group_root =3D root_item->bytenr;
> +		super->block_group_root_generation =3D root_item->generation;
> +		super->block_group_root_level =3D root_item->level;
> +	}
>   }
>
>   int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
> @@ -2261,6 +2269,13 @@ int btrfs_commit_transaction(struct btrfs_trans_h=
andle *trans)
>   	list_add_tail(&fs_info->chunk_root->dirty_list,
>   		      &cur_trans->switch_commits);
>
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +		btrfs_set_root_node(&fs_info->block_group_root->root_item,
> +				    fs_info->block_group_root->node);
> +		list_add_tail(&fs_info->block_group_root->dirty_list,
> +			      &cur_trans->switch_commits);
> +	}
> +
>   	switch_commit_roots(trans);
>
>   	ASSERT(list_empty(&cur_trans->dirty_bgs));
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 1c33dd0e4afc..572f52d78297 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -639,8 +639,10 @@ static void block_group_err(const struct extent_buf=
fer *eb, int slot,
>   static int check_block_group_item(struct extent_buffer *leaf,
>   				  struct btrfs_key *key, int slot)
>   {
> +	struct btrfs_fs_info *fs_info =3D leaf->fs_info;
>   	struct btrfs_block_group_item bgi;
>   	u32 item_size =3D btrfs_item_size_nr(leaf, slot);
> +	u64 chunk_objectid;
>   	u64 flags;
>   	u64 type;
>
> @@ -663,8 +665,23 @@ static int check_block_group_item(struct extent_buf=
fer *leaf,
>
>   	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
>   			   sizeof(bgi));
> -	if (unlikely(btrfs_stack_block_group_chunk_objectid(&bgi) !=3D
> -		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
> +	chunk_objectid =3D btrfs_stack_block_group_chunk_objectid(&bgi);
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
> +		/*
> +		 * We don't init the nr_global_roots until we load the global
> +		 * roots, so this could be 0 at mount time.  If it's 0 we'll
> +		 * just assume we're fine, and later we'll check against our
> +		 * actual value.
> +		 */
> +		if (unlikely(fs_info->nr_global_roots &&
> +			     chunk_objectid >=3D fs_info->nr_global_roots)) {
> +			block_group_err(leaf, slot,
> +	"invalid block group global root id, have %llu, needs to be <=3D %llu"=
,
> +					chunk_objectid,
> +					fs_info->nr_global_roots);
> +			return -EUCLEAN;
> +		}
> +	} else if (unlikely(chunk_objectid !=3D BTRFS_FIRST_CHUNK_TREE_OBJECTI=
D)) {
>   		block_group_err(leaf, slot,
>   		"invalid block group chunk objectid, have %llu expect %llu",
>   				btrfs_stack_block_group_chunk_objectid(&bgi),
>
