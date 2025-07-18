Return-Path: <linux-btrfs+bounces-15558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B5B0AA75
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB15D7AC070
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA42E7F1E;
	Fri, 18 Jul 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LRXvvSqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mP+8aU17"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2317A305
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865039; cv=none; b=T95BVGcXLmbU/0zixfzfefy6oBK0Mlc8DxFbCdRoMCN5htUaocaI7kfjes3Ea1XVR2WQELpTnreLY+IkSDZd5yYitJaqOfIU2efGkpqQyAQa/GNtKOFAo4RyWcg8aQQd28/MJ0KoCJ/Eye+tqB9fap27sHApxfoKffRVCDchduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865039; c=relaxed/simple;
	bh=HOL5sQpep2JIwdhldcqLHzHn1WYnFzhwrLrMYIIvub8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5O6dZ7KJ4XSYybuMZKloGmj5ud8Q92SENK+u3bM8bZFrywF4nXKnOGBQ0IWD1FaWer++YFtTRrByMDPAeu8jZRc9SKnEdjAG08c5XQg/IWQWqVzKLcW/DLhtNGb04mqkCGBvFMI9RHYf5afM9RYq6e7yzwhu2orjXVvIf7Cs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LRXvvSqE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mP+8aU17; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 902FA1D000C4;
	Fri, 18 Jul 2025 14:57:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 18 Jul 2025 14:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1752865036; x=1752951436; bh=itK9G4V/3b
	Ew5KjMCR0nEul4U9u8XxodZYQsbgH8vD8=; b=LRXvvSqEviKHW9KwSKuy4nI71d
	rEr1gTBGJXln5ma8ckdXSnqizS/ZOFLTfL7aZBtI+tkNpeWxYgjBY92WLfZ8sclD
	bHGJobRwWA7V3AtKeVmcVzwLJF85pG05R8VuduwfTyseiWOKetybGxw8NTxJ2abx
	hzmtmfwUfyTp9FN2b2BsNMi8nK1mdXboVWNbO21ppiBvSIuU/pb+sNRSwvENFXT0
	CuIk/LSyeychsuirhavdLgPq0TG6Tp4DiPTRe4pU/Vod0OPjpw2Ksq2oyt1LX8vq
	S3meV+0ZngCemEa2JSj5gN8aLyYeu9Y2oBCooiYYnT0InqcoNTgXsbqe9aPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752865036; x=1752951436; bh=itK9G4V/3bEw5KjMCR0nEul4U9u8XxodZYQ
	sbgH8vD8=; b=mP+8aU17DTuowtE6Btuxczd6l+cX1Ua+55H402YSdDHZ1yKOrDs
	IlU6IWpSmn8SAY70ZlWUFl9Mhf6/Tj8TpZ47jVawUfB/jc3ffrcWmwLp1OZu+iRc
	LpU0IKJfS92lDNUYbBNFtQOLtqeDDofUXNl0eo/OLtwXtsYZRglSDW/CsSTIvUaU
	gJZq/xwmp2Qo+vXx7AHqqpilkCfdlB4K6dJicvLMGXJwKTkrvmvyM0SCZgRLJTML
	3aZfO0leh73vLvI0XQ1HJVMTF2pnrmgEicSgPfeSRl7VmaOeR3RD77Nn1AX2LPWQ
	cEzyA25PnBDMJH2ZzqwsbgVSVjDGwOAVo2Q==
X-ME-Sender: <xms:C5l6aCK9uoub-3R-V27gWqk7PS_SgLBAijL5KDjrlq-RXD-32tZebw>
    <xme:C5l6aHvvCgftkYc9c1TDTamorMs537q7c_Sl68I3CoUMsD0rItq2Z4wp-AJ6T_UvZ
    CvH0ujxrP5CPxm1x3U>
X-ME-Received: <xmr:C5l6aJLn49DGRCYFKrZC0WDFWsDzOGBinDcoQRjkpnIA36urgA_8EYAurbjOVSNt_3AWuDjfeQTDLWX_DCHACLM4lkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpthhrudeffeejsegtrggthhihohhsrdhorhhgpdhrtghpthhtoheplhhishhtshestg
    holhhorhhrvghmvgguihgvshdrtghomhdprhgtphhtthhopehquhifvghnrhhuohdrsght
    rhhfshesghhmgidrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvsehjihhkohhsrdgtiidprhgt
    phhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtph
    htthhopegunhgrihhmsegtrggthhihohhsrdhorhhg
