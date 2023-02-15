Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB47698490
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBOTcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBOTcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 14:32:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74F3CE19
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 11:32:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B71111F74D;
        Wed, 15 Feb 2023 19:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676489552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+JbCXbKoRiNdQloOCNPFNvDigvauh/gx5wB2zLcOs4=;
        b=vBO70GAVCF+JUsc5o1EHkRFAV9put4aP96CgUA5QmqmcvYguVbZj+LKWN9cWYZs593E5iE
        cheCRqt5dtlGcsqENsjgrG+jRVytuym/9Fe/bwE2Ib/jd99iCa778pECa1orPh7TgkLHvV
        cXRZbrTKCsrfhryQg5epuvi7P48l8Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676489552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+JbCXbKoRiNdQloOCNPFNvDigvauh/gx5wB2zLcOs4=;
        b=dEJm1mlsVl9ZFz0hipGohPSnNqvP4MyH+6Ra7Ax/6LrtTVcUyiJ0uGmlSc9evPGO3nY6fK
        YJ/CUpM1a2QPIKDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88F5B13483;
        Wed, 15 Feb 2023 19:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v914IFAz7WObCgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Feb 2023 19:32:32 +0000
Date:   Wed, 15 Feb 2023 20:26:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/7] Error handling fixes
Message-ID: <20230215192639.GU28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1675787102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 07, 2023 at 11:57:18AM -0500, Josef Bacik wrote:
> Hello,
> 
> For a short period of time our btrfs backport had 947a629988f1 ("btrfs: move
> tree block parentness check into validate_extent_buffer()") without the
> associated fix, which resulted in a lot of hilarity.
> 
> One of the things that popped was a WARN_ON(ret == 1) in __btrfs_free_extent
> where we didn't find the bytenr we were looking for.  This was troubling, as it
> appeared that we were losing the EIO and returning 1 from btrfs_search_slot.
> 
> I rigged up my error injection stress test with
> btrfs_check_leaf/btrfs_check_node with balance (as this was the path that we saw
> the error).  This of course uncovered a few other unrelated things, but
> eventually I reproduced what we saw in production.  Thankfully it was not that
> we were eating the -EIO and returning 1 instead, however the actual problem is
> worse.  We do not handle the errors properly in snapshot delete (which also gets
> used by reloation), and then we do not abort the transaction when we hit errors
> in this path, which leads to the file system being corrupted and eventually
> triggers the above WARN_ON().
> 
> With these fixes in place my stress testing was running overnight without
> tripping over any other leaks, corruptions, or panics.  Previously I wasn't able
> to run for longer than a couple of minutes without falling over.  Thanks,
> 
> Josef
> 
> Josef Bacik (7):
>   btrfs: use btrfs_handle_fs_error in btrfs_fill_super
>   btrfs: replace BUG_ON(level == 0) with ASSERT(level)
>   btrfs: handle errors from btrfs_read_node_slot in split
>   btrfs: iput on orphan cleanup failure
>   btrfs: drop root refs properly when orphan cleanup fails
>   btrfs: handle errors in walk_down_tree properly
>   btrfs: abort the transaction if we get an error during snapshot drop

Added to for-next as topic branch, will be moved to misc-next once the
6.3 pull request is out. Thanks.
