Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC285511789
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiD0MSM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiD0MSL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 08:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C9694B8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 05:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3722619E9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 12:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD252C385A7;
        Wed, 27 Apr 2022 12:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651061700;
        bh=IEQi51P9LiZBip1bmUIExGkY5ZzFTv8V4m4+Exrli8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUcvKGtGBjJlZRd+B291LIdCIlHejnO917bkDTxk611rqhyGMe/aCP/CCrkD9GQ6l
         53Rop5QozJeUzdcpp5pLQbLjgZOimC2QNeNd01qXAcbqwdo2ZVgdcmCZt00v6952eR
         aRDEAIYJ2vuuuoRPpbUF6Kay8B7DgfiUHqi4j1KRbMwgUQcA3MryDJnxfZ0No58w/6
         vRmlJaqOyO1wrwQWzFiJ1y0B3nhDS+mMxAy/HHUbBFzkvluwsJP68Q437dxV1pOTCa
         zQ5B5Z+UXpmuEo1hiw8yOR8gIZa/XFhYCC1gHD9cl4HeSeoz8U3DJs6jwTmLTunPFG
         vYHvZCAW+tsWQ==
Date:   Wed, 27 Apr 2022 13:14:56 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: improve error reporting in
 lookup_inline_extent_backref
Message-ID: <YmkzwFQHmv1etu9z@debian9.Home>
References: <20220427100344.700330-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427100344.700330-1-nborisov@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 01:03:44PM +0300, Nikolay Borisov wrote:
> When iterating the backrefs in an extent item if the ptr to the
> 'current' backref record goes beyond the extent item a warning is
> generated and -ENOENT is returned. However what's more appropriate to
> debug such cases would be to return EUCLEAN and also print identifying
> information about the performed search as well as the current content of
> the leaf containing the possibly corrupted extent item.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> V2:
>  * Removed WARN_ON and instead introduced btrfs_crit as an error printing
>  mechanism
>  * Now prints a proper error message with information about the searched reference
>  fs/btrfs/extent-tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 963160a0c393..5e29c2cee46e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -895,7 +895,14 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>  	err = -ENOENT;
>  	while (1) {
>  		if (ptr >= end) {
> -			WARN_ON(ptr > end);
> +			if (ptr > end) {
> +				err = -EUCLEAN;
> +				btrfs_crit(fs_info,
> +"overrun extent record at slot %lu [%llu BTRFS_EXTENT_ITEM_KEY %llu] while looking for inline extent for root %llu owner %llu offset %llu",
> +				path->slots[0], bytenr, num_bytes,
> +				root_objectid, root_objectid, owner, offset);

Printing 'parent' is also needed in order to figure out what type of reference
we were looking for.

Also, %d can be used to print the slot, as path->slots is an int array.

> +				btrfs_print_leaf(path->nodes[0]);

The leaf should be dumped before printing the message, see:

https://btrfs.wiki.kernel.org/index.php/Development_notes#Output

Other than that, it looks fine.

Thanks.

> +			}
>  			break;
>  		}
>  		iref = (struct btrfs_extent_inline_ref *)ptr;
> --
> 2.25.1
> 
