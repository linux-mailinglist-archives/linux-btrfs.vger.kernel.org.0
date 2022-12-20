Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99037652722
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 20:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiLTTh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 14:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTThz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 14:37:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399310D1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 11:37:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A8C822269;
        Tue, 20 Dec 2022 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671565072;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=veAxSf12DNG47jR5jayL1YoDivvUiMHtPGyXEa2HYJw=;
        b=Y896nygQ7OIgbU16tEijZwVWYLckxMGp/XncYSEq15YY3uFAj2qXYuQnFL64azdlG5OBSp
        p/sZYH6w/FCtb4QuNyi6qloiBcV11OEl+CwNbfWydhfZGmBZP/au+Qj8LjQhmlNptWVlSw
        jVR0zaog4dxEhUSSa1KgonIcNQ7kYvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671565072;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=veAxSf12DNG47jR5jayL1YoDivvUiMHtPGyXEa2HYJw=;
        b=wjM53taC5ClkjuBXSyakCNWeSFk97aSsvSkKLLkxVd22jTb8iUBqXif7QHT+gSPuJDs3c1
        wvXMaGt+/jIN3wAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33EDE13254;
        Tue, 20 Dec 2022 19:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lcAeCxAPomNhQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 20 Dec 2022 19:37:52 +0000
Date:   Tue, 20 Dec 2022 20:37:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] Fixup uninitialized warnings and enable extra checks
Message-ID: <20221220193706.GS10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1671221596.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:15:50PM -0500, Josef Bacik wrote:
> Hello,
> 
> We had been failing the raid56 related scrub tests on our overnight tests since
> November.  Initially I asked Qu to look into these as I didn't have time to dig
> in, and he was unable to reproduce.  I assumed it was some oddity in my setup,
> so I ignored it.  However recently I got a report that I regressed some of these
> tests with an unrelated change.  When debugging it I found it was because of an
> uninitialized return value, which would have been caught by more modern gcc's
> with -Wmaybe-uninitialized.
> 
> In order to avoid these sort of problems in the future lets fix up all the false
> positivies that this warning brings, and then enable the option for btrfs so we
> can avoid this style of failure in the future.  Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs: fix uninit warning in run_one_async_start
>   btrfs: fix uninit warning in btrfs_cleanup_ordered_extents
>   btrfs: fix uninit warning from get_inode_gen usage
>   btrfs: fix uninit warning in btrfs_update_block_group
>   btrfs: fix uninit warning in __set_extent_bit and convert_extent_bit
>   btrfs: extract out zone cache usage into it's own helper
>   btrfs: fix uninit warning in btrfs_sb_log_location
>   btrfs: turn on -Wmaybe-uninitialized

I've applied all except 1, 6 and 8, so there are still 2 reported
warnings with -Wmaybe-uninitialized that could be fixed in a slightly
different way.
