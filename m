Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333364D9A90
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348002AbiCOLq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347999AbiCOLqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:46:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421450063
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 04:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22ED2CE1A43
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E69C340E8;
        Tue, 15 Mar 2022 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647344709;
        bh=2Maieef/Tph1rKTjynrt+F18fnhqgwi5bNZdnFzOZpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDOY4HEWGh938IaSxuWB1yyAULtJGuJJ59dDd1AWRf3AguwXtZhgN8+wBznPHJQ5j
         J8Z0/st2AD87e5RMraxRBzRpuw2IiX6Rc3ZB3tfVPO7LcUDGn5Zujb+OAehgRnNV2d
         SWuTtcpAeS1esBgbOxj1qbZNFdDezQu1lbxfH+HdTyfxgi+ATrEXXTppbKeTP3xTY1
         QM/bTpiM87ftuCjZyQGgwm2EmOgswhnOVbnMlTYtGqjhuLvZ6Z07/8wxTCaCMn3Yl+
         ZBO2huWaQZpUKJu2rt9lbTqkpjG8GG5PivXHXd2L75QU6UPzN+EW/3W48GXoz946bt
         yF6QFP0NkygAA==
Date:   Tue, 15 Mar 2022 11:45:05 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make enough noise for fstests to catch extent
 buffer leakage
Message-ID: <YjB8QWiskKVANQ7j@debian9.Home>
References: <e29bd3f7a0b167cc6d7a6e40f8b3b62b88a64fc3.1647338477.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e29bd3f7a0b167cc6d7a6e40f8b3b62b88a64fc3.1647338477.git.wqu@suse.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 06:01:33PM +0800, Qu Wenruo wrote:
> Although we have btrfs_extent_buffer_leak_debug_check() (enabled by
> CONFIG_BTRFS_DEBUG option) to detect and warn QA testers that we have
> some extent buffer leakage, it's just pr_err(), not noisy enough for
> fstests to cache.
> 
> So here we trigger a WARN_ON_ONCE() if the allocated_ebs list is not
> empty.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 78486bbd1ac9..593eafc30261 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -76,6 +76,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
>  		return;
>  
>  	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
> +	WARN_ON_ONCE(!list_empty(&fs_info->allocated_ebs));

I would make it WARN_ON(), so that it's less likely to get unnoticed.

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>  	while (!list_empty(&fs_info->allocated_ebs)) {
>  		eb = list_first_entry(&fs_info->allocated_ebs,
>  				      struct extent_buffer, leak_list);
> -- 
> 2.35.1
> 
