Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC94E9FC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245692AbiC1Tcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiC1Tch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 15:32:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5365DE42
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 12:30:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 593D31FDA7;
        Mon, 28 Mar 2022 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648495855;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b48HkU5AT6k5eD0HbooXQFoyZSH1GZ+ADCsn4BviEdQ=;
        b=sW/OLG2T6kRKHHJIU+qdeNU4E1PAvwlHaTaZNEpsQKaEggdHNLrKgqwflwid719gLfCb1i
        /DL2NHGerD/3hyAhvXsEAtro6zdKWwDNa9zy1QaOtg6RQLhNrf4Tv66bPg0l3oWPDsLns2
        qO7N/fWENyfI3hPnlaYH2f8FY0xh4Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648495855;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b48HkU5AT6k5eD0HbooXQFoyZSH1GZ+ADCsn4BviEdQ=;
        b=BrAL9QWplIi8aTpO1RCBjbs6HXsxcpcGgf65qDwWv55Eim8vSeiiLeyQQRi/hGcJjCxAwC
        PM6g4/uTYogIA+CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2BC5EA3BA2;
        Mon, 28 Mar 2022 19:30:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 199A1DA7F3; Mon, 28 Mar 2022 21:26:57 +0200 (CEST)
Date:   Mon, 28 Mar 2022 21:26:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Message-ID: <20220328192657.GU2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
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

On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:
> Running generic/406 causes the following WARNING in btrfs_destroy_inode()
> which tells there is outstanding extents left.
> 
> In btrfs_get_blocks_direct_write(), we reserve a temporary outstanding
> extents with btrfs_delalloc_reserve_metadata() (or indirectly from
> btrfs_delalloc_reserve_space(()). We then release the outstanding extents
> with btrfs_delalloc_release_extents(). However, the "len" can be modified
> in the CoW case, which releasing fewer outstanding extents than expected.
> 
> Fix it by calling btrfs_delalloc_release_extents() for the original length.
> 
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 757 at fs/btrfs/inode.c:8848 btrfs_destroy_inode+0x1e6/0x210 [btrfs]
>     Modules linked in: btrfs blake2b_generic xor lzo_compress
>     lzo_decompress raid6_pq zstd zstd_decompress zstd_compress xxhash zram
>     zsmalloc
>     CPU: 0 PID: 757 Comm: umount Not tainted 5.17.0-rc8+ #101
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb5a 04/01/2014
>     RIP: 0010:btrfs_destroy_inode+0x1e6/0x210 [btrfs]
>     Code: fe ff ff 0f 0b e9 d6 fe ff ff 0f 0b 48 83 bb e0 01 00 00 00 0f 84
>     65 fe ff ff 0f 0b 48 83 bb 78 ff ff ff 00 0f 84 63 fe ff ff <0f> 0b 48
>     83 bb 70 ff ff ff 00 0f 84 61 fe ff ff 0f 0b e9 5a fe ff
>     RSP: 0018:ffffc9000327bda8 EFLAGS: 00010206
>     RAX: 0000000000000000 RBX: ffff888100548b78 RCX: 0000000000000000
>     RDX: 0000000000026900 RSI: 0000000000000000 RDI: ffff888100548b78
>     RBP: ffff888100548940 R08: 0000000000000000 R09: ffff88810b48aba8
>     R10: 0000000000000001 R11: ffff8881004eb240 R12: ffff88810b48a800
>     R13: ffff88810b48ec08 R14: ffff88810b48ed00 R15: ffff888100490c68
>     FS:  00007f8549ea0b80(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00007f854a09e733 CR3: 000000010a2e9003 CR4: 0000000000370eb0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      <TASK>
>      destroy_inode+0x33/0x70
>      dispose_list+0x43/0x60
>      evict_inodes+0x161/0x1b0
>      generic_shutdown_super+0x2d/0x110
>      kill_anon_super+0xf/0x20
>      btrfs_kill_super+0xd/0x20 [btrfs]
>      deactivate_locked_super+0x27/0x90
>      cleanup_mnt+0x12c/0x180
>      task_work_run+0x54/0x80
>      exit_to_user_mode_prepare+0x152/0x160
>      syscall_exit_to_user_mode+0x12/0x30
>      do_syscall_64+0x42/0x80
>      entry_SYSCALL_64_after_hwframe+0x44/0xae
>     RIP: 0033:0x7f854a000fb7
> 
> Fixes: f0bfa76a11e9 ("btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range")
> CC: stable@vger.kernel.org # 5.17
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, with updated subject and changelog, thanks.
