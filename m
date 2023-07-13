Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB25752941
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGMQ6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGMQ62 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 12:58:28 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A83270A
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 09:58:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-57045429f76so8181377b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689267507; x=1691859507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3qGbKFdG5v0sc9iRAyVTVUouQ0K+inFZmmdmYGP4eM=;
        b=JtBCLaFeg5nkeomC48l68ssXEzYtEuCo+p9DjMxzSWbqduBdccbjG2I5HKPpmbhTkq
         fZADg4BEkovpxpxT7yIGRGhMFmIha04sVnTR15VCragOrJWpxZuUTY/0LL8eJ0vwHa3K
         jco1c/VPfDuwWiBY+yF1ZCSF8ZDIHZ54iu3KwCRjNq3u6ZQ63Qq0ECJOpP6x38kpiGo6
         17tXNpclMTOdZ2wMj88r7N16/sZUk4ix16EbQmjFEtdFA0ew2d+yMDRbyCVmL0Y8CRIR
         kgpGjI/eARTyDm7/VRll6xPWCQiWpVCuUyLvls2ZzcKYLiJN3Rhx/9ISz91JKnG4cu3L
         XPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267507; x=1691859507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3qGbKFdG5v0sc9iRAyVTVUouQ0K+inFZmmdmYGP4eM=;
        b=WIQq0RPERgNkHjZkgEQyjTcWPz0eTrIrui2igAywFxP3IZihGn7blfrCPMj7zCyw5r
         0jxpxN6kDy4kpSZPhEh6u0XagjmqWt1VcxW1yN8nR8iCjvAFCAUgU1J/YHGfmPs7cbKA
         Hh2qsDJs6/ZGnguPN4euvcjP97BiIWxwvjsa/zGcVTkXEsPh2FPVMT83Ad13a1oO7hgL
         vmqT6cViwO3ipkYZ7/UBIEOCS3bL4VqmqFxrjWevU9AFimhevF/8KV7BQAW16Eb1d7QM
         RX6E+kqoqu/Xry7Pb5bmqYXDBzxuGYDy6RSv7Igs5tJgUD8uaIVtGMOXRMVhTN7L2N4E
         Z2Cw==
X-Gm-Message-State: ABy/qLaJYvC5/TVLL0DidVtTP48jz4hcnAOilRgskx9fYMW7x/3w/kT/
        qrDXouWdgHafKd33/4ISav/FBLWU52Z2+blnmzXR7Q==
X-Google-Smtp-Source: APBJJlG1Cyg95n6ZX6PmZRSRROmK9RrgWVTLJCCsCUBnhaiS/ySydwK4LnBJh1An6Mmn1INM4aH8ww==
X-Received: by 2002:a81:4f91:0:b0:57a:5b6f:d41 with SMTP id d139-20020a814f91000000b0057a5b6f0d41mr2278231ywb.42.1689267506768;
        Thu, 13 Jul 2023 09:58:26 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t131-20020a0dea89000000b0056cd3e598d8sm1860105ywe.114.2023.07.13.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:58:26 -0700 (PDT)
