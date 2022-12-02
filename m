Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3A63FD12
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiLBAbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Dec 2022 19:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiLBAbQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Dec 2022 19:31:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35B13EB5
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Dec 2022 16:26:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 618FE5C00AC;
        Thu,  1 Dec 2022 19:26:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute2.internal (MEProxy); Thu, 01 Dec 2022 19:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8henrie.com; h=
        cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669940810; x=1670027210; bh=xs6K3h/hxM
        7yoJ0nBmQVaDP5nBuKOflKyofoHd0L3xY=; b=qFPSFAHrh3Oe7pEqr4Ib20K4cc
        GV8O160ZMvGe6+OGCIJPuYgXgIQ8sbGHRx/SMlLjGnov1IPpTsjCFel5GSrFkXcC
        ECsNtFRXhy/hUVeLiJaFY6faJQIcj5waSJLO7JNgrezmnx9keF90tkV767w7v7nm
        a+2vPHAtaELHLRRpVs03XC+bNujsUINgXGjkc1SmTU0JsbwkxeQtIw8BsRVfRQPm
        BuFwmagjVAZ+1NHFKOlcJmTIz2UuRYpdfcP5Q/j1LNbQjeOQUe8oTkLhm+t/vpWj
        OzgVTYoj/qlLa+4RzTrTmIi7hODjbZUwh2EiJRgYrsxFUfYSCBbzqz8hz/dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669940810; x=1670027210; bh=xs6K3h/hxM7yoJ0nBmQVaDP5nBuK
        OflKyofoHd0L3xY=; b=GfQDkNcUvby3CpaL/fZpZDORmyeCChihZd3rPaE9TY5u
        rzy4784K5e4v5hzUCOD/m3+TwspD8Ka+I9GWe5NF8oPJxEQaiLeSdDoYwpY53b8e
        x/ZCyE6MGWANeT7i7tRB8ZL1vVqssgddg4iab6O06N2zdTOsalLJ1Bi28RlTsqZj
        F2jz8RgpLu99Yg2bG7tFPuBKmNDF6BPXstDkXktFx7Qn6iB1rYlYEJdF3xxuavW/
        hQd27RCpCMzjM21LNAjXvEVEnqX2R/ZN0+BLn36jazBlybzi5lkhq0SlprHmhA6A
        lB2yWNUIZoQoR6lMQSl/dwIl75jGnxUofuzSDWIa2g==
X-ME-Sender: <xms:SkaJY2CBseUg5YxFyhsDDNPnNUsACEgYNi3WW6Cqhvitrzb6aDpa3Q>
    <xme:SkaJYwhyRhMIVK-Qdm2fEdfzrmkB4dUO6aZ6AEqsQFLA0eb_B_Dle9XrV-lMwVsFE
    lCoFHd97-nHnAzCCto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdeigddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfpfgrthhh
    rghnucfjvghnrhhivgdfuceonhgrthgvsehnkehhvghnrhhivgdrtghomheqnecuggftrf
    grthhtvghrnhephfevheefvdfhieetteetkefhieeufedtieejkeefvdeggfetteffueef
    fedtveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epnhgrthgvsehnkehhvghnrhhivgdrtghomh
X-ME-Proxy: <xmx:SkaJY5kVMoYyDzpnmPR3xUiH5qzKv03JiVl0BpZGSO69KqM2siSk0Q>
    <xmx:SkaJY0wUqv66C2WKfQxbQd40CmGMHT5HgJbDezW-EDoQlA8BDxjl6Q>
    <xmx:SkaJY7Sw-hZcsN2g7yFf580NMpJ8YtTZYuyUxLmKncRQL9suZeJzpg>
    <xmx:SkaJYyLd2rQnmPtA344lxWZa02ThHdbH3qbM1eS_h7xMabHpNt0OTg>
Feedback-ID: iffd94604:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 059A9B60086; Thu,  1 Dec 2022 19:26:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <2aac6a67-9ae8-4489-8e05-083b7f165d0c@app.fastmail.com>
In-Reply-To: <e7e85926-cf60-bc0b-ed13-ceed00f1acf2@gmx.com>
References: <debfa7c5-646c-4333-a277-62e98a78a47e@app.fastmail.com>
 <15a497f7-f4f0-6b17-0f90-58b5420aaaaf@libero.it>
 <fd9ea145-38cb-eb6a-0154-832ed612633d@georgianit.com>
 <f2da2590-f970-4c1c-8eef-4d48e5aeea61@app.fastmail.com>
 <e7e85926-cf60-bc0b-ed13-ceed00f1acf2@gmx.com>
Date:   Thu, 01 Dec 2022 17:26:28 -0700
From:   "Nathan Henrie" <nate@n8henrie.com>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "Remi Gauvin" <remi@georgianit.com>, kreijack@inwind.it,
        linux-btrfs@vger.kernel.org
Subject: Re: BTRFS RAID1 root corrupt and read-only
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for your help.

nvme0:

```
[1/7] checking root items
[2/7] checking extents
backref 15353727729664 parent 1140559929556992 not referenced back 0xc9133d70
tree backref 15353727729664 parent 14660022714368 not found in extent tree
incorrect global backref count on 15353727729664 found 3 wanted 2
backpointer mismatch on [15353727729664 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 0507d652-8d7a-4897-a843-2fb170634055
found 714021703680 bytes used, error(s) found
total csum bytes: 647554940
total tree bytes: 48873324544
total fs tree bytes: 45331578880
total extent tree bytes: 2671329280
btree space waste bytes: 8367968013
file data blocks allocated: 2528365129728
 referenced 4251594551296
```

nvme1:

```
[1/7] checking root items
[2/7] checking extents
backref 15353727729664 parent 1140559929556992 not referenced back 0xca4d0f20
tree backref 15353727729664 parent 14660022714368 not found in extent tree
incorrect global backref count on 15353727729664 found 3 wanted 2
backpointer mismatch on [15353727729664 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/nvme1n1p1
UUID: 0507d652-8d7a-4897-a843-2fb170634055
found 714021703680 bytes used, error(s) found
total csum bytes: 647554940
total tree bytes: 48873324544
total fs tree bytes: 45331578880
total extent tree bytes: 2671329280
btree space waste bytes: 8367968013
file data blocks allocated: 2528365129728
 referenced 4251594551296
```

nvme2:
```
[1/7] checking root items
[2/7] checking extents
backref 15353727729664 parent 1140559929556992 not referenced back 0xc9dbbe70
tree backref 15353727729664 parent 14660022714368 not found in extent tree
incorrect global backref count on 15353727729664 found 3 wanted 2
backpointer mismatch on [15353727729664 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/nvme2n1p1
UUID: 0507d652-8d7a-4897-a843-2fb170634055
found 714021703680 bytes used, error(s) found
total csum bytes: 647554940
total tree bytes: 48873324544
total fs tree bytes: 45331578880
total extent tree bytes: 2671329280
btree space waste bytes: 8367968013
file data blocks allocated: 2528365129728
 referenced 4251594551296
```

Nate

