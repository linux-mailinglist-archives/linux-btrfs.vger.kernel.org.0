Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD03A3396
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFJS5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 14:57:12 -0400
Received: from dark-alexandr.net ([194.87.138.36]:8962 "EHLO
        privacy-is-dead.xyz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhFJS5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 14:57:11 -0400
Received: from [192.168.0.2] (helo=sss-desktop)
        by privacy-is-dead.xyz with esmtpsa  (TLS1.3) tls TLS_CHACHA20_POLY1305_SHA256
        (Exim 4.94-396-ca261bddd-XX)
        (envelope-from <sss@sss.chaoslab.ru>)
        id 1lrPEr-000IXu-7L
        for linux-btrfs@vger.kernel.org;
        Thu, 10 Jun 2021 21:17:09 +0300
Date:   Thu, 10 Jun 2021 18:17:04 +0000
From:   sss <sss@sss.chaoslab.ru>
To:     linux-btrfs@vger.kernel.org
Subject: BUG: kernel NULL pointer dereference, address: 000000000000005a
Message-ID: <20210610181704.rsdewwjrvd4ze63e@sss-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated-User: sss@sss.chaoslab.ru
X-Authenticator: plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

2021-06-10 17:54:41	Zygo	sss1: post the stack trace to the mailing list, then reboot
2021-06-10 17:54:55	Zygo	looks like you might have found tree mod log bug #7

[ 2147.950658] BTRFS critical (device dm-15): unable to find logical 0 length 4096
[ 2147.950833] BTRFS critical (device dm-15): unable to find logical 0 length 4096
[ 2147.950994] BUG: kernel NULL pointer dereference, address: 000000000000005a
[ 2147.951109] #PF: supervisor read access in kernel mode
[ 2147.951215] #PF: error_code(0x0000) - not-present page
[ 2147.951346] PGD 0 P4D 0 
[ 2147.951452] Oops: 0000 [#1] SMP NOPTI
[ 2147.951555] CPU: 3 PID: 31734 Comm: crawl_5 Not tainted 5.12.10 #2
[ 2147.951673] Hardware name: Supermicro H8DG6/H8DGi/H8DG6/H8DGi, BIOS 3.5c       03/18/2016
[ 2147.951821] RIP: 0010:btrfs_get_io_geometry+0x19/0xf0
[ 2147.951943] Code: 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55 49 89 ca 41 89 d3 31 d2 48 89 e5 41 56 41 55 41 54 49 89 fc 48 89 cf 53 <4c> 8b 76 70 4c 8b 46 18 49 8b 4e 10 4d 29 c2 4c 89 d0 48 f7 f1 49
[ 2147.952159] RSP: 0018:ffffc90006feb580 EFLAGS: 00010246
[ 2147.952266] RAX: ffffffffffffffea RBX: ffffc90006feb6d0 RCX: 0000000000000000
[ 2147.952386] RDX: 0000000000000000 RSI: ffffffffffffffea RDI: 0000000000000000
[ 2147.952539] RBP: ffffc90006feb5a0 R08: 0000000000001000 R09: ffffc90006feb638
[ 2147.952656] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888105ce3000
[ 2147.952779] R13: ffff888105ce3000 R14: ffffffffffffffea R15: 0000000000000000
[ 2147.952899] FS:  00007f2a60b58640(0000) GS:ffff88bf236c0000(0000) knlGS:0000000000000000
[ 2147.953050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2147.953171] CR2: 000000000000005a CR3: 0000000542304000 CR4: 00000000000406e0
[ 2147.953304] Call Trace:
[ 2147.953415]  __btrfs_map_block+0x80/0xd40
[ 2147.953522]  ? printk+0x53/0x6a
[ 2147.953635]  btrfs_map_bio+0x8f/0x460
[ 2147.953784]  btrfs_submit_metadata_bio+0x10a/0x170
[ 2147.953900]  submit_one_bio+0x62/0x70
[ 2147.954025]  submit_extent_page+0x7e/0x2c0
[ 2147.954138]  read_extent_buffer_pages+0x1eb/0x540
[ 2147.954248]  ? btrfs_submit_read_repair+0x4f0/0x4f0
[ 2147.954367]  btree_read_extent_buffer_pages+0x9c/0x110
[ 2147.954480]  read_tree_block+0x39/0x70
[ 2147.954582]  read_block_for_search+0x1be/0x3b0
[ 2147.954700]  btrfs_search_old_slot+0x23f/0x960
[ 2147.954815]  btrfs_next_old_leaf+0xee/0x380
[ 2147.954926]  find_parent_nodes+0x18a1/0x1c00
[ 2147.955066]  btrfs_find_all_leafs+0x5e/0xa0
[ 2147.955172]  iterate_extent_inodes+0xb2/0x250
[ 2147.955273]  ? btrfs_get_64+0x64/0x110
[ 2147.955380]  ? btrfs_inode_flags_to_xflags+0x50/0x50
[ 2147.955497]  iterate_inodes_from_logical+0xae/0xe0
[ 2147.955603]  ? btrfs_inode_flags_to_xflags+0x50/0x50
[ 2147.955715]  btrfs_ioctl_logical_to_ino+0x136/0x1b0
[ 2147.955824]  btrfs_ioctl+0xbfe/0x2f90
[ 2147.955932]  ? get_task_mm+0x14/0x50
[ 2147.956035]  ? getrusage+0x412/0x420
[ 2147.956137]  ? new_sync_read+0x140/0x1c0
[ 2147.956276]  ? _copy_to_user+0x20/0x30
[ 2147.956378]  ? __do_sys_getrusage+0x69/0xb0
[ 2147.956486]  ? __audit_syscall_entry+0xd6/0x120
[ 2147.956598]  __x64_sys_ioctl+0x89/0xc0
[ 2147.956702]  ? __x64_sys_ioctl+0x89/0xc0
[ 2147.956814]  do_syscall_64+0x32/0x80
[ 2147.956919]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2147.957029] RIP: 0033:0x7f2a6445592b
[ 2147.957140] Code: ff ff ff 85 c0 79 8b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 15 a5 0c 00 f7 d8 64 89 01 48
[ 2147.957349] RSP: 002b:00007f2a60b55cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 2147.957528] RAX: ffffffffffffffda RBX: 00005611cc7757b0 RCX: 00007f2a6445592b
[ 2147.957646] RDX: 00007f2a60b55f28 RSI: 00000000c038943b RDI: 0000000000000003
[ 2147.957768] RBP: 00007f2a60b55f20 R08: 0000000000000000 R09: 00007f2a60b56100
[ 2147.957886] R10: 00000000000e43b8 R11: 0000000000000246 R12: 0000000000000003
[ 2147.958002] R13: 00007f2a60b55f28 R14: 00007f2a60b56030 R15: 00007f2a60b55ee8
[ 2147.958131] Modules linked in: nft_masq nft_nat nft_chain_nat nf_nat nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables nfnetlink mousedev hid_generic usbhid ipmi_si ipmi_devintf crc32c_intel ipmi_msghandler fam15h_power ohci_pci i2c_piix4 ohci_hcd bonding tls igb i2c_algo_bit i2c_core button acpi_cpufreq sch_fq_codel br_netfilter bridge stp llc vhost_net vhost vhost_iotlb kvm_amd kvm irqbypass k10temp hwmon parport tun nfsd fuse auth_rpcgss nfs_acl lockd grace sunrpc bpf_preload autofs4
[ 2147.958676] CR2: 000000000000005a
[ 2147.958810] ---[ end trace 7c6f62b6aa0a4769 ]---
[ 2147.958984] RIP: 0010:btrfs_get_io_geometry+0x19/0xf0
[ 2147.959101] Code: 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55 49 89 ca 41 89 d3 31 d2 48 89 e5 41 56 41 55 41 54 49 89 fc 48 89 cf 53 <4c> 8b 76 70 4c 8b 46 18 49 8b 4e 10 4d 29 c2 4c 89 d0 48 f7 f1 49
[ 2147.959320] RSP: 0018:ffffc90006feb580 EFLAGS: 00010246
[ 2147.959437] RAX: ffffffffffffffea RBX: ffffc90006feb6d0 RCX: 0000000000000000
[ 2147.959559] RDX: 0000000000000000 RSI: ffffffffffffffea RDI: 0000000000000000
[ 2147.959678] RBP: ffffc90006feb5a0 R08: 0000000000001000 R09: ffffc90006feb638
[ 2147.959796] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888105ce3000
[ 2147.959939] R13: ffff888105ce3000 R14: ffffffffffffffea R15: 0000000000000000
[ 2147.960067] FS:  00007f2a60b58640(0000) GS:ffff88bf236c0000(0000) knlGS:0000000000000000
[ 2147.960215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2147.960324] CR2: 000000000000005a CR3: 0000000542304000 CR4: 00000000000406e0


