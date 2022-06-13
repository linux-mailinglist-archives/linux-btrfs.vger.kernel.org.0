Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6119547FBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 08:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbiFMGrj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiFMGrh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 02:47:37 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F611154
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 23:47:27 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id n19-20020a056602341300b0066850b49e09so2200700ioz.12
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 23:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QnnJfmh+ZzDqayIMrkxn40pdrXu9tEckn4AjcSunCfI=;
        b=6kWgCnA0Y5WGIsc2wGrv1Z/a/mkPlLtYax6a7SYsyh7ItDaKq6VG6t5hKtcWmzGtHw
         pVBAmNETvC2UoiI5Kqn77yFhpIn/IkfHG1M5ztGkVZknHx6MJcakdCK2Nl6K8BHDaHgV
         mnQ6NyLjVWTY4BtB+cE7CGeBNMKPj5bW7aH7IilrFHsHmwj8zyqlXfcpp2lrmse0XXxN
         iPJNTzTH3YHyJy9rJS8LJ1vmOABBlcfLsH1/SYrDR16mD9xGqTridf1xh72cQT3S6BoQ
         7Slbj+YzTyf0KNOd2jiGZwBZeoZ4+NnAPiesHeREjgGGDLU6i8KJ54MtCXrswc5c8NUe
         GFdg==
X-Gm-Message-State: AOAM531Osj+aEOAr7yMtQ9dtWZh4lrGftRNtheIStCYydoKlxruL908Y
        OSTJS2ykZoQa5yBCpmpWmJN96aLEhJe37krJzH1qMYJOagk0
X-Google-Smtp-Source: ABdhPJxobX9Tnzaa2LIvM6BB7yZSkzzsmcO9vzFzaNcH7VdVvG5YK8THCJAYBPBlrnRSUlusACJoQJbA4sLq9wZpg9/y2lnzvuCS
MIME-Version: 1.0
X-Received: by 2002:a02:cc32:0:b0:331:76a7:bf36 with SMTP id
 o18-20020a02cc32000000b0033176a7bf36mr27834212jap.15.1655102846581; Sun, 12
 Jun 2022 23:47:26 -0700 (PDT)
