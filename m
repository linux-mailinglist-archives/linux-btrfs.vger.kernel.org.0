Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8B516D64
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 11:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384221AbiEBJeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384264AbiEBJeD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 05:34:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8087AB1CE
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 02:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142E1B8136B
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0C4C385AC;
        Mon,  2 May 2022 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651483831;
        bh=REeP2Gyzx8WT2DYgc2T6XnjLWAYP2egqihFx749jPcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUJsnVA6XTRaaKjV3dw76g5IiOYCU+Fx8Ewm0xK3gceWH/qMk6gmxWleQZiskGmKg
         cyW8yok6YRq/xtlsNCB5my8X9Tg50TplVHGbDl40jSJEl9VymzQ+iGfjvBFDVWCVoy
         1P3xDNUF2BND+3nxiXm5ivlaKneRt5tmqQmgooz+5boibYqnHA2GsSDXjTr+y3E6bW
         nF3ceOldsyRznn49VyFkVz/T/OXl1q/n6qiQFKQM1P4+WQdnQIsbwkFAvFNfnkIDSD
         FvQLPRCwYHnK7fUfiNrd6rWt+lbWIM5IUtQ+UYsanQp4kz4W3asngN6t4M2dorhLgB
         oz/rHAwOrjvZw==
Date:   Mon, 2 May 2022 10:30:28 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: improve error reporting in
 lookup_inline_extent_backref
Message-ID: <Ym+ktE6Yrefhr39v@debian9.Home>
References: <20220429141734.866132-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429141734.866132-1-nborisov@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 05:17:34PM +0300, Nikolay Borisov wrote:
> When iterating the backrefs in an extent item if the ptr to the
> 'current' backref record goes beyond the extent item a warning is
> generated and -ENOENT is returned. However what's more appropriate to
> debug such cases would be to return EUCLEAN and also print identifying
> information about the performed search as well as the current content of
> the leaf containing the possibly corrupted extent item.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> 
> V5:
>  * Stop printing the key we are searching for as it was both wrong and redundant,
>  since we have the slot number printed anyway. (Filipe)
> 
> V4:
>  * Also print the value of 'parent' as it's pertinent when metadata inline backrefs
>  are being searched (Filipe)
>  * Print the leaf before printing the error message so that the latter is
>  not lost (Filipe)
> 
> V3:
>  * Fixed format for the btree slot
>  * Removed redundant argument passed to format string
> 
>  fs/btrfs/extent-tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 963160a0c393..cca89016f2b3 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -895,7 +895,14 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>  	err = -ENOENT;
>  	while (1) {
>  		if (ptr >= end) {
> -			WARN_ON(ptr > end);
> +			if (ptr > end) {
> +				err = -EUCLEAN;
> +				btrfs_print_leaf(path->nodes[0]);
> +				btrfs_crit(fs_info,
> +"overrun extent record at slot %d while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
> +				path->slots[0], root_objectid, owner, offset,
> +				parent);
> +			}
>  			break;
>  		}
>  		iref = (struct btrfs_extent_inline_ref *)ptr;
> --
> 2.25.1
> 
