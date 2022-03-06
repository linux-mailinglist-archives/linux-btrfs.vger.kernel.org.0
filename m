Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D084CE87D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 04:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiCFDZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 22:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiCFDZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 22:25:22 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74DD24F27
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 19:24:29 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dbc48104beso130546927b3.5
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Mar 2022 19:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oNFv28vwUfzQyNtvMMtO+uqekiwJlyNmWaMqdA/KmeQ=;
        b=gL1qYcdQQ/8AitiDTfW4UcbYQmWckaHd4rOC/hHTMN0LK432H4WOQgXFZkVji23oId
         SUTviiFiiNFY3MCo5KVWQAfQfX3ZLDVSwNJNUdTpz2SoayIVK8Pn6EyClW1jABLjydG8
         A+g+GKGBVfL7hntuFY8Rmf2iod8ilV74zmxotRrAebrux3ivRNpB0pVbHHCG/MmhFfg5
         KyyRv5De1uCVMODLardJ2IiIkBkJXrvwQ4g8oxiLdyG6EfPwastP+r8PAcl982/XfWzq
         VATgnGOBRlXMR3zyN5K08rKtx0gMXaks49MaZM+so5ZR3BpyXloGVvL9rfe/fU4x3zm7
         BVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oNFv28vwUfzQyNtvMMtO+uqekiwJlyNmWaMqdA/KmeQ=;
        b=VeCng9ILPjBx50ZXYPWmt53QXnDH0/78c4M3ebS2/EZnR2sJWLK9GkmUEK4odNviUx
         7QmcONUD09G2zO6ney3XO+nyOh4XMRQwcwGw9gG1WJIUH/4aD/VbYUZLxNIbF81yiOi4
         qSAJVn1gmXfj3O9/EDKeFBJtqEMhMzHZDbpqhlDeacfdgHPHz46pwH3bLox4keLEWU29
         TXao6NG2L4qX/0N2O6CweUujyMeZ59obWCHSrz2hbd9RIuubNZyi2qWacn47BKeZVZuP
         6FzUqAHAUTNAU+0fYNZeOzqRelIQRfN3GPZqmP+0O+W6iBm6F5UMNGOv6dDcL563at6r
         Di0Q==
X-Gm-Message-State: AOAM533qic49nuFp65GHeog+AFkDA9t0wkul0J+B3PZHC39Z7lNasrP5
        cdPiH+FILB/V5lfcAonK61ZwAuumIm1tWkkVcRFrYreFWT0=
X-Google-Smtp-Source: ABdhPJyP6rX8R+EmbgbJis3Db5D4lLgPnmPlnnLxQzPDAKKcQks6BFCYEdBsW6/RR7xwy/0z76bUIdbfTHF7BmVqqCs=
X-Received: by 2002:a81:110f:0:b0:2db:fe4f:fe with SMTP id 15-20020a81110f000000b002dbfe4f00femr4348714ywr.90.1646537068539;
 Sat, 05 Mar 2022 19:24:28 -0800 (PST)
MIME-Version: 1.0
From:   April Kolwey <cheapiephp@gmail.com>
Date:   Sat, 5 Mar 2022 21:24:17 -0600
Message-ID: <CAFkGwLgySb_Bs_e-Ou+58o4Y4W7QGBCRk0aqZ8kk9LqRqGiBdA@mail.gmail.com>
Subject: Error encountered when working with loop devices on zoned btrfs
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

Hi,
I have a box here running 5.17-rc4 (slightly old, I know - but I don't
think anything relevant has been touched since then) with btrfs in
zoned mode running on an HM-SMR SATA hard drive. It's mostly been
working fine, but I managed to get it to act up earlier today when I
was doing some rather strange activities. Specifically, I had the
following set up:
* FS mounted as normal, no special options, not at /
* Three 2TB sparse files (created with the "truncate" command)
present, alongside other unrelated data
* Three loop devices created, one backed by each of these files
* A 4-disk md RAID 6 array (operating in degraded mode with the 4th
disk missing) on top of these three loop devices, and the initial sync
already having completed
* The array formatted with a GPT partition table and ext4
* This ext4 FS mounted at another mount point
* A large (~700GB) file being copied from the btrfs volume to this ext4 one

This ran OK for a while, then suddenly went read-only with the
following errors appearing in dmesg:

[686057.758230] BTRFS info (device sda): reclaiming chunk
6369168064512 with 20% used 79% unusable
[686057.758254] BTRFS info (device sda): relocating block group
6369168064512 flags data
[686059.334968] ------------[ cut here ]------------
[686059.334974] WARNING: CPU: 5 PID: 454656 at
fs/btrfs/extent-tree.c:2389 btrfs_cross_ref_exist+0x9a/0xb0 [btrfs]
[686059.335006] Modules linked in: ext4 crc16 mbcache jbd2 uas
usb_storage loop vhost_net tun vhost vhost_iotlb macvtap macvlan tap
dm_zoned rpcsec_gss_krb5 auth_rpcgss nfnetlink nfsv4 cpufreq_userspace
cpufreq_powersave cpufreq_ondemand cpufreq_conservative dns_resolver
nfs lockd scsi_transport_iscsi grace fscache netfs tcm_loop
iscsi_target_mod rfkill target_core_user qrtr uio target_core_mod
sunrpc binfmt_misc nls_ascii nls_cp437 vfat fat intel_rapl_msr
intel_rapl_common edac_mce_amd snd_hda_codec_realtek kvm_amd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi kvm
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
irqbypass snd_hda_core snd_hwdep snd_pcm rapl joydev wmi_bmof
efi_pstore snd_timer sp5100_tco watchdog k10temp evdev snd ccp
soundcore rng_core sg button acpi_cpufreq nct6775 hwmon_vid parport_pc
ppdev lp parport fuse configfs ip_tables x_tables autofs4 btrfs
blake2b_generic zstd_compress efivarfs raid10 raid456
async_raid6_recov async_memcpy async_pq
[686059.335042]  async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod dm_mirror
dm_region_hash dm_log dm_mod hid_logitech_hidpp hid_logitech_dj amdgpu
hid_generic drm_ttm_helper usbhid hid ttm sd_mod gpu_sched
i2c_algo_bit drm_kms_helper crc32_pclmul crc32c_intel ahci cec rc_core
libahci xhci_pci ghash_clmulni_intel xhci_hcd libata nvme usbcore drm
scsi_mod aesni_intel nvme_core r8169 t10_pi crc_t10dif realtek
crct10dif_generic crypto_simd mdio_devres crct10dif_pclmul gpio_amdpt
cryptd libphy i2c_piix4 usb_common scsi_common crct10dif_common wmi
gpio_generic
[686059.335071] CPU: 5 PID: 454656 Comm: kworker/u64:27 Tainted: G
   W         5.17.0-rc4-amd64 #1  Debian 5.17~rc4-1~exp1