X-ME-Proxy: <xmx:C5l6aI-ZYxGsLarhzRdqwdGeTsiJwIaCVQo-V3eL_NAe9h9a1pp2VQ>
    <xmx:C5l6aKw7gMfh12m0B__K2QN4TGmbFdRF02LXXsWIUMR1QCgRhHQw9A>
    <xmx:C5l6aN5LoMWsH1PqF-Cy0EK_wKv9QJ9r-d5dRc7_nQguWTHq34Qk3Q>
    <xmx:C5l6aJ-8eiy5hSW1PXZyI9KfSU5V5ZlkHyBd5xTFbD0LVcQVn8jhog>
    <xmx:DJl6aDQ9f5Ii5U_alTlS5jw9CRfHjQx_W_2XxCc77_tWk9XmzG8dy839>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:57:15 -0400 (EDT)
Date: Fri, 18 Jul 2025 11:58:45 -0700
From: Boris Burkov <boris@bur.io>
To: Peter Jung <ptr1337@cachyos.org>
Cc: Chris Murphy <lists@colorremedies.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dave@jikos.cz,
	Greg KH <gregkh@linuxfoundation.org>, dnaim@cachyos.org
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
Message-ID: <20250718185845.GA4107167@zen.localdomain>
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
 <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
 <d0863ae6-5c0f-46ff-8cea-b5b3d1c43005@app.fastmail.com>
 <bb83ecb0-e302-4c01-93d5-1321ba737f71@cachyos.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb83ecb0-e302-4c01-93d5-1321ba737f71@cachyos.org>

On Thu, Jul 17, 2025 at 06:51:40PM +0200, Peter Jung wrote:
> Hi all,
> 
> Here you can find the trace of dmesg, after the log tree is corrupted. This
> has been taken on an Live ISO, which should reflect the same dmesg as in the
> emergency shell, when trying to mount the disk.

Thank you very much for collecting this.

