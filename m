Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5636EEF57
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbjDZHf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 03:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbjDZHf4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 03:35:56 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40F2D4E
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 00:35:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DB075C0185
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 03:35:48 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Wed, 26 Apr 2023 03:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682494548; x=1682580948; bh=2b
        L1PpufE5jZq+dZxFl4ezqgGZJNsiUYhvAOCmH9iOA=; b=jkYXab+HMLYGAhwc9N
        vQ+5mi3jeAlzFzXXnrjGpm3PizQzt425Sv3x2z1HXSAm71KlxPnvmXxCe5AoFP2p
        tgb0ujzueh3fyyAwsJ2sCrA6NUYOZogFd35U9FQoZXOllk6Z2qDXNaxYt/AIZrac
        3exW5tzpPUlbQrNKuG5GnySoO7/rTDQhnI/NA3mUpXqyUYDSSt4HbrV4vjdm1h0Y
        UMejvQr/TSSgvQqBT4XO0sythLHkx8JBgZiCkbALrd3bSqVLsxT0gqvwull/bUby
        XSv2o1pk2mMmDC6palBpCMLLtPECspoTsy0M93gvqZTuGxC9ZoT0TlqiB71BGTmj
        v+zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682494548; x=1682580948; bh=2bL1PpufE5jZq
        +dZxFl4ezqgGZJNsiUYhvAOCmH9iOA=; b=Pp2ky27t4yuzPqTVxK6zL8w7Hyil7
        9NW4n5N6DpcIJxXEpJac2dRAkbef2ZENmcvhtTgkcHeFW3djIK+LaKuEgbyE9chG
        53r5riKbq8KZJW66Rl/GpO59rcY0wMZx31JOrtMpCoiXfBrsWItsT63aMCXc2IJJ
        a5pBTgCN+0WMiOJx/9/qcPrlUiWu2+1d770x6+1hYQp6UyA8GiT3l/XMZXkRY+/v
        QVL/YASd7NXrS4rsKsEGrShchl8ju86rDexDBfT94zP8xyUCpl5gcUS0T0gjfmkx
        hAhUpHqOFNwFbITemENxuM/uNbvy/sZGfvaC/R4vvJMCOtARhVjEvi2gQ==
X-ME-Sender: <xms:VNRIZGKsfZvcHeB2r8YkOwohJSufBgpP3Em_MrBs8kTVOOx_8liP8Q>
    <xme:VNRIZOKNsEuBP71Ac2njb8C2eWXsYNwSsPpAHZMqujz6arqwmfQuldlS-phO1T3q5
    FqNMoJga30dowRbCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedufedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgfgsehtqh
    ertderreejnecuhfhrohhmpefnrghurhgvnhhtihhuucfpihgtohhlrgcuoehlnhhitgho
    lhgrseguvghnugdrrhhoqeenucggtffrrghtthgvrhhnpeevfedtfeeijeeuffefueetje
    ehledvkeejudehgfdukeffffehledutdfguefgteenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:VNRIZGvNXZlNURdD08NQYLIOyJI4gj-o7U7vJlzwCFqFho3LLvE_3g>
    <xmx:VNRIZLYEBgGSv6BD9mvPnDN6SWtvA61GUFpHneb762l_UnCR3ISWiA>
    <xmx:VNRIZNZJ1z-9jqKWp4KSduR412hGH2Y8qPPeC8qMixzX6wuyjoJVjA>
    <xmx:VNRIZGmBvm2-EPpk6rCFeowytRuKW5pAmPDdbNGTrSVo4jH2a06qfA>
Feedback-ID: ic7f8409e:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 086901700089; Wed, 26 Apr 2023 03:35:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
Date:   Wed, 26 Apr 2023 10:35:26 +0300
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     linux-btrfs@vger.kernel.org
Subject: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction ->
 btrfs_run_delayed_refs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I decided to give btrfs a try, converted my existing ext4 partition and =
used it for about two weeks, until it crashed out of the blue and remoun=
ted itself read-only with an "unable to find ref byte nr 696367414912 pa=
rent 0 root 10 owner 0 offset 0" message. This was on 6.2.8, on Arch Lin=
ux (a pretty vanilla kernel AFAICT).

I was able to boot from a live image, mount it with rescue=3Dnologreplay=
 and recover my data, but it seems like a good idea to report it nonethe=
