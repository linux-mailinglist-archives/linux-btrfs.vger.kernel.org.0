Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ADC713768
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 May 2023 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjE1Bbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 May 2023 21:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Bbo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 May 2023 21:31:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CCFD8
        for <linux-btrfs@vger.kernel.org>; Sat, 27 May 2023 18:31:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso1627632b3a.0
        for <linux-btrfs@vger.kernel.org>; Sat, 27 May 2023 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bashdev.org; s=google; t=1685237501; x=1687829501;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jcHeO7jWysQkOG1x5Y1TSSLjjfMiNxhGrzwMQe5VGlM=;
        b=n9umVx0uqx0reUWhUmwYvQQUX8XR7PlyG+maCTOVdeu13dJKWEfi2OcDf+86MVAC+P
         k5aDCwemgnyWo6GZoQ4wf/yjbnPARM03tghDNdhnQJ5OX8kCW4PJZfJFMTCM1VfF3mlu
         UfyjabolsudRy2guxqxUq00SI+MCzFffWoltZS2z2FHGaw0dqik1x14apYu9hvlGZ1Sg
         VWWtzuI568W0FX6CDiOeinJYGmu6gVNiOiObLolIoaGJ2bBob/mh9onO7l/TejYYDBix
         mB8u8swQjsD8020DL+dQ13m/72lE77omE7Ox0vrsVcFi8XQC6gLnc4NkFgpNHI3d6jh3
         CHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685237501; x=1687829501;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcHeO7jWysQkOG1x5Y1TSSLjjfMiNxhGrzwMQe5VGlM=;
        b=ezMxjLY5UqBTdloLcEf7JgjhqQcJ/oECZKGjsiZj7Scin1eUXZN7kwzECiDkGMg5vF
         yemzAjLf19RuBT9aFVAGRtjEUl3iUWEjd2mGb8YcMYHv8OR28p35ve2+FYDgntijqjLE
         bgX7NpeHU/9fRAn6+d7fO/g1PBSqP91FtE3qiV/1FZFM5HR5KGA6W1ZJJ/5xlstK6xWA
         37mK3TSsasSjlUTWBcNlV/KaqF++qvaMjTu2cKL1VDwX5l5/lQyztuZrQe+c9PE9p3GH
         hcgWjshxkCsJg0+o/K7IqBYfg1qu8UoZlabe6w4fjC+gFOLSrlwtWxs0TSUYrIGOE6XC
         gs8A==
X-Gm-Message-State: AC+VfDzobJfl08YqVGlmSYMDlOHtF14ZoBj2O+yyerm8OAInPEW7gw17
        eq45bb90CzSmSPqkkmtMOd8clDWhikNqjWED978NbXKjYumO6NC+3u4=
X-Google-Smtp-Source: ACHHUZ7ZZnRtNx/+ihTduxHEfRD4QxoTEkDPYtFCiKLXx6Se+C8T2J7abvadmg+nZuKPc0DgWit8ivfuVAAPCYf3sBo=
X-Received: by 2002:a05:6a00:1253:b0:644:8172:3ea9 with SMTP id
 u19-20020a056a00125300b0064481723ea9mr8991692pfi.15.1685237500781; Sat, 27
 May 2023 18:31:40 -0700 (PDT)
MIME-Version: 1.0
From:   ash lee <ash@bashdev.org>
Date:   Sat, 27 May 2023 20:31:30 -0500
Message-ID: <CAMmhH1vkKS2Ot0TyJZ+sDFXhi_-YTWcBkQhSfFxrXmdEAJtK5Q@mail.gmail.com>
Subject: BTRFS kernel BUG at fs/inode.c;611!
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, during running of a BTRFS balance, i ran into this bug. It ended
up deadlocking the BTRFS balance, and i could not pause/cancel it.

I have the rest of the kernel logs as well if those would help.

2,3508,4363269431,-;kernel BUG at fs/inode.c:611!
4,3509,4363269436,-;invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
4,3510,4363269437,-;CPU: 8 PID: 275989 Comm: btrfs Tainted: P
 OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
