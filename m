Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76F6C5BC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 02:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCWBUS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 22 Mar 2023 21:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCWBUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 21:20:17 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2832B611
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 18:20:14 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id oe8so370147qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 18:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679534413;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIxMn5T5ryTr2cMqWZH5JVIASp4wiMaDT2WKn/8c/cU=;
        b=b+m/g7lKdOb77vV+0iqnlnJLggb+hm7QVyuTx4gI+Unsim+qPEdqN3ak9i34IQ/unq
         F7zHi2YZB+HdE9HgnBSl6pnGOlhVE1hfyYik8k2iQ2p16tiiN2GenRNONkiM1mAmooHk
         I+DVgneEXvs+U//v3nvnqXHaoIJdJgKL4Z7btG+kIcQ96+2rcq+7rYeFxyplbENdFeWz
         xaz5S5MLowcX6FGx1kRTIGji3fH3ZtWLu3vFsQAFiKezhUJroLjSfHXJFYo5ynLDuv8G
         PVIU8VVnOuY7N52/4yWA62+nWP2CWfCdgLoWTzeBXX7g6CVjusVYyi3/nOOx2pJCNxjA
         Cg5g==
X-Gm-Message-State: AO0yUKU3bds0pJ+hsfUJJH5AizihFMsBHj3zYlcUxh0YUyI0VO0R9hW4
        RNUokXb0eLxlgO0n/YvoZ9LswsxfkN0=
X-Google-Smtp-Source: AK7set8yzTbNQd9fJrHyfyNBlYi45JsmCxCa1VwwSNVQ2IYMpodFtoAckAdgmNPHg23UZ+kACgCPDg==
X-Received: by 2002:ad4:5aad:0:b0:56f:9d:1e29 with SMTP id u13-20020ad45aad000000b0056f009d1e29mr10755223qvg.21.1679534412185;
        Wed, 22 Mar 2023 18:20:12 -0700 (PDT)
Received: from smtpclient.apple ([2601:47:4301:d340:d8ab:9846:3158:99f8])
        by smtp.gmail.com with ESMTPSA id 141-20020a370793000000b0074672975d5csm8085745qkh.91.2023.03.22.18.20.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 18:20:11 -0700 (PDT)
From:   David Ryskalczyk <david@rysk.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Kernel panic due to stack recursion when copying data from a damaged
 filesystem
Message-Id: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
Date:   Wed, 22 Mar 2023 21:20:00 -0400
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

In the process of transferring data from a damaged filesystem, I came across a file which would panic the system upon reading. Further debugging indicates that this is due to recursion in btrfs_repair_one_sector.

While I do not expect this file to be recoverable, a recursion limit to prevent kernel panic and system lockup would be worthwhile.

Error log and stack trace follows (kernel version is 6.2.6, kasan enabled).

[  252.752577] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 1 wanted 0 found 1
[  252.806147] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 2 wanted 0 found 1
[  252.848313] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 3 wanted 0 found 1
[  252.898989] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 4 wanted 0 found 1
** Above four lines repeated an additional 24 times
[  254.601885] BUG: TASK stack guard page was hit at 000000000b8efb37 (stack is 00000000e95f2615..000000008aa34447)
[  254.603929] stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  254.604763] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
[  254.604874] RIP: 0010:kasan_check_range (mm/kasan/generic.c:188) 
[ 254.605650] Code: 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 6e 01 00 00 49 89 f9 41 54 44 0f b6 c2 <55> 53 49 01 f1 0f 82 15 01 00 0
All code
========
   0:	00 0f                	add    %cl,(%rdi)
   2:	1f                   	(bad)
   3:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	66 0f 1f 00          	nopw   (%rax)
  18:	48 85 f6             	test   %rsi,%rsi
  1b:	0f 84 6e 01 00 00    	je     0x18f
  21:	49 89 f9             	mov    %rdi,%r9
  24:	41 54                	push   %r12
  26:	44 0f b6 c2          	movzbl %dl,%r8d
  2a:*	55                   	push   %rbp		<-- trapping instruction
  2b:	53                   	push   %rbx
  2c:	49 01 f1             	add    %rsi,%r9
  2f:	0f 82 15 01 00 00    	jb     0x14a

Code starting with the faulting instruction
===========================================
   0:	55                   	push   %rbp
   1:	53                   	push   %rbx
   2:	49 01 f1             	add    %rsi,%r9
   5:	0f 82 15 01 00 00    	jb     0x120
