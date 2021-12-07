Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F146C393
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhLGT0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:26:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhLGT0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:26:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 93A681FDFE;
        Tue,  7 Dec 2021 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638904999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYc3YoLOWlhvRkMReERUCcg+gWmshaC0qxUCEdsr/Jo=;
        b=P6grSuXt7h4Phi6dUUlDnSvbR+VK8+WC6qkAbWiR+nVTTAdu4zj2cicSo+ufLgqLBMx2qs
        qa0TCaPvzxyj/8N9JhCWkZY1Tyblw37AgjbCzPtM44KFkA53haFWcO5sQ/g5Xi+KlE030z
        MmIcF9q/e5YvNjIG7Tubu0lq2TPguJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638904999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYc3YoLOWlhvRkMReERUCcg+gWmshaC0qxUCEdsr/Jo=;
        b=aUuFalEKzhW3VdJzwZoDq7Ngwog7xziLrNHVdmgqqRsg6dq+lAXUaDSyCYxjV7AfFBt0Pv
        0QpSDgr4hJm52KAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 60447A3B81;
        Tue,  7 Dec 2021 19:23:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B17EDDA799; Tue,  7 Dec 2021 20:23:04 +0100 (CET)
Date:   Tue, 7 Dec 2021 20:23:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: fix re-dirty process of tree-log nodes
Message-ID: <20211207192304.GF28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211130034021.515210-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130034021.515210-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 30, 2021 at 12:40:21PM +0900, Naohiro Aota wrote:
> There is a report of a transaction abort of -EAGAIN with the following
> script.
> 
>   #!/bin/sh
> 
>   for d in sda sdb; do
>           mkfs.btrfs -d single -m single -f /dev/\${d}
>   done
> 
>   mount /dev/sda /mnt/test
>   mount /dev/sdb /mnt/scratch
> 
>   for dir in test scratch; do
>           echo 3 >/proc/sys/vm/drop_caches
>           fio --directory=/mnt/\${dir} --name=fio.\${dir} --rw=read --size=50G --bs=64m \
>                   --numjobs=$(nproc) --time_based --ramp_time=5 --runtime=480 \
>                   --group_reporting |& tee /dev/shm/fio.\${dir}
>           echo 3 >/proc/sys/vm/drop_caches
>   done
> 
> 
>   for d in sda sdb; do
>           umount /dev/\${d}
>   done
> 
> The stack trace is shown in below.
> 
>   [ 3310.967991] BTRFS: error (device sda) in btrfs_commit_transaction:2341: errno=-11 unknown (Error while writing out transaction)
>   [ 3310.968060] BTRFS info (device sda): forced readonly
>   [ 3310.968064] BTRFS warning (device sda): Skipping commit of aborted transaction.
>   [ 3310.968065] ------------[ cut here ]------------
>   [ 3310.968066] BTRFS: Transaction aborted (error -11)
>   [ 3310.968074] WARNING: CPU: 14 PID: 1684 at fs/btrfs/transaction.c:1946 btrfs_commit_transaction.cold+0x209/0x2c8
>   [ 3310.968083] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr ns sunrpc vfat fat ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm irqbypass rapl wmi_bmof i2c_piix4 k10temp acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq fuse zram ip_tables xfs raid1 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ast i2c_algo_bit drm_vram_helper drm_kms_helper cec drm_ttm_helper ttm nvme drm ccp tg3 sp5100_tco nvme_core wmi
>   [ 3310.968131] CPU: 14 PID: 1684 Comm: fio Not tainted 5.14.10-300.fc35.x86_64 #1
>   [ 3310.968135] Hardware name: DIAWAY Tartu/Tartu, BIOS V2.01.B10 04/08/2021
>   [ 3310.968137] RIP: 0010:btrfs_commit_transaction.cold+0x209/0x2c8
>   [ 3310.968141] Code: e9 f3 b4 8d ff 49 8b 54 24 28 49 8b 44 24 30 48 89 42 08 48 89 10 e9 2d ff ff ff 44 89 f6 48 c7 c7 48 65 60 84 e8 fb 89 fe ff <0f> 0b e9 5e fe ff ff 48 8b 7d 50 44 89 f2 48 c7 c6 78 65 60 84 e8
>   [ 3310.968144] RSP: 0018:ffffb284ce393e10 EFLAGS: 00010282
>   [ 3310.968147] RAX: 0000000000000026 RBX: ffff973f147b0f60 RCX: 0000000000000027
>   [ 3310.968149] RDX: ffff974ecf098a08 RSI: 0000000000000001 RDI: ffff974ecf098a00
>   [ 3310.968150] RBP: ffff973f147b0f08 R08: 0000000000000000 R09: ffffb284ce393c48
>   [ 3310.968151] R10: ffffb284ce393c40 R11: ffffffff84f47468 R12: ffff973f101bfc00
>   [ 3310.968153] R13: ffff971f20cf2000 R14: 00000000fffffff5 R15: ffff973f147b0e58
>   [ 3310.968154] FS:  00007efe65468740(0000) GS:ffff974ecf080000(0000) knlGS:0000000000000000
>   [ 3310.968157] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 3310.968158] CR2: 000055691bcbe260 CR3: 000000105cfa4001 CR4: 0000000000770ee0
>   [ 3310.968160] PKRU: 55555554
>   [ 3310.968161] Call Trace:
>   [ 3310.968167]  ? dput+0xd4/0x300
>   [ 3310.968174]  btrfs_sync_file+0x3f1/0x490
>   [ 3310.968180]  __x64_sys_fsync+0x33/0x60
>   [ 3310.968185]  do_syscall_64+0x3b/0x90
>   [ 3310.968190]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [ 3310.968194] RIP: 0033:0x7efe6557329b
>   [ 3310.968198] Code: 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 1e f8 ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 c1 1e f8 ff 8b 44
>   [ 3310.968200] RSP: 002b:00007ffe0236ebc0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
>   [ 3310.968203] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efe6557329b
>   [ 3310.968204] RDX: 0000000000000000 RSI: 00007efe58d77010 RDI: 0000000000000006
>   [ 3310.968205] RBP: 0000000004000000 R08: 0000000000000000 R09: 00007efe58d77010
>   [ 3310.968207] R10: 0000000016cacc0c R11: 0000000000000293 R12: 00007efe5ce95980
>   [ 3310.968208] R13: 0000000000000000 R14: 00007efe6447c790 R15: 0000000c80000000
>   [ 3310.968212] ---[ end trace 1a346f4d3c0d96ba ]---
>   [ 3310.968214] BTRFS: error (device sda) in cleanup_transaction:1946: errno=-11 unknown
> 
> The abort occur because of a write hole while writing out freeing tree
> nodes of a tree-log tree. For zoned btrfs, we re-dirty a freed tree
> node to ensure btrfs can write the region and does not leave a hole on
> write on a zoned device. The current code fails to re-dirty a node
> when the tree-log tree's depth is greater or equal to 2. That leads to
> a transaction abort with -EAGAIN.
> 
> Fix the issue by properly re-dirty a node on walking up the tree.
> 
> Fixes: d3575156f662 ("btrfs: zoned: redirty released extent buffers")
> Cc: stable@vger.kernel.org # 5.12+
> Link: https://github.com/kdave/btrfs-progs/issues/415
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I see the patch in misc-next but I'm not sure if I replied to the mail,
so doing it now, thanks.
