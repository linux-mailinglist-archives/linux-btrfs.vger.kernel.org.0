Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D154B41E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbfIPUcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 16:32:02 -0400
Received: from mail.robco.com ([64.119.213.201]:48385 "EHLO mail.robco.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733017AbfIPUcC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 16:32:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.robco.com (Postfix) with ESMTP id 0920E18DC
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 16:32:01 -0400 (EDT)
Received: from mail.robco.com ([127.0.0.1])
        by localhost (mail.robco.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jXg_DjwwePcs for <linux-btrfs@vger.kernel.org>;
        Mon, 16 Sep 2019 16:32:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.robco.com (Postfix) with ESMTP id D23481C17
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 16:32:00 -0400 (EDT)
X-Virus-Scanned: amavisd-new at robco.com
Received: from mail.robco.com ([127.0.0.1])
        by localhost (mail.robco.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3rZtLl9ivIh8 for <linux-btrfs@vger.kernel.org>;
        Mon, 16 Sep 2019 16:32:00 -0400 (EDT)
Received: from mail.robco.com (localhost [127.0.0.1])
        by mail.robco.com (Postfix) with ESMTP id A7BDD18DC
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 16:32:00 -0400 (EDT)
Date:   Mon, 16 Sep 2019 16:32:00 -0400 (EDT)
From:   Lai Wei-Hwa <whlai@robco.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <79984309.572916.1568665920098.JavaMail.zimbra@robco.com>
In-Reply-To: <591580482.537773.1568655046847.JavaMail.zimbra@robco.com>
References: <591580482.537773.1568655046847.JavaMail.zimbra@robco.com>
Subject: btrfs scrub resulting in readonly filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.2.144]
X-Mailer: Zimbra 8.7.11_GA_3800 (ZimbraWebClient - FF69 (Linux)/8.7.11_GA_3800)
Thread-Topic: btrfs scrub resulting in readonly filesystem
Thread-Index: aXvGEVu6aioDPTVwKLyXdAlKgw4O15/CHLDp
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi There, 

Found a host with readonly filesystem. This is the output from dmesg which occurred right after a cron job was executed to scrub. 



[Sep14 20:02] ------------[ cut here ]------------ 
[ +0.000042] WARNING: CPU: 18 PID: 28882 at /build/linux-TSOhpZ/linux-4.4.0/fs/btrfs/extent-tree.c:10046 btrfs_create_pending_block_groups+0x144/0x1f0 [btrfs]() 
[ +0.000002] BTRFS: Transaction aborted (error -27) 
[ +0.000002] Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common xt_LOG xt_limit xt_tcpudp xt_hl ip6t_rt nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack nf_conntrack ip6table_filter ip6_tables x_tables ufs qnx4 hfsplus hfs minix ntfs msdos jfs xfs cpuid unix_diag veth bridge stp llc bonding binfmt_misc zfs(PO) zunicode(PO) zcommon(PO) znvpair(PO) spl(O) zavl(PO) intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ipmi_devintf ipmi_ssif ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul dcdbas glue_helper input_leds ablk_helper ipmi_si gpio_ich serio_raw i7core_edac joydev 8250_fintek acpi_power_meter mac_hid ipmi_msghandler shpchp edac_core cryptd lpc_ich ib_iser rdma_cm iw_cm ib_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi 
[ +0.000047] autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear ses enclosure scsi_transport_sas uas hid_generic usbhid usb_storage wmi psmouse hid pata_acpi megaraid_sas bnx2 fjes 
[ +0.000019] CPU: 18 PID: 28882 Comm: btrfs Tainted: P IO 4.4.0-157-generic #185-Ubuntu 
[ +0.000002] Hardware name: Dell Inc. PowerEdge R610/0F0XJ6, BIOS 6.4.0 07/23/2013 
[ +0.000001] 0000000000000286 1faf5c66f8e16e90 ffff8802adbcfa18 ffffffff8140c9a1 
[ +0.000003] ffff8802adbcfa60 ffffffffc024d588 ffff8802adbcfa50 ffffffff810864d2 
[ +0.000002] ffff880697e29720 ffff880c11881da0 ffff880c0f6e6800 ffff880697e29640 
[ +0.000002] Call Trace: 
[ +0.000008] [<ffffffff8140c9a1>] dump_stack+0x63/0x82 
[ +0.000007] [<ffffffff810864d2>] warn_slowpath_common+0x82/0xc0 
[ +0.000002] [<ffffffff8108656c>] warn_slowpath_fmt+0x5c/0x80 
[ +0.000014] [<ffffffffc01f31c4>] ? btrfs_finish_chunk_alloc+0x204/0x5a0 [btrfs] 
[ +0.000011] [<ffffffffc01b1d24>] btrfs_create_pending_block_groups+0x144/0x1f0 [btrfs] 
[ +0.000012] [<ffffffffc01c7ed3>] __btrfs_end_transaction+0x93/0x340 [btrfs] 
[ +0.000013] [<ffffffffc01c8190>] btrfs_end_transaction+0x10/0x20 [btrfs] 
[ +0.000010] [<ffffffffc01b5a4d>] btrfs_inc_block_group_ro+0xed/0x1b0 [btrfs] 
[ +0.000014] [<ffffffffc02253bf>] scrub_enumerate_chunks+0x21f/0x580 [btrfs] 
[ +0.000004] [<ffffffff810cb700>] ? wake_atomic_t_function+0x60/0x60 
[ +0.000013] [<ffffffffc0226d0c>] btrfs_scrub_dev+0x1bc/0x530 [btrfs] 
[ +0.000004] [<ffffffff8123f306>] ? __mnt_want_write+0x56/0x60 
[ +0.000013] [<ffffffffc0202408>] btrfs_ioctl+0x1ac8/0x28c0 [btrfs] 
[ +0.000003] [<ffffffff8119a3b9>] ? unlock_page+0x69/0x70 
[ +0.000002] [<ffffffff8119a654>] ? filemap_map_pages+0x224/0x230 
[ +0.000004] [<ffffffff811cdb77>] ? handle_mm_fault+0x10f7/0x1b80 
[ +0.000002] [<ffffffff811fb77b>] ? kmem_cache_alloc_node+0xbb/0x210 
[ +0.000003] [<ffffffff813e13e3>] ? create_task_io_context+0x23/0x100 
[ +0.000003] [<ffffffff812318ef>] do_vfs_ioctl+0x2af/0x4b0 
[ +0.000002] [<ffffffff813e1510>] ? get_task_io_context+0x50/0x90 
[ +0.000003] [<ffffffff813f0936>] ? set_task_ioprio+0x86/0xa0 
[ +0.000002] [<ffffffff81231b69>] SyS_ioctl+0x79/0x90 
[ +0.000004] [<ffffffff81864f1b>] entry_SYSCALL_64_fastpath+0x22/0xcb 
[ +0.000002] ---[ end trace 13fce4e84d9b6aed ]--- 
[ +0.000003] BTRFS: error (device sda1) in btrfs_create_pending_block_groups:10046: errno=-27 unknown 
[ +0.003942] BTRFS info (device sda1): forced readonly 
[ +0.000193] pending csums is 28672 
[ +0.002295] BTRFS warning (device sda1): failed setting block group ro, ret=-30 

[ +7.197271] BTRFS warning (device sda1): failed setting block group ro, ret=-30 



What's the cause here? 


Best Regards, 

Lai Wei-Hwa

Thanks! 
Lai
