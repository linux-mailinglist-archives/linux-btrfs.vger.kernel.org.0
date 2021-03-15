Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0036633C6D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 20:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhCOTbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 15:31:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:39010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231961AbhCOTbB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 15:31:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3900AE3D;
        Mon, 15 Mar 2021 19:30:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 603AADA6E2; Mon, 15 Mar 2021 20:28:57 +0100 (CET)
Date:   Mon, 15 Mar 2021 20:28:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/9] btrfs: always pin deleted leaves when there are
 active tree mod log users
Message-ID: <20210315192857.GB7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
 <d9d8cda5b3ab2a262d4d66e9fe8abd75912f252f.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9d8cda5b3ab2a262d4d66e9fe8abd75912f252f.1615472583.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 02:31:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When freeing a tree block we may end up adding its extent back to the
> free space cache/tree, as long as there are no more references for it,
> it was created in the current transaction and writeback for it never
> happened. This is generally fine, however when we have tree mod log
> operations it can result in inconsistent versions of a btree after
> unwinding extent buffers with the recorded tree mod log operations.
> 
> This is because:
> 
> * We only log operations for nodes (adding and removing key/pointers),
>   for leaves we don't do anything;
> 
> * This means that we can log a MOD_LOG_KEY_REMOVE_WHILE_FREEING operation
>   for a node that points to a leaf that was deleted;
> 
> * Before we apply the logged operation to unwind a node, we can have
>   that leaf's extent allocated again, either as a node or as a leaf, and
>   possibly for another btree. This is possible if the leaf was created in
>   the current transaction and writeback for it never started, in which
>   case btrfs_free_tree_block() returns its extent back to the free space
>   cache/tree;
> 
> * Then, before applying the tree mod log operation, some task allocates
>   the metadata extent just freed before, and uses it either as a leaf or
>   as a node for some btree (can be the same or another one, it does not
>   matter);
> 
> * After applying the MOD_LOG_KEY_REMOVE_WHILE_FREEING operation we now
>   get the target node with an item pointing to the metadata extent that
>   now has content different from what it had before the leaf was deleted.
>   It might now belong to a different btree and be a node and not a leaf
>   anymore.
> 
>   As a consequence, the results of searches after the unwinding can be
>   unpredictable and produce unexpected results.
> 
> So make sure we pin extent buffers corresponding to leaves when there
> are tree mod log users.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5e228d6ad63f..2482b26b1971 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3310,6 +3310,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  
>  	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
>  		struct btrfs_block_group *cache;
> +		bool must_pin = false;
>  
>  		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
>  			ret = check_ref_cleanup(trans, buf->start);
> @@ -3327,7 +3328,27 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  			goto out;
>  		}
>  
> -		if (btrfs_is_zoned(fs_info)) {
> +		/*
> +		 * If this is a leaf and there are tree mod log users, we may
> +		 * have recorded mod log operations that point to this leaf.
> +		 * So we must make sure no one reuses this leaf's extent before
> +		 * mod log operations are applied to a node, otherwise after
> +		 * rewinding a node using the mod log operations we get an
> +		 * inconsistent btree, as the leaf's extent may now be used as
> +		 * a node or leaf for another different btree.
> +		 * We are safe from races here because at this point no other
> +		 * node or root points to this extent buffer, so if after this
> +		 * check a new tree mod log user joins, it will not be able to
> +		 * find a node pointing to this leaf and record operations that
> +		 * point to this leaf.
> +		 */
> +		if (btrfs_header_level(buf) == 0) {
> +			read_lock(&fs_info->tree_mod_log_lock);
> +			must_pin = !list_empty(&fs_info->tree_mod_seq_list);
> +			read_unlock(&fs_info->tree_mod_log_lock);
> +		}
> +
> +		if (must_pin || btrfs_is_zoned(fs_info)) {
>  			btrfs_redirty_list_add(trans->transaction, buf);
>  			pin_down_extent(trans, cache, buf->start, buf->len, 1);
>  			btrfs_put_block_group(cache);

This has been added in d3575156f662 ("btrfs: zoned: redirty released
extent buffers") 5.12-rc1, so it is a regression but otherwise it sounds
like it's not related only to zoned mode. I'm not sure if this is
relevant for older stable trees because of missing
btrfs_redirty_list_add, possibly with some tweaks. Please let me know,
thanks.
