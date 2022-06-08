Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A0543165
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiFHNcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiFHNch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 09:32:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D547E10A625
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 06:32:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u26so32535458lfd.8
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WrRztywCsLIxQa8brrUf1wCXBO+fVmDrzDM67hdJ5kI=;
        b=eLG8O8JI6EXN8pus1NTjB8zVFU3Q9GPAhxnW3Er0efhlipZNKmjFWQUaa0kvYiC7wM
         z/1Xsi0qsz/cdAMJxe7DA7460RNqumxQks1odNPclJ223ZSBWzKvXO+0qW5xCp07WmjJ
         RzfPJWipsFwvBa3uvnG1qbj1hsfVEQ+JdL3qDGO1qe3x56x1dhN8gODvPlHWpZ8BOzrF
         Sh3dxd6nVyPGbO/n6Ybcudwl6MRrrQvM6/iC5kjy2W6NeVAPbTO/JMM/2B3W3UGGAk4P
         yV38DFMrKf1sVQyH3j8DWPrq2evMndacZzXog6vV/6sl5VTiwn/QUOQnkvzUA4gImfMP
         tCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WrRztywCsLIxQa8brrUf1wCXBO+fVmDrzDM67hdJ5kI=;
        b=TYuQcJMGKDPQCLzyyX5Omz4clHB3R6u4LkpnxqQtEg0VMO+OZN1g6+0CdKx8oE3F/i
         IgHMKoYcngtWbRjD7JMHhAMTRwmgsA5UdWaxVOwp2l2LmDUXVUQWeESNIbnY2TdWUuDJ
         5yihK6oDWH+moz7+eAnU2dLoMAdt02wFkDF6I4na+nF4DV2Gm+SU2PsvbzGZVRi/OaHM
         HRQ3BDKvOn2yYWD+9lOjtE4xrCrOhv5RI0cKqAGWZoQqJSwuUJepbqhfrFh9RWz1ih/C
         FGcIkrJCSh+6aiImrx0qx55Sn5bzCGBmIYHKYtTFyop0YnAnIi4BQxdv++NPAJCBGZ29
         +lSA==
X-Gm-Message-State: AOAM533vrXPyCQXNfcLol0mMKvzo2JcGqIJrW/BgXuFHUILa9JpmFQGc
        ff0Ht9/LeVDS81NejfSOeaFqDuT1mUWoT6YxnbLRYZsd2Kff6HZn
X-Google-Smtp-Source: ABdhPJwoZVpazzGE8D7TTwpR8Jvl9bpwGbseceocD8qMIg+NmHwSkXbDK7UO6V9siwW427PVS0hiJq5rgAMOfbipdmg=
X-Received: by 2002:a05:6512:20a:b0:479:8fb:2214 with SMTP id
 a10-20020a056512020a00b0047908fb2214mr22953816lfo.473.1654695152158; Wed, 08
 Jun 2022 06:32:32 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 8 Jun 2022 09:32:16 -0400
Message-ID: <CAJCQCtT0VogE6WUu-9z-FAt4mP=yMoOQSmS_ZQWY=XU65Sy4fg@mail.gmail.com>
Subject: bug: warning at fs/btrfs/inode.c:8885 btrfs_destroy_inode
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.17.3

Not sure what workload the user was running at the time.

https://bugzilla.redhat.com/show_bug.cgi?id=2079294

WARNING: CPU: 4 PID: 78 at fs/btrfs/inode.c:8885 btrfs_destroy_inode+0x203/0x220
Modules linked in: overlay tls hid_logitech_hidpp uhid uinput rfcomm
snd_seq_dummy snd_hrtimer nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nf_tables nfnetlink qrtr snd_hda_codec_hdmi bnep sunrpc
snd_sof_pci_intel_cnl snd_sof_intel_hda_common soundwire_intel
soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
snd_sof_pci snd_sof_xtensa_dsp snd_sof vfat fat soundwire_bus
snd_soc_skl intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp
iwlmvm snd_soc_hdac_hda iTCO_wdt coretemp snd_hda_ext_core
intel_pmc_bxt snd_soc_sst_ipc snd_soc_sst_dsp iTCO_vendor_support
snd_soc_acpi_intel_match kvm_intel mei_pxp mei_hdcp intel_rapl_msr
snd_soc_acpi dell_laptop mac80211 kvm snd_ctl_led irqbypass libarc4
snd_soc_core dell_smm_hwmon snd_hda_codec_realtek snd_compress rapl
 snd_hda_codec_generic ac97_bus snd_pcm_dmaengine intel_cstate
