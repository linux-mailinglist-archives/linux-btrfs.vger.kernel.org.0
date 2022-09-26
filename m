Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79D15E9D6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 11:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiIZJXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 05:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbiIZJWi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 05:22:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B179EE17
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 02:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8904CB801BF
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 09:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F318C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664184006;
        bh=xTebss1BAtKTT7SUZtUq6J/O6dEULrx9j1nv9ZlNobo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dboyByNW5gnBpinq9Zm565pMjWMAw9aHdWTBdihLlre/NS05LnQYLTuuC/CMrYtdX
         RCybrhcXR2FwEOOCC5Hgf+6fpqNJY6dVhyLq1mLiN45DJyFCSVVXcfjYdyaexKVB/E
         Zj+I0SWCGwbODw1Bl/lB+6EhEg8c4gSbbG8Da17OudzkaGCbcr2gvTqcwgbHIAgOFd
         VdBP7O2gxIyyp0yhUGgP2DciG8V3fCapMBGGkVPSAykgnBu3W0ii6orXlETMS6tdI3
         oQcyIKHkVndiV5uJpSgpPMSE8rweBv7oTiZ7E1UCZaHlI5v1FmudPG36Wu5mreO1PV
         lGoc4dh8SjHmA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1280590722dso8453274fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 02:20:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf2R9WpyLqW8wDvAEzHkvuvaxU71JRkUoM5zUY6RJU9G3N8t4Ca4
        G19kVE8zEPEpy3p36chvgeP/HiYavo7Wh92FlXU=
X-Google-Smtp-Source: AMsMyM7maqpYFgsceKrc8xZ28QkXjAjdXejTKwAO52tsu8UBRS/dc9c6c7X9k+mMohO0KHitmUGDho+pF1QEpTKg2lQ=
X-Received: by 2002:a05:6870:63a6:b0:12b:85ee:59ff with SMTP id
 t38-20020a05687063a600b0012b85ee59ffmr12104188oap.98.1664184005324; Mon, 26
 Sep 2022 02:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220925141807.168A.409509F4@e16-tech.com>
In-Reply-To: <20220925141807.168A.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 26 Sep 2022 10:19:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5wth3OR9obGTh7fbdaqsR7A4LDKmp4uQqBvF+F24CgDg@mail.gmail.com>
Message-ID: <CAL3q7H5wth3OR9obGTh7fbdaqsR7A4LDKmp4uQqBvF+F24CgDg@mail.gmail.com>
Subject: Re: fstests btrfs/232 triggle warning of btrfs_extent_buffer_leak_debug_check
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 25, 2022 at 8:06 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> fstests btrfs/232 triggle warning of btrfs_extent_buffer_leak_debug_check

Try the fixup I reported here:

https://lore.kernel.org/linux-btrfs/20220926091440.GA1198392@falcondesktop/

And see if it still triggers the leak.
Thanks.


