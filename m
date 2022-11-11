Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8012D625F28
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 17:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiKKQKZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 11:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiKKQKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 11:10:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A9F5B2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 08:10:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CAAB224ED;
        Fri, 11 Nov 2022 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668183021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjLEHT9bd0AJ2kM8l8Lm/P+oKPqGv62YcAQOwJQ8GOM=;
        b=cDGg6LYbSTbyPsw6Fop8x6el3jmzWj+2mkyhEDDtCQTnMuBA+GKfe5toSub1O9Z+xo2Hi2
        xQjxi1BlfWI6fMEPYa+eub/gsnl6TL1fxwDrDN+FRplXkqoRn9FFL8yibd+Kow7Tecw/tq
        OOyHFn1zs5wRHbX4HcrUFQUaALZ90iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668183021;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjLEHT9bd0AJ2kM8l8Lm/P+oKPqGv62YcAQOwJQ8GOM=;
        b=0Is46JVzvOcJ8/KGFFAR0xVt6o2QLHGE4raPQXJSmqcR65M3ylRvbQcsh5AXvLZXVj65PX
        eAHGD4u8R4IAjODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC54913273;
        Fri, 11 Nov 2022 16:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w+vuMOxzbmMUSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 16:10:20 +0000
Date:   Fri, 11 Nov 2022 17:09:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: concentrate all tree block parentness check
 parameters into one structure
Message-ID: <20221111160957.GU5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663133223.git.wqu@suse.com>
 <5776cd5a337d786e57d9e6dbea3e371cc74c14e3.1663133223.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5776cd5a337d786e57d9e6dbea3e371cc74c14e3.1663133223.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:32:50PM +0800, Qu Wenruo wrote:
> There are several different tree block parentness check parameters used
> across several helpers:
> 
> - level
>   Mandatory
> 
> - transid
>   Under most cases it's mandatory, but there are several backref cases
>   which skips this check.
> 
> - owner_root
> - first_key
>   Utilized by most top-down tree search routine. Otherwise can be
>   skipped.
> 
> Those four members are not always mandatory checks, and some of them are
> the same u64, which means if some arguments got swapped compiler will
> not catch it.
> 
> Furthermore if we're going to further expand the parentness check, we
> need to modify quite some helpers just to add one more parameter.
> 
> This patch will concentrate all these members into a structure called
> btrfs_tree_parent_check, and pass that structure for the following
> helpers:
> 
> - btrfs_read_extent_buffer()
> - read_tree_block()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/backref.c      | 15 ++++++++---
>  fs/btrfs/ctree.c        | 28 +++++++++++--------
>  fs/btrfs/disk-io.c      | 59 ++++++++++++++++++++++++-----------------
>  fs/btrfs/disk-io.h      | 36 ++++++++++++++++++++++---
>  fs/btrfs/extent-tree.c  | 12 ++++++---
>  fs/btrfs/print-tree.c   | 13 +++++----
>  fs/btrfs/qgroup.c       | 18 ++++++++++---
>  fs/btrfs/relocation.c   | 11 +++++---
>  fs/btrfs/tree-log.c     | 25 ++++++++++++-----
>  fs/btrfs/tree-mod-log.c |  9 +++++--
>  10 files changed, 158 insertions(+), 68 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 9d06f8c18b15..abaed23edc7c 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -777,6 +777,8 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
>  	struct rb_node *node;
>  
>  	while ((node = rb_first_cached(&tree->root))) {
> +		struct btrfs_tree_parent_check check = {0};

The { 0 } should be used.

> +
>  		ref = rb_entry(node, struct prelim_ref, rbnode);
>  		rb_erase_cached(node, &tree->root);
>  
> @@ -784,8 +786,10 @@ static int add_missing_keys(struct btrfs_fs_info *fs_info,
>  		BUG_ON(ref->key_for_search.type);
>  		BUG_ON(!ref->wanted_disk_byte);
>  
> -		eb = read_tree_block(fs_info, ref->wanted_disk_byte,
> -				     ref->root_id, 0, ref->level - 1, NULL);
> +		check.level = ref->level - 1;
> +		check.owner_root = ref->root_id;
> +
> +		eb = read_tree_block(fs_info, ref->wanted_disk_byte, &check);
>  		if (IS_ERR(eb)) {
>  			free_pref(ref);
>  			return PTR_ERR(eb);
> @@ -1330,10 +1334,13 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
>  		if (ref->count && ref->parent) {
>  			if (extent_item_pos && !ref->inode_list &&
>  			    ref->level == 0) {
> +				struct btrfs_tree_parent_check check = {0};
>  				struct extent_buffer *eb;
>  
> -				eb = read_tree_block(fs_info, ref->parent, 0,
> -						     0, ref->level, NULL);
> +				check.level = ref->level;
> +
> +				eb = read_tree_block(fs_info, ref->parent,
> +						     &check);
>  				if (IS_ERR(eb)) {
>  					ret = PTR_ERR(eb);
>  					goto out;
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index ebfa35fe1c38..44dd9ed3fe63 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -834,19 +834,22 @@ struct extent_buffer *btrfs_read_node_slot(struct extent_buffer *parent,
>  					   int slot)
>  {
>  	int level = btrfs_header_level(parent);
> +	struct btrfs_tree_parent_check check = {0};
>  	struct extent_buffer *eb;
> -	struct btrfs_key first_key;
>  
>  	if (slot < 0 || slot >= btrfs_header_nritems(parent))
>  		return ERR_PTR(-ENOENT);
>  
>  	BUG_ON(level == 0);
>  
> -	btrfs_node_key_to_cpu(parent, &first_key, slot);
> +	check.level = level - 1;
> +	check.transid = btrfs_node_ptr_generation(parent, slot);
> +	check.owner_root = btrfs_header_owner(parent);
> +	check.has_first_key = true;
> +	btrfs_node_key_to_cpu(parent, &check.first_key, slot);
> +
>  	eb = read_tree_block(parent->fs_info, btrfs_node_blockptr(parent, slot),
> -			     btrfs_header_owner(parent),
> -			     btrfs_node_ptr_generation(parent, slot),
> -			     level - 1, &first_key);
> +			     &check);
>  	if (IS_ERR(eb))
>  		return eb;
>  	if (!extent_buffer_uptodate(eb)) {
> @@ -1405,10 +1408,10 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  		      const struct btrfs_key *key)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct btrfs_tree_parent_check check = {0};
>  	u64 blocknr;
>  	u64 gen;
>  	struct extent_buffer *tmp;
> -	struct btrfs_key first_key;
>  	int ret;
>  	int parent_level;
>  	bool unlock_up;
> @@ -1417,7 +1420,11 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  	blocknr = btrfs_node_blockptr(*eb_ret, slot);
>  	gen = btrfs_node_ptr_generation(*eb_ret, slot);
>  	parent_level = btrfs_header_level(*eb_ret);
> -	btrfs_node_key_to_cpu(*eb_ret, &first_key, slot);
> +	btrfs_node_key_to_cpu(*eb_ret, &check.first_key, slot);
> +	check.has_first_key = true;
> +	check.level = parent_level - 1;
> +	check.transid = gen;
> +	check.owner_root = root->root_key.objectid;
>  
>  	/*
>  	 * If we need to read an extent buffer from disk and we are holding locks
> @@ -1439,7 +1446,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  			 * parents (shared tree blocks).
>  			 */
>  			if (btrfs_verify_level_key(tmp,
> -					parent_level - 1, &first_key, gen)) {
> +					parent_level - 1, &check.first_key, gen)) {
>  				free_extent_buffer(tmp);
>  				return -EUCLEAN;
>  			}
> @@ -1451,7 +1458,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  			btrfs_unlock_up_safe(p, level + 1);
>  
>  		/* now we're allowed to do a blocking uptodate check */
> -		ret = btrfs_read_extent_buffer(tmp, gen, parent_level - 1, &first_key);
> +		ret = btrfs_read_extent_buffer(tmp, &check);
>  		if (ret) {
>  			free_extent_buffer(tmp);
>  			btrfs_release_path(p);
> @@ -1479,8 +1486,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  	if (p->reada != READA_NONE)
>  		reada_for_search(fs_info, p, level, slot, key->objectid);
>  
> -	tmp = read_tree_block(fs_info, blocknr, root->root_key.objectid,
> -			      gen, parent_level - 1, &first_key);
> +	tmp = read_tree_block(fs_info, blocknr, &check);
>  	if (IS_ERR(tmp)) {
>  		btrfs_release_path(p);
>  		return PTR_ERR(tmp);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 54b5784a59e5..80aa0ba4ac55 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -253,13 +253,11 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
>   * helper to read a given tree block, doing retries as required when
>   * the checksums don't match and we have alternate mirrors to try.
>   *
> - * @parent_transid:	expected transid, skip check if 0
> - * @level:		expected level, mandatory check
> - * @first_key:		expected key of first slot, skip check if NULL
> + * @check:		expected tree parentness check, see the comments of the
> + *			structure for details.
>   */
>  int btrfs_read_extent_buffer(struct extent_buffer *eb,
> -			     u64 parent_transid, int level,
> -			     struct btrfs_key *first_key)
> +			     struct btrfs_tree_parent_check *check)
>  {
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
>  	struct extent_io_tree *io_tree;
> @@ -269,16 +267,20 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
>  	int mirror_num = 0;
>  	int failed_mirror = 0;
>  
> +	ASSERT(check);
> +
>  	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
>  	while (1) {
>  		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
>  		ret = read_extent_buffer_pages(eb, WAIT_COMPLETE, mirror_num);
>  		if (!ret) {
>  			if (verify_parent_transid(io_tree, eb,
> -						   parent_transid, 0))
> +						  check->transid, 0))
>  				ret = -EIO;
> -			else if (btrfs_verify_level_key(eb, level,
> -						first_key, parent_transid))
> +			else if (btrfs_verify_level_key(eb, check->level,
> +						check->has_first_key ?
> +						&check->first_key : NULL,
> +						check->transid))
>  				ret = -EUCLEAN;
>  			else
>  				break;
> @@ -922,28 +924,28 @@ struct extent_buffer *btrfs_find_create_tree_block(
>   * Read tree block at logical address @bytenr and do variant basic but critical
>   * verification.
>   *
> - * @owner_root:		the objectid of the root owner for this block.
> - * @parent_transid:	expected transid of this tree block, skip check if 0
> - * @level:		expected level, mandatory check
> - * @first_key:		expected key in slot 0, skip check if NULL
> + * @check:		expected tree parentness check, see comments of the
> + *			structure for details.
>   */
>  struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
> -				      u64 owner_root, u64 parent_transid,
> -				      int level, struct btrfs_key *first_key)
> +				      struct btrfs_tree_parent_check *check)
>  {
>  	struct extent_buffer *buf = NULL;
>  	int ret;
>  
> -	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
> +	ASSERT(check);
> +
> +	buf = btrfs_find_create_tree_block(fs_info, bytenr, check->owner_root,
> +					   check->level);
>  	if (IS_ERR(buf))
>  		return buf;
>  
> -	ret = btrfs_read_extent_buffer(buf, parent_transid, level, first_key);
> +	ret = btrfs_read_extent_buffer(buf, check);
>  	if (ret) {
>  		free_extent_buffer_stale(buf);
>  		return ERR_PTR(ret);
>  	}
> -	if (btrfs_check_eb_owner(buf, owner_root)) {
> +	if (btrfs_check_eb_owner(buf, check->owner_root)) {
>  		free_extent_buffer_stale(buf);
>  		return ERR_PTR(-EUCLEAN);
>  	}
> @@ -1355,6 +1357,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
>  					      struct btrfs_key *key)
>  {
>  	struct btrfs_root *root;
> +	struct btrfs_tree_parent_check check = {0};
>  	struct btrfs_fs_info *fs_info = tree_root->fs_info;
>  	u64 generation;
>  	int ret;
> @@ -1374,9 +1377,12 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
>  
>  	generation = btrfs_root_generation(&root->root_item);
>  	level = btrfs_root_level(&root->root_item);
> +	check.level = level;
> +	check.transid = generation;
> +	check.owner_root = key->objectid;
>  	root->node = read_tree_block(fs_info,
>  				     btrfs_root_bytenr(&root->root_item),
> -				     key->objectid, generation, level, NULL);
> +				     &check);
>  	if (IS_ERR(root->node)) {
>  		ret = PTR_ERR(root->node);
>  		root->node = NULL;
> @@ -2351,6 +2357,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
>  			    struct btrfs_fs_devices *fs_devices)
>  {
>  	int ret;
> +	struct btrfs_tree_parent_check check = {0};
>  	struct btrfs_root *log_tree_root;
>  	struct btrfs_super_block *disk_super = fs_info->super_copy;
>  	u64 bytenr = btrfs_super_log_root(disk_super);
> @@ -2366,10 +2373,10 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
>  	if (!log_tree_root)
>  		return -ENOMEM;
>  
> -	log_tree_root->node = read_tree_block(fs_info, bytenr,
> -					      BTRFS_TREE_LOG_OBJECTID,
> -					      fs_info->generation + 1, level,
> -					      NULL);
> +	check.level = level;
> +	check.transid = fs_info->generation + 1;
> +	check.owner_root = BTRFS_TREE_LOG_OBJECTID;
> +	log_tree_root->node = read_tree_block(fs_info, bytenr, &check);
>  	if (IS_ERR(log_tree_root->node)) {
>  		btrfs_warn(fs_info, "failed to read log tree");
>  		ret = PTR_ERR(log_tree_root->node);
> @@ -2845,10 +2852,14 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
>  
>  static int load_super_root(struct btrfs_root *root, u64 bytenr, u64 gen, int level)
>  {
> +	struct btrfs_tree_parent_check check = {0};
>  	int ret = 0;
>  
> -	root->node = read_tree_block(root->fs_info, bytenr,
> -				     root->root_key.objectid, gen, level, NULL);
> +	check.level = level;
> +	check.transid = gen;
> +	check.owner_root = root->root_key.objectid;

In some cases where the initialization parameters are simple I've moved
it to the definition of block like

	struct btrfs_tree_parent_check check = {
		.level = level,
		.transid = gen,
		.owner_root = root->root_key.objectid
	};
