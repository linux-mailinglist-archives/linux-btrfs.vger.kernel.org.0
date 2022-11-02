Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1DD616973
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiKBQmq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiKBQmA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 12:42:00 -0400
X-Greylist: delayed 1857 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 09:36:56 PDT
Received: from mail.as397444.net (mail.as397444.net [69.59.18.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B76502A25B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1667404861; h=Subject:From:To:From:Subject:To:Cc:Cc:Reply-To:In-Reply-To:
        References; bh=VqF5NbPLNkJXVYFk+qgpY52SGsxfnDzk9OdX+LbRyFM=; b=Zy6idXzTmSyA+R
        4z3Y4ut9ppVZGBGZD2WndjcTSNOW834E2kfnFvdzzas6XJ8mjX4lF+bbodumKFpZD/SSR0yZeDmdn
        DtlSQAyfcZw+sXNDo8F2Xl/Dq9FMbuZCjyOLd2B61wiyhLo1i2W0DAg9pP7QIN/yemzflp8G4727x
        z3M+i5D95mPY5f2rqzZPB9BX1Pwa1DZ8tnU3G2f4FMvB0opDDVVCa+1yHYTDEhciKya2ffCzKwwZo
        eVpaP1UES5sk0n6xZAzdKZAsS6FFymVjg45fIKNbDIn+z0lw2Cp9oUtDdcV6big8fCr2Z1Agv1Hbt
        PD4MGBPPu8kcRNNSj9hA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=clients.mail.as397444.net; s=1667404863; h=Subject:From:To:From:Subject:To:
        Cc:Cc:Reply-To:In-Reply-To:References;
        bh=VqF5NbPLNkJXVYFk+qgpY52SGsxfnDzk9OdX+LbRyFM=; b=hy7vDPjy9+1KCKBu5MvUTdMGFr
        2IpiKLq3+DApfHPqKa7ar0axKVXaK4AbadRYO0lKnAib7Wcb7qTrrz3qUStANpgSUsQ9d6RzAiEBo
        DLOa2MQhJKt2NbVmeHCIHv20HPmc5YAb0t1bwAvBV17Vz2oq1sTeKNAvFf4LaWsHJJ01HAOS2wWqT
        /nEnbVT1G+bFHBrJmDUZGPPgTMN6d5afx8TZ/kYA9yfii5LkdfoB1pGH+74327BqFpEkxEokOA/zK
        yqQM4ER/NwX5mUy/xErIkWetanHqYwJMuuukiZQAFYsHKlzQjAPoJscpiB8BGzLWxoW8q1TO5O2od
        FaDtXh1g==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1oqGFX-00FWer-1q for linux-btrfs@vger.kernel.org;
        Wed, 02 Nov 2022 16:05:58 +0000
Message-ID: <56f5c7a4-8c4f-5bcc-220b-ed51c692598b@bluematt.me>
Date:   Wed, 2 Nov 2022 09:05:58 -0700
MIME-Version: 1.0
Content-Language: en-US
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Matt Corallo <blnxfsl@bluematt.me>
Subject: NULL Ptr Deref on sub-page rw mount with missing device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Basically what the title says. Sadly dmesg is a bit of a mess because multiple threads hit it at the 
same time so its all interleaved. A full dmesg is available at http://cwillu.com:8080/69.59.18.155/1 
with the top of it pasted below.

Linux BEASTv3 5.19.0-0.deb11.2-powerpc64le #1 SMP Debian 5.19.11-1~bpo11+1 (2022-10-03) ppc64le 
GNU/Linux

[  571.427636] audit: type=1400 audit(1667403706.044:20): apparmor="STATUS" 
operation="profile_replace" info="same as current profile, skipping" profile="unconfined" 
name="lxc-container-default-with-nesting" pid=2433 comm="apparmor_parser"
[  571.427642] audit: type=1400 audit(1667403706.044:21): apparmor="STATUS" 
operation="profile_replace" info="same as current profile, skipping" profile="unconfined" 
name="lxc-container-nfs" pid=2433 comm="apparmor_parser"
[  734.123376] BTRFS info (device dm-1): disk space caching is enabled
[  734.123384] BTRFS info (device dm-1): has skinny extents
[  734.123387] BTRFS info (device dm-1): forcing free space tree for sector size 4096 with page size 
65536
[  734.123391] BTRFS warning (device dm-1): read-write for sector size 4096 with page size 65536 is 
experimental
[  734.166761] BTRFS error (device dm-1): devid 4 uuid a5666cf3-91d2-4902-8d0b-e1ba147c5c9c is missing
[  734.166794] BTRFS error (device dm-1): failed to read chunk tree: -2
[  734.184942] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.184967] Faulting instruction address: 0xc00000000015fe30
[  734.184982] Oops: Kernel access of bad area, sig: 7 [#1]
[  734.184994] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  734.185010] Modules linked in: xt_mark xt_connmark xt_nat wireguard libchacha20poly1305 
libcurve25519_generic libchacha libpoly1305 ip6_udp_tunnel udp_tunnel nft_chain_nat xt_MASQUERADE 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables crc32c_generic nfnetlink 
essiv authenc amdgpu evdev snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec ofpart 
gpu_sched ast snd_hda_core powernv_flash ipmi_powernv snd_hwdep drm_display_helper drm_vram_helper 
ipmi_devintf drm_ttm_helper mtd ttm ipmi_msghandler opal_prd snd_pcm sg snd_timer drm_kms_helper 
syscopyarea snd sysfillrect sysimgblt at24 fb_sys_fops i2c_algo_bit soundcore regmap_i2c drm sunrpc 
fuse drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs 
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c raid0 multipath linear usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod raid1 
md_mod xhci_pci xhci_hcd xts ecb nvme
[  734.185135]  ctr vmx_crypto gf128mul crc32c_vpmsum tg3 nvme_core t10_pi usbcore mpt3sas 
crc64_rocksoft_generic libphy crc64_rocksoft crc_t10dif crct10dif_generic crc64 crct10dif_common 
raid_class ptp pps_core usb_common scsi_transport_sas
[  734.185414] CPU: 4 PID: 1199 Comm: kworker/u129:0 Not tainted 5.19.0-0.deb11.2-powerpc64le #1 
Debian 5.19.11-1~bpo11+1
[  734.185436] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
[  734.185473] NIP:  c00000000015fe30 LR: c0000000001602d4 CTR: c000000000160250
[  734.185478] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.185507] REGS: c00000002ade7650 TRAP: 0300   Not tainted  (5.19.0-0.deb11.2-powerpc64le Debian 
5.19.11-1~bpo11+1)
[  734.185540] Faulting instruction address: 0xc00000000015fe30
[  734.185575] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28002284  XER: 20040000
[  734.185648] CFAR: c00000000015fc1c DAR: 0000000000000000 DSISR: 00080000 IRQMASK: 1
                GPR00: c0000000001602d4 c00000002ade78f0 c0000000026a7800 0000000000000800
                GPR04: 000000007fffffff c00000002983abc0 0000000000000000 c0080000102bc968
                GPR08: 0000000fffffffe1 000000007fffffff 0000000000000000 c008000010363be8
                GPR12: 0000000000004000 c000000ffffdba00 c00000000016e808 c000000008a5b840
                GPR16: 0000000000000000 c000000024f7a000 00000000000001b0 c000000000ed73f0
                GPR20: 0000000000000001 c0000000027836f8 c000000002783700 0000000000000000
                GPR24: c00000000250f9c0 c0000000026e3060 0000000000000004 000000007fffffff
                GPR28: c0000000021278b0 0000000000000800 0000000000000000 c00000002983abc0
