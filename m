Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB154EB6E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiC2XlT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiC2XlS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 19:41:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE5965499
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 16:39:34 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id z134so16788080vsz.8
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6Lg0goOTC0gYfsTqI7xY923Ujf54D0QFokxxYo3sp/A=;
        b=b07oUqqwLWIoxxF8uwVHw6set/yBezOF835/EA8UlPzr4NVRrSOB3luoJajq9RI4As
         AEidBM76Io5FtQvdt2b4sQRvZAf/rZfxwIzpMCme7WNXoIQPy3pDxTOnA6usXzeYCVLw
         MAGQrXZRV9FhZ9xyL4+LQEglo263G25/i0ZfcALEGeiRZy0uC4NWrSISyfk3fqWMJxIL
         fifUxyDmxQFA3LnPswux4xRQWBts66kipnZwiEaHPwsXSOvY3w6UecwYJ4zqcR8DfHAR
         DwEixwGP2S1VQ3YCtM/XWuo453+qFfkBeQ4ZduguDwaFsy5ztbRW7B+upESHbc1FOZYa
         xDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6Lg0goOTC0gYfsTqI7xY923Ujf54D0QFokxxYo3sp/A=;
        b=hdRfRzcPJ4Dzf4y8JpyBcmtEMkZaDpn3L/x2b5PNN6SxdVrg3AVjPuYG2vOg5oCj3Q
         Jkw/sTPEj14mtRtq1+KN8dDhz1voXV13Bs6lGlbFWpP2Ql8pidzS24bq/cT0fl+JRo/M
         VWsgiRwUJWsuNNnYUWHAl3HPf6/MqojuAbm1l/72P48MLCIcoXaiqiIWUDuFb8Sw3RsG
         eqkjuCsN9Hkg/1nK7KtYIHdZAYkAcoQ1Vox5ewxNGuR/4irdcPFXrjhCNJQI0vHy/zuR
         naLbcfqxuNEpiApaA25ss1yxGFD8gChTdMYnTf0CZW+c/KgheNn0Q1Ufxd9+aRbot/y5
         oaCw==
X-Gm-Message-State: AOAM531DRG7JO/eOv3YVqFgxZJht2/t3gFcCuKhN9VmX+IjNxz8W6nDZ
        jwYQMcUpyCTrYSVOrln//c1iZ/zcTt+Wq1JuQ9RH6CluuISWMg==
X-Google-Smtp-Source: ABdhPJzzAOvrd8UmIKu1Am/Tt5cnE1RRadwxfsd1CJD0p6qXPBpO0/IUwLs8wSKW/D7z8n8nEj2KDKrn5EXZpLvDVcE=
X-Received: by 2002:a67:6686:0:b0:325:3d74:f2f0 with SMTP id
 a128-20020a676686000000b003253d74f2f0mr17918008vsc.20.1648597173359; Tue, 29
 Mar 2022 16:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB7onZzhe3EHM9+TvJARGr9Kcg6rKuxdy2-1Jk6V-wuDwQ@mail.gmail.com>
In-Reply-To: <CAGdWbB7onZzhe3EHM9+TvJARGr9Kcg6rKuxdy2-1Jk6V-wuDwQ@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 29 Mar 2022 19:39:21 -0400
Message-ID: <CAGdWbB5N827QrHiuQt2r3ZxLNRfGXkgOJj7u7M8mD81wiXL+7g@mail.gmail.com>
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