[  254.605703] RSP: 0018:ffffc90003cd0000 EFLAGS: 00000002
[  254.606299] RAX: ffff8881097c6000 RBX: ffffc90003cd0080 RCX: ffffffffa3366ec3
[  254.606327] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffc90003cd0080
[  254.606351] RBP: 0000000000000070 R08: 0000000000000001 R09: ffffc90003cd0080
[  254.606375] R10: fffff5200079a07d R11: ffffffffa6f274a0 R12: 0000000000000000
[  254.606399] R13: ffffc90003cd0150 R14: ffffc90003cd0080 R15: ffffc90003cd00a8
[  254.606447] FS:  00007f324a860740(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
[  254.606477] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  254.606489] CR2: ffffc90003ccfff8 CR3: 0000000106af4000 CR4: 00000000000006f0
[  254.606598] Call Trace:
[  254.606713]  <TASK>
[  254.606796] memset (mm/kasan/shadow.c:44) 
[  254.606837] __unwind_start (arch/x86/kernel/unwind_orc.c:665) 
[  254.606860] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:770) btrfs
[  254.607437] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:770) btrfs
[  254.607722] ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83) 
[  254.607737] arch_stack_walk (arch/x86/kernel/stacktrace.c:24) 
[  254.607761] stack_trace_save (kernel/stacktrace.c:123) 
[  254.607772] ? __pfx_stack_trace_save (kernel/stacktrace.c:114) 
[  254.607787] ? __sbitmap_get_word (./arch/x86/include/asm/bitops.h:138 ./arch/x86/include/asm/bitops.h:144 ./include/asm-generic/bitops/instrumented-lock.h:58 lib/sbitmap.c:159) 
[  254.607803] kasan_save_stack (mm/kasan/common.c:46) 
[  254.607848] __kasan_record_aux_stack (mm/kasan/generic.c:493) 
[  254.607860] insert_work (./include/linux/instrumented.h:72 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
[  254.607873] ? __pfx_timer_delete (kernel/time/timer.c:1360) 
[  254.607886] __queue_work (kernel/workqueue.c:1520) 
[  254.607899] ? try_to_grab_pending (./arch/x86/include/asm/bitops.h:138 ./include/asm-generic/bitops/instrumented-atomic.h:72 kernel/workqueue.c:1280) 
[  254.607912] mod_delayed_work_on (./arch/x86/include/asm/irqflags.h:137 kernel/workqueue.c:1740) 
[  254.607924] ? __pfx_mod_delayed_work_on (kernel/workqueue.c:1730) 
[  254.607937] ? __blk_mq_delay_run_hw_queue (block/blk-mq.c:2203 block/blk-mq.c:2262) 
[  254.607953] kblockd_mod_delayed_work_on (block/blk-core.c:1039) 
[  254.607964] blk_mq_sched_insert_requests (./include/linux/rcupdate.h:771 ./include/linux/percpu-refcount.h:330 ./include/linux/percpu-refcount.h:351 block/blk-mq-sched.c:494) 
[  254.607981] blk_mq_flush_plug_list (block/blk-mq.c:2808) 
[  254.607997] ? __pfx_blk_mq_flush_plug_list (block/blk-mq.c:2769) 
[  254.608009] ? __pfx___submit_bio (block/blk-core.c:596) 
[  254.608028] __blk_flush_plug (block/blk-core.c:1152) 
[  254.608039] ? psi_group_change (./arch/x86/include/asm/bitops.h:207 (discriminator 1) ./arch/x86/include/asm/bitops.h:239 (discriminator 1) ./include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) kernel/sched/psi.c:857 (discriminator 1)) 
[  254.608051] ? __pfx_sched_clock_cpu (kernel/sched/clock.c:364) 
[  254.608063] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:543 ./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186 ./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[  254.608079] ? __pfx___blk_flush_plug (block/blk-core.c:1141) 
[  254.608091] ? _raw_spin_lock_irq (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:543 ./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186 ./include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[  254.608103] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169) 
[  254.608114] ? psi_task_change (kernel/sched/psi.c:901 (discriminator 1)) 
[  254.608128] io_schedule (kernel/sched/core.c:8871) 
[  254.608143] folio_wait_bit_common (mm/filemap.c:1286) 
[  254.608160] ? __pfx_folio_wait_bit_common (mm/filemap.c:1220) 
[  254.608171] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.608485] ? __pfx_submit_extent_page (fs/btrfs/extent_io.c:1474) btrfs
[  254.608766] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.609047] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.609339] ? __pfx_wake_page_function (mm/filemap.c:1079) 
[  254.609356] ? submit_one_bio (fs/btrfs/extent_io.c:156) btrfs
[  254.609642] read_extent_buffer_pages (./include/linux/pagemap.h:1024 ./include/linux/pagemap.h:1036 fs/btrfs/extent_io.c:5029) btrfs
[  254.609932] ? __pfx_read_extent_buffer_pages (fs/btrfs/extent_io.c:4919) btrfs
[  254.610214] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[  254.610230] ? __pfx_end_bio_extent_readpage (fs/btrfs/extent_io.c:1077) btrfs
[  254.610516] ? folio_unlock (./arch/x86/include/asm/bitops.h:101 ./include/asm-generic/bitops/instrumented-lock.h:78 mm/filemap.c:1526) 
[  254.610530] btrfs_read_extent_buffer (fs/btrfs/disk-io.c:303) btrfs
[  254.610804] read_tree_block (fs/btrfs/disk-io.c:1025) btrfs
[  254.611070] ? find_extent_buffer (fs/btrfs/extent_io.c:4328) btrfs
[  254.611357] read_block_for_search (fs/btrfs/ctree.c:1620) btrfs
[  254.611615] ? rwsem_down_read_slowpath (./include/trace/events/lock.h:95 ./include/trace/events/lock.h:95 kernel/locking/rwsem.c:1077) 
[  254.611630] ? __pfx_read_block_for_search (fs/btrfs/ctree.c:1533) btrfs
[  254.611901] btrfs_search_slot (fs/btrfs/ctree.c:2225) btrfs
[  254.612166] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.612448] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.612738] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.613020] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.613312] ? __pfx_btrfs_search_slot (fs/btrfs/ctree.c:2037) btrfs
[  254.613567] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.613858] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.614152] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.614441] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.614733] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.615012] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.615301] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.615581] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.615869] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.616152] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.616443] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.616726] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.617016] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.617297] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.617587] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.617868] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.618161] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.618448] btrfs_lookup_csum (fs/btrfs/file-item.c:221) btrfs
[  254.618713] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.618996] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.619289] ? __pfx_btrfs_lookup_csum (fs/btrfs/file-item.c:207) btrfs
[  254.619555] ? _raw_write_lock_irqsave (./include/asm-generic/qrwlock.h:101 ./include/linux/rwlock_api_smp.h:187 kernel/locking/spinlock.c:318) 
[  254.619570] ? btrfs_csum_root (fs/btrfs/disk-io.c:1236) btrfs
[  254.619838] ? __pfx_btrfs_csum_root (fs/btrfs/disk-io.c:1236) btrfs
[  254.620108] ? _kmem_cache_alloc (mm/slub.c:3454 mm/slub.c:3460 mm/slub.c:3467 mm/slub.c:3476) 
[  254.620124] btrfs_lookup_bio_sums (fs/btrfs/file-item.c:315 fs/btrfs/file-item.c:484) btrfs
[  254.620393] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.620680] ? end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.620972] ? btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.621254] ? bio_init (./arch/x86/include/asm/atomic.h:41 ./include/linux/atomic/atomic-instrumented.h:42 block/bio.c:280) 
[  254.621273] ? __pfx_btrfs_lookup_bio_sums (fs/btrfs/file-item.c:393) btrfs
[  254.621540] ? bio_add_page (block/bio.c:1146) 
[  254.621551] ? __pfx_bio_add_page (block/bio.c:1138) 
[  254.621560] ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:543 ./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186 ./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[  254.621576] btrfs_submit_data_read_bio (fs/btrfs/inode.c:2787) btrfs
[  254.621854] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.622147] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.622441] ? bio_add_page (block/bio.c:1146) 
[  254.622461] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.622754] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.623045] ? bio_add_page (block/bio.c:1146) 
[  254.623065] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.623358] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.623652] ? bio_add_page (block/bio.c:1146) 
[  254.623671] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.623969] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.624262] ? bio_add_page (block/bio.c:1146) 
[  254.624281] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.624574] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.624868] ? bio_add_page (block/bio.c:1146) 
[  254.624887] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.625178] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.625468] ? bio_add_page (block/bio.c:1146) 
[  254.625488] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.625780] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.626070] ? bio_add_page (block/bio.c:1146) 
[  254.626090] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.626381] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.626675] ? bio_add_page (block/bio.c:1146) 
[  254.626695] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.626988] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.627282] ? bio_add_page (block/bio.c:1146) 
[  254.627302] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.627594] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.627887] ? bio_add_page (block/bio.c:1146) 
[  254.627907] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.628201] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.628496] ? bio_add_page (block/bio.c:1146) 
[  254.628516] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.628810] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.629104] ? bio_add_page (block/bio.c:1146) 
[  254.629124] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.629419] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.629710] ? bio_add_page (block/bio.c:1146) 
[  254.629730] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.630022] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.630315] ? bio_add_page (block/bio.c:1146) 
[  254.630334] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.630627] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.630920] ? bio_add_page (block/bio.c:1146) 
[  254.630940] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.631233] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.631528] ? bio_add_page (block/bio.c:1146) 
[  254.631548] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.631843] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.632135] ? bio_add_page (block/bio.c:1146) 
[  254.632154] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.632447] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.632739] ? bio_add_page (block/bio.c:1146) 
[  254.632759] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.633053] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.633347] ? bio_add_page (block/bio.c:1146) 
[  254.633367] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.633660] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.633955] ? bio_add_page (block/bio.c:1146) 
[  254.633974] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.634272] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.634565] ? bio_add_page (block/bio.c:1146) 
[  254.634585] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.634881] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.635176] ? bio_add_page (block/bio.c:1146) 
[  254.635195] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.635488] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.635782] ? bio_add_page (block/bio.c:1146) 
[  254.635802] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.636095] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.636389] ? bio_add_page (block/bio.c:1146) 
[  254.636409] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.636703] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.636996] ? bio_add_page (block/bio.c:1146) 
[  254.637016] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.637309] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.637602] ? bio_add_page (block/bio.c:1146) 
[  254.637622] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.637913] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.638208] ? bio_add_page (block/bio.c:1146) 
[  254.638228] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.638520] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.638813] ? bio_add_page (block/bio.c:1146) 
[  254.638833] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.639126] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.639418] ? bio_add_page (block/bio.c:1146) 
[  254.639438] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.639730] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.640023] ? bio_add_page (block/bio.c:1146) 
[  254.640042] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.640336] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.640629] ? bio_add_page (block/bio.c:1146) 
[  254.640648] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.640944] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.641236] ? bio_add_page (block/bio.c:1146) 
[  254.641256] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.641551] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.641844] ? bio_add_page (block/bio.c:1146) 
[  254.641864] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.642156] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.642448] ? bio_add_page (block/bio.c:1146) 
[  254.642468] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.642763] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.643055] ? bio_add_page (block/bio.c:1146) 
[  254.643075] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.643366] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.643657] ? bio_add_page (block/bio.c:1146) 
[  254.643676] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.643967] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.644260] ? bio_add_page (block/bio.c:1146) 
[  254.644280] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.644575] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.644872] ? bio_add_page (block/bio.c:1146) 
[  254.644892] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.645185] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.645480] ? bio_add_page (block/bio.c:1146) 
[  254.645499] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.645791] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.646084] ? bio_add_page (block/bio.c:1146) 
[  254.646104] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.646399] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.646690] ? bio_add_page (block/bio.c:1146) 
[  254.646710] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.647003] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.647294] ? bio_add_page (block/bio.c:1146) 
[  254.647313] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.647604] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.647896] ? bio_add_page (block/bio.c:1146) 
[  254.647916] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.648210] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.648502] ? bio_add_page (block/bio.c:1146) 
[  254.648521] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.648814] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.649107] ? bio_add_page (block/bio.c:1146) 
[  254.649126] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.649419] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.649710] ? bio_add_page (block/bio.c:1146) 
[  254.649730] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.650023] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.650315] ? bio_add_page (block/bio.c:1146) 
[  254.650335] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.650627] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.650919] ? bio_add_page (block/bio.c:1146) 
[  254.650939] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.651236] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.651531] ? bio_add_page (block/bio.c:1146) 
[  254.651551] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.651843] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.652134] ? bio_add_page (block/bio.c:1146) 
[  254.652154] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.652448] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.652740] ? bio_add_page (block/bio.c:1146) 
[  254.652760] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.653053] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.653347] ? bio_add_page (block/bio.c:1146) 
[  254.653367] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.653662] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.653955] ? bio_add_page (block/bio.c:1146) 
[  254.653975] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.654268] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.654561] ? bio_add_page (block/bio.c:1146) 
[  254.654581] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.654876] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.655316] ? bio_add_page (block/bio.c:1146) 
[  254.655337] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.655632] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.655926] ? bio_add_page (block/bio.c:1146) 
[  254.655945] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.656245] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.656539] ? bio_add_page (block/bio.c:1146) 
[  254.656559] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.656854] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.657146] ? bio_add_page (block/bio.c:1146) 
[  254.657166] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.657462] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.657753] ? bio_add_page (block/bio.c:1146) 
[  254.657773] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.658069] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.658362] ? bio_add_page (block/bio.c:1146) 
[  254.658382] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.658676] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.658969] ? bio_add_page (block/bio.c:1146) 
[  254.658990] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.659283] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.659576] ? bio_add_page (block/bio.c:1146) 
[  254.659597] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.659890] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.660184] ? bio_add_page (block/bio.c:1146) 
[  254.660204] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.660499] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.660794] ? bio_add_page (block/bio.c:1146) 
[  254.660815] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.661108] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.661403] ? bio_add_page (block/bio.c:1146) 
[  254.661423] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.661715] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.662007] ? bio_add_page (block/bio.c:1146) 
[  254.662027] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.662320] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.662612] ? bio_add_page (block/bio.c:1146) 
[  254.662633] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.662927] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.663220] ? bio_add_page (block/bio.c:1146) 
[  254.663240] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.663535] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.663828] ? bio_add_page (block/bio.c:1146) 
[  254.663848] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.664142] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.664434] ? bio_add_page (block/bio.c:1146) 
[  254.664455] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.664751] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.665045] ? bio_add_page (block/bio.c:1146) 
[  254.665066] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.665359] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.665654] ? bio_add_page (block/bio.c:1146) 
[  254.665673] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.665967] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.666261] ? bio_add_page (block/bio.c:1146) 
[  254.666281] btrfs_repair_one_sector (fs/btrfs/extent_io.c:775) btrfs
[  254.666572] end_compressed_bio_read (fs/btrfs/compression.c:197) btrfs
[  254.666866] ? bio_add_page (block/bio.c:1141) 
[  254.666886] btrfs_submit_compressed_read (fs/btrfs/bio.h:93 fs/btrfs/compression.c:805) btrfs
[  254.667185] ? __pfx_btrfs_submit_compressed_read (fs/btrfs/compression.c:665) btrfs
[  254.667489] submit_one_bio (fs/btrfs/extent_io.c:160) btrfs
[  254.667773] ? kasan_save_free_info (mm/kasan/generic.c:525) 
[  254.667789] submit_extent_page (fs/btrfs/extent_io.c:1487) btrfs
[  254.668075] ? kmem_cache_free (mm/slub.c:1807 mm/slub.c:3788 mm/slub.c:3810) 
[  254.668091] ? btrfs_get_extent (fs/btrfs/inode.c:7124) btrfs
[  254.668374] ? __pfx_submit_extent_page (fs/btrfs/extent_io.c:1474) btrfs
[  254.668657] ? __pfx_btrfs_get_extent (fs/btrfs/inode.c:6942) btrfs
[  254.668937] ? btrfs_lookup_ordered_range (fs/btrfs/ordered-data.c:855) btrfs
[  254.669219] ? __pfx_lock_extent (fs/btrfs/extent-io-tree.c:1730) btrfs
[  254.669527] ? __pfx_btrfs_lookup_ordered_range (fs/btrfs/ordered-data.c:855) btrfs
[  254.669812] btrfs_do_readpage (fs/btrfs/extent_io.c:1780) btrfs
[  254.670105] ? xas_find (lib/xarray.c:1253) 
[  254.670117] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:543 ./include/asm-generic/qspinlock.h:97 ./include/linux/spinlock.h:192 ./include/linux/spinlock_api_smp.h:89 kernel/locking/spinlock.c:138) 
[  254.670133] extent_readahead (./include/linux/page-flags.h:251 ./include/linux/mm.h:1318 fs/btrfs/extent_io.c:1834 fs/btrfs/extent_io.c:3229) btrfs
[  254.670424] ? __pfx_extent_readahead (fs/btrfs/extent_io.c:3218) btrfs
[  254.670712] ? __mod_memcg_lruvec_state (mm/memcontrol.c:613 mm/memcontrol.c:801) 
[  254.670727] ? __pfx_end_bio_extent_readpage (fs/btrfs/extent_io.c:1077) btrfs
[  254.671011] ? xa_get_order (lib/xarray.c:1762) 
[  254.671044] read_pages (./include/linux/pagemap.h:1245 ./include/linux/pagemap.h:1285 mm/readahead.c:167) 
[  254.671057] ? __pfx_workingset_update_node (mm/workingset.c:545) 
[  254.671074] ? folio_batch_add_and_move (./arch/x86/include/asm/atomic.h:29 ./include/linux/atomic/atomic-instrumented.h:28 ./include/linux/swap.h:391 mm/swap.c:262) 
[  254.671087] ? __pfx_read_pages (mm/readahead.c:148) 
[  254.671099] ? folio_add_lru (./arch/x86/include/asm/preempt.h:95 mm/swap.c:548) 
[  254.671118] page_cache_ra_unbounded (./include/linux/fs.h:824 mm/readahead.c:271) 
[  254.671137] filemap_get_pages (./include/linux/instrumented.h:72 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 ./include/linux/page-flags.h:711 mm/filemap.c:2621) 
[  254.671155] ? __copy_page_from_iter_atomic (lib/iov_iter.c:813) 
[  254.671171] ? __pfx_filemap_get_pages (mm/filemap.c:2582) 
[  254.671185] ? __pfx___copy_page_from_iter_atomic (lib/iov_iter.c:811) 
[  254.671205] filemap_read (mm/filemap.c:2695) 
[  254.671220] ? generic_perform_write (./include/linux/uio.h:272 mm/filemap.c:3809) 
[  254.671235] ? __pfx_generic_perform_write (mm/filemap.c:3738) 
[  254.671247] ? __pfx_filemap_read (mm/filemap.c:2663) 
[  254.671268] ? fsnotify_perm.part.0 (./arch/x86/include/asm/atomic64_64.h:22 ./include/linux/atomic/atomic-long.h:29 ./include/linux/atomic/atomic-instrumented.h:1266 ./include/linux/fsnotify.h:62 ./include/linux/fsnotify.h:99 ./include/linux/fsnotify.h:124) 
[  254.671283] vfs_read (./include/linux/fs.h:2184 fs/read_write.c:389 fs/read_write.c:470) 
[  254.671300] ? __pfx_vfs_read (fs/read_write.c:451) 
[  254.671318] ? __fget_light (./include/linux/atomic/atomic-arch-fallback.h:227 ./include/linux/atomic/atomic-instrumented.h:35 fs/file.c:1015) 
[  254.671329] ? __fget_light (./include/linux/atomic/atomic-arch-fallback.h:227 ./include/linux/atomic/atomic-instrumented.h:35 fs/file.c:1015) 
[  254.671344] ksys_read (fs/read_write.c:613) 
[  254.671357] ? __pfx_ksys_read (fs/read_write.c:603) 
[  254.671370] ? ksys_read (fs/read_write.c:613) 
[  254.671380] ? __pfx_ksys_read (fs/read_write.c:603) 
[  254.671393] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  254.671406] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671419] ? syscall_exit_to_user_mode (./arch/x86/include/asm/jump_label.h:27 ./include/linux/context_tracking_state.h:106 ./include/linux/context_tracking.h:41 kernel/entry/common.c:134 kernel/entry/common.c:298) 
[  254.671431] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671442] ? syscall_exit_to_user_mode (./arch/x86/include/asm/jump_label.h:27 ./include/linux/context_tracking_state.h:106 ./include/linux/context_tracking.h:41 kernel/entry/common.c:134 kernel/entry/common.c:298) 
[  254.671453] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671465] ? syscall_exit_to_user_mode (./arch/x86/include/asm/jump_label.h:27 ./include/linux/context_tracking_state.h:106 ./include/linux/context_tracking.h:41 kernel/entry/common.c:134 kernel/entry/common.c:298) 
[  254.671476] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671485] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671495] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671506] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671515] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[  254.671526] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  254.671573] RIP: 0033:0x7f324a959931
[ 254.671806] Code: 31 c0 e9 b2 fe ff ff 50 48 8d 3d 72 81 0a 00 e8 25 13 02 00 0f 1f 44 00 00 f3 0f 1e fa 80 3d cd 9a 0e 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 4
All code
========
   0:	31 c0                	xor    %eax,%eax
   2:	e9 b2 fe ff ff       	jmp    0xfffffffffffffeb9
   7:	50                   	push   %rax
   8:	48 8d 3d 72 81 0a 00 	lea    0xa8172(%rip),%rdi        # 0xa8181
   f:	e8 25 13 02 00       	call   0x21339
  14:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  19:	f3 0f 1e fa          	endbr64
  1d:	80 3d cd 9a 0e 00 00 	cmpb   $0x0,0xe9acd(%rip)        # 0xe9af1
  24:	74 13                	je     0x39
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 57                	ja     0x89
  32:	c3                   	ret
  33:	66                   	data16
  34:	04                   	.byte 0x4

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 57                	ja     0x5f
   8:	c3                   	ret
   9:	66                   	data16
   a:	04                   	.byte 0x4
