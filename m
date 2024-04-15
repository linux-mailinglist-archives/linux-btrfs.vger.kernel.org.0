Return-Path: <linux-btrfs+bounces-4250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63A8A477E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 07:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731431C213D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 05:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6A5234;
	Mon, 15 Apr 2024 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="oM1PUpRz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0055C138;
	Mon, 15 Apr 2024 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713157884; cv=none; b=N8SI60MU3RyJNJ1dhNmEZxnrzznVL4HsuZ+CxN5rX4PDUhqTTmsbjvuuQwnogZt0pdjNNDGrl6hIRdRkRsqb+sNq5Bt4OfZXvt6jcD5JZykqmFlDpw75sC2DdKyJSUsWOoK5cI5swIUE9YaVNUwqgbVtXqmTthNBj/l4VNOxvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713157884; c=relaxed/simple;
	bh=3yDZ/kwgaUxbofN0+kugke1sHkJsx+ANt7RBqra3GbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=IbsEaDX3z67wieD0wx9efC+W6H3h8kBrfova0FBfP4ApwyqpNHp37mVLmnMohp7jvhPhnUlJJBTjFwH1bfcG/9ZZkEftvP2wnmJDKKBC6O5FLyvAzJ/1aPyYOjgiajAvvgd3aCuW8S9frNRkCGOBoJloYWW3syud1k77ovsGYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=oM1PUpRz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=2RqVnNiHEZsQRUo3wtchR55KSJHjRHKxoWBHB8I16dc=;
	t=1713157882; x=1713589882; b=oM1PUpRzVOb3QTJBQqIzLSPyAILeKEpT3ZtggNk2CXITzSn
	o/r+3CGcLaqJeqRPWOooyi4RKI0KNvVvs3C1gq3NN/F0r4xEVKZtWX/YZpqUcZWwn0Kmkg40mA5kp
	Gs7LddEQWh/UyeB+zRP5MpsmZaVGDgP4W1cA+f4M74E5InX5Yk7whKYc1t/DhWgdAsrbxHi6gmbBF
	M0gZ6SHT8M3k5UXSdo07TguC5PDubzqmz8sEMpSbLk19nFXF6VYkj8UtCKuQ/nBBUdxsQNBrXxNYN
	rPs+m4p419XBMv7hVOJwf3F9CUb7Bi8wQNHF2zrFbi8drd8a+Nj3GJY3PHnWDP8A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rwEce-00048c-Bu; Mon, 15 Apr 2024 07:11:16 +0200
Message-ID: <bd8492f4-a12e-48ae-8ea6-a9d4596a6f72@leemhuis.info>
Date: Mon, 15 Apr 2024 07:11:15 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs: sanity tests fails on 6.8.3
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
References: <20240415.125625.2060132070860882181.sian@big.or.jp>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
Cc: linux-btrfs@vger.kernel.org, Hiroshi Takekawa <sian@big.or.jp>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
In-Reply-To: <20240415.125625.2060132070860882181.sian@big.or.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713157882;7cc21886;
X-HE-SMSGID: 1rwEce-00048c-Bu

[adding the authors of the two commits mentioned as well as the Btrfs
maintainers and the regressions & stable list to the list of recipients]

On 15.04.24 05:56, Hiroshi Takekawa wrote:
>=20
> Module loading fails with CONFIG_BTRFS_FS_RUN_SANITY_TESTS enabled on
> 6.8.3-6.8.6.
>=20
> Bisected:
> Reverting these commits, then module loading succeeds.
> 70f49f7b9aa3dfa70e7a2e3163ab4cae7c9a457a

FWIW, that is a linux-stable commit-id for 41044b41ad2c8c ("btrfs: add
helper to get fs_info from struct inode pointer") [v6.9-rc1, v6.8.3
(70f49f7b9aa3df)]

> 86211eea8ae1676cc819d2b4fdc8d995394be07d

FWIW, that was a mainline commit-id for 86211eea8ae167 ("btrfs: qgroup:
validate btrfs_qgroup_inherit parameter") [v6.9-rc1, v6.8.3
(f19dad4f440af4)]

Also:

There is a report that to me looks a lot like it's about the same
problem: https://bugzilla.kernel.org/show_bug.cgi?id=3D218720

Ciao, Thorsten

