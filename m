Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239397529F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjGMRiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 13:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGMRh4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 13:37:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC0A26A5
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:37:54 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-576a9507a9bso32915187b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689269874; x=1691861874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRzh+8KI+kPxhh41HeVUk7afTgiZ7kEVdFElHhJvtrk=;
        b=l/2bcY3B8WMK2xR0xx2yPV4cVR+5TZHMJ0mnEKAV9BFjHQF2TsQk9UpBTQMETNrVNq
         IZeWSMNhmGxkcXpvM4T7YTmwkx+BYpauRE1BRxobAgjkNTRh7AOXoY19MMYFVrEZLNfB
         yCMEJzbP3fvmHIkdEQ97Tsx/R3kjIUHoa1JfJHEUMt+Qu2SUOXhJZIKNwJe/kc21jjBC
         oQx45RIZXMXjGPdHnFPDuwjbvsalD6tFn8+OnUudOqNl4LwPsJnmzwuR/IMAeQdCZTFm
         kMvw2P+HuKCKzyDbQp7fn96XLsiC14VQHh77wwVF5slLboQm99iIksFznKRvMRfgLvou
         Txaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269874; x=1691861874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRzh+8KI+kPxhh41HeVUk7afTgiZ7kEVdFElHhJvtrk=;
        b=G/oW3oSrE9/dXYoAunLWyD71ve9RsS0FkE3oJUGtXR/jKLWX4K9x6262VoiCwgoULH
         ANv1oJcaK+6/P1LADz7VETYlkPJ5n5prx1BLuWXFAIJQsfhraWpaIsKpjCYgWymGisnb
         /3kG3xJYCaStYf2rcmD67b0jAH407rrv3Y8FGHQnxIpw9rgZW0NMmxxMV/VLz9IIlW1R
         jjeTU/4VeAnoSNiJB9KNQw8gB/1u1q51u/vIEe5vVjb4dpgBI/QN0Eu3dB7/3g35fmZd
         g2pDYv+GG4EDad9gYKOF5+gm96w2M9OzP0+4UNLihQfKkfBK8g2zE4U37dxa80uEX1UG
         q9Gw==
X-Gm-Message-State: ABy/qLaQSRloS5BgMx/rAI0yTpV5yOiX1yxHSNQINvHjeA95hw565xqC
        8nmUujskbZN9cBmvdTMJ5U2lDx+t5+ZrWy0RQ6NwaQ==
X-Google-Smtp-Source: APBJJlE8bCjbgCoYL2dN5rm4zLQN7KPDJVyIS0vEc9jSRultc6JdlMPDqGKU30hC3ZVo4CtJOmellw==
X-Received: by 2002:a81:6d42:0:b0:56c:e260:e2d5 with SMTP id i63-20020a816d42000000b0056ce260e2d5mr456023ywc.7.1689269873849;
        Thu, 13 Jul 2023 10:37:53 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f65-20020a0dc344000000b00565271801b6sm1870954ywd.59.2023.07.13.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:37:53 -0700 (PDT)
