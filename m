Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8F21DEF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgGMRqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 13:46:52 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34406 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMRqw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 13:46:52 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A370A75E0D8; Mon, 13 Jul 2020 13:46:50 -0400 (EDT)
Date:   Mon, 13 Jul 2020 13:46:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Peter Hjalmarsson <kanelxake@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FS broken by defrag and balance at the same time hitting enospc
Message-ID: <20200713174650.GG10769@hungrycats.org>
References: <CALpSwpjYDgKMSpuNWG1C6aPoYV9xof1t+r71jfv78g0eydU2iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpSwpjYDgKMSpuNWG1C6aPoYV9xof1t+r71jfv78g0eydU2iQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 11:44:02AM +0200, Peter Hjalmarsson wrote:
> Hi,
> 
> I have a broken FS currently, triggered from a problem I am unsure on
> how to reproduce since I do not know how to generate fragmented files
> on demand or that matches the FS criterias.
> But I will try to describe the problem happening so maybe someone that
> knows how can try at it.
> 
> I have a filesystem consisting of two 2TB disks running RAID0.
> The files on this FS are of varying size from a couple of megabytes up
> to a couple of gigabytes.
> The FS in itself is a form of scratchspace, where most files are read
> most. However the files are written to enough to cause fragmentation.
> For example there is a 16GB big file that had 12520 extents according
> to filefrag.

That file had an average of 1372194 bytes per extent, which is within the
range of optimal extent sizes (512K..4M or so).  The benefit of further
defragmentation is negligible, unless 1) you have slow spinning disks,
and you read the entire file sequentially very often, or 2) the files
are nodatacow, which avoids many of the costs of larger extents.

If the extents become too large, then they make unnecessary work for
future balance operations, and they increase wasted space on large,
frequently-modified files.  If the filesystem is low on disk space
(less than about 100GB free) then too many large extents can make it
impossible to defrag or balance.

You should do a data balance on empty block groups (e.g. btrfs balance
start -dusage=75) before and after a large defrag.  The balance before
defrag makes large contiguous regions of free space available for defrag.
The balance after defrag coalesces the small regions of free space that
are freed by the defrag operation.  Without the balances, defrag is
less efficient and effective--more IO, more fragmentation remaining.

> The biggest file is about 90GB and when I started the FS had according
> to "df -h" over 200 GB free space.
> 
> What I did was use filefrag to sort out the most fragmented files, and
> ran "btrfs fi defrag" on them one by one.
> The problem I had was hit while running this on a 85G big file.
> The defrag itself started fine. However during the defrag a cronjob
> running "btrfs balance start -m" on the FS every night was triggered.