[  734.185801] NIP [c00000000015fe30] __queue_work+0x380/0x7a0
[  734.185817] LR [c0000000001602d4] queue_work_on+0x84/0xb0
[  734.185832] Call Trace:
[  734.185839] [c00000002ade79e0] [c0000000001602d4] queue_work_on+0x84/0xb0
[  734.185857] [c00000002ade7a10] [c0080000102bd1fc] btrfs_queue_work+0xf4/0x180 [btrfs]
[  734.185917] [c00000002ade7a70] [c00800001025cc54] end_workqueue_bio+0x9c/0x140 [btrfs]
[  734.185977] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.185980] [c00000002ade7aa0] [c0000000006eefbc] bio_endio+0x19c/0x230
[  734.185982] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  734.185988] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.185991] Faulting instruction address: 0xc00000000015fe30
[  734.186005] Faulting instruction address: 0xc00000000015fe30

[  734.186017] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  734.186022] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  734.186027] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.186030] Faulting instruction address: 0xc00000000015fe30
[  734.186018] [c00000002ade7ad0] [c0080000102ad8dc] btrfs_end_bio+0xe4/0x290 [btrfs]
[  734.186046] BUG: Kernel NULL pointer dereference on read at 0x00000000

[  734.186055] [c00000002ade7b10] [c0000000006eefbc] bio_endio+0x19c/0x230
[  734.186060] [c00000002ade7b40] [c00800000f855304] dm_io_complete+0xdc/0x2e0 [dm_mod]
[  734.186092] Faulting instruction address: 0xc00000000015fe30

