Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF759161A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiHLTsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 15:48:08 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A4B3B0A
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 12:48:07 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id j2so1818123vsp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=kvDqBlVap0EmnMOEordbvVG7VKbGSQRYifrliH4gpcY=;
        b=eGYwdrw2lF9JxBPgpc9NCcZOvPn0cwLgAeT13CO3O2rBpgntENg55OizAlGRMsF+fC
         0U5Cvn5KckBVZugu/gViNzTbZEtDdquREkuKCsmadXt3BBwkb1b4ABSJ6pvGtGsyBnCi
         G0aeMZvh03Z3em2GJ26upy/vgfRq8CfrPmqckNM9UhvqHvtNBhOILmDpPQKVZUNzKaub
         +Zwd+xKJ065itpmrJqDRvTYOBUEgOGUEnUKK7MefAN1d0qyEpOKyZjjhxd41AH5XXXl3
         3UEqd9w++NOSNybwgotgo4oLerbLklbZBY8Lebh2Qvft+lbHSix8IhThDjIWE2fFZ4wg
         Ua1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=kvDqBlVap0EmnMOEordbvVG7VKbGSQRYifrliH4gpcY=;
        b=UPYFpZ+YePISekvP+JYXl1lB/ZjsoOjWPlgm+0XB2PMBGUAuEJUaAiYmu4wRa/a6ae
         bYb8dfUOZ3U7/4Y+YwtPs4vPYBzZAjrQNtkPFDgq1RcHjsKox801Z1MFfkm3MsukZOYP
         0hO29YmqYdE267L+Ynl6YLctnnutWWRpvE7fCWYhSG2Eqc7ccAaAWf/fcxnUIUIjE535
         zPA4KNqi1m3Mi9jhtIyKDPnDa74sum+cGyz2jrTew8dv95CN6KI8EpkjtKL+HJMDSk6N
         V3NJX8fteC15EK3SsZL8DTFVb14Gnaa/NKkPcTAfW1l74dyv0a0YOVnWa+lcE0yKzd3L
         aj5A==
X-Gm-Message-State: ACgBeo2dv5eKRJF3YAXHp05BHKnQq2WPeLq6BYY1t7ns0HYVUUjf0SHi
        PnsBEhj38A30+L2LgiV+lvqq0GYNieCKReom7UMyi+20yezYOg==
X-Google-Smtp-Source: AA6agR4YUFUjMfT1V6k2LcoKK0fnvKh1Cz4fUdG1x2YH38e9BO4Hg9nvVdqTI298c9oJJeudTfVVmUMajDuKTIgkyCQ=
X-Received: by 2002:a67:c201:0:b0:386:b3ad:6c2c with SMTP id
 i1-20020a67c201000000b00386b3ad6c2cmr2516213vsj.53.1660333686581; Fri, 12 Aug
 2022 12:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOsCCbMHCzA_b8eF23mAZ7FbiXDO5S6A7zjCsCLeTvOt8-ut7w@mail.gmail.com>
In-Reply-To: <CAOsCCbMHCzA_b8eF23mAZ7FbiXDO5S6A7zjCsCLeTvOt8-ut7w@mail.gmail.com>
From:   =?UTF-8?Q?Tobiasz_Karo=C5=84?= <unfa00@gmail.com>
Date:   Fri, 12 Aug 2022 21:47:55 +0200
Message-ID: <CAOsCCbMRA-Hbqc=yEg=LhjjtdX+QsicaUTWgXzG5oMZtA83Zsw@mail.gmail.com>
Subject: Re: Out of space; balance crashes (dmesg backtrace), makes filesystem
 read-only; can't fix
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

Somehow a root partition on one of my systems has filled up
completely, to the point where the system crashed. I managed to boot
into single user mode, started deleting unneded files but the space
didn't free up. I've tried doing a balance with -duase=3D10 or so to not
go overboard.

The balancing however would fail and make the filesystem read-only.
I don't want to do anything chaotic, I've imaged the disk but I don't
know what I can do at this point. Maybe it's a bug in btrfsprogs?

Here's a dmesg output of such occurance:

[pi=C4=85 sie 12 21:36:15 2022] BTRFS info (device dm-2): found 330
extents, stage: move data extents
[pi=C4=85 sie 12 21:36:34 2022] ------------[ cut here ]------------
[pi=C4=85 sie 12 21:36:34 2022] WARNING: CPU: 11 PID: 1918458 at
fs/btrfs/extent-tree.c:865 lookup_inline_extent_backref+0x5db/0x700
[btrfs]
[pi=C4=85 sie 12 21:36:34 2022] Modules linked in: loop exfat rndis_host
cdc_ether usbnet mii tun uinput snd_seq_midi snd_seq_midi_event
snd_seq_dummy snd_hrtimer snd_seq vfat fat ext4 crc16 mbcache jbd2
uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
snd_usb_audio snd_usbmidi_lib videobuf2_common snd_rawmidi
videodev snd_seq_device intel_rapl_msr mc r8169 intel_rapl_common
mousedev joydev snd_hda_codec_realtek snd_hda_codec_generic
edac_mce_amd ledtrig_audio realtek kvm_amd snd_hda_codec_hdmi amdgpu
snd_hda_intel kvm snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
mdio_devres snd_hda_core irqbypass snd_hwdep libphy
gpu_sched snd_pcm drm_ttm_helper snd_timer snd wmi_bmof
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel ttm aesni_intel
gigabyte_wmi cfg80211 sp5100_tco soundcore ccp pcspkr crypto_simd
drm_dp_helper pinctrl_amd wmi cryptd rfkill rapl rng_core k10temp
gpio_amdpt acpi_cpufreq i2c_piix4 gpio_generic mac_hid vboxnet
flt(OE) vboxnetadp(OE) vboxdrv(OE) dm_multipath dm_mod crypto_user
[pi=C4=85 sie 12 21:36:34 2022]  fuse bpf_preload ip_tables x_tables
uvesafb(OE) uas usb_storage usbhid btrfs blake2b_generic libcrc32c
crc32c_generic xor raid6_pq crc32c_intel xhci_pci xhci_pci_renesas
bcache
[pi=C4=85 sie 12 21:36:34 2022] CPU: 11 PID: 1918458 Comm: btrfs Tainted: G
       W  OE     5.18.16-arch1-1 #1