[  254.671819] RSP: 002b:00007ffc3afc0238 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  254.671899] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f324a959931
[  254.671909] RDX: 0000000000020000 RSI: 00007f324a83f000 RDI: 0000000000000004
[  254.671916] RBP: 0000000000000000 R08: 00007f324a85f000 R09: 0000000000000000
[  254.671923] R10: 00007f324a83f000 R11: 0000000000000246 R12: 00007ffc3afc1d00
[  254.671930] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  254.671966]  </TASK>
[  254.672004] Modules linked in: mousedev kvm_amd ppdev ccp kvm psmouse irqbypass pcspkr i2c_piix4 parport_pc parport mac_hid btrfs blake2b_generic xor raid6_pq libcrc32c cfg8021k
[  257.929353] ---[ end trace 0000000000000000 ]---
[  257.929447] RIP: 0010:kasan_check_range (mm/kasan/generic.c:188) 
[ 257.929484] Code: 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 85 f6 0f 84 6e 01 00 00 49 89 f9 41 54 44 0f b6 c2 <55> 53 49 01 f1 0f 82 15 01 00 0
All code
========
   0:	00 0f                	add    %cl,(%rdi)
   2:	1f                   	(bad)
   3:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	66 0f 1f 00          	nopw   (%rax)
  18:	48 85 f6             	test   %rsi,%rsi
  1b:	0f 84 6e 01 00 00    	je     0x18f
  21:	49 89 f9             	mov    %rdi,%r9
  24:	41 54                	push   %r12
  26:	44 0f b6 c2          	movzbl %dl,%r8d
  2a:*	55                   	push   %rbp		<-- trapping instruction
  2b:	53                   	push   %rbx
  2c:	49 01 f1             	add    %rsi,%r9
  2f:	0f 82 15 01 00 00    	jb     0x14a

