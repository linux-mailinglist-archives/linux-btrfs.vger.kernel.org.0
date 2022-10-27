Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF69060F132
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 09:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiJ0HgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiJ0HgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 03:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE219165C9A
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 00:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B552621A9
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 07:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618C2C433C1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666856162;
        bh=UeFFAxOKHSg+pbQXhD2hnA4BLnKpdRHJAQVNtxlLiSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WxcKylhPytEROKag2Y+S4B059Zr0Ffy6BzabvT/Vzu2Vin2yArPlYKnEoqdzK9YnR
         9Sql43ymqRkwiAAoBchackmMWNyPXFlrpnKBLChWe6bejX3xsvwbt5PMmqSxKRVsAP
         HzUNBVBx+zBIm3NhrDJmMpBml9U0ORwCC3DZNGbuA+KC7GcpsClcP8sDnmshB2LC3H
         FYyeV1F2rv1R1mB/26pPCNSIcIPGrJubsy1zGavwMzJdSj49zXtqvE0ozzasBASdT2
         7rxTri8gkwyhv+eTicKhx5tcLduqhmQLUDBidtHsW6qEszv7jumHlGdPEFvsMmCll7
         x68Gn7zkNUZDQ==
Received: by mail-oi1-f179.google.com with SMTP id o64so900466oib.12
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 00:36:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf35+OS+YZES9V5Pk4DYUczEUYg2bXiM7TFi82+0v0hZFpK3tP7q
        P+cmBk1vHaAHHaN0IB9/vJ7dxTg5ygn6aCTdksA=
X-Google-Smtp-Source: AMsMyM7k88Oi1CDzgq6+Li3XvzRjYXb4QTvVBx0vXz+GzgzWpvl7WV+55Hy4Ws5gj7DvDyBP0XcLQ59eauEWtAkoBgs=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr4248499oib.98.1666856161458; Thu, 27
 Oct 2022 00:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <Y1krzbq3zdYOSQYG@bulldog> <5d59652451decb86786ff2dff9e4ffe3843f143b.camel@scientia.org>
 <Y1oUCLPC8xqrm1j1@bulldog>
In-Reply-To: <Y1oUCLPC8xqrm1j1@bulldog>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 27 Oct 2022 08:35:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6yYSGRBtWa69-qM+6UjzpTXQspWtXDc=FTKtv2kSivMg@mail.gmail.com>
Message-ID: <CAL3q7H6yYSGRBtWa69-qM+6UjzpTXQspWtXDc=FTKtv2kSivMg@mail.gmail.com>
Subject: Re: Lenovo X1 - kernel 6.0.N - complete freeze btrfs or i915 related
To:     Norbert Preining <norbert@preining.info>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 6:31 AM Norbert Preining <norbert@preining.info> wrote:
>
> Hi
>
> (please cc)
>
> > https://bugs.archlinux.org/task/76266
>
> After booting an emergency system, running btrfsck with csum verification,
> and mounting with clear_cache,space_cache=v2 I still had problems with the
> kernel 6.0.3.

Your log showed only i915 problems:

Oct 26 21:03:43 burischnitzel kernel: ------------[ cut here ]------------
Oct 26 21:03:43 burischnitzel kernel: i915 0000:00:02.0: Block 42
min_size is zero
Oct 26 21:03:43 burischnitzel kernel: WARNING: CPU: 8 PID: 696 at
drivers/gpu/drm/i915/display/intel_bios.c:477
intel_bios_init+0x84b/0x1ea0 [i915]
Oct 26 21:03:43 burischnitzel kernel: Modules linked in: iwlwifi(+)
xt_addrtype mei_me(+) btintel acpi_cpufreq(-) mei intel_lpss
nft_compat btmtk cfg80211 idma64 fjes(-) i915(+) nf_tables bluetooth
nfnetlink processor_thermal_device_pci intel_ish_ipc(+) drm_buddy
br_netfilter processor_thermal_device ecdh_generic intel_ishtp
thunderbolt(+) ttm processor_thermal_rfim bridge ucsi_acpi
drm_display_helper processor_thermal_mbox typec_ucsi intel_vsec
processor_thermal_rapl typec cec intel_rapl_common stp intel_gtt
tpm_crb llc igen6_edac roles tpm_tis tpm_tis_core mac_hid
thinkpad_acpi nxp_nci_i2c nxp_nci ledtrig_audio nci platform_profile
nfc snd i2c_hid_acpi rfkill i2c_hid soundcore int3403_thermal
int340x_thermal_zone soc_button_array vfat fat ov2740 v4l2_fwnode ext4
v4l2_async videodev crc16 intel_skl_int3472_tps68470 mc mbcache
tps68470_regulator jbd2 clk_tps68470 intel_skl_int3472_discrete
intel_hid sparse_keymap int3400_thermal acpi_thermal_rel acpi_tad
acpi_pad dm_multipath sg crypto_user fuse bpf_preload
Oct 26 21:03:43 burischnitzel kernel:  ip_tables x_tables btrfs
blake2b_generic xor raid6_pq libcrc32c crc32c_generic dm_crypt dm_mod
cbc encrypted_keys trusted asn1_encoder tee tpm rng_core
crct10dif_pclmul serio_raw nvme crc32_pclmul atkbd crc32c_intel libps2
polyval_clmulni polyval_generic vivaldi_fmap gf128mul
ghash_clmulni_intel aesni_intel crypto_simd xhci_pci nvme_core cryptd
xhci_pci_renesas nvme_common wmi i8042 serio video
Oct 26 21:03:43 burischnitzel kernel: Unloaded tainted modules:
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1
pcc_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 fjes():1
pcc_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1
acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 fjes():1
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1
acpi_cpufreq():1
Oct 26 21:03:43 burischnitzel kernel: CPU: 8 PID: 696 Comm:
systemd-udevd Tainted: G     U             6.0.2-arch1-1 #1
50c0f0880a1bf780734fcafd72b58c22e0d25b99
Oct 26 21:03:43 burischnitzel kernel: Hardware name: LENOVO
21CBCTO1WW/21CBCTO1WW, BIOS N3AET67W (1.32 ) 09/27/2022
Oct 26 21:03:43 burischnitzel kernel: RIP:
0010:intel_bios_init+0x84b/0x1ea0 [i915]
Oct 26 21:03:43 burischnitzel kernel: Code: 48 8b 78 08 4c 8b 7f 50 4d
85 ff 75 03 4c 8b 3f e8 5a ae 27 e0 44 89 e9 4c 89 fa 48 c7 c7 60 3b
67 c1 48 89 c6 e8 54 33 64 e0 <0f> 0b e9 d3 fb ff ff 48 89 df 49 83 c6
10 e8 72 ed dc df 48 c7 c0
Oct 26 21:03:43 burischnitzel kernel: RSP: 0018:ffffaad181b9faa8
EFLAGS: 00010286
Oct 26 21:03:43 burischnitzel kernel: RAX: 0000000000000000 RBX:
ffffaad1822b48f3 RCX: 0000000000000027
Oct 26 21:03:43 burischnitzel kernel: RDX: ffff8e13bf621668 RSI:
0000000000000001 RDI: ffff8e13bf621660
Oct 26 21:03:43 burischnitzel kernel: RBP: 0000000000000000 R08:
0000000000000000 R09: ffffaad181b9f930
Oct 26 21:03:43 burischnitzel kernel: R10: 0000000000000003 R11:
ffff8e13df7aa8a8 R12: 0000000000000000
Oct 26 21:03:43 burischnitzel kernel: R13: 000000000000002a R14:
ffffffffc1640ad8 R15: ffff8e0c83271d70
Oct 26 21:03:43 burischnitzel kernel: FS:  00007f2028738200(0000)
GS:ffff8e13bf600000(0000) knlGS:0000000000000000
Oct 26 21:03:43 burischnitzel kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 26 21:03:43 burischnitzel kernel: CR2: 000055b114633000 CR3:
000000010568c001 CR4: 0000000000f70ee0
Oct 26 21:03:43 burischnitzel kernel: PKRU: 55555554
Oct 26 21:03:43 burischnitzel kernel: Call Trace:
Oct 26 21:03:43 burischnitzel kernel:  <TASK>
Oct 26 21:03:43 burischnitzel kernel:  ? drm_vblank_worker_init+0x6b/0x80
Oct 26 21:03:43 burischnitzel kernel:
intel_modeset_init_noirq+0x39/0x240 [i915
fab1b575434f0c70727a22e73338b88c3a20a26a]
Oct 26 21:03:43 burischnitzel kernel:  i915_driver_probe+0x476/0xd70
[i915 fab1b575434f0c70727a22e73338b88c3a20a26a]
Oct 26 21:03:43 burischnitzel kernel:  ?
intel_modeset_probe_defer+0x4f/0x60 [i915
fab1b575434f0c70727a22e73338b88c3a20a26a]
Oct 26 21:03:43 burischnitzel kernel:  ? i915_pci_probe+0x43/0x160
[i915 fab1b575434f0c70727a22e73338b88c3a20a26a]
Oct 26 21:03:43 burischnitzel kernel:  local_pci_probe+0x42/0x80
Oct 26 21:03:43 burischnitzel kernel:  pci_device_probe+0xc1/0x220
Oct 26 21:03:43 burischnitzel kernel:  ? sysfs_do_create_link_sd+0x6e/0xe0
Oct 26 21:03:43 burischnitzel kernel:  really_probe+0xdb/0x380
Oct 26 21:03:43 burischnitzel kernel:  ? pm_runtime_barrier+0x54/0x90
Oct 26 21:03:43 burischnitzel kernel:  __driver_probe_device+0x78/0x170
Oct 26 21:03:43 burischnitzel kernel:  driver_probe_device+0x1f/0x90
Oct 26 21:03:43 burischnitzel kernel:  __driver_attach+0xd5/0x1d0
Oct 26 21:03:43 burischnitzel kernel:  ? __device_attach_driver+0x110/0x110
Oct 26 21:03:43 burischnitzel kernel:  bus_for_each_dev+0x88/0xd0
Oct 26 21:03:43 burischnitzel kernel:  bus_add_driver+0x1b2/0x200
Oct 26 21:03:43 burischnitzel kernel:  driver_register+0x8d/0xe0
Oct 26 21:03:43 burischnitzel kernel:  i915_init+0x23/0x83 [i915
fab1b575434f0c70727a22e73338b88c3a20a26a]
Oct 26 21:03:43 burischnitzel kernel:  ? 0xffffffffc179e000
Oct 26 21:03:43 burischnitzel kernel:  do_one_initcall+0x5a/0x220
Oct 26 21:03:43 burischnitzel kernel:  do_init_module+0x4a/0x1e0
Oct 26 21:03:43 burischnitzel kernel:  __do_sys_init_module+0x17f/0x1b0
Oct 26 21:03:43 burischnitzel kernel:  do_syscall_64+0x5c/0x90
Oct 26 21:03:43 burischnitzel kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
Oct 26 21:03:43 burischnitzel kernel:  ? do_syscall_64+0x6b/0x90
Oct 26 21:03:43 burischnitzel kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Oct 26 21:03:43 burischnitzel kernel: RIP: 0033:0x7f20290d2eae
Oct 26 21:03:43 burischnitzel kernel: Code: 48 8b 0d dd ee 0c 00 f7 d8
64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d aa
ee 0c 00 f7 d8 64 89 01 48
Oct 26 21:03:43 burischnitzel kernel: RSP: 002b:00007ffe0dd984a8
EFLAGS: 00000246 ORIG_RAX: 00000000000000af
Oct 26 21:03:43 burischnitzel kernel: RAX: ffffffffffffffda RBX:
000055b114529930 RCX: 00007f20290d2eae
Oct 26 21:03:43 burischnitzel kernel: RDX: 000055b114468560 RSI:
00000000006a1c8e RDI: 00007f2026abf010
Oct 26 21:03:43 burischnitzel kernel: RBP: 000055b114468560 R08:
0000000000261000 R09: 85ebca77c2b2ae63
Oct 26 21:03:43 burischnitzel kernel: R10: 0000000000012901 R11:
0000000000000246 R12: 0000000000020000
Oct 26 21:03:43 burischnitzel kernel: R13: 000055b11452e0d0 R14:
000055b114529930 R15: 000055b11445d530
Oct 26 21:03:43 burischnitzel kernel:  </TASK>
Oct 26 21:03:43 burischnitzel kernel: ---[ end trace 0000000000000000 ]---

If that persists, just contact the i915 developers and maintainers:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS#n10214

>
> After compiling 6.0.5 on a different system and installing it via the
> rescue system, it *seems* now that everything is back to normal.
>
> Thanks, much appreciated
>
> Norbert
>
> --
> PREINING Norbert                              https://www.preining.info
> Mercari Inc.     +     IFMGA Guide     +     TU Wien     +     TeX Live
> GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