This is the cause of your current problem:  not the simultaneous use of
defrag and metadata balance (though that can't help), but the fact that
you have run metadata balance at all.

Never balance metadata except to convert raid profiles.

If the 'btrfs balance start -m' command came from a distro package, then
report a bug against the package.

Balancing metadata reduces allocated metadata space, which starves the
filesystem of free metadata space and can lead to metadata ENOSPC panics
like this one.  It is especially unnecessary and bad to do unfiltered
metadata balance frequently on an active filesystem.

You should have roughly 0.5% of the disk allocated for metadata, but you
have 0.13% metadata and no unallocated space--barely above the minimum
required for btrfs to function under normal conditions, too little to
cope with large IO operations like defrag or balance individually, and
certainly not enough to run both at the same time.  An active filesystem
requires more metadata space, not less.

Data balances at regular intervals are necessary to ensure some
unallocated space is available on the disks for metadata growth, and
also to control fragmentation of free space so that files are naturally
written unfragmented.  It is only necessary to do data balance until
there is 2GB unallocated on each disk (when there's 1GB free you can
still do a data balance; when there's <1GB free, you might not be able
to balance any more and will have to start deleting files).

It's OK to balance more data block groups than necessary, especially
if you are planning to run defrag or create large files, but you will
have to compare the IO cost against the benefit for your workload to
determine if data balance beyond the minimum necessary is useful.

You didn't post 'btrfs fi usage' output, and 'btrfs fi show' rounds
its numbers, but it looks like you haven't been running data balances,
which are especially necessary as a filesystem becomes nearly full.

> This resulted in a enospc and the following in dmesg:
> [219870.293424] BTRFS info (device sdc): balance: start -m -s
> [219905.318835] BTRFS info (device sdc): relocating block group
> 25827648471040 flags metadata|raid1
> [221051.593209] BTRFS info (device sdc): found 55873 extents, stage:
> move data extents
> [221227.377205] BTRFS info (device sdc): relocating block group
> 25826574729216 flags metadata|raid1
> [222256.539637] BTRFS info (device sdc): found 59083 extents, stage:
> move data extents
> [222385.936727] BTRFS info (device sdc): relocating block group
> 25825500987392 flags metadata|raid1
> [223869.077289] BTRFS info (device sdc): found 62424 extents, stage:
> move data extents
> [223986.080323] BTRFS info (device sdc): relocating block group
> 25824427245568 flags metadata|raid1
> [229402.856561] BTRFS: error (device sdc) in btrfs_drop_snapshot:5505:
> errno=-28 No space left
> [229402.856639] BTRFS info (device sdc): forced readonly
> [229402.940405] BTRFS info (device sdc): 1 enospc errors during balance
> [229402.940408] BTRFS info (device sdc): balance: ended with status: -30
> [229411.602581] BTRFS: error (device sdc) in
> btrfs_commit_transaction:2323: errno=-117 unknown (Error while writing
> out transaction)
> [229411.602705] BTRFS warning (device sdc): Skipping commit of aborted
> transaction.
> [229411.602706] ------------[ cut here ]------------
> [229411.602707] BTRFS: Transaction aborted (error -117)
> [229411.602808] WARNING: CPU: 1 PID: 804 at
> fs/btrfs/transaction.c:1894 cleanup_transaction+0x51/0xb0 [btrfs]
> [229411.602809] Modules linked in: rpcsec_gss_krb5 xt_CHECKSUM
> xt_MASQUERADE xt_conntrack ipt_REJECT tun bonding bridge stp llc
> rfkill nf_nat_ftp nf_nat_tftp nf_conntrack_netbios_ns
> nf_conntrack_broadcast nf_conntrack_ftp nft_objref nf_conntrack_tftp
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
> ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
> iptable_security ipmi_watchdog ip_set nfnetlink ebtable_filter
> ebtables ip6table_filter ip6_tables iptable_filter nct6775 hwmon_vid
> vfat fat gpio_ich intel_powerclamp coretemp kvm_intel kvm irqbypass
> intel_cstate joydev i2c_i801 lpc_ich ipmi_ssif ipmi_si ipmi_devintf
> ipmi_msghandler i2c_ismt acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd
> grace sunrpc tcp_bbr sch_fq ip_tables crct10dif_pclmul crc32_pclmul
> ast ghash_clmulni_intel drm_vram_helper
> [229411.602846]  drm_ttm_helper ttm drm_kms_helper drm mpt3sas igb dca
> i2c_algo_bit raid_class scsi_transport_sas btrfs blake2b_generic
> libcrc32c crc32c_intel xor raid6_pq
> [229411.602857] CPU: 1 PID: 804 Comm: btrfs-transacti Kdump: loaded
> Not tainted 5.7.7-200.fc32.x86_64 #1
> [229411.602858] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./C2550D4I, BIOS P2.50 03/26/2018
> [229411.602888] RIP: 0010:cleanup_transaction+0x51/0xb0 [btrfs]
> [229411.602890] Code: 77 66 f0 49 0f ba ad 40 0a 00 00 02 72 1e 41 83
> fc fb 75 07 0f 1f 44 00 00 eb 11 44 89 e6 48 c7 c7 b8 21 46 c0 e8 86
> cc d2 c5 <0f> 0b 44 89 e1 ba 66 07 00 00 49 8d 5e 28 48 89 ef 48 c7 c6
> b0 65
> [229411.602892] RSP: 0018:ffffbc1980593df8 EFLAGS: 00010292
> [229411.602894] RAX: 0000000000000027 RBX: 00000000ffffff8b RCX:
> 0000000000000007
> [229411.602895] RDX: 00000000fffffff8 RSI: 0000000000000092 RDI:
> ffff99e2efc99cc0
> [229411.602896] RBP: ffff99e2edc61a28 R08: 0000000000000606 R09:
> 0000000000000003
> [229411.602897] R10: 0000000000000000 R11: 0000000000000001 R12:
> 00000000ffffff8b
> [229411.602899] R13: ffff99e2ecb8c000 R14: ffff99e0aa524600 R15:
> ffff99e2edc61978
> [229411.602901] FS:  0000000000000000(0000) GS:ffff99e2efc80000(0000)
> knlGS:0000000000000000
> [229411.602902] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [229411.602903] CR2: 00007f3b30434810 CR3: 000000014680a000 CR4:
> 00000000001006e0
> [229411.602905] Call Trace:
> [229411.602940]  btrfs_commit_transaction+0x298/0xa00 [btrfs]
> [229411.602948]  ? console_conditional_schedule+0x10/0x20
> [229411.602975]  transaction_kthread+0x13c/0x180 [btrfs]
> [229411.603003]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
> [229411.603006]  kthread+0x115/0x140
> [229411.603009]  ? __kthread_bind_mask+0x60/0x60
> [229411.603012]  ret_from_fork+0x35/0x40
> [229411.603015] ---[ end trace 315f78655d49169a ]---
> [229411.603046] BTRFS: error (device sdc) in cleanup_transaction:1894:
> errno=-117 unknown
> 
> 
> The defrag stopped with "Read-only file system"
> And while trying to read all files from FS trying to figure out the
> extent of the damage, also reading some  files unrelated to the defrag
> results in "Input/output error" and the following in dmesg:
> [259921.952356] verify_parent_transid: 4867 callbacks suppressed
> [259921.952360] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.952644] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.952870] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.953109] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.953374] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.953649] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.953931] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.954192] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.954487] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396
> [259921.954730] BTRFS error (device sdc): parent transid verify failed
> on 25862917062656 wanted 382549 found 382396

