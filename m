Return-Path: <linux-btrfs+bounces-11061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89645A1BC89
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6717A540A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA982248B6;
	Fri, 24 Jan 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="t0L333oI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n54yh332"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD5146A9B
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745146; cv=none; b=ANYsegpLFuJvVuovJO5HjaCRdAeB/sRvDj5CeVOo8YeumJ2+eY5bsUTKx2iKJV2bm0xytqIlDolB8ZPJqaRXDVISCf3kcKEauRXqmK5k2yw3vUtNcOCnCya0/EFUP5sE5QBXOEQT8SWKvZWt4i6E8jZEB392J7I1p9m1hntTKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745146; c=relaxed/simple;
	bh=1ounYxmS5N7j9tuGsvMXlu/9s7FWQT+o45tsMF2NsE0=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=jL4Nrh3Q2BToIbQDfB6L23uNBWgcJs/NqNhVa2wwZ+xck9MYjDI3+l5g1hXMWQFAkEZj1mHF6oo4Igb2BrsG5mMUBtMEVqJQfhwhtxo0AehNBHNHSUFqTHhY3Bco14ALO6oAkT4FemDmrO7drF6PvvatvOPAcRBCj3ChVtkahYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=t0L333oI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n54yh332; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DBF8913802FB
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 13:59:02 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Fri, 24 Jan 2025 13:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm3; t=
	1737745142; x=1737831542; bh=d2RMlwpit4qtJ872VpHj02N5e0xdWbB9dBH
	GIJt9H0o=; b=t0L333oIsC5xpxM5Z3a5TBctY5Op5aKZ7xXUK4p4oby/i0SW6Nk
	T55lGV4Qf5jf15Tqps+d4vqfEsDkfKC7x16kHzOPz53slv/ByNWMUdXL/XWDHQms
	Mm6QaOUgqEXnuJbcG7kRqHFvQtO1e0g3fh6g33LF2O7TDOm3iRtuPpdl5qkaTRCZ
	X1iBDpUuj1uVz517lgekRD0fJ5JE4BmAmSd2bPOUo2OUvaZQdB6R0sk+ZN9qbhqv
	pM7P2Qm6waA7SyOvwhWRpfElhA9SZk5vsKcoKavvDSHAfwn7gEfIXN6YylWd/4SX
	c/ux1b/l6CeA+HpIloSGOB8+duV3SMr686g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737745142; x=1737831542; bh=d2RMlwpit4qtJ872VpHj02N5e0xdWbB9dBH
	GIJt9H0o=; b=n54yh332JjiA95KsCoQ0wv6pfUYdQCodkGjblSCFmGo1h+Ii+ns
	TO7O5OpojF6mdaYg8j4cpGRnDP47fQVD7VM5LjWodP0/3SEbc7eBAg40PbIKuQU4
	jERWUsTZ9IdeR0NOy/I2nHDc+Qm0+aTWAGHbGQzfmcyhLg0JBEAL8HDpksXCGCwp
	TMkQmYMwkBffjWYpBFAlfkEFIQJEJp7aT5M98PP4uqE0wK2OMPI5fzB6tZlDpeWH
	qKuoZkozDOXrDDcs8LeLWoyhzGMkhHzUMEAQS1WSRHicXg4QkxxEVqk6IDcVE9H5
	UJZPP82ldOxJynCxjKRgw2YCVV01DM8ftmQ==
X-ME-Sender: <xms:9uKTZ0GTm-D1t3f7fmEimRB-3UXA1v9tO4uiPJbgDDv4NGlDxMiAAA>
    <xme:9uKTZ9U0bM683f1ieYwvOeyurrd7Yq8RzP0Vii1pm3jBxSvoS7_Asisz8t9HjzmHZ
    6hMrRPqys7Gnj7Cbn8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkffutgfgsehtqhertdertddtnecu
    hfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoegthhhrihhssegtohhlohhrrhgvmh
    gvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfejhffgkefhleelueegueef
    keeihfevfeekkeevuedvffejleefgfffiedvveenucffohhmrghinheprhgvughhrghtrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    tghhrhhishestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepud
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9uKTZ-I0Rn1uG3YCadSkCZ8gzqSxiCqyRzPiN3m92NJQY1n7KPdjzw>
    <xmx:9uKTZ2H8omtgnSf0rDSoURyNtN_jGVzUzXN8blvQY_jugky-WpKX0w>
    <xmx:9uKTZ6Vf1EaM-54PEqBX6BpiSVQaay5mvejzDpD12u2jzYDLfWVjsw>
    <xmx:9uKTZ5OTXbk5T1FWumD5LAVJBfmbQvOUrATDWuqVxgsuAXimo35wNg>
    <xmx:9uKTZzdM3Osa0YUScGEONXN5NLS9YC26nAYQ_1VLoyGCsZdfswJ_3AH->
