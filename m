Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD913F9300
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 05:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhH0Dmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 23:42:39 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:57893 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhH0Dmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 23:42:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0452731|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.030739-0.00211435-0.967147;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.LAVGGNV_1630035707;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LAVGGNV_1630035707)
          by smtp.aliyun-inc.com(10.147.42.16);
          Fri, 27 Aug 2021 11:41:48 +0800
Date:   Fri, 27 Aug 2021 11:41:54 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we don't have enough pages"
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20210825054142.11579-1-wqu@suse.com>
References: <20210825054142.11579-1-wqu@suse.com>
Message-Id: <20210827114153.19CB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

With this patch, kernel panic when xfstest btrfs/244

#btrfs version: 5.13.x (with some patches from 5.14), although shown as 5.10.61.

[  131.802619] BUG: kernel NULL pointer dereference, address:
0000000000000000
[  131.810837] #PF: supervisor read access in kernel mode
[  131.817026] #PF: error_code(0x0000) - not-present page
[  131.823240] PGD 0 P4D 0
[  131.826521] Oops: 0000 [#1] SMP NOPTI
[  131.831029] CPU: 37 PID: 4434 Comm: btrfs Not tainted 5.10.61-1.el7.x86_64 #1
[  131.839478] Hardware name: Dell Inc. PowerEdge T620/02CD1V, BIOS 2.9.0 12/06/2019
[  131.848315] RIP: 0010:btrfs_rm_device+0x248/0x4f0 [btrfs]
[  131.854805] Code: 8b 45 30 48 89 df 48 83 40 48 01 e8 92 cb 14 ea e9 e2 fe ff ff b9 08 00 00 00 48 c7 c7 f7
 9a a4 c0 4c 89 e6 41 bf 06 00 00 00 <f3> a6 0f 97 c0 1c 00 84 c0 0f 84 be fe ff ff e9 b6 fe ff ff 48 89
[  131.876730] RSP: 0018:ffff9ff54e01fd80 EFLAGS: 00010246
[  131.883000] RAX: fffffffffffffffe RBX: ffff8c0b0a8cd000 RCX: 0000000000000008
[  131.891463] RDX: fffffffffffffffe RSI: 0000000000000000 RDI: ffffffffc0a49af7
[  131.899854] RBP: fffffffffffffffe R08: ffff8c0d4872f400 R09: 0000000000001000
[  131.908262] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  131.916686] R13: 0000000000000003 R14: ffff8c0d4872f400 R15: 0000000000000006
[  131.925070] FS:  00007ffa0f6029c0(0000) GS:ffff8c1abfc80000(0000) knlGS:0000000000000000
[  131.934608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  131.941449] CR2: 0000000000000000 CR3: 0000002179c4e001 CR4: 00000000001706e0
[  131.949883] Call Trace:
[  131.953090]  ? __check_object_size+0x162/0x180
[  131.958593]  btrfs_ioctl+0x1870/0x2fd0 [btrfs]
[  131.963997]  ? do_fault+0x22e/0x490
[  131.968370]  ? __handle_mm_fault+0x5e8/0x7c0
[  131.973582]  ? __x64_sys_ioctl+0x84/0xc0
[  131.978370]  __x64_sys_ioctl+0x84/0xc0
[  131.982999]  do_syscall_64+0x33/0x40
[  131.987445]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  131.993511] RIP: 0033:0x7ffa0e16762b
[  131.997925] Code: 0f 1e fa 48 8b 05 5d b8 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00
 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d b8 2c 00 f7 d8 64 89 01 48
