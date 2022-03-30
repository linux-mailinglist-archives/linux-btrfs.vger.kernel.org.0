Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9A4EB850
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiC3Cev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiC3Ceu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 22:34:50 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91734BFF9
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 19:33:05 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id w189so10805901vke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=20+zjhAJj2OLl413i6ZBDkCwi3cE0hJqwfgjDEQ3dJU=;
        b=cDUvt4HZv9HsLh0gkdr4wd4bsF3Grnqrd6CjmAwnXJaItFuhsLHrGKl2IwfjNJCbik
         qSdLrPYnmVe1sKjulcTNuXO9J5C2kqU8UQFb2sCpgfBwauowazJ8SQWhcTx80ZK3Hvvj
         0ZPIcUKgnQxusEPd1vni5HKYDzJpfe+N9F5oHkrLZzSjLHeQUHHmlYHAFfedXRI2QI+P
         H/CwLxvmX/aDdhBNYG02hftY7ZfEEmimYRydSwfsGniAqUIevrO868LrAwCHrV+BTB03
         2TcJBqMm6jFjE2TFLOy6kvsIuqlRnU3CZ8em0/MoTQxo6IhKdhCv8kv4lzXgu4znHg0M
         N95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=20+zjhAJj2OLl413i6ZBDkCwi3cE0hJqwfgjDEQ3dJU=;
        b=DMXnMQfseEYQtZkyqb3ASYWozR9usRXJE8DN0uUC42stKgF1yBvfkR2/PIlvdjZQ8b
         cDhrtCLK2qPCBYHaI2v8QmXDow3Ok7eG+s3VvFe5KQeY8b3cPhLO9teieIxhrqXuEc8P
         +rNQQ0jCTH3yq24b0gmB3B1yYFTxKfjyRiSGB9T/F2vlxO/ZIIHLR18bCUmQBKMLfRp6
         /sWAZYGlePnBt6zUVMq0XEanLcY+G+fP0/7TMRO6RkLQZPVdKtItzvTf0qRk1ZiXDig3
         0TUJB5WJOoGlrHAt9jwyrD+WsNzIW2z1r0ZEafiwUARcWuGbm5cuu+dOAa8yLuT7MNuN
         UjOQ==
X-Gm-Message-State: AOAM532TGg/R+saBaiVxbPwobcM17+XDjJkcXDMqUzVFMsWPFfoIH7rz
        tHcpMtcrBE3qmuSyjhGVZY+lZmG06pHyi5V8rloP8+Vcev9UNw==
X-Google-Smtp-Source: ABdhPJzWbEbdaNuKonYCJIeUSi0b45vZMci2/NF/JZYXR1SyzFqpmtJSQ4nV3N8Hg65ojQJw2cYFGX6Gb7PvP3i2Qls=
X-Received: by 2002:a05:6122:49e:b0:343:30f:beaf with SMTP id
 o30-20020a056122049e00b00343030fbeafmr12883002vkn.6.1648607584750; Tue, 29
 Mar 2022 19:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB7onZzhe3EHM9+TvJARGr9Kcg6rKuxdy2-1Jk6V-wuDwQ@mail.gmail.com>
 <CAGdWbB5N827QrHiuQt2r3ZxLNRfGXkgOJj7u7M8mD81wiXL+7g@mail.gmail.com> <CAGdWbB5s02ERFxY7McwCh6eDAmw_zmyUe2ZFB=G6cuUpRVK6vw@mail.gmail.com>