Feedback-ID: i07814636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92A8C1C20066; Fri, 24 Jan 2025 13:59:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jan 2025 11:58:41 -0700
From: "Chris Murphy" <chris@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <5f6d6f11-a693-4192-ae20-7591c44c6332@app.fastmail.com>
Subject: kernel 6.12.8, hard lockup, refcount_t: addition on 0; use-after-free
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Downstream bug report contains full dmesg attached.
https://bugzilla.redhat.com/show_bug.cgi?id=3D2341993

This is a one time event so far. Manifests as a sluggish system, increas=
ingly non-responsive.

top reports 100% CPU for each flush-btrfs-1 and btrfs_discard.

And then total lockup, including the mouse pointer - system became unres=
ponsive to the user but systemd-journald must still have been flushing t=
o disk because I have entries through to the time power was forced off.

dmesg excerpt

[31602.276050] kernel: wlp0s20f3: Limiting TX power to 27 (30 - 3) dBm a=
s advertised by f8:a0:97:6e:c7:e8
[36853.462029] kernel: ------------[ cut here ]------------
[36853.462228] kernel: refcount_t: addition on 0; use-after-free.
[36853.462255] kernel: WARNING: CPU: 1 PID: 36554 at lib/refcount.c:25 r=
efcount_warn_saturate+0xe5/0x110
[36853.462278] kernel: Modules linked in: f2fs crc32_generic lz4hc_compr=
ess lz4_compress nls_utf8 hfsplus uas usb_storage uinput rfcomm snd_seq_=
dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib=
_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 n=
f_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc qrtr bnep zstd snd_soc_s=
kl_hda_dsp snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_=
hda_dsp_common snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_ge=
neric snd_hda_scodec_component snd_soc_dmic snd_sof_pci_intel_cnl snd_so=
f_intel_hda_generic soundwire_intel soundwire_cadence snd_sof_intel_hda_=
common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_so=
f_pci snd_sof_xtensa_dsp snd_sof binfmt_misc snd_sof_utils snd_soc_acpi_=
intel_match soundwire_generic_allocation snd_soc_acpi soundwire_bus vfat=
 fat snd_soc_avs snd_soc_hda_codec snd_hda_ext_core snd_soc_core intel_u=
ncore_frequency snd_compress
[36853.462389] kernel:  intel_uncore_frequency_common iwlmvm ac97_bus in=
tel_pmc_core_pltdrv intel_pmc_core snd_pcm_dmaengine intel_vsec pmt_tele=
metry snd_hda_intel pmt_class intel_tcc_cooling snd_intel_dspcfg snd_int=
el_sdw_acpi x86_pkg_temp_thermal snd_hda_codec uvcvideo intel_powerclamp=
 mac80211 btusb snd_hda_core btrtl coretemp uvc spi_nor btintel kvm_inte=
l snd_hwdep videobuf2_vmalloc videobuf2_memops processor_thermal_device_=
pci_legacy videobuf2_v4l2 processor_thermal_device snd_ctl_led libarc4 m=
ei_pxp btbcm mtd snd_seq processor_thermal_wt_hint mei_wdt kvm videobuf2=
_common mei_hdcp iTCO_wdt snd_seq_device processor_thermal_rfim intel_pm=
c_bxt intel_rapl_msr iTCO_vendor_support iwlwifi snd_pcm videodev thinkp=
ad_acpi processor_thermal_rapl think_lmi btmtk rapl mei_me intel_rapl_co=
mmon spi_intel_pci intel_cstate intel_uncore bluetooth mc thunderbolt cf=
g80211 firmware_attributes_class intel_wmi_thunderbolt wmi_bmof sparse_k=
eymap e1000e snd_timer mei processor_thermal_wt_req platform_profile i2c=
_i801 idma64 i2c_smbus spi_intel
[36853.462460] kernel:  processor_thermal_power_floor rfkill processor_t=
hermal_mbox intel_pch_thermal intel_soc_dts_iosf snd int3403_thermal sou=
ndcore int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_tad ac=
pi_pad joydev loop nfnetlink dm_crypt i915 crct10dif_pclmul crc32_pclmul=
 crc32c_intel nvme hid_multitouch polyval_clmulni polyval_generic ghash_=
clmulni_intel i2c_hid_acpi sha512_ssse3 sha256_ssse3 nvme_core sha1_ssse=
3 i2c_algo_bit drm_buddy i2c_hid ttm nvme_auth drm_display_helper ucsi_a=
cpi typec_ucsi video typec cec pinctrl_cannonlake wmi serio_raw fuse
[36853.462525] kernel: CPU: 1 UID: 0 PID: 36554 Comm: kworker/u32:4 Not =
tainted 6.12.8-200.fc41.x86_64 #1
[36853.462548] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS=
 N2HET77W (1.60 ) 02/06/2024
