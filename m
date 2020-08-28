Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ABB25622A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgH1Um7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 16:42:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34066 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1Um5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 16:42:57 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DB4597D7B32; Fri, 28 Aug 2020 16:42:55 -0400 (EDT)
Date:   Fri, 28 Aug 2020 16:42:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
Subject: Re: BUG at fs/btrfs/relocation.c:794! Still happening on misc-next
 and 5.8.3
Message-ID: <20200828204255.GV5890@hungrycats.org>
References: <20200630221006.17585-1-dsterba@suse.com>
 <20200723215641.GE5890@hungrycats.org>
 <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
 <20200804161626.GN5890@hungrycats.org>
 <20200828000313.GS5890@hungrycats.org>
 <20200828000822.GT5890@hungrycats.org>
 <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 09:34:31AM +0300, Nikolay Borisov wrote:
> On 28.08.20 г. 3:08 ч., Zygo Blaxell wrote:
> > On Thu, Aug 27, 2020 at 08:03:13PM -0400, Zygo Blaxell wrote:
> >> On Tue, Aug 04, 2020 at 12:16:26PM -0400, Zygo Blaxell wrote:
> 
> <snip>
> 
> Since you can repro reliably could you modify the code in
> create_reloc_root so it prints what's the returned error value, I'd
> speculate it's EEXIST from
> 
> btrfs_insert_root
>   btrfs_insert_item
>    btrfs_insert_empty_item
>      btrfs_insert_empty_items
>        btrfs_search_slot
> 
> But better be sure.