less. This is the error I got from the live image (I have some photos fr=
om when it crashed, they're showing something pretty similar):

[   61.001188] BTRFS info (device nvme0n1p5): using xxhash64 (xxhash64-g=
eneric) checksum algorithm
[   61.001193] BTRFS info (device nvme0n1p5): using free space tree
[   61.004406] BTRFS info (device nvme0n1p5): enabling ssd optimizations
[   61.004409] BTRFS info (device nvme0n1p5): auto enabling async discard
[   61.004410] BTRFS info (device nvme0n1p5): start tree-log replay
[   61.328588] ------------[ cut here ]------------
[   61.328590] WARNING: CPU: 25 PID: 3090 at fs/btrfs/extent-tree.c:3068=
 __btrfs_free_extent+0x57d/0x820
[   61.328594] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtime=
r nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ip=
v4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nf=
t_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defr=
ag_ipv4 ip_set nf_tables nfnetlink qrtr bnep binfmt_misc amdgpu iwlmvm m=
ac80211 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi s=
nd_usb_audio snd_hda_intel snd_intel_dspcfg snd_usbmidi_lib snd_intel_sd=
w_acpi libarc4 snd_hda_codec snd_rawmidi iommu_v2 mc btusb snd_hda_core =
joydev drm_buddy apple_mfi_fastcharge gpu_sched btrtl snd_hwdep iwlwifi =
snd_seq drm_ttm_helper btbcm ttm intel_rapl_msr btintel snd_seq_device i=
ntel_rapl_common snd_pcm drm_display_helper btmtk cfg80211 edac_mce_amd =
cec snd_timer bluetooth snd kvm_amd eeepc_wmi soundcore asus_wmi kvm led=
trig_audio i2c_piix4 sparse_keymap k10temp platform_profile irqbypass rf=
kill video rapl pcspkr gpio_amdpt wmi_bmof gpio_generic acpi_cpufreq
[   61.328623]  zram isofs squashfs hid_apple nvme crct10dif_pclmul crc3=
2_pclmul crc32c_intel polyval_clmulni polyval_generic uas ucsi_ccg nvme_=
core igc typec_ucsi ccp ghash_clmulni_intel usb_storage sha512_ssse3 typ=
ec sp5100_tco nvme_common wmi sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb=
4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_=
tcp libiscsi_tcp libiscsi scsi_transport_iscsi loop ip6_tables ip_tables=
 fuse
[   61.328639] CPU: 25 PID: 3090 Comm: mount Not tainted 6.2.2-301.fc38.=
x86_64 #1
[   61.328640] Hardware name: ASUS System Product Name/ROG STRIX B550-F =
GAMING (WI-FI), BIOS 2806 10/27/2022
[   61.328641] RIP: 0010:__btrfs_free_extent+0x57d/0x820
[   61.328643] Code: 0f 86 a9 20 95 00 48 8d 70 7d ba 11 00 00 00 4c 89 =
f7 e8 16 8e 03 00 0f b6 c0 48 39 e8 0f 84 e8 fd ff ff 0f 0b e9 e1 fd ff =
ff <0f> 0b 49 8b 3f e8 49 53 00 00 49 89 e9 4d 89 f0 48 89 da 41 55 48
[   61.328644] RSP: 0018:ffffb75294247770 EFLAGS: 00010246
[   61.328645] RAX: 00000000fffffffe RBX: 000000a180030000 RCX: 00000000=
00000001
[   61.328646] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff8fb2=
02484900
[   61.328646] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000=
00000001
[   61.328646] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000=
00000001
[   61.328647] R13: 0000000000000000 R14: 000000000000000a R15: ffff8fb2=
00b84cb0
[   61.328648] FS:  00007f04b7811800(0000) GS:ffff8fc0af040000(0000) knl=
GS:0000000000000000
[   61.328648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.328649] CR2: 00007f811d614008 CR3: 000000013ba80000 CR4: 00000000=
00750ee0
[   61.328650] PKRU: 55555554
[   61.328650] Call Trace:
[   61.328651]  <TASK>
[   61.328653]  ? btrfs_old_root_level+0x21/0x80
[   61.328656]  __btrfs_run_delayed_refs+0x2bd/0x1070
[   61.328658]  ? _raw_spin_unlock+0x15/0x30
[   61.328660]  ? release_extent_buffer+0x16f/0x1b0
[   61.328662]  ? btrfs_release_path+0x13/0x70
[   61.328664]  btrfs_run_delayed_refs+0x5e/0x1b0
[   61.328666]  btrfs_start_dirty_block_groups+0x307/0x540
[   61.328667]  ? btrfs_run_delayed_refs+0x5e/0x1b0
[   61.328669]  btrfs_commit_transaction+0xb0/0xc60
[   61.328671]  btrfs_recover_log_trees+0x3a9/0x460
[   61.328672]  ? __pfx_replay_one_buffer+0x10/0x10
[   61.328675]  open_ctree+0xfb1/0x1475
[   61.328678]  btrfs_mount_root.cold+0xe/0x93
[   61.328680]  legacy_get_tree+0x27/0x50
[   61.328682]  vfs_get_tree+0x25/0xc0
[   61.328684]  vfs_kern_mount.part.0+0x73/0xb0
[   61.328686]  btrfs_mount+0x149/0x3d0
[   61.328688]  ? cred_has_capability.isra.0+0xb3/0x160
[   61.328690]  legacy_get_tree+0x27/0x50
[   61.328691]  vfs_get_tree+0x25/0xc0
[   61.328692]  path_mount+0x48a/0xac0
[   61.328694]  __x64_sys_mount+0x116/0x150
[   61.328695]  do_syscall_64+0x5b/0x80
[   61.328697]  ? do_faccessat+0x139/0x280
[   61.328699]  ? syscall_exit_to_user_mode+0x17/0x40
[   61.328701]  ? do_syscall_64+0x67/0x80
[   61.328702]  ? syscall_exit_to_user_mode+0x17/0x40
[   61.328704]  ? do_syscall_64+0x67/0x80
[   61.328705]  ? syscall_exit_to_user_mode+0x17/0x40
[   61.328707]  ? do_syscall_64+0x67/0x80
[   61.328708]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   61.328710] RIP: 0033:0x7f04b79fbc9e
[   61.328726] Code: 48 8b 0d 6d 11 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3a 11 0c 00 f7 d8 64 89 01 48
[   61.328726] RSP: 002b:00007ffc85675ad8 EFLAGS: 00000246 ORIG_RAX: 000=
00000000000a5
[   61.328727] RAX: ffffffffffffffda RBX: 0000562d61918550 RCX: 00007f04=
b79fbc9e
[   61.328728] RDX: 0000562d6191f010 RSI: 0000562d619187e0 RDI: 0000562d=
61918780
[   61.328728] RBP: 00007ffc85675c00 R08: 0000000000000000 R09: 00000000=
00000001
[   61.328729] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000=
00000000
[   61.328729] R13: 0000562d61918780 R14: 0000562d6191f010 R15: 00007f04=
b7b2c076
[   61.328731]  </TASK>
[   61.328731] ---[ end trace 0000000000000000 ]---
[   61.328732] BTRFS info (device nvme0n1p5): leaf 693351944192 gen 5667=
4 total ptrs 269 free space 681 owner 2
[   61.328733] 	item 0 key (693633847296 169 0) itemoff 16250 itemsize 33
[   61.328734] 		extent refs 1 gen 56673 flags 2
[   61.328735] 		ref#0: tree block backref root 2
[snip 267 items]
[   61.329087] 	item 268 key (693638418432 169 0) itemoff 7406 itemsize =
33
[   61.329088] 		extent refs 1 gen 56673 flags 2
[   61.329089] 		ref#0: tree block backref root 2
[   61.329089] BTRFS error (device nvme0n1p5): unable to find ref byte n=
r 693637414912 parent 0 root 10  owner 0 offset 0
[   61.329090] ------------[ cut here ]------------
[   61.329091] BTRFS: Transaction aborted (error -2)
[   61.329093] WARNING: CPU: 25 PID: 3090 at fs/btrfs/extent-tree.c:3074=
 __btrfs_free_extent.cold+0x92f/0x9ae