On Tue, Mar 29, 2022 at 7:08 PM Dave T <davestechshop@gmail.com> wrote:
>
> My systemd journal (log) is filled with the BTRFS error shown below.
> I'm running a fully updated Arch Linux system on a ThinkPad with the
> latest bios updates for that hardware.
>
> BTRFS scrub reports no errors on the internal and external storage devices.
>
> An online search did not return anything I found relevant, so I have
> no idea what this message means or how serious it is.
>
> Mar 29 17:46:15 archlinux kernel: ------------[ cut here ]------------
> Mar 29 17:46:15 archlinux kernel: WARNING: CPU: 2 PID: 1424 at
> fs/btrfs/extent-tree.c:232 btrfs_lookup_extent_info+0x3bf/0x3e0
> [btrfs]
> Mar 29 17:46:15 archlinux kernel: Modules linked in: rfcomm
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc
> fscache netfs cmac algif_hash algif_skcipher af_alg bnep snd_soc_skl
> snd_soc_hdac_hda snd_hda_ext_core snd_hda_codec_hdmi snd_soc_sst_ipc
> snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi intel_rapl_msr
> snd_ctl_led snd_soc_core snd_compress snd_hda_codec_realtek ac97_bus
> iTCO_wdt tps6598x snd_pcm_dmaengine snd_hda_codec_generic
> intel_pmc_bxt ee1004 mei_pxp mei_hdcp typec snd_hda_intel
> iTCO_vendor_support intel_rapl_common snd_intel_dspcfg iwlmvm
> snd_intel_sdw_acpi snd_hda_codec mac80211 intel_tcc_cooling uvcvideo
> snd_hda_core x86_pkg_temp_thermal intel_powerclamp videobuf2_vmalloc
> libarc4 think_lmi btusb coretemp videobuf2_memops snd_hwdep rapl
> intel_cstate intel_uncore iwlwifi pcspkr psmouse btrtl snd_pcm
> cdc_mbim i2c_i801 videobuf2_v4l2 btbcm firmware_attributes_class
> wmi_bmof intel_wmi_thunderbolt e1000e i2c_smbus snd_timer
> videobuf2_common cdc_wdm mei_me intel_lpss_pci
> Mar 29 17:46:15 archlinux kernel:  btintel cdc_ncm cfg80211 intel_lpss
> mei idma64 videodev bluetooth cdc_ether qcserial mc usbnet i915
> ecdh_generic mii usb_wwan mousedev joydev crc16
> intel_xhci_usb_role_switch ttm thinkpad_acpi roles intel_pch_thermal
> intel_gtt ledtrig_audio i2c_multi_instantiate platform_profile rfkill
> snd soundcore acpi_pad mac_hid ipmi_devintf ipmi_msghandler
> crypto_user fuse bpf_preload ip_tables x_tables ecb crypto_simd xts
> btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq
> hid_multitouch usbhid uas usb_storage dm_crypt cbc encrypted_keys
> dm_mod trusted asn1_encoder tee tpm rng_core rtsx_pci_sdmmc serio_raw
> mmc_core atkbd libps2 crct10dif_pclmul crc32_pclmul crc32c_intel
> ghash_clmulni_intel cryptd rtsx_pci xhci_pci xhci_pci_renesas wmi
> i8042 video serio vfat fat
> Mar 29 17:46:15 archlinux kernel: CPU: 2 PID: 1424 Comm: btrfs-cleaner
> Tainted: G     U  W         5.16.16-arch1-1 #1
> ea44c25f01916b44dd68de6a90ee2f4c9e51dcb4
> Mar 29 17:46:15 archlinux kernel: Hardware name: LENOVO
> 20HNCTO1WW/20HNCTO1WW, BIOS R0IET64W (1.42 ) 05/27/2021
> Mar 29 17:46:15 archlinux kernel: RIP:
> 0010:btrfs_lookup_extent_info+0x3bf/0x3e0 [btrfs]
> Mar 29 17:46:15 archlinux kernel: Code: 08 0d 00 00 c7 44 24 14 00 00
> 00 00 48 89 44 24 08 e9 d0 fc ff ff 80 48 6a 0c e9 e3 fc ff ff 48 85
> db 0f 85 61 ff ff ff 0f 0b <0f> 0b eb 82 b8 f4 ff ff ff eb aa e8 01 ef
> 38 db e9 3f 1c 0c 00 66
> Mar 29 17:46:15 archlinux kernel: RSP: 0018:ffffba48014cfc50 EFLAGS: 00010246
> Mar 29 17:46:15 archlinux kernel: RAX: 0000000000000000 RBX:
> 0000000000000000 RCX: 0000000000000000
> Mar 29 17:46:15 archlinux kernel: RDX: 0000000000000000 RSI:
> 000000531c714000 RDI: ffff93640021b178
> Mar 29 17:46:15 archlinux kernel: RBP: ffff9365d8a11ee0 R08:
> 0000000000000000 R09: ffff9365d8a11ee0
> Mar 29 17:46:15 archlinux kernel: R10: 000145ce761ca360 R11:
> 0000000000000000 R12: ffff93640021b000
> Mar 29 17:46:15 archlinux kernel: R13: ffff93640021b178 R14:
> 0000000000000000 R15: 000000531c714000
> Mar 29 17:46:15 archlinux kernel: FS:  0000000000000000(0000)
> GS:ffff936b1f500000(0000) knlGS:0000000000000000
> Mar 29 17:46:15 archlinux kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Mar 29 17:46:15 archlinux kernel: CR2: 00007f448004a000 CR3:
> 000000055c810001 CR4: 00000000003706e0
> Mar 29 17:46:15 archlinux kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000
> Mar 29 17:46:15 archlinux kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400
> Mar 29 17:46:15 archlinux kernel: Call Trace:
> Mar 29 17:46:15 archlinux kernel:  <TASK>
> Mar 29 17:46:15 archlinux kernel:  do_walk_down+0x171/0x690 [btrfs
> 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> Mar 29 17:46:15 archlinux kernel:  walk_down_tree+0xce/0x110 [btrfs
> 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> Mar 29 17:46:15 archlinux kernel:  btrfs_drop_snapshot+0x1de/0x830
> [btrfs 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> Mar 29 17:46:15 archlinux kernel:
> btrfs_clean_one_deleted_snapshot+0xe4/0x100 [btrfs
> 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> Mar 29 17:46:15 archlinux kernel:  cleaner_kthread+0xe5/0x130 [btrfs
> 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> Mar 29 17:46:15 archlinux kernel:  ? end_workqueue_bio+0xc0/0xc0
> [btrfs 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]
> Mar 29 17:46:15 archlinux kernel:  kthread+0x15c/0x180
> Mar 29 17:46:15 archlinux kernel:  ? set_kthread_struct+0x40/0x40
> Mar 29 17:46:15 archlinux kernel:  ret_from_fork+0x22/0x30
> Mar 29 17:46:15 archlinux kernel:  </TASK>
> Mar 29 17:46:15 archlinux kernel: ---[ end trace bc332cefd9295579 ]---
> Mar 29 17:46:15 archlinux kernel: BTRFS error (device dm-1): Missing references.
>
>
> # btrfs scrub status /mnt/usb_hdd
> UUID:             <redacted>
> Scrub started:    Tue Mar 29 01:45:08 2022
> Status:           finished
> Duration:         1:43:34
> Total to scrub:   392.98GiB
> Rate:             64.76MiB/s
> Error summary:    no errors found
>
>
> # btrfs scrub status /
> UUID:             <redacted>
> Scrub started:    Tue Mar 29 03:33:08 2022
> Status:           finished
> Duration:         0:02:42
> Total to scrub:   59.40GiB
> Rate:             318.16MiB/s
> Error summary:    no errors found
>
> Here is an indication of how frequently the errors are reported in the logs:
>
> Mar 29 17:44:12 kernel: BTRFS error (device dm-1): Missing references.
> Mar 29 17:44:43 kernel: BTRFS error (device dm-1): Missing references.
> Mar 29 17:45:14 kernel: BTRFS error (device dm-1): Missing references.
> Mar 29 17:45:44 kernel: BTRFS error (device dm-1): Missing references.
>
> It looks like it is reported every 30 seconds continuously, whether
> the device is being actively used or is idle.

adding info to the above post:

device dm-1 is my usb-attached HDD (WD Elements).
It contains 400 snapshots. This large number of snapshots has not
presented any problems in the past because it is a backup disk only.

Every 30 seconds the message contains the same btrfs UUID values, like
this example:

btrfs_clean_one_deleted_snapshot+0xe4/0x100 [btrfs
0911a8fe6c71eb7dbbad7c3b2067cc4913bade04]

The logs are always for btrfs 0911a8fe6c71eb7dbbad7c3b2067cc4913bade04 only.

I'm using btrbk to create snapshots. I see that the last one that was
sent to the USB HDD is listed as "incomplete" by btrbk.

Any suggestions for tracking this down and resolving it?
