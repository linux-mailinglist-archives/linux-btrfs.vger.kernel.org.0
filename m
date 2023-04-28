Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE86F1D16
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjD1RCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346419AbjD1RCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 13:02:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E75524F
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 10:01:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCA8C21F99;
        Fri, 28 Apr 2023 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682701293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0B1WMhro7xNT27N8Gf0oZdS0OGoet1k7s3xeDsXbmA=;
        b=u1J1Le2deQbv1KwSSTae4AVDr1BfVKcB+99mK8PkvVv8XCpW12YEbiokv4+Vqempj6HLDG
        camZwAv8wm11JpIFovVCp99IthVZ+i/jHUcsMLgfWadRLjOrctlInpPQdqQpioBozcq61q
        9XcAXYBAtqD2Nsx/Zur299P0brcPz2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682701293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0B1WMhro7xNT27N8Gf0oZdS0OGoet1k7s3xeDsXbmA=;
        b=Q+FiFCJE4w9nb6XXhzTGYYevGhCDc6Dm1KOT63QL0e3QpNj0BouX8/Nb4fPGBclu/QtL0K
        xoS8/Rx4t02nl0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91E5C1390E;
        Fri, 28 Apr 2023 17:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kS7mIu37S2QDDAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Apr 2023 17:01:33 +0000
Date:   Fri, 28 Apr 2023 18:55:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: make dev-scrub as an exclusive operation
Message-ID: <20230428165540.GE2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ef0c22ce3cf2f7941634ed1cb2ca718f04ce675d.1682296794.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0c22ce3cf2f7941634ed1cb2ca718f04ce675d.1682296794.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 24, 2023 at 08:48:47AM +0800, Qu Wenruo wrote:
> [PROBLEMS]
> Currently dev-scrub is not an exclusive operation, thus it's possible to
> run scrub with balance at the same time.
> 
> But there are possible several problems when such concurrency is
> involved:
> 
> - Scrub can lead to false alerts due to removed block groups
>   When balance is finished, it would delete the source block group
>   and may even do an discard.
> 
>   In that case if a scrub is still running for that block group, we
>   can lead to false alerts on bad checksum.
> 
> - Balance is already checking the checksum
>   Thus we're doing double checksum verification, under most cases it's
>   just a waste of IO and CPU time.
> 
> - Extra chance of unnecessary -ENOSPC
>   Both balance and scrub would try to mark the target block group
>   read-only.
>   With more block groups marked read-only, we have higher chance to
>   hit early -ENOSPC.
> 
> [ENHANCEMENT]
> Let's make dev-scrub as an exclusive operation, but unlike regular
> exclusive operations, we need to allow multiple dev-scrub to run
> concurrently.
> 
> Thus we introduce a new member, fs_info::exclusive_dev_scrubs, to record
> how many dev scrubs are running.
> And only set fs_info::exclusive_operation back to NONE when no more
> dev-scrub is running.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> 
> This change is a change to the dev-scrub behavior, now we have extra
> error patterns.
> 
> And some existing test cases would be invalid, as they expect
> concurrent scrub and balance as a background stress.
> 
> Although this makes later logical bytenr based scrub much easier to
> implement (needs to be exclusive with dev-scrub).

IIRC there were suggestions in the past to make scrub another exclusive
op but for performance impact if accidentally started in the background.
Which is related to the reasons you mention.

Scrub is a bit different than the other ops, it can be started on
devices so it's not a whole-filesystem op, which needs the counter but
that could be acceptable in the end.

But I'm not sure we should add this limitation, and it's a bit hard to
guess how much is the concurrent scrub/balance used versus how often the
spurious ENOSPC happens (and is considered a problem). We could add
warnings to balance and scrub start if there's the other one detected.