[   61.329095] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtime=
r nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ip=
v4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nf=
t_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defr=
ag_ipv4 ip_set nf_tables nfnetlink qrtr bnep binfmt_misc amdgpu iwlmvm m=
ac80211 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi s=
nd_usb_audio snd_hda_intel snd_intel_dspcfg snd_usbmidi_lib snd_intel_sd=
w_acpi libarc4 snd_hda_codec snd_rawmidi iommu_v2 mc btusb snd_hda_core =
joydev drm_buddy apple_mfi_fastcharge gpu_sched btrtl snd_hwdep iwlwifi =
snd_seq drm_ttm_helper btbcm ttm intel_rapl_msr btintel snd_seq_device i=
ntel_rapl_common snd_pcm drm_display_helper btmtk cfg80211 edac_mce_amd =
cec snd_timer bluetooth snd kvm_amd eeepc_wmi soundcore asus_wmi kvm led=
trig_audio i2c_piix4 sparse_keymap k10temp platform_profile irqbypass rf=
kill video rapl pcspkr gpio_amdpt wmi_bmof gpio_generic acpi_cpufreq
[   61.329114]  zram isofs squashfs hid_apple nvme crct10dif_pclmul crc3=
2_pclmul crc32c_intel polyval_clmulni polyval_generic uas ucsi_ccg nvme_=
core igc typec_ucsi ccp ghash_clmulni_intel usb_storage sha512_ssse3 typ=
ec sp5100_tco nvme_common wmi sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb=
4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_=
tcp libiscsi_tcp libiscsi scsi_transport_iscsi loop ip6_tables ip_tables=
 fuse
[   61.329124] CPU: 25 PID: 3090 Comm: mount Tainted: G        W        =
  6.2.2-301.fc38.x86_64 #1
