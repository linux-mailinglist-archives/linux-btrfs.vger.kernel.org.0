Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9541A5FA24A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJJQ7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJQ7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 12:59:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC4760DE
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 09:59:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89CCD21B2E;
        Mon, 10 Oct 2022 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665421155;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0LOdSpMXA3vhydQOHTf7L1gHz56RGWTtuuOee8UERE=;
        b=hw6ZEqtEpxiiTKxuVUP7vAtOnhmlstohgUeG8kbZKcVu2yBjcRfFKsWcHtk3JPtPW8Di16
        MsDR+JBJ6KrOhgtHwXgMVBbOyZJHMSFBoTu8Jsbkf0XYfI5WwiCnxcbzqPXnv62olXzu+S
        Ym6uvSewI4CAkkQh8DR0sSFby1T3n5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665421155;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0LOdSpMXA3vhydQOHTf7L1gHz56RGWTtuuOee8UERE=;
        b=vdbkVd6N6yjrGTam5H25mLKYKwnWWX1f0AksTmtAIVqSS+TyD2oqHmuiSqQXceLgOhAZCW
        PrV1XNv9GFF5HvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50AC913479;
        Mon, 10 Oct 2022 16:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xnokEmNPRGNuXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 10 Oct 2022 16:59:15 +0000
Date:   Mon, 10 Oct 2022 18:59:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
Message-ID: <20221010165910.GF13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 09, 2022 at 09:35:01AM -0400, Josef Bacik wrote:
> Inside of FB, as well as some user reports, we've had a consistent
> problem of occasional ENOSPC transaction aborts.  Inside FB we were
> seeing ~100-200 ENOSPC aborts per day in the fleet, which is a really
> low occurrence rate given the size of our fleet, but it's not nothing.
> 
> There are two causes of this particular problem.
> 
> First is delayed allocation.  The reservation system for delalloc
> assumes that contiguous dirty ranges will result in 1 file extent item.
> However if there is memory pressure that results in fragmented writeout,
> or there is fragmentation in the block groups, this won't necessarily be
> true.  Consider the case where we do a single 256MiB write to a file and
> then close it.  We will have 1 reservation for the inode update, the
> reservations for the checksum updates, and 1 reservation for the file
> extent item.  At some point later we decide to write this entire range
> out, but we're so fragmented that we break this into 100 different file
> extents.  Since we've already closed the file and are no longer writing
> to it there's nothing to trigger a refill of the delalloc block rsv to
> satisfy the 99 new file extent reservations we need.  At this point we
> exhaust our delalloc reservation, and we begin to steal from the global
> reserve.  If you have enough of these cases going in parallel you can
> easily exhaust the global reserve, get an ENOSPC at
> btrfs_alloc_tree_block() time, and then abort the transaction.
> 
> The other case is the delayed refs reserve.  The delayed refs reserve
> updates its size based on outstanding delayed refs and dirty block
> groups.  However we only refill this block reserve when returning
> excess reservations and when we call btrfs_start_transaction(root, X).
> We will reserve 2*X credits at transaction start time, and fill in X
> into the delayed refs reserve to make sure it stays topped off.
> Generally this works well, but clearly has downsides.  If we do a
> particularly delayed ref heavy operation we may never catch up in our
> reservations.  Additionally running delayed refs generates more delayed
> refs, and at that point we may be committing the transaction and have no
> way to trigger a refill of our delayed refs rsv.  Then a similar thing
> occurs with the delalloc reserve.
> 
> Generally speaking we well over-reserve in all of our block rsvs.  If we
> reserve 1 credit we're usually reserving around 264k of space, but we'll
> often not use any of that reservation, or use a few blocks of that
> reservation.  We can be reasonably sure that as long as you were able to
> reserve space up front for your operation you'll be able to find space
> on disk for that reservation.
> 
> So introduce a new flushing state, BTRFS_RESERVE_FLUSH_EMERGENCY.  This
> gets used in the case that we've exhausted our reserve and the global
> reserve.  It simply forces a reservation if we have enough actual space
> on disk to make the reservation, which is almost always the case.  This
> keeps us from hitting ENOSPC aborts in these odd occurrences where we've
> not kept up with the delayed work.
> 
> Fixing this in a complete way is going to be relatively complicated and
> time consuming.  This patch is what I discussed with Filipe earlier this
> year, and what I put into our kernels inside FB.  With this patch we're
> down to 1-2 ENOSPC aborts per week, which is a significant reduction.
> This is a decent stop gap until we can work out a more wholistic
> solution to these two corner cases.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I'll add this to misc-next, we now have a full development cycle to find
problems and could remove it eventually.
