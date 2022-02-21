Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7B4BE919
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358151AbiBUMle (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 07:41:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358148AbiBUMld (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 07:41:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A0B1929D
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 04:41:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 088FFB80D3E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Feb 2022 12:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18DC340E9;
        Mon, 21 Feb 2022 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645447267;
        bh=pX1ff/cN6LIbZdm174lh4gUopIJSBqx8liP0wC6cZxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbUz2qkvVHNU2xeoJgDJtFs2GGgR5ucP2zi4V/S0Y0Hx/3nXcbQpPU1p7wtZUTUUE
         jonTU+USX4wn6Tt4veXMlx05V+ssjlSYECkqdEx7Kok0gOTyVt2hfA9R38EE4dFYzV
         zOBee0gSpuxV90EaBQkXt94eYFo4AnTy38CJJFeTZrSB1o3T1XMG4gXb+FMfZXBaff
         G3SISlCEO1SkXCQhYAbjgpfgEb8PHhCkkVgm8UvaQdfiU1lpa5Q24lGrHSfuSQnXLW
         ULOuTrsNZs/LWFXgQ3j3eFWWCjOf4u3eduSq7nlLq0VkyM31cEAJY1CPhuc52wwptG
         f3PtdtlEYiBaQ==
Date:   Mon, 21 Feb 2022 12:41:04 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] btrfs: pass btrfs_fs_info to
 btrfs_recover_relocation
Message-ID: <YhOIYIwTVKbTPfrN@debian9.Home>
References: <cover.1645214059.git.josef@toxicpanda.com>
 <3aaba7fc1861004693fdc02ca5df300cd6773273.1645214059.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aaba7fc1861004693fdc02ca5df300cd6773273.1645214059.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 02:56:12PM -0500, Josef Bacik wrote:
> We don't need a root here, we just need the btrfs_fs_info, we can just
> get the specific roots we need from fs_info.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
>  fs/btrfs/ctree.h      | 2 +-
>  fs/btrfs/disk-io.c    | 2 +-
>  fs/btrfs/relocation.c | 5 ++---
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1e238748dc73..ca411a42bccf 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3845,7 +3845,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
>  			  struct btrfs_root *root);
>  int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
>  			    struct btrfs_root *root);
> -int btrfs_recover_relocation(struct btrfs_root *root);
> +int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
>  int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
>  int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
>  			  struct btrfs_root *root, struct extent_buffer *buf,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 183baeffd9c9..6a0b4dbd70e9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3379,7 +3379,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>  	up_read(&fs_info->cleanup_work_sem);
>  
>  	mutex_lock(&fs_info->cleaner_mutex);
> -	ret = btrfs_recover_relocation(fs_info->tree_root);
> +	ret = btrfs_recover_relocation(fs_info);
>  	mutex_unlock(&fs_info->cleaner_mutex);
>  	if (ret < 0) {
>  		btrfs_warn(fs_info, "failed to recover relocation: %d", ret);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f528c5283f25..7dc6f29a6094 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4124,9 +4124,8 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
>   * this function resumes merging reloc trees with corresponding fs trees.
>   * this is important for keeping the sharing of tree blocks
>   */
> -int btrfs_recover_relocation(struct btrfs_root *root)
> +int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_fs_info *fs_info = root->fs_info;
>  	LIST_HEAD(reloc_roots);
>  	struct btrfs_key key;
>  	struct btrfs_root *fs_root;
> @@ -4167,7 +4166,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>  		    key.type != BTRFS_ROOT_ITEM_KEY)
>  			break;
>  
> -		reloc_root = btrfs_read_tree_root(root, &key);
> +		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
>  		if (IS_ERR(reloc_root)) {
>  			err = PTR_ERR(reloc_root);
>  			goto out;
> -- 
> 2.26.3
> 