[   61.329125] Hardware name: ASUS System Product Name/ROG STRIX B550-F =
GAMING (WI-FI), BIOS 2806 10/27/2022
[   61.329125] RIP: 0010:__btrfs_free_extent.cold+0x92f/0x9ae
[   61.329126] Code: ff be ea ff ff ff 48 c7 c7 08 f5 8b bd e8 c1 8f fe =
ff 0f 0b e9 0c fe ff ff be fe ff ff ff 48 c7 c7 08 f5 8b bd e8 a9 8f fe =
ff <0f> 0b eb a5 89 df e8 46 ef ff ff 84 c0 75 5e 48 8b 44 24 08 89 da
[   61.329127] RSP: 0018:ffffb75294247770 EFLAGS: 00010286
[   61.329128] RAX: 0000000000000000 RBX: 000000a180030000 RCX: 00000000=
00000000
[   61.329128] RDX: 0000000000000001 RSI: 0000000000000027 RDI: 00000000=
ffffffff
[   61.329129] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb752=
94247608
[   61.329129] R10: 0000000000000003 R11: ffffffffbe1447c8 R12: 00000000=
00000001
[   61.329130] R13: 0000000000000000 R14: 000000000000000a R15: ffff8fb2=
00b84cb0
[   61.329130] FS:  00007f04b7811800(0000) GS:ffff8fc0af040000(0000) knl=
GS:0000000000000000
[   61.329131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.329132] CR2: 00007f811d614008 CR3: 000000013ba80000 CR4: 00000000=
00750ee0
[   61.329132] PKRU: 55555554
[   61.329133] Call Trace:
[   61.329133]  <TASK>
[   61.329134]  ? btrfs_old_root_level+0x21/0x80
[   61.329135]  __btrfs_run_delayed_refs+0x2bd/0x1070
[   61.329137]  ? _raw_spin_unlock+0x15/0x30
[   61.329138]  ? release_extent_buffer+0x16f/0x1b0
[   61.329140]  ? btrfs_release_path+0x13/0x70
[   61.329142]  btrfs_run_delayed_refs+0x5e/0x1b0
[   61.329143]  btrfs_start_dirty_block_groups+0x307/0x540
[   61.329144]  ? btrfs_run_delayed_refs+0x5e/0x1b0
[   61.329145]  btrfs_commit_transaction+0xb0/0xc60
[   61.329147]  btrfs_recover_log_trees+0x3a9/0x460
[   61.329148]  ? __pfx_replay_one_buffer+0x10/0x10
[   61.329150]  open_ctree+0xfb1/0x1475
[   61.329152]  btrfs_mount_root.cold+0xe/0x93
[   61.329153]  legacy_get_tree+0x27/0x50
[   61.329154]  vfs_get_tree+0x25/0xc0
[   61.329156]  vfs_kern_mount.part.0+0x73/0xb0
[   61.329157]  btrfs_mount+0x149/0x3d0
[   61.329158]  ? cred_has_capability.isra.0+0xb3/0x160
[   61.329160]  legacy_get_tree+0x27/0x50
[   61.329161]  vfs_get_tree+0x25/0xc0
[   61.329162]  path_mount+0x48a/0xac0
[   61.329164]  __x64_sys_mount+0x116/0x150
[   61.329165]  do_syscall_64+0x5b/0x80
[   61.329167]  ? do_faccessat+0x139/0x280
[   61.329168]  ? syscall_exit_to_user_mode+0x17/0x40
[   61.329170]  ? do_syscall_64+0x67/0x80
[   61.329171]  ? syscall_exit_to_user_mode+0x17/0x40
[   61.329172]  ? do_syscall_64+0x67/0x80
[   61.329174]  ? syscall_exit_to_user_mode+0x17/0x40
[   61.329175]  ? do_syscall_64+0x67/0x80
[   61.329177]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   61.329178] RIP: 0033:0x7f04b79fbc9e
[   61.329180] Code: 48 8b 0d 6d 11 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 =
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 3a 11 0c 00 f7 d8 64 89 01 48
[   61.329181] RSP: 002b:00007ffc85675ad8 EFLAGS: 00000246 ORIG_RAX: 000=
00000000000a5
[   61.329182] RAX: ffffffffffffffda RBX: 0000562d61918550 RCX: 00007f04=
b79fbc9e
[   61.329182] RDX: 0000562d6191f010 RSI: 0000562d619187e0 RDI: 0000562d=
61918780
[   61.329183] RBP: 00007ffc85675c00 R08: 0000000000000000 R09: 00000000=
00000001
[   61.329183] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000=
00000000
[   61.329183] R13: 0000562d61918780 R14: 0000562d6191f010 R15: 00007f04=
b7b2c076
[   61.329185]  </TASK>
[   61.329185] ---[ end trace 0000000000000000 ]---
[   61.329186] BTRFS: error (device nvme0n1p5: state A) in __btrfs_free_=
extent:3074: errno=3D-2 No such entry
[   61.329188] BTRFS error (device nvme0n1p5: state EA): failed to run d=
elayed ref for logical 693637414912 num_bytes 16384 type 176 action 2 re=
f_mod 1: -2
[   61.329190] BTRFS: error (device nvme0n1p5: state EA) in btrfs_run_de=
layed_refs:2151: errno=3D-2 No such entry
[   61.329192] BTRFS: error (device nvme0n1p5: state EA) in btrfs_replay=
_log:2479: errno=3D-2 No such entry (Failed to recover log tree)
[   61.342111] BTRFS error (device nvme0n1p5: state EA): open_ctree fail=
ed