4,3511,4363269439,-;Hardware name: ASUS System Product Name/ROG
MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
4,3512,4363269439,-;RIP: 0010:clear_inode+0x72/0x80
4,3513,4363269443,-;Code: 2d a8 40 75 2b 48 8b 93 28 01 00 00 48 8d 83
28 01 00 00 48 39 c2 75 1a 48 c7 83 98 00 00 00 60 00 00 00 5b 5d c3
cc cc cc cc <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 1f 40 00 0f 1f 44 00 00
41 54 49
4,3514,4363269444,-;RSP: 0018:ffffaa0db1f87b90 EFLAGS: 00010006
4,3515,4363269445,-;RAX: 0000000000000000 RBX: ffff999e3171a1c0 RCX:
0000000ab1f68008
4,3516,4363269446,-;RDX: 0000000000000001 RSI: 83c8a7dbcd6e3494 RDI:
0000000000000000
4,3517,4363269447,-;RBP: ffff999e3171a340 R08: 0000000000020000 R09:
0000000000020000
4,3518,4363269447,-;R10: ffff9989889c4ea0 R11: fffffa6500000000 R12:
ffffffffc0dd5380
4,3519,4363269448,-;R13: ffff999f6c1b2000 R14: ffff998a02bf5330 R15:
0000000000000001
4,3520,4363269448,-;FS:  00007f717b482d80(0000)
GS:ffff99a8ad200000(0000) knlGS:0000000000000000
4,3521,4363269449,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,3522,4363269450,-;CR2: 00007f39991d6000 CR3: 00000004f2e26002 CR4:
0000000000770ee0
4,3523,4363269450,-;PKRU: 55555554
4,3524,4363269451,-;Call Trace:
4,3525,4363269452,-; <TASK>
4,3526,4363269454,-; evict+0xcd/0x1d0
4,3527,4363269457,-; btrfs_relocate_block_group+0xb2/0x3f0 [btrfs]
4,3528,4363269484,-; btrfs_relocate_chunk+0x3b/0x120 [btrfs]
4,3529,4363269501,-; btrfs_balance+0x7a4/0xf70 [btrfs]
4,3530,4363269517,-; btrfs_ioctl+0x2276/0x2610 [btrfs]
4,3531,4363269533,-; ? __rseq_handle_notify_resume+0xa6/0x4a0
4,3532,4363269535,-; ? proc_nr_files+0x30/0x30
4,3533,4363269537,-; ? call_rcu+0x116/0x660
4,3534,4363269539,-; ? percpu_counter_add_batch+0x53/0xc0
4,3535,4363269541,-; __x64_sys_ioctl+0x8d/0xd0
4,3536,4363269542,-; do_syscall_64+0x58/0xc0
4,3537,4363269544,-; ? handle_mm_fault+0xdb/0x2d0
4,3538,4363269546,-; ? preempt_count_add+0x47/0xa0
4,3539,4363269547,-; ? up_read+0x37/0x70
4,3540,4363269548,-; ? do_user_addr_fault+0x1ef/0x690
4,3541,4363269550,-; ? fpregs_assert_state_consistent+0x22/0x50
4,3542,4363269552,-; ? exit_to_user_mode_prepare+0x40/0x1d0
4,3543,4363269553,-; entry_SYSCALL_64_after_hwframe+0x63/0xcd
4,3544,4363269555,-;RIP: 0033:0x7f717b581afb
4,3545,4363269560,-;Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04
24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00
00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25
28 00 00
4,3546,4363269561,-;RSP: 002b:00007ffeec386500 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
4,3547,4363269562,-;RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f717b581afb
4,3548,4363269562,-;RDX: 00007ffeec3865c8 RSI: 00000000c4009420 RDI:
0000000000000003
4,3549,4363269563,-;RBP: 0000000000000000 R08: 0000000000000013 R09:
0000000000000073
4,3550,4363269563,-;R10: 0000000000000000 R11: 0000000000000246 R12:
00007ffeec3865c8
4,3551,4363269564,-;R13: 00007ffeec386e3a R14: 00007ffeec386e3a R15:
0000000000000000
4,3552,4363269565,-; </TASK>
4,3553,4363269566,-;Modules linked in: snd_seq_dummy snd_seq_midi
snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth nft_chain_nat
xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter bridge stp llc
wireguard libchacha20poly1305 chacha_x86_64 poly1305_x86_64
curve25519_x86_64 libcurve25519_generic libchacha ip6_udp_tunnel
udp_tunnel cmac nvme_fabrics nf_conntrack_netlink nfnetlink_acct qrtr
overlay sunrpc ip6t_REJECT nf_reject_ipv6 xt_hl ip6_tables ip6t_rt
ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_multiport xt_comment
nft_limit xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat intel_rapl_msr
intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm
irqbypass ghash_clmulni_intel btusb btrtl btbcm btintel
snd_sof_pci_intel_tgl btmtk snd_sof_intel_hda_common bluetooth
soundwire_intel soundwire_generic_allocation soundwire_cadence
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof iwlmvm
snd_sof_utils snd_soc_hdac_hda
4,3554,4363269589,c; snd_hda_ext_core snd_soc_acpi_intel_match
nvidia_drm(POE) snd_soc_acpi aesni_intel mac80211 jitterentropy_rng
nvidia_modeset(POE) crypto_simd zfs(POE) cryptd snd_hda_codec_hdmi
snd_soc_core libarc4 snd_compress zunicode(POE) soundwire_bus
sha512_ssse3 sha512_generic zzstd(OE) snd_hda_intel iwlwifi
snd_intel_dspcfg snd_usb_audio snd_intel_sdw_acpi uvcvideo
snd_hda_codec eeepc_wmi rapl zlua(OE) asus_wmi videobuf2_vmalloc
platform_profile snd_usbmidi_lib videobuf2_memops ctr intel_cstate
mei_hdcp snd_hda_core iTCO_wdt videobuf2_v4l2 snd_rawmidi battery
zavl(POE) pmt_telemetry drbg intel_pmc_bxt sparse_keymap pmt_class
icp(POE) videobuf2_common snd_hwdep snd_seq_device iTCO_vendor_support
intel_uncore nvidia(POE) ledtrig_audio ansi_cprng cfg80211 wmi_bmof
snd_pcm ecdh_generic cdc_acm watchdog videodev pcspkr snd_timer ecc
mei_me crc16 mc snd mei zcommon(POE) ucsi_acpi rfkill soundcore
znvpair(POE) typec_ucsi intel_vsec roles joydev spl(OE) typec
intel_pmc_core acpi_tad acpi_pad
4,3555,4363269615,c; sg evdev squashfs nf_tables crc32c_generic
nfnetlink nct6775 nct6775_core hwmon_vid coretemp tun parport_pc ppdev
lp parport loop efi_pstore configfs efivarfs ip_tables x_tables
autofs4 nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache netfs
nls_ascii nls_cp437 vfat fat dm_mod hid_microsoft ff_memless
binfmt_misc fuse btrfs xor raid6_pq zstd_compress libcrc32c
hid_generic usbhid hid sd_mod nouveau mxm_wmi i2c_algo_bit
drm_display_helper cec nvme rc_core drm_ttm_helper nvme_core ahci ttm
libahci xhci_pci drm_kms_helper t10_pi video xhci_hcd libata atlantic
crc32_pclmul crc64_rocksoft crc32c_intel drm thunderbolt usbcore
macsec crc64 scsi_mod intel_lpss_pci crc_t10dif i2c_i801 ptp
intel_lpss crct10dif_generic i2c_smbus crct10dif_pclmul pps_core
idma64 usb_common scsi_common crct10dif_common vmd fan wmi
pinctrl_alderlake button
4,3556,4363269641,-;---[ end trace 0000000000000000 ]---
4,3557,4363406724,-;RIP: 0010:clear_inode+0x72/0x80
4,3558,4363406727,-;Code: 2d a8 40 75 2b 48 8b 93 28 01 00 00 48 8d 83
28 01 00 00 48 39 c2 75 1a 48 c7 83 98 00 00 00 60 00 00 00 5b 5d c3
cc cc cc cc <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 1f 40 00 0f 1f 44 00 00
41 54 49
4,3559,4363406728,-;RSP: 0018:ffffaa0db1f87b90 EFLAGS: 00010006
4,3560,4363406729,-;RAX: 0000000000000000 RBX: ffff999e3171a1c0 RCX:
0000000ab1f68008
4,3561,4363406729,-;RDX: 0000000000000001 RSI: 83c8a7dbcd6e3494 RDI:
0000000000000000
4,3562,4363406730,-;RBP: ffff999e3171a340 R08: 0000000000020000 R09:
0000000000020000
4,3563,4363406731,-;R10: ffff9989889c4ea0 R11: fffffa6500000000 R12:
ffffffffc0dd5380
4,3564,4363406731,-;R13: ffff999f6c1b2000 R14: ffff998a02bf5330 R15:
0000000000000001
4,3565,4363406732,-;FS:  00007f717b482d80(0000)
GS:ffff99a8ad200000(0000) knlGS:0000000000000000
4,3566,4363406733,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,3567,4363406733,-;CR2: 00007f39991d6000 CR3: 00000004f2e26002 CR4:
0000000000770ee0
4,3568,4363406734,-;PKRU: 55555554
6,3569,4363406735,-;note: btrfs[275989] exited with irqs disabled
6,3570,4363406759,-;note: btrfs[275989] exited with preempt_count 1
6,3587,4673101354,-;iotop[351029]: segfault at 2cbfd43298 ip
0000000000500755 sp 00007ffce3581e50 error 4 in
python3.11[41f000+2b3000] likely on CPU 10 (core 20, socket 0)
6,3588,4673101367,-;Code: 46 10 48 89 70 18 48 89 72 10 5b c3 8b 5e 20
48 8b 56 10 48 8b 46 18 48 6b db 30 48 03 1d bb 3e 5c 00 48 89 42 18
48 89 50 10 <48> 8b 43 18 48 89 46 10 48 89 73 18 8b 73 10 48 8b 14 f5
20 46 ac
6,3591,4708011011,-;traps: iotop[354859] general protection fault
ip:42b1bf sp:7fff207cf020 error:0 in python3.11[41f000+2b3000]
6,3610,5061930113,-;iotop[359003]: segfault at 8e8 ip 00000000000008e8
sp 00007fff29df99d8 error 14 in python3.11[400000+1f000] likely on CPU
10 (core 20, socket 0)
6,3611,5061930122,-;Code: Unable to access opcode bytes at 0x8be.
4,3625,5313827230,-;------------[ cut here ]------------
4,3626,5313827233,-;WARNING: CPU: 21 PID: 392166 at
fs/btrfs/backref.c:1560 btrfs_is_data_extent_shared+0x2f6/0x3e0
[btrfs]
4,3627,5313827281,-;Modules linked in: snd_seq_dummy snd_seq_midi
snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth nft_chain_nat
xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter bridge stp llc
wireguard libchacha20poly1305 chacha_x86_64 poly1305_x86_64
curve25519_x86_64 libcurve25519_generic libchacha ip6_udp_tunnel
udp_tunnel cmac nvme_fabrics nf_conntrack_netlink nfnetlink_acct qrtr
overlay sunrpc ip6t_REJECT nf_reject_ipv6 xt_hl ip6_tables ip6t_rt
ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_multiport xt_comment
nft_limit xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nft_compat intel_rapl_msr
intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm
irqbypass ghash_clmulni_intel btusb btrtl btbcm btintel
snd_sof_pci_intel_tgl btmtk snd_sof_intel_hda_common bluetooth
soundwire_intel soundwire_generic_allocation soundwire_cadence
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof iwlmvm
snd_sof_utils snd_soc_hdac_hda
4,3628,5313827311,c; snd_hda_ext_core snd_soc_acpi_intel_match
nvidia_drm(POE) snd_soc_acpi aesni_intel mac80211 jitterentropy_rng
nvidia_modeset(POE) crypto_simd zfs(POE) cryptd snd_hda_codec_hdmi
snd_soc_core libarc4 snd_compress zunicode(POE) soundwire_bus
sha512_ssse3 sha512_generic zzstd(OE) snd_hda_intel iwlwifi
snd_intel_dspcfg snd_usb_audio snd_intel_sdw_acpi uvcvideo
snd_hda_codec eeepc_wmi rapl zlua(OE) asus_wmi videobuf2_vmalloc
platform_profile snd_usbmidi_lib videobuf2_memops ctr intel_cstate
mei_hdcp snd_hda_core iTCO_wdt videobuf2_v4l2 snd_rawmidi battery
zavl(POE) pmt_telemetry drbg intel_pmc_bxt sparse_keymap pmt_class
icp(POE) videobuf2_common snd_hwdep snd_seq_device iTCO_vendor_support
intel_uncore nvidia(POE) ledtrig_audio ansi_cprng cfg80211 wmi_bmof
snd_pcm ecdh_generic cdc_acm watchdog videodev pcspkr snd_timer ecc
mei_me crc16 mc snd mei zcommon(POE) ucsi_acpi rfkill soundcore
znvpair(POE) typec_ucsi intel_vsec roles joydev spl(OE) typec
intel_pmc_core acpi_tad acpi_pad
4,3629,5313827344,c; sg evdev squashfs nf_tables crc32c_generic
nfnetlink nct6775 nct6775_core hwmon_vid coretemp tun parport_pc ppdev
lp parport loop efi_pstore configfs efivarfs ip_tables x_tables
autofs4 nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver fscache netfs
nls_ascii nls_cp437 vfat fat dm_mod hid_microsoft ff_memless
binfmt_misc fuse btrfs xor raid6_pq zstd_compress libcrc32c
hid_generic usbhid hid sd_mod nouveau mxm_wmi i2c_algo_bit
drm_display_helper cec nvme rc_core drm_ttm_helper nvme_core ahci ttm
libahci xhci_pci drm_kms_helper t10_pi video xhci_hcd libata atlantic
crc32_pclmul crc64_rocksoft crc32c_intel drm thunderbolt usbcore
macsec crc64 scsi_mod intel_lpss_pci crc_t10dif i2c_i801 ptp
intel_lpss crct10dif_generic i2c_smbus crct10dif_pclmul pps_core
idma64 usb_common scsi_common crct10dif_common vmd fan wmi
pinctrl_alderlake button
4,3630,5313827381,-;CPU: 21 PID: 392166 Comm: mandb Tainted: P      D
  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
