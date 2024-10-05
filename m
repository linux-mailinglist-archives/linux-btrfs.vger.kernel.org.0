Return-Path: <linux-btrfs+bounces-8568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC78991439
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 06:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF128127B
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2024 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1525761;
	Sat,  5 Oct 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="w/YWKUeZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F92A48
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Oct 2024 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728100863; cv=none; b=UU0xagF5vsHZfsoYROPnb8vJvMMjIByPOK5ilE5hV73UpxZ6ZnniwjnzFrn6Yb2/2oYaC4k2sEeoqlJi6vX3TAHwQBq6u5mpQITGHwYVqBaHaYyOXEH9fBOhEYA+Tor24eYw/6bau1KB9dgqucjPzPA4xvTTAVEUZXOSVXbsc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728100863; c=relaxed/simple;
	bh=rxYnjSm7iOiKSqV+BuwjtAEYkttUNP/CsiT29eLIvpo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FbKdxLiNUONob1qbUDQbKv4gvq52A10jEp733KlJMMDtdsroTfMSA4sUe1XTCNnlgnGiLJ23/0avZ9eAugnvSFozqoKAhbuTxYiCqbusoCgy/0Di+kOqPiKn390YhVxItdo5hXa/lO8PtqIMz3H5ceCY0ZSSQx0gABGBn+yBqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=w/YWKUeZ; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1728100855;
	bh=vc82mlfiwxSVvtwxdHWLe7oU50oLteVGqPb9/x6GPKI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=w/YWKUeZvORBiCZohO8hZECO1/Giav97ZTtlfWqxxGM1LXbenJSZTsUJAyILFRKZ5
	 esmedyifSp63hhiTf1yoMqd2oVJsqkLPln2UIpf1qPHwMK47v+531XphXMaK1Wpjx7
	 SR9EN50e1+gzznGpoKZ6COf6XLMGbTl/GkuFA1T8=