[  734.186119] [c00000002ade7b90] [c00800000f857998] clone_endio+0x100/0x310 [dm_mod]
[  734.186456] [c00000002ade7c30] [c0000000006eefbc] bio_endio+0x19c/0x230
[  734.186480] [c00000002ade7c60] [c00800000f282200] crypt_dec_pending+0x138/0x190 [dm_crypt]
[  734.186518] [c00000002ade7ca0] [c000000000161848] process_one_work+0x2a8/0x580
[  734.186555] [c00000002ade7d40] [c000000000162228] worker_thread+0x98/0x5e0
[  734.186562] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  734.186566] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.186570] Faulting instruction address: 0xc00000000015fe30
[  734.186591] [c00000002ade7dc0] [c00000000016e920] kthread+0x120/0x130
[  734.186645] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.186672] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  734.186677] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  734.186680] Faulting instruction address: 0xc00000000015fe30

[  734.186706] [c00000002ade7e10] [c00000000000ce54] ret_from_kernel_thread+0x5c/0x64
[  734.186789] Faulting instruction address: 0xc00000000015fe30

[  734.186840] Instruction dump:
[  734.187346] eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 7c0803a6 ebc1fff0 ebe1fff8
[  734.187438] 7d908120 4e800020 60000000 60420000 <e87e0000> 48bb5955 60000000 813e0018
[  734.187558] ---[ end trace 0000000000000000 ]---