intel_uncore iwlwifi pcspkr snd_usb_audio snd_hda_intel btusb dell_wmi
snd_intel_dspcfg snd_intel_sdw_acpi ledtrig_audio iwlmei snd_hda_codec
dell_wmi_sysman btrtl snd_usbmidi_lib dell_smbios
firmware_attributes_class snd_hda_core dcdbas snd_rawmidi i2c_i801
btbcm dell_wmi_descriptor cfg80211 wmi_bmof intel_wmi_thunderbolt
snd_hwdep i2c_smbus snd_seq uvcvideo btintel snd_seq_device mei_me
btmtk thunderbolt mei snd_pcm videobuf2_vmalloc videobuf2_memops
bluetooth videobuf2_v4l2 videobuf2_common
processor_thermal_device_pci_legacy snd_timer processor_thermal_device
joydev processor_thermal_rfim idma64 videodev snd
processor_thermal_mbox processor_thermal_rapl soundcore
intel_rapl_common ecdh_generic rfkill mc intel_soc_dts_iosf
intel_pch_thermal int3403_thermal int340x_thermal_zone intel_hid
int3400_thermal acpi_tad acpi_pad sparse_keymap acpi_thermal_rel zram
dm_crypt typec_displayport i915 rtsx_pci_sdmmc
 crct10dif_pclmul mmc_core hid_multitouch crc32_pclmul nvme
crc32c_intel ucsi_acpi nvme_core ghash_clmulni_intel typec_ucsi
serio_raw rtsx_pci ttm typec wmi i2c_hid_acpi i2c_hid video
pinctrl_cannonlake ip6_tables ip_tables ipmi_devintf ipmi_msghandler
fuse
CPU: 4 PID: 78 Comm: kswapd0 Not tainted 5.17.3-302.fc36.x86_64 #1
Hardware name: Dell Inc. XPS 13 7390/0G2D0W, BIOS 1.13.0 02/10/2022
RIP: 0010:btrfs_destroy_inode+0x203/0x220
Code: fe ff ff 0f 0b 48 83 bb 78 ff ff ff 00 0f 84 62 fe ff ff 0f 0b
48 83 bb 70 ff ff ff 00 0f 84 60 fe ff ff 0f 0b e9 59 fe ff ff <0f> 0b
e9 89 fe ff ff 0f 0b e9 74 fe ff ff 66 66 2e 0f 1f 84 00 00
RSP: 0018:ffffb5d180523b68 EFLAGS: 00010206
RAX: 0000000000008000 RBX: ffff8f487fed7ce8 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8f487fed7ce8
RBP: ffff8f487fed7ab0 R08: 0000000000000001 R09: 0000000080330025
R10: ffff8f496cb99e10 R11: ffff8f480a5aa000 R12: ffff8f4805633000
R13: ffff8f480d145800 R14: 0000000000014c89 R15: 0000000005322400
FS:  0000000000000000(0000) GS:ffff8f4b7e900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd1ec62a128 CR3: 00000002d4e10006 CR4: 00000000003706e0
Call Trace:
 <TASK>
 destroy_inode+0x38/0x70
 dispose_list+0x48/0x60
 prune_icache_sb+0x41/0x50
 super_cache_scan+0x163/0x1e0
 do_shrink_slab+0x13e/0x2f0
 shrink_slab+0x1e1/0x280
 shrink_node+0x2b3/0x6f0
 balance_pgdat+0x33d/0x720
 kswapd+0x1dc/0x390
 ? do_wait_intr_irq+0xa0/0xa0
 ? balance_pgdat+0x720/0x720
 kthread+0xe6/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>


-- 
Chris Murphy
