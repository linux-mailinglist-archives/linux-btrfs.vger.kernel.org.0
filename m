Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8152735A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 May 2022 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiENR6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 May 2022 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiENR6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 May 2022 13:58:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D930369C0
        for <linux-btrfs@vger.kernel.org>; Sat, 14 May 2022 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pTQPi5JwD4axm6qseKz5qNscOpk9m6YbNIc+aeH67rg=; b=nFmosZRe63YYAoVNe/rNWGWn5i
        c8n+R6SwbXDS4QYDHCHpmaAjmGyyNW5DTlSEGkeMf+26EkYgIvsjF/G+li4NBbsCW0LJoQNgxNcig
        jFNbejp1+YH6alOmZxm//uv2mscoRKg4mQSF2AQqw7jpWhhWHWpsJv3QGsfZPs7PIJENjcJW8LS+z
        AXbOfElOUGOLEv3hpmI7JAhVvXXw0ooD56sZiipvgDKW6kFUbbUBlvnb6Yz0Lk3OeqHVHH9m98Vlq
        l8j/aXm3c+VuupvSk5wjcq4F4DycTn+WrLY/O16sTvwsqy8Jl8EiY+VtmShkLxEklgNhqJ8Mk9De9
        WsFE1SSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npw29-008Nwx-Py
        for linux-btrfs@vger.kernel.org; Sat, 14 May 2022 17:58:29 +0000
Date:   Sat, 14 May 2022 18:58:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-btrfs@vger.kernel.org
Subject: Use of PageError in superblock writes
Message-ID: <Yn/txWbij5voeGOB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a need to reclaim page flag bits, and one of the easier
ones to remove is PG_error (aka {Set,Clear,}PageError(), aka
folio_{test,set,clear}_error().

That caused me to look at wait_dev_supers(), and it's a little unusual.
Instead of following the usual pagecache writeback procedure, it
locks the page, memcpy() into it, submits its own BIO, and then
unlocks the page in the bio endio routine.  wait_dev_supers()
waits for the page to be unlocked (ie the write completed) and then
checks PageError() to see if it worked.

I don't think this is buggy.  It's just confusing to see a write being
waited for on the locked bit instead of on the writeback bit.  But I
get why you're doing it; this is such a special case that there's no
need to do the usual pagecache dance with the dirty & writeback flags.

The handling of the uptodate flag is a little strange though.
You're leaving it clear if the write fails, which means that it'll be
re-read from storage if someone tries to read that block through the
pagecache from the underlying device file.  What's a bit weirder (and
maybe buggy?) is that if you're on a machine with a 64KiB page size,
you fetch a 64KiB page from the cache, write 4KiB into it, and then
(assuming the write is successful), mark the entire 64KiB as being
uptodate in the page cache for the underlying disk mapping, which means
that anyone reading the other 60KiB in the page cache is going to be
reading uninitialised memory.  You'd have to be root to do that, so I
doubt it's any kind of security concern, but it's not great.

I wonder if the page cache is really helping you here.  As far as I can
tell, you'd be better off allocating a single page, storing a pointer to
it in struct btrfs_device, and maintaining your own metadata in struct
page (how many writes are still outstanding, how many had errors).
That gives you five words (minus one bit) to play with without worrying
about what the rest of the system is doing with page flags.

Am I wrong about that?  Is there an advantage to having the superblock
pages stored in the bdev's i_mapping?  Or can we just use your O_DIRECT
path to read/write kernel memory directly?
