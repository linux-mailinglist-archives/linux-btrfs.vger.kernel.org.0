Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5985EA801
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiIZOJb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiIZOIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 10:08:51 -0400
Received: from out20-109.mail.aliyun.com (out20-109.mail.aliyun.com [115.124.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B1963F4
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 05:19:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436549|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0447181-0.00567782-0.949604;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.POxvt1K_1664194779;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.POxvt1K_1664194779)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 20:19:39 +0800
Date:   Mon, 26 Sep 2022 20:19:43 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Filipe Manana <fdmanana@kernel.org>
Subject: Re: fstests btrfs/232 triggle warning of btrfs_extent_buffer_leak_debug_check
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <CAL3q7H5wth3OR9obGTh7fbdaqsR7A4LDKmp4uQqBvF+F24CgDg@mail.gmail.com>
References: <20220925141807.168A.409509F4@e16-tech.com> <CAL3q7H5wth3OR9obGTh7fbdaqsR7A4LDKmp4uQqBvF+F24CgDg@mail.gmail.com>
Message-Id: <20220926201940.B938.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Sun, Sep 25, 2022 at 8:06 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi,
> >
> > fstests btrfs/232 triggle warning of btrfs_extent_buffer_leak_debug_check
> 
> Try the fixup I reported here:
> 
> https://lore.kernel.org/linux-btrfs/20220926091440.GA1198392@falcondesktop/
> 
> And see if it still triggers the leak.
> Thanks.

With this fixup, this leak does not happen again.
test times: 3

Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/26

> 
> 
> >
> > local debug config, about 100x slow than release config
> > a) memory debug
> >         CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
> > b) lockdep debug
> >         CONFIG_PROVE_LOCKING/...
> > c) btrfs debug
> > CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
> > CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
> > CONFIG_BTRFS_DEBUG=y
> > CONFIG_BTRFS_ASSERT=y
> > CONFIG_BTRFS_FS_REF_VERIFY=y
> >
> >
> > reproduce rate:
> > 1) kernel 6.0-rc6  + btrfs misc-next: bf940dd88f48
> >         reproduce rate: 3/3
> > 2) kernel 6.0-rc6
> >         reproduce rate: 0/3
> >
> > dmesg output of btrfs/232 ( fstests results/btrfs/232.dmesg)
> >
> > [ 1483.644665] run fstests btrfs/232 at 2022-09-25 13:14:13
> > [ 1497.715047] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
> > [ 1497.722927] BTRFS info (device sdb1): using free space tree
> > [ 1497.756470] BTRFS info (device sdb1): enabling ssd optimizations
> > [ 1511.997451] BTRFS: device fsid e48675db-6559-474c-9be7-1c6d5f464897 devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (2321)
> > [ 1512.247524] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
> > [ 1512.255476] BTRFS info (device sdb2): using free space tree
> > [ 1512.284849] BTRFS info (device sdb2): enabling ssd optimizations
> > [ 1512.292742] BTRFS info (device sdb2): checking UUID tree
> > [ 1546.439962] BTRFS warning (device sdb2): qgroup rescan is already in progress
> > [ 1546.467376] BTRFS info (device sdb2): qgroup scan completed (inconsistency flag cleared)
> > [ 1668.016159] BTRFS warning (device sdb2): folio private not zero on folio 155959296
> > [ 1668.025369] BTRFS warning (device sdb2): folio private not zero on folio 155963392
> > [ 1668.033469] BTRFS warning (device sdb2): folio private not zero on folio 155967488
> > [ 1668.041706] BTRFS warning (device sdb2): folio private not zero on folio 155971584
> > [ 1668.050340] BTRFS warning (device sdb2): folio private not zero on folio 163266560
> > [ 1668.058104] BTRFS warning (device sdb2): folio private not zero on folio 163270656
> > [ 1668.065837] BTRFS warning (device sdb2): folio private not zero on folio 163274752
> > [ 1668.073589] BTRFS warning (device sdb2): folio private not zero on folio 163278848
> > [ 1668.081717] BTRFS warning (device sdb2): folio private not zero on folio 201490432
> > [ 1668.089620] BTRFS warning (device sdb2): folio private not zero on folio 201494528
> > [ 1668.097449] BTRFS warning (device sdb2): folio private not zero on folio 201498624
> > [ 1668.105492] BTRFS warning (device sdb2): folio private not zero on folio 201502720
> > [ 1668.115268] BTRFS warning (device sdb2): folio private not zero on folio 244154368
> > [ 1668.123009] BTRFS warning (device sdb2): folio private not zero on folio 244158464
> > [ 1668.130759] BTRFS warning (device sdb2): folio private not zero on folio 244162560
> > [ 1668.138681] BTRFS warning (device sdb2): folio private not zero on folio 244166656
> > [ 1668.150117] BTRFS warning (device sdb2): folio private not zero on folio 297549824
> > [ 1668.157865] BTRFS warning (device sdb2): folio private not zero on folio 297553920
> > [ 1668.165650] BTRFS warning (device sdb2): folio private not zero on folio 297558016
> > [ 1668.173481] BTRFS warning (device sdb2): folio private not zero on folio 297562112
> > [ 1668.183652] BTRFS warning (device sdb2): folio private not zero on folio 343425024
> > [ 1668.191442] BTRFS warning (device sdb2): folio private not zero on folio 343429120
> > [ 1668.199341] BTRFS warning (device sdb2): folio private not zero on folio 343433216
> > [ 1668.207243] BTRFS warning (device sdb2): folio private not zero on folio 343437312
> > [ 1668.253965] BTRFS warning (device sdb2): folio private not zero on folio 531431424
> > [ 1668.262788] BTRFS warning (device sdb2): folio private not zero on folio 531435520
> > [ 1668.271597] BTRFS warning (device sdb2): folio private not zero on folio 531439616
> > [ 1668.281297] BTRFS warning (device sdb2): folio private not zero on folio 531443712
> > [ 1668.299790] ------------[ cut here ]------------
> > [ 1668.305805] WARNING: CPU: 1 PID: 2468 at fs/btrfs/extent_io.c:69 btrfs_extent_buffer_leak_debug_check+0xc6/0x4f0 [btrfs]
> > [ 1668.317972] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill ib_core sunrpc dm_multipath amdgpu intel_rapl_msr intel_rapl_common iommu_v2 gpu_sched drm_buddy sb_edac x86_pkg_temp_thermal intel_powerclamp btrfs coretemp snd_hda_codec_realtek kvm_intel blake2b_generic iTCO_wdt snd_hda_codec_generic radeon mei_wdt dcdbas iTCO_vendor_support ledtrig_audio snd_hda_codec_hdmi xor dell_smm_hwmon kvm raid6_pq snd_hda_intel zstd_compress snd_intel_dspcfg snd_intel_sdw_acpi i2c_algo_bit snd_hda_codec irqbypass drm_display_helper rapl snd_hda_core cec intel_cstate snd_hwdep drm_ttm_helper snd_seq ttm dm_mod snd_seq_device intel_uncore drm_kms_helper snd_pcm pcspkr i2c_i801 syscopyarea sysfillrect snd_timer mei_me sysimgblt i2c_smbus snd mei lpc_ich fb_sys_fops soundcore drm fuse xfs sd_mod t10_pi sr_mod cdrom sg crct10dif_pclmul crc32_pclmul crc32c_intel bnx2x ahci libahci ghash_clmulni_intel mpt3sas libata mdio e1000e raid_class
> > [ 1668.318269]  scsi_transport_sas wmi i2c_dev ipmi_devintf ipmi_msghandler
> > [ 1668.412738] Unloaded tainted modules: pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1
> > [ 1668.420990]  acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1
> > [ 1668.517613]  pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1
> > [ 1668.635315] CPU: 1 PID: 2468 Comm: umount Not tainted 6.0.0-7.2.debug.el7.x86_64 #1
> > [ 1668.644769] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
> > [ 1668.653918] RIP: 0010:btrfs_extent_buffer_leak_debug_check+0xc6/0x4f0 [btrfs]
> > [ 1668.662959] Code: c4 30 4c 89 fe 4c 89 ef 5b 5d 41 5c 41 5d 41 5e 41 5f e9 fd 54 89 d8 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b eb 9b 48 89 ef e8 4e 71 f5 d6 e9 61 ff ff ff 48 89 ef e8 41
> > [ 1668.685345] RSP: 0018:ffff88a10f8afdc8 EFLAGS: 00010287
> > [ 1668.692414] RAX: ffff888324f3bfb0 RBX: ffff8881bfe9c000 RCX: 0000000000000000
> > [ 1668.701408] RDX: 1ffff11037fd3ca2 RSI: ffff88a10f8afdf8 RDI: ffff8881bfe9c000
> > [ 1668.710406] RBP: ffff8881bfe9e510 R08: ffffed1421f15faf R09: 0000000000000001
> > [ 1668.719452] R10: ffffffff9fb5e067 R11: fffffbfff3f6bc0c R12: ffff8881bfe9c0a0
> > [ 1668.728485] R13: ffff8881b969ea00 R14: ffff8881b969e740 R15: 0000000000000000
> > [ 1668.737490] FS:  00007fd57fe99540(0000) GS:ffff889f9ce80000(0000) knlGS:0000000000000000
> > [ 1668.747517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1668.755174] CR2: 00007ffa9a9690b2 CR3: 00000020d3ffe006 CR4: 00000000001706e0
> > [ 1668.764295] Call Trace:
> > [ 1668.768685]  <TASK>
> > [ 1668.772727]  ? kfree+0xe4/0x440
> > [ 1668.777833]  btrfs_free_fs_info+0x25b/0x370 [btrfs]
> > [ 1668.784845]  deactivate_locked_super+0x77/0xc0
> > [ 1668.791268]  cleanup_mnt+0x204/0x450
> > [ 1668.796884]  task_work_run+0xd0/0x170
> > [ 1668.802535]  exit_to_user_mode_prepare+0x21d/0x220
> > [ 1668.809382]  syscall_exit_to_user_mode+0x19/0x50
> > [ 1668.816186]  do_syscall_64+0x67/0x80
> > [ 1668.821835]  ? lockdep_hardirqs_on_prepare+0x280/0x3d0
> > [ 1668.828997]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [ 1668.836134] RIP: 0033:0x7fd57fd53a6b
> > [ 1668.841806] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 63 0a 00 f7 d8
> > [ 1668.864909] RSP: 002b:00007ffce1232458 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> > [ 1668.874760] RAX: 0000000000000000 RBX: 000055c8407c7540 RCX: 00007fd57fd53a6b
> > [ 1668.884129] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055c8407cc260
> > [ 1668.893573] RBP: 000055c8407c7310 R08: 0000000000000000 R09: 000055c8407c6010
> > [ 1668.902959] R10: 00007fd57fdfaaa0 R11: 0000000000000246 R12: 0000000000000000
> > [ 1668.912356] R13: 000055c8407cc260 R14: 000055c8407c7420 R15: 000055c8407c7310
> > [ 1668.921846]  </TASK>
> > [ 1668.926321] irq event stamp: 9286695
> > [ 1668.932193] hardirqs last  enabled at (9286709): [<ffffffff9af89752>] __up_console_sem+0x52/0x60
> > [ 1668.943349] hardirqs last disabled at (9286722): [<ffffffff9af89737>] __up_console_sem+0x37/0x60
> > [ 1668.954475] softirqs last  enabled at (9286514): [<ffffffff9d200550>] __do_softirq+0x550/0x81f
> > [ 1668.965349] softirqs last disabled at (9286475): [<ffffffff9ae0d6ae>] irq_exit_rcu+0x16e/0x1b0
> > [ 1668.976255] ---[ end trace 0000000000000000 ]---
> > [ 1668.983132] BTRFS: buffer leak start 531431424 len 16384 refs 2 bflags 561 owner 5
> > [ 1668.990438] BTRFS: buffer leak start 343425024 len 16384 refs 2 bflags 561 owner 5
> > [ 1669.001476] BTRFS: buffer leak start 297549824 len 16384 refs 2 bflags 561 owner 5
> > [ 1669.010642] BTRFS: buffer leak start 244154368 len 16384 refs 2 bflags 561 owner 5
> > [ 1669.021477] BTRFS: buffer leak start 201490432 len 16384 refs 2 bflags 561 owner 5
> > [ 1669.031453] BTRFS: buffer leak start 163266560 len 16384 refs 2 bflags 561 owner 5
> > [ 1669.041475] BTRFS: buffer leak start 155959296 len 16384 refs 2 bflags 561 owner 5
> > [ 1669.423070] BTRFS info (device sdb2): using crc32c (crc32c-intel) checksum algorithm
> > [ 1669.432903] BTRFS info (device sdb2): using free space tree
> > [ 1669.469465] BTRFS info (device sdb2): enabling ssd optimizations
> >
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2022/09/25
> >