In-Reply-To: <CAGdWbB5s02ERFxY7McwCh6eDAmw_zmyUe2ZFB=G6cuUpRVK6vw@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 29 Mar 2022 22:32:53 -0400
Message-ID: <CAGdWbB62XSNfv4+u-NvjaRxoSTk1_dqZeH3232RH3_mdYEJ6HA@mail.gmail.com>
Subject: Re: kernel: BTRFS error (device dm-1): Missing references.
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 8:58 PM Dave T <davestechshop@gmail.com> wrote:
>
> On Tue, Mar 29, 2022 at 7:39 PM Dave T <davestechshop@gmail.com> wrote:
> >
> > On Tue, Mar 29, 2022 at 7:08 PM Dave T <davestechshop@gmail.com> wrote:
> > >
> > > My systemd journal (log) is filled with the BTRFS error shown below.
> > > I'm running a fully updated Arch Linux system on a ThinkPad with the
> > > latest bios updates for that hardware.
> > >
> > > BTRFS scrub reports no errors on the internal and external storage devices.
> > >
> > > An online search did not return anything I found relevant, so I have
> > > no idea what this message means or how serious it is.
> > >
> > > Mar 29 17:46:15 archlinux kernel: ------------[ cut here ]------------
> > > Mar 29 17:46:15 archlinux kernel: WARNING: CPU: 2 PID: 1424 at
> > > fs/btrfs/extent-tree.c:232 btrfs_lookup_extent_info+0x3bf/0x3e0
> > > [btrfs]
> > > Mar 29 17:46:15 archlinux kernel: Modules linked in: rfcomm
> > > rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc
> > > fscache netfs cmac algif_hash algif_skcipher af_alg bnep snd_soc_skl
> > > snd_soc_hdac_hda snd_hda_ext_core snd_hda_codec_hdmi snd_soc_sst_ipc
> > > snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi intel_rapl_msr
> > > snd_ctl_led snd_soc_core snd_compress snd_hda_codec_realtek ac97_bus
> > > iTCO_wdt tps6598x snd_pcm_dmaengine snd_hda_codec_generic
> > > intel_pmc_bxt ee1004 mei_pxp mei_hdcp typec snd_hda_intel
> > > iTCO_vendor_support intel_rapl_common snd_intel_dspcfg iwlmvm
> > > snd_intel_sdw_acpi snd_hda_codec mac80211 intel_tcc_cooling uvcvideo
> > > snd_hda_core x86_pkg_temp_thermal intel_powerclamp videobuf2_vmalloc
> > > libarc4 think_lmi btusb coretemp videobuf2_memops snd_hwdep rapl
> > > intel_cstate intel_uncore iwlwifi pcspkr psmouse btrtl snd_pcm
> > > cdc_mbim i2c_i801 videobuf2_v4l2 btbcm firmware_attributes_class
> > > wmi_bmof intel_wmi_thunderbolt e1000e i2c_smbus snd_timer
> > > videobuf2_common cdc_wdm mei_me intel_lpss_pci
> > > Mar 29 17:46:15 archlinux kernel:  btintel cdc_ncm cfg80211 intel_lpss
> > > mei idma64 videodev bluetooth cdc_ether qcserial mc usbnet i915
> > > ecdh_generic mii usb_wwan mousedev joydev crc16
> > > intel_xhci_usb_role_switch ttm thinkpad_acpi roles intel_pch_thermal
> > > intel_gtt ledtrig_audio i2c_multi_instantiate platform_profile rfkill
> > > snd soundcore acpi_pad mac_hid ipmi_devintf ipmi_msghandler
> > > crypto_user fuse bpf_preload ip_tables x_tables ecb crypto_simd xts
> > > btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq
> > > hid_multitouch usbhid uas usb_storage dm_crypt cbc encrypted_keys
> > > dm_mod trusted asn1_encoder tee tpm rng_core rtsx_pci_sdmmc serio_raw
> > > mmc_core atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel
> > > ghash_clmulni_intel cryptd rtsx_pci xhci_pci xhci_pci_renesas wmi
> > > i8042 video serio vfat fat
> > > Mar 29 17:46:15 archlinux kernel: CPU: 2 PID: 1424 Comm: btrfs-cleaner
> > > Tainted: G     U  W         5.16.16-arch1-1 #1
> > > ea44c25f01916b44dd68de6a90ee2f4c9e51dcb4
> > > Mar 29 17:46:15 archlinux kernel: Hardware name: LENOVO
> > > 20HNCTO1WW/20HNCTO1WW, BIOS R0IET64W (1.42 ) 05/27/2021
> > > Mar 29 17:46:15 archlinux kernel: RIP:
> > > 0010:btrfs_lookup_extent_info+0x3bf/0x3e0 [btrfs]
> > > Mar 29 17:46:15 archlinux kernel: Code: 08 0d 00 00 c7 44 24 14 00 00
> > > 00 00 48 89 44 24 08 e9 d0 fc ff ff 80 48 6a 0c e9 e3 fc ff ff 48 85
> > > db 0f 85 61 ff ff ff 0f 0b <0f> 0b eb 82 b8 f4 ff ff ff eb aa e8 01 ef
> > > 38 db e9 3f 1c 0c 00 66
> > > Mar 29 17:46:15 archlinux kernel: RSP: 0018:ffffba48014cfc50 EFLAGS: 00010246
> > > Mar 29 17:46:15 archlinux kernel: RAX: 0000000000000000 RBX:
> > > 0000000000000000 RCX: 0000000000000000
> > > Mar 29 17:46:15 archlinux kernel: RDX: 0000000000000000 RSI:
> > > 000000531c714000 RDI: ffff93640021b178
> > > Mar 29 17:46:15 archlinux kernel: RBP: ffff9365d8a11ee0 R08:
> > > 0000000000000000 R09: ffff9365d8a11ee0
> > > Mar 29 17:46:15 archlinux kernel: R10: 000145ce761ca360 R11:
> > > 0000000000000000 R12: ffff93640021b000
> > > Mar 29 17:46:15 archlinux kernel: R13: ffff93640021b178 R14:
> > > 0000000000000000 R15: 000000531c714000
> > > Mar 29 17:46:15 archlinux kernel: FS:  0000000000000000(0000)
> > > GS:ffff936b1f500000(0000) knlGS:0000000000000000
> > > Mar 29 17:46:15 archlinux kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> > > 0000000080050033
> > > Mar 29 17:46:15 archlinux kernel: CR2: 00007f448004a000 CR3:
> > > 000000055c810001 CR4: 00000000003706e0
> > > Mar 29 17:46:15 archlinux kernel: DR0: 0000000000000000 DR1:
> > > 0000000000000000 DR2: 0000000000000000
> > > Mar 29 17:46:15 archlinux kernel: DR3: 0000000000000000 DR6:
> > > 00000000fffe0ff0 DR7: 0000000000000400
> > > Mar 29 17:46:15 archlinux kernel: Call Trace:
> > > Mar 29 17:46:15 archlinux kernel:  <TASK>
> > > Mar 29 17:46:15 archlinux kernel:  do_walk_down+0x171/0x690 [btrfs
> > > 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> > > Mar 29 17:46:15 archlinux kernel:  walk_down_tree+0xce/0x110 [btrfs
> > > 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> > > Mar 29 17:46:15 archlinux kernel:  btrfs_drop_snapshot+0x1de/0x830
> > > [btrfs 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> > > Mar 29 17:46:15 archlinux kernel:
> > > btrfs_clean_one_deleted_snapshot+0xe4/0x100 [btrfs
> > > 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> > > Mar 29 17:46:15 archlinux kernel:  cleaner_kthread+0xe5/0x130 [btrfs
> > > 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> > > Mar 29 17:46:15 archlinux kernel:  ? end_workqueue_bio+0xc0/0xc0
> > > [btrfs 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> > > Mar 29 17:46:15 archlinux kernel:  kthread+0x15c/0x180
> > > Mar 29 17:46:15 archlinux kernel:  ? set_kthread_struct+0x40/0x40
> > > Mar 29 17:46:15 archlinux kernel:  ret_from_fork+0x22/0x30
> > > Mar 29 17:46:15 archlinux kernel:  </TASK>
> > > Mar 29 17:46:15 archlinux kernel: ---[ end trace bc332cefd9295579 ]---
> > > Mar 29 17:46:15 archlinux kernel: BTRFS error (device dm-1): Missing references.
> > >
> > >
> > > # btrfs scrub status /mnt/usb_hdd
> > > UUID:             <redacted>
> > > Scrub started:    Tue Mar 29 01:45:08 2022
> > > Status:           finished
> > > Duration:         1:43:34
> > > Total to scrub:   392.98GiB
> > > Rate:             64.76MiB/s
> > > Error summary:    no errors found
> > >
> > >
> > > # btrfs scrub status /
> > > UUID:             <redacted>
> > > Scrub started:    Tue Mar 29 03:33:08 2022
> > > Status:           finished
> > > Duration:         0:02:42
> > > Total to scrub:   59.40GiB
> > > Rate:             318.16MiB/s
> > > Error summary:    no errors found
> > >
> > > Here is an indication of how frequently the errors are reported in the logs:
> > >
> > > Mar 29 17:44:12 kernel: BTRFS error (device dm-1): Missing references.
> > > Mar 29 17:44:43 kernel: BTRFS error (device dm-1): Missing references.
> > > Mar 29 17:45:14 kernel: BTRFS error (device dm-1): Missing references.
> > > Mar 29 17:45:44 kernel: BTRFS error (device dm-1): Missing references.
> > >
> > > It looks like it is reported every 30 seconds continuously, whether
> > > the device is being actively used or is idle.
> >
> > adding info to the above post:
> >
> > device dm-1 is my usb-attached HDD (WD Elements).
> > It contains 400 snapshots. This large number of snapshots has not
> > presented any problems in the past because it is a backup disk only.
> >
> > Every 30 seconds the message contains the same btrfs UUID values, like
> > this example:
> >
> > btrfs_clean_one_deleted_snapshot+0xe4/0x100 [btrfs
> > 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> >
> > The logs are always for btrfs 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04 only.
> >
> > I'm using btrbk to create snapshots. I see that the last one that was
> > sent to the USB HDD is listed as "incomplete" by btrbk.
> >
> > Any suggestions for tracking this down and resolving it?
>
> update 2:
>
> resolving the incomplete btrbk backup (deleting that snapshot and
> creating a new backup with btrbk, which completed successfully) did
> not resolve the kernel error message. It continues to appear every 30
> seconds. However, the btrfs UUID is different now. Here's the new
> message.
>
> Mar 29 20:56:27 archlinux kernel: BTRFS error (device dm-1): Missing references.
> Mar 29 20:56:57 archlinux kernel: ------------[ cut here ]------------
> Mar 29 20:56:57 archlinux kernel: WARNING: CPU: 2 PID: 932 at
> fs/btrfs/extent-tree.c:235 btrfs_lookup_extent_info+0x3ed/0x410
> [btrfs]
> Mar 29 20:56:57 archlinux kernel: Modules linked in: nls_iso8859_1
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc
> fscache netfs snd_soc_skl cmac snd_soc_hdac_hda algif_hash
> snd_hda_ext_core algif_skcipher snd_soc_sst_ipc af_alg bnep
> snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi
> snd_hda_codec_hdmi snd_soc_core snd_ctl_led intel_rapl_msr
> intel_rapl_common snd_compress snd_hda_codec_realtek ac97_bus
> snd_hda_codec_generic snd_pcm_dmaengine intel_tcc_cooling iTCO_wdt
> iwlmvm x86_pkg_temp_thermal mac80211 snd_hda_intel tps6598x
> intel_pmc_bxt libarc4 intel_powerclamp btusb ee1004 mei_pxp
> snd_intel_dspcfg iTCO_vendor_support mei_hdcp typec snd_intel_sdw_acpi
> coretemp iwlwifi btrtl rapl snd_hda_codec btbcm uvcvideo intel_cstate
> btintel iwlmei snd_hda_core intel_uncore think_lmi btmtk
> videobuf2_vmalloc psmouse pcspkr firmware_attributes_class
> videobuf2_memops snd_hwdep wmi_bmof intel_wmi_thunderbolt cdc_mbim
> bluetooth videobuf2_v4l2 snd_pcm cdc_wdm e1000e videobuf2_common
> i2c_i801 cdc_ncm
> Mar 29 20:56:57 archlinux kernel:  i2c_smbus snd_timer cdc_ether
> mei_me cfg80211 thinkpad_acpi videodev ecdh_generic mei mc usbnet
> crc16 ledtrig_audio platform_profile rfkill qcserial mii usb_wwan
> mousedev joydev i2c_multi_instantiate snd soundcore i915
> intel_xhci_usb_role_switch acpi_pad roles mac_hid intel_lpss_pci ttm
> intel_pch_thermal intel_lpss intel_gtt idma64 ipmi_devintf
> ipmi_msghandler crypto_user fuse bpf_preload ip_tables x_tables ecb
> crypto_simd xts btrfs blake2b_generic libcrc32c crc32c_generic xor
> raid6_pq hid_multitouch usbhid uas usb_storage dm_crypt cbc
> encrypted_keys dm_mod trusted asn1_encoder tee tpm rng_core
> rtsx_pci_sdmmc serio_raw atkbd mmc_core libps2 crct10dif_pclmul
> crc32_pclmul crc32c_intel ghash_clmulni_intel rtsx_pci cryptd xhci_pci
> xhci_pci_renesas wmi i8042 video serio vfat fat
> Mar 29 20:56:57 archlinux kernel: CPU: 2 PID: 932 Comm: btrfs-cleaner
> Tainted: G     U  W         5.17.1-arch1-1 #1
> 0ea933cb6bfe82a8dc16ab834a4bccdd297f98b7
> Mar 29 20:56:57 archlinux kernel: Hardware name: LENOVO
> 20HNCTO1WW/20HNCTO1WW, BIOS R0IET64W (1.42 ) 05/27/2021
> Mar 29 20:56:57 archlinux kernel: RIP:
> 0010:btrfs_lookup_extent_info+0x3ed/0x410 [btrfs]
> Mar 29 20:56:57 archlinux kernel: Code: 00 00 c7 44 24 1c 00 00 00 00
> 48 89 44 24 10 e9 a3 fc ff ff 80 48 6a 0c e9 b7 fc ff ff 48 83 3c 24
> 00 0f 85 54 ff ff ff 0f 0b <0f> 0b e9 79 ff ff ff b8 f4 ff ff ff eb a5
> e8 d0 e7 54 f7 e9 8f 06
> Mar 29 20:56:57 archlinux kernel: RSP: 0018:ffffc199810ebc58 EFLAGS: 00010246
> Mar 29 20:56:57 archlinux kernel: RAX: 0000000000000000 RBX:
> 000000531c714000 RCX: 0000000000000000
> Mar 29 20:56:57 archlinux kernel: RDX: 0000000000000000 RSI:
> 000000531c714000 RDI: ffff9cd967865f78
> Mar 29 20:56:57 archlinux kernel: RBP: ffff9cd9c3dd33f0 R08:
> 0000000000000000 R09: 0000000000000001
> Mar 29 20:56:57 archlinux kernel: R10: 00012972b4686430 R11:
> 0000000000000001 R12: ffff9cd967865e00
> Mar 29 20:56:57 archlinux kernel: R13: ffff9cd967865f78 R14:
> 0000000000000000 R15: ffff9cd991cdd000
> Mar 29 20:56:57 archlinux kernel: FS:  0000000000000000(0000)
> GS:ffff9ce05f500000(0000) knlGS:0000000000000000
> Mar 29 20:56:57 archlinux kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Mar 29 20:56:57 archlinux kernel: CR2: 000055c824c50000 CR3:
> 00000006c7810002 CR4: 00000000003706e0
> Mar 29 20:56:57 archlinux kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000
> Mar 29 20:56:57 archlinux kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400
> Mar 29 20:56:57 archlinux kernel: Call Trace:
> Mar 29 20:56:57 archlinux kernel:  <TASK>
> Mar 29 20:56:57 archlinux kernel:  do_walk_down+0x171/0x690 [btrfs
> d7bb535792b5408a564e9011b11717e721df9e55]
> Mar 29 20:56:57 archlinux kernel:  walk_down_tree+0xce/0x110 [btrfs
> d7bb535792b5408a564e9011b11717e721df9e55]
> Mar 29 20:56:57 archlinux kernel:  btrfs_drop_snapshot+0x1df/0x830
> [btrfs d7bb535792b5408a564e9011b11717e721df9e55]
> Mar 29 20:56:57 archlinux kernel:
> btrfs_clean_one_deleted_snapshot+0xe4/0x100 [btrfs
> d7bb535792b5408a564e9011b11717e721df9e55]
> Mar 29 20:56:57 archlinux kernel:  cleaner_kthread+0xe5/0x130 [btrfs
> d7bb535792b5408a564e9011b11717e721df9e55]
> Mar 29 20:56:57 archlinux kernel:  ? end_workqueue_bio+0xc0/0xc0
> [btrfs d7bb535792b5408a564e9011b11717e721df9e55]
> Mar 29 20:56:57 archlinux kernel:  kthread+0xd8/0x100
> Mar 29 20:56:57 archlinux kernel:  ? kthread_complete_and_exit+0x20/0x20
> Mar 29 20:56:57 archlinux kernel:  ret_from_fork+0x22/0x30
> Mar 29 20:56:57 archlinux kernel:  </TASK>
> Mar 29 20:56:57 archlinux kernel: ---[ end trace 0000000000000000 ]---
> Mar 29 20:56:57 archlinux kernel: BTRFS error (device dm-1): Missing references.

Update 3:

I deleted all the backups (all subvolumes on dm-1), keeping only the
top level btrfs volume. I guess I did not need to do that because the
errors continue even after removing all the 400 snapshots I had there.

Here's the result of btrfs scrub status -R:

Status:           finished
Duration:         0:05:31
        data_extents_scrubbed: 450403
        tree_extents_scrubbed: 10366
        data_bytes_scrubbed: 26869157888
        tree_bytes_scrubbed: 169836544
        read_errors: 0
        csum_errors: 0
        verify_errors: 0
        no_csum: 8128
        csum_discards: 6551725
        super_errors: 0
        malloc_errors: 0
        uncorrectable_errors: 0
        unverified_errors: 0
        corrected_errors: 0
        last_physical: 424166817792

The kernel error message remains exactly the same as what I reported
last, even the uuid. The error continues to be logged every 30
seconds.