Code starting with the faulting instruction
===========================================
   0:	55                   	push   %rbp
   1:	53                   	push   %rbx
   2:	49 01 f1             	add    %rsi,%r9
   5:	0f 82 15 01 00 00    	jb     0x120
[  257.929498] RSP: 0018:ffffc90003cd0000 EFLAGS: 00000002
[  257.929515] RAX: ffff8881097c6000 RBX: ffffc90003cd0080 RCX: ffffffffa3366ec3
[  257.929524] RDX: 0000000000000001 RSI: 0000000000000070 RDI: ffffc90003cd0080
[  257.929532] RBP: 0000000000000070 R08: 0000000000000001 R09: ffffc90003cd0080
[  257.929539] R10: fffff5200079a07d R11: ffffffffa6f274a0 R12: 0000000000000000
[  257.929546] R13: ffffc90003cd0150 R14: ffffc90003cd0080 R15: ffffc90003cd00a8
[  257.929556] FS:  00007f324a860740(0000) GS:ffff88811b200000(0000) knlGS:0000000000000000
[  257.929566] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  257.929573] CR2: ffffc90003ccfff8 CR3: 0000000106af4000 CR4: 00000000000006f0
[  257.929665] Kernel panic - not syncing: Fatal exception in interrupt
[  257.930205] Kernel Offset: 0x22200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Regards,
David