>
> local debug config, about 100x slow than release config
> a) memory debug
>         CONFIG_KASAN/CONFIG_DEBUG_KMEMLEAK/...
> b) lockdep debug
>         CONFIG_PROVE_LOCKING/...
> c) btrfs debug
> CONFIG_BTRFS_FS_CHECK_INTEGRITY=3Dy
> CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy
> CONFIG_BTRFS_DEBUG=3Dy
> CONFIG_BTRFS_ASSERT=3Dy
> CONFIG_BTRFS_FS_REF_VERIFY=3Dy
>
>
> reproduce rate:
> 1) kernel 6.0-rc6  + btrfs misc-next: bf940dd88f48
>         reproduce rate: 3/3
> 2) kernel 6.0-rc6
>         reproduce rate: 0/3
>
> dmesg output of btrfs/232 ( fstests results/btrfs/232.dmesg)
>
> [ 1483.644665] run fstests btrfs/232 at 2022-09-25 13:14:13
> [ 1497.715047] BTRFS info (device sdb1): using crc32c (crc32c-intel) chec=
ksum algorithm
> [ 1497.722927] BTRFS info (device sdb1): using free space tree
> [ 1497.756470] BTRFS info (device sdb1): enabling ssd optimizations
> [ 1511.997451] BTRFS: device fsid e48675db-6559-474c-9be7-1c6d5f464897 de=
vid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (2321)
> [ 1512.247524] BTRFS info (device sdb2): using crc32c (crc32c-intel) chec=
ksum algorithm
> [ 1512.255476] BTRFS info (device sdb2): using free space tree
> [ 1512.284849] BTRFS info (device sdb2): enabling ssd optimizations
> [ 1512.292742] BTRFS info (device sdb2): checking UUID tree
> [ 1546.439962] BTRFS warning (device sdb2): qgroup rescan is already in p=
rogress
> [ 1546.467376] BTRFS info (device sdb2): qgroup scan completed (inconsist=
ency flag cleared)
> [ 1668.016159] BTRFS warning (device sdb2): folio private not zero on fol=
io 155959296
> [ 1668.025369] BTRFS warning (device sdb2): folio private not zero on fol=
io 155963392
> [ 1668.033469] BTRFS warning (device sdb2): folio private not zero on fol=
io 155967488
> [ 1668.041706] BTRFS warning (device sdb2): folio private not zero on fol=
io 155971584
> [ 1668.050340] BTRFS warning (device sdb2): folio private not zero on fol=
io 163266560
> [ 1668.058104] BTRFS warning (device sdb2): folio private not zero on fol=
io 163270656
> [ 1668.065837] BTRFS warning (device sdb2): folio private not zero on fol=
io 163274752
> [ 1668.073589] BTRFS warning (device sdb2): folio private not zero on fol=
io 163278848
> [ 1668.081717] BTRFS warning (device sdb2): folio private not zero on fol=
io 201490432
> [ 1668.089620] BTRFS warning (device sdb2): folio private not zero on fol=
io 201494528
> [ 1668.097449] BTRFS warning (device sdb2): folio private not zero on fol=
io 201498624
> [ 1668.105492] BTRFS warning (device sdb2): folio private not zero on fol=
io 201502720
> [ 1668.115268] BTRFS warning (device sdb2): folio private not zero on fol=
io 244154368
> [ 1668.123009] BTRFS warning (device sdb2): folio private not zero on fol=
io 244158464
> [ 1668.130759] BTRFS warning (device sdb2): folio private not zero on fol=
io 244162560
> [ 1668.138681] BTRFS warning (device sdb2): folio private not zero on fol=
io 244166656
> [ 1668.150117] BTRFS warning (device sdb2): folio private not zero on fol=
io 297549824
> [ 1668.157865] BTRFS warning (device sdb2): folio private not zero on fol=
io 297553920
> [ 1668.165650] BTRFS warning (device sdb2): folio private not zero on fol=
io 297558016
> [ 1668.173481] BTRFS warning (device sdb2): folio private not zero on fol=
io 297562112
> [ 1668.183652] BTRFS warning (device sdb2): folio private not zero on fol=
io 343425024
> [ 1668.191442] BTRFS warning (device sdb2): folio private not zero on fol=
io 343429120
> [ 1668.199341] BTRFS warning (device sdb2): folio private not zero on fol=
io 343433216
> [ 1668.207243] BTRFS warning (device sdb2): folio private not zero on fol=
io 343437312
> [ 1668.253965] BTRFS warning (device sdb2): folio private not zero on fol=
io 531431424
> [ 1668.262788] BTRFS warning (device sdb2): folio private not zero on fol=
io 531435520
> [ 1668.271597] BTRFS warning (device sdb2): folio private not zero on fol=
io 531439616
> [ 1668.281297] BTRFS warning (device sdb2): folio private not zero on fol=
io 531443712
> [ 1668.299790] ------------[ cut here ]------------
> [ 1668.305805] WARNING: CPU: 1 PID: 2468 at fs/btrfs/extent_io.c:69 btrfs=
_extent_buffer_leak_debug_check+0xc6/0x4f0 [btrfs]
> [ 1668.317972] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_r=
esolver nfs lockd grace fscache netfs rfkill ib_core sunrpc dm_multipath am=
dgpu intel_rapl_msr intel_rapl_common iommu_v2 gpu_sched drm_buddy sb_edac =
x86_pkg_temp_thermal intel_powerclamp btrfs coretemp snd_hda_codec_realtek =
kvm_intel blake2b_generic iTCO_wdt snd_hda_codec_generic radeon mei_wdt dcd=
bas iTCO_vendor_support ledtrig_audio snd_hda_codec_hdmi xor dell_smm_hwmon=
 kvm raid6_pq snd_hda_intel zstd_compress snd_intel_dspcfg snd_intel_sdw_ac=
pi i2c_algo_bit snd_hda_codec irqbypass drm_display_helper rapl snd_hda_cor=
e cec intel_cstate snd_hwdep drm_ttm_helper snd_seq ttm dm_mod snd_seq_devi=
ce intel_uncore drm_kms_helper snd_pcm pcspkr i2c_i801 syscopyarea sysfillr=
ect snd_timer mei_me sysimgblt i2c_smbus snd mei lpc_ich fb_sys_fops soundc=
ore drm fuse xfs sd_mod t10_pi sr_mod cdrom sg crct10dif_pclmul crc32_pclmu=
l crc32c_intel bnx2x ahci libahci ghash_clmulni_intel mpt3sas libata mdio e=
1000e raid_class
> [ 1668.318269]  scsi_transport_sas wmi i2c_dev ipmi_devintf ipmi_msghandl=
er
> [ 1668.412738] Unloaded tainted modules: pcc_cpufreq():1 acpi_cpufreq():1=
 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cp=
ufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq()=
:1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_=
cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi=
_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufre=
q():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufre=
q():1 pcc_cpufreq():1
> [ 1668.420990]  acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_c=
pufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():=
1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_=
cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_c=
pufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():=
1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpu=
freq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpu=
freq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1=
 acpi_cpufreq():1
> [ 1668.517613]  pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1=
 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():=
