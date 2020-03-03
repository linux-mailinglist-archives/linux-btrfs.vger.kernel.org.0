Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9249917866F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 00:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgCCXgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 18:36:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:33250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbgCCXgs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 18:36:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE34BAFC1;
        Tue,  3 Mar 2020 23:36:44 +0000 (UTC)
Subject: Re: FS Remounted RO due to false-positive for OOS?
To:     "Ellis H. Wilson III" <ellisw@panasas.com>,
        BTRFS <linux-btrfs@vger.kernel.org>
References: <bd2903fd-0939-357b-e22a-ef425ac48f32@panasas.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <22b61d0f-c2be-304c-4a3b-89225ea58e4e@suse.com>
Date:   Wed, 4 Mar 2020 01:36:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bd2903fd-0939-357b-e22a-ef425ac48f32@panasas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.03.20 г. 23:32 ч., Ellis H. Wilson III wrote:
> Hi all,
> 
> I encountered the following issue and wasn't sure if it was known or not
> yet.  I'll be glad to hear it matches a fingerprint of a known or fixed
> bug as I'm admittedly running an older kernel, but my searching skills
> have failed me.
> 
> I have an mdraid array formatted with BTRFS.  6x12TB drives in raid0.
> Only about 240GB of 72TB consumed at the time of OOS.
> 
> /etc/fstab mount options:
> 
> /dev/md0        /pandata/0      btrfs   defaults,space_cache=v2,noauto  0 0
> 
> uname:
> 
> Linux 4d00fa3d419078 4.12.14-lp150.11-default #1 SMP Fri May 11 08:28:30
> UTC 2018 (a9fee09) x86_64 x86_64 x86_64 GNU/Linux
> 
> dmesg output:
> 
> [17939.536301] BTRFS: Transaction aborted (error -28)
> [17939.536331] ------------[ cut here ]------------
> [17939.542058] WARNING: CPU: 7 PID: 3372 at
> ../fs/btrfs/extent-tree.c:6988 __btrfs_free_extent.isra.64+0xb9d/0xd40
> [btrfs]
> [17939.553779] Modules linked in: binfmt_misc af_packet bonding
> iscsi_ibft iscsi_boot_sysfs msr nls_iso8859_1 nls_cp437 vfat intel_rapl
> fat skx_edac x86_pkg_temp_thermal btrfs intel_powerclamp coretemp xor
> ipmi_ssif kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> crc32c_intel raid0 iTCO_wdt iTCO_vendor_support ghash_clmulni_intel pcbc
> dax_pmem ixgbe device_dax md_mod ptp nd_pmem pps_core mdio nd_btt
> aesni_intel aes_x86_64 raid6_pq crypto_simd glue_helper cryptd i2c_i801
> lpc_ich ioatdma ipmi_si pcspkr mei_me mei nfit ipmi_devintf shpchp dca
> wmi ipmi_msghandler libnvdimm acpi_pad button joydev hid_generic usbhid
> ast i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops xhci_pci ttm xhci_hcd nvme drm ahci
> drm_panel_orientation_quirks nvme_core usbcore libahci sg dm_multipath
> dm_mod
> [17939.631713]  scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
> [17939.638341] CPU: 7 PID: 3372 Comm: btrfs-transacti Not tainted
> 4.12.14-lp150.11-default #1 openSUSE Leap 15.0 (unreleased)
> [17939.650466] Hardware name: Supermicro SYS-F629P3-RTB/X11DPFR-S, BIOS
> 3.0c_PI021_2e 11/26/2019
> [17939.660095] task: ffff88083b975680 task.stack: ffffc9000a238000
> [17939.667128] RIP: 0010:__btrfs_free_extent.isra.64+0xb9d/0xd40 [btrfs]
> [17939.674653] RSP: 0018:ffffc9000a23bc78 EFLAGS: 00010296
> [17939.680953] RAX: 0000000000000026 RBX: 0000000000000000 RCX:
> 0000000000000000
> [17939.689172] RDX: ffff88085c1dfd40 RSI: ffff88085c1d7a68 RDI:
> ffff88085c1d7a68
> [17939.697386] RBP: 00000012b9a5c000 R08: 0000000000000511 R09:
> 0000000000000007
> [17939.705602] R10: 0000000000000001 R11: 0000000000000001 R12:
> ffff8808530ae000
> [17939.713803] R13: 00000000ffffffe4 R14: ffff8802edf64870 R15:
> ffff8801368c0230
> [17939.722017] FS:  0000000000000000(0000) GS:ffff88085c1c0000(0000)
> knlGS:0000000000000000
> [17939.731203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [17939.738051] CR2: 00007f12998bea08 CR3: 000000000200a003 CR4:
> 00000000007606e0
> [17939.746292] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [17939.754525] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [17939.762735] PKRU: 55555554
> [17939.766521] Call Trace:
> [17939.770075]  __btrfs_run_delayed_refs+0x5b9/0x1300 [btrfs]
> [17939.776682]  btrfs_run_delayed_refs+0x68/0x250 [btrfs]
> [17939.782948]  btrfs_commit_transaction+0x2df/0x900 [btrfs]
> [17939.789462]  ? wait_woken+0x80/0x80
> [17939.794087]  transaction_kthread+0x186/0x1a0 [btrfs]
> [17939.800201]  ? btrfs_cleanup_transaction+0x4e0/0x4e0 [btrfs]
> [17939.806983]  kthread+0x11a/0x130
> [17939.811308]  ? kthread_create_on_node+0x40/0x40
> [17939.816939]  ret_from_fork+0x1f/0x40
> [17939.821591] Code: 00 00 48 c7 c6 c0 07 8e a0 4c 89 f7 41 bd ea ff ff
> ff e8 4d d0 09 00 e9 a0 f5 ff ff 44 89 ee 48 c7 c7 18 71 8e a0 e8 d9 95
> 96 e0 <0f> 0b e9 73 f5 ff ff 49 8b 46 60 f0 0f ba a8 30 17 00 00 02 72
> [17939.842686] ---[ end trace 179787a3004a4525 ]---
> [17939.848482] BTRFS: error (device md0) in __btrfs_free_extent:6988:
> errno=-28 No space left
> [17939.857923] BTRFS info (device md0): forced readonly
> [17939.864081] BTRFS: error (device md0) in btrfs_run_delayed_refs:3016:
> errno=-28 No space left
> [17939.873811] BTRFS warning (device md0): Skipping commit of aborted
> transaction.
> [17939.882319] BTRFS: error (device md0) in cleanup_transaction:1876:
> errno=-28 No space left
> [17940.192941] BTRFS error (device md0): pending csums is 334954496
> 

There were multiple fixes to the ENOSPC machinery. In particular:

https://patchwork.kernel.org/cover/10709795/

But this series might depend on other fixes you'd have to do the
backporting yourself.
