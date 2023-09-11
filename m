Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2F79BCEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355951AbjIKWC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbjIKNvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 09:51:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF07FA
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:51:51 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7b9c04591fso3734434276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694440310; x=1695045110; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vi3jzxur3SdMTDLceOQ6ZmBnaFyzcufuj8RUdb/3Gx4=;
        b=BxddP5169o4MQCqd7LBj/EYYo/xDVTRfiFXZeaY8ahckFTVQ2B0416rh8p47xl+B16
         3F2ktv/RaTXezC2jLpkkW6A2afxBhX2gvbi+ZfbalIplmcbiqkn3FUBsfaIiNQrifxem
         qpqSQ8kMORK0LA9UYpIeQC/nJRP0H8fseDzeGO0en5cCahgCxS8T9Fs2Lw9Gl0UjkAnc
         dp7VzJedi9cc5IEahMuKf6Q/Xvw3IVLhTdVxJBx9XCBG9fRivmWX+3AsCM9xyHOYzuYX
         INkiQDUJqmc/CyodehjPMEB34hU7tycLX+MFSBC757xr/7G4k+GmmjIe7Ig1fsgn7Uis
         W6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440310; x=1695045110;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi3jzxur3SdMTDLceOQ6ZmBnaFyzcufuj8RUdb/3Gx4=;
        b=KeT6UG7AVpATEPQZNpn1iBYx4Hf8BqoVzFRQQ+yLYypxoCtSATTEM6Xzl7Y1DqKuyE
         j4wyZkguq0TB5n/4p+B6A5ro41kotXB0Y8aOZ3DM/8xkMYI6DF4iBRhz/I/QYVkr3ohG
         mOgGZOnY6FZvgKBdbeM0UJPPsBj1L4UpkSfYlqWt40tdu+36aiqwVgXLxwD6MWdmb3W8
         p3zVuKFtyM8YYc+1Drm61ZoM7prCXjMGV4T/PcN9dqDHGXXwKJ6Uyf9E5aYfzeIlvtZY
         Fyej5CXdug0B+BBmRXYWA8gTejFZ/oY/aHAHZ8VKAPf3Jyxrhc6Ygg6wGlOUC64XFIYJ
         CLMQ==
X-Gm-Message-State: AOJu0YyKSJiUjlE7/lIBqErDXV8mGR3WcjeFZUpMXK1pIfRqdsMwJulc
        ZQQXxo+PEGRs4dZ6rKaSNA1PCf5GI6e8H0qII2RRWw==
X-Google-Smtp-Source: AGHT+IEAufkYUPNXSYTQwYR4PAvaQ7Ox9VSbKYEu++jxJAmkFgk5na89NrGwFh0749U79NaFa7jUmQ==
X-Received: by 2002:a25:b16:0:b0:d7f:cdc8:e17c with SMTP id 22-20020a250b16000000b00d7fcdc8e17cmr8202730ybl.51.1694440310085;
        Mon, 11 Sep 2023 06:51:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n62-20020a25d641000000b00d7f06aa25c5sm1705813ybg.58.2023.09.11.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:51:49 -0700 (PDT)
Date:   Mon, 11 Sep 2023 09:51:46 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, naohiro.aota@wdc.com
Subject: Zoned panic WRT btrfs_redirty_list_add
Message-ID: <20230911135146.GA2352074@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I hit the following panic on our CI this last week

assertion failed: PageDirty(eb->pages[i]), in fs/btrfs/extent_io.c:3809
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:3809!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 858183 Comm: fsstress Not tainted 6.5.0+ #1
RIP: 0010:set_extent_buffer_dirty+0x11a/0x210
RSP: 0018:ffffc9000631fa28 EFLAGS: 00010246
RAX: 0000000000000047 RBX: ffff888116642848 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88817bd21880 RDI: ffff88817bd21880
RBP: 0000000000000004 R08: 0000000000000000 R09: ffffc9000631f8c8
R10: 0000000000000003 R11: ffffffff8c534318 R12: 0000000000000004
R13: 0000000000004000 R14: 0000000000000004 R15: ffff888116642848
FS:  00007f6608d72740(0000) GS:ffff88817bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000c98568 CR3: 000000011f3b8000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ? die+0x36/0x90
 ? do_trap+0xda/0x100
 ? set_extent_buffer_dirty+0x11a/0x210
 ? set_extent_buffer_dirty+0x11a/0x210
 ? do_error_trap+0x81/0x110
 ? set_extent_buffer_dirty+0x11a/0x210
 ? exc_invalid_op+0x50/0x70
 ? set_extent_buffer_dirty+0x11a/0x210
 ? asm_exc_invalid_op+0x1a/0x20
 ? set_extent_buffer_dirty+0x11a/0x210
 ? set_extent_buffer_dirty+0x11a/0x210
 btrfs_redirty_list_add+0x75/0xd0
 btrfs_free_tree_block+0x243/0x2f0
 btrfs_del_leaf+0xba/0xe0
 btrfs_del_items+0x49c/0x520
 __btrfs_free_extent+0x615/0x1260
 __btrfs_run_delayed_refs+0x2d9/0x1310
 ? lock_is_held_type+0x9b/0x110
 ? find_held_lock+0x2b/0x80
 ? btrfs_start_dirty_block_groups+0x50/0x5b0
 btrfs_run_delayed_refs+0x59/0x220
 btrfs_start_dirty_block_groups+0x3bc/0x5b0
 ? btrfs_commit_transaction+0x41/0x1420
 ? btrfs_commit_transaction+0x41/0x1420
 btrfs_commit_transaction+0x106/0x1420
 ? btrfs_attach_transaction_barrier+0x22/0x60
 ? __pfx_sync_fs_one_sb+0x10/0x10
 iterate_supers+0x7e/0xf0

We have a check to make sure the pages we just dirtied are actually set to
dirty, and this is what's failing.

In btrfs_redirty_list_add() we have an ASSERT(!EXTENT_BUFFER_DIRTY), so we know
we're going through the path where we weren't dirty and now we are and thus
setting the pages dirty.

However we're doing the btrfs_redirty_list_add() outside of the
btrfs_tree_lock().  We always set the EXTENT_DIRTY for ->dirty_pages on the
transaction, however we never clear it, we rely on the EXTENT_BUFFER_DIRTY flag
to be the ultimate arbiter of whether or not to write the extent buffer.

Which means there's a race where we could be currently writing this extent
buffer out and calling btrfs_redirty_list_add() on the extent buffer.

I attempted to naively fix this by adjusting the btrfs_clear_buffer_dirty()
helper to simply not clear dirty for extent buffers if we were zoned, but that
keeps blowing up in my face and I'm not awake enough to figure out why.

I had also tried just wrapping this in btrfs_tree_lock() but there was an
immediate deadlock that I didn't look at because I tried the
btrfs_clear_buffer_dirty() thing next.

In any case this needs to be reworked with this race in mind.  Thanks,

Josef