1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1
> [ 1668.635315] CPU: 1 PID: 2468 Comm: umount Not tainted 6.0.0-7.2.debug.=
el7.x86_64 #1
> [ 1668.644769] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 =
09/11/2019
> [ 1668.653918] RIP: 0010:btrfs_extent_buffer_leak_debug_check+0xc6/0x4f0 =
[btrfs]
> [ 1668.662959] Code: c4 30 4c 89 fe 4c 89 ef 5b 5d 41 5c 41 5d 41 5e 41 5=
f e9 fd 54 89 d8 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <=
0f> 0b eb 9b 48 89 ef e8 4e 71 f5 d6 e9 61 ff ff ff 48 89 ef e8 41
> [ 1668.685345] RSP: 0018:ffff88a10f8afdc8 EFLAGS: 00010287
> [ 1668.692414] RAX: ffff888324f3bfb0 RBX: ffff8881bfe9c000 RCX: 000000000=
0000000
> [ 1668.701408] RDX: 1ffff11037fd3ca2 RSI: ffff88a10f8afdf8 RDI: ffff8881b=
fe9c000
> [ 1668.710406] RBP: ffff8881bfe9e510 R08: ffffed1421f15faf R09: 000000000=
0000001
> [ 1668.719452] R10: ffffffff9fb5e067 R11: fffffbfff3f6bc0c R12: ffff8881b=
fe9c0a0
> [ 1668.728485] R13: ffff8881b969ea00 R14: ffff8881b969e740 R15: 000000000=
0000000
> [ 1668.737490] FS:  00007fd57fe99540(0000) GS:ffff889f9ce80000(0000) knlG=
S:0000000000000000
> [ 1668.747517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1668.755174] CR2: 00007ffa9a9690b2 CR3: 00000020d3ffe006 CR4: 000000000=
01706e0
> [ 1668.764295] Call Trace:
> [ 1668.768685]  <TASK>
> [ 1668.772727]  ? kfree+0xe4/0x440
> [ 1668.777833]  btrfs_free_fs_info+0x25b/0x370 [btrfs]
> [ 1668.784845]  deactivate_locked_super+0x77/0xc0
> [ 1668.791268]  cleanup_mnt+0x204/0x450
> [ 1668.796884]  task_work_run+0xd0/0x170
> [ 1668.802535]  exit_to_user_mode_prepare+0x21d/0x220
> [ 1668.809382]  syscall_exit_to_user_mode+0x19/0x50
> [ 1668.816186]  do_syscall_64+0x67/0x80
> [ 1668.821835]  ? lockdep_hardirqs_on_prepare+0x280/0x3d0
> [ 1668.828997]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 1668.836134] RIP: 0033:0x7fd57fd53a6b
> [ 1668.841806] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3 0f 1=
e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 63 0a 00 f7 d8
> [ 1668.864909] RSP: 002b:00007ffce1232458 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a6
> [ 1668.874760] RAX: 0000000000000000 RBX: 000055c8407c7540 RCX: 00007fd57=
fd53a6b
> [ 1668.884129] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055c84=
07cc260
> [ 1668.893573] RBP: 000055c8407c7310 R08: 0000000000000000 R09: 000055c84=
07c6010
> [ 1668.902959] R10: 00007fd57fdfaaa0 R11: 0000000000000246 R12: 000000000=
0000000
> [ 1668.912356] R13: 000055c8407cc260 R14: 000055c8407c7420 R15: 000055c84=
07c7310
> [ 1668.921846]  </TASK>
> [ 1668.926321] irq event stamp: 9286695
> [ 1668.932193] hardirqs last  enabled at (9286709): [<ffffffff9af89752>] =
__up_console_sem+0x52/0x60
> [ 1668.943349] hardirqs last disabled at (9286722): [<ffffffff9af89737>] =
__up_console_sem+0x37/0x60
> [ 1668.954475] softirqs last  enabled at (9286514): [<ffffffff9d200550>] =
__do_softirq+0x550/0x81f
> [ 1668.965349] softirqs last disabled at (9286475): [<ffffffff9ae0d6ae>] =
irq_exit_rcu+0x16e/0x1b0
> [ 1668.976255] ---[ end trace 0000000000000000 ]---
> [ 1668.983132] BTRFS: buffer leak start 531431424 len 16384 refs 2 bflags=
 561 owner 5
> [ 1668.990438] BTRFS: buffer leak start 343425024 len 16384 refs 2 bflags=
 561 owner 5
> [ 1669.001476] BTRFS: buffer leak start 297549824 len 16384 refs 2 bflags=
 561 owner 5
> [ 1669.010642] BTRFS: buffer leak start 244154368 len 16384 refs 2 bflags=
 561 owner 5
> [ 1669.021477] BTRFS: buffer leak start 201490432 len 16384 refs 2 bflags=
 561 owner 5
> [ 1669.031453] BTRFS: buffer leak start 163266560 len 16384 refs 2 bflags=
 561 owner 5
> [ 1669.041475] BTRFS: buffer leak start 155959296 len 16384 refs 2 bflags=
 561 owner 5
> [ 1669.423070] BTRFS info (device sdb2): using crc32c (crc32c-intel) chec=
ksum algorithm
> [ 1669.432903] BTRFS info (device sdb2): using free space tree
> [ 1669.469465] BTRFS info (device sdb2): enabling ssd optimizations
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/25
>
