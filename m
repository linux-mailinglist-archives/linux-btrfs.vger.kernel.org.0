Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF3853FE9B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 14:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiFGMVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 08:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiFGMUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 08:20:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522FF689A
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 05:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8081B81F6F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 12:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2902EC385A5;
        Tue,  7 Jun 2022 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654604336;
        bh=ejJwEddXdd4zptBxGGv828EnKRF+PZXIbxp6iI7ady0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRGwoGn7NWPe6cDEWYBpPhmQtinjerkgyTtSGwHP8hqLfeBDL11ZFXh0qBAvfWvbF
         whsBop24MARA4hBQIQ+Ray7wTxy/6V2npxBmtR5PN/KB928uwYqzNJDp7zTgJeHb73
         toxhb2KVtPM+msJqpW1M4VXGpB/SafFbY/RiU99cbaMfi3toSXErPJEQtSYLlrFzUd
         EjOYJ6VxZM7zaUfJSCXZEcdebbmCNfYPtbiRSISBJFAtGioYKnoXOJTn2GEecd/w0x
         Q/L0Laa961fesOjKWLC3+E/wWHg/A10H1CkK5zhM/xiSXekaLZAI+1AzGL/Ja+D0n3
         HuGncPMDumg5A==
Date:   Tue, 7 Jun 2022 13:18:53 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: make btrfs_super_block::log_root_transid
 deprecated
Message-ID: <20220607121853.GA3568258@falcondesktop>
References: <d271efe6a00ed1b8de9150e96399636dedd38e3c.1654602650.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d271efe6a00ed1b8de9150e96399636dedd38e3c.1654602650.git.wqu@suse.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 07:50:59PM +0800, Qu Wenruo wrote:
> When using "btrfs inspect-internal dump-super" to inspect an fs with
> dirty log, it always shows the log_root_transid as 0:
> 
>  log_root                30474240
>  log_root_transid        0 <<<
>  log_root_level          0
> 
> It turns out that, btrfs_super_block::log_root_transid is never really
> utilized (even no read for it).
> 
> This can date back to the introduction of btrfs into upstream kernel.
> 
> In fact, when reading log tree root, we always use
> btrfs_super_block::generation + 1 as the expected generation.
> So here we're completely safe to mark this member deprecated.
> 
> In theory we can easily reuse this member for other purposes, but to be
> extra safe, here we follow the leafsize way, by adding "__unused_" for
> log_root_transid.
> And we can safely remove the accessors, since there is no such callers
> from the very beginning.
> 
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0e49b1a0c071..71ba3b9fd8c2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -248,8 +248,13 @@ struct btrfs_super_block {
>  	__le64 chunk_root;
>  	__le64 log_root;
>  
> -	/* this will help find the new super based on the log root */
> -	__le64 log_root_transid;
> +	/*
> +	 * This member is never utlized from the very beginning of btrfs, thus

utlized -> utilized (or used)

> +	 * it's always 0 no matter kernel versions.

no matter kernel versions -> no matter which kernel version

Other than that, it looks fine.
Thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +	 * We always use generation + 1 to read log tree root.
> +	 * So here we mark it deprecated.
> +	 */
> +	__le64 __unused_log_root_transid;
>  	__le64 total_bytes;
>  	__le64 bytes_used;
>  	__le64 root_dir_objectid;
> @@ -2475,8 +2480,6 @@ BTRFS_SETGET_STACK_FUNCS(super_chunk_root_level, struct btrfs_super_block,
>  			 chunk_root_level, 8);
>  BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
>  			 log_root, 64);
> -BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
> -			 log_root_transid, 64);
>  BTRFS_SETGET_STACK_FUNCS(super_log_root_level, struct btrfs_super_block,
>  			 log_root_level, 8);
>  BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
> -- 
> 2.36.1
> 