Date:   Sun, 12 Jun 2022 23:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cbe2805e14ea9c7@google.com>
Subject: [syzbot] general protection fault in detach_extent_buffer_page (2)
From:   syzbot <syzbot+94f5f2795eb772708f0e@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e71e60cd74df Merge tag 'dma-mapping-5.19-2022-06-06' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b8496ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd131cc02ee620e
dashboard link: https://syzkaller.appspot.com/bug?extid=94f5f2795eb772708f0e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94f5f2795eb772708f0e@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000003d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000001e8-0x00000000000001ef]
CPU: 2 PID: 3675 Comm: syz-fuzzer Not tainted 5.19.0-rc1-syzkaller-00003-ge71e60cd74df #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__lock_acquire+0xd85/0x5660 kernel/locking/lockdep.c:4923
Code: 76 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 81 da 76 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 2d 00 00 48 81 3b e0 03 2b 8f 0f 84 4f f3 ff
RSP: 0000:ffffc90002d86aa8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 00000000000001e8 RCX: 0000000000000000
RDX: 000000000000003d RSI: 0000000000000000 RDI: 00000000000001e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888015c4c080 R14: 0000000000000000 R15: 0000000000000000
FS:  000000c000080090(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000402794 CR3: 0000000026785000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 detach_extent_buffer_page+0x7e7/0x1280 fs/btrfs/extent_io.c:5835
 btrfs_release_extent_buffer_pages+0xd3/0x3a0 fs/btrfs/extent_io.c:5904
 release_extent_buffer+0x227/0x2a0 fs/btrfs/extent_io.c:6389
 try_release_extent_buffer+0x9ec/0xbe0 fs/btrfs/extent_io.c:7460
 btree_release_folio+0xbe/0x100 fs/btrfs/disk-io.c:1004
 filemap_release_folio+0x13b/0x1a0 mm/filemap.c:3964
 shrink_page_list+0x2697/0x3a50 mm/vmscan.c:1878
 shrink_inactive_list mm/vmscan.c:2386 [inline]
 shrink_list mm/vmscan.c:2616 [inline]
 shrink_lruvec+0xccf/0x2620 mm/vmscan.c:2933
 shrink_node_memcgs mm/vmscan.c:3122 [inline]
 shrink_node+0x84a/0x1db0 mm/vmscan.c:3245
 shrink_zones mm/vmscan.c:3482 [inline]
 do_try_to_free_pages+0x3b5/0x1700 mm/vmscan.c:3540
 try_to_free_pages+0x2ac/0x840 mm/vmscan.c:3775
 __perform_reclaim mm/page_alloc.c:4641 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4663 [inline]
 __alloc_pages_slowpath.constprop.0+0xa8a/0x2160 mm/page_alloc.c:5066
 __alloc_pages+0x436/0x510 mm/page_alloc.c:5439
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
 folio_alloc+0x1c/0x70 mm/mempolicy.c:2282
 filemap_alloc_folio+0x8e/0xb0 mm/filemap.c:996
 page_cache_ra_unbounded+0x1af/0x550 mm/readahead.c:240
 do_page_cache_ra mm/readahead.c:291 [inline]
 page_cache_ra_order+0x680/0x940 mm/readahead.c:546
 do_sync_mmap_readahead mm/filemap.c:3046 [inline]
 filemap_fault+0x1638/0x2550 mm/filemap.c:3138
 __do_fault+0x10d/0x650 mm/memory.c:4165
 do_read_fault mm/memory.c:4511 [inline]
 do_fault mm/memory.c:4640 [inline]
 handle_pte_fault mm/memory.c:4903 [inline]
 __handle_mm_fault+0x2739/0x3f50 mm/memory.c:5042
 handle_mm_fault+0x1c8/0x790 mm/memory.c:5140
 do_user_addr_fault+0x489/0x11c0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1484 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1540
 asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x402794
Code: fd d7 d6 48 83 c6 40 48 83 c7 40 48 83 eb 40 81 fa ff ff ff ff 74 c4 c5 f8 77 48 31 c0 c3 c5 f8 77 48 83 fb 08 76 1b 48 8b 0e <48> 8b 17 48 83 c6 08 48 83 c7 08 48 83 eb 08 48 39 d1 74 e3 48 31
RSP: 002b:000000c00008b870 EFLAGS: 00010216
RAX: 00000000008cd601 RBX: 0000000000000011 RCX: 70702a282e746d66
RDX: 2e656d69746e7572 RSI: 00000000008cd601 RDI: 00000000006f0620
RBP: 000000c00008b8e0 R08: 00000000000000cb R09: 00000000004c55d7
R10: 0000000000000002 R11: 0000000000000001 R12: 00000000004c5590
R13: 0000000000051208 R14: 000000c000082000 R15: 000000c00aa62c00
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd85/0x5660 kernel/locking/lockdep.c:4923
Code: 76 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 81 da 76 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 1e 2d 00 00 48 81 3b e0 03 2b 8f 0f 84 4f f3 ff
RSP: 0000:ffffc90002d86aa8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 00000000000001e8 RCX: 0000000000000000
RDX: 000000000000003d RSI: 0000000000000000 RDI: 00000000000001e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888015c4c080 R14: 0000000000000000 R15: 0000000000000000
FS:  000000c000080090(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000402794 CR3: 0000000026785000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	76 0e                	jbe    0x10
   2:	41 be 01 00 00 00    	mov    $0x1,%r14d
   8:	0f 86 c8 00 00 00    	jbe    0xd6
   e:	89 05 81 da 76 0e    	mov    %eax,0xe76da81(%rip)        # 0xe76da95
  14:	e9 bd 00 00 00       	jmpq   0xd6
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 1e 2d 00 00    	jne    0x2d52
  34:	48 81 3b e0 03 2b 8f 	cmpq   $0xffffffff8f2b03e0,(%rbx)
  3b:	0f                   	.byte 0xf
  3c:	84 4f f3             	test   %cl,-0xd(%rdi)
  3f:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