> 
> ```
> [  205.774875] BTRFS: device fsid b09a027e-a61d-424f-858f-2e02be61b342 devid
> 1 transid 159947 /dev/nvme0n1p2 (259:2) scanned by mount (2499)
> [  205.775120] BTRFS info (device nvme0n1p2): first mount of filesystem
> b09a027e-a61d-424f-858f-2e02be61b342
> [  205.775142] BTRFS info (device nvme0n1p2): using crc32c (crc32c-intel)
> checksum algorithm
> [  205.775150] BTRFS info (device nvme0n1p2): using free-space-tree
> [  205.792525] BTRFS info (device nvme0n1p2): start tree-log replay
> [  205.875103] BTRFS: error (device nvme0n1p2) in btrfs_replay_log:2104:
> errno=-5 IO failure (Failed to recover log tree)

What we can draw from this is that we are seeing an EIO somewhere in
btrfs_replay_log()

> [  205.876751] ------------[ cut here ]------------
> [  205.876753] WARNING: CPU: 4 PID: 2499 at fs/btrfs/block-rsv.c:456
> btrfs_release_global_block_rsv+0xa9/0xe0 [btrfs]

Then after that function fails, we go to the cleanup of the mount
operation and also hit a WARNING in btrfs_free_block_groups(). It could
be related. It's a little weird since that call fully empties the
block_rsv with a -1 release before the WARN checks, so it suggests some
race where someone else uses the block_rsv mid release.

I don't have a strong intuition for whether this is important or not,
but best case it is a hint of what's happening on the system, it doesn't
have strong relevance to the proximal causes of the log tree replay EIO.

> [  205.876813] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq
> snd_seq_device qrtr snd_soc_dmic snd_soc_acp6x_mach snd_acp6x_pdm_dma
> snd_sof_amd_acp70 snd_sof_amd_acp63 snd_sof_amd_vangogh
> snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci
> snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match
> soundwire_amd soundwire_generic_allocation snd_amd_sdw_acpi soundwire_bus
> snd_soc_sdca snd_soc_core ac97_bus snd_pcm_dmaengine snd_compress amd_atl
> intel_rapl_msr intel_rapl_common kvm_amd hid_sensor_custom
> snd_hda_codec_realtek snd_rpl_pci_acp6x snd_hda_scodec_component kvm
> uvcvideo snd_hda_codec_generic snd_acp_pci snd_hda_codec_hdmi
> snd_acp_legacy_common iwlmvm crct10dif_pclmul snd_hda_intel snd_intel_dspcfg
> snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_pci_acp6x polyval_clmulni
> uvc snd_hwdep videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
> videobuf2_common videodev mc polyval_generic nvidia_drm(OE) hid_multitouch
> btusb spd5118 hid_sensor_hub snd_pcm mac80211
> [  205.876885]  ghash_clmulni_intel snd_timer libarc4 btbcm
> nvidia_modeset(OE) snd_pci_acp5x btintel snd_rn_pci_acp3x sha1_ssse3 ptp snd
> snd_acp_config btrtl joydev pps_core mousedev wacom iwlwifi rapl i2c_piix4
> soundcore ideapad_laptop snd_soc_acpi i2c_hid_acpi ucsi_acpi btmtk cfg80211
> nvidia(OE) platform_profile typec_ucsi bluetooth typec sparse_keymap roles
> wmi_bmof nvidia_wmi_ec_backlight k10temp rfkill amd_pmc snd_pci_acp3x ccp
> i2c_hid mac_hid acpi_tad i2c_smbus zfs(OE) spl(OE) pkcs8_key_parser ntsync
> i2c_dev nfnetlink lz4 zram 842_decompress 842_compress lz4hc_compress
> lz4_compress ip_tables x_tables overlay squashfs loop isofs cdrom dm_mod
> hid_logitech_hidpp hid_logitech_dj amdgpu nouveau btrfs mxm_wmi drm_gpuvm
> drm_buddy raid6_pq drm_exec amdxcp crc32_pclmul xor gpu_sched uas
> drm_suballoc_helper sha512_ssse3 libcrc32c crc32c_generic crc32c_intel
> usb_storage hid_generic serio_raw sha256_ssse3 drm_ttm_helper sdhci_pci
> atkbd aesni_intel ttm cqhci libps2 gf128mul vivaldi_fmap sdhci_uhs2
> crypto_simd i2c_algo_bit nvme
> [  205.876991]  cryptd sdhci drm_display_helper usbhid nvme_core i8042
> mmc_core video cec crc16 nvme_auth serio wmi
> [  205.877008] CPU: 4 UID: 0 PID: 2499 Comm: mount Tainted: G OE
> 6.13.0-2-cachyos #1 b109e82a9bce3931c5e96e558e71463b86410157
> [  205.877013] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  205.877015] Hardware name: LENOVO 82SN/LNVNB161216, BIOS J4CN44WW
> 01/03/2025
> [  205.877017] RIP: 0010:btrfs_release_global_block_rsv+0xa9/0xe0 [btrfs]
> [  205.877059] Code: 01 00 00 00 74 b1 0f 0b 48 83 bb 40 01 00 00 00 74 af
> 0f 0b 48 83 bb 48 01 00 00 00 74 ad 0f 0b 48 83 bb 70 01 00 00 00 74 ab <0f>
> 0b 48 83 bb 78 01 00 00 00 74 a9 0f 0b 48 83 bb a8 01 00 00 00
> [  205.877062] RSP: 0018:ffffb1dccf0b3930 EFLAGS: 00010286
> [  205.877065] RAX: 000000000aa74000 RBX: ffff9d1309b3e000 RCX:
> 0000000000000000
> [  205.877067] RDX: 0000000000000001 RSI: ffff9d11968a8000 RDI:
> ffff9d11968a8008
> [  205.877069] RBP: ffff9d1309b3e000 R08: 0000000000200018 R09:
> 0000000000000000
> [  205.877071] R10: ffffffff00000000 R11: ffff9d11a3b70d28 R12:
> 0000000000000000
> [  205.877073] R13: ffff9d1309b3e090 R14: dead000000000122 R15:
> ffff9d1309b3e098
> [  205.877075] FS:  00007f78c965bb80(0000) GS:ffff9d146fe00000(0000)
> knlGS:0000000000000000
> [  205.877077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  205.877079] CR2: 000077ed0d308068 CR3: 0000000105c44000 CR4:
> 0000000000f50ef0
> [  205.877081] PKRU: 55555554
> [  205.877083] Call Trace:
> [  205.877085]  <TASK>
> [  205.877087]  ? __warn+0xd5/0x1d0
> [  205.877093]  ? btrfs_release_global_block_rsv+0xa9/0xe0 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877131]  ? report_bug+0x144/0x1f0
> [  205.877137]  ? handle_bug+0x6a/0x90
> [  205.877141]  ? exc_invalid_op+0x1a/0x50
> [  205.877144]  ? asm_exc_invalid_op+0x1a/0x20
> [  205.877151]  ? btrfs_release_global_block_rsv+0xa9/0xe0 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877187]  btrfs_free_block_groups+0x3a6/0x490 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877223]  open_ctree+0x825/0x1030 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877261]  btrfs_get_tree+0x58e/0x740 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877297]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877300]  ? __kmalloc_node_track_caller_noprof+0x1aa/0x2a0
> [  205.877304]  ? vfs_dup_fs_context+0x2d/0x1b0
> [  205.877309]  vfs_get_tree+0x2b/0xd0
> [  205.877313]  fc_mount+0x12/0x40
> [  205.877317]  btrfs_get_tree+0x234/0x740 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877354]  vfs_get_tree+0x2b/0xd0
> [  205.877358]  __se_sys_fsconfig+0x50a/0x5c0
> [  205.877363]  do_syscall_64+0x85/0x11e
> [  205.877366]  ? mntput_no_expire.llvm.15307020400983096988+0x4d/0x220
> [  205.877372]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877375]  ? syscall_exit_work+0xca/0x150
> [  205.877378]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877380]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877384]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877386]  ? do_syscall_64+0x91/0x11e
> [  205.877389]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877391]  ? syscall_exit_work+0xca/0x150
> [  205.877393]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877396]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877399]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877402]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877404]  ? syscall_exit_work+0xca/0x150
> [  205.877406]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877409]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877412]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877414]  ? do_syscall_64+0x91/0x11e
> [  205.877417]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877419]  ? do_syscall_64+0x91/0x11e
> [  205.877422]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877424]  ? __fs_parse+0x54/0x1d0
> [  205.877428]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877430]  ? btrfs_parse_param+0x54/0x8e0 [btrfs
> d6619631500fe860881f162577f2f551d395ff24]
> [  205.877467]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877470]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877472]  ? syscall_exit_work+0xca/0x150
> [  205.877475]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877477]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877480]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877483]  ? do_syscall_64+0x91/0x11e
> [  205.877486]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877488]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877491]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877493]  ? do_syscall_64+0x91/0x11e
> [  205.877496]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877498]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877510]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877513]  ? do_syscall_64+0x91/0x11e
> [  205.877515]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877517]  ? syscall_exit_to_user_mode+0x38/0x9f
> [  205.877521]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877523]  ? do_syscall_64+0x91/0x11e
> [  205.877526]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877528]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  205.877531]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  205.877534] RIP: 0033:0x7f78c97b02fe
> [  205.877561] Code: 73 01 c3 48 8b 0d 12 ca 0c 00 f7 d8 64 89 01 48 83 c8
> ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e2 c9 0c 00 f7 d8 64 89 01 48
> [  205.877564] RSP: 002b:00007fff681e2018 EFLAGS: 00000246 ORIG_RAX:
> 00000000000001af
> [  205.877569] RAX: ffffffffffffffda RBX: 0000643d093634f0 RCX:
> 00007f78c97b02fe
> [  205.877571] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
> 0000000000000003
> [  205.877572] RBP: 00007fff681e2050 R08: 0000000000000000 R09:
> 00007f78c987db20
> [  205.877574] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007f78c98d4aa0
> [  205.877576] R13: 0000000000000000 R14: 0000643d093650a0 R15:
> 00007f78c98cbf9b
> [  205.877581]  </TASK>
> [  205.877582] ---[ end trace 0000000000000000 ]---
> [  205.877701] BTRFS error (device nvme0n1p2 state E): open_ctree failed
> ```

