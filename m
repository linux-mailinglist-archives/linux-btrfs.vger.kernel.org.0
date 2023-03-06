Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DEF6ACD99
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 20:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCFTKN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 14:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFTKL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 14:10:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE14AFD6
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 11:10:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF1DC1FDF2;
        Mon,  6 Mar 2023 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678129805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGT1M1OJsUfANKs5sDcyJOWcX6Nft27mMLav7D8c82Y=;
        b=pm1x+uKBy+6aoLYe915dMGx+TdOqKY+5+oolRKqNVMpLjqMK8ZnHrL24QgbL/93OnOSmX3
        W3WPPapp1pMzTGHhs52nd6gXZd4jKjFMbbxk4AzuvlqGS8PlwDGgLFV2yPmPVN6+pj4LFv
        PJ6GSKaWy6l7T0XUWrWm/fHe3co2uuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678129805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGT1M1OJsUfANKs5sDcyJOWcX6Nft27mMLav7D8c82Y=;
        b=BNqMO+f7eLrsAo/oWprM53JpdxQpo2Uxr2e1R4P0obl4/gBW2GIPvv1AZdte8fXVtMI75d
        6wWTbcCoGxVWqoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A165B13A66;
        Mon,  6 Mar 2023 19:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8diVJo06BmQaKQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 06 Mar 2023 19:10:05 +0000
Date:   Mon, 6 Mar 2023 20:04:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
Message-ID: <20230306190403.GG10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 09:54:12AM +0800, Qu Wenruo wrote:
> [BUG]
> During my scrub rework, I did a stupid thing like this:
> 
>         bio->bi_iter.bi_sector = stripe->logical;
>         btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
> 
> Above bi_sector assignment is using logical address directly, which
> lacks ">> SECTOR_SHIFT".
> 
> This results a read on a range which has no chunk mapping.
> 
> This results the following crash:
> 
>  BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>  assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>  ------------[ cut here ]------------
> 
> Sure this is all my fault, but this shows a possible problem in real
> world, that some bitflip in file extents/tree block can point to
> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
> is not configured, cause invalid pointer.
> 
> [PROBLEMS]
> In above call chain, we just don't handle the possible error from
> btrfs_get_chunk_map() inside __btrfs_map_block().
> 
> [FIX]
> The fix is pretty straightforward, just replace the ASSERT() with proper
> error handling.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
