Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226AD4CAE03
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiCBTBa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 14:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiCBTB3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 14:01:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D979936E37
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 11:00:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21E911F44D;
        Wed,  2 Mar 2022 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646247644;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxbst+egQ+4cTd1SUUrkxSdc1PKVv5oMpVAPccwlufs=;
        b=D8fdV7YYkVxSik/lWB+eQ8Y06cPmgvXYnOKFNIWstkfzeLUYzgOI0jYhVbQZkbkh6cQvL4
        IjpFJxXq7yc0nh1M2SHWq7NnVAo0AtyOpjHQ9tseIex/ClvXcC1I9pYjkNhN7M+F8ULffI
        BijhfBkiZCyXIDS5mhf6oO3FvaIl69k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646247644;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rxbst+egQ+4cTd1SUUrkxSdc1PKVv5oMpVAPccwlufs=;
        b=acNIVBug4r/dvjelSbZXqwK1YMc0v3BGqPVu+wpXhBPPzF0jZ4d2CMkO+Ot3IRIab1Ulxs
        EYkfpUrNPqG+v5CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1A272A3B83;
        Wed,  2 Mar 2022 19:00:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F87FDA80E; Wed,  2 Mar 2022 19:56:51 +0100 (CET)
Date:   Wed, 2 Mar 2022 19:56:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Christoph Anton Mitterer <calestyo@scientia.org>
Subject: Re: [PATCH] btrfs: verify the tranisd of the to-be-written dirty
 extent buffer
Message-ID: <20220302185651.GU12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Christoph Anton Mitterer <calestyo@scientia.org>
References: <1f011e6358e042e5ae1501e88377267a2a95c09d.1646183319.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f011e6358e042e5ae1501e88377267a2a95c09d.1646183319.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 09:10:21AM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a bitflip in the transid part of an extent
> buffer makes btrfs to reject certain tree blocks:
> 
>   BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
> 
> [CAUSE]
> Note the failed transid check, hex(262166) = 0x40016, while
> hex(22) = 0x16.
> 
> It's an obvious bitflip.

Oh, quite. I think I've seen only bits flipped from 0 -> 1, this case is
an interesting evidence.

> Furthermore, the reporter also confirmed the bitflip is from the
> hardware, so it's a real hardware caused bitflip, and such problem can
> not be detected by the existing tree-checker framework.
> 
> As tree-checker can only verify the content inside one tree block, while
> generation of a tree block can only be verified against its parent.
> 
> So such problem remain undetected.
> 
> [FIX]
> Although tree-checker can not verify it at write-time, we still have a
> quick (but not the most accurate) way to catch such obvious corruption.
> 
> Function csum_one_extent_buffer() is called before we submit metadata
> write.
> 
> Thus it means, all the extent buffer passed in should be dirty tree
> blocks, and should be newer than last committed transaction.
> 
> Using that we can catch the above bitflip.
> 
> Although it's not a perfect solution, as if the corrupted generation is
> higher than the correct value, we have no way to catch it at all.
> 
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Link: https://lore.kernel.org/linux-btrfs/2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -441,17 +441,31 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
>  	else
>  		ret = btrfs_check_leaf_full(eb);
>  
> -	if (ret < 0) {
> -		btrfs_print_tree(eb, 0);
> +	if (ret < 0)
> +		goto error;
> +
> +	/*
> +	 * Also check the generation, the eb reached here must be newer than
> +	 * last committed. Or something seriously wrong happened.
> +	 */
> +	if (btrfs_header_generation(eb) <= fs_info->last_trans_committed) {

For any cases in regular code that leads to EUCLEAN you can use
unlikely() annotation.