Date:   Thu, 13 Jul 2023 12:58:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 10/18] btrfs: track owning root in btrfs_ref
Message-ID: <20230713165825.GJ207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <2a1725b60a1978c03c67a93c55c8c52b76d7f046.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1725b60a1978c03c67a93c55c8c52b76d7f046.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:47PM -0700, Boris Burkov wrote:
> While data extents require us to store additional inline refs to track
> the original owner on free, this information is available implicitly for
> metadata. It is found in the owner field of the header of the tree
> block. Even if other trees refer to this block and the original ref goes
> away, we will not rewrite that header field, so it will reliably give the
> original owner.
> 
> In addition, there is a relocation case where a new data extent needs to
> have an owning root separate from the referring root wired through
> delayed refs.
> 
> To use it for recording simple quota deltas, we need to wire this root
> id through from when we create the delayed ref until we fully process
> it. Store it in the generic btrfs_ref struct of the delayed ref.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c |  7 ++++---
>  fs/btrfs/delayed-ref.h | 13 +++++++++++--
>  fs/btrfs/extent-tree.c | 19 ++++++++++++-------
>  fs/btrfs/file.c        | 10 +++++-----
>  fs/btrfs/inode-item.c  |  2 +-
>  fs/btrfs/relocation.c  | 16 +++++++++-------
>  fs/btrfs/tree-log.c    |  3 ++-
>  7 files changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index f0bae1e1c455..49c320f2334b 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -840,7 +840,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
>  static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_delayed_ref_node *ref,
>  				    u64 bytenr, u64 num_bytes, u64 ref_root,
> -				    int action, u8 ref_type)
> +				    int action, u8 ref_type, u64 owning_root)
>  {
>  	u64 seq = 0;
>  
> @@ -857,6 +857,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
>  	ref->action = action;
>  	ref->seq = seq;
>  	ref->type = ref_type;
> +	ref->owning_root = owning_root;
>  	RB_CLEAR_NODE(&ref->ref_node);
>  	INIT_LIST_HEAD(&ref->add_list);
>  }
> @@ -915,7 +916,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  
>  	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
>  				generic_ref->tree_ref.ref_root, action,
> -				ref_type);
> +				ref_type, generic_ref->owning_root);
>  	ref->root = generic_ref->tree_ref.ref_root;
>  	ref->parent = parent;
>  	ref->level = level;
> @@ -989,7 +990,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  	else
>  	        ref_type = BTRFS_EXTENT_DATA_REF_KEY;
>  	init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
> -				ref_root, action, ref_type);
> +				ref_root, action, ref_type, ref_root);
>  	ref->root = ref_root;
>  	ref->parent = parent;
>  	ref->objectid = owner;
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index a71eff78469c..336c33c28191 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -32,6 +32,12 @@ struct btrfs_delayed_ref_node {
>  	/* seq number to keep track of insertion order */
>  	u64 seq;
>  
> +	/*
> +	 * root which originally allocated this extent and owns it for
> +	 * simple quota accounting purposes.
> +	 */
> +	u64 owning_root;
> +
>  	/* ref count on this data structure */
>  	refcount_t refs;
>  
> @@ -239,6 +245,7 @@ struct btrfs_ref {
>  #endif
>  	u64 bytenr;
>  	u64 len;
> +	u64 owning_root;
>  
>  	/* Bytenr of the parent tree block */
>  	u64 parent;
> @@ -278,16 +285,18 @@ static inline u64 btrfs_calc_delayed_ref_bytes(const struct btrfs_fs_info *fs_in
>  }
>  
>  static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
> -				int action, u64 bytenr, u64 len, u64 parent)
> +				int action, u64 bytenr, u64 len, u64 parent, u64 owning_root)
>  {
>  	generic_ref->action = action;
>  	generic_ref->bytenr = bytenr;
>  	generic_ref->len = len;
>  	generic_ref->parent = parent;
> +	generic_ref->owning_root = owning_root;
>  }
>  
>  static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
> -				int level, u64 root, u64 mod_root, bool skip_qgroup)
> +				int level, u64 root, u64 mod_root,
> +				bool skip_qgroup)
>  {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	/* If @real_root not set, use @root as fallback */
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 041f2eb153d7..fa53f7cbd84a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2410,7 +2410,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
>  			num_bytes = btrfs_file_extent_disk_num_bytes(buf, fi);
>  			key.offset -= btrfs_file_extent_offset(buf, fi);
>  			btrfs_init_generic_ref(&generic_ref, action, bytenr,
> -					       num_bytes, parent);
> +					       num_bytes, parent, ref_root);
>  			btrfs_init_data_ref(&generic_ref, ref_root, key.objectid,
>  					    key.offset, root->root_key.objectid,
>  					    for_reloc);
> @@ -2424,7 +2424,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
>  			bytenr = btrfs_node_blockptr(buf, i);
>  			num_bytes = fs_info->nodesize;
>  			btrfs_init_generic_ref(&generic_ref, action, bytenr,
> -					       num_bytes, parent);
> +					       num_bytes, parent, ref_root);
>  			btrfs_init_tree_ref(&generic_ref, level - 1, ref_root,
>  					    root->root_key.objectid, for_reloc);
>  			if (inc)
> @@ -3242,7 +3242,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  	int ret;
>  
>  	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
> -			       buf->start, buf->len, parent);
> +			       buf->start, buf->len, parent, btrfs_header_owner(buf));
>  	btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf),
>  			    root_id, 0, false);
>  
> @@ -4699,12 +4699,16 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  				     struct btrfs_key *ins)
>  {
>  	struct btrfs_ref generic_ref = { 0 };
> +	u64 root_objectid = root->root_key.objectid;
> +	u64 owning_root = root_objectid;
> +
> +	BUG_ON(root_objectid == BTRFS_TREE_LOG_OBJECTID);
>  

This is a duplicate check of what's checked below.  Also we don't want to add
new BUG_ON()'s, we want to add ASSERT()'s.  Thanks,

Josef