> Backtrace:
> [   69.030943] xor: automatically using best checksumming function   av=
x      =20
> [   69.031940] raid6: skipped pq benchmark and selected avx2x4
> [   69.031942] raid6: using avx2x2 recovery algorithm
> [   69.074954] Btrfs loaded, zoned=3Dno, fsverity=3Dno
> [   69.074973] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
> [   69.074974] BTRFS: selftest: running btrfs free space cache tests
> [   69.074979] BTRFS: selftest: running extent only tests
> [   69.074981] BTRFS: selftest: running bitmap only tests
> [   69.074986] BTRFS: selftest: running bitmap and extent tests
> [   69.074989] BTRFS: selftest: running space stealing from bitmap to e=
xtent tests
> [   69.075128] BTRFS: selftest: running bytes index tests
> [   69.075134] BTRFS: selftest: running extent buffer operation tests
> [   69.075135] BTRFS: selftest: running btrfs_split_item tests
> [   69.075140] BTRFS: selftest: running extent I/O tests
> [   69.075141] BTRFS: selftest: running find delalloc tests
> [   69.098156] BUG: kernel NULL pointer dereference, address: 000000000=
0000208
> [   69.098169] #PF: supervisor read access in kernel mode
> [   69.098174] #PF: error_code(0x0000) - not-present page
> [   69.098179] PGD 0 P4D 0=20
> [   69.098182] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   69.098187] CPU: 16 PID: 9701 Comm: modprobe Tainted: P           OE=
      6.8.4 #1
> [   69.098194] Hardware name: ASUS System Product Name/PRIME Z490-A, BI=
OS 2801 10/27/2023
> [   69.098200] RIP: 0010:find_lock_delalloc_range+0x30/0x260 [btrfs]
> [   69.098239] Code: 57 41 56 41 55 41 54 53 48 83 ec 40 49 89 d6 49 89=
 f7 49 89 fc 65 48 8b 04 25 28 00 00 00 48 89 44 24 38 48 8b 87 40 fe ff =
ff <48> 8b 80 08 02 00 00 48 85 c0 74 09 48 8b a8 a0 0c 00 00 eb 05 bd
> [   69.098252] RSP: 0018:ffffa2c087cfb8a8 EFLAGS: 00010282
> [   69.098256] RAX: 0000000000000000 RBX: 0000000000000fff RCX: ffffa2c=
087cfb938
> [   69.098262] RDX: ffffa2c087cfb940 RSI: ffffdf1544fbac80 RDI: ffffa08=
5c86b05f0
> [   69.098266] RBP: 0000000000000000 R08: 0000000000000010 R09: 0000000=
000000000
> [   69.098271] R10: ffffa0852f8e8a20 R11: ffffffffbb22eb70 R12: ffffa08=
5c86b05f0
> [   69.098276] R13: ffffdf1544fbac80 R14: ffffa2c087cfb940 R15: ffffdf1=
544fbac80
> [   69.098280] FS:  00007f6447289740(0000) GS:ffffa0a3edc00000(0000) kn=
lGS:0000000000000000
> [   69.098286] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   69.098290] CR2: 0000000000000208 CR3: 0000000176cec006 CR4: 0000000=
0007706f0
> [   69.098295] PKRU: 55555554
> [   69.098297] Call Trace:
> [   69.098300]  <TASK>
> [   69.098302]  ? __die_body+0x5f/0xb0
> [   69.098307]  ? page_fault_oops+0x294/0x3c0
> [   69.098311]  ? exc_page_fault+0x4b/0x70
> [   69.098316]  ? asm_exc_page_fault+0x26/0x30
> [   69.098319]  ? __pfx_workingset_update_node+0x10/0x10
> [   69.098325]  ? find_lock_delalloc_range+0x30/0x260 [btrfs]
> [   69.098355]  btrfs_test_extent_io+0x185/0x1210 [btrfs]
> [   69.098378]  btrfs_run_sanity_tests+0x7c/0x120 [btrfs]
> [   69.098400]  ? __pfx_init_module+0x10/0x10 [btrfs]
> [   69.098421]  init_module+0x1b/0x90 [btrfs]
> [   69.098441]  ? __pfx_init_module+0x10/0x10 [btrfs]
> [   69.098462]  do_one_initcall+0x115/0x340
> [   69.098598]  ? idr_alloc_cyclic+0x139/0x1d0
> [   69.098728]  ? __kernfs_new_node+0xc7/0x230
> [   69.098855]  ? sysvec_apic_timer_interrupt+0x15/0x80
> [   69.098984]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   69.099111]  ? __slab_free+0x74/0x270
> [   69.099239]  ? __slab_free+0x74/0x270
> [   69.099364]  ? vfree+0x16c/0x200
> [   69.099488]  ? kfree+0x14e/0x200
> [   69.099611]  ? vfree+0x16c/0x200
> [   69.099733]  ? load_module+0x104e/0x11c0
> [   69.099856]  ? kmalloc_trace+0x11e/0x240
> [   69.099980]  do_init_module+0x7d/0x240
> [   69.100102]  __x64_sys_finit_module+0x293/0x380
> [   69.100226]  do_syscall_64+0x89/0x110
> [   69.100347]  ? syscall_exit_work+0xaf/0xd0
> [   69.100466]  ? syscall_exit_to_user_mode+0x74/0x80
> [   69.100585]  ? do_syscall_64+0x98/0x110
> [   69.100703]  ? syscall_exit_work+0xaf/0xd0
> [   69.100820]  ? syscall_exit_to_user_mode+0x74/0x80
> [   69.100937]  ? do_syscall_64+0x98/0x110
> [   69.101050]  ? do_syscall_64+0x98/0x110
> [   69.101160]  ? do_syscall_64+0x98/0x110
> [   69.101263]  entry_SYSCALL_64_after_hwframe+0x73/0x7b
> [   69.101361] RIP: 0033:0x7f6446b1e3ed
> [   69.101457] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 29 0d 00 f7 d8 64 89 01 48
> [   69.101667] RSP: 002b:00007fff472969b8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000139
> [   69.101774] RAX: ffffffffffffffda RBX: 000056091ee62c00 RCX: 00007f6=
446b1e3ed
> [   69.101881] RDX: 0000000000000000 RSI: 000056091da20585 RDI: 0000000=
000000009
> [   69.101987] RBP: 000056091da20585 R08: 00007f6446bf1d00 R09: 0000000=
000000000
> [   69.102092] R10: 0000000000000050 R11: 0000000000000246 R12: 0000000=
000040000
> [   69.102196] R13: 000056091ee6a5d0 R14: 00007f64472970a8 R15: 0000560=
91ee625d0
> [   69.102299]  </TASK>
> [   69.102399] Modules linked in: btrfs(+) raid6_pq xor zstd_compress l=
zo_decompress lzo_compress efivarfs loop nvidia_drm(POE) nvidia_modeset(P=
OE) nvidia(POE) virtiofs virtio fuse virtio_ring ipt_REJECT nf_reject_ipv=
4 ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_mangle =
vhost_vsock vmw_vsock_virtio_transport_common vsock vhost_net vhost vhost=
_iotlb tun xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm=
_algo iptable_nat nf_nat xt_addrtype iptable_filter ip_tables br_netfilte=
r bridge stp llc overlay sr_mod cdrom snd_pcm_oss snd_mixer_oss vmw_vmci =
nct6775 hwmon_vid nct6775_core nf_log_syslog nft_log nft_ct nf_tables lib=
crc32c nfnetlink joydev ipv6 mei_me ee1004 mei pl2303 usbserial usb_stora=
ge coretemp hwmon intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp=
 snd_hda_codec_realtek snd_hda_codec_generic kvm_intel led_class snd_hda_=
