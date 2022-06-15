Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC98F54D2E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiFOUtd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFOUtc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 16:49:32 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472654FA0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 13:49:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y19so25540676ejq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OS+TuHIIEmhhn+FJo6qNSFyLVwLCzFNvOeov1B2sZIQ=;
        b=qZ1bIGfgoQXOGZkn3BBAVv+xf2ik9fu31nj8ATe3IOZ1gaRjr35jDLbMM1MGBC/xVt
         KfVFgTDwh6oy76ZHZFaK97f+YpfSLzCasJoJZowFKxWyHZ7KgixLRIUHHsR2sU1BR9pp
         iJY5S0WYZGthcaiLE3dARrPLtrnJhnqvGeZLiqAt16xBuuYetMSksj5+MzHjTDotmzfW
         m7XZ2KVSDsBAGW7dGuSDmgi+yAFga2hkzAtUpKWWOYCSAnFvBrPafni8uG/q3ZDEkILl
         EBCSX2Kf+13UnovKIxuigcfYYIwYEI5a9/p57ZpFtwRZK6w2Onxuvz9O4uJwFpQ0RMyq
         3/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OS+TuHIIEmhhn+FJo6qNSFyLVwLCzFNvOeov1B2sZIQ=;
        b=HPTJZXaZV01NS+O6gUOIf1FRbP6xDBYGCLF5r/8JPne94TwJalXSDI5C3QydXT0610
         XTFaStGkbq/F1biyvmnr9fOkUz+Q2nzpvqBbYFrt2v+hx0j8ydJmU6j90tWQnad0wiod
         CCci3gR8MNFHTf/DFN5NExp5WgHNPVd0QC+2bSO2OO9JVu32s4DoJvf+5RQnNh3x/1cF
         F05DLMw/NRz+Fgrq2y6Zl8rBmvvly/W7OXOumVjFTXGPt+1R+GrWpP0SUWMOMi1fc9Vd
         NjQnPD3zRdLsQAp+PGoTNfxhvYsOQ64tmw6WQNVUwqQ5rwZUGqt/SiJcoJK4ElkSHEks
         gnMw==
X-Gm-Message-State: AJIora8+Fps38pxgj0YdA8oTpBJmUMh/SpGjqANOS1Isx2jsozQ4+PN4
        MsWyPBW43Vzjpw/JzrNyL9AOqfrvAbQc4XMhYPldY3duExO8lWyB
X-Google-Smtp-Source: AGRyM1tYTrcDPE9P9LKfP+YiHR8ZHkkwrHAY0xkuiwLnveI0Wvp0tqXGC7Wmn8EJuUjWCHNZsKXcApnUCbwZ6SaMaFM=
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id
 s5-20020a17090699c500b006df82154ccdmr1538819ejn.684.1655326168909; Wed, 15
 Jun 2022 13:49:28 -0700 (PDT)
MIME-Version: 1.0
From:   eyzrcd dcrzye <eyzrcd@gmail.com>
Date:   Wed, 15 Jun 2022 14:49:17 -0600
Message-ID: <CAPqeY=rKFBhC7aB8KZW1m=deVqpPQyBhZ3m+FF080W9zzW3i0w@mail.gmail.com>
Subject: Failed balance leads to R/O disk and un-cancelable balance
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mailing List:

Yesterday, I tried to balance metadata from "single" to "DUP" on my
laptop with a single SSD.  Laptop OS was Manjaro, and fully up to date
as of yesterday morning, on kernel 5.18.1.

Due to my misreading of the info BTRFS provided me, I thought I had
enough space available to complete the balance.  However, I did not,
and the balance stopped with an "out of space" message, and the
filesystem was kicked into read-only.  I was unable to do anything in
regards to remounting RW or canceling the balance, so I re-booted into
an Arch LiveCD environment.

In the live environment, I tried various mounting options to enable me
to cancel the balance... fail with "error (device dm-1) in
cleanup_transaction:1975: errno=-28 No space left" and "error (device
dm-1) in reset_balance:3525: errno=-28 No space left"

mount command used: "mount -o rw,clear_cache,skip_balance,noatime
/dev/mapper/crypt /mnt"
also tried adding "nospace_cache" to the options, with no change.

Also tried "btrfs check --clear-space-cache v1 /dev/mapper/crypt"
which cleared the cache, but did not allow me to mount RW