[686059.335074] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./B450M Pro4, BIOS P3.50 07/18/2019
[686059.335076] Workqueue: writeback wb_workfn (flush-btrfs-5)
[686059.335080] RIP: 0010:btrfs_cross_ref_exist+0x9a/0xb0 [btrfs]
[686059.335104] Code: 89 44 24 04 e8 87 21 ff ff 48 83 bb f7 01 00 00
f7 8b 44 24 04 75 04 85 c0 7f 0f 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e
41 5f c3 <0f> 0b eb ed b8 f4 ff ff ff eb e6 66 66 2e 0f 1f 84 00 00 00
00 00
[686059.335105] RSP: 0018:ffffadd943ba77c8 EFLAGS: 00010202
[686059.335107] RAX: 0000000000000001 RBX: ffff979c83be3000 RCX:
000001a42bf1a005
[686059.335108] RDX: 000001a42bf18005 RSI: 9fbeed0512c619c0 RDI:
00000000000398b0
[686059.335109] RBP: 00000000000001f2 R08: ffff979cbf494bc0 R09:
0000000000000001
[686059.335110] R10: ffff979ba29d9a10 R11: 0000000000000001 R12:
0000000008d1f000
[686059.335111] R13: 000007c51fcc3000 R14: 0000000000000000 R15:
ffff979ba29d9a10
[686059.335113] FS:  0000000000000000(0000) GS:ffff97ab5e940000(0000)
knlGS:0000000000000000
[686059.335114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[686059.335115] CR2: 0000563262f65240 CR3: 000000011156e000 CR4:
00000000003506e0
[686059.335116] Call Trace:
[686059.335120]  <TASK>
[686059.335122]  run_delalloc_nocow+0x456/0x970 [btrfs]
[686059.335149]  btrfs_run_delalloc_range+0x6f/0x650 [btrfs]
[686059.335174]  writepage_delalloc+0xc1/0x180 [btrfs]
[686059.335201]  __extent_writepage+0x139/0x350 [btrfs]
[686059.335229]  extent_write_cache_pages+0x260/0x410 [btrfs]
[686059.335256]  extent_writepages+0x7a/0x140 [btrfs]
[686059.335283]  do_writepages+0xcf/0x1c0
[686059.335287]  __writeback_single_inode+0x41/0x340
[686059.335290]  writeback_sb_inodes+0x1fc/0x480
[686059.335293]  __writeback_inodes_wb+0x4c/0xe0
[686059.335295]  wb_writeback+0x1d7/0x2c0
[686059.335298]  wb_workfn+0x2e7/0x510
[686059.335299]  ? psi_task_switch+0xbc/0x1f0
[686059.335302]  ? _raw_spin_unlock+0x16/0x30
[686059.335305]  process_one_work+0x1e5/0x3b0
[686059.335307]  worker_thread+0x50/0x3a0
[686059.335309]  ? rescuer_thread+0x390/0x390
[686059.335310]  kthread+0xe7/0x110
[686059.335312]  ? kthread_complete_and_exit+0x20/0x20
[686059.335314]  ret_from_fork+0x22/0x30
[686059.335318]  </TASK>
[686059.335318] ---[ end trace 0000000000000000 ]---
[686059.569331] ata6.00: exception Emask 0x0 SAct 0x79fe060 SErr 0x0 action 0x0
[686059.569338] ata6.00: irq_stat 0x40000008
[686059.569342] ata6.00: failed command: WRITE FPDMA QUEUED
[686059.569344] ata6.00: cmd 61/a8:c0:6b:fd:2d/00:00:7a:00:00/40 tag
24 ncq dma 688128 out
                         res 43/04:a8:6b:fd:2d/00:00:7a:00:00/00 Emask
0x400 (NCQ error) <F>
[686059.569351] ata6.00: status: { DRDY SENSE ERR }
[686059.569353] ata6.00: error: { ABRT }
[686059.611703] ata6.00: configured for UDMA/133
[686059.611800] sd 5:0:0:0: [sda] tag#24 FAILED Result:
hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[686059.611805] sd 5:0:0:0: [sda] tag#24 Sense Key : Illegal Request [current]
[686059.611809] sd 5:0:0:0: [sda] tag#24 Add. Sense: Unaligned write command
[686059.611813] sd 5:0:0:0: [sda] tag#24 CDB: Write(16) 8a 00 00 00 00
00 7a 2d fd 6b 00 00 00 a8 00 00
[686059.611815] I/O error, dev sda, sector 16398674776 op 0x1:(WRITE)
flags 0x104000 phys_seg 168 prio class 0
[686059.611827] ata6: EH complete
[686059.649320] ata6.00: exception Emask 0x0 SAct 0x400fff0e SErr 0x0 action 0x0
[686059.649326] ata6.00: irq_stat 0x40000008
[686059.649330] ata6.00: failed command: WRITE FPDMA QUEUED
[686059.649332] ata6.00: cmd 61/a8:48:50:01:40/00:00:7a:00:00/40 tag 9
ncq dma 688128 out
                         res 43/04:a8:50:01:40/00:00:7a:00:00/00 Emask
0x400 (NCQ error) <F>
[686059.649339] ata6.00: status: { DRDY SENSE ERR }
[686059.649342] ata6.00: error: { ABRT }
[686059.670132] ata6.00: configured for UDMA/133
[686059.670222] sd 5:0:0:0: [sda] tag#9 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_OK cmd_age=0s
[686059.670226] sd 5:0:0:0: [sda] tag#9 Sense Key : Illegal Request [current]
[686059.670230] sd 5:0:0:0: [sda] tag#9 Add. Sense: Unaligned write command
[686059.670233] sd 5:0:0:0: [sda] tag#9 CDB: Write(16) 8a 00 00 00 00
00 7a 40 01 50 00 00 00 a8 00 00
[686059.670235] I/O error, dev sda, sector 16408119936 op 0x1:(WRITE)
flags 0x100000 phys_seg 168 prio class 0
[686059.670241] BTRFS error (device sda): bdev /dev/sda errs: wr 1, rd
0, flush 0, corrupt 0, gen 0
[686059.670334] ata6: EH complete
[686060.577497] ata6.00: exception Emask 0x0 SAct 0x8290ff83 SErr 0x0 action 0x0
[686060.577506] ata6.00: irq_stat 0x40000008
[686060.577509] ata6.00: failed command: WRITE FPDMA QUEUED
[686060.577511] ata6.00: cmd 61/58:00:13:fe:2d/00:00:7a:00:00/40 tag 0
ncq dma 360448 out
                         res 43/04:58:13:fe:2d/00:00:7a:00:00/00 Emask
0x400 (NCQ error) <F>
[686060.577519] ata6.00: status: { DRDY SENSE ERR }
[686060.577521] ata6.00: error: { ABRT }
[686060.597107] ata6.00: configured for UDMA/133
[686060.597189] sd 5:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_OK cmd_age=0s
[686060.597194] sd 5:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
[686060.597197] sd 5:0:0:0: [sda] tag#0 Add. Sense: Unaligned write command
[686060.597200] sd 5:0:0:0: [sda] tag#0 CDB: Write(16) 8a 00 00 00 00
00 7a 2d fe 13 00 00 00 58 00 00
[686060.597202] I/O error, dev sda, sector 16398676120 op 0x1:(WRITE)
flags 0x100000 phys_seg 88 prio class 0
[686060.597209] BTRFS error (device sda): bdev /dev/sda errs: wr 2, rd
0, flush 0, corrupt 0, gen 0
[686060.597350] ata6: EH complete
[686062.841388] ata6.00: exception Emask 0x0 SAct 0x7000063f SErr 0x0 action 0x0
[686062.841396] ata6.00: irq_stat 0x40000008
[686062.841400] ata6.00: failed command: WRITE FPDMA QUEUED
[686062.841402] ata6.00: cmd 61/a8:50:6b:fe:2d/00:00:7a:00:00/40 tag
10 ncq dma 688128 out
                         res 43/04:a8:6b:fe:2d/00:00:7a:00:00/00 Emask
0x400 (NCQ error) <F>
[686062.841410] ata6.00: status: { DRDY SENSE ERR }
[686062.841412] ata6.00: error: { ABRT }
[686062.860636] ata6.00: configured for UDMA/133
[686062.860717] sd 5:0:0:0: [sda] tag#10 FAILED Result:
hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
[686062.860722] sd 5:0:0:0: [sda] tag#10 Sense Key : Illegal Request [current]
[686062.860725] sd 5:0:0:0: [sda] tag#10 Add. Sense: Unaligned write command
[686062.860729] sd 5:0:0:0: [sda] tag#10 CDB: Write(16) 8a 00 00 00 00
00 7a 2d fe 6b 00 00 00 a8 00 00
[686062.860731] I/O error, dev sda, sector 16398676824 op 0x1:(WRITE)
flags 0x104000 phys_seg 168 prio class 0
[686062.860744] ata6: EH complete
[686063.761358] ------------[ cut here ]------------
[686063.761363] WARNING: CPU: 8 PID: 454675 at
fs/btrfs/extent-tree.c:866 lookup_inline_extent_backref+0x661/0x6a0
[btrfs]
[686063.761400] Modules linked in: ext4 crc16 mbcache jbd2 uas
usb_storage loop vhost_net tun vhost vhost_iotlb macvtap macvlan tap
dm_zoned rpcsec_gss_krb5 auth_rpcgss nfnetlink nfsv4 cpufreq_userspace
cpufreq_powersave cpufreq_ondemand cpufreq_conservative dns_resolver
nfs lockd scsi_transport_iscsi grace fscache netfs tcm_loop
iscsi_target_mod rfkill target_core_user qrtr uio target_core_mod
sunrpc binfmt_misc nls_ascii nls_cp437 vfat fat intel_rapl_msr
intel_rapl_common edac_mce_amd snd_hda_codec_realtek kvm_amd
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi kvm
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
irqbypass snd_hda_core snd_hwdep snd_pcm rapl joydev wmi_bmof
efi_pstore snd_timer sp5100_tco watchdog k10temp evdev snd ccp
soundcore rng_core sg button acpi_cpufreq nct6775 hwmon_vid parport_pc
ppdev lp parport fuse configfs ip_tables x_tables autofs4 btrfs
blake2b_generic zstd_compress efivarfs raid10 raid456
async_raid6_recov async_memcpy async_pq
[686063.761443]  async_xor async_tx xor raid6_pq libcrc32c
crc32c_generic raid1 raid0 multipath linear md_mod dm_mirror
dm_region_hash dm_log dm_mod hid_logitech_hidpp hid_logitech_dj amdgpu
hid_generic drm_ttm_helper usbhid hid ttm sd_mod gpu_sched
i2c_algo_bit drm_kms_helper crc32_pclmul crc32c_intel ahci cec rc_core
libahci xhci_pci ghash_clmulni_intel xhci_hcd libata nvme usbcore drm
scsi_mod aesni_intel nvme_core r8169 t10_pi crc_t10dif realtek
crct10dif_generic crypto_simd mdio_devres crct10dif_pclmul gpio_amdpt
cryptd libphy i2c_piix4 usb_common scsi_common crct10dif_common wmi
gpio_generic
[686063.761477] CPU: 8 PID: 454675 Comm: kworker/u64:29 Tainted: G
   W         5.17.0-rc4-amd64 #1  Debian 5.17~rc4-1~exp1
[686063.761481] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./B450M Pro4, BIOS P3.50 07/18/2019
[686063.761483] Workqueue: loop1 loop_rootcg_workfn [loop]
[686063.761488] RIP: 0010:lookup_inline_extent_backref+0x661/0x6a0 [btrfs]
[686063.761518] Code: e9 67 fe ff ff 48 83 c1 01 48 83 f9 08 0f 85 fe
fd ff ff e9 5f fe ff ff 49 89 ee 4c 8b 7c 24 10 4c 89 ed 31 db e9 3d
fc ff ff <0f> 0b b8 fb ff ff ff e9 21 fb ff ff 80 7c 24 5f bf 0f 87 36
fe ff
[686063.761520] RSP: 0018:ffffadd943e47978 EFLAGS: 00010202
[686063.761523] RAX: 0000000000000001 RBX: 0000000000000000 RCX:
0000000000000100
[686063.761524] RDX: 0000000000000000 RSI: 0000000000000113 RDI:
0000000000000000
[686063.761526] RBP: ffff979ca0f31b60 R08: 0000000000000000 R09:
0000000000000001
[686063.761527] R10: 0001392a1d26ade0 R11: 0000000000000000 R12:
000007c51fcc3000
[686063.761528] R13: ffff979ca0f31b60 R14: ffff979b88c9c618 R15:
ffff979cbf781000
[686063.761530] FS:  0000000000000000(0000) GS:ffff97ab5ea00000(0000)
knlGS:0000000000000000
[686063.761532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[686063.761533] CR2: 00007f6a20165738 CR3: 00000004d9810000 CR4:
00000000003506e0
[686063.761535] Call Trace:
[686063.761538]  <TASK>
[686063.761541]  insert_inline_extent_backref+0x5b/0xf0 [btrfs]
[686063.761572]  __btrfs_inc_extent_ref.isra.0+0x7e/0x250 [btrfs]
[686063.761602]  ? __btrfs_run_delayed_refs+0x62c/0x1120 [btrfs]
[686063.761632]  __btrfs_run_delayed_refs+0x7bb/0x1120 [btrfs]
[686063.761664]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
[686063.761693]  btrfs_commit_transaction+0x60/0xb30 [btrfs]
[686063.761726]  ? _raw_spin_unlock_irq+0x1d/0x2f
[686063.761729]  ? btrfs_wait_ordered_range+0x1c4/0x220 [btrfs]
[686063.761765]  btrfs_sync_file+0x41f/0x4e0 [btrfs]
[686063.761799]  loop_process_work+0x374/0x8d0 [loop]
[686063.761803]  ? psi_task_change+0x46/0x120
[686063.761807]  ? ttwu_do_wakeup+0x17/0x160
[686063.761810]  ? _raw_spin_unlock_irqrestore+0x25/0x40
[686063.761812]  ? try_to_wake_up+0x94/0x5a0
[686063.761815]  process_one_work+0x1e5/0x3b0
[686063.761818]  ? rescuer_thread+0x390/0x390
[686063.761819]  worker_thread+0x50/0x3a0
[686063.761821]  ? rescuer_thread+0x390/0x390
[686063.761823]  kthread+0xe7/0x110
[686063.761825]  ? kthread_complete_and_exit+0x20/0x20
[686063.761828]  ret_from_fork+0x22/0x30
[686063.761833]  </TASK>
[686063.761834] ---[ end trace 0000000000000000 ]---
[686063.761836] BTRFS: error (device sda) in
btrfs_run_delayed_refs:2159: errno=-5 IO failure
[686063.761839] BTRFS info (device sda): forced readonly

This continued on for quite some time with the loop devices, md, and
ext4 all complaining of write errors due to btrfs having gone
read-only. I don't believe this is a hardware error as after stopping
the array and remounting the zoned drive rw again, I was able to
continue normal use. However, if this is suspected then I am willing
to run a full test on this drive if needed.

--April