Since you didn't mention a reboot, I assume you tried this immediately
after the ENOSPC without umounting or rebooting.

The filesystem stopped updating the disk when the transaction aborted,
but it still has updated pages cached in kernel memory.  The pointers
in kernel memory won't match the reference values on disk, so reads from
disk will trigger a lot of consistency errors.  You can ignore these,
they are not persistent.

This issue should be resolved by umounting and mounting again.

> [259921.968711] btrfs_lookup_bio_sums: 2428 callbacks suppressed
> [259921.968715] BTRFS info (device sdc): no csum found for inode 25136
> start 144900096
> [259921.969178] BTRFS info (device sdc): no csum found for inode 25136
> start 144904192
> [259921.969767] BTRFS info (device sdc): no csum found for inode 25136
> start 144908288
> [259921.970319] BTRFS info (device sdc): no csum found for inode 25136
> start 144912384
> [259921.970852] BTRFS info (device sdc): no csum found for inode 25136
> start 144916480
> [259921.971435] BTRFS info (device sdc): no csum found for inode 25136
> start 144920576
> [259921.971977] BTRFS info (device sdc): no csum found for inode 25136
> start 144924672
> [259921.972547] BTRFS info (device sdc): no csum found for inode 25136
> start 144928768
> [259921.973075] BTRFS info (device sdc): no csum found for inode 25136
> start 144932864
> [259921.973791] BTRFS info (device sdc): no csum found for inode 25136
> start 144936960
> [259922.016937] btrfs_print_data_csum_error: 148 callbacks suppressed
> [259922.016943] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145264640 csum 0x02e757d7 expected csum 0x00000000 mirror 1
> [259922.024591] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145330176 csum 0x9a81c4f8 expected csum 0x00000000 mirror 1
> [259922.032918] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145395712 csum 0x4ef80b30 expected csum 0x00000000 mirror 1
> [259922.045045] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145461248 csum 0xb4725676 expected csum 0x00000000 mirror 1
> [259922.053042] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145526784 csum 0x4b667191 expected csum 0x00000000 mirror 1
> [259922.061969] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145592320 csum 0x5e867266 expected csum 0x00000000 mirror 1
> [259922.079638] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145657856 csum 0xa0240cc3 expected csum 0x00000000 mirror 1
> [259922.087980] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145723392 csum 0xef066c8e expected csum 0x00000000 mirror 1
> [259922.096107] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145788928 csum 0x78d09191 expected csum 0x00000000 mirror 1
> [259922.122687] BTRFS warning (device sdc): csum failed root 257 ino
> 25136 off 145854464 csum 0x126eceb2 expected csum 0x00000000 mirror 1
> 
> Not all files results in this.
> Now also "df -h" only reports 59G free, but no new content has been
> added to any file.

If that's 'df' before umount/remount then it's probably meaningless.
It will include temporary extents allocated but not committed in the
defrag, and also the temporary extents allocated for balance, and
possibly various other artifacts left over from the ENOSPC panic.

Try df again after umount/remount or reboot.

> "btrfs fi df" of fs after crash:
> Data, RAID0: total=3.63TiB, used=3.57TiB
> System, RAID1: total=32.00MiB, used=288.00KiB
> Metadata, RAID1: total=5.00GiB, used=3.96GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> "btrfs fi show" of fs after crash:
> Label: 'scrap'  uuid: 9e5d6cc1-ead9-484a-b77f-156220193147
>         Total devices 2 FS bytes used 3.58TiB
>         devid    1 size 1.82TiB used 1.82TiB path /dev/sdc
>         devid    2 size 1.82TiB used 1.82TiB path /dev/sdd

The filesystem currently has no unallocated space.  That can be resolved
using 'btrfs-balance-least-used' from the python-btrfs package.  If you
can't install that package, this shell loop might work as well (don't
forget to substitute your mount point):

	for x in $(seq 0 100); do
		btrfs balance start -dusage=$x,limit=1 /mount/point
	done

Note some of the balances in the above loop may fail if you don't have
some files with small extents.  You should try to get at least 10GB
unallocated space to undo the damage from metadata balances in the past.

> Anyone has any ideas of things to try, or want me to extract any more
> information before I scrap the FS and rebuild it from backup?
> 
> Best Regards,
> Peter Hjalmarsson