[  735.590644] Oops: Kernel access of bad area, sig: 7 [#2]
[  735.590655] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  735.590669] Modules linked in: xt_mark xt_connmark xt_nat wireguard libchacha20poly1305 
libcurve25519_generic libchacha libpoly1305 ip6_udp_tunnel udp_tunnel nft_chain_nat xt_MASQUERADE 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables crc32c_generic nfnetlink 
essiv authenc amdgpu evdev snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_hda_codec ofpart 
gpu_sched ast snd_hda_core powernv_flash ipmi_powernv snd_hwdep drm_display_helper drm_vram_helper 
ipmi_devintf drm_ttm_helper mtd ttm ipmi_msghandler opal_prd snd_pcm sg snd_timer drm_kms_helper 
syscopyarea snd sysfillrect sysimgblt at24 fb_sys_fops i2c_algo_bit soundcore regmap_i2c drm sunrpc 
fuse drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 xxhash_generic btrfs 
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c raid0 multipath linear
[  735.590782] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  735.590784] Faulting instruction address: 0xc00000000015fe30
[  735.591027]  usb_storage dm_crypt dm_mod algif_skcipher af_alg sd_mod raid1 md_mod xhci_pci 
xhci_hcd xts ecb nvme ctr vmx_crypto gf128mul crc32c_vpmsum tg3 nvme_core t10_pi usbcore mpt3sas 
crc64_rocksoft_generic libphy crc64_rocksoft crc_t10dif crct10dif_generic crc64 crct10dif_common 
raid_class ptp pps_core usb_common scsi_transport_sas
[  735.591141] CPU: 26 PID: 642 Comm: kworker/u129:6 Tainted: G      D 
5.19.0-0.deb11.2-powerpc64le #1  Debian 5.19.11-1~bpo11+1
[  735.591180] Workqueue: kcryptd/253:4 kcryptd_crypt [dm_crypt]
[  735.591213] NIP:  c00000000015fe30 LR: c0000000001602d4 CTR: c000000000160250
[  735.591247] REGS: c000000011e67650 TRAP: 0300   Tainted: G      D 
(5.19.0-0.deb11.2-powerpc64le Debian 5.19.11-1~bpo11+1)
[  735.591293] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28002284  XER: 20040000
[  735.591341] CFAR: c00000000015fc1c DAR: 0000000000000000 DSISR: 00080000 IRQMASK: 1
                GPR00: c0000000001602d4 c000000011e678f0 c0000000026a7800 0000000000000800
                GPR04: 000000007fffffff c00000002983ca40 0000000000000000 c0080000102bc968
                GPR08: 0000000fffffffe1 000000007fffffff 0000000000000000 c008000010363be8
                GPR12: 0000000000004000 c000000ffffc3900 c00000000016e808 c000000008a50ac0
                GPR16: 0000000000000000 c000000024f7a000 0000000000000278 c000000000ed73f0
                GPR20: 0000000000000001 c0000000027836f8 c000000002783700 0000000000000000
                GPR24: c00000000250f9c0 c0000000026e3060 000000000000001a 000000007fffffff
                GPR28: c0000000021278b0 0000000000000800 0000000000000000 c00000002983ca40
[  735.591627] NIP [c00000000015fe30] __queue_work+0x380/0x7a0
[  735.591649] LR [c0000000001602d4] queue_work_on+0x84/0xb0
[  735.591670] Call Trace:
[  735.591685] [c000000011e679e0] [c0000000001602d4] queue_work_on+0x84/0xb0
[  735.591709] [c000000011e67a10] [c0080000102bd1fc] btrfs_queue_work+0xf4/0x180 [btrfs]
[  735.591768] [c000000011e67a70] [c00800001025cc54] end_workqueue_bio+0x9c/0x140 [btrfs]
[  735.591816] [c000000011e67aa0] [c0000000006eefbc] bio_endio+0x19c/0x230
[  735.591840] [c000000011e67ad0] [c0080000102ad8dc] btrfs_end_bio+0xe4/0x290 [btrfs]
[  735.591898] [c000000011e67b10] [c0000000006eefbc] bio_endio+0x19c/0x230
[  735.591930] [c000000011e67b40] [c00800000f855304] dm_io_complete+0xdc/0x2e0 [dm_mod]
[  735.591969] [c000000011e67b90] [c00800000f857998] clone_endio+0x100/0x310 [dm_mod]
[  735.592008] [c000000011e67c30] [c0000000006eefbc] bio_endio+0x19c/0x230
[  735.592049] [c000000011e67c60] [c00800000f282200] crypt_dec_pending+0x138/0x190 [dm_crypt]
[  735.592093] [c000000011e67ca0] [c000000000161848] process_one_work+0x2a8/0x580
[  735.592118] [c000000011e67d40] [c000000000162228] worker_thread+0x98/0x5e0
[  735.592160] [c000000011e67dc0] [c00000000016e920] kthread+0x120/0x130
[  735.592192] [c000000011e67e10] [c00000000000ce54] ret_from_kernel_thread+0x5c/0x64
[  735.592226] Instruction dump:
[  735.592243] eb21ffc8 eb41ffd0 eb61ffd8 eb81ffe0 eba1ffe8 7c0803a6 ebc1fff0 ebe1fff8
[  735.592274] 7d908120 4e800020 60000000 60420000 <e87e0000> 48bb5955 60000000 813e0018
[  735.592306] ---[ end trace 0000000000000000 ]---
