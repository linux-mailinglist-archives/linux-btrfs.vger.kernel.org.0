Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D64B0FCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 15:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiBJOIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 09:08:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbiBJOIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 09:08:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB05F5;
        Thu, 10 Feb 2022 06:08:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 470541F391;
        Thu, 10 Feb 2022 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644502130;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKfbdMLq1uv0xXHacVm2GBmBm+0Pa3pnsnQQmDp1SRs=;
        b=tCS8fnro2eBglLgWwNj/Bhf1jwTIerc+rDKFSgdLLXSlshGhKv5BIA2Zaw5ve3CTPry2PQ
        EoLH2MS2up75IvH6Q37g+zjdq2s4+ao2X5Y78YoE+kf6jiLBDYWgSHDvWaDBDYwqyKwu3u
        3yshXktz6z68q4ewKy9MmdzFElIq8bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644502130;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKfbdMLq1uv0xXHacVm2GBmBm+0Pa3pnsnQQmDp1SRs=;
        b=IlyvGXydUeuFMwaAwUwYRSj0twVgFKnnVCaQABQQJizUUXKAXP3UHf80By6O7GN/VJEwOZ
        f9NnQWdypK0IkjCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 30644A3B87;
        Thu, 10 Feb 2022 14:08:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CCCEADA9BA; Thu, 10 Feb 2022 15:05:08 +0100 (CET)
Date:   Thu, 10 Feb 2022 15:05:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: prevent copying too big compressed lzo segment
Message-ID: <20220210140508.GN12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
References: <20220202214455.15753-1-davispuh@gmail.com>
 <20220202214455.15753-2-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202214455.15753-2-davispuh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 11:44:55PM +0200, Dāvis Mosāns wrote:
> Compressed length can be corrupted to be a lot larger than memory
> we have allocated for buffer.
> This will cause memcpy in copy_compressed_segment to write outside
> of allocated memory.
> 
> This mostly results in stuck read syscall but sometimes when using
> btrfs send can get #GP
> 
> kernel: general protection fault, probably for non-canonical address 0x841551d5c1000: 0000 [#1] PREEMPT SMP NOPTI
> kernel: CPU: 17 PID: 264 Comm: kworker/u256:7 Tainted: P           OE     5.17.0-rc2-1 #12
> kernel: Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> kernel: RIP: 0010:lzo_decompress_bio (./include/linux/fortify-string.h:225 fs/btrfs/lzo.c:322 fs/btrfs/lzo.c:394) btrfs
> Code starting with the faulting instruction
> ===========================================
>    0:*  48 8b 06                mov    (%rsi),%rax              <-- trapping instruction
>    3:   48 8d 79 08             lea    0x8(%rcx),%rdi
>    7:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
>    b:   48 89 01                mov    %rax,(%rcx)
>    e:   44 89 f0                mov    %r14d,%eax
>   11:   48 8b 54 06 f8          mov    -0x8(%rsi,%rax,1),%rdx
> kernel: RSP: 0018:ffffb110812efd50 EFLAGS: 00010212
> kernel: RAX: 0000000000001000 RBX: 000000009ca264c8 RCX: ffff98996e6d8ff8
> kernel: RDX: 0000000000000064 RSI: 000841551d5c1000 RDI: ffffffff9500435d
> kernel: RBP: ffff989a3be856c0 R08: 0000000000000000 R09: 0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000001000 R12: ffff98996e6d8000
> kernel: R13: 0000000000000008 R14: 0000000000001000 R15: 000841551d5c1000
> kernel: FS:  0000000000000000(0000) GS:ffff98a09d640000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00001e9f984d9ea8 CR3: 000000014971a000 CR4: 00000000003506e0
> kernel: Call Trace:
> kernel:  <TASK>
> kernel: end_compressed_bio_read (fs/btrfs/compression.c:104 fs/btrfs/compression.c:1363 fs/btrfs/compression.c:323) btrfs
> kernel: end_workqueue_fn (fs/btrfs/disk-io.c:1923) btrfs
> kernel: btrfs_work_helper (fs/btrfs/async-thread.c:326) btrfs
> kernel: process_one_work (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:212 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2312)
> kernel: worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2455)
> kernel: ? process_one_work (kernel/workqueue.c:2397)
> kernel: kthread (kernel/kthread.c:377)
> kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
> kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
> kernel:  </TASK>
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>

Thanks, added to misc-next. I've swapped the order of the patches so
that it's easier to backport the fix.
