Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043E5B9F0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIOPlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIOPk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 11:40:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BABB754BF
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:40:57 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o7so9826747qkj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KoEQjBRa83fNF/FurfdurdKlgPlEdx3aej46pfLP4Ok=;
        b=ZVKfxm6AfLrQTUaMly0HeJe84vK8+gPgdAUggUyFVuhXSdI/PsVFevOosqtSJk2Et8
         sxrvQUbsioJ+7zfYA0Y8w00DiPAtfHK4ZPAgDeX/+JXktKlp8s4uB5tITpFBZt9dUZFH
         0EqZMvQmSFyWgHuu/GIIyX74AYFBfSdEp63xBaW8by8Ym3UF/m3w7tFw/4SgLJnhK+Z8
         hhnn78w3WFtIoGOxBY1U9cNs3pgy2sDkQ/kFv21qevnXDav5/hxt0UPX1Ubp5zB7tuvH
         kdpH/QvYwqh5zrMFpzpUhSRyN8Df3gLjL2gZwylcQP71QPJ10THwZjOwu9EsQfJ2wOiL
         MeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KoEQjBRa83fNF/FurfdurdKlgPlEdx3aej46pfLP4Ok=;
        b=DWYcfnBlAK77TNZ8USpEuoKtXQ8NX2mOkb1HQEDm4OsmR7RfbhwCYcqFjUtmvMeOM5
         6ht2/Go5ymM0CR4Ga7sxMcRfYKebNvG97GBYiG6tWjQe+gHTlYyWzWsy5j5Y8t0FHIyj
         5iOLehkQ9MggFVFvUC457wqbo2iyltlQuB8Jzt+UAtjbBoSP4eq/YBOLToPYBVC2dfU0
         CNFbIclCJ8W6JIwbJ96N6EOUPyrdytOVofJFDq2mlmW6Tkbevprv0HWhf17VwLwwUz3B
         FD6PJsCBzlAKvNW2Coe9MCn48M/CLCAOoiz/gvfxpLAQF7jMrGk8gQNLBUpS3YUWTG8b
         jurw==
X-Gm-Message-State: ACrzQf2IUbMF3fo05jBREzTUIOpYruMbxNtOA/K5qfETk3NCDPYmkxDN
        ZZxclL8/OMyyJAkqUXkq0HtcnpQLtQOydA==
X-Google-Smtp-Source: AMsMyM7hPxd2vHXLYLNNvezscYTS6Bhb3xyMApwg9nJvMA0R1fqzHRFyGN7kKFeK1cCoS1fhXjoP/w==
X-Received: by 2002:ae9:e207:0:b0:6cd:b864:11e5 with SMTP id c7-20020ae9e207000000b006cdb86411e5mr506811qkc.295.1663256456571;
        Thu, 15 Sep 2022 08:40:56 -0700 (PDT)
Received: from localhost ([2600:380:a345:f4dd:7e40:406:9902:14d7])
        by smtp.gmail.com with ESMTPSA id i19-20020ac85e53000000b0035badb499c7sm3993233qtx.21.2022.09.15.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 08:40:55 -0700 (PDT)
Date:   Thu, 15 Sep 2022 11:40:53 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: refactor the inline extent read code inside
 btrfs_get_extent()
Message-ID: <YyNHhayadq+RyH+w@localhost.localdomain>
References: <cover.1663229903.git.wqu@suse.com>
 <dc726a7d458d3100602b3507cbf2a236ac47ff55.1663229903.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc726a7d458d3100602b3507cbf2a236ac47ff55.1663229903.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 04:22:51PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> In btrfs_get_extent() we can fill the inline extent directly.
> 
> But there are something not that straightforward for the functionality:
> 
> - It's behind two levels of indent
> 
> - It has a weird reset for extent map values
>   This includes resetting:
>   * em->start
> 
>     This makes no sense, as our current tree-checker ensures that
>     inline extent can only at file offset 0.
> 
>     This means not only the @extent_start (key.offset) is always 0,
>     but also @pg_offset and @extent_offset should also be 0.
> 
>   * em->len
> 
>     In btrfs_extent_item_to_extent_map(), we already initialize em->len
>     to "btrfs_file_extent_end() - extent_start".
>     Since @extent_start can only be 0 for inline extents, and
>     btrfs_file_extent_end() is already doing ALIGN() (which is rounding
>     up).
> 
>     So em->len is always sector_size for inlined extent now.
> 
>   * em->orig_block_len/orig_start
> 
>     They doesn't make much sense for inlined extent anyway.
> 
> - Extra complex calculation for inline extent read
> 
>   This is mostly caused by the fact it's still assuming we can have
>   inline file extents at non-zero file offset.
> 
>   Such offset calculation is now a dead code which we will never reach,
>   just damaging the readability.
> 
> - We have an extra bool for btrfs_extent_item_to_extent_map()
> 
>   Which is making no difference for now.
> 
> [ENHANCEMENT]
> This patch will enhance the behavior by:
> 
> - Extract the read code into a new helper, read_inline_extent()
> 
> - Much simpler calculation for inline extent read
> 
> - Don't touch extent map when reading inline extents
> 
> - Remove the bool argument from btrfs_extent_item_to_extent_map()
> 
> - New ASSERT()s to ensure inline extents only start at file offset 0
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h     |  1 -
>  fs/btrfs/file-item.c |  6 +--
>  fs/btrfs/inode.c     | 93 +++++++++++++++++++++++++-------------------
>  fs/btrfs/ioctl.c     |  2 +-
>  4 files changed, 57 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 05df502c3c9d..e8ce86516ec8 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3356,7 +3356,6 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>  void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
>  				     const struct btrfs_path *path,
>  				     struct btrfs_file_extent_item *fi,
> -				     const bool new_inline,
>  				     struct extent_map *em);
>  int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 start,
>  					u64 len);
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 29999686d234..d9c3b58b63bf 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -1196,7 +1196,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>  void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
>  				     const struct btrfs_path *path,
>  				     struct btrfs_file_extent_item *fi,
> -				     const bool new_inline,
>  				     struct extent_map *em)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> @@ -1248,10 +1247,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
>  		 */
>  		em->orig_start = EXTENT_MAP_HOLE;
>  		em->block_len = (u64)-1;
> -		if (!new_inline && compress_type != BTRFS_COMPRESS_NONE) {
> +		em->compress_type = compress_type;
> +		if (em->compress_type != BTRFS_COMPRESS_NONE)
>  			set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
> -			em->compress_type = compress_type;
> -		}

I spent most of my time reviewing this patch trying to decide if this mattered
or not, why it was introduced in the first place, and if it was ok to change.
Additionally it's not related to the bulk of the change which is making the
btrfs_get_extent thing cleaner.

So break this out into it's own patch, with a detailed explanation of why this
particular change is ok.  In fact I'd prefer if you made all changes to how we
mess with the em their own changes, since bugs here can be super subtle, I'd
rather have more discreete areas to bisect to.  Thanks,

Josef