[  132.019844] RSP: 002b:00007ffe18adeeb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  132.028777] RAX: ffffffffffffffda RBX: 00007ffe18ae1070 RCX: 00007ffa0e16762b
[  132.037222] RDX: 00007ffe18adfee0 RSI: 000000005000943a RDI: 0000000000000003
[  132.045715] RBP: 00007ffe18adfee0 R08: 00007ffe18ae3221 R09: 0000000000000000
[  132.054134] R10: 00007ffa0e1e51e0 R11: 0000000000000246 R12: 0000000000000001
[  132.062617] R13: 0000000000000000 R14: 0000000000000003 R15: 00007ffe18ae1078
[  132.071037] Modules linked in: dm_flakey rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache rfkill iTCO_wdt int
el_pmc_bxt intel_rapl_msr iTCO_vendor_support dcdbas intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powe
rclamp coretemp ipmi_ssif kvm_intel kvm irqbypass rapl intel_cstate ipmi_si mei_me ipmi_devintf intel_uncore j
oydev ipmi_msghandler mei lpc_ich acpi_power_meter nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm rdmavt nfsd rdma
_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core auth_rpcgss nfs_acl lockd grace nfs_ssc ip_tables xfs mgag200
 drm_kms_helper btrfs cec crct10dif_pclmul crc32_pclmul crc32c_intel xor raid6_pq drm bnx2x nvme mpt3sas ghash
_clmulni_intel igb pcspkr mdio megaraid_sas nvme_core raid_class dca i2c_algo_bit scsi_transport_sas wmi dm_mu
ltipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua sunrpc i2c_dev
[  132.155588] CR2: 0000000000000000
[  132.159878] ---[ end trace 5ad61f759e33fdff ]---
[  132.169659] RIP: 0010:btrfs_rm_device+0x248/0x4f0 [btrfs]
[  132.176237] Code: 8b 45 30 48 89 df 48 83 40 48 01 e8 92 cb 14 ea e9 e2 fe ff ff b9 08 00 00 00 48 c7 c7 f7
 9a a4 c0 4c 89 e6 41 bf 06 00 00 00 <f3> a6 0f 97 c0 1c 00 84 c0 0f 84 be fe ff ff e9 b6 fe ff ff 48 89
[  132.198409] RSP: 0018:ffff9ff54e01fd80 EFLAGS: 00010246
[  132.204856] RAX: fffffffffffffffe RBX: ffff8c0b0a8cd000 RCX: 0000000000000008
[  132.213467] RDX: fffffffffffffffe RSI: 0000000000000000 RDI: ffffffffc0a49af7
[  132.222039] RBP: fffffffffffffffe R08: ffff8c0d4872f400 R09: 0000000000001000
[  132.230657] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  132.239222] R13: 0000000000000003 R14: ffff8c0d4872f400 R15: 0000000000000006
[  132.247813] FS:  00007ffa0f6029c0(0000) GS:ffff8c1abfc80000(0000) knlGS:0000000000000000
[  132.257461] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  132.264459] CR2: 0000000000000000 CR3: 0000002179c4e001 CR4: 00000000001706e0
[  132.273009] Kernel panic - not syncing: Fatal exception
[  132.447157] Kernel Offset: 0x29000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xfffff
fffbfffffff)
[  132.462761] ---[ end Kernel panic - not syncing: Fatal exception ]---

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/08/27

> This reverts commit f2165627319ffd33a6217275e5690b1ab5c45763.
> 
> [BUG]
> It's no longer possible to create compressed inline extent after commit
> f2165627319f ("btrfs: compression: don't try to compress if we don't
> have enough pages").
> 
> [CAUSE]
> For compression code, there are several possible reasons we have a range
> that needs to be compressed while it's no more than one page.
> 
> - Compressed inline write
>   The data is always smaller than one sector.
> 
> - Compressed subpage write
>   For the incoming subpage compressed write support, we require page
>   alignment of the delalloc range.
>   And for 64K page size, we can compress just one page into smaller
>   sectors.
> 
> For those reasons, the requirement for the data to be more than one page
> is not correct, and is already causing regression for compressed inline
> data writeback.
> 
> [FIX]
> Fix it by reverting the offending commit.
> 
> Fixes: f2165627319f ("btrfs: compression: don't try to compress if we don't have enough pages")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2aa9646bce56..2b7fe98adec2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -632,7 +632,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>  	 * inode has not been flagged as nocompress.  This flag can
>  	 * change at any time if we discover bad compression ratios.
>  	 */
> -	if (nr_pages > 1 && inode_need_compress(BTRFS_I(inode), start, end)) {
> +	if (inode_need_compress(BTRFS_I(inode), start, end)) {
>  		WARN_ON(pages);
>  		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>  		if (!pages) {
> -- 
> 2.32.0