I also ran btrfs check and it spewed hundreds of thousands of messages l=
ike:

WARNING: tree block [693902610432, 693902626816) is not nodesize aligned=
, may cause problem for 64K page system

, then:

ref mismatch on [634543001600 16384] extent item 0, found 1
tree extent[634543001600, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543001600 16384]
ref mismatch on [634543017984 16384] extent item 0, found 1
tree extent[634543017984, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543017984 16384]
ref mismatch on [634543034368 16384] extent item 0, found 1
tree extent[634543034368, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543034368 16384]
ref mismatch on [634543050752 16384] extent item 0, found 1
tree extent[634543050752, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543050752 16384]
ref mismatch on [634543067136 16384] extent item 0, found 1
tree extent[634543067136, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543067136 16384]
ref mismatch on [634543083520 16384] extent item 0, found 1
tree extent[634543083520, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543083520 16384]
ref mismatch on [634543099904 16384] extent item 0, found 1
tree extent[634543099904, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543099904 16384]
ref mismatch on [634543116288 16384] extent item 0, found 1
tree extent[634543116288, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543116288 16384]
ref mismatch on [634543132672 16384] extent item 0, found 1
tree extent[634543132672, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543132672 16384]
ref mismatch on [634543149056 16384] extent item 0, found 1
tree extent[634543149056, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543149056 16384]
ref mismatch on [634543165440 16384] extent item 0, found 1
tree extent[634543165440, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543165440 16384]
ref mismatch on [634543181824 16384] extent item 0, found 1
tree extent[634543181824, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543181824 16384]
ref mismatch on [634543198208 16384] extent item 0, found 1
tree extent[634543198208, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543198208 16384]
ref mismatch on [634543214592 16384] extent item 0, found 1
tree extent[634543214592, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543214592 16384]
ref mismatch on [634543230976 16384] extent item 0, found 1
tree extent[634543230976, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543230976 16384]
ref mismatch on [634543247360 16384] extent item 0, found 1
tree extent[634543247360, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543247360 16384]
ref mismatch on [634543263744 16384] extent item 0, found 1
tree extent[634543263744, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543263744 16384]
ref mismatch on [634543280128 16384] extent item 0, found 1
tree extent[634543280128, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543280128 16384]
ref mismatch on [634543296512 16384] extent item 0, found 1
tree extent[634543296512, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543296512 16384]
ref mismatch on [634543312896 16384] extent item 0, found 1
tree extent[634543312896, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543312896 16384]
ref mismatch on [634543329280 16384] extent item 0, found 1
tree extent[634543329280, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543329280 16384]
ref mismatch on [634543345664 16384] extent item 0, found 1
tree extent[634543345664, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543345664 16384]
ref mismatch on [634543362048 16384] extent item 0, found 1
tree extent[634543362048, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543362048 16384]
ref mismatch on [634543378432 16384] extent item 0, found 1
tree extent[634543378432, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543378432 16384]
ref mismatch on [634543394816 16384] extent item 0, found 1
tree extent[634543394816, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543394816 16384]
ref mismatch on [634543411200 16384] extent item 0, found 1
tree extent[634543411200, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543411200 16384]
ref mismatch on [634543427584 16384] extent item 0, found 1
tree extent[634543427584, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543427584 16384]
ref mismatch on [634543443968 16384] extent item 0, found 1
tree extent[634543443968, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543443968 16384]
ref mismatch on [634543460352 16384] extent item 0, found 1
tree extent[634543460352, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543460352 16384]
ref mismatch on [634543476736 16384] extent item 0, found 1
tree extent[634543476736, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543476736 16384]
ref mismatch on [634543493120 16384] extent item 0, found 1
tree extent[634543493120, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543493120 16384]
ref mismatch on [634543509504 16384] extent item 0, found 1
tree extent[634543509504, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543509504 16384]
ref mismatch on [634543525888 16384] extent item 0, found 1
tree extent[634543525888, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543525888 16384]
ref mismatch on [634543542272 16384] extent item 0, found 1
tree extent[634543542272, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543542272 16384]
ref mismatch on [634543558656 16384] extent item 0, found 1
tree extent[634543558656, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543558656 16384]
ref mismatch on [634543575040 16384] extent item 0, found 1
tree extent[634543575040, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543575040 16384]
ref mismatch on [634543591424 16384] extent item 0, found 1
tree extent[634543591424, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543591424 16384]
ref mismatch on [634543607808 16384] extent item 0, found 1
tree extent[634543607808, 16384] root 7 has no backref item in extent tr=
ee
backpointer mismatch on [634543607808 16384]
ref mismatch on [634543624192 16384] extent item 0, found 1
tree extent[634543624192, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543624192 16384]
ref mismatch on [634543640576 16384] extent item 0, found 1
tree extent[634543640576, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543640576 16384]
ref mismatch on [634543656960 16384] extent item 0, found 1
tree extent[634543656960, 16384] root 257 has no backref item in extent =
tree
backpointer mismatch on [634543656960 16384]
ref mismatch on [634543673344 16384] extent item 0, found 1
tree extent[634543673344, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543673344 16384]
ref mismatch on [634543689728 16384] extent item 0, found 1
tree extent[634543689728, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543689728 16384]
ref mismatch on [634543722496 16384] extent item 0, found 1
tree extent[634543722496, 16384] root 257 has no backref item in extent =
tree
backpointer mismatch on [634543722496 16384]
ref mismatch on [634543738880 16384] extent item 0, found 1
tree extent[634543738880, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543738880 16384]
ref mismatch on [634543755264 16384] extent item 0, found 1
tree extent[634543755264, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543755264 16384]
ref mismatch on [634543771648 16384] extent item 0, found 1
tree extent[634543771648, 16384] root 7 has no backref item in extent tr=
ee
backpointer mismatch on [634543771648 16384]
ref mismatch on [634543788032 16384] extent item 0, found 1
tree extent[634543788032, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543788032 16384]
ref mismatch on [634543804416 16384] extent item 0, found 1
tree extent[634543804416, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543804416 16384]
ref mismatch on [634543820800 16384] extent item 0, found 1
tree extent[634543820800, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543820800 16384]
ref mismatch on [634543837184 16384] extent item 0, found 1
tree extent[634543837184, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543837184 16384]
ref mismatch on [634543853568 16384] extent item 0, found 1
tree extent[634543853568, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543853568 16384]
ref mismatch on [634543869952 16384] extent item 0, found 1
tree extent[634543869952, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543869952 16384]
ref mismatch on [634543886336 16384] extent item 0, found 1
tree extent[634543886336, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543886336 16384]
ref mismatch on [634543902720 16384] extent item 0, found 1
tree extent[634543902720, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634543902720 16384]
ref mismatch on [634543919104 16384] extent item 0, found 1
tree extent[634543919104, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543919104 16384]
ref mismatch on [634543935488 16384] extent item 0, found 1
tree extent[634543935488, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543935488 16384]
ref mismatch on [634543951872 16384] extent item 0, found 1
tree extent[634543951872, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543951872 16384]
ref mismatch on [634543984640 16384] extent item 0, found 1
tree extent[634543984640, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634543984640 16384]
ref mismatch on [634544001024 16384] extent item 0, found 1
tree extent[634544001024, 16384] root 257 has no backref item in extent =
tree
backpointer mismatch on [634544001024 16384]
ref mismatch on [634544017408 16384] extent item 0, found 1
tree extent[634544017408, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544017408 16384]
ref mismatch on [634544033792 16384] extent item 0, found 1
tree extent[634544033792, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544033792 16384]
ref mismatch on [634544050176 16384] extent item 0, found 1
tree extent[634544050176, 16384] root 257 has no backref item in extent =
tree
backpointer mismatch on [634544050176 16384]
ref mismatch on [634544066560 16384] extent item 0, found 1
tree extent[634544066560, 16384] root 7 has no backref item in extent tr=
ee
backpointer mismatch on [634544066560 16384]
ref mismatch on [634544082944 16384] extent item 0, found 1
tree extent[634544082944, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544082944 16384]
ref mismatch on [634544115712 16384] extent item 0, found 1
tree extent[634544115712, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544115712 16384]
ref mismatch on [634544132096 16384] extent item 0, found 1
tree extent[634544132096, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544132096 16384]
ref mismatch on [634544148480 16384] extent item 0, found 1
tree extent[634544148480, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544148480 16384]
ref mismatch on [634544214016 16384] extent item 0, found 1
tree extent[634544214016, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544214016 16384]
ref mismatch on [634544230400 16384] extent item 0, found 1
tree extent[634544230400, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544230400 16384]
ref mismatch on [634544246784 16384] extent item 0, found 1
tree extent[634544246784, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544246784 16384]
ref mismatch on [634544263168 16384] extent item 0, found 1
tree extent[634544263168, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544263168 16384]
ref mismatch on [634544279552 16384] extent item 0, found 1
tree extent[634544279552, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544279552 16384]
ref mismatch on [634544295936 16384] extent item 0, found 1
tree extent[634544295936, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544295936 16384]
ref mismatch on [634544312320 16384] extent item 0, found 1
tree extent[634544312320, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544312320 16384]
ref mismatch on [634544328704 16384] extent item 0, found 1
tree extent[634544328704, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544328704 16384]
ref mismatch on [634544345088 16384] extent item 0, found 1
tree extent[634544345088, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544345088 16384]
ref mismatch on [634544361472 16384] extent item 0, found 1
tree extent[634544361472, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544361472 16384]
ref mismatch on [634544377856 16384] extent item 0, found 1
tree extent[634544377856, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544377856 16384]
ref mismatch on [634544394240 16384] extent item 0, found 1
tree extent[634544394240, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544394240 16384]
ref mismatch on [634544410624 16384] extent item 0, found 1
tree extent[634544410624, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544410624 16384]
ref mismatch on [634544427008 16384] extent item 0, found 1
tree extent[634544427008, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544427008 16384]
ref mismatch on [634544443392 16384] extent item 0, found 1
tree extent[634544443392, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544443392 16384]
ref mismatch on [634544459776 16384] extent item 0, found 1
tree extent[634544459776, 16384] root 7 has no backref item in extent tr=
ee
backpointer mismatch on [634544459776 16384]
ref mismatch on [634544476160 16384] extent item 0, found 1
tree extent[634544476160, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544476160 16384]
ref mismatch on [634544492544 16384] extent item 0, found 1
tree extent[634544492544, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544492544 16384]
ref mismatch on [634544508928 16384] extent item 0, found 1
tree extent[634544508928, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544508928 16384]
ref mismatch on [634544525312 16384] extent item 0, found 1
tree extent[634544525312, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544525312 16384]
ref mismatch on [634544541696 16384] extent item 0, found 1
tree extent[634544541696, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544541696 16384]
ref mismatch on [634544558080 16384] extent item 0, found 1
tree extent[634544558080, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544558080 16384]
ref mismatch on [634544574464 16384] extent item 0, found 1
tree extent[634544574464, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544574464 16384]
ref mismatch on [634544590848 16384] extent item 0, found 1
tree extent[634544590848, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544590848 16384]
ref mismatch on [634544607232 16384] extent item 0, found 1
tree extent[634544607232, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544607232 16384]
ref mismatch on [634544623616 16384] extent item 0, found 1
tree extent[634544623616, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544623616 16384]
ref mismatch on [634544640000 16384] extent item 0, found 1
tree extent[634544640000, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544640000 16384]
ref mismatch on [634544656384 16384] extent item 0, found 1
tree extent[634544656384, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544656384 16384]
ref mismatch on [634544672768 16384] extent item 0, found 1
tree extent[634544672768, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544672768 16384]
ref mismatch on [634544689152 16384] extent item 0, found 1
tree extent[634544689152, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544689152 16384]
ref mismatch on [634544705536 16384] extent item 0, found 1
tree extent[634544705536, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544705536 16384]
ref mismatch on [634544721920 16384] extent item 0, found 1
tree extent[634544721920, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544721920 16384]
ref mismatch on [634544738304 16384] extent item 0, found 1
tree extent[634544738304, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544738304 16384]
ref mismatch on [634544754688 16384] extent item 0, found 1
tree extent[634544754688, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544754688 16384]
ref mismatch on [634544771072 16384] extent item 0, found 1
tree extent[634544771072, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544771072 16384]
ref mismatch on [634544787456 16384] extent item 0, found 1
tree extent[634544787456, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544787456 16384]
ref mismatch on [634544803840 16384] extent item 0, found 1
tree extent[634544803840, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544803840 16384]
ref mismatch on [634544820224 16384] extent item 0, found 1
tree extent[634544820224, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544820224 16384]
ref mismatch on [634544836608 16384] extent item 0, found 1
tree extent[634544836608, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544836608 16384]
ref mismatch on [634544852992 16384] extent item 0, found 1
tree extent[634544852992, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544852992 16384]
ref mismatch on [634544869376 16384] extent item 0, found 1
tree extent[634544869376, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634544869376 16384]
ref mismatch on [634544885760 16384] extent item 0, found 1
tree extent[634544885760, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544885760 16384]
ref mismatch on [634544902144 16384] extent item 0, found 1
tree extent[634544902144, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544902144 16384]
ref mismatch on [634544918528 16384] extent item 0, found 1
tree extent[634544918528, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544918528 16384]
ref mismatch on [634544934912 16384] extent item 0, found 1
tree extent[634544934912, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544934912 16384]
ref mismatch on [634544951296 16384] extent item 0, found 1
tree extent[634544951296, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544951296 16384]
ref mismatch on [634544967680 16384] extent item 0, found 1
tree extent[634544967680, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544967680 16384]
ref mismatch on [634544984064 16384] extent item 0, found 1
tree extent[634544984064, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634544984064 16384]
ref mismatch on [634545000448 16384] extent item 0, found 1
tree extent[634545000448, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545000448 16384]
ref mismatch on [634545016832 16384] extent item 0, found 1
tree extent[634545016832, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545016832 16384]
ref mismatch on [634545033216 16384] extent item 0, found 1
tree extent[634545033216, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545033216 16384]
ref mismatch on [634545049600 16384] extent item 0, found 1
tree extent[634545049600, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545049600 16384]
ref mismatch on [634545065984 16384] extent item 0, found 1
tree extent[634545065984, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545065984 16384]
ref mismatch on [634545082368 16384] extent item 0, found 1
tree extent[634545082368, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545082368 16384]
ref mismatch on [634545098752 16384] extent item 0, found 1
tree extent[634545098752, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545098752 16384]
ref mismatch on [634545115136 16384] extent item 0, found 1
tree extent[634545115136, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545115136 16384]
ref mismatch on [634545131520 16384] extent item 0, found 1
tree extent[634545131520, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545131520 16384]
ref mismatch on [634545164288 16384] extent item 0, found 1
tree extent[634545164288, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545164288 16384]
ref mismatch on [634545180672 16384] extent item 0, found 1
tree extent[634545180672, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545180672 16384]
ref mismatch on [634545197056 16384] extent item 0, found 1
tree extent[634545197056, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545197056 16384]
ref mismatch on [634545213440 16384] extent item 0, found 1
tree extent[634545213440, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545213440 16384]
ref mismatch on [634545229824 16384] extent item 0, found 1
tree extent[634545229824, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545229824 16384]
ref mismatch on [634545246208 16384] extent item 0, found 1
tree extent[634545246208, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545246208 16384]
ref mismatch on [634545262592 16384] extent item 0, found 1
tree extent[634545262592, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545262592 16384]
ref mismatch on [634545278976 16384] extent item 0, found 1
tree extent[634545278976, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545278976 16384]
ref mismatch on [634545295360 16384] extent item 0, found 1
tree extent[634545295360, 16384] root 258 has no backref item in extent =
tree
backpointer mismatch on [634545295360 16384]
ref mismatch on [634545311744 16384] extent item 0, found 1
tree extent[634545311744, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545311744 16384]
ref mismatch on [634545328128 16384] extent item 0, found 1
tree extent[634545328128, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545328128 16384]
ref mismatch on [634545344512 16384] extent item 0, found 1
tree extent[634545344512, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545344512 16384]
ref mismatch on [634545360896 16384] extent item 0, found 1
tree extent[634545360896, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545360896 16384]
ref mismatch on [634545377280 16384] extent item 0, found 1
tree extent[634545377280, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545377280 16384]
ref mismatch on [634545393664 16384] extent item 0, found 1
tree extent[634545393664, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545393664 16384]
ref mismatch on [634545410048 16384] extent item 0, found 1
tree extent[634545410048, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [634545410048 16384]
tree extent[693637402624, 1] root 2 has no tree block found
incorrect global backref count on 693637402624 found 1 wanted 0
backpointer mismatch on [693637402624 1]
owner ref check failed [693637402624 1]
extent item 693637414912 has multiple extent items
ref mismatch on [693637414912 16384] extent item 0, found 2
tree extent[693637414912, 16384] root 10 has no backref item in extent t=
ree
tree extent[693637414912, 16384] root 2 has no backref item in extent tr=
ee
backpointer mismatch on [693637414912 16384]
bad metadata [693637414912, 693637431296) crossing stripe boundary
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space tree
there is no free space entry for 634543001600-634545426432
cache appears valid but isn't 634260230144
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p5
UUID: ca0bd5c5-1e9b-4d7a-9e11-028ee4bfa22a
found 176460701697 bytes used, error(s) found
total csum bytes: 330310016
total tree bytes: 7177601024
total fs tree bytes: 4736794624
total extent tree bytes: 2011512832
btree space waste bytes: 1592634452
file data blocks allocated: 230763827200
 referenced 2489957961728

Notice the problematic 693637414912 showing up again at the the end of b=
trfs check.

btrfs --repair did some stuff, but it didn't make the partition unmounta=
ble.

This was my second broken btrfs file system (the first one failed after =
two months with a "parent transid verify failed" error, but I'm quite in=
clined to trust the hardware I'm running. Both of these volumes had bloc=
k-group-tree enabled and were running with discard=3Dasync.

In addition, someone on IRC (also running Arch Linux) told today about a=
 pretty similar issue, but block-group-tree was not involved there.

I no longer have the volume, but I can try to answer any follow-up quest=
ions, and still have the photos and full dmesg output.

Could this be some data corruption bug introduced around the 6.2 release?

Thanks,
Laurentiu
