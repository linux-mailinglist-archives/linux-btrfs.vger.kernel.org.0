Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F286C4DC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 15:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCVOdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjCVOdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 10:33:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C762D94
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 07:32:38 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bz27so11043502qtb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679495552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eteTpsLweyKCkxwj6Zv+dEw+CI76ZFy+fG9Gpn157Ig=;
        b=H9h8G4W5otSrCdL2dTVmnH19iVLUS3Ezzo50xNZzkiSkMaPWZhDJKpAaF7CnnLlWVl
         cGNrtsaekIFdOp7DNOTI6obzz4cVwarpJlDV+AksNSK7ZN1P7MxAk05kAm5X4uEth9fm
         LkimRefvqM4SmWkQe+Jc3ZTwLi9aOC2ADQgV2gmVuHbFN7cY3WwEsJRRVE7Zy8WtzaU4
         cL8UnDUljLO68QOoo6wg+OegJXoDkoO4gpOtDYJbZuR3jcIEl6xdtf6/qikadGuFPRPM
         0d2ccKJfxBA87cNMcUomfY5dYf/tfEGbicXOo1AZL/MVm4TIQ98p6lGzDXtrJF0+CC+S
         JF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eteTpsLweyKCkxwj6Zv+dEw+CI76ZFy+fG9Gpn157Ig=;
        b=OYw48pxpvtgAxRemo5TCZ9wRC90j6dArni5nU9HO6AYfpwGzCH6lTj/nbSe1fnKaBG
         ysDvPkPdPa79l/U1mePreluo7pythoNP6Pvzul8BHPBH3fk8Rr1wf0SKd4m+G2h61i16
         13dXNstuL2h0WXRtgGp2rutKBu6hsshThF6d1FlKWFC+tA2pMCk208NCIocX7iBnh/Ig
         2T4IXmVFAzXH7yCSNBUYggfGIuVR1K5wHxngcaGifsfSASN3EFOKMOHBdz0d0gqPjpjy
         6Mut2iUdhgwppejoLgAoMMkzxczVErbaqXtKB6SUXUB95dqNbcXp0M4rTOz19SG3zqDZ
         0USg==
X-Gm-Message-State: AO0yUKVzalWQna+6N2hr9vPsXcflsFro8EfJldZvE5PA9H19eYyEtZcQ
        XDsBzDMs8SL4PCPYBLJ2HBIMSMScK6mjpRB2UzjgeQ==
X-Google-Smtp-Source: AK7set+ylDXAXUIFM9sUF3Vo+CBZhhJMF/YXxOKSejlp9q062zvh3ti5RoLcIternjOuTPlkHUZQRg==
X-Received: by 2002:ac8:570e:0:b0:3e2:6a40:5630 with SMTP id 14-20020ac8570e000000b003e26a405630mr5995752qtw.21.1679495551980;
        Wed, 22 Mar 2023 07:32:31 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id c20-20020ac86614000000b003e1080e0f8csm5828413qtp.16.2023.03.22.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:32:31 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:32:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix deadlock when aborting transaction during
 relocation with scrub