On Thu, Dec 1, 2022, at 4:16 PM, Qu Wenruo wrote:
> 
> 
> On 2022/12/2 07:05, Nathan Henrie wrote:
> > I mounted, and in the few seconds before it went read-only I started a scrub. Oddly it it finished without errors. (Obviously nothing seems to have changed when I try to remount, but thought it was worth a shot.)
> > 
> > The rsync is done, between that and other backups I think I'm unlikely to lose much / any data. Is trying a `btrfs check --repair` on the drive *without* SMART errors a reasonable next step?
> > 
> > It certainly seems weird to suddenly have two simultaneous drive failures (different manufacturers), one without SMART errors. No weird power surges or recent hard shutdowns I recall.
> 
> Nope, as mentioned extent tree is corrupted.
> 
> How it is corrupted can only be verified by "btrfs check" output.
> It can be a bitflip (mostly hardware problem) or some bug in btrfs code, 
> really hard to say if no "btrfs check" output.
> 
> Thanks,
> Qu
> 
> > 
> > ```
> > # mount -t btrfs -o clear_cache,skip_balance,degraded,rescan_uuid_tree /dev/nvme2n1p1 /mnt
> > # btrfs scrub start -B /mnt
> > scrub done for 0507d652-8d7a-4897-a843-2fb170634055
> > Scrub started:    Thu Dec  1 22:49:20 2022
> > Status:           finished
> > Duration:         0:03:26
> > Total to scrub:   1.31TiB
> > Rate:             6.46GiB/s
> > Error summary:    no errors found
> > ```
> > 
> > In dmesg I see:
> > 
> > ```
> > [ +32.007721] BTRFS info (device nvme0n1p1): force clearing of disk cache
> > [  +0.000005] BTRFS info (device nvme0n1p1): allowing degraded mounts
> > [  +0.000002] BTRFS info (device nvme0n1p1): disk space caching is enabled
> > [  +0.000001] BTRFS info (device nvme0n1p1): has skinny extents
> > [  +0.004773] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1 errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> > [  +0.000005] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1 errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> > [  +0.162844] BTRFS info (device nvme0n1p1): enabling ssd optimizations
> > [Dec 1 22:49] BTRFS info (device nvme0n1p1): balance: resume skipped
> > [  +0.000006] BTRFS info (device nvme0n1p1): checking UUID tree
> > [  +7.477641] BTRFS info (device nvme0n1p1): scrub: started on devid 1
> > [  +0.000560] BTRFS info (device nvme0n1p1): scrub: started on devid 3
> > [  +0.000008] BTRFS info (device nvme0n1p1): scrub: started on devid 4
> > [ +13.372940] ------------[ cut here ]------------
> > [  +0.000004] WARNING: CPU: 18 PID: 25283 at fs/btrfs/extent-tree.c:3049 __btrfs_free_extent+0x6d5/0x920 [btrfs]
> > [  +0.000041] Modules linked in: qrtr ns af_packet intel_rapl_msr edac_mce_amd edac_core intel_rapl_common kvm_amd kvm irqbypass btrfs crc32_pclmul wmi_bmof snd_hda_codec_realtek ghash_clmulni_intel aesni_intel nouveau blake2b_generic crypto_simd xor snd_hda_codec_hdmi rt2800usb snd_hda_codec_generic btusb ledtrig_audio snd_hda_intel iwlmvm cryptd rt2x00usb mxm_wmi zstd_compress btrtl snd_intel_dspcfg snd_intel_sdw_acpi rt2800lib rt2x00lib video snd_hda_codec btbcm snd_hda_core btintel snd_hwdep mac80211 iwlwifi drm_ttm_helper ttm mousedev libarc4 bluetooth drm_kms_helper igb evdev joydev input_leds snd_pcm fb_sys_fops sp5100_tco mac_hid ecdh_generic corsair_psu syscopyarea ecc sysfillrect cfg80211 rapl raid6_pq snd_timer sysimgblt ptp crc16 watchdog pps_core libaes deflate snd dca i2c_algo_bit led_class rfkill efi_pstore tpm_crb soundcore i2c_piix4 k10temp tpm_tis tpm_tis_core gpio_amdpt tpm pinctrl_amd gpio_generic rng_core tiny_power_button i2c_designware_platform wmi
> > [  +0.000056]  i2c_designware_core button acpi_cpufreq ip6_tables xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp ip6t_rpfilter ipt_rpfilter xt_pkttype nft_compat nft_counter nf_tables libcrc32c crc32c_generic nfnetlink sch_fq_codel ctr atkbd libps2 serio zfs(PO) zunicode(PO) zzstd(O) zlua(O) zavl(PO) icp(PO) zcommon(PO) znvpair(PO) spl(O) tun tap macvlan drm bridge stp llc agpgart backlight fuse i2c_core pstore configfs efivarfs ip_tables x_tables autofs4 squashfs isofs uas usb_storage hid_generic usbhid hid sr_mod sd_mod cdrom xhci_pci xhci_pci_renesas xhci_hcd ahci nvme libahci usbcore crc32c_intel nvme_core libata t10_pi crc_t10dif crct10dif_generic crct10dif_pclmul crct10dif_common usb_common rtc_cmos dm_mod nls_iso8859_1 nls_cp437 vfat fat vmw_pvscsi scsi_mod scsi_common overlay loop
> > [  +0.000054] CPU: 18 PID: 25283 Comm: btrfs-transacti Tainted: P        W  O      5.15.79 #1-NixOS
> > [  +0.000003] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X399 Taichi, BIOS P3.90 12/04/2019
> > [  +0.000002] RIP: 0010:__btrfs_free_extent+0x6d5/0x920 [btrfs]
> > [  +0.000026] Code: e8 8c df 2d f9 0f 0b e9 63 65 0b 00 41 8d 54 24 01 39 d0 0f 85 86 64 0b 00 45 89 66 40 c7 44 24 18 02 00 00 00 e9 9a fd ff ff <0f> 0b 49 8b 3e e8 f1 54 00 00 ff 74 24 18 4d 89 f8 48 89 d9 4c 8b
> > [  +0.000002] RSP: 0018:ffffb7655b48bc60 EFLAGS: 00010246
> > [  +0.000002] RAX: 00000000fffffffe RBX: 00000d554d724000 RCX: 0000000000000000
> > [  +0.000001] RDX: 0000000000000000 RSI: 000000000000013e RDI: ffff98b31d35b900
> > [  +0.000001] RBP: 00000df6d17cc000 R08: 0000000000000000 R09: ffff98b30f295380
> > [  +0.000001] R10: 000135e6d2840580 R11: 0000000000000000 R12: 00000000fffffffe
> > [  +0.000001] R13: ffff98b287fcb070 R14: ffff98b30f295380 R15: fffffffffffffff8
> > [  +0.000002] FS:  0000000000000000(0000) GS:ffff98c23ed80000(0000) knlGS:0000000000000000
> > [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0.000001] CR2: 00007f6900045eb0 CR3: 000000039e4ae000 CR4: 00000000003506e0
> > [  +0.000002] Call Trace:
> > [  +0.000004]  <TASK>
> > [  +0.000004]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
> > [  +0.000034]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
> > [  +0.000024]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> > [  +0.000024]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
> > [  +0.000026]  ? start_transaction+0xce/0x5a0 [btrfs]
> > [  +0.000025]  ? usleep_range_state+0x80/0x90
> > [  +0.000004]  transaction_kthread+0x12f/0x1a0 [btrfs]
> > [  +0.000025]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
> > [  +0.000025]  kthread+0x127/0x150
> > [  +0.000005]  ? set_kthread_struct+0x50/0x50
> > [  +0.000002]  ret_from_fork+0x22/0x30
> > [  +0.000005]  </TASK>
> > [  +0.000001] ---[ end trace 97a30a2b1a52a636 ]---
> > [  +0.000003] BTRFS info (device nvme0n1p1): leaf 14486647160832 gen 7325287 total ptrs 198 free space 4502 owner 2
> > [  +0.000002]   item 0 key (15353724665856 169 0) itemoff 16250 itemsize 33
> > [  +0.000002]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489880297472
> > [  +0.000001]   item 1 key (15353724682240 169 0) itemoff 16217 itemsize 33
> > [  +0.000002]           extent refs 1 gen 6975524 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488845074432
> > [  +0.000001]   item 2 key (15353724698624 169 0) itemoff 16184 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662811271168
> > [  +0.000001]   item 3 key (15353724715008 169 0) itemoff 16151 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489909542912
> > [  +0.000001]   item 4 key (15353724731392 169 0) itemoff 16118 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489900630016
> > [  +0.000001]   item 5 key (15353724747776 169 0) itemoff 16085 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 6 key (15353724764160 169 0) itemoff 16052 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975524 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488831803392
> > [  +0.000001]   item 7 key (15353724780544 169 0) itemoff 16019 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 8 key (15353724796928 169 0) itemoff 15986 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975524 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490243547136
> > [  +0.000000]   item 9 key (15353724829696 169 0) itemoff 15953 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489509363712
> > [  +0.000001]   item 10 key (15353724846080 169 0) itemoff 15920 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489877594112
> > [  +0.000000]   item 11 key (15353724862464 169 0) itemoff 15887 itemsize 33
> > [  +0.000002]           extent refs 1 gen 6975731 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517627678720
> > [  +0.000001]   item 12 key (15353724878848 169 0) itemoff 15854 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489541672960
> > [  +0.000001]   item 13 key (15353724895232 169 0) itemoff 15821 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489517981696
> > [  +0.000001]   item 14 key (15353724911616 169 0) itemoff 15788 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975731 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517627170816
> > [  +0.000001]   item 15 key (15353724928000 169 0) itemoff 15755 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489903284224
> > [  +0.000001]   item 16 key (15353724944384 169 0) itemoff 15722 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975731 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517627645952
> > [  +0.000001]   item 17 key (15353724960768 169 0) itemoff 15689 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967802 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14662064504832
> > [  +0.000001]   item 18 key (15353724977152 169 0) itemoff 15656 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 19 key (15353724993536 169 0) itemoff 15623 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975524 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490358923264
> > [  +0.000001]   item 20 key (15353725009920 169 0) itemoff 15590 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662808584192
> > [  +0.000001]   item 21 key (15353725026304 169 0) itemoff 15557 itemsize 33
> > [  +0.000000]           extent refs 1 gen 6969114 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14666533453824
> > [  +0.000001]   item 22 key (15353725042688 169 0) itemoff 15524 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975524 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488860704768
> > [  +0.000000]   item 23 key (15353725059072 169 0) itemoff 15482 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490181468160
> > [  +0.000001]           ref#1: shared block backref parent 14490181369856
> > [  +0.000001]   item 24 key (15353725075456 169 0) itemoff 15449 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6969360 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489312313344
> > [  +0.000001]   item 25 key (15353725091840 169 0) itemoff 15416 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489879068672
> > [  +0.000001]   item 26 key (15353725108224 169 0) itemoff 15383 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6969114 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490464141312
> > [  +0.000001]   item 27 key (15353725124608 169 0) itemoff 15350 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489889439744
> > [  +0.000000]   item 28 key (15353725140992 169 0) itemoff 15317 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975524 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488834670592
> > [  +0.000001]   item 29 key (15353725157376 169 0) itemoff 15284 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975731 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490292551680
> > [  +0.000000]   item 30 key (15353725173760 169 0) itemoff 15251 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975731 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490292338688
> > [  +0.000001]   item 31 key (15353725190144 169 0) itemoff 15218 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488548966400
> > [  +0.000001]   item 32 key (15353725206528 169 0) itemoff 15185 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488887934976
> > [  +0.000001]   item 33 key (15353725222912 169 0) itemoff 15152 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488535973888
> > [  +0.000001]   item 34 key (15353725255680 169 0) itemoff 15119 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662806437888
> > [  +0.000001]   item 35 key (15353725272064 169 0) itemoff 15086 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000000]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 36 key (15353725288448 169 0) itemoff 15053 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489898500096
> > [  +0.000001]   item 37 key (15353725304832 169 0) itemoff 15020 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489853100032
> > [  +0.000001]   item 38 key (15353725353984 169 0) itemoff 14987 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489511477248
> > [  +0.000000]   item 39 key (15353725419520 169 0) itemoff 14954 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975731 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15603905249280
> > [  +0.000001]   item 40 key (15353725435904 169 0) itemoff 14921 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 14665767337984
> > [  +0.000000]   item 41 key (15353725452288 169 0) itemoff 14888 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975731 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488777506816
> > [  +0.000001]   item 42 key (15353725468672 169 0) itemoff 14774 itemsize 114
> > [  +0.000001]           extent refs 10 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488601034752
> > [  +0.000000]           ref#1: shared block backref parent 14488601001984
> > [  +0.000001]           ref#2: shared block backref parent 14488600952832
> > [  +0.000001]           ref#3: shared block backref parent 14488600936448
> > [  +0.000001]           ref#4: shared block backref parent 14488600838144
> > [  +0.000000]           ref#5: shared block backref parent 14488600805376
> > [  +0.000001]           ref#6: shared block backref parent 14488600772608
> > [  +0.000001]           ref#7: shared block backref parent 14488600739840
> > [  +0.000001]           ref#8: shared block backref parent 14488600723456
> > [  +0.000000]           ref#9: shared block backref parent 14488600576000
> > [  +0.000001]   item 43 key (15353725485056 169 0) itemoff 14741 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662805225472
> > [  +0.000001]   item 44 key (15353725501440 169 0) itemoff 14708 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489895272448
> > [  +0.000001]   item 45 key (15353725517824 169 0) itemoff 14675 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662803898368
> > [  +0.000001]   item 46 key (15353725550592 169 0) itemoff 14642 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489859358720
> > [  +0.000001]   item 47 key (15353725566976 169 0) itemoff 14609 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973447 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517560209408
> > [  +0.000000]   item 48 key (15353725583360 169 0) itemoff 14576 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973447 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488841814016
> > [  +0.000001]   item 49 key (15353725599744 169 0) itemoff 14543 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973447 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517546987520
> > [  +0.000001]   item 50 key (15353725616128 169 0) itemoff 14510 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973447 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517541597184
> > [  +0.000001]   item 51 key (15353725632512 169 0) itemoff 14477 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000000]           ref#0: shared block backref parent 15390790156288
> > [  +0.000001]   item 52 key (15353725648896 169 0) itemoff 14444 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975524 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488714674176
> > [  +0.000001]   item 53 key (15353725665280 169 0) itemoff 14411 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7144659 flags 2
> > [  +0.000000]           ref#0: tree block backref root 42397
> > [  +0.000001]   item 54 key (15353725681664 169 0) itemoff 14378 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15390790156288
> > [  +0.000000]   item 55 key (15353725698048 169 0) itemoff 14345 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973537 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489113264128
> > [  +0.000001]   item 56 key (15353725714432 169 0) itemoff 14312 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662808338432
> > [  +0.000000]   item 57 key (15353725730816 169 0) itemoff 14279 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489909821440
> > [  +0.000001]   item 58 key (15353725747200 169 0) itemoff 14246 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967712 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489904480256
> > [  +0.000001]   item 59 key (15353725763584 169 0) itemoff 14213 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488687345664
> > [  +0.000001]   item 60 key (15353725796352 169 0) itemoff 14180 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489873301504
> > [  +0.000001]   item 61 key (15353725812736 169 0) itemoff 14147 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662811320320
> > [  +0.000001]   item 62 key (15353725829120 169 0) itemoff 14114 itemsize 33
> > [  +0.000000]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489890471936
> > [  +0.000001]   item 63 key (15353725845504 169 0) itemoff 14081 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489903874048
> > [  +0.000000]   item 64 key (15353725861888 169 0) itemoff 14048 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490369949696
> > [  +0.000001]   item 65 key (15353725878272 169 0) itemoff 14015 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489883017216
> > [  +0.000001]   item 66 key (15353725894656 169 0) itemoff 13982 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490399948800
> > [  +0.000001]   item 67 key (15353725911040 169 0) itemoff 13949 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490246348800
> > [  +0.000001]   item 68 key (15353725927424 169 0) itemoff 13916 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490241564672
> > [  +0.000001]   item 69 key (15353725943808 169 0) itemoff 13883 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490250543104
> > [  +0.000001]   item 70 key (15353725960192 169 0) itemoff 13850 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489879822336
> > [  +0.000000]   item 71 key (15353725992960 169 0) itemoff 13817 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490242187264
> > [  +0.000001]   item 72 key (15353726025728 169 0) itemoff 13784 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000000]   item 73 key (15353726042112 169 0) itemoff 13751 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488933941248
> > [  +0.000001]   item 74 key (15353726058496 169 0) itemoff 13718 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488992284672
> > [  +0.000001]   item 75 key (15353726074880 169 0) itemoff 13685 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490241155072
> > [  +0.000001]   item 76 key (15353726091264 169 0) itemoff 13652 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490219167744
> > [  +0.000001]   item 77 key (15353726107648 169 0) itemoff 13619 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15603601784832
> > [  +0.000001]   item 78 key (15353726124032 169 0) itemoff 13586 itemsize 33
> > [  +0.000000]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490243547136
> > [  +0.000001]   item 79 key (15353726156800 169 0) itemoff 13553 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488995299328
> > [  +0.000000]   item 80 key (15353726189568 169 0) itemoff 13520 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488936677376
> > [  +0.000001]   item 81 key (15353726205952 169 0) itemoff 13487 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489546522624
> > [  +0.000001]   item 82 key (15353726222336 169 0) itemoff 13454 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489910542336
> > [  +0.000001]   item 83 key (15353726238720 169 0) itemoff 13421 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6974758 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14661155930112
> > [  +0.000001]   item 84 key (15353726255104 169 0) itemoff 13388 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 16057554894848
> > [  +0.000001]   item 85 key (15353726271488 169 0) itemoff 13355 itemsize 33
> > [  +0.000000]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15390790156288
> > [  +0.000001]   item 86 key (15353726287872 169 0) itemoff 13322 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489339510784
> > [  +0.000000]   item 87 key (15353726304256 169 0) itemoff 13289 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489330483200
> > [  +0.000001]   item 88 key (15353726320640 169 0) itemoff 13256 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489318604800
> > [  +0.000001]   item 89 key (15353726353408 169 0) itemoff 13223 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15390790156288
> > [  +0.000001]   item 90 key (15353726386176 169 0) itemoff 13190 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000000]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 91 key (15353726402560 169 0) itemoff 13157 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15604655046656
> > [  +0.000001]   item 92 key (15353726418944 169 0) itemoff 13124 itemsize 33
> > [  +0.000000]           extent refs 1 gen 6976037 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489871187968
> > [  +0.000001]   item 93 key (15353726451712 169 0) itemoff 13091 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488948097024
> > [  +0.000000]   item 94 key (15353726468096 169 0) itemoff 13058 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490241859584
> > [  +0.000001]   item 95 key (15353726484480 169 0) itemoff 13025 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490382761984
> > [  +0.000001]   item 96 key (15353726500864 169 0) itemoff 12992 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490238582784
> > [  +0.000001]   item 97 key (15353726517248 169 0) itemoff 12959 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490240942080
> > [  +0.000001]   item 98 key (15353726533632 169 0) itemoff 12926 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 99 key (15353726550016 169 0) itemoff 12893 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000000]   item 100 key (15353726582784 169 0) itemoff 12860 itemsize 33
> > [  +0.000002]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490417348608
> > [  +0.000001]   item 101 key (15353726615552 169 0) itemoff 12827 itemsize 33
> > [  +0.000002]           extent refs 1 gen 7325160 flags 2
> > [  +0.000000]           ref#0: tree block backref root 2
> > [  +0.000001]   item 102 key (15353726631936 169 0) itemoff 12794 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490241499136
> > [  +0.000001]   item 103 key (15353726648320 169 0) itemoff 12761 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967712 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15603379503104
> > [  +0.000001]   item 104 key (15353726664704 169 0) itemoff 12728 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490373767168
> > [  +0.000000]   item 105 key (15353726681088 169 0) itemoff 12695 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488951848960
> > [  +0.000001]   item 106 key (15353726697472 169 0) itemoff 12662 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488842190848
> > [  +0.000000]   item 107 key (15353726713856 169 0) itemoff 12629 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490238615552
> > [  +0.000001]   item 108 key (15353726730240 169 0) itemoff 12596 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967712 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489883246592
> > [  +0.000001]   item 109 key (15353726746624 169 0) itemoff 12563 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490375340032
> > [  +0.000001]   item 110 key (15353726763008 169 0) itemoff 12530 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488960925696
> > [  +0.000001]   item 111 key (15353726779392 169 0) itemoff 12497 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488983453696
> > [  +0.000001]   item 112 key (15353726795776 169 0) itemoff 12464 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488860016640
> > [  +0.000001]   item 113 key (15353726812160 169 0) itemoff 12431 itemsize 33
> > [  +0.000002]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488935251968
> > [  +0.000001]   item 114 key (15353726828544 169 0) itemoff 12398 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488944197632
> > [  +0.000001]   item 115 key (15353726844928 169 0) itemoff 12365 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488941985792
> > [  +0.000001]   item 116 key (15353726861312 169 0) itemoff 12332 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490237714432
> > [  +0.000001]   item 117 key (15353726877696 169 0) itemoff 12299 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490247168000
> > [  +0.000001]   item 118 key (15353726894080 169 0) itemoff 12266 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6969114 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662809141248
> > [  +0.000001]   item 119 key (15353726910464 169 0) itemoff 12233 itemsize 33
> > [  +0.000000]           extent refs 1 gen 7144659 flags 2
> > [  +0.000001]           ref#0: tree block backref root 42397
> > [  +0.000001]   item 120 key (15353726926848 169 0) itemoff 12200 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 14665767337984
> > [  +0.000000]   item 121 key (15353726943232 169 0) itemoff 12167 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973537 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517509730304
> > [  +0.000001]   item 122 key (15353726976000 169 0) itemoff 12134 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662809010176
> > [  +0.000000]   item 123 key (15353727008768 169 0) itemoff 12101 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 124 key (15353727041536 169 0) itemoff 12068 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6974758 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517689364480
> > [  +0.000001]   item 125 key (15353727057920 169 0) itemoff 12035 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490248085504
> > [  +0.000001]   item 126 key (15353727074304 169 0) itemoff 12002 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490375618560
> > [  +0.000001]   item 127 key (15353727090688 169 0) itemoff 11969 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490417856512
> > [  +0.000000]   item 128 key (15353727107072 169 0) itemoff 11936 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490244202496
> > [  +0.000001]   item 129 key (15353727123456 169 0) itemoff 11903 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488952356864
> > [  +0.000000]   item 130 key (15353727139840 169 0) itemoff 11870 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490240204800
> > [  +0.000001]   item 131 key (15353727156224 169 0) itemoff 11837 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488990023680
> > [  +0.000001]   item 132 key (15353727172608 169 0) itemoff 11804 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490222428160
> > [  +0.000001]   item 133 key (15353727188992 169 0) itemoff 11771 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6976037 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489896222720
> > [  +0.000001]   item 134 key (15353727205376 169 0) itemoff 11738 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490222624768
> > [  +0.000000]   item 135 key (15353727221760 169 0) itemoff 11705 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488990187520
> > [  +0.000001]   item 136 key (15353727238144 169 0) itemoff 11672 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490245185536
> > [  +0.000001]   item 137 key (15353727254528 169 0) itemoff 11639 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490240253952
> > [  +0.000001]   item 138 key (15353727270912 169 0) itemoff 11606 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14662810386432
> > [  +0.000001]   item 139 key (15353727287296 169 0) itemoff 11573 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6974758 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14661155930112
> > [  +0.000001]   item 140 key (15353727303680 169 0) itemoff 11540 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000000]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 141 key (15353727320064 169 0) itemoff 11507 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490365952000
> > [  +0.000000]   item 142 key (15353727336448 169 0) itemoff 11474 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 143 key (15353727352832 169 0) itemoff 11441 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490239975424
> > [  +0.000001]   item 144 key (15353727369216 169 0) itemoff 11408 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490416398336
> > [  +0.000001]   item 145 key (15353727385600 169 0) itemoff 11375 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14488948260864
> > [  +0.000001]   item 146 key (15353727401984 169 0) itemoff 11342 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975677 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490252328960
> > [  +0.000000]   item 147 key (15353727418368 169 0) itemoff 11309 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490247315456
> > [  +0.000001]   item 148 key (15353727434752 169 0) itemoff 11276 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488935530496
> > [  +0.000000]   item 149 key (15353727451136 169 0) itemoff 11243 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 150 key (15353727467520 169 0) itemoff 11210 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6974758 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 16057712148480
> > [  +0.000001]   item 151 key (15353727483904 169 0) itemoff 11177 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967802 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14489148194816
> > [  +0.000001]   item 152 key (15353727500288 169 0) itemoff 11144 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14662800867328
> > [  +0.000001]   item 153 key (15353727516672 169 0) itemoff 11111 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000000]   item 154 key (15353727533056 169 0) itemoff 11078 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490371440640
> > [  +0.000001]   item 155 key (15353727549440 169 0) itemoff 11045 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490416513024
> > [  +0.000001]   item 156 key (15353727565824 169 0) itemoff 11012 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14488931860480
> > [  +0.000001]   item 157 key (15353727582208 169 0) itemoff 10979 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6969564 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15493588500480
> > [  +0.000001]   item 158 key (15353727614976 169 0) itemoff 10946 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490399064064
> > [  +0.000000]   item 159 key (15353727631360 169 0) itemoff 10913 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 160 key (15353727647744 169 0) itemoff 10880 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490252001280
> > [  +0.000000]   item 161 key (15353727664128 169 0) itemoff 10847 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490358923264
> > [  +0.000001]   item 162 key (15353727680512 169 0) itemoff 10814 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973852 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14489511919616
> > [  +0.000001]   item 163 key (15353727696896 169 0) itemoff 10781 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14490408747008
> > [  +0.000001]   item 164 key (15353727713280 169 0) itemoff 10748 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14490235289600
> > [  +0.000001]   item 165 key (15353727729664 169 0) itemoff 10706 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 1140559929556992
> > [  +0.000000]           ref#1: shared block backref parent 14488837406720
> > [  +0.000001]   item 166 key (15353727746048 169 0) itemoff 10664 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6976256 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517470031872
> > [  +0.000001]           ref#1: shared block backref parent 14490542309376
> > [  +0.000000]   item 167 key (15353727762432 169 0) itemoff 10622 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15350897311744
> > [  +0.000001]           ref#1: shared block backref parent 14490375929856
> > [  +0.000001]   item 168 key (15353727778816 169 0) itemoff 10589 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6974758 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14661155930112
> > [  +0.000001]   item 169 key (15353727795200 169 0) itemoff 10547 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15351039606784
> > [  +0.000001]           ref#1: shared block backref parent 14490250330112
> > [  +0.000000]   item 170 key (15353727811584 169 0) itemoff 10505 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517268918272
> > [  +0.000001]           ref#1: shared block backref parent 14488937119744
> > [  +0.000001]   item 171 key (15353727827968 169 0) itemoff 10463 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517272309760
> > [  +0.000001]           ref#1: shared block backref parent 14488934105088
> > [  +0.000001]   item 172 key (15353727860736 169 0) itemoff 10430 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 14662802079744
> > [  +0.000001]   item 173 key (15353727877120 169 0) itemoff 10388 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15351074078720
> > [  +0.000001]           ref#1: shared block backref parent 14490241236992
> > [  +0.000000]   item 174 key (15353727893504 169 0) itemoff 10346 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15351016357888
> > [  +0.000001]           ref#1: shared block backref parent 14488857247744
> > [  +0.000001]   item 175 key (15353727909888 169 0) itemoff 10304 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15351051993088
> > [  +0.000001]           ref#1: shared block backref parent 14490219331584
> > [  +0.000001]   item 176 key (15353727926272 169 0) itemoff 10262 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6973537 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517502046208
> > [  +0.000001]           ref#1: shared block backref parent 14489130483712
> > [  +0.000001]   item 177 key (15353727942656 169 0) itemoff 10220 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517259825152
> > [  +0.000000]           ref#1: shared block backref parent 14490417889280
> > [  +0.000001]   item 178 key (15353727959040 169 0) itemoff 10187 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6969360 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662434062336
> > [  +0.000001]   item 179 key (15353727975424 169 0) itemoff 10145 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15350977789952
> > [  +0.000001]           ref#1: shared block backref parent 14490240860160
> > [  +0.000001]   item 180 key (15353728008192 169 0) itemoff 10103 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517268639744
> > [  +0.000000]           ref#1: shared block backref parent 14488934760448
> > [  +0.000001]   item 181 key (15353728024576 169 0) itemoff 10061 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15350974939136
> > [  +0.000001]           ref#1: shared block backref parent 14490251264000
> > [  +0.000000]   item 182 key (15353728057344 169 0) itemoff 10028 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967802 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 16058580140032
> > [  +0.000001]   item 183 key (15353728073728 169 0) itemoff 9986 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15350972956672
> > [  +0.000001]           ref#1: shared block backref parent 14490244694016
> > [  +0.000001]   item 184 key (15353728090112 169 0) itemoff 9953 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 14665767337984
> > [  +0.000001]   item 185 key (15353728106496 169 0) itemoff 9911 itemsize 42
> > [  +0.000000]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15517267525632
> > [  +0.000001]           ref#1: shared block backref parent 14490397294592
> > [  +0.000001]   item 186 key (15353728122880 169 0) itemoff 9869 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15351048683520
> > [  +0.000001]           ref#1: shared block backref parent 14490246283264
> > [  +0.000001]   item 187 key (15353728139264 169 0) itemoff 9827 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15350996107264
> > [  +0.000000]           ref#1: shared block backref parent 14490246676480
> > [  +0.000001]   item 188 key (15353728155648 169 0) itemoff 9794 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973294 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15451197095936
> > [  +0.000001]   item 189 key (15353728172032 169 0) itemoff 9752 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15350978117632
> > [  +0.000001]           ref#1: shared block backref parent 14490367754240
> > [  +0.000001]   item 190 key (15353728204800 169 0) itemoff 9710 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15350914547712
> > [  +0.000001]           ref#1: shared block backref parent 14488850366464
> > [  +0.000001]   item 191 key (15353728221184 169 0) itemoff 9677 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6975470 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662813384704
> > [  +0.000000]   item 192 key (15353728237568 169 0) itemoff 9635 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 15351101833216
> > [  +0.000001]           ref#1: shared block backref parent 14490385612800
> > [  +0.000001]   item 193 key (15353728253952 169 0) itemoff 9602 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6973537 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517504094208
> > [  +0.000001]   item 194 key (15353728270336 169 0) itemoff 9569 itemsize 33
> > [  +0.000001]           extent refs 1 gen 7149840 flags 2
> > [  +0.000001]           ref#0: shared block backref parent 15393060175872
> > [  +0.000001]   item 195 key (15353728286720 169 0) itemoff 9527 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15517258514432
> > [  +0.000001]           ref#1: shared block backref parent 14489000230912
> > [  +0.000001]   item 196 key (15353728303104 169 0) itemoff 9485 itemsize 42
> > [  +0.000001]           extent refs 2 gen 6975244 flags 258
> > [  +0.000000]           ref#0: shared block backref parent 15523042508800
> > [  +0.000001]           ref#1: shared block backref parent 14490375569408
> > [  +0.000001]   item 197 key (15353728319488 169 0) itemoff 9452 itemsize 33
> > [  +0.000001]           extent refs 1 gen 6967802 flags 258
> > [  +0.000001]           ref#0: shared block backref parent 14662429999104
> > [  +0.000001] BTRFS error (device nvme0n1p1): unable to find ref byte nr 15353727729664 parent 14660022714368 root 18446744073709551608  owner 0 offset 0
> > [  +0.000005] ------------[ cut here ]------------
> > [  +0.000000] BTRFS: Transaction aborted (error -2)
> > [  +0.000008] WARNING: CPU: 18 PID: 25283 at fs/btrfs/extent-tree.c:3055 __btrfs_free_extent+0x730/0x920 [btrfs]
> > [  +0.000033] Modules linked in: qrtr ns af_packet intel_rapl_msr edac_mce_amd edac_core intel_rapl_common kvm_amd kvm irqbypass btrfs crc32_pclmul wmi_bmof snd_hda_codec_realtek ghash_clmulni_intel aesni_intel nouveau blake2b_generic crypto_simd xor snd_hda_codec_hdmi rt2800usb snd_hda_codec_generic btusb ledtrig_audio snd_hda_intel iwlmvm cryptd rt2x00usb mxm_wmi zstd_compress btrtl snd_intel_dspcfg snd_intel_sdw_acpi rt2800lib rt2x00lib video snd_hda_codec btbcm snd_hda_core btintel snd_hwdep mac80211 iwlwifi drm_ttm_helper ttm mousedev libarc4 bluetooth drm_kms_helper igb evdev joydev input_leds snd_pcm fb_sys_fops sp5100_tco mac_hid ecdh_generic corsair_psu syscopyarea ecc sysfillrect cfg80211 rapl raid6_pq snd_timer sysimgblt ptp crc16 watchdog pps_core libaes deflate snd dca i2c_algo_bit led_class rfkill efi_pstore tpm_crb soundcore i2c_piix4 k10temp tpm_tis tpm_tis_core gpio_amdpt tpm pinctrl_amd gpio_generic rng_core tiny_power_button i2c_designware_platform wmi
> > [  +0.000034]  i2c_designware_core button acpi_cpufreq ip6_tables xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp ip6t_rpfilter ipt_rpfilter xt_pkttype nft_compat nft_counter nf_tables libcrc32c crc32c_generic nfnetlink sch_fq_codel ctr atkbd libps2 serio zfs(PO) zunicode(PO) zzstd(O) zlua(O) zavl(PO) icp(PO) zcommon(PO) znvpair(PO) spl(O) tun tap macvlan drm bridge stp llc agpgart backlight fuse i2c_core pstore configfs efivarfs ip_tables x_tables autofs4 squashfs isofs uas usb_storage hid_generic usbhid hid sr_mod sd_mod cdrom xhci_pci xhci_pci_renesas xhci_hcd ahci nvme libahci usbcore crc32c_intel nvme_core libata t10_pi crc_t10dif crct10dif_generic crct10dif_pclmul crct10dif_common usb_common rtc_cmos dm_mod nls_iso8859_1 nls_cp437 vfat fat vmw_pvscsi scsi_mod scsi_common overlay loop
> > [  +0.000033] CPU: 18 PID: 25283 Comm: btrfs-transacti Tainted: P        W  O      5.15.79 #1-NixOS
> > [  +0.000002] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X399 Taichi, BIOS P3.90 12/04/2019
> > [  +0.000000] RIP: 0010:__btrfs_free_extent+0x730/0x920 [btrfs]
> > [  +0.000024] Code: 48 05 50 0a 00 00 f0 48 0f ba 28 03 0f 92 c0 41 58 84 c0 0f 85 ba 63 0b 00 be fe ff ff ff 48 c7 c7 00 dc e6 c1 e8 0c df 2d f9 <0f> 0b e9 a2 63 0b 00 c7 44 24 14 f4 ff ff ff e9 c8 fc ff ff 0f 1f
> > [  +0.000001] RSP: 0018:ffffb7655b48bc60 EFLAGS: 00010286
> > [  +0.000002] RAX: 0000000000000000 RBX: 00000d554d724000 RCX: 0000000000000027
> > [  +0.000001] RDX: ffff98c23ed9c648 RSI: 0000000000000001 RDI: ffff98c23ed9c640
> > [  +0.000001] RBP: 00000df6d17cc000 R08: 0000000000000000 R09: ffffb7655b48ba90
> > [  +0.000001] R10: ffffb7655b48ba88 R11: ffff98c27fdfdfe8 R12: 00000000fffffffe
> > [  +0.000001] R13: ffff98b287fcb070 R14: ffff98b30f295380 R15: fffffffffffffff8
> > [  +0.000001] FS:  0000000000000000(0000) GS:ffff98c23ed80000(0000) knlGS:0000000000000000
> > [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0.000001] CR2: 00007f6900045eb0 CR3: 000000039e4ae000 CR4: 00000000003506e0
> > [  +0.000001] Call Trace:
> > [  +0.000001]  <TASK>
> > [  +0.000001]  ? btrfs_merge_delayed_refs+0x241/0x280 [btrfs]
> > [  +0.000032]  __btrfs_run_delayed_refs+0x25d/0x1040 [btrfs]
> > [  +0.000025]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> > [  +0.000024]  btrfs_commit_transaction+0x60/0xb00 [btrfs]
> > [  +0.000025]  ? start_transaction+0xce/0x5a0 [btrfs]
> > [  +0.000025]  ? usleep_range_state+0x80/0x90
> > [  +0.000002]  transaction_kthread+0x12f/0x1a0 [btrfs]
> > [  +0.000025]  ? btrfs_cleanup_transaction.isra.0+0x580/0x580 [btrfs]
> > [  +0.000026]  kthread+0x127/0x150
> > [  +0.000002]  ? set_kthread_struct+0x50/0x50
> > [  +0.000002]  ret_from_fork+0x22/0x30
> > [  +0.000003]  </TASK>
> > [  +0.000001] ---[ end trace 97a30a2b1a52a637 ]---
> > [  +0.000002] BTRFS: error (device nvme0n1p1) in __btrfs_free_extent:3055: errno=-2 No such entry
> > [  +0.000003] BTRFS info (device nvme0n1p1): forced readonly
> > [  +0.000003] BTRFS: error (device nvme0n1p1) in btrfs_run_delayed_refs:2149: errno=-2 No such entry
> > [Dec 1 22:50] BTRFS info (device nvme0n1p1): scrub: finished on devid 3 with status: 0
> > [Dec 1 22:52] BTRFS info (device nvme0n1p1): scrub: finished on devid 4 with status: 0
> > [  +3.928883] BTRFS info (device nvme0n1p1): scrub: finished on devid 1 with status: 0
> > ```
> > 
> > Nate
> > 
> > On Thu, Dec 1, 2022, at 1:14 PM, Remi Gauvin wrote:
> >> On 2022-12-01 1:52 p.m., Goffredo Baroncelli wrote:
> >>
> >>>> [99537.333018] BTRFS info (device nvme0n1p1): bdev /dev/nvme0n1p1
> >>>> errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> >>>> [99537.333023] BTRFS info (device nvme0n1p1): bdev /dev/nvme1n1p1
> >>>> errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> >>>
> >>>
> >>>
> >>> I am not sure how is related; but from the above excerpt of dmesg, I see
> >>> that both nvme0 and nvme1 have errors (== corruption). If this is true,
> >>> raid1 is not enough to protect against these.
> >>>
> >>>
> >>
> >> What sticks out to me is that they both end up with the same reported
> >> number of corrupted errors,,, that would lead me to think that the
> >> corruption is not happening on the storage device but in memory while in
> >> flight.).
> >>
> >> I would start with a burn in memory test,, though more experienced
> >> members of this list can probably identify bitflip error in the CRC from
> >> the btrfs check output
> >>
> >>
> 