Here you go, EEXIST == 17:

	Aug 28 15:30:55 regress kernel: [18452.845182][T31546] BTRFS info (device dm-0): balance: start -dlimit=9
	Aug 28 15:30:55 regress kernel: [18452.874627][T31546] BTRFS info (device dm-0): relocating block group 15873413742592 flags data
	Aug 28 15:30:55 regress kernel: [18453.097516][ T2100] btrfs_search_slot ret = 0
	Aug 28 15:30:55 regress kernel: [18453.104865][ T2100] btrfs_search_slot ret = 0
	Aug 28 15:30:55 regress kernel: [18453.109751][ T2100] btrfs_search_slot ret = 0
	Aug 28 15:30:56 regress kernel: [18454.453135][ T2100] btrfs_search_slot ret = 0
	Aug 28 15:30:56 regress kernel: [18454.453955][ T2100] btrfs_insert_empty_item ret = -17
	Aug 28 15:30:56 regress kernel: [18454.455022][ T2100] btrfs_insert_root ret = -17
	Aug 28 15:30:56 regress kernel: [18454.456229][ T2100] ------------[ cut here ]------------
	Aug 28 15:30:56 regress kernel: [18454.457622][ T2100] kernel BUG at fs/btrfs/relocation.c:795!
	Aug 28 15:30:56 regress kernel: [18454.459006][ T2100] invalid opcode: 0000 [#1] SMP KASAN PTI
	Aug 28 15:30:56 regress kernel: [18454.460356][ T2100] CPU: 2 PID: 2100 Comm: rsync Tainted: G        W         5.8.5-8de74804e45b+ #6
	Aug 28 15:30:57 regress kernel: [18454.462324][ T2100] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	Aug 28 15:30:57 regress kernel: [18454.464289][ T2100] RIP: 0010:create_reloc_root+0x47a/0x490
	Aug 28 15:30:57 regress kernel: [18454.465507][ T2100] Code: e8 5b 3b bd ff 4d 8b 76 50 be 08 00 00 00 49 8d bc 24 f0 00 00 00 e8 65 3b bd ff 4d 89 b4 24 f0 00 00 00 e9 dc fc ff ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 b9 90 07 01 66 0f 1f 84 00 00 00 00 00
	Aug 28 15:30:57 regress kernel: [18454.468861][ T2100] RSP: 0018:ffffc90000c777d0 EFLAGS: 00010282
	Aug 28 15:30:57 regress kernel: [18454.469787][ T2100] RAX: 000000000000001b RBX: ffff88817cbc9400 RCX: ffffffffa5273b42
	Aug 28 15:30:57 regress kernel: [18454.471005][ T2100] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881f5dff28c
	Aug 28 15:30:57 regress kernel: [18454.472278][ T2100] RBP: ffffc90000c778c0 R08: ffffed103ebc1645 R09: ffffed103ebc1645
	Aug 28 15:30:57 regress kernel: [18454.473547][ T2100] R10: ffff8881f5e0b227 R11: ffffed103ebc1644 R12: ffff8881cb710020
	Aug 28 15:30:57 regress kernel: [18454.474949][ T2100] R13: ffff888118800a80 R14: 00000000ffffffef R15: ffffc90000c77858
	Aug 28 15:30:57 regress kernel: [18454.476224][ T2100] FS:  00007f1b8f7d9b80(0000) GS:ffff8881f5c00000(0000) knlGS:0000000000000000
	Aug 28 15:30:57 regress kernel: [18454.477635][ T2100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	Aug 28 15:30:57 regress kernel: [18454.478661][ T2100] CR2: 00007fc1d25e7100 CR3: 0000000120a8e006 CR4: 00000000001606e0
	Aug 28 15:30:57 regress kernel: [18454.479894][ T2100] Call Trace:
	Aug 28 15:30:57 regress kernel: [18454.480416][ T2100]  ? update_backref_node+0xf0/0xf0
	Aug 28 15:30:57 regress kernel: [18454.481209][ T2100]  ? check_chain_key+0x1e6/0x2e0
	Aug 28 15:30:57 regress kernel: [18454.482012][ T2100]  btrfs_init_reloc_root+0x1b0/0x310
	Aug 28 15:30:57 regress kernel: [18454.482859][ T2100]  ? find_reloc_root+0x200/0x200
	Aug 28 15:30:57 regress kernel: [18454.483661][ T2100]  ? do_raw_spin_unlock+0xa8/0x140
	Aug 28 15:30:57 regress kernel: [18454.484482][ T2100]  record_root_in_trans+0x18c/0x1d0
	Aug 28 15:30:57 regress kernel: [18454.485435][ T2100]  btrfs_record_root_in_trans+0x8b/0xc0
	Aug 28 15:30:57 regress kernel: [18454.486301][ T2100]  start_transaction+0x16b/0x8f0
	Aug 28 15:30:57 regress kernel: [18454.487082][ T2100]  btrfs_start_transaction+0x1e/0x20
	Aug 28 15:30:57 regress kernel: [18454.487905][ T2100]  btrfs_cont_expand+0x549/0x7a0
	Aug 28 15:30:57 regress kernel: [18454.488680][ T2100]  ? btrfs_truncate_block+0x970/0x970
	Aug 28 15:30:57 regress kernel: [18454.489527][ T2100]  ? timestamp_truncate+0x180/0x180
	Aug 28 15:30:57 regress kernel: [18454.490344][ T2100]  ? check_chain_key+0x1e6/0x2e0
	Aug 28 15:30:57 regress kernel: [18454.491117][ T2100]  btrfs_file_write_iter+0x7ae/0x957
	Aug 28 15:30:57 regress kernel: [18454.491938][ T2100]  ? btrfs_sync_file+0x7c0/0x7c0
	Aug 28 15:30:57 regress kernel: [18454.492710][ T2100]  ? iov_iter_init+0x99/0xd0
	Aug 28 15:30:57 regress kernel: [18454.493426][ T2100]  new_sync_write+0x2ad/0x3f0
	Aug 28 15:30:57 regress kernel: [18454.494153][ T2100]  ? new_sync_read+0x3e0/0x3e0
	Aug 28 15:30:57 regress kernel: [18454.494890][ T2100]  ? check_flags+0x26/0x30
	Aug 28 15:30:57 regress kernel: [18454.495582][ T2100]  ? lock_is_held_type+0xc9/0x100
	Aug 28 15:30:57 regress kernel: [18454.496365][ T2100]  ? rcu_read_lock_any_held+0xd2/0x100
	Aug 28 15:30:57 regress kernel: [18454.497211][ T2100]  ? rcu_read_lock_held+0xb0/0xb0
	Aug 28 15:30:57 regress kernel: [18454.497985][ T2100]  ? __sb_start_write+0x1a1/0x270
	Aug 28 15:30:57 regress kernel: [18454.498768][ T2100]  vfs_write+0x2d2/0x300
	Aug 28 15:30:57 regress kernel: [18454.499417][ T2100]  ksys_write+0xcc/0x170
	Aug 28 15:30:57 regress kernel: [18454.500064][ T2100]  ? __ia32_sys_read+0x50/0x50
	Aug 28 15:30:57 regress kernel: [18454.500783][ T2100]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
	Aug 28 15:30:57 regress kernel: [18454.501704][ T2100]  __x64_sys_write+0x43/0x50
	Aug 28 15:30:57 regress kernel: [18454.502403][ T2100]  do_syscall_64+0x60/0xf0
	Aug 28 15:30:57 regress kernel: [18454.503079][ T2100]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	Aug 28 15:30:57 regress kernel: [18454.503971][ T2100] RIP: 0033:0x7f1b8f8c5504
	Aug 28 15:30:57 regress kernel: [18454.504644][ T2100] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
	Aug 28 15:30:57 regress kernel: [18454.507565][ T2100] RSP: 002b:00007fff3419eaa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
	Aug 28 15:30:57 regress kernel: [18454.508800][ T2100] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1b8f8c5504
	Aug 28 15:30:57 regress kernel: [18454.509982][ T2100] RDX: 0000000000000400 RSI: 000055e56f375bb0 RDI: 0000000000000001
	Aug 28 15:30:57 regress kernel: [18454.511153][ T2100] RBP: 0000000000000400 R08: 0000000000000400 R09: 000000002c4a4095
	Aug 28 15:30:57 regress kernel: [18454.512325][ T2100] R10: 000000000a7b98fd R11: 0000000000000246 R12: 000055e56f375bb0
	Aug 28 15:30:57 regress kernel: [18454.513503][ T2100] R13: 000055e56f375bb0 R14: 0000000000008000 R15: 0000000000000400
	Aug 28 15:30:57 regress kernel: [18454.514685][ T2100] Modules linked in:
	Aug 28 15:30:57 regress kernel: [18454.515321][ T2100] ---[ end trace dc1ad17026339b11 ]---
	Aug 28 15:30:57 regress kernel: [18454.516184][ T2100] RIP: 0010:create_reloc_root+0x47a/0x490
	Aug 28 15:30:57 regress kernel: [18454.517085][ T2100] Code: e8 5b 3b bd ff 4d 8b 76 50 be 08 00 00 00 49 8d bc 24 f0 00 00 00 e8 65 3b bd ff 4d 89 b4 24 f0 00 00 00 e9 dc fc ff ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 b9 90 07 01 66 0f 1f 84 00 00 00 00 00
	Aug 28 15:30:57 regress kernel: [18454.520010][ T2100] RSP: 0018:ffffc90000c777d0 EFLAGS: 00010282
	Aug 28 15:30:57 regress kernel: [18454.520935][ T2100] RAX: 000000000000001b RBX: ffff88817cbc9400 RCX: ffffffffa5273b42
	Aug 28 15:30:57 regress kernel: [18454.522172][ T2100] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881f5dff28c
	Aug 28 15:30:57 regress kernel: [18454.523567][ T2100] RBP: ffffc90000c778c0 R08: ffffed103ebc1645 R09: ffffed103ebc1645
	Aug 28 15:30:57 regress kernel: [18454.524985][ T2100] R10: ffff8881f5e0b227 R11: ffffed103ebc1644 R12: ffff8881cb710020
	Aug 28 15:30:57 regress kernel: [18454.526404][ T2100] R13: ffff888118800a80 R14: 00000000ffffffef R15: ffffc90000c77858
	Aug 28 15:30:57 regress kernel: [18454.527887][ T2100] FS:  00007f1b8f7d9b80(0000) GS:ffff8881f5c00000(0000) knlGS:0000000000000000
	Aug 28 15:30:57 regress kernel: [18454.529576][ T2100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	Aug 28 15:30:57 regress kernel: [18454.530845][ T2100] CR2: 00007fc1d25e7100 CR3: 0000000120a8e006 CR4: 00000000001606e0
	Aug 28 15:30:57 regress kernel: [18454.821401][T32222] ==================================================================
	Aug 28 15:30:57 regress kernel: [18454.822634][T32222] BUG: KASAN: use-after-free in __mutex_lock+0x202/0xce0
	Aug 28 15:30:57 regress kernel: [18454.823654][T32222] Read of size 4 at addr ffff88811329c02c by task mkdir/32222
	Aug 28 15:30:57 regress kernel: [18454.824781][T32222] 
	Aug 28 15:30:57 regress kernel: [18454.825148][T32222] CPU: 1 PID: 32222 Comm: mkdir Tainted: G      D W         5.8.5-8de74804e45b+ #6
	Aug 28 15:30:57 regress kernel: [18454.826616][T32222] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	Aug 28 15:30:57 regress kernel: [18454.828088][T32222] Call Trace:
	Aug 28 15:30:57 regress kernel: [18454.828607][T32222]  dump_stack+0xc8/0x11a
	Aug 28 15:30:57 regress kernel: [18454.829297][T32222]  ? __mutex_lock+0x202/0xce0
	Aug 28 15:30:57 regress kernel: [18454.830033][T32222]  print_address_description.constprop.8+0x1f/0x200
	Aug 28 15:30:57 regress kernel: [18454.831062][T32222]  ? __mutex_lock+0x202/0xce0
	Aug 28 15:30:57 regress kernel: [18454.831783][T32222]  ? __mutex_lock+0x202/0xce0
	Aug 28 15:30:57 regress kernel: [18454.832537][T32222]  kasan_report.cold.11+0x20/0x3e
	Aug 28 15:30:57 regress kernel: [18454.833323][T32222]  ? __mutex_lock+0x202/0xce0
	Aug 28 15:30:57 regress kernel: [18454.834056][T32222]  __asan_load4+0x69/0x90
	Aug 28 15:30:57 regress kernel: [18454.834754][T32222]  __mutex_lock+0x202/0xce0
	Aug 28 15:30:57 regress kernel: [18454.835475][T32222]  ? wait_current_trans+0xb7/0x230
	Aug 28 15:30:57 regress kernel: [18454.836295][T32222]  ? btrfs_record_root_in_trans+0x7e/0xc0
	Aug 28 15:30:57 regress kernel: [18454.837206][T32222]  ? mutex_lock_io_nested+0xc20/0xc20
	Aug 28 15:30:57 regress kernel: [18454.838064][T32222]  ? __kasan_check_read+0x11/0x20
	Aug 28 15:30:57 regress kernel: [18454.838860][T32222]  ? join_transaction+0x32/0x6f0
	Aug 28 15:30:57 regress kernel: [18454.839653][T32222]  ? join_transaction+0x1a6/0x6f0
	Aug 28 15:30:57 regress kernel: [18454.840592][T32222]  ? lock_downgrade+0x3e0/0x3e0
	Aug 28 15:30:57 regress kernel: [18454.841401][T32222]  ? __kasan_check_write+0x14/0x20
	Aug 28 15:30:57 regress kernel: [18454.842165][T32222]  ? lock_contended+0x720/0x720
	Aug 28 15:30:57 regress kernel: [18454.842883][T32222]  ? do_raw_spin_lock+0x1e0/0x1e0
	Aug 28 15:30:57 regress kernel: [18454.843629][T32222]  ? wait_current_trans+0xb7/0x230
	Aug 28 15:30:57 regress kernel: [18454.844409][T32222]  mutex_lock_nested+0x1b/0x20
	Aug 28 15:30:57 regress kernel: [18454.845121][T32222]  ? mutex_lock_nested+0x1b/0x20
	Aug 28 15:30:57 regress kernel: [18454.845867][T32222]  btrfs_record_root_in_trans+0x7e/0xc0
	Aug 28 15:30:57 regress kernel: [18454.846694][T32222]  start_transaction+0x16b/0x8f0
	Aug 28 15:30:57 regress kernel: [18454.847438][T32222]  btrfs_start_transaction+0x1e/0x20
	Aug 28 15:30:57 regress kernel: [18454.848223][T32222]  btrfs_mkdir+0xf5/0x3b0
	Aug 28 15:30:57 regress kernel: [18454.848863][T32222]  ? make_kprojid+0x20/0x20
	Aug 28 15:30:57 regress kernel: [18454.849533][T32222]  ? putname+0x6b/0x80
	Aug 28 15:30:57 regress kernel: [18454.850141][T32222]  ? btrfs_rename2+0x2b20/0x2b20
	Aug 28 15:30:57 regress kernel: [18454.850866][T32222]  ? generic_permission+0x58/0x250
	Aug 28 15:30:57 regress kernel: [18454.851753][T32222]  ? security_inode_permission+0x1d/0x70
	Aug 28 15:30:57 regress kernel: [18454.852598][T32222]  ? inode_permission+0x7a/0x1f0
	Aug 28 15:30:57 regress kernel: [18454.853343][T32222]  vfs_mkdir+0x1e1/0x2f0
	Aug 28 15:30:57 regress kernel: [18454.853971][T32222]  do_mkdirat+0x192/0x1c0
	Aug 28 15:30:57 regress kernel: [18454.854620][T32222]  ? __ia32_sys_mknod+0x50/0x50
	Aug 28 15:30:57 regress kernel: [18454.855357][T32222]  ? trace_hardirqs_on_prepare+0x35/0x170
	Aug 28 15:30:57 regress kernel: [18454.856239][T32222]  __x64_sys_mkdir+0x37/0x40
	Aug 28 15:30:57 regress kernel: [18454.856951][T32222]  do_syscall_64+0x60/0xf0
	Aug 28 15:30:57 regress kernel: [18454.857645][T32222]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	Aug 28 15:30:57 regress kernel: [18454.858609][T32222] RIP: 0033:0x7f36074470d7
	Aug 28 15:30:57 regress kernel: [18454.859287][T32222] Code: 1f 40 00 48 8b 05 b9 0d 0d 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 0d 0d 00 f7 d8 64 89 01 48
	Aug 28 15:30:57 regress kernel: [18454.862597][T32222] RSP: 002b:00007ffc5c8419e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
	Aug 28 15:30:57 regress kernel: [18454.863874][T32222] RAX: ffffffffffffffda RBX: 00007ffc5c842bc8 RCX: 00007f36074470d7
	Aug 28 15:30:57 regress kernel: [18454.865087][T32222] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc5c842bc8
	Aug 28 15:30:57 regress kernel: [18454.866297][T32222] RBP: 00007ffc5c842bc8 R08: 00000000000001ff R09: 0000557174728c00
	Aug 28 15:30:57 regress kernel: [18454.867501][T32222] R10: fffffffffffff35a R11: 0000000000000206 R12: 00000000000001ff
	Aug 28 15:30:57 regress kernel: [18454.868709][T32222] R13: 0000000000000000 R14: 00007ffc5c841b60 R15: 00007ffc5c841cf0
	Aug 28 15:30:57 regress kernel: [18454.869923][T32222] 
	Aug 28 15:30:57 regress kernel: [18454.870296][T32222] Allocated by task 2066:
	Aug 28 15:30:57 regress kernel: [18454.870939][T32222]  save_stack+0x21/0x50
	Aug 28 15:30:57 regress kernel: [18454.871572][T32222]  __kasan_kmalloc.constprop.17+0xc1/0xd0
	Aug 28 15:30:57 regress kernel: [18454.872434][T32222]  kasan_slab_alloc+0x12/0x20
	Aug 28 15:30:57 regress kernel: [18454.873133][T32222]  kmem_cache_alloc_node+0x113/0x720
	Aug 28 15:30:57 regress kernel: [18454.873914][T32222]  copy_process+0x357/0x3680
	Aug 28 15:30:57 regress kernel: [18454.874653][T32222]  _do_fork+0xed/0x880
	Aug 28 15:30:57 regress kernel: [18454.875353][T32222]  __do_sys_clone+0xee/0x130
	Aug 28 15:30:57 regress kernel: [18454.876057][T32222]  __x64_sys_clone+0x67/0x80
	Aug 28 15:30:57 regress kernel: [18454.876782][T32222]  do_syscall_64+0x60/0xf0
	Aug 28 15:30:57 regress kernel: [18454.877476][T32222]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	Aug 28 15:30:57 regress kernel: [18454.878398][T32222] 
	Aug 28 15:30:57 regress kernel: [18454.878760][T32222] Freed by task 3558:
	Aug 28 15:30:57 regress kernel: [18454.879384][T32222]  save_stack+0x21/0x50
	Aug 28 15:30:57 regress kernel: [18454.880038][T32222]  __kasan_slab_free+0x118/0x170
	Aug 28 15:30:57 regress kernel: [18454.880855][T32222]  kasan_slab_free+0xe/0x10
	Aug 28 15:30:57 regress kernel: [18454.881565][T32222]  kmem_cache_free+0x5f/0x280
	Aug 28 15:30:57 regress kernel: [18454.882297][T32222]  free_task+0x73/0x90
	Aug 28 15:30:57 regress kernel: [18454.882928][T32222]  __put_task_struct+0x199/0x1d0
	Aug 28 15:30:57 regress kernel: [18454.883699][T32222]  delayed_put_task_struct+0x124/0x1b0
	Aug 28 15:30:57 regress kernel: [18454.884615][T32222]  rcu_core+0x3b0/0xea0
	Aug 28 15:30:57 regress kernel: [18454.885273][T32222]  rcu_core_si+0xe/0x10
	Aug 28 15:30:57 regress kernel: [18454.886251][T32222]  __do_softirq+0x120/0x5e3
	Aug 28 15:30:57 regress kernel: [18454.886964][T32222] 
	Aug 28 15:30:57 regress kernel: [18454.887332][T32222] The buggy address belongs to the object at ffff88811329c000
	Aug 28 15:30:57 regress kernel: [18454.887332][T32222]  which belongs to the cache task_struct(192:ssh.service) of size 11072
	Aug 28 15:30:57 regress kernel: [18454.889771][T32222] The buggy address is located 44 bytes inside of
	Aug 28 15:30:57 regress kernel: [18454.889771][T32222]  11072-byte region [ffff88811329c000, ffff88811329eb40)
	Aug 28 15:30:57 regress kernel: [18454.891843][T32222] The buggy address belongs to the page:
	Aug 28 15:30:57 regress kernel: [18454.892718][T32222] page:ffffea00044ca700 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811329ffff head:ffffea00044ca700 order:2 compound_mapcount:0 compound_pincount:0
	Aug 28 15:30:57 regress kernel: [18454.895303][T32222] flags: 0x17ffe0000010200(slab|head)
	Aug 28 15:30:57 regress kernel: [18454.896186][T32222] raw: 017ffe0000010200 ffffea0001a49908 ffff8881f5b36498 ffff8881eb5a1380
	Aug 28 15:30:57 regress kernel: [18454.897618][T32222] raw: ffff88811329ffff ffff88811329c000 0000000100000001 0000000000000000
	Aug 28 15:30:57 regress kernel: [18454.899016][T32222] page dumped because: kasan: bad access detected
	Aug 28 15:30:57 regress kernel: [18454.900061][T32222] 
	Aug 28 15:30:57 regress kernel: [18454.900439][T32222] Memory state around the buggy address:
	Aug 28 15:30:57 regress kernel: [18454.901364][T32222]  ffff88811329bf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	Aug 28 15:30:57 regress kernel: [18454.902699][T32222]  ffff88811329bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	Aug 28 15:30:57 regress kernel: [18454.904052][T32222] >ffff88811329c000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	Aug 28 15:30:57 regress kernel: [18454.905345][T32222]                                   ^
	Aug 28 15:30:57 regress kernel: [18454.906245][T32222]  ffff88811329c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	Aug 28 15:30:57 regress kernel: [18454.907675][T32222]  ffff88811329c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	Aug 28 15:30:57 regress kernel: [18454.909247][T32222] ==================================================================