I cannot add a device to the pool as there is "another exclusive
operation 'balance' in progress".
I cannot free up any space (delete files and/or snapshots) because the
disk is immediately forced into read-only.

Data has already been copied to another disk, in addition to my normal
backups.  However, this seems to be a bug and/or bad failure mode in
that the balance failed and hard locked the filesystem, rather than
stopping the balance on a failure or otherwise allowing it to be
cancelled.

I have already reached out on reddit (
https://www.reddit.com/r/btrfs/comments/vce30l/btrfs_balance_fail_cannot_resume_or_cancel_no/
) without resolution.  Provided for more context.

Any help is appreciated, thank you!

####################

Requested system information (this is from the Arch livecd):
uname -a
    Linux archiso 5.18.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Mon, 30 May
2022 17:53:11 +0000 x86_64 GNU/Linux

btrfs --version
    btrfs-progs v5.18

btrfs fi show /mnt
    Label: none  uuid: fcf1e06e-e432-4ea3-85dc-0fc66b368689
        Total devices 1 FS bytes used 204.99GiB
        devid    1 size 220.46GiB used 220.46GiB path /dev/mapper/crypt

btrfs fi df /mnt
    Data, single: total=215.45GiB, used=201.73GiB
    System, single: total=4.00MiB, used=48.00KiB
    Metadata, single: total=5.01GiB, used=3.26GiB
    GlobalReserve, single: total=512.00MiB, used=0.00B

Relevant portion of dmesg, full log is too large, but available on request:

[  543.850450] BTRFS info (device dm-1): flagging fs with big metadata feature
[  543.850464] BTRFS info (device dm-1): force clearing of disk cache
[  543.850471] BTRFS info (device dm-1): disk space caching is enabled
[  543.850475] BTRFS info (device dm-1): has skinny extents
[  543.993472] BTRFS info (device dm-1): enabling ssd optimizations
[  543.993751] BTRFS info (device dm-1): balance: resume skipped
[  543.993753] BTRFS info (device dm-1): checking UUID tree
[  544.091765] BTRFS warning (device dm-1): Skipping commit of aborted
transaction.
[  544.091777] ------------[ cut here ]------------
[  544.091780] BTRFS: Transaction aborted (error -28)
[  544.091820] WARNING: CPU: 7 PID: 8 at fs/btrfs/transaction.c:1982
btrfs_commit_transaction.cold+0x21b/0x2f3 [btrfs]
[  544.092038] Modules linked in: ext4 mbcache jbd2 btrfs
blake2b_generic xor raid6_pq libcrc32c crc32c_generic dm_crypt
encrypted_keys trusted asn1_encoder tee qrtr ccm algif_aead cbc
des_generic libdes ecb algif_skcipher cmac md4 algif_hash af_alg
intel_rapl_msr intel_rapl_common intel_tcc_cooling snd_hda_codec_hdmi
snd_soc_skl x86_pkg_temp_thermal snd_soc_hdac_hda intel_powerclamp
snd_ctl_led snd_hda_ext_core snd_soc_sst_ipc coretemp snd_soc_sst_dsp
snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core kvm_intel
snd_hda_codec_realtek snd_compress iwlmvm ac97_bus
snd_hda_codec_generic kvm ledtrig_audio snd_pcm_dmaengine irqbypass
btusb mac80211 crct10dif_pclmul btrtl wl(POE) libarc4
ghash_clmulni_intel uvcvideo snd_hda_intel btbcm btintel
videobuf2_vmalloc iTCO_wdt snd_intel_dspcfg videobuf2_memops
snd_intel_sdw_acpi intel_pmc_bxt btmtk hid_multitouch iwlwifi pktcdvd
videobuf2_v4l2 at24 snd_hda_codec mei_hdcp mei_pxp iTCO_vendor_support
rapl acer_wmi videobuf2_common intel_cstate iwlmei
[  544.092185]  bluetooth intel_xhci_usb_role_switch snd_hda_core
intel_uncore joydev pcspkr intel_wmi_thunderbolt mousedev
sparse_keymap snd_hwdep tpm_crb wmi_bmof roles ecdh_generic videodev
intel_lpss_pci snd_pcm cfg80211 snd_timer crc16 mc i2c_i801 tpm_tis
mei_me i2c_hid_acpi intel_lpss snd tpm_tis_core acer_wireless
i2c_smbus idma64 intel_pch_thermal soundcore mac_hid i2c_hid rfkill
tpm mei rng_core acpi_pad pkcs8_key_parser fuse bpf_preload ip_tables
x_tables overlay squashfs loop isofs dm_mod uas usb_storage usbhid
i915 nouveau serio_raw atkbd libps2 drm_buddy rtsx_pci_sdmmc mxm_wmi
r8169 crc32_pclmul drm_ttm_helper mmc_core crc32c_intel vivaldi_fmap
ttm realtek aesni_intel mdio_devres drm_dp_helper crypto_simd libphy
xhci_pci intel_gtt sr_mod cryptd rtsx_pci cdrom xhci_pci_renesas i8042
serio wmi video
[  544.092327] CPU: 7 PID: 8 Comm: kworker/u16:0 Tainted: P        W
OE     5.18.1-arch1-1 #1 aeb6a372044721fe869dfc17901d8ed9fc452f1a
[  544.092338] Hardware name: Acer Aspire E5-576G/Ironman_SK, BIOS
V1.43 05/02/2018
[  544.092342] Workqueue: events_unbound
btrfs_async_reclaim_metadata_space [btrfs]
[  544.092590] RIP: 0010:btrfs_commit_transaction.cold+0x21b/0x2f3 [btrfs]
[  544.092853] Code: e9 e6 be f4 ff 49 8b 54 24 28 49 8b 44 24 30 48
89 42 08 48 89 10 e9 0e ff ff ff 44 89 f6 48 c7 c7 d0 fc e9 c1 e8 82
d1 cb eb <0f> 0b e9 43 fe ff ff 48 8b 7b 50 44 89 f2 48 c7 c6 00 fd e9
c1 e8
[  544.092863] RSP: 0018:ffffb33d400b3d28 EFLAGS: 00010282
[  544.092873] RAX: 0000000000000000 RBX: ffff90c665a2f270 RCX: 0000000000000027
[  544.092880] RDX: ffff90c99ede16a8 RSI: 0000000000000001 RDI: ffff90c99ede16a0
[  544.092887] RBP: ffff90c665a2f2c8 R08: 0000000000000000 R09: ffffb33d400b3b38
[  544.092894] R10: 0000000000000003 R11: ffffffffaeccaa08 R12: ffff90c644637200
[  544.092900] R13: ffff90c6449a0000 R14: 00000000ffffffe4 R15: ffff90c665a2f1b8
[  544.092907] FS:  0000000000000000(0000) GS:ffff90c99edc0000(0000)
knlGS:0000000000000000
[  544.092915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  544.092923] CR2: 00007fed4c010c58 CR3: 000000018e010002 CR4: 00000000003706e0
[  544.092931] Call Trace:
[  544.092939]  <TASK>
[  544.092949]  ? start_transaction+0xc3/0x5c0 [btrfs
51c5e55142c29811cecfb2b5bc53d7ebe6efe7cc]
[  544.093197]  flush_space+0xf5/0x5b0 [btrfs
51c5e55142c29811cecfb2b5bc53d7ebe6efe7cc]
[  544.093484]  ? psi_task_switch+0xc3/0x1f0
[  544.093497]  ? __update_idle_core+0x1f/0xb0
[  544.093511]  ? __switch_to_asm+0x46/0x70
[  544.093524]  ? finish_task_switch.isra.0+0xac/0x290
[  544.093541]  btrfs_async_reclaim_metadata_space+0x1a8/0x2a0 [btrfs
51c5e55142c29811cecfb2b5bc53d7ebe6efe7cc]
[  544.093831]  process_one_work+0x1c7/0x380
[  544.093846]  worker_thread+0x51/0x380
[  544.093857]  ? rescuer_thread+0x3a0/0x3a0
[  544.093866]  kthread+0xde/0x110
[  544.093881]  ? kthread_complete_and_exit+0x20/0x20
[  544.093896]  ret_from_fork+0x22/0x30
[  544.093915]  </TASK>
[  544.093919] ---[ end trace 0000000000000000 ]---
[  544.093928] BTRFS: error (device dm-1: state A) in
cleanup_transaction:1982: errno=-28 No space left
[  544.094070] BTRFS info (device dm-1: state EA): forced readonly
[  544.094163] BTRFS warning (device dm-1: state EA):
btrfs_uuid_scan_kthread failed -5
