Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94804E84E8
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Mar 2022 03:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiC0BdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Mar 2022 21:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiC0BdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Mar 2022 21:33:17 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC2DF9A;
        Sat, 26 Mar 2022 18:31:39 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.43.99])
        by gnuweeb.org (Postfix) with ESMTPSA id 810CC7E2FD;
        Sun, 27 Mar 2022 01:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648344699;
        bh=E7s3fkpNp1mlDh6m9BcuAuvQUAsW/l8YLz8KcAzZTZ4=;
        h=Date:To:Cc:From:Subject:From;
        b=OwP2jlyd1F0Bjo0Lcyuahaj2J9+wHKRmdCT/MDPUM86pcMOp2VJR2HYl4fHDbvFBA
         dLS+Y8TDc0e3PESpVwc5O+xhMGDkgCa6FG6Tx++RJLYseTNUdWxczLa+4jcYIYCech
         ZxW8/RGZdH8wa2+eMxST1cHvpcXa6kpcaURe+ob3QTQ0C6KvxOgkNTjnUF6VhStTQR
         0B8CmEc0opN+JHmrrcPOPJn/O6q3wbrDb+qmdCphP9Gl+nd76x06VZw/4cnUYo7+PH
         Lkr0vVUDMRORG1mGhSVtZvuzUtuiODUKcUKo2sul9uuFwfTDgXTAq8udSfP+Fu+y+F
         hUlUSkFzerZ7A==
Message-ID: <322c0884-38fe-a295-0aff-caee1308833d@gnuweeb.org>
Date:   Sun, 27 Mar 2022 08:31:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hello btrfs maintainers,

I got the following bug in Linux 5.17.0 stable. I don't have the
reproducer for this. I will send any update if I find something
relevant. If anyone has any suggestion on how to debug this further,
or wants me to test a patch after it gets a reliable reproducer,
or something, please let me know. I will try it on my machine.

If you need me to send something to investigate this, please let
me know.

