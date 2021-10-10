Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02A4282DB
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Oct 2021 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJJSCz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 10 Oct 2021 14:02:55 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42750 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhJJSCz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 14:02:55 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EFB5DBB747C; Sun, 10 Oct 2021 14:00:55 -0400 (EDT)
Date:   Sun, 10 Oct 2021 14:00:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Ian Kelling <iank@fsf.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: I got a write time tree block corruption detected
Message-ID: <20211010180055.GR29026@hungrycats.org>
References: <87ily8y9c8.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87ily8y9c8.fsf@fsf.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 07, 2021 at 02:32:23PM -0400, Ian Kelling wrote:
> # uname -a
> Linux hostname.fsf.org 5.8.0-59-generic #66~20.04.1 SMP Sat Jul 10 19:20:41 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.10.1
> 
> 
> I was running this command:
> btrfs balance start -dconvert=raid1c3 -mconvert=raid1c3 /srv/backup-online
> 
> Note, the command was a bit of a mistake since the filesystem was
> already raid1c3 with 3 16tb disks. It failed after about a day, this was
> in dmesg:
> 
> [Thu Oct  7 12:01:59 2021] BTRFS info (device dm-3): relocating block group 17366831333376 flags data|raid1c3
> [Thu Oct  7 12:44:01 2021] ------------[ cut here ]------------
> [Thu Oct  7 12:44:01 2021] BTRFS: Transaction aborted (error -28)
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS info (device dm-3): forced readonly
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_finish_ordered_io:2705: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] WARNING: CPU: 10 PID: 3140 at fs/btrfs/extent-tree.c:2144 btrfs_run_delayed_refs+0x1af/0x200 [btrfs]
> [Thu Oct  7 12:44:01 2021] Modules linked in: dm_crypt algif_skcipher af_alg edac_mce_amd nf_log_ipv6 kvm_amd xt_hl ccp ip6t_rt kvm ip6t_REJECT crct10dif_pclmul nf_reject_ipv6 crc32_pclmul ghash_clmulni_intel nf_log_ipv4 nf_log_common aesni_intel input_leds joydev crypto_simd xt_LOG cryptd glue_helper serio_raw xt_recent mac_hid qemu_fw_cfg xt_limit xt_tcpudp xt_addrtype xt_conntrack ipt_REJECT nf_reject_ipv4 ip6table_filter ip6_tables nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp nf_nat nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 sch_fq_codel nf_defrag_ipv4 iptable_filter bpfilter sunrpc ip_tables x_tables autofs4 xfs btrfs blake2b_generic xor raid6_pq libcrc32c cirrus drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core virtio_net net_failover psmouse drm virtio_blk failover i2c_piix4 pata_acpi floppy
> [Thu Oct  7 12:44:01 2021] CPU: 10 PID: 3140 Comm: btrfs-transacti Not tainted 5.8.0-59-generic #66~20.04.1
> [Thu Oct  7 12:44:01 2021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [Thu Oct  7 12:44:01 2021] RIP: 0010:btrfs_run_delayed_refs+0x1af/0x200 [btrfs]
> [Thu Oct  7 12:44:01 2021] Code: 8b 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 20 83 f8 fb 74 3c 83 f8 e2 74 37 89 c6 48 c7 c7 20 b5 4a c0 89 45 d0 e8 a9 7e f3 f3 <0f> 0b 8b 45 d0 89 c1 ba 60 08 00 00 4c 89 ef 89 45 d0 48 c7 c6 20
> [Thu Oct  7 12:44:01 2021] RSP: 0018:ffffb15b00d1fd68 EFLAGS: 00010286
> [Thu Oct  7 12:44:01 2021] RAX: 0000000000000000 RBX: 0000000000071fd2 RCX: 0000000000000027
> [Thu Oct  7 12:44:01 2021] RDX: 0000000000000027 RSI: 0000000000000086 RDI: ffff9ed01bc98cd8
> [Thu Oct  7 12:44:01 2021] RBP: ffffb15b00d1fdb0 R08: ffff9ed01bc98cd0 R09: 0000000000000004
> [Thu Oct  7 12:44:01 2021] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9ecaa2ce4f88
> [Thu Oct  7 12:44:01 2021] R13: ffff9ed0116f5410 R14: ffff9eca9dedcbd0 R15: ffff9ecad5e86d60
> [Thu Oct  7 12:44:01 2021] FS:  0000000000000000(0000) GS:ffff9ed01bc80000(0000) knlGS:0000000000000000
> [Thu Oct  7 12:44:01 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Thu Oct  7 12:44:01 2021] CR2: 000000000dbaa00a CR3: 00000001c61a4000 CR4: 00000000000406e0
> [Thu Oct  7 12:44:01 2021] Call Trace:
> [Thu Oct  7 12:44:01 2021]  btrfs_start_dirty_block_groups+0x2be/0x4a0 [btrfs]
> [Thu Oct  7 12:44:01 2021]  btrfs_commit_transaction+0xc6/0x9e0 [btrfs]
> [Thu Oct  7 12:44:01 2021]  ? start_transaction+0xd7/0x550 [btrfs]
> [Thu Oct  7 12:44:01 2021]  ? __next_timer_interrupt+0xb0/0xe0
> [Thu Oct  7 12:44:01 2021]  transaction_kthread+0x146/0x190 [btrfs]
> [Thu Oct  7 12:44:01 2021]  kthread+0x114/0x150
> [Thu Oct  7 12:44:01 2021]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
> [Thu Oct  7 12:44:01 2021]  ? kthread_park+0x90/0x90
> [Thu Oct  7 12:44:01 2021]  ret_from_fork+0x22/0x30
> [Thu Oct  7 12:44:01 2021] ---[ end trace ba3013eb4032f5ac ]---
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:2144: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in __btrfs_run_delayed_items:1172: errno=-28 No space left
> [Thu Oct  7 12:44:01 2021] BTRFS warning (device dm-3): Skipping commit of aborted transaction.
> [Thu Oct  7 12:44:01 2021] BTRFS: error (device dm-3) in cleanup_transaction:1939: errno=-28 No space left
> [Thu Oct  7 12:44:04 2021] BTRFS info (device dm-3): 80 enospc errors during balance
> [Thu Oct  7 12:44:04 2021] BTRFS info (device dm-3): balance: ended with status: -30
> 
> I unmounted the filesystem, then tried a remount like so:
> mount -o skip_balance /dev/mapper/btrfs0 /mnt/backup-tmp
> which failed, and the following was in dmesg:
> 
> [Thu Oct  7 12:57:11 2021] BTRFS info (device dm-3): disk space caching is enabled
> [Thu Oct  7 12:57:11 2021] BTRFS info (device dm-3): has skinny extents
> [Thu Oct  7 12:58:08 2021] BTRFS info (device dm-3): start tree-log replay
> [Thu Oct  7 13:04:36 2021] BTRFS: error (device dm-3) in btrfs_replay_log:2362: errno=-22 unknown (Failed to recover log tree)

We can stop reading here.  This is the first error.

> 2021 Oct  7 13:04:36 monolith BTRFS: error (device dm-3) in btrfs_replay_log:2362: errno=-22 unknown (Failed to recover log tree)
> [Thu Oct  7 13:04:41 2021] BTRFS critical (device dm-3): corrupt leaf: root=5 block=5558935797760 slot=0 ino=161138910, invalid nlink: has 2 expect no more than 1 for dir
> [Thu Oct  7 13:04:41 2021] BTRFS info (device dm-3): leaf 5558935797760 gen 129446 total ptrs 88 free space 3 owner 5
> [Thu Oct  7 13:04:41 2021]      item 0 key (161138910 1 0) itemoff 16123 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40700
> [Thu Oct  7 13:04:41 2021]      item 1 key (161138911 1 0) itemoff 15963 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 2 key (161138913 1 0) itemoff 15803 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 3 key (161138914 1 0) itemoff 15643 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 4 key (161138916 1 0) itemoff 15483 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 5 key (161138918 1 0) itemoff 15323 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 6 key (161138919 1 0) itemoff 15163 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40700
> [Thu Oct  7 13:04:41 2021]      item 7 key (161138921 1 0) itemoff 15003 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 8 key (161138922 1 0) itemoff 14843 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 9 key (161138923 1 0) itemoff 14683 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 10 key (161138926 1 0) itemoff 14523 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 11 key (161138928 1 0) itemoff 14363 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 12 key (161138929 1 0) itemoff 14203 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 13 key (161138930 1 0) itemoff 14043 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 14 key (161138933 1 0) itemoff 13883 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 11903 mode 100640
> [Thu Oct  7 13:04:41 2021]      item 15 key (161138934 1 0) itemoff 13723 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 16 key (161138935 1 0) itemoff 13563 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 17 key (161138937 1 0) itemoff 13403 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 18 key (161138938 1 0) itemoff 13243 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 19 key (161138939 1 0) itemoff 13083 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 20 key (161138941 1 0) itemoff 12923 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 21 key (161138942 1 0) itemoff 12763 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 22 key (161138944 1 0) itemoff 12603 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 23 key (161138945 1 0) itemoff 12443 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 24 key (161138947 1 0) itemoff 12283 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 25 key (161138948 1 0) itemoff 12123 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 26 key (161138949 1 0) itemoff 11963 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 27 key (161138951 1 0) itemoff 11803 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 103 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 28 key (161138952 1 0) itemoff 11643 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 29 key (161138954 1 0) itemoff 11483 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 30 key (161138955 1 0) itemoff 11323 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 31 key (161138956 1 0) itemoff 11163 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 32 key (161138957 1 0) itemoff 11003 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 33 key (161138959 1 0) itemoff 10843 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 34 key (161138961 1 0) itemoff 10683 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 35 key (161138962 1 0) itemoff 10523 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 36 key (161138963 1 0) itemoff 10363 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 37 key (161138965 1 0) itemoff 10203 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 38 key (161138966 1 0) itemoff 10043 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 39 key (161138968 1 0) itemoff 9883 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 40 key (161138969 1 0) itemoff 9723 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 41 key (161138971 1 0) itemoff 9563 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 42 key (161138972 1 0) itemoff 9403 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 43 key (161138974 1 0) itemoff 9243 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 44 key (161138975 1 0) itemoff 9083 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 45 key (161138976 1 0) itemoff 8923 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 46 key (161138978 1 0) itemoff 8763 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 47 key (161138979 1 0) itemoff 8603 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 48 key (161138980 1 0) itemoff 8443 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 29858047 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 49 key (161138982 1 0) itemoff 8283 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 50 key (161138983 1 0) itemoff 8123 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 51 key (161138984 1 0) itemoff 7963 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 52 key (161138985 1 0) itemoff 7803 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 53 key (161138987 1 0) itemoff 7643 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 54 key (161138988 1 0) itemoff 7483 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 55 key (161138990 1 0) itemoff 7323 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 56 key (161138991 1 0) itemoff 7163 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 57 key (161138993 1 0) itemoff 7003 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 58 key (161138994 1 0) itemoff 6843 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 59 key (161138996 1 0) itemoff 6683 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 60 key (161138997 1 0) itemoff 6523 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 61 key (161138999 1 0) itemoff 6363 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 62 key (161139000 1 0) itemoff 6203 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 63 key (161139002 1 0) itemoff 6043 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 64 key (161139003 1 0) itemoff 5883 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 65 key (161139005 1 0) itemoff 5723 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 66 key (161139006 1 0) itemoff 5563 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 67 key (161139007 1 0) itemoff 5403 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 68 key (161139008 1 0) itemoff 5243 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 69 key (161139010 1 0) itemoff 5083 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 70 key (161139011 1 0) itemoff 4923 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 71 key (161139012 1 0) itemoff 4763 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 72 key (161139014 1 0) itemoff 4603 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 73 key (161139015 1 0) itemoff 4443 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 74 key (161139016 1 0) itemoff 4283 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 75 key (161139017 1 0) itemoff 4123 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 76 key (161139019 1 0) itemoff 3963 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 77 key (161139020 1 0) itemoff 3803 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 78 key (161139021 1 0) itemoff 3643 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 79 key (161139023 1 0) itemoff 3483 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 80 key (161139024 1 0) itemoff 3323 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 81 key (161139025 1 0) itemoff 3163 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 82 key (161139027 1 0) itemoff 3003 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 83 key (161139028 1 0) itemoff 2843 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 40755
> [Thu Oct  7 13:04:41 2021]      item 84 key (161139029 1 0) itemoff 2683 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 85 key (161139031 1 0) itemoff 2523 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 101 mode 100600
> [Thu Oct  7 13:04:41 2021]      item 86 key (161139032 1 0) itemoff 2363 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100644
> [Thu Oct  7 13:04:41 2021]      item 87 key (161139034 1 0) itemoff 2203 itemsize 160
> [Thu Oct  7 13:04:41 2021]              inode generation 129446 size 0 mode 100600
> [Thu Oct  7 13:04:41 2021] BTRFS error (device dm-3): block=5558935797760 write time tree block corruption detected                                                   
> [Thu Oct  7 13:04:42 2021] BTRFS: error (device dm-3) in btrfs_commit_transaction:2366: errno=-30 Readonly filesystem (Error while writing out transaction)
> [Thu Oct  7 13:04:42 2021] BTRFS warning (device dm-3): Skipping commit of aborted transaction.
> [Thu Oct  7 13:04:42 2021] BTRFS: error (device dm-3) in cleanup_transaction:1939: errno=-30 Readonly filesystem
> 2021 Oct  7 13:04:41 monolith BTRFS critical (device dm-3): corrupt leaf: root=5 block=5558935797760 slot=0 ino=161138910, invalid nlink: has 2 expect no more than 1 for dir
> 2021 Oct  7 13:04:42 monolith BTRFS: error (device dm-3) in btrfs_commit_transaction:2366: errno=-30 Readonly filesystem (Error while writing out transaction)
> 2021 Oct  7 13:04:42 monolith BTRFS: error (device dm-3) in cleanup_transaction:1939: errno=-30 Readonly filesystem
> [Thu Oct  7 13:04:46 2021] BTRFS error (device dm-3): open_ctree failed
> 
> I searched for the error and came upon
> https://btrfs.wiki.kernel.org/index.php/Tree-checker , which said to
> email here. Any help is appreciated, I'd like to get this filesystem
> working again as soon as possible.

This is a failure in log tree replay.  'btrfs rescue zero-log' should
resolve it, though it will wipe out the last few seconds of writes to
the filesystem.

I'd upgrade to at least a current LTS kernel (5.10).  5.8 is a year old
and no longer maintained.  The bug you have found may be fixed already.

> I'm currently running btrfs check /dev/dm-3
> 
> -- 
> Ian Kelling | Senior Systems Administrator, Free Software Foundation
> GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
> https://fsf.org | https://gnu.org
