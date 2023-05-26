Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92E71290C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjEZPDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjEZPDQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 11:03:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CD125
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 08:03:15 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1092721AE4;
        Fri, 26 May 2023 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685113394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtO4PugRLiH5d5b8+rLOPKEQoiOei8ZxfX6QA7Qa0/Q=;
        b=OzuxrhH5IBA9mTL/DCMdP80xduZIfDDE0/nvrSqN3wHf55jUi88fTQqx1pC2VNdDRL8GxG
        VQY/XmfTmG7ATZZZgJbgZIjMe0vShUYm4UwQLSoOeST1FfHmlYU/YSH9NGo725Pt0psL5c
        hOZlCPZqNbqDhjPI+6i4qCWloXgB+/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685113394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KtO4PugRLiH5d5b8+rLOPKEQoiOei8ZxfX6QA7Qa0/Q=;
        b=LrF2+VY5CJLVCTya1Gy35XV9gpKQDMihSTqPaDrUe4Z+3wNCvuVTRCG8G0HXL1mryi58oi
        X0WCEroy+gJe/nCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D50E513684;
        Fri, 26 May 2023 15:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gitFMzHKcGQLBAAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 15:03:13 +0000
Date:   Fri, 26 May 2023 16:57:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: print assertion failure report and stack
 trace from the same line
Message-ID: <20230526145705.GC575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230503190816.8800-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503190816.8800-1-dsterba@suse.com>
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

On Wed, May 03, 2023 at 09:08:16PM +0200, David Sterba wrote:
> Assertions reports are split into two parts, the exact file and location
> of the condition and then the stack trace printed from
> btrfs_assertfail(). This means all the stack traces report the same line
> and this is what's typically reported by various tools, making it harder
> to distinguish the reports.
> 
>   [403.2467] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
>   [403.2479] ------------[ cut here ]------------
>   [403.2484] kernel BUG at fs/btrfs/messages.c:259!
>   [403.2488] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>   [403.2493] CPU: 2 PID: 23202 Comm: umount Not tainted 6.2.0-rc4-default+ #67
>   [403.2499] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
>   [403.2509] RIP: 0010:btrfs_assertfail+0x19/0x1b [btrfs]
>   ...
>   [403.2595] Call Trace:
>   [403.2598]  <TASK>
>   [403.2601]  btrfs_free_block_groups.cold+0x52/0xae [btrfs]
>   [403.2608]  close_ctree+0x6c2/0x761 [btrfs]
>   [403.2613]  ? __wait_for_common+0x2b8/0x360
>   [403.2618]  ? btrfs_cleanup_one_transaction.cold+0x7a/0x7a [btrfs]
>   [403.2626]  ? mark_held_locks+0x6b/0x90
>   [403.2630]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
>   [403.2636]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
>   [403.2642]  ? trace_hardirqs_on+0x2d/0x110
>   [403.2646]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
>   [403.2652]  generic_shutdown_super+0xb0/0x1c0
>   [403.2657]  kill_anon_super+0x1e/0x40
>   [403.2662]  btrfs_kill_super+0x25/0x30 [btrfs]
>   [403.2668]  deactivate_locked_super+0x4c/0xc0
> 
> By making btrfs_assertfail a macro we'll get the same line number for
> the BUG output:
> 
>   [63.5736] assertion failed: 0, in fs/btrfs/super.c:1572
>   [63.5758] ------------[ cut here ]------------
>   [63.5782] kernel BUG at fs/btrfs/super.c:1572!
>   [63.5807] invalid opcode: 0000 [#2] PREEMPT SMP KASAN
>   [63.5831] CPU: 0 PID: 859 Comm: mount Tainted: G      D            6.3.0-rc7-default+ #2062
>   [63.5868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
>   [63.5905] RIP: 0010:btrfs_mount+0x24/0x30 [btrfs]
>   [63.5964] RSP: 0018:ffff88800e69fcd8 EFLAGS: 00010246
>   [63.5982] RAX: 000000000000002d RBX: ffff888008fc1400 RCX: 0000000000000000
>   [63.6004] RDX: 0000000000000000 RSI: ffffffffb90fd868 RDI: ffffffffbcc3ff20
>   [63.6026] RBP: ffffffffc081b200 R08: 0000000000000001 R09: ffff88800e69fa27
>   [63.6046] R10: ffffed1001cd3f44 R11: 0000000000000001 R12: ffff888005a3c370
>   [63.6062] R13: ffffffffc058e830 R14: 0000000000000000 R15: 00000000ffffffff
>   [63.6081] FS:  00007f7b3561f800(0000) GS:ffff88806c600000(0000) knlGS:0000000000000000
>   [63.6105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [63.6120] CR2: 00007fff83726e10 CR3: 0000000002a9e000 CR4: 00000000000006b0
>   [63.6137] Call Trace:
>   [63.6143]  <TASK>
>   [63.6148]  legacy_get_tree+0x80/0xd0
>   [63.6158]  vfs_get_tree+0x43/0x120
>   [63.6166]  do_new_mount+0x1f3/0x3d0
>   [63.6176]  ? do_add_mount+0x140/0x140
>   [63.6187]  ? cap_capable+0xa4/0xe0
>   [63.6197]  path_mount+0x223/0xc10
> 
> This comes at a cost of bloating the final btrfs.ko module due all the
> inlining, as long as assertions are compiled in. This is a must for
> debugging builds but this is often enabled on release builds too.
> 
> Release build:
> 
>    text    data     bss     dec     hex filename
> 1251676   20317   16088 1288081  13a791 pre/btrfs.ko
> 1260612   29473   16088 1306173  13ee3d post/btrfs.ko
> 
> DELTA: +8936
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

I'm adding this to misc-next. Recent patchsets reduced size of .ko so
the bloat isn't too bad.