And there is no other helpful information here, unfortunately. The BZ
Chris linked above is essentially the same, as far as I can tell.

So that still leaves us with very little to go off of. Would any of the
following be possible with one of the people experiencing the issue:

run offline commands like btrfs check, btrfs filesystem dump-tree, etc..
on the broken fs from a live CD? We might need to hack the btrfs cli to
keep trying after seeing some basic corruption, but I am happy to
provide the patched btrfs-progs if necessary.

or

run some bpf tracing (preferably using bpftrace) during the failing
mount? I can think about / provide my best guess of a useful script if
so.

Regarding versions this is happening on: you have strong evidence it is
happening on 6.15.3 but not 6.15.2? It could still be a coincidence,
where we are triggering some ancient latent bug, but I will also
inspect the patches you linked more carefully if so.

Thanks,
Boris

> 
> 
> 
> On 7/8/25 05:01, Chris Murphy wrote:
> > 
> > On Mon, Jul 7, 2025, at 7:12 AM, Peter Jung wrote:
> > 
> > > Thanks for your answer - but how it would work saving the logs in the
> > > emergency shell, specially if the root partitions can not be mounted?
> > You can mount a USB stick or even the EFI system partition to `/sysroot` and then copy the logs there.
> > 
> > Also for Qu et al, we have a couple reports in Fedora of log tree replay issues with 6.15 series too. I've requested dmesg, but at least one of the users already followed advice to zero the log tree. Hopefully we get one to report dmesg soon.
> > 
> > -- Chris Murphy
> > 
> 

