Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0372532F4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiEXQ5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiEXQ5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 12:57:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C876E8FC
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 09:57:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C54C1F940;
        Tue, 24 May 2022 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653411468;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhyaSsYpsVdAFU6AAdgntSQVWuPUBTXQE9rCsigo31U=;
        b=SyTBMH6LT7znAPi/Tx9EGswAkeTx42vwTLSG9eGScew83x2EkexElUW5JnJgqYaDpLSywv
        7UiN3of1rn7ZTW+uDeTilYjmFJJjkSFzY79lGwbWztKwteRceZ0pG51DzrYzYOSQG1qsiG
        YJBscY+282GFCf8yo/7urzwCmoN6498=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653411468;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhyaSsYpsVdAFU6AAdgntSQVWuPUBTXQE9rCsigo31U=;
        b=ehcRmmSx7wW8R8VPZ2NNMP8WxmCvNlJfUCh/NuehgcoCiCD/DfzgZH5KMzXXhrRQ9xrX1J
        4RJYmYIAOeGJV5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E33D13AE3;
        Tue, 24 May 2022 16:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UCZoCowOjWJTZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 24 May 2022 16:57:48 +0000
Date:   Tue, 24 May 2022 18:53:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Use of PageError in superblock writes
Message-ID: <20220524165326.GV18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org
References: <Yn/txWbij5voeGOB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn/txWbij5voeGOB@casper.infradead.org>
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

On Sat, May 14, 2022 at 06:58:29PM +0100, Matthew Wilcox wrote:
> That caused me to look at wait_dev_supers(), and it's a little unusual.
> Instead of following the usual pagecache writeback procedure, it
> locks the page, memcpy() into it, submits its own BIO, and then
> unlocks the page in the bio endio routine.  wait_dev_supers()
> waits for the page to be unlocked (ie the write completed) and then
> checks PageError() to see if it worked.
> 
> I don't think this is buggy.  It's just confusing to see a write being
> waited for on the locked bit instead of on the writeback bit.  But I
> get why you're doing it; this is such a special case that there's no
> need to do the usual pagecache dance with the dirty & writeback flags.

I think that this is the reason, the page lock is used for waiting
because "it works" and follows the direct change from buffer_head in
commit 314b6dd0eebfa9962. Switching to another way can be done and I
think somebody suggested to use page cache, but this was not
implemented, the buffer head -> bio was basically API transformation.

> The handling of the uptodate flag is a little strange though.
> You're leaving it clear if the write fails, which means that it'll be
> re-read from storage if someone tries to read that block through the
> pagecache from the underlying device file.  What's a bit weirder (and
> maybe buggy?) is that if you're on a machine with a 64KiB page size,
> you fetch a 64KiB page from the cache, write 4KiB into it, and then
> (assuming the write is successful), mark the entire 64KiB as being
> uptodate in the page cache for the underlying disk mapping, which means
> that anyone reading the other 60KiB in the page cache is going to be
> reading uninitialised memory.  You'd have to be root to do that, so I
> doubt it's any kind of security concern, but it's not great.

This does not sound like a serious problem but I agree that it's weird
and should be fixed.

> I wonder if the page cache is really helping you here.  As far as I can
> tell, you'd be better off allocating a single page, storing a pointer to
> it in struct btrfs_device, and maintaining your own metadata in struct
> page (how many writes are still outstanding, how many had errors).
> That gives you five words (minus one bit) to play with without worrying
> about what the rest of the system is doing with page flags.
> 
> Am I wrong about that?  Is there an advantage to having the superblock
> pages stored in the bdev's i_mapping?  Or can we just use your O_DIRECT
> path to read/write kernel memory directly?

No, I think you have a point, a separate page can work fine. I'm not
sure about using direct io here, the single page should make it obvious
what's going on and super block handling can be special.