Date:   Thu, 13 Jul 2023 13:37:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 18/18] btrfs: track data relocation with simple quota
Message-ID: <20230713173752.GR207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <d9e6a4525095ec5abb1818547d565fcf3ef58460.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e6a4525095ec5abb1818547d565fcf3ef58460.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:55PM -0700, Boris Burkov wrote:
> Relocation data allocations are quite tricky for simple quotas. The
> basic data relocation sequence is (ignoring details that aren't relevant
> to this fix):
> - create a fake relocation data fs root
> - create a fake relocation inode in that root
> - foreach data extent:
>   - preallocate a data extent on behalf of the fake inode
>   - copy over the data
> - foreach extent
>   - swap the refs so that the original file extent now refers to the new
>     extent item
> - drop the fake root, dropping its refs on the old extents, which lets
>   us delete them.
> 
> Done naively, this results in storing an extent item in the extent tree
> whose owner_ref points at the relocation data root and a no-op squota
> recording, since the reloc root is not a legit fstree. So far, that's
> OK. The problem comes when you do the swap, and leave an extent item
> owned by this bogus root as the real permanent extents of the file. If
> the file then drops that ref, we free it and no-op account that against
> the fake relocation root. Essentially, this means that relocation is
> simple quota "extent laundering", since we re-own the extents into a
> fake root.
> 
> Simple quotas very intentionally doesn't have a mechanism for
> transferring ownership of extents, as that is exactly the complicated
> thing we are trying to avoid with the new design. Further, it cannot be
> correctly done in this case, since at the time you create the new
> "real" refs, there is no way to know which was the original owner before
> relocation unless we track it.
> 
> Therefore, it makes more sense to trick the preallocation to handle
> relocation as a special case and note the proper owner ref from the
> beginning. That way, we never write out an extent item without the
> correct owner ref that it will eventually have.
> 
> This could be done by wiring a special root parameter all the way
> through the allocation code path, but to avoid that special case
> touching all the code, take advantage of the serial nature of relocation
> to store the src root on the relocation root object. Then when we finish
> the prealloc, if it happens to be this case, prepare the delayed ref
> appropriately.
> 
> This is obviously a smelly bit of code, but I think it is the best
> solution to the problem, given the relocation implementation.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ctree.h       |  1 +
>  fs/btrfs/extent-tree.c | 13 +++++++------
>  fs/btrfs/relocation.c  | 15 +++++++++++++++
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f2d2b313bde5..577186994188 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -333,6 +333,7 @@ struct btrfs_root {
>  #ifdef CONFIG_BTRFS_DEBUG
>  	struct list_head leak_list;
>  #endif
> +	u64 relocation_src_root;
>  };
>  
>  static inline bool btrfs_root_readonly(const struct btrfs_root *root)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 99845a54e168..10e026d5b684 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -57,7 +57,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
>  static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  				      u64 parent, u64 root_objectid,
>  				      u64 flags, u64 owner, u64 offset,
> -				      struct btrfs_key *ins, int ref_mod);
> +				      struct btrfs_key *ins, int ref_mod, u64 oref_root);
>  static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  				     struct btrfs_delayed_ref_node *node,
>  				     struct btrfs_delayed_extent_op *extent_op);
> @@ -1541,7 +1541,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  		ret = alloc_reserved_file_extent(trans, parent, ref_root,
>  						 flags, ref->objectid,
>  						 ref->offset, &ins,
> -						 node->ref_mod);
> +						 node->ref_mod, href->owning_root);
>  		if (!ret)
>  			ret = btrfs_record_simple_quota_delta(trans->fs_info, &delta);
>  	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
> @@ -4683,7 +4683,7 @@ static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
>  static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  				      u64 parent, u64 root_objectid,
>  				      u64 flags, u64 owner, u64 offset,
> -				      struct btrfs_key *ins, int ref_mod)
> +				      struct btrfs_key *ins, int ref_mod, u64 oref_root)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_root *extent_root;
> @@ -4731,7 +4731,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  	if (simple_quota) {
>  		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
>  		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> -		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
> +		btrfs_set_extent_owner_ref_root_id(leaf, oref, oref_root);
>  		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
>  	}
>  	btrfs_set_extent_inline_ref_type(leaf, iref, type);
> @@ -4842,7 +4842,8 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  
>  	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
>  
> -	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
> +	if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_src_root))
> +		owning_root = root->relocation_src_root;
>  
>  	btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
>  			       ins->objectid, ins->offset, 0, owning_root);
> @@ -4899,7 +4900,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
>  	spin_unlock(&space_info->lock);
>  
>  	ret = alloc_reserved_file_extent(trans, 0, root_objectid, 0, owner,
> -					 offset, ins, 1);
> +					 offset, ins, 1, root_objectid);
>  	if (ret)
>  		btrfs_pin_extent(trans, ins->objectid, ins->offset, 1);
>  	ret = btrfs_record_simple_quota_delta(fs_info, &delta);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 119f670538f7..e12377c818c0 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3665,6 +3665,21 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  				    struct btrfs_extent_item);
>  		flags = btrfs_extent_flags(path->nodes[0], ei);
>  
> +		/*
> +		 * If we are relocating a simple quota owned extent item, we need
> +		 * to note the owner on the reloc data root so that when we
> +		 * allocate the replacement item, we can attribute it to the
> +		 * correct eventual owner (rather than the reloc data root)
> +		 */
> +		if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE) {
> +			struct btrfs_root *root = BTRFS_I(rc->data_inode)->root;
> +			u64 owning_root_id = btrfs_get_extent_owner_root(fs_info,
> +									 path->nodes[0],
> +									 path->slots[0]);
> +
> +			root->relocation_src_root = owning_root_id;
> +		}
> +

This is almost correct but can mess up if we have adjacent extents that are
owned by different roots.  If you look further down we move the extents via
relocate_data_extent(), which will cluster together ranges to limit the number
of preallocations you do.  You're going to have to add a check in there for the
owning_root_id != root->relocation_src_root, do the prealloc, and then set
root->relocation_src_root in there and carry on.  Thanks,

Josef
