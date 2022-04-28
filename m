Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27BA5137EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiD1PTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiD1PTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:19:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9DAF1E6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F44B82D65
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 15:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A62CC385A0;
        Thu, 28 Apr 2022 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158978;
        bh=mxI11hFH2cQno6uWnR/2eff89Z2hAPuwnBw34AjrZtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekvC0jS3sZx58GIdg2RtiryCc3UYhfMLRF0brlMJOcFS4HUio+FFxVK6U7xdR4Lq0
         ctNyOU2BZsJf6OniVcctgRuggswNDBem+hGfwr8qq+AiQvEGjzWKkYrq4UbT4u1wTo
         1WhiSyH6dXmfRbDlWzC6alAGAAs0WNlu1aNYvbhraaHs/tC4l8v63PqP2o2JKtmfAy
         z2uTOtshZN8D8RmxlG7CG5JVtYZEQxlMhqtWUlzkrb6LuB64ieX40te2agYz4+xsIj
         5kRuyDjgWv3iqQKF61Iv2sxY88h97eYa8IRbcGDl/0Zmcx+HKMvQsZldmULIyYbsUX
         Rhwm91tZWN+MQ==
Date:   Thu, 28 Apr 2022 16:16:14 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: improve error reporting in
 lookup_inline_extent_backref
Message-ID: <YmqvviNRmr+N8NFJ@debian9.Home>
References: <20220428131449.792353-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428131449.792353-1-nborisov@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 04:14:49PM +0300, Nikolay Borisov wrote:
> When iterating the backrefs in an extent item if the ptr to the
> 'current' backref record goes beyond the extent item a warning is
> generated and -ENOENT is returned. However what's more appropriate to
> debug such cases would be to return EUCLEAN and also print identifying
> information about the performed search as well as the current content of
> the leaf containing the possibly corrupted extent item.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
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
> index 963160a0c393..cae2ef560f3f 100644
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
> +"overrun extent record at slot %d [%llu BTRFS_EXTENT_ITEM_KEY %llu] while looking for inline extent for root %llu owner %llu offset %llu parent %llu",
> +				path->slots[0], bytenr, num_bytes,

The key being printed is misleading, as it will often be incorrect.

First the type is not always BTRFS_EXTENT_ITEM_KEY, it can also be
BTRFS_METADATA_ITEM_KEY.

Secondly, the offset's value is not always 'num_bytes', it can also be 'owner'.

So it's better to just print the key as "%llu %u %llu" and using key.objectid,
key.type and key.offset. Or just leave the key from the message since we have
printed the slot, and therefore it's redundant. Either option is fine for me.

Sorry, I missed this before and I hate to have to make you send another version.

With that fixed,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +				root_objectid, owner, offset, parent);
> +			}
>  			break;
>  		}
>  		iref = (struct btrfs_extent_inline_ref *)ptr;
> --
> 2.25.1
> 