4,3631,5313827383,-;Hardware name: ASUS System Product Name/ROG
MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
4,3632,5313827384,-;RIP: 0010:btrfs_is_data_extent_shared+0x2f6/0x3e0 [btrfs]
4,3633,5313827416,-;Code: ff 48 39 88 08 01 00 00 72 19 49 83 7d 00 01
0f 86 8d fe ff ff 41 c6 84 24 c0 00 00 00 00 e9 7f fe ff ff 31 d2 e9
2f ff ff ff <0f> 0b eb ad 48 8b 7d 80 48 81 c7 b8 03 00 00 e8 06 41 d8
db 8b 95
4,3634,5313827417,-;RSP: 0018:ffffaa0db86b7b90 EFLAGS: 00010202
4,3635,5313827419,-;RAX: ffff998bdac20e80 RBX: 00002106a9914000 RCX:
0000000002124015
4,3636,5313827420,-;RDX: ffff99903fc2a1a8 RSI: ffffaa0db86b7bb8 RDI:
ffff99903fc2a1a0
4,3637,5313827421,-;RBP: ffffaa0db86b7c30 R08: ffff99903fc2a1a8 R09:
ffff998bdac20e00
4,3638,5313827422,-;R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9997b244d800
4,3639,5313827423,-;R13: ffff99903fc2a1a0 R14: 0000000000000007 R15:
0000000000000008
4,3640,5313827424,-;FS:  00007f816fee2740(0000)
GS:ffff99a8ad540000(0000) knlGS:0000000000000000
4,3641,5313827425,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,3642,5313827426,-;CR2: 0000555d2a42e018 CR3: 00000016c20d8002 CR4:
0000000000770ee0
4,3643,5313827427,-;PKRU: 55555554
4,3644,5313827428,-;Call Trace:
4,3645,5313827431,-; <TASK>
4,3646,5313827433,-; ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
4,3647,5313827463,-; ? extent_fiemap+0x97b/0xad0 [btrfs]
4,3648,5313827492,-; extent_fiemap+0x97b/0xad0 [btrfs]
4,3649,5313827521,-; btrfs_fiemap+0x45/0x80 [btrfs]
4,3650,5313827548,-; do_vfs_ioctl+0x1f2/0x910
4,3651,5313827552,-; __x64_sys_ioctl+0x6e/0xd0
4,3652,5313827553,-; do_syscall_64+0x58/0xc0
4,3653,5313827556,-; ? syscall_exit_to_user_mode+0x17/0x40
4,3654,5313827558,-; ? do_syscall_64+0x67/0xc0
4,3655,5313827560,-; ? handle_mm_fault+0xdb/0x2d0
4,3656,5313827562,-; ? preempt_count_add+0x47/0xa0
4,3657,5313827565,-; ? up_read+0x37/0x70
4,3658,5313827566,-; ? do_user_addr_fault+0x1ef/0x690
4,3659,5313827569,-; ? fpregs_assert_state_consistent+0x22/0x50
4,3660,5313827571,-; ? exit_to_user_mode_prepare+0x40/0x1d0
4,3661,5313827573,-; entry_SYSCALL_64_after_hwframe+0x63/0xcd
4,3662,5313827576,-;RIP: 0033:0x7f8170002afb
4,3663,5313827583,-;Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04
24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00
00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25
28 00 00
4,3664,5313827584,-;RSP: 002b:00007ffee890d220 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
4,3665,5313827586,-;RAX: ffffffffffffffda RBX: 0000000000000005 RCX:
00007f8170002afb
4,3666,5313827586,-;RDX: 00007ffee890d360 RSI: 00000000c020660b RDI:
0000000000000006
4,3667,5313827587,-;RBP: 00007ffee890d320 R08: 0000000000000001 R09:
0000555d29ebd870
4,3668,5313827588,-;R10: 0000000000000000 R11: 0000000000000246 R12:
0000555d2a32ef60
4,3669,5313827589,-;R13: 00007ffee890d308 R14: 00007ffee890d310 R15:
0000000000000006
4,3670,5313827592,-; </TASK>
4,3671,5313827592,-;---[ end trace 0000000000000000 ]---
