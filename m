Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153E4F84B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbiDGQSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbiDGQSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 12:18:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A11E6F84
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 09:16:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B93501F85A;
        Thu,  7 Apr 2022 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649348174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCrpc+ySwryDYNrXrM21WZslLldWyY8gwlFlJhIeGe8=;
        b=F3CR7CxszOYrziWAleG5jFWb2hOu1+Y+4z9esKQMDNkCiV6TZ4C3EaDtV9czcwML6KknN4
        PIMKhC2hmlZc03aUFjkCPKnKoyKSqBElEbzJ98cK2mG1lhs6r7UANbMbWi8r9QD20fVZZW
        GZw5ZPLLtqlCVc7WlwthXxIi+0y+Uck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649348174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCrpc+ySwryDYNrXrM21WZslLldWyY8gwlFlJhIeGe8=;
        b=EO8wS2th0XJkCtYiyD/YXQxqrLu8dkh1KPiwllHj9ad4SGqy38c3nT3bR/eqmaoDSEfMc4
        a+nT5HX0S3hRlyAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B1496A3B96;
        Thu,  7 Apr 2022 16:16:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BB22DA80E; Thu,  7 Apr 2022 18:12:11 +0200 (CEST)
Date:   Thu, 7 Apr 2022 18:12:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 1/6] Turn delayed_nodes_tree into delayed_nodes_xarray in
 btrfs_root
Message-ID: <20220407161211.GN15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20220407153855.21089-1-gniebler@suse.com>
 <20220407153855.21089-2-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407153855.21089-2-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 07, 2022 at 05:38:49PM +0200, Gabriel Niebler wrote:
> … but don't use the XArray API yet.
> 
> This works, since the radix_tree_root struct has already been turned into an xarray behind the scenes, via a macro.

Please align the text to 74 chars.

> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>  fs/btrfs/ctree.h         | 4 ++--
>  fs/btrfs/delayed-inode.c | 8 ++++----
>  fs/btrfs/disk-io.c       | 2 +-
>  fs/btrfs/inode.c         | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b7631b88426e..ccd42a1638b1 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1224,10 +1224,10 @@ struct btrfs_root {
>  	struct rb_root inode_tree;
>  
>  	/*
> -	 * radix tree that keeps track of delayed nodes of every inode,
> +	 * XArray that keeps track of delayed nodes of every inode,
>  	 * protected by inode_lock
>  	 */
> -	struct radix_tree_root delayed_nodes_tree;
> +	struct xarray delayed_nodes_xarray;

I'd rather not rename the variable, it's an implementation detail and
maybe dropping the _tree completely is a better idea.
