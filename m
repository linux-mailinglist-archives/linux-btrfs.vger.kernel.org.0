Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C834A9870
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358410AbiBDLcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 06:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiBDLcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 06:32:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F54C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 03:31:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 309C1B836EA
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 11:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D22FC004E1;
        Fri,  4 Feb 2022 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643974317;
        bh=fAmoLN1kvLEB6G3HHg71LGWkNY8E6lviK+rHNEHARwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPway76NOY0YXI81sSp/gD9JNUB8hR3P/CohKEc7Q22Lj2JDBAuct3nOqbfsf0r4j
         n4DFZkupB2xsFphLvqginL9r93q28l/gElbwXPelbi6EprjhjrBonz/kDzgx4Hqdz5
         P0efSjMgW4F8CYxBVJvCWIZVNSfrvQKJHPMPEdUTm7CkWEH23XKLJmQR3xq9ET1Vx+
         qnNJ/OzdlnJhwG527xiZHJ5Z9IuzNL1g7Vb1wsCa6GriUNf1PiR4XguulOwlqanahk
         2SfvOdC1LuOR7I5jnDu3DqOJqJkkFHFWVfN+bcYLHGRtHABlUEgnNR7EiPsXqEw5N0
         pUBrpIJ+1BjDg==
Date:   Fri, 4 Feb 2022 11:31:54 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] btrfs: store details about first setget bounds check
 failure
Message-ID: <Yf0OqgnMCFNmNkbl@debian9.Home>
References: <cover.1643904960.git.dsterba@suse.com>
 <79c2eac1b0c7f0a1769bbe9b9ee4ca8b23ef0132.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c2eac1b0c7f0a1769bbe9b9ee4ca8b23ef0132.1643904960.git.dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 03, 2022 at 06:26:29PM +0100, David Sterba wrote:
> The way the setget helpers are used makes it hard to return an error
> code at the call site, as this would require to clutter a lot of code
> with potential failures that are expected to be rare.
> 
> Instead, do a delayed reporting, tracked by a filesystem-wide bit that
> synchronizes potential races in the reporting function that records only
> the first event. To give a bit more insight into the scale, count the
> total number of events.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h        | 16 ++++++++++++++--
>  fs/btrfs/struct-funcs.c | 12 ++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 9f7a950b8a69..5d12a80d09f5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -127,6 +127,13 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
>  enum {
>  	/* Global indicator of serious filesystem errors */
>  	BTRFS_FS_STATE_ERROR,
> +	/* Track if a transaction abort has been reported on this filesystem */
> +	BTRFS_FS_STATE_TRANS_ABORTED,
> +	/*
> +	 * There was a failed bounds check in check_setget_bounds, set this on
> +	 * first event.
> +	 */
> +	BTRFS_FS_SETGET_COMPLAINS,
>  	/*
>  	 * Filesystem is being remounted, allow to skip some operations, like
>  	 * defrag
> @@ -134,8 +141,6 @@ enum {
>  	BTRFS_FS_STATE_REMOUNTING,
>  	/* Filesystem in RO mode */
>  	BTRFS_FS_STATE_RO,
> -	/* Track if a transaction abort has been reported on this filesystem */
> -	BTRFS_FS_STATE_TRANS_ABORTED,
>  	/*
>  	 * Bio operations should be blocked on this filesystem because a source
>  	 * or target device is being destroyed as part of a device replace
> @@ -1060,6 +1065,13 @@ struct btrfs_fs_info {
>  	spinlock_t zone_active_bgs_lock;
>  	struct list_head zone_active_bgs;
>  
> +	/* Store details about the first bounds check failure in report_setget_bounds */
> +	u64 setget_eb_start;
> +	const void *setget_ptr;
> +	unsigned setget_off;
> +	int setget_size;
> +	atomic_t setget_failures;
> +
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	spinlock_t ref_verify_lock;
>  	struct rb_root block_tree;
> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
> index c97c69e29d64..28b9e62cdc86 100644
> --- a/fs/btrfs/struct-funcs.c
> +++ b/fs/btrfs/struct-funcs.c
> @@ -11,11 +11,23 @@ static void report_setget_bounds(const struct extent_buffer *eb,
>  				 const void *ptr, unsigned off, int size)
>  {
>  	const unsigned long member_offset = (unsigned long)ptr + off;
> +	struct btrfs_fs_info *fs_info;
>  
>  	btrfs_err_rl(eb->fs_info,
>  		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
>  		(member_offset > eb->len ? "start" : "end"),
>  		(unsigned long)ptr, eb->start, member_offset, size);
> +
> +	/* Count events and record more details about the first one */
> +	fs_info = eb->fs_info;
> +	atomic_inc(&fs_info->setget_failures);
> +	if (test_and_set_bit(BTRFS_FS_SETGET_COMPLAINS, &eb->fs_info->flags))
> +		return;
> +
> +	fs_info->setget_eb_start = eb->start;
> +	fs_info->setget_ptr = ptr;
> +	fs_info->setget_off = member_offset;
> +	fs_info->setget_size = size;

These new fields at fs_info are set here, but then never read, neither in this
patch nor in the remaining of this patchset.

Do you plan to use them somewhere else? If not, it seems they could go away.

Thanks.

>  }
>  
>  static inline bool check_setget_bounds(const struct extent_buffer *eb,
> -- 
> 2.34.1
> 
