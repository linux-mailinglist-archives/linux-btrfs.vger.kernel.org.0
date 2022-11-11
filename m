Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B15625B76
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKKNtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 08:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKNty (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 08:49:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9827B00
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 05:49:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E7E9201C5;
        Fri, 11 Nov 2022 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668174592;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5QWzqpKsZWn0NNBI6jipFL7jh0aLlE5aUK1tWNOg2M=;
        b=AWLZQMnzQNtcSPwTb80JoW8QTL0fZzNJZlMCtc07rQdXCJHlb+2gbYG+sq3gl6Wo1jy8YL
        suV7CA3gDvJ1/14zXSEuUatd4mEbY6Ad4vLmCGurPioBhj5ES9unbQsLvpu7Wrq0B6ID9i
        IAQqMzPaJsYpc1pRTWWneTKAkQIKTlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668174592;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5QWzqpKsZWn0NNBI6jipFL7jh0aLlE5aUK1tWNOg2M=;
        b=kjtKdNWgjVrz3CBi6kxZ2kPF1NRyxZDjjdry2XgCsQ9w+lqho769LGEKyrzZ2wcGCAC6p0
        qI0tMYHrG4J6a7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CDC213273;
        Fri, 11 Nov 2022 13:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ERzyDQBTbmOieAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Nov 2022 13:49:52 +0000
Date:   Fri, 11 Nov 2022 14:49:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: debug: verify all the pointers for
 generate_pq_vertical()
Message-ID: <20221111134928.GM5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0cb5e2dcb02a3f6f8f7ec1f42543d146bed31b51.1667956749.git.wqu@suse.com>
 <20221110193950.GI5824@twin.jikos.cz>
 <798c8be3-5f9a-d74d-cf69-1e8991663327@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798c8be3-5f9a-d74d-cf69-1e8991663327@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 11, 2022 at 07:05:25AM +0800, Qu Wenruo wrote:
> > [ 2424.878618]  kthread+0x146/0x180
> > [ 2424.879153]  ret_from_fork+0x1f/0x30
> > [ 2424.880146]
> > [ 2424.880669] Freed by task 4823:
> > [ 2424.881638]  kasan_save_stack+0x1c/0x40
> > [ 2424.882744]  kasan_set_track+0x21/0x30
> > [ 2424.883718]  kasan_save_free_info+0x2a/0x40
> > [ 2424.884663]  ____kasan_slab_free+0x1b7/0x210
> > [ 2424.885746]  __kmem_cache_free+0xc7/0x1b0
> > [ 2424.886816]  rbio_orig_end_io+0x9d/0x110 [btrfs]
> > 
> > Freed in end io - perhaps too early
> > 
> > [ 2424.888108]  scrub_rbio_work_locked+0x440/0x1310 [btrfs]
> 
> I'm very interested in the code line number of this frame.

(gdb) l *(scrub_rbio_work_locked+0x440)
0x154fa0 is in scrub_rbio_work_locked (fs/btrfs/raid56.c:2598).
2593
2594            return ret;
2595    }
2596
2597    static void scrub_rbio_work_locked(struct work_struct *work)
2598    {
2599            struct btrfs_raid_bio *rbio;
2600            int ret;
2601
2602            rbio = container_of(work, struct btrfs_raid_bio, work);

That's same with and without the atomic_dec fixups.

> The 0x440/0x1310 doesn't really match the scrub_rbio_work_locked(), 
> which calls rbio_orig_end_io() at the end of it.

Reading the raw assembly, it points to "call rbio_orig_end_io", or the
instruction right after that which is what the call stack tracks. So gdb
does not give the right line number but otherwise it looks correct.