dd4fdd19f9b9db73fa00a1e8bfc0950337edf3ef
[pi=C4=85 sie 12 21:36:34 2022] Hardware name: Gigabyte Technology Co.,
Ltd. B550 AORUS ELITE V2/B550 AORUS ELITE V2, BIOS F13 07/08/2021
[pi=C4=85 sie 12 21:36:34 2022] RIP:
0010:lookup_inline_extent_backref+0x5db/0x700 [btrfs]
[pi=C4=85 sie 12 21:36:34 2022] Code: 0f 86 c6 00 00 00 49 39 d7 0f 83 e7
fe ff ff 4c 89 64 24 40 41 be 02 00 00 00 4d 89 fc 48 89 d5 44 8b 7c
24 20 e9 9a fd ff ff <0f> 0b b8 fb ff ff ff e9 8f fb ff ff b8 8b ff ff
ff e9 85 fb ff ff
[pi=C4=85 sie 12 21:36:34 2022] RSP: 0018:ffffae0f87cf77f0 EFLAGS: 00010202
[pi=C4=85 sie 12 21:36:34 2022] RAX: 0000000000000001 RBX: ffff8f893d487e00
RCX: 0000000000000000
[pi=C4=85 sie 12 21:36:34 2022] RDX: 0000000000000000 RSI: 0000000000000001
RDI: 0000000000000000
[pi=C4=85 sie 12 21:36:34 2022] RBP: 0000000000000000 R08: 0000000000000000
R09: 00000000000000df
[pi=C4=85 sie 12 21:36:34 2022] R10: 0000000000000000 R11: 0000000000000000
R12: 0000000042808000
[pi=C4=85 sie 12 21:36:34 2022] R13: 0000000000004000 R14: ffff8f889f881dd0
R15: ffff8f88ce391000
[pi=C4=85 sie 12 21:36:34 2022] FS:  00007fa98df88900(0000)
GS:ffff8f8f9ecc0000(0000) knlGS:0000000000000000
[pi=C4=85 sie 12 21:36:34 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
[pi=C4=85 sie 12 21:36:34 2022] CR2: 00007f3fe8100798 CR3: 00000001584a6000
CR4: 0000000000350ee0
[pi=C4=85 sie 12 21:36:34 2022] Call Trace:
[pi=C4=85 sie 12 21:36:34 2022]  <TASK>
[pi=C4=85 sie 12 21:36:34 2022]  insert_inline_extent_backref+0x66/0xf0
[btrfs 68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  __btrfs_inc_extent_ref.isra.0+0x95/0x260
[btrfs 68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  __btrfs_run_delayed_refs+0xb89/0x10c0
[btrfs 68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  ? btrfs_search_slot+0x80b/0xc30 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  btrfs_run_delayed_refs+0x71/0x1e0 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  ? btrfs_update_root+0x1b7/0x2f0 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  btrfs_commit_transaction+0x66/0xc60 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  ? btrfs_update_reloc_root+0x12c/0x230
[btrfs 68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  prepare_to_merge+0x100/0x370 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  relocate_block_group+0x12d/0x500 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  btrfs_relocate_block_group+0x235/0x400
[btrfs 68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  btrfs_relocate_chunk+0x3f/0x100 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  btrfs_balance+0x7f9/0xfc0 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  btrfs_ioctl+0x2628/0x2950 [btrfs
68a25cb6a9e61a33fdb13dbe6e95423ee852887b]
[pi=C4=85 sie 12 21:36:34 2022]  ? kernfs_fop_release+0x56/0xb0
[pi=C4=85 sie 12 21:36:34 2022]  ? kfree+0xe8/0x300
[pi=C4=85 sie 12 21:36:34 2022]  ? __rseq_handle_notify_resume+0x324/0x480
[pi=C4=85 sie 12 21:36:34 2022]  ? mntput_no_expire+0x4a/0x280
[pi=C4=85 sie 12 21:36:34 2022]  __x64_sys_ioctl+0x94/0xd0
[pi=C4=85 sie 12 21:36:34 2022]  do_syscall_64+0x5f/0x90
[pi=C4=85 sie 12 21:36:34 2022]  ? syscall_exit_to_user_mode+0x26/0x50
[pi=C4=85 sie 12 21:36:34 2022]  ? do_syscall_64+0x6b/0x90
[pi=C4=85 sie 12 21:36:34 2022]  ? syscall_exit_to_user_mode+0x26/0x50
[pi=C4=85 sie 12 21:36:34 2022]  ? do_syscall_64+0x6b/0x90
[pi=C4=85 sie 12 21:36:34 2022]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[pi=C4=85 sie 12 21:36:34 2022] RIP: 0033:0x7fa98e0cf9ef
[pi=C4=85 sie 12 21:36:34 2022] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48
2b 04 25 28 00 00
[pi=C4=85 sie 12 21:36:34 2022] RSP: 002b:00007ffe2f37e570 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
[pi=C4=85 sie 12 21:36:34 2022] RAX: ffffffffffffffda RBX: 0000000000000003
RCX: 00007fa98e0cf9ef
[pi=C4=85 sie 12 21:36:34 2022] RDX: 00007ffe2f37e670 RSI: 00000000c4009420
RDI: 0000000000000003
[pi=C4=85 sie 12 21:36:34 2022] RBP: 0000000000000000 R08: 0000000000000013
R09: 0000000000000073
[pi=C4=85 sie 12 21:36:34 2022] R10: 0000000000000000 R11: 0000000000000246
R12: 00007ffe2f37f6ff
[pi=C4=85 sie 12 21:36:34 2022] R13: 00007ffe2f37e670 R14: 0000000000000001
R15: 0000000000000000
[pi=C4=85 sie 12 21:36:34 2022]  </TASK>
[pi=C4=85 sie 12 21:36:34 2022] ---[ end trace 0000000000000000 ]---
[pi=C4=85 sie 12 21:36:34 2022] BTRFS: error (device dm-2: state A) in
btrfs_run_delayed_refs:2151: errno=3D-5 IO failure
[pi=C4=85 sie 12 21:36:34 2022] BTRFS info (device dm-2: state EA): forced =
readonly
[pi=C4=85 sie 12 21:36:34 2022] BTRFS info (device dm-2: state EA):
balance: ended with status: -30


Any help would be greatly appreciated.
Thank you!

--
- Tobiasz 'unfa' Karo=C5=84

www.youtube.com/unfa000