Message-ID: <20230322143230.GA2169647@perftesting>
References: <2f4ff5c22d01e1d92d9458c4069531d911fa7418.1679478272.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4ff5c22d01e1d92d9458c4069531d911fa7418.1679478272.git.fdmanana@suse.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 09:46:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Before relocating a block group we pause scrub, then do the relocation and
> then unpause scrub. The relocation process requires starting and committing
> a transaction, and if we have a failure in the critical section of the
> transaction commit path (transaction state >= TRANS_STATE_COMMIT_START),
> we will deadlock if there is a paused scrub.
> 
> That results in stack traces like the following:
> 
>    [ 8242.479915] BTRFS info (device sdc): relocating block group 53876686848 flags metadata|raid6
>    [ 8242.936437] BTRFS warning (device sdc): Skipping commit of aborted transaction.
>    [ 8242.936441] ------------[ cut here ]------------
>    [ 8242.936441] BTRFS: Transaction aborted (error -28)
>    [ 8242.936490] WARNING: CPU: 11 PID: 346822 at fs/btrfs/transaction.c:1977 btrfs_commit_transaction+0xcc8/0xeb0 [btrfs]
>    [ 8242.936544] Modules linked in: dm_flakey dm_mod loop btrfs (...)
>    [ 8242.936582] CPU: 11 PID: 346822 Comm: btrfs Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8242.936584] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>    [ 8242.936585] RIP: 0010:btrfs_commit_transaction+0xcc8/0xeb0 [btrfs]
>    [ 8242.936625] Code: ff ff 45 8b (...)
>    [ 8242.936627] RSP: 0018:ffffb58649633b48 EFLAGS: 00010282
>    [ 8242.936628] RAX: 0000000000000000 RBX: ffff8be6ef4d5bd8 RCX: 0000000000000000
>    [ 8242.936629] RDX: 0000000000000002 RSI: ffffffffb35e7782 RDI: 00000000ffffffff
>    [ 8242.936630] RBP: ffff8be6ef4d5c98 R08: 0000000000000000 R09: ffffb586496339e8
>    [ 8242.936632] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8be6d38c7c00
>    [ 8242.936632] R13: 00000000ffffffe4 R14: ffff8be6c268c000 R15: ffff8be6ef4d5cf0
>    [ 8242.936633] FS:  00007f381a82b340(0000) GS:ffff8beddfcc0000(0000) knlGS:0000000000000000
>    [ 8242.936635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [ 8242.936636] CR2: 00007f1e35fb7638 CR3: 0000000117680006 CR4: 0000000000370ee0
>    [ 8242.936638] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [ 8242.936639] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [ 8242.936640] Call Trace:
>    [ 8242.936642]  <TASK>
>    [ 8242.936644]  ? start_transaction+0xcb/0x610 [btrfs]
>    [ 8242.936684]  prepare_to_relocate+0x111/0x1a0 [btrfs]
>    [ 8242.936734]  relocate_block_group+0x57/0x5d0 [btrfs]
>    [ 8242.936781]  ? btrfs_wait_nocow_writers+0x25/0xb0 [btrfs]
>    [ 8242.936827]  btrfs_relocate_block_group+0x248/0x3c0 [btrfs]
>    [ 8242.936873]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8242.936877]  btrfs_relocate_chunk+0x3b/0x150 [btrfs]
>    [ 8242.936927]  btrfs_balance+0x8ff/0x11d0 [btrfs]
>    [ 8242.936973]  ? __kmem_cache_alloc_node+0x14a/0x410
>    [ 8242.936976]  btrfs_ioctl+0x2334/0x32c0 [btrfs]
>    [ 8242.937024]  ? mod_objcg_state+0xd2/0x360
>    [ 8242.937028]  ? refill_obj_stock+0xb0/0x160
>    [ 8242.937030]  ? seq_release+0x25/0x30
>    [ 8242.937041]  ? __rseq_handle_notify_resume+0x3b5/0x4b0
>    [ 8242.937043]  ? percpu_counter_add_batch+0x2e/0xa0
>    [ 8242.937048]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8242.937050]  __x64_sys_ioctl+0x88/0xc0
>    [ 8242.937052]  do_syscall_64+0x38/0x90
>    [ 8242.937056]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8242.937058] RIP: 0033:0x7f381a6ffe9b
>    [ 8242.937060] Code: 00 48 89 44 24 (...)
>    [ 8242.937062] RSP: 002b:00007ffd45ecf060 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8242.937064] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f381a6ffe9b
>    [ 8242.937065] RDX: 00007ffd45ecf150 RSI: 00000000c4009420 RDI: 0000000000000003
>    [ 8242.937066] RBP: 0000000000000003 R08: 0000000000000013 R09: 0000000000000000
>    [ 8242.937066] R10: 00007f381a60c878 R11: 0000000000000246 R12: 00007ffd45ed0423
>    [ 8242.937067] R13: 00007ffd45ecf150 R14: 0000000000000000 R15: 00007ffd45ecf148
>    [ 8242.937070]  </TASK>
>    [ 8242.937071] ---[ end trace 0000000000000000 ]---
>    [ 8242.937075] BTRFS: error (device sdc: state A) in cleanup_transaction:1977: errno=-28 No space left
>    [ 8459.196386] INFO: task btrfs:346772 blocked for more than 120 seconds.
>    [ 8459.196564]       Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8459.196706] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    [ 8459.196845] task:btrfs           state:D stack:0     pid:346772 ppid:1      flags:0x00004002
>    [ 8459.196861] Call Trace:
>    [ 8459.196866]  <TASK>
>    [ 8459.196876]  __schedule+0x392/0xa70
>    [ 8459.196906]  ? __pv_queued_spin_lock_slowpath+0x165/0x370
>    [ 8459.196923]  schedule+0x5d/0xd0
>    [ 8459.196937]  __scrub_blocked_if_needed+0x74/0xc0 [btrfs]
>    [ 8459.197226]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.197242]  scrub_pause_off+0x21/0x50 [btrfs]
>    [ 8459.197507]  scrub_simple_mirror+0x1c7/0x950 [btrfs]
>    [ 8459.197769]  ? scrub_parity_put+0x1a5/0x1d0 [btrfs]
>    [ 8459.198065]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.198090]  scrub_stripe+0x20d/0x740 [btrfs]
>    [ 8459.198360]  scrub_chunk+0xc4/0x130 [btrfs]
>    [ 8459.198621]  scrub_enumerate_chunks+0x3e4/0x7a0 [btrfs]
>    [ 8459.198885]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.198901]  btrfs_scrub_dev+0x236/0x6a0 [btrfs]
>    [ 8459.199162]  ? btrfs_ioctl+0xd97/0x32c0 [btrfs]
>    [ 8459.199420]  ? _copy_from_user+0x7b/0x80
>    [ 8459.199435]  btrfs_ioctl+0xde1/0x32c0 [btrfs]
>    [ 8459.199693]  ? refill_stock+0x33/0x50
>    [ 8459.199707]  ? should_failslab+0xa/0x20
>    [ 8459.199721]  ? kmem_cache_alloc_node+0x151/0x460
>    [ 8459.199731]  ? alloc_io_context+0x1b/0x80
>    [ 8459.199744]  ? preempt_count_add+0x70/0xa0
>    [ 8459.199759]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8459.199770]  __x64_sys_ioctl+0x88/0xc0
>    [ 8459.199783]  do_syscall_64+0x38/0x90
>    [ 8459.199796]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8459.199808] RIP: 0033:0x7f82ffaffe9b
>    [ 8459.199817] RSP: 002b:00007f82ff9fcc50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8459.199827] RAX: ffffffffffffffda RBX: 000055b191e36310 RCX: 00007f82ffaffe9b
>    [ 8459.199833] RDX: 000055b191e36310 RSI: 00000000c400941b RDI: 0000000000000003
>    [ 8459.199838] RBP: 0000000000000000 R08: 00007fff1575016f R09: 0000000000000000
>    [ 8459.199844] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82ff9fd640
>    [ 8459.199849] R13: 000000000000006b R14: 00007f82ffa87580 R15: 0000000000000000
>    [ 8459.199863]  </TASK>
>    [ 8459.199868] INFO: task btrfs:346773 blocked for more than 120 seconds.
>    [ 8459.200013]       Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8459.200126] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    [ 8459.201363] task:btrfs           state:D stack:0     pid:346773 ppid:1      flags:0x00004002
>    [ 8459.201376] Call Trace:
>    [ 8459.201380]  <TASK>
>    [ 8459.201387]  __schedule+0x392/0xa70
>    [ 8459.201399]  ? __pv_queued_spin_lock_slowpath+0x165/0x370
>    [ 8459.201415]  schedule+0x5d/0xd0
>    [ 8459.201425]  __scrub_blocked_if_needed+0x74/0xc0 [btrfs]
>    [ 8459.201697]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.201712]  scrub_pause_off+0x21/0x50 [btrfs]
>    [ 8459.202001]  scrub_simple_mirror+0x1c7/0x950 [btrfs]
>    [ 8459.202261]  ? scrub_parity_put+0x1a5/0x1d0 [btrfs]
>    [ 8459.202526]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.202550]  scrub_stripe+0x20d/0x740 [btrfs]
>    [ 8459.202820]  scrub_chunk+0xc4/0x130 [btrfs]
>    [ 8459.203081]  scrub_enumerate_chunks+0x3e4/0x7a0 [btrfs]
>    [ 8459.203345]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.203361]  btrfs_scrub_dev+0x236/0x6a0 [btrfs]
>    [ 8459.203621]  ? btrfs_ioctl+0xd97/0x32c0 [btrfs]
>    [ 8459.203877]  ? _copy_from_user+0x7b/0x80
>    [ 8459.203891]  btrfs_ioctl+0xde1/0x32c0 [btrfs]
>    [ 8459.204152]  ? should_failslab+0xa/0x20
>    [ 8459.204166]  ? kmem_cache_alloc_node+0x151/0x460
>    [ 8459.204231]  ? alloc_io_context+0x1b/0x80
>    [ 8459.204245]  ? preempt_count_add+0x70/0xa0
>    [ 8459.204259]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8459.204270]  __x64_sys_ioctl+0x88/0xc0
>    [ 8459.204283]  do_syscall_64+0x38/0x90
>    [ 8459.204295]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8459.204305] RIP: 0033:0x7f82ffaffe9b
>    [ 8459.204312] RSP: 002b:00007f82ff1fbc50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8459.204321] RAX: ffffffffffffffda RBX: 000055b191e36790 RCX: 00007f82ffaffe9b
>    [ 8459.204326] RDX: 000055b191e36790 RSI: 00000000c400941b RDI: 0000000000000003
>    [ 8459.204331] RBP: 0000000000000000 R08: 00007fff1575016f R09: 0000000000000000
>    [ 8459.204336] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82ff1fc640
>    [ 8459.204341] R13: 000000000000006b R14: 00007f82ffa87580 R15: 0000000000000000
>    [ 8459.204355]  </TASK>
>    [ 8459.204359] INFO: task btrfs:346774 blocked for more than 120 seconds.
>    [ 8459.205156]       Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8459.205882] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    [ 8459.206615] task:btrfs           state:D stack:0     pid:346774 ppid:1      flags:0x00004002
>    [ 8459.206627] Call Trace:
>    [ 8459.206632]  <TASK>
>    [ 8459.206639]  __schedule+0x392/0xa70
>    [ 8459.206656]  schedule+0x5d/0xd0
>    [ 8459.206666]  __scrub_blocked_if_needed+0x74/0xc0 [btrfs]
>    [ 8459.206922]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.206938]  scrub_pause_off+0x21/0x50 [btrfs]
>    [ 8459.207207]  scrub_simple_mirror+0x1c7/0x950 [btrfs]
>    [ 8459.207475]  ? scrub_parity_put+0x1a5/0x1d0 [btrfs]
>    [ 8459.207727]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.207751]  scrub_stripe+0x20d/0x740 [btrfs]
>    [ 8459.208008]  scrub_chunk+0xc4/0x130 [btrfs]
>    [ 8459.208323]  scrub_enumerate_chunks+0x3e4/0x7a0 [btrfs]
>    [ 8459.208579]  ? __mutex_unlock_slowpath.isra.0+0x9a/0x120
>    [ 8459.208594]  btrfs_scrub_dev+0x236/0x6a0 [btrfs]
>    [ 8459.208845]  ? btrfs_ioctl+0xd97/0x32c0 [btrfs]
>    [ 8459.209087]  ? _copy_from_user+0x7b/0x80
>    [ 8459.209100]  btrfs_ioctl+0xde1/0x32c0 [btrfs]
>    [ 8459.209350]  ? should_failslab+0xa/0x20
>    [ 8459.209363]  ? kmem_cache_alloc_node+0x151/0x460
>    [ 8459.209373]  ? alloc_io_context+0x1b/0x80
>    [ 8459.209385]  ? preempt_count_add+0x70/0xa0
>    [ 8459.209399]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8459.209410]  __x64_sys_ioctl+0x88/0xc0
>    [ 8459.209423]  do_syscall_64+0x38/0x90
>    [ 8459.209434]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8459.209444] RIP: 0033:0x7f82ffaffe9b
>    [ 8459.209450] RSP: 002b:00007f82fe9fac50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8459.209459] RAX: ffffffffffffffda RBX: 000055b191e36c10 RCX: 00007f82ffaffe9b
>    [ 8459.209465] RDX: 000055b191e36c10 RSI: 00000000c400941b RDI: 0000000000000003
>    [ 8459.209470] RBP: 0000000000000000 R08: 00007fff1575016f R09: 0000000000000000
>    [ 8459.209474] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82fe9fb640
>    [ 8459.209479] R13: 000000000000006b R14: 00007f82ffa87580 R15: 0000000000000000
>    [ 8459.209493]  </TASK>
>    [ 8459.209497] INFO: task btrfs:346775 blocked for more than 120 seconds.
>    [ 8459.210219]       Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8459.210933] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    [ 8459.211670] task:btrfs           state:D stack:0     pid:346775 ppid:1      flags:0x00004002
>    [ 8459.211682] Call Trace:
>    [ 8459.211686]  <TASK>
>    [ 8459.211692]  __schedule+0x392/0xa70
>    [ 8459.211708]  schedule+0x5d/0xd0
>    [ 8459.211717]  __scrub_blocked_if_needed+0x74/0xc0 [btrfs]
>    [ 8459.211973]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.211988]  scrub_pause_off+0x21/0x50 [btrfs]
>    [ 8459.212303]  scrub_simple_mirror+0x1c7/0x950 [btrfs]
>    [ 8459.212555]  ? scrub_parity_put+0x1a5/0x1d0 [btrfs]
>    [ 8459.212813]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.212836]  scrub_stripe+0x20d/0x740 [btrfs]
>    [ 8459.213097]  scrub_chunk+0xc4/0x130 [btrfs]
>    [ 8459.213347]  scrub_enumerate_chunks+0x3e4/0x7a0 [btrfs]
>    [ 8459.213603]  ? __mutex_unlock_slowpath.isra.0+0x9a/0x120
>    [ 8459.213617]  btrfs_scrub_dev+0x236/0x6a0 [btrfs]
>    [ 8459.213869]  ? btrfs_ioctl+0xd97/0x32c0 [btrfs]
>    [ 8459.214241]  ? _copy_from_user+0x7b/0x80
>    [ 8459.214264]  btrfs_ioctl+0xde1/0x32c0 [btrfs]
>    [ 8459.214527]  ? should_failslab+0xa/0x20
>    [ 8459.214540]  ? kmem_cache_alloc_node+0x151/0x460
>    [ 8459.214550]  ? alloc_io_context+0x1b/0x80
>    [ 8459.214562]  ? preempt_count_add+0x70/0xa0
>    [ 8459.214577]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8459.214588]  __x64_sys_ioctl+0x88/0xc0
>    [ 8459.214600]  do_syscall_64+0x38/0x90
>    [ 8459.214612]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8459.214622] RIP: 0033:0x7f82ffaffe9b
>    [ 8459.214628] RSP: 002b:00007f82fe1f9c50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8459.214637] RAX: ffffffffffffffda RBX: 000055b191e37090 RCX: 00007f82ffaffe9b
>    [ 8459.214642] RDX: 000055b191e37090 RSI: 00000000c400941b RDI: 0000000000000003
>    [ 8459.214647] RBP: 0000000000000000 R08: 00007fff1575016f R09: 0000000000000000
>    [ 8459.214652] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82fe1fa640
>    [ 8459.214657] R13: 000000000000006b R14: 00007f82ffa87580 R15: 0000000000000000
>    [ 8459.214671]  </TASK>
>    [ 8459.214675] INFO: task btrfs:346776 blocked for more than 120 seconds.
>    [ 8459.215457]       Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8459.216311] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    [ 8459.217124] task:btrfs           state:D stack:0     pid:346776 ppid:1      flags:0x00004002
>    [ 8459.217136] Call Trace:
>    [ 8459.217140]  <TASK>
>    [ 8459.217147]  __schedule+0x392/0xa70
>    [ 8459.217158]  ? __pv_queued_spin_lock_slowpath+0x165/0x370
>    [ 8459.217174]  schedule+0x5d/0xd0
>    [ 8459.217183]  __scrub_blocked_if_needed+0x74/0xc0 [btrfs]
>    [ 8459.217438]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.217452]  scrub_pause_off+0x21/0x50 [btrfs]
>    [ 8459.217699]  scrub_simple_mirror+0x1c7/0x950 [btrfs]
>    [ 8459.217946]  ? scrub_parity_put+0x1a5/0x1d0 [btrfs]
>    [ 8459.218231]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.218255]  scrub_stripe+0x20d/0x740 [btrfs]
>    [ 8459.218514]  scrub_chunk+0xc4/0x130 [btrfs]
>    [ 8459.218764]  scrub_enumerate_chunks+0x3e4/0x7a0 [btrfs]
>    [ 8459.219018]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.219033]  btrfs_scrub_dev+0x236/0x6a0 [btrfs]
>    [ 8459.219284]  ? btrfs_ioctl+0xd97/0x32c0 [btrfs]
>    [ 8459.219527]  ? _copy_from_user+0x7b/0x80
>    [ 8459.219540]  btrfs_ioctl+0xde1/0x32c0 [btrfs]
>    [ 8459.219790]  ? should_failslab+0xa/0x20
>    [ 8459.219802]  ? kmem_cache_alloc_node+0x151/0x460
>    [ 8459.219812]  ? alloc_io_context+0x1b/0x80
>    [ 8459.219824]  ? preempt_count_add+0x70/0xa0
>    [ 8459.219838]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8459.219849]  __x64_sys_ioctl+0x88/0xc0
>    [ 8459.219862]  do_syscall_64+0x38/0x90
>    [ 8459.219873]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8459.219883] RIP: 0033:0x7f82ffaffe9b
>    [ 8459.219889] RSP: 002b:00007f82fd9f8c50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8459.219897] RAX: ffffffffffffffda RBX: 000055b191e37510 RCX: 00007f82ffaffe9b
>    [ 8459.219902] RDX: 000055b191e37510 RSI: 00000000c400941b RDI: 0000000000000003
>    [ 8459.219907] RBP: 0000000000000000 R08: 00007fff1575016f R09: 0000000000000000
>    [ 8459.219912] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f82fd9f9640
>    [ 8459.219917] R13: 000000000000006b R14: 00007f82ffa87580 R15: 0000000000000000
>    [ 8459.219931]  </TASK>
>    [ 8459.219937] INFO: task btrfs:346822 blocked for more than 120 seconds.
>    [ 8459.220815]       Tainted: G        W          6.3.0-rc2-btrfs-next-127+ #1
>    [ 8459.221633] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    [ 8459.222504] task:btrfs           state:D stack:0     pid:346822 ppid:1      flags:0x00004002
>    [ 8459.222516] Call Trace:
>    [ 8459.222519]  <TASK>
>    [ 8459.222526]  __schedule+0x392/0xa70
>    [ 8459.222542]  schedule+0x5d/0xd0
>    [ 8459.222552]  btrfs_scrub_cancel+0x91/0x100 [btrfs]
>    [ 8459.222804]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.222819]  btrfs_commit_transaction+0x572/0xeb0 [btrfs]
>    [ 8459.223026]  ? start_transaction+0xcb/0x610 [btrfs]
>    [ 8459.223234]  prepare_to_relocate+0x111/0x1a0 [btrfs]
>    [ 8459.223482]  relocate_block_group+0x57/0x5d0 [btrfs]
>    [ 8459.223730]  ? btrfs_wait_nocow_writers+0x25/0xb0 [btrfs]
>    [ 8459.223965]  btrfs_relocate_block_group+0x248/0x3c0 [btrfs]
>    [ 8459.224277]  ? __pfx_autoremove_wake_function+0x10/0x10
>    [ 8459.224292]  btrfs_relocate_chunk+0x3b/0x150 [btrfs]
>    [ 8459.224539]  btrfs_balance+0x8ff/0x11d0 [btrfs]
>    [ 8459.224787]  ? __kmem_cache_alloc_node+0x14a/0x410
>    [ 8459.224804]  btrfs_ioctl+0x2334/0x32c0 [btrfs]
>    [ 8459.225049]  ? mod_objcg_state+0xd2/0x360
>    [ 8459.225062]  ? refill_obj_stock+0xb0/0x160
>    [ 8459.225072]  ? seq_release+0x25/0x30
>    [ 8459.225083]  ? __rseq_handle_notify_resume+0x3b5/0x4b0
>    [ 8459.225093]  ? percpu_counter_add_batch+0x2e/0xa0
>    [ 8459.225111]  ? __x64_sys_ioctl+0x88/0xc0
>    [ 8459.225122]  __x64_sys_ioctl+0x88/0xc0
>    [ 8459.225134]  do_syscall_64+0x38/0x90
>    [ 8459.225146]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>    [ 8459.225155] RIP: 0033:0x7f381a6ffe9b
>    [ 8459.225161] RSP: 002b:00007ffd45ecf060 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    [ 8459.225169] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f381a6ffe9b
>    [ 8459.225175] RDX: 00007ffd45ecf150 RSI: 00000000c4009420 RDI: 0000000000000003
>    [ 8459.225179] RBP: 0000000000000003 R08: 0000000000000013 R09: 0000000000000000
>    [ 8459.225184] R10: 00007f381a60c878 R11: 0000000000000246 R12: 00007ffd45ed0423
>    [ 8459.225189] R13: 00007ffd45ecf150 R14: 0000000000000000 R15: 00007ffd45ecf148
>    [ 8459.225203]  </TASK>
> 
> What happens is the following:
> 
> 1) A scrub is running, so fs_info->scrubs_running is 1;
> 
> 2) Task A starts block group relocation, and at btrfs_relocate_chunk() it
>    pauses scrub by calling btrfs_scrub_pause(). That increments
>    fs_info->scrub_pause_req from 0 to 1 and waits for the scrub task to
>    pause (for fs_info->scrubs_paused to be == to fs_info->scrubs_running);
> 
> 3) The scrub task pauses at scrub_pause_off(), waiting for
>    fs_info->scrub_pause_req to decrease to 0;
> 
> 4) Task A then enters btrfs_relocate_block_group(), and down that call
>    chain we start a transaction and then attempt to commit it;
> 
> 5) When task A calls btrfs_commit_transaction(), it either will do the
>    commit itself or wait for some other task that already started the
>    commit of the transaction - it doesn't matter which case;
> 
> 6) The transaction commit enters state TRANS_STATE_COMMIT_START;
> 
> 7) An error happens during the transaction commit, like -ENOSPC when
>    running delayed refs or delayed items for example;
> 
> 8) This results in calling transaction.c:cleanup_transaction(), where
>    we call btrfs_scrub_cancel(), incrementing fs_info->scrub_cancel_req
>    from 0 to 1, and blocking this task waiting for fs_info->scrubs_running
>    to decrease to 0;
> 
> 9) From this point on, both the transaction commit and the scrub task
>    hang forever:
> 
>    1) The transaction commit is waiting for fs_info->scrubs_running to
>       be decreased to 0;
> 
>    2) The scrub task is at scrub_pause_off() waiting for
>       fs_info->scrub_pause_req to decrease to 0 - so it can not proceed
>       to stop the scrub and decrement fs_info->scrubs_running from 0 to 1.
> 
>    Therefore resulting in a deadlock.
> 
> Fix this by having cleanup_transaction(), called if a transaction commit
> fails, not call btrfs_scrub_cancel() if relocation is in progress, and
> having btrfs_relocate_block_group() call btrfs_scrub_cancel() instead if
> the relocation failed and a transaction abort happened.
> 
> This was triggered with btrfs/061 from fstests.
> 
> Fixes: 55e3a601c81c ("btrfs: Fix data checksum error cause by replace with io-load.")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