[36853.462568] kernel: Workqueue: writeback wb_workfn (flush-btrfs-1)
[36853.462589] kernel: RIP: 0010:refcount_warn_saturate+0xe5/0x110
[36853.462610] kernel: Code: 7e 81 ff 0f 0b c3 cc cc cc cc 80 3d 85 8d 3=
1 02 00 0f 85 5e ff ff ff 48 c7 c7 d8 d9 ea 8e c6 05 71 8d 31 02 01 e8 e=
b 7d 81 ff <0f> 0b c3 cc cc cc cc 48 c7 c7 30 da ea 8e c6 05 55 8d 31 02=
 01 e8
[36853.462632] kernel: RSP: 0018:ffffb0321039f460 EFLAGS: 00010282
[36853.462653] kernel: RAX: 0000000000000000 RBX: ffff95be09399400 RCX: =
0000000000000027
[36853.462674] kernel: RDX: ffff95c16e6a1908 RSI: 0000000000000001 RDI: =
ffff95c16e6a1900
[36853.462694] kernel: RBP: ffff95be09200000 R08: 0000000000000000 R09: =
0000000000000000
[36853.462714] kernel: R10: 206e6f206e6f6974 R11: 612d657375203b30 R12: =
ffffb0321039f528
[36853.462739] kernel: R13: 0000000000000000 R14: 0000000000000001 R15: =
ffff95be11737400
[36853.462761] kernel: FS:  0000000000000000(0000) GS:ffff95c16e680000(0=
000) knlGS:0000000000000000
[36853.462782] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[36853.462804] kernel: CR2: 00007efc89f67000 CR3: 000000013c82a003 CR4: =
00000000003726f0
[36853.462825] kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[36853.462846] kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[36853.462866] kernel: Call Trace:
[36853.462891] kernel:  <TASK>
[36853.462913] kernel:  ? refcount_warn_saturate+0xe5/0x110
[36853.462936] kernel:  ? __warn.cold+0x93/0xfa
[36853.462958] kernel:  ? refcount_warn_saturate+0xe5/0x110
[36853.462976] kernel:  ? report_bug+0xff/0x140
[36853.463010] kernel:  ? handle_bug+0x58/0x90
[36853.463038] kernel:  ? exc_invalid_op+0x17/0x70
[36853.463061] kernel:  ? asm_exc_invalid_op+0x1a/0x20
[36853.463082] kernel:  ? refcount_warn_saturate+0xe5/0x110
[36853.463096] kernel:  find_free_extent+0x26a/0x16c0
[36853.463116] kernel:  ? ttwu_queue_wakelist+0x119/0x1a0
[36853.463137] kernel:  btrfs_reserve_extent+0x12e/0x290
[36853.463159] kernel:  cow_file_range+0x185/0x7a0
[36853.463181] kernel:  ? merge_next_state+0x1a/0x90
[36853.463200] kernel:  btrfs_run_delalloc_range+0x112/0x440
[36853.463222] kernel:  ? find_lock_delalloc_range+0x178/0x230
[36853.463244] kernel:  writepage_delalloc+0x1d1/0x3a0
[36853.463266] kernel:  extent_write_cache_pages+0x24a/0x6d0
[36853.463290] kernel:  btrfs_writepages+0x76/0x130
[36853.463312] kernel:  do_writepages+0x7e/0x280
[36853.463332] kernel:  ? sched_balance_find_src_group+0x51/0x580
[36853.463353] kernel:  __writeback_single_inode+0x41/0x340
[36853.463373] kernel:  writeback_sb_inodes+0x21d/0x4e0
[36853.463394] kernel:  __writeback_inodes_wb+0x4c/0xf0
[36853.463415] kernel:  wb_writeback+0x193/0x310
[36853.463435] kernel:  wb_workfn+0x2af/0x450
[36853.463459] kernel:  process_one_work+0x176/0x330
[36853.463478] kernel:  worker_thread+0x252/0x390
[36853.463496] kernel:  ? __pfx_worker_thread+0x10/0x10
[36853.463514] kernel:  kthread+0xcf/0x100
[36853.463537] kernel:  ? __pfx_kthread+0x10/0x10
[36853.463558] kernel:  ret_from_fork+0x31/0x50
[36853.463578] kernel:  ? __pfx_kthread+0x10/0x10
[36853.463595] kernel:  ret_from_fork_asm+0x1a/0x30
[36853.463615] kernel:  </TASK>
[36853.463634] kernel: ---[ end trace 0000000000000000 ]---
[36853.463651] kernel: ------------[ cut here ]------------
[36853.463669] kernel: refcount_t: underflow; use-after-free.
[36853.463689] kernel: WARNING: CPU: 1 PID: 36554 at lib/refcount.c:28 r=
efcount_warn_saturate+0xbe/0x110



--
Chris Murphy