codec_hdmi kvm irqbypass crc32c_intel sha512_ssse3 sha256_ssse3 snd_hda_i=
ntel sha1_ssse3 snd_intel_dspcfg aesni_intel snd_hda_codec crypto_simd sn=
d_hda_core
> [   69.102430]  cryptd snd_pcm rapl snd_timer i2c_i801 intel_cstate wmi=
_bmof intel_wmi_thunderbolt intel_uncore i2c_smbus rtc_cmos snd sd_mod so=
undcore thermal fan wmi acpi_pad button [last unloaded: nvidia(POE)]
> [   69.103752] CR2: 0000000000000208
> [   69.103902] ---[ end trace 0000000000000000 ]---
> [   69.259181] RIP: 0010:find_lock_delalloc_range+0x30/0x260 [btrfs]
> [   69.259364] Code: 57 41 56 41 55 41 54 53 48 83 ec 40 49 89 d6 49 89=
 f7 49 89 fc 65 48 8b 04 25 28 00 00 00 48 89 44 24 38 48 8b 87 40 fe ff =
ff <48> 8b 80 08 02 00 00 48 85 c0 74 09 48 8b a8 a0 0c 00 00 eb 05 bd
> [   69.259691] RSP: 0018:ffffa2c087cfb8a8 EFLAGS: 00010282
> [   69.259856] RAX: 0000000000000000 RBX: 0000000000000fff RCX: ffffa2c=
087cfb938
> [   69.260023] RDX: ffffa2c087cfb940 RSI: ffffdf1544fbac80 RDI: ffffa08=
5c86b05f0
> [   69.260191] RBP: 0000000000000000 R08: 0000000000000010 R09: 0000000=
000000000
> [   69.260360] R10: ffffa0852f8e8a20 R11: ffffffffbb22eb70 R12: ffffa08=
5c86b05f0
> [   69.260531] R13: ffffdf1544fbac80 R14: ffffa2c087cfb940 R15: ffffdf1=
544fbac80
> [   69.260704] FS:  00007f6447289740(0000) GS:ffffa0a3edc00000(0000) kn=
lGS:0000000000000000
> [   69.260882] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   69.261061] CR2: 0000000000000208 CR3: 0000000176cec006 CR4: 0000000=
0007706f0
> [   69.261242] PKRU: 55555554
> [   69.261423] note: modprobe[9701] exited with irqs disabled
>=20
> --
> Hiroshi Takekawa <sian@big.or.jp>

P.S.:

#regzbot ^introduced 70f49f7b9aa3df
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=3D218720
#regzbot title: btrfs: sanity tests fails and causes Oops
#regzbot ignore-activity

