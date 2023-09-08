Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE5799219
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbjIHWTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 18:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjIHWTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 18:19:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04881FDA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 15:19:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B120201C7;
        Fri,  8 Sep 2023 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694211586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJYIk6AvvsYQJoc75Z4sTccwk2dK6zxwLFRcv/g2/Is=;
        b=ZdcqUXKvf7+iVBu7pKa8r+aW+LUzqJnMGojedLTLOH2hU61yNr7yN4zLkba7YCF4Ioxrev
        Y/trh0ZaVjRvd7VeGmUCS78Ses1KKLW3bkXcqoY68UO77F7ZsL5cCBAtnpdSgEytYjkgps
        z+6464edsf+ohaDkOwrhZj6/aHkGROs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694211586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJYIk6AvvsYQJoc75Z4sTccwk2dK6zxwLFRcv/g2/Is=;
        b=LaIYOs3cuQmjiPIFMg9QEXEcvufDt0GeGxexhjcPm/LnTPNP9n20HH3hC9Syh6oHRkyU0s
        UuBXnohqrmlI7dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A939131FD;
        Fri,  8 Sep 2023 22:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wFIXDQKe+2RjKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 22:19:46 +0000
Date:   Sat, 9 Sep 2023 00:13:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't clear uptodate on write errors
Message-ID: <20230908221313.GA3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b709ff69f5d190ec620b7e4a21530be08442bf4b.1694201483.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b709ff69f5d190ec620b7e4a21530be08442bf4b.1694201483.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 03:31:39PM -0400, Josef Bacik wrote:
> We have been consistently seeing hangs with generic/648 in our subpage
> GitHub CI setup.  This is a classic deadlock, we are calling
> btrfs_read_folio() on a folio, which requires holding the folio lock on
> the folio, and then finding a ordered extent that overlaps that range
> and calling btrfs_start_ordered_extent(), which then tries to write out
> the dirty page, which requires taking the folio lock and then we
> deadlock.
> 
> The hang happens because we're writing to range [1271750656, 1271767040), page
> index [77621, 77622], and page 77621 is !Uptodate.  It is also Dirty, so we call
> btrfs_read_folio() for 77621 and which does btrfs_lock_and_flush_ordered_range()
> for that range, and we find an ordered extent which is [1271644160, 1271746560),
> page index [77615, 77621].  The page indexes overlap, but the actual bytes don't
> overlap.  We're holding the page lock for 77621, then call
> btrfs_lock_and_flush_ordered_range() which tries to flush the dirty page, and
> tries to lock 77621 again and then we deadlock.
> 
> The byte ranges do not overlap, but with subpage support if we clear
> uptodate on any portion of the page we mark the entire thing as not
> uptodate.

Right, the split state handling.

> We have been clearing page uptodate on write errors, but no other file
> system does this, and is in fact incorrect.  This doesn't hurt us in the
> !subpage case because we can't end up with overlapped ranges that don't
> also overlap on the page.
> 
> Fix this by not clearing uptodate when we have a write error.  The only
> thing we should be doing in this case is setting the mapping error and
> carrying on.  This makes it so we would no longer call
> btrfs_read_folio() on the page as it's uptodate and eliminates the
> deadlock.
> 
> With this patch we're now able to make it through a full xfstests run on
> our subpage blocksize vms.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I've marked it for stable 6.1 but it does not apply cleanly due to
cleanups, btrfs_page_clear_uptodate() was called from
end_extent_writepage() and open coded in 9783e4deed72 ("btrfs: remove
end_extent_writepage"). Any backport needs to be careful, obviously the
call can be removed from the helper but this might not be the only
place. Added to misc-next, thanks.