Here is the dmesg output:

   <7>[ 2303.271381][T10970] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
   <7>[ 2303.271386][T10970] turning off the locking correctness validator.
   <4>[ 2303.271388][T10970] CPU: 6 PID: 10970 Comm: ThreadPoolForeg Tainted: G        W         5.17.0-superb-owl-00001-gf443e374ae13 #4 2e0b653b4e6257f7299ba52601cab31b4cf18438
   <4>[ 2303.271391][T10970] Hardware name: HP HP Laptop 14s-dq2xxx/87FD, BIOS F.15 09/15/2021
   <4>[ 2303.271392][T10970] Call Trace:
   <4>[ 2303.271394][T10970]  <TASK>
   <4>[ 2303.271397][T10970] dump_stack_lvl (lib/dump_stack.c:107)
   <4>[ 2303.271401][T10970] validate_chain (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:3748 kernel/locking/lockdep.c:3769)
   <4>[ 2303.271403][T10970] ? check_path (kernel/locking/lockdep.c:1977)
   <4>[ 2303.271405][T10970] ? __bfs (kernel/locking/lockdep.c:1758)
   <4>[ 2303.271407][T10970] ? check_path (kernel/locking/lockdep.c:1803 kernel/locking/lockdep.c:2104)
   <4>[ 2303.271408][T10970] ? check_noncircular (kernel/locking/lockdep.c:2131)
   <4>[ 2303.271409][T10970] ? __bfs (kernel/locking/lockdep.c:1758)
   <4>[ 2303.271411][T10970] ? lockdep_unlock (kernel/locking/lockdep.c:126)
   <4>[ 2303.271413][T10970] ? validate_chain (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:3805)
   <4>[ 2303.271415][T10970] ? validate_chain (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:3805)
   <4>[ 2303.271416][T10970] ? validate_chain (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:3805)
   <4>[ 2303.271417][T10970] __lock_acquire (kernel/locking/lockdep.c:5027)
   <4>[ 2303.271420][T10970] lock_acquire (kernel/locking/lockdep.c:5639)
   <4>[ 2303.271422][T10970] ? btrfs_reserve_extent (fs/btrfs/extent-tree.c:? fs/btrfs/extent-tree.c:4527) btrfs
   <4>[ 2303.271444][T10970] ? btrfs_reserve_extent (fs/btrfs/extent-tree.c:? fs/btrfs/extent-tree.c:4527) btrfs
   <4>[ 2303.271457][T10970] btrfs_get_alloc_profile (./include/linux/seqlock.h:103 ./include/linux/seqlock.h:840 fs/btrfs/block-group.c:105) btrfs
   <4>[ 2303.271470][T10970] ? btrfs_reserve_extent (fs/btrfs/extent-tree.c:? fs/btrfs/extent-tree.c:4527) btrfs
   <4>[ 2303.271483][T10970] btrfs_reserve_extent (fs/btrfs/extent-tree.c:? fs/btrfs/extent-tree.c:4527) btrfs
   <4>[ 2303.271498][T10970] btrfs_alloc_tree_block (fs/btrfs/extent-tree.c:4942) btrfs
   <4>[ 2303.271511][T10970] ? lock_is_held_type (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:5683)
   <4>[ 2303.271515][T10970] ? register_lock_class (kernel/locking/lockdep.c:1258)
   <4>[ 2303.271517][T10970] __btrfs_cow_block (fs/btrfs/ctree.c:416) btrfs
   <4>[ 2303.271531][T10970] btrfs_cow_block (fs/btrfs/ctree.c:571) btrfs
   <4>[ 2303.271545][T10970] push_leaf_right (fs/btrfs/ctree.c:2994) btrfs
   <4>[ 2303.271558][T10970] btrfs_del_items (fs/btrfs/inode.c:10680) btrfs
   <4>[ 2303.271572][T10970] __btrfs_update_delayed_inode (fs/btrfs/ctree.h:2926 ./include/asm-generic/bitops/instrumented-atomic.h:86 fs/btrfs/delayed-inode.c:920 fs/btrfs/delayed-inode.c:987) btrfs
   <4>[ 2303.271586][T10970] btrfs_commit_inode_delayed_inode (fs/btrfs/delayed-inode.c:1193) btrfs
   <4>[ 2303.271599][T10970] btrfs_evict_inode (fs/btrfs/inode.c:5234) btrfs
   <4>[ 2303.271612][T10970] ? bit_waitqueue (kernel/sched/wait_bit.c:22)
   <4>[ 2303.271615][T10970] evict (fs/inode.c:?)
   <4>[ 2303.271617][T10970] __dentry_kill (fs/dcache.c:?)
   <4>[ 2303.271618][T10970] dentry_kill (fs/dcache.c:755)
   <4>[ 2303.271620][T10970] dput (fs/dcache.c:913)
   <4>[ 2303.271622][T10970] do_renameat2 (fs/namei.c:4832)
   <4>[ 2303.271626][T10970] __x64_sys_rename (fs/namei.c:4874 fs/namei.c:4872 fs/namei.c:4872)
   <4>[ 2303.271628][T10970] do_syscall_64 (arch/x86/entry/common.c:?)
   <4>[ 2303.271630][T10970] entry_SYSCALL_64_after_hwframe (??:?)
   <4>[ 2303.271632][T10970] RIP: 0033:0x7fb89f7aacbb
   <4>[ 2303.271634][T10970] Code: e8 ea 35 0b 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5d c3 66 0f 1f 44 00 00 b8 ff ff ff ff 5d c3 90 f3 0f 1e fa b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 41 71 1b 00 f7 d8
   All code
   ========
      0:	e8 ea 35 0b 00       	call   0xb35ef
      5:	85 c0                	test   %eax,%eax
      7:	0f 95 c0             	setne  %al
      a:	0f b6 c0             	movzbl %al,%eax
      d:	f7 d8                	neg    %eax
      f:	5d                   	pop    %rbp
     10:	c3                   	ret
     11:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     1c:	5d                   	pop    %rbp
     1d:	c3                   	ret
     1e:	90                   	nop
     1f:	f3 0f 1e fa          	endbr64
     23:	b8 52 00 00 00       	mov    $0x52,%eax
     28:	0f 05                	syscall
     2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
     30:	77 05                	ja     0x37
     32:	c3                   	ret
     33:	0f 1f 40 00          	nopl   0x0(%rax)
     37:	48 8b 15 41 71 1b 00 	mov    0x1b7141(%rip),%rdx        # 0x1b717f
     3e:	f7 d8                	neg    %eax

   Code starting with the faulting instruction
   ===========================================
      0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
      6:	77 05                	ja     0xd
      8:	c3                   	ret
      9:	0f 1f 40 00          	nopl   0x0(%rax)
      d:	48 8b 15 41 71 1b 00 	mov    0x1b7141(%rip),%rdx        # 0x1b7155
     14:	f7 d8                	neg    %eax
   <4>[ 2303.271636][T10970] RSP: 002b:00007fb899a32e98 EFLAGS: 00000282 ORIG_RAX: 0000000000000052
   <4>[ 2303.271638][T10970] RAX: ffffffffffffffda RBX: 00007fb899a32ef0 RCX: 00007fb89f7aacbb
   <4>[ 2303.271639][T10970] RDX: 0000000000000001 RSI: 0000177c02926be0 RDI: 0000177c01713380
   <4>[ 2303.271639][T10970] RBP: 00007fb899a32f70 R08: 000005e769162932 R09: 00007ffe45363080
   <4>[ 2303.271640][T10970] R10: 0000000000000010 R11: 0000000000000282 R12: 0000177c02926be0
   <4>[ 2303.271641][T10970] R13: 00007fb899a32ec0 R14: 0000177c01713380 R15: 000055b6d6ae3c40
   <4>[ 2303.271644][T10970]  </TASK>


-- 
Ammar Faizi