X-QQ-mid: bizesmtpip4t1728100854t5iau0f
X-QQ-Originating-IP: btfqHrd7d2P5xmktbWHE+XnPV34lkRBBMHwhfs+Zxp0=
Received: from [IPV6:2408:8214:5911:6ac0:4a3a: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Sat, 05 Oct 2024 12:00:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3224445085450126783
Message-ID: <C88FE3873E1B7917+43baca4b-4158-4a5d-a66c-2ab05e0b5373@bupt.moe>
Date: Sat, 5 Oct 2024 12:00:53 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Yuwei Han <hrx@bupt.moe>
Subject: 6.12-rc1 oops when rebalancing to RAID1 with RST enabled.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NTh0zKNfFfcQJjPCORYgNuxO9dL2EW1NgghlCLxjkXWcA0PvagMKj8tO
	3rJG/mPb0/aroNDzjxmH64vlhBcAyY+wWKdgM98iDMPLBpDN8A4qKirAtlqrIXGdO62BSCc
	IBf/lR9VGQPsIRxrfcaOMG2Q1gss6ZvceBkEdEPdHb7O1/rjcfTY1l63I6cOE+wiFA4X3Rl
	nUeyyAIh4fP/7SicGmWRrEcPlfRu0wAgQ6i7f5bDs8wN/Veih/Ytpf9Y2sazx5rF1zFLlBV
	Lj58UZIR4vyavjwUb/zqa4oB/ArWVnY4RzOMMGoirrPsFiHmrlvsUL2QwA4ScxkXch6WC6I
	fQdGg4rHc/wwCSpL3OvzSCApIce6uIQ/tUR9eK105C8DZkXLrLETkqopgd80hpFGMWbi8gK
	Vr+Hmo8T81zmXsQdyZoL5uyzWGjZ9xiGHnnMnlmFcCPNRFFY/pZhe9DqwcHo5H809IkMu6n
	SAryRAxtixXC4FPBHELkg9qGgvJd2g00/+9PJ4d+UrRQ0FzLFaPdLtBApUrTFVOuxKTHvSh
	eHk1vNuxPpp+dznyc6r4LHgF9mXeEWUWjwWrXmAzyZuDuj3p0e6/INrBRmjJhniZV6d4Mzs
	HpZSUZ1YBs9nWL2x2KAgK/aqSKNk2vlWMpe32GhrcNw4CO/OfcoQHcRJ/c/3Je72ZWKi/cN
	4F0aNVB850kmjeDXmjfG6X97l+9wxyzvnZvCnnm9dj5EVEsDKHaE5pMyZQg0ucBHqWChfZA
	CbQUkGIntH85Fcf83wndJkCQxYxwLRpSymMv/OJS13rGWJxi9rD3mbk4J8oAE1KK9PLlcKB
	LACkw1mB+1Ni67KzDKXj65zVil4BAgW+0QKy5b7OyFacIohpiYUELPeltQgNOfHNsq2oTyX
	BcZ9b6/+ySc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi, all
I am testing 6.12-rc1 RAID1 with RST enabled and kernel is patched with 
Jain's new raid1 balancing methods. Unfortunately it oops when I tried 
to balance to RAID1 profile with other io performing (transmission-daemon).

# ./btrfs version
btrfs-progs v6.11
+EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin
#./btrfs balance start -dconvert=raid1 /data2

dmesg:
[62742.559286] BTRFS error (device sdc): zoned: write pointer offset 
mismatch of zones in raid1 profile
[62742.568397] CPU 6 Unable to handle kernel paging request at virtual 
address 0000000000000058, era == 9000000003be4530, ra == 9000000003be4510
[62742.581048] Oops[#1]:
[62742.583310] CPU: 6 UID: 0 PID: 5526 Comm: btrfs Not tainted 
6.12.0-rc1-dirty #6
[62742.590583] Hardware name: Loongson 
Loongson-3A6000-7A2000-1w-V0.1-EVB/Loongson-3A6000-7A2000-1w-EVB-V1.21, 
BIOS Loongson-UDK2018-V4.0.05823-stable202408
[62742.604337] pc 9000000003be4530 ra 9000000003be4510 tp 
9000000199dd8000 sp 9000000199ddad80
[62742.612648] a0 900000014cbc1010 a1 0000000000000000 a2 
0000000010000000 a3 0000000000000001
[62742.620957] a4 0000000000000003 a5 0000000000000000 a6 
00000000000553e0 a7 900000010458be40
[62742.629264] t0 0000000010000000 t1 0000000010000000 t2 
0000000000000001 t3 00000000018c9006
[62742.637572] t4 00000000018c9006 t5 0000000000000004 t6 
0000000000000000 t7 9000000101563600
[62742.645881] t8 900000000b80e3f0 u0 900000014cbc1000 s9 
9000000005c64000 s0 900000014cbc1000
[62742.654190] s1 0000000000000000 s2 900000014cbc1010 s3 
0000000010000000 s4 0000000000000001
[62742.662498] s5 900000009336b180 s6 0000000000000000 s7 
9000000199ddadd8 s8 9000000199ddade0
[62742.670806]    ra: 9000000003be4510 
__btrfs_add_free_space_zoned+0x50/0x1e0
[62742.677738]   ERA: 9000000003be4530 
__btrfs_add_free_space_zoned+0x70/0x1e0
[62742.684667]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[62742.690827]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[62742.695173]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[62742.699947]  ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
[62742.704716] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[62742.710180]  BADV: 0000000000000058
[62742.713646]  PRID: 0014d000 (Loongson-64bit, Loongson-3A6000)
[62742.719358] Modules linked in: sha1_generic algif_hash af_alg tun 
wireguard libchacha20poly1305 libcurve25519_generic libpoly1305 
libchacha nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat 
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw 
iptable_security cfg80211 rfkill ip_set nf_tables iptable_filter amdgpu 
binfmt_misc vfat fat drm_exec spi_loongson_pci amdxcp drm_buddy kvm 
gpu_sched drm_suballoc_helper spi_loongson_core drm_display_helper 
dm_multipath fuse efi_pstore pstore nfnetlink efivarfs ip_tables
[62742.783134] Process btrfs (pid: 5526, threadinfo=0000000013109ed8, 
task=00000000fa20e533)
[62742.791274] Stack : 9000000199ddadcc 9000000199ddadd8 
900000012f9e70b0 9000000005281000
[62742.799247]         900000014cbc1000 0000000000000000 
0000000010000000 900000012f9e7000
[62742.807218]         00000076d0000000 9000000003c4bfb8 
90000001015635f0 0000000000000000
[62742.815189]         0000000000000000 b4738f5546011d46 
0000000010000000 900000012fa2fa80
[62742.823160]         0000000000000000 0000000000000014 
0000000010000000 00000076d0000000
[62742.831130]         9000000102be6220 900000012f9e7000 
900000014cbc1000 9000000003c4f8c8
[62742.839103]         0000000000000002 9000000093369e00 
900000012f9e7000 9000000102be6220
[62742.847072]         0000000000000000 0000000000000014 
0000000010000000 9000000003bb9e18
[62742.855041]         9000000199ddaec0 0000000000000002 
900000011d866800 9000000199ddaf80
[62742.863011]         0000000010000000 9000000199ddaf78 
9000000199ddaf70 0000000010000000
[62742.870981]         ...
[62742.873414] Call Trace:
[62742.873420] [<9000000003be4530>] __btrfs_add_free_space_zoned+0x70/0x1e0
[62742.882515] [<9000000003c4bfb4>] btrfs_add_new_free_space+0xf4/0x1a0
[62742.888842] [<9000000003c4f8c4>] btrfs_make_block_group+0x164/0x360
[62742.895083] [<9000000003bb9e14>] btrfs_create_chunk+0x734/0x1060
[62742.901064] [<9000000003c51378>] btrfs_chunk_alloc+0x1f8/0x820
[62742.906872] [<9000000003b4e5bc>] find_free_extent.isra.0+0xd3c/0x18a0
[62742.913287] [<9000000003b586cc>] btrfs_reserve_extent+0x16c/0x3a0
[62742.919356] [<9000000003b591f8>] btrfs_alloc_tree_block+0x118/0xac0
[62742.925598] [<9000000003b3de48>] btrfs_force_cow_block+0x1c8/0x10e0
[62742.931838] [<9000000003b3eee4>] btrfs_cow_block+0x184/0x3e0
[62742.937471] [<9000000003b4741c>] btrfs_search_slot+0x9dc/0x1760
[62742.943364] [<9000000003b50288>] lookup_inline_extent_backref+0x288/0xa20
[62742.950123] [<9000000003b51890>] lookup_extent_backref+0x50/0x140
[62742.956189] [<9000000003b536b4>] __btrfs_free_extent.isra.0+0x174/0x1780
[62742.962861] [<9000000003b55310>] __btrfs_run_delayed_refs+0x650/0x1060
[62742.969359] [<9000000003b55d64>] btrfs_run_delayed_refs+0x44/0x1a0
[62742.975512] [<9000000003b72de0>] btrfs_commit_transaction+0x80/0x1240
[62742.981923] [<9000000003bf9e00>] prepare_to_relocate+0x100/0x1c0
[62742.987903] [<9000000003bfe0a4>] relocate_block_group+0x64/0x640
[62742.993882] [<9000000003bfe96c>] btrfs_relocate_block_group+0x2ec/0x5c0
[62743.000466] [<9000000003bbb960>] btrfs_relocate_chunk+0x40/0x1e0
[62743.006445] [<9000000003bbc640>] btrfs_balance+0xb40/0x1ca0
[62743.011992] [<9000000003bd1c4c>] btrfs_ioctl+0x362c/0x3d00
[62743.017453] [<90000000038a5ad8>] sys_ioctl+0x338/0x12c0
[62743.022652] [<900000000490ccd0>] do_syscall+0xb0/0x160
[62743.027767] [<9000000003561518>] handle_syscall+0xb8/0x158

[62743.034703] Code: 0010ebac  680139ac  03400000 <24005b18> 0015035e 
00408318  40001760  28c822ed  68012fad

[62743.045914] ---[ end trace 0000000000000000 ]---

