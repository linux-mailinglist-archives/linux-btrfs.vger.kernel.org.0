Return-Path: <linux-btrfs+bounces-8233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19093986921
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 00:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D472FB250FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49F156F23;
	Wed, 25 Sep 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="TkFpVaHd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHAyRjho"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20E148838
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303077; cv=none; b=SDABOfKKxT+6smIm0JeTBlhY6bBZ2u0O+lx905MM9YuG2/LiX4OKtypkrpEW8OU/hPm1Ol7WMBIAuS2NsayGTmCdKPj0f/GW0aKuVVOVjmGgXgbqxYfLYa5B4Q+mSsIAL9CcAG8VqndXss83lDziUovflPv2t73dftnY2bBrsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303077; c=relaxed/simple;
	bh=RC//bXR79Ed6fJ9XOpDkHTsrySQL9Sc4dz4z4ujZbgs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KdiL7wDZh2YLui9yzWqXnN4oz/fiVrWdlb9FSRWqA+mTtB0Ij3SkZlD9sF1zX+Fvp+/UdI7WgiLED4HVQQoMrWXOUWsiPWndsVlIK0d8CYM+ojeot8ek9EGtjUf2CY4adZdnZzh1lrUEjsVKLJePWSvgEDM3Sx7dwITGfSUmSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=TkFpVaHd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHAyRjho; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A80A2114015A;
	Wed, 25 Sep 2024 18:24:32 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Wed, 25 Sep 2024 18:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1727303072; x=1727389472; bh=/TXm/U5SqVh/wU+GMfQPS
	owzju5A5J+o4dJ0UU88xUQ=; b=TkFpVaHdbJU9XNSRVgtKxP5+vvjzvMMgP8LAx
	i486te7bmJLT3o08Th5RghhPk7ARqTmVWv+g2+W4oTJaSDc30Gug8vKqq6nTv3OM
	EXdh+i81nAcrSJwafFdviunT6C29Sy4s5Q6SIBKfogJl8ikWrDCK/13J3OhcMYMZ
	oN0l4DRXPhszYra+CwAP9IkYBDHt5PakLTskasVEGpX8UZgmG7mHouhLD5vSXcpp
	U6X9e/OhNC7zpEG2z78Z80B+EjjKvq4uPj7w/ITF0cEo6wakud6JWALEkhkn8+nE
	vabyetoxb6Q+wXSyUG/bgydoSV8Fc9zGfIfiKC4vLSn0kAHfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727303072; x=
	1727389472; bh=/TXm/U5SqVh/wU+GMfQPSowzju5A5J+o4dJ0UU88xUQ=; b=i
	HAyRjhoy2dCw0YWpKyj7vT4HdfessELdpiWK/3+eSoE8KoYbpu3MZiHemSOCVWUl
	6Ry4uJhyLhyv3S0vK9QZqw4vaopxgZafkS+QJ4+PWqqz95XZQfYo8AOWUeDp9UyS
	A+CCUqJldByC0ttHZvYwY16WA9ftB/QIKDFRoAO7C3PQdst8aNAJqL0/ubLE8QYE
	Ea2jlq02LWf04OBMrLeHceTOxMGREil2zoriTv6bnOyIvq5v6nfkqNNDQ9+t8oKZ
	6jyIfN9e9b+hq7/XrHVhrUj8b+uqgDV40D3iS2OZ9odnvbOR3oCMgaVmGGzWyaUN
	mZZhWkh3dLBCzLK8gGeng==
X-ME-Sender: <xms:oI30ZjbsxYOAYwHJMLdYroGGx1kCNDSxDavHiZfr6FZInirTTBVujA>
    <xme:oI30ZiYzPMuoPuamh87--WipA6kVSt1y0MCvMeVC02zLfVyuBLCno_Ci7l2LEZ68N
    cxUb9RpEyhpe6lTYcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvg
    hmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepveekteevieffleeiudektdei
    gfegheejhedugeeigeffjeevkedttdfgleehvefgnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhope
    dvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvfhgrnhhnnhgruhesghhm
    rghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:oI30Zl9D_rB-Dxkg_JzcAqWGiweyX5c6K_jUlNRJhOrZapp8KzFZBw>
    <xmx:oI30Zpp1QY-KX-zAECuo5Kg141F_EHgbSSG4aZTPCYrVUYm4Rso5rA>
    <xmx:oI30ZuoywwCV_qk41RTJ-AHJkwj7SuyAErXcsTJ5gafFNUtyxb9EhQ>
    <xmx:oI30ZvSFeQ-XJ8Qm8SU8aICsLJOVd8PQzieBUg1KSNDxtLStmU3J5g>
    <xmx:oI30ZjDaE-ABtL1wGRZj3fbH7mYG8gIg5rLmdLh0fRuj3q6UtYUA2_Dc>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 599551C20066; Wed, 25 Sep 2024 18:24:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 18:24:11 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Stefan N" <stefannnau@gmail.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <fb093ca9-2deb-4eae-93ee-8442e01e7470@app.fastmail.com>
In-Reply-To: 
 <CA+W5K0pnbNZL+rPu=vF1TTYnrx+=qhUSuNjx-ueDNc=ip+yjpA@mail.gmail.com>
References: 
 <CA+W5K0pYAyHS6K5Oy2h03KKgP9+6Q0stOYBrNY7vSmA+J4SdfA@mail.gmail.com>
 <CA+W5K0pnbNZL+rPu=vF1TTYnrx+=qhUSuNjx-ueDNc=ip+yjpA@mail.gmail.com>
Subject: Re: Recovering from/avoiding metadata space exhaustion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

My opinions only. And hopefully someone will push back on it.

You need to run a more recent kernel that's also closer to kernel.org source. And latest btrfs-progs. That'd be a mostly unmodified 6.10.11 or 6.11.0 kernel. There are distro kernels that offer this but you might have to dig around or ask for where newer kernels are kept. Or build the kernel yourself, which would allow you to enable CONFIG_BTRFS_ASSERT and it might not be a bad idea to enable KASAN.

None of this may change the situation you're in, either preventing it or fixing it, but upstream development on this list tends to work on mainline and linux-next, there's not always a lot of familiarity what the code base state is in specific distributions.

Recuring themes: Have you tested it with the latest kernel.org kernel to see if the bug is fixed? Do you have complete dmesg for the boot the problem first occurred in and the dmesg for the boot the problem is occuring now? That's not always easy to retain or recover but file systems are the most non-determinstic things in computing. And therefore quite a lot of information is needed to understand a problem and suggest a solution.

--
Chris Murphy




On Wed, Sep 25, 2024, at 8:02 AM, Stefan N wrote:
> Hi all,
>
> Please help!
>
> Since & in addition to my previous email, I have now hit an impasse,
> where I'm unable to mount even with -o
> skip_balance,degraded,clear_cache and my <2 month old array is
> unmountable as rw :(
>
> To rectify the situation I'd previously reported in this chain, I've
> been trying to get the dconvert to complete, and have been having the
> ro issue recurring every few days, resulting in me following a process
> of:
> 1) mount -o skip_balance,degraded
> 2) add a temporary device (1tb usb ssd)
> 3) remount normally
> 4) delete the temporary device
> 5) dconvert=raid6,soft
>
> Some output obtained hours/days before the current error state (likely
> while a dconvert was in progress, hence lower unallocated data than
> expected)
> $ btrfs fi usage /mnt/array/
> Overall:
>     Device size:                 162.81TiB
>     Device allocated:            130.20TiB
>     Device unallocated:           32.61TiB
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Used:                        129.00TiB
>     Free (estimated):             25.60TiB      (min: 11.78TiB)
>     Free (statfs, df):            12.93TiB
>     Data ratio:                       1.32
>     Metadata ratio:                   3.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                 yes      (data)
>
> Data,single: Size:14.62TiB, Used:14.61TiB (99.91%)
>    /dev/sdd1       7.31TiB
>    /dev/sdb1       7.31TiB
>
> Data,RAID6: Size:83.72TiB, Used:82.86TiB (98.97%)
>    /dev/sdd1       2.43TiB
>    /dev/sdb1       2.43TiB
>    /dev/sdh1      15.77TiB
>    /dev/sde1      15.77TiB
>    /dev/sdm1      15.77TiB
>    /dev/sdg1      15.77TiB
>    /dev/sda1      15.77TiB
>    /dev/sdf1      15.77TiB
>    /dev/sdc1      15.77TiB
>    /dev/sdl        1.00GiB
>
> Metadata,RAID1C3: Size:109.00GiB, Used:108.84GiB (99.86%)
>    /dev/sdd1       3.00GiB
>    /dev/sdb1       1.00GiB
>    /dev/sde1     109.00GiB
>    /dev/sdm1      27.00GiB
>    /dev/sdg1     108.00GiB
>    /dev/sda1      26.00GiB
>    /dev/sdf1      27.00GiB
>    /dev/sdc1      26.00GiB
>
> System,RAID1C3: Size:32.00MiB, Used:6.41MiB (20.02%)
>    /dev/sdb1      32.00MiB
>    /dev/sde1      32.00MiB
>    /dev/sdg1      32.00MiB
>
> Unallocated:
>    /dev/sdd1      10.27TiB
>    /dev/sdb1      10.27TiB
>    /dev/sdh1     611.08GiB
>    /dev/sde1       4.13TiB
>    /dev/sdm1     584.08GiB
>    /dev/sdg1       4.13TiB
>    /dev/sda1     585.08GiB
>    /dev/sdf1     584.08GiB
>    /dev/sdc1     585.08GiB
>    /dev/sdl      952.87GiB
>
> Latest upgrade is now to
> $ uname -a
> Linux nas.fail 6.8.0-45-generic #45-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug
> 30 12:02:04 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
> $ btrfs --version
> btrfs-progs v6.6.3
>
> The cause of the current read-only state while running the dconvert
> (note slightly older kernel)
> BTRFS info (device sdd1): relocating block group 10305804435456 flags data
> BTRFS info (device sdd1): found 8 extents, stage: move data extents
> BTRFS info (device sdd1): found 8 extents, stage: update data pointers
> BTRFS info (device sdd1): relocating block group 10304730693632 flags data
> BTRFS info (device sdd1): found 8 extents, stage: move data extents
> BTRFS info (device sdd1): found 8 extents, stage: update data pointers
> _btrfs_printk: 9188 callbacks suppressed
> BTRFS error (device sdd1): failed to run delayed ref for logical
> 189494664708096 num_bytes 16384 type 176 action 1 ref_mod 1: -28
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 2 PID: 2081534 at fs/btrfs/extent-tree.c:2249
> btrfs_run_delayed_refs+0x125/0x130 [btrfs]
> Modules linked in: cpuid ipt_REJECT nf_reject_ipv4 iptable_filter
> xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
> curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
> libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
> xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
> bridge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211
> binfmt_misc nls_iso8859_1 amdgpu intel_rapl_msr snd_hda_codec_realtek
> intel_rapl_common snd_hda_codec_generic snd_hda_codec_hdmi
> edac_mce_amd snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_amd
> amdxcp snd_hda_codec drm_exec kvm snd_hda_core snd_hwdep irqbypass
> gpu_sched drm_buddy drm_suballoc_helper rapl drm_ttm_helper wmi_bmof
> snd_pcm ttm snd_timer i2c_piix4 k10temp drm_display_helper snd cec
> rc_core soundcore ccp mac_hid dm_multipath bonding tls efi_pstore nfsd
> auth_rpcgss nfs_acl lockd grace sunrpc nfnetlink dmi_sysfs ip_tables
> x_tables autofs4 btrfs blake2b_generic raid10 raid456
> async_raid6_recov async_memcpy async_pq async_xor rct10dif_pclmul
> crc32_pclmul polyval_clmulni usb_storage polyval_generic
> ghash_clmulni_intel igb sha256_ssse3 sha1_ssse3 nvme mpt3sas
> i2c_algo_bit  video nvme_core scsi_transport_sas dca qlcnic nvme_auth
> wmi aesni_intel crypto_simd cryptd
> CPU: 2 PID: 2081534 Comm: btrfs Tainted: G        W
> 6.8.0-41-generic #41-Ubuntu
> Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
> P3.70 02/23/2022
> RIP: 0010:btrfs_run_delayed_refs+0x125/0x130 [btrfs]
> Code: 1b 49 8b 7c 24 60 89 da 48 c7 c6 a8 6a ae c0 e8 a1 48 0e 00 41
> b8 01 00 00 00 eb aa 89 de 48 c7 c7 d0 6a ae c0 e8 eb 09 bb c2 <0f> 0b
> eb e6 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffa54690667760 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffa54690667780 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff897e8ead6000
> R13: ffff898175b07200 R14: ffff898175b07358 R15: ffff897abf9c4d70
> FS:  0000720d96b8f380(0000) GS:ffff8981a0300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00006ef18dd54000 CR3: 000000017bf6e000 CR4: 00000000003506f0
> Call Trace:
>  <TASK>
>  ? show_regs+0x6d/0x80
>  ? __warn+0x89/0x160
>  ? btrfs_run_delayed_refs+0x125/0x130 [btrfs]
>  ? report_bug+0x17e/0x1b0
>  ? irq_work_queue+0x2f/0x70
>  ? handle_bug+0x51/0xa0
>  ? exc_invalid_op+0x18/0x80
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? btrfs_run_delayed_refs+0x125/0x130 [btrfs]
>  btrfs_write_dirty_block_groups+0x156/0x3c0 [btrfs]
>  commit_cowonly_roots+0x1cd/0x240 [btrfs]
>  btrfs_commit_transaction+0x540/0xbe0 [btrfs]
>  prepare_to_relocate+0x141/0x1d0 [btrfs]
>  relocate_block_group+0x6a/0x560 [btrfs]
>  btrfs_relocate_block_group+0x28c/0x3e0 [btrfs]
>  btrfs_relocate_chunk+0x40/0x1b0 [btrfs]
>  __btrfs_balance+0x308/0x560 [btrfs]
>  btrfs_balance+0x52e/0x990 [btrfs]
>  btrfs_ioctl_balance+0x24e/0x3c0 [btrfs]
>  btrfs_ioctl+0x8e3/0x13a0 [btrfs]
>  ? __fput+0x15e/0x2e0
>  __x64_sys_ioctl+0xa3/0xf0
>  x64_sys_call+0x143b/0x25c0
>  do_syscall_64+0x7f/0x180
>  ? do_sys_openat2+0x9f/0xe0
>  ? __x64_sys_openat+0x55/0xa0
>  ? syscall_exit_to_user_mode+0x89/0x260
>  ? do_syscall_64+0x8c/0x180
>  ? do_fault+0x109/0x350
>  ? handle_pte_fault+0x114/0x1d0
>  ? __handle_mm_fault+0x653/0x790
>  ? __count_memcg_events+0x6b/0x120
>  ? count_memcg_events.constprop.0+0x2a/0x50
>  ? handle_mm_fault+0xad/0x380
>  ? do_user_addr_fault+0x32c/0x670
>  ? irqentry_exit_to_user_mode+0x7e/0x260
>  ? irqentry_exit+0x43/0x50
>  ? exc_page_fault+0x94/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x78/0x80
> RIP: 0033:0x720d96924ded
> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00
> 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2
> 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> RSP: 002b:00007ffcfeb98c10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000720d96924ded
> RDX: 00007ffcfeb98d18 RSI: 00000000c4009420 RDI: 0000000000000003
> RBP: 00007ffcfeb98c60 R08: 0000000000000013 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffcfeb98d18 R14: 0000000000000000 R15: 0000000000000001
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS info (device sdd1: state A): dumping space info:
> BTRFS info (device sdd1: state A): space_info DATA has 3378427371520
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=114548488011776,
> used=111151002333184, pinned=1073741824, reserved=4046319616,
> may_use=124289024, readonly=13813956608 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info METADATA has -834977792
> free, is full
> BTRFS info (device sdd1: state A): space_info total=121332826112,
> used=121274580992, pinned=54558720, reserved=3686400,
> may_use=834977792, readonly=0 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info SYSTEM has 26460160
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=33554432,
> used=7094272, pinned=0, reserved=0, may_use=0, readonly=0
> zone_unusable=0
> BTRFS info (device sdd1: state A): global_block_rsv: size 536870912
> reserved 536854528
> BTRFS info (device sdd1: state A): trans_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_refs_rsv: size 218234880
> reserved 216596480
> BTRFS: error (device sdd1: state A) in btrfs_run_delayed_refs:2249:
> errno=-28 No space left
> BTRFS info (device sdd1: state EA): forced readonly
> BTRFS warning (device sdd1: state EA): Skipping commit of aborted transaction.
> BTRFS: error (device sdd1: state EA) in cleanup_transaction:2020:
> errno=-28 No space left
> BTRFS info (device sdd1: state EA): 1 enospc errors during balance
> BTRFS info (device sdd1: state EA): balance: ended with status: -30
> BTRFS error (device sdd1: state EA): level verify failed on logical
> 259977098330112 mirror 1 wanted 1 found 0
> BTRFS error (device sdd1: state EA): level verify failed on logical
> 259977098330112 mirror 2 wanted 1 found 0
> BTRFS error (device sdd1: state EA): level verify failed on logical
> 259977098330112 mirror 3 wanted 1 found 0
>
> Once in this state, here seem to be a few different paths the btrfs
> errors I've triggered depending on the mount flags, see below
> $ mount -o rw,degraded,clear_cache,skip_balance -U my-uuid-a-b-c /mnt/array
> mount: /mnt/array: mount(2) system call failed: No space left on device.
>        dmesg(1) may have more information after failed mount system call.
>
> BTRFS info (device sdd1): first mount of filesystem my-uuid-a-b-c
> BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
> BTRFS info (device sdd1): using free-space-tree
> BTRFS info (device sdd1): rebuilding free space tree
> -----------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 2 PID: 7545 at fs/btrfs/free-space-tree.c:1348
> btrfs_rebuild_free_space_tree+0x1a5/0x1b0 [btrfs]
> Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
> xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
> curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
> libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
> xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
> bridge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211
> binfmt_misc nls_iso8859_1 amdgpu intel_rapl_msr intel_rapl_common
> edac_mce_amd snd_hda_codec_realtek kvm_amd snd_hda_codec_generic
> snd_hda_codec_hdmi amdxcp drm_exec gpu_sched snd_hda_intel drm_buddy
> drm_suballoc_helper snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> kvm snd_hda_core drm_ttm_helper snd_hwdep ttm snd_pcm irqbypass
> drm_display_helper snd_timer rapl snd cec wmi_bmof ccp i2c_piix4
> k10temp rc_core soundcore mac_hid sch_fq_codel dm_multipath bonding
> tls nfsd auth_rpcgss nfs_acl lockd efi_pstore grace sunrpc nfnetlink
> dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 uas crct10dif_pclmul crc32_pclmul
> polyval_clmulni usb_storage polyval_generic ghash_clmulni_intel
> sha256_ssse3 sha1_ssse3 mpt3sas video nvme igb ahci nvme_core
> i2c_algo_bit libahci nvme_auth dca qlcnic raid_class xhci_pci
> xhci_pci_renesas scsi_transport_sas wmi aesni_intel crypto_simd cryptd
> CPU: 2 PID: 7545 Comm: mount Tainted: G        W
> 6.8.0-45-generic #45-Ubuntu
> Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
> P3.70 02/23/2022
> RIP: 0010:btrfs_rebuild_free_space_tree+0x1a5/0x1b0 [btrfs]
> Code: 60 44 89 e2 48 c7 c6 f8 9b 78 c0 e8 e5 c3 01 00 41 b8 01 00 00
> 00 e9 44 ff ff ff 44 89 e6 48 c7 c7 20 9c 78 c0 e8 bb ed c4 db <0f> 0b
> eb e2 e8 92 a8 d7 dc 66 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffb25dc47ef750 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff92ba99dad0d8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffb25dc47ef790 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffe4
> R13: ffff92ba5198b0a8 R14: ffff92ba37bed000 R15: ffff92ba50035180
> FS:  00007d746aa68800(0000) GS:ffff92c120300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000263010 CR3: 000000011ffb4000 CR4: 00000000003506f0
> Call Trace:
>  <TASK>
>  ? show_regs+0x6d/0x80
>  ? __warn+0x89/0x160
>  ? btrfs_rebuild_free_space_tree+0x1a5/0x1b0 [btrfs]
>  ? report_bug+0x17e/0x1b0
>  ? handle_bug+0x51/0xa0
>  ? exc_invalid_op+0x18/0x80
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? btrfs_rebuild_free_space_tree+0x1a5/0x1b0 [btrfs]
>  btrfs_start_pre_rw_mount+0x84/0x620 [btrfs]
>  ? btrfs_get_root_ref+0x288/0x3a0 [btrfs]
>  open_ctree+0xd1c/0xed0 [btrfs]
>  ? snprintf+0x51/0x80
>  btrfs_get_tree_super+0x2d6/0x3a0 [btrfs]
>  btrfs_get_tree+0x18/0x30 [btrfs]
>  vfs_get_tree+0x2a/0x100
>  fc_mount+0x12/0x60
>  btrfs_get_tree_subvol+0x13c/0x480 [btrfs]
>  ? vfs_parse_fs_string+0x7d/0xb0
>  btrfs_get_tree+0x25/0x30 [btrfs]
>  vfs_get_tree+0x2a/0x100
>  do_new_mount+0x1a0/0x340
>  path_mount+0x1e0/0x830
>  ? putname+0x5b/0x80
>  __x64_sys_mount+0x127/0x160
>  x64_sys_call+0x1df5/0x25c0
>  do_syscall_64+0x7f/0x180
>  ? __legitimize_path+0x2d/0x70
>  ? try_to_unlazy+0x60/0xe0
>  ? terminate_walk+0x65/0x100
>  ? path_lookupat+0x96/0x1b0
>  ? filename_lookup+0xe4/0x200
>  ? mntput_no_expire+0x51/0x260
>  ? generic_permission+0x39/0x230
>  ? mntput+0x24/0x50
>  ? path_put+0x1e/0x30
>  ? do_faccessat+0x1c2/0x2f0
>  ? syscall_exit_to_user_mode+0x89/0x260
>  ? do_syscall_64+0x8c/0x180
>  ? syscall_exit_to_user_mode+0x89/0x260
>  ? do_syscall_64+0x8c/0x180
>  ? __count_memcg_events+0x6b/0x120
>  ? syscall_exit_to_user_mode+0x89/0x260
>  ? do_syscall_64+0x8c/0x180
>  ? irqentry_exit_to_user_mode+0x7e/0x260
>  ? irqentry_exit+0x43/0x50
>  ? exc_page_fault+0x94/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x78/0x80
> RIP: 0033:0x7d746a92af0e
> Code: 48 8b 0d 0d 7f 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d da 7e 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffcb2af5f48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00005757d0922b00 RCX: 00007d746a92af0e
> RDX: 00005757d09298f0 RSI: 00005757d0923180 RDI: 00005757d09231e0
> RBP: 00007ffcb2af5fb0 R08: 00005757d0928af0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00005757d09231e0
> R13: 00005757d0923180 R14: 00005757d09298f0 R15: 00005757d0922c60
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS info (device sdd1: state A): dumping space info:
> BTRFS info (device sdd1: state A): space_info DATA has 3383098413056
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=114548488011776,
> used=111151575642112, pinned=0, reserved=0, may_use=0,
> readonly=13813956608 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info METADATA has -537149440
> free, is full
> BTRFS info (device sdd1: state A): space_info total=121332826112,
> used=121276203008, pinned=0, reserved=56623104, may_use=537149440,
> readonly=0 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info SYSTEM has 26460160
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=33554432,
> used=7094272, pinned=0, reserved=0, may_use=0, readonly=0
> zone_unusable=0
> BTRFS info (device sdd1: state A): global_block_rsv: size 536870912
> reserved 536870912
> BTRFS info (device sdd1: state A): trans_block_rsv: size 262144 reserved 262144
> BTRFS info (device sdd1: state A): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_refs_rsv: size 5122818048
> reserved 16384
> BTRFS: error (device sdd1: state A) in
> btrfs_rebuild_free_space_tree:1348: errno=-28 No space left
> BTRFS warning (device sdd1: state EA): failed to rebuild free space tree: -28
> BTRFS warning (device sdd1: state EA): Skipping commit of aborted transaction.
> BTRFS: error (device sdd1: state EA) in cleanup_transaction:2020:
> errno=-28 No space left
> BTRFS error (device sdd1: state EA): commit super ret -30
> BTRFS error (device sdd1: state EA): open_ctree failed
>
> $ mount /mnt/array
> BTRFS info (device sdd1): first mount of filesystem my-uuid-a-b-c
> BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
> BTRFS info (device sdd1): using free-space-tree
> BTRFS error (device sdd1): failed to run delayed ref for logical
> 189538519531520 num_bytes 16384 type 176 action 1 ref_mod 1: -28
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 1 PID: 7786 at fs/btrfs/extent-tree.c:2249
> btrfs_run_delayed_refs+0x125/0x130 [btrfs]
> Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
> xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
> curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
> libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
> xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
> bridge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211
> binfmt_misc nls_iso8859_1 amdgpu intel_rapl_msr intel_rapl_common
> edac_mce_amd snd_hda_codec_realtek kvm_amd snd_hda_codec_generic
> snd_hda_codec_hdmi amdxcp drm_exec gpu_sched snd_hda_intel drm_buddy
> drm_suballoc_helper snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> kvm snd_hda_core drm_ttm_helper snd_hwdep ttm snd_pcm irqbypass
> drm_display_helper snd_timer rapl snd cec wmi_bmof ccp i2c_piix4
> k10temp rc_core soundcore mac_hid sch_fq_codel dm_multipath bonding
> tls nfsd auth_rpcgss nfs_acl lockd efi_pstore grace sunrpc nfnetlink
> dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 uas crct10dif_pclmul crc32_pclmul
> polyval_clmulni usb_storage polyval_generic ghash_clmulni_intel
> sha256_ssse3 sha1_ssse3 mpt3sas video nvme igb ahci nvme_core
> i2c_algo_bit libahci nvme_auth dca qlcnic raid_class xhci_pci
> xhci_pci_renesas scsi_transport_sas wmi aesni_intel crypto_simd cryptd
> CPU: 1 PID: 7786 Comm: mount Tainted: G        W
> 6.8.0-45-generic #45-Ubuntu
> Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
> P3.70 02/23/2022
> RIP: 0010:btrfs_run_delayed_refs+0x125/0x130 [btrfs]
> Code: 1b 49 8b 7c 24 60 89 da 48 c7 c6 98 0a 78 c0 e8 31 40 0e 00 41
> b8 01 00 00 00 eb aa 89 de 48 c7 c7 c0 0a 78 c0 e8 0b 6a d1 db <0f> 0b
> eb e6 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffb25dc4a87800 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffb25dc4a87820 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff92ba5198bc78
> R13: ffff92ba001c6400 R14: ffff92ba001c6558 R15: ffff92badc163570
> FS:  00007bb92c6da800(0000) GS:ffff92c120280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001e2b7d8 CR3: 000000014fac0000 CR4: 00000000003506f0
> Call Trace:
>  <TASK>
>  ? show_regs+0x6d/0x80
>  ? __warn+0x89/0x160
>  ? btrfs_run_delayed_refs+0x125/0x130 [btrfs]
>  ? report_bug+0x17e/0x1b0
>  ? handle_bug+0x51/0xa0
>  ? exc_invalid_op+0x18/0x80
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? btrfs_run_delayed_refs+0x125/0x130 [btrfs]
>  btrfs_write_dirty_block_groups+0x156/0x3c0 [btrfs]
>  commit_cowonly_roots+0x1cd/0x240 [btrfs]
>  btrfs_commit_transaction+0x540/0xbe0 [btrfs]
>  btrfs_recover_relocation+0x2f4/0x5d0 [btrfs]
>  btrfs_start_pre_rw_mount+0x360/0x620 [btrfs]
>  open_ctree+0xd1c/0xed0 [btrfs]
>  ? snprintf+0x51/0x80
>  btrfs_get_tree_super+0x2d6/0x3a0 [btrfs]
>  btrfs_get_tree+0x18/0x30 [btrfs]
>  vfs_get_tree+0x2a/0x100
>  fc_mount+0x12/0x60
>  btrfs_get_tree_subvol+0x13c/0x480 [btrfs]
>  ? btrfs_parse_param+0x52/0x8d0 [btrfs]
>  btrfs_get_tree+0x25/0x30 [btrfs]
>  vfs_get_tree+0x2a/0x100
>  do_new_mount+0x1a0/0x340
>  path_mount+0x1e0/0x830
>  ? putname+0x5b/0x80
>  __x64_sys_mount+0x127/0x160
>  x64_sys_call+0x1df5/0x25c0
>  do_syscall_64+0x7f/0x180
>  ? syscall_exit_to_user_mode+0x89/0x260
>  ? do_syscall_64+0x8c/0x180
>  ? do_syscall_64+0x8c/0x180
>  ? count_memcg_events.constprop.0+0x2a/0x50
>  ? handle_mm_fault+0xad/0x380
>  ? do_user_addr_fault+0x32c/0x670
>  ? irqentry_exit_to_user_mode+0x7e/0x260
>  ? irqentry_exit+0x43/0x50
>  ? exc_page_fault+0x94/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x78/0x80
> RIP: 0033:0x7bb92c52af0e
> Code: 48 8b 0d 0d 7f 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d da 7e 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffdd46a80e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00005ecfa5e51b00 RCX: 00007bb92c52af0e
> RDX: 00005ecfa5e51f10 RSI: 00005ecfa5e541f0 RDI: 00005ecfa5e52260
> RBP: 00007ffdd46a8150 R08: 0000000000000000 R09: 00007ffdd46a81c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00005ecfa5e52260
> R13: 00005ecfa5e541f0 R14: 00005ecfa5e51f10 R15: 00005ecfa5e51c60
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS info (device sdd1: state A): dumping space info:
> BTRFS info (device sdd1: state A): space_info DATA has 3383098413056
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=114548488011776,
> used=111151575642112, pinned=0, reserved=0, may_use=0,
> readonly=13813956608 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info METADATA has -536821760
> free, is full
> BTRFS info (device sdd1: state A): space_info total=121332826112,
> used=121276514304, pinned=56229888, reserved=81920, may_use=536821760,
> readonly=0 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info SYSTEM has 26460160
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=33554432,
> used=7094272, pinned=0, reserved=0, may_use=0, readonly=0
> zone_unusable=0
> BTRFS info (device sdd1: state A): global_block_rsv: size 536870912
> reserved 536805376
> BTRFS info (device sdd1: state A): trans_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_refs_rsv: size 23068672
> reserved 16384
> BTRFS: error (device sdd1: state A) in btrfs_run_delayed_refs:2249:
> errno=-28 No space left
> BTRFS warning (device sdd1: state EA): Skipping commit of aborted transaction.
> BTRFS: error (device sdd1: state EA) in cleanup_transaction:2020:
> errno=-28 No space left
> BTRFS warning (device sdd1: state EA): failed to recover relocation: -28
> BTRFS error (device sdd1: state EA): commit super ret -30
> BTRFS error (device sdd1: state EA): open_ctree failed
>
> $ mount -o rw,degraded,skip_balance -U my-uuid-a-b-c /mnt/array
> BTRFS info (device sdd1): first mount of filesystem my-uuid-a-b-c
> BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
> BTRFS info (device sdd1): using free-space-tree
> BTRFS error (device sdd1): failed to run delayed ref for logical
> 189538519531520 num_bytes 16384 type 176 action 1 ref_mod 1: -28
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 0 PID: 8002 at fs/btrfs/extent-tree.c:2249
> btrfs_run_delayed_refs+0x125/0x130 [btrfs]
> Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
> xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
> curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
> libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat
> xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter
> bridge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211
> binfmt_misc nls_iso8859_1 amdgpu intel_rapl_msr intel_rapl_common
> edac_mce_amd snd_hda_codec_realtek kvm_amd snd_hda_codec_generic
> snd_hda_codec_hdmi amdxcp drm_exec gpu_sched snd_hda_intel drm_buddy
> drm_suballoc_helper snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> kvm snd_hda_core drm_ttm_helper snd_hwdep ttm snd_pcm irqbypass
> drm_display_helper snd_timer rapl snd cec wmi_bmof ccp i2c_piix4
> k10temp rc_core soundcore mac_hid sch_fq_codel dm_multipath bonding
> tls nfsd auth_rpcgss nfs_acl lockd efi_pstore grace sunrpc nfnetlink
> dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic raid10
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 uas crct10dif_pclmul crc32_pclmul
> polyval_clmulni usb_storage polyval_generic ghash_clmulni_intel
> sha256_ssse3 sha1_ssse3 mpt3sas video nvme igb ahci nvme_core
> i2c_algo_bit libahci nvme_auth dca qlcnic raid_class xhci_pci
> xhci_pci_renesas scsi_transport_sas wmi aesni_intel crypto_simd cryptd
> CPU: 0 PID: 8002 Comm: mount Tainted: G        W
> 6.8.0-45-generic #45-Ubuntu
> Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
> P3.70 02/23/2022
> RIP: 0010:btrfs_run_delayed_refs+0x125/0x130 [btrfs]
> Code: 1b 49 8b 7c 24 60 89 da 48 c7 c6 98 0a 78 c0 e8 31 40 0e 00 41
> b8 01 00 00 00 eb aa 89 de 48 c7 c7 c0 0a 78 c0 e8 0b 6a d1 db <0f> 0b
> eb e6 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffb25dc4da7910 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffb25dc4da7930 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff92ba8d140738
> R13: ffff92ba12ad9200 R14: ffff92ba12ad9358 R15: ffff92ba501eed70
> FS:  00007c372a442800(0000) GS:ffff92c120200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0001fd010 CR3: 0000000132c64000 CR4: 00000000003506f0
> Call Trace:
>  <TASK>
>  ? show_regs+0x6d/0x80
>  ? __warn+0x89/0x160
>  ? btrfs_run_delayed_refs+0x125/0x130 [btrfs]
>  ? report_bug+0x17e/0x1b0
>  ? handle_bug+0x51/0xa0
>  ? exc_invalid_op+0x18/0x80
>  ? asm_exc_invalid_op+0x1b/0x20
>  ? btrfs_run_delayed_refs+0x125/0x130 [btrfs]
>  btrfs_write_dirty_block_groups+0x156/0x3c0 [btrfs]
>  commit_cowonly_roots+0x1cd/0x240 [btrfs]
>  btrfs_commit_transaction+0x540/0xbe0 [btrfs]
>  btrfs_recover_relocation+0x2f4/0x5d0 [btrfs]
>  btrfs_start_pre_rw_mount+0x360/0x620 [btrfs]
>  open_ctree+0xd1c/0xed0 [btrfs]
>  ? snprintf+0x51/0x80
>  btrfs_get_tree_super+0x2d6/0x3a0 [btrfs]
>  btrfs_get_tree+0x18/0x30 [btrfs]
>  vfs_get_tree+0x2a/0x100
>  fc_mount+0x12/0x60
>  btrfs_get_tree_subvol+0x13c/0x480 [btrfs]
>  ? vfs_parse_fs_string+0x7d/0xb0
>  btrfs_get_tree+0x25/0x30 [btrfs]
>  vfs_get_tree+0x2a/0x100
>  do_new_mount+0x1a0/0x340
>  path_mount+0x1e0/0x830
>  ? putname+0x5b/0x80
>  __x64_sys_mount+0x127/0x160
>  x64_sys_call+0x1df5/0x25c0
>  do_syscall_64+0x7f/0x180
>  ? irqentry_exit+0x43/0x50
>  ? exc_page_fault+0x94/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x78/0x80
> RIP: 0033:0x7c372a32af0e
> Code: 48 8b 0d 0d 7f 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d da 7e 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd909addc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 000062236f771b00 RCX: 00007c372a32af0e
> RDX: 000062236f778890 RSI: 000062236f772120 RDI: 000062236f772180
> RBP: 00007ffd909ade30 R08: 000062236f778670 R09: 0000000000000020
> R10: 0000000000000000 R11: 0000000000000246 R12: 000062236f772180
> R13: 000062236f772120 R14: 000062236f778890 R15: 000062236f771c60
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS info (device sdd1: state A): dumping space info:
> BTRFS info (device sdd1: state A): space_info DATA has 3383098413056
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=114548488011776,
> used=111151575642112, pinned=0, reserved=0, may_use=0,
> readonly=13813956608 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info METADATA has -536821760
> free, is full
> BTRFS info (device sdd1: state A): space_info total=121332826112,
> used=121276514304, pinned=56229888, reserved=81920, may_use=536821760,
> readonly=0 zone_unusable=0
> BTRFS info (device sdd1: state A): space_info SYSTEM has 26460160
> free, is not full
> BTRFS info (device sdd1: state A): space_info total=33554432,
> used=7094272, pinned=0, reserved=0, may_use=0, readonly=0
> zone_unusable=0
> BTRFS info (device sdd1: state A): global_block_rsv: size 536870912
> reserved 536805376
> BTRFS info (device sdd1: state A): trans_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sdd1: state A): delayed_refs_rsv: size 23068672
> reserved 16384
> BTRFS: error (device sdd1: state A) in btrfs_run_delayed_refs:2249:
> errno=-28 No space left
> BTRFS warning (device sdd1: state EA): Skipping commit of aborted transaction.
> BTRFS: error (device sdd1: state EA) in cleanup_transaction:2020:
> errno=-28 No space left
> BTRFS warning (device sdd1: state EA): failed to recover relocation: -28
> BTRFS error (device sdd1: state EA): commit super ret -30
> BTRFS error (device sdd1: state EA): open_ctree failed
>
>
> On Sun, 8 Sept 2024 at 20:44, Stefan N <stefannnau@gmail.com> wrote:
>>
>> Hi all,
>>
>> I seem to have another issue with btrfs raid6 metadata free space.
>> I've managed to regain a writeable filesystem by remounting with
>> skip_balance and quickly adding a 1tb ssd, however, want to know what
>> I should do next to resolve this safely longer term and avoid it
>> reoccurring. The raid6 balance has not yet been resumed/canceled.
>>
>> As the state of the array has been rapidly evolving, these are the
>> steps over the last month leading up to this issue (after the old
>> array became inconsistent, due to dev extent overlap)
>> 1) create new 'single' array with 2x disks, fill this new array
>> 2) disconnect another 2x disks from old raid6 array, add these to new
>> 'single' array, and continue to copy data
>> 3) remove remaining 5 disks from old array, add to new 'single' array
>> 4) use balance to convert new 'single' array to raid6 with raid1c3 metadata
>> 5) continue using array, slowly filling it up further
>>
>> The following error occurred roughly half way through this balance,
>> (-dconvert=raid6 -mconvert=raid1c3)
>>
>> ** Trigger of previous read-only state
>>
>> ------------[ cut here ]------------
>> BTRFS: Transaction aborted (error -28)
>> WARNING: CPU: 1 PID: 3814 at fs/btrfs/free-space-tree.c:865
>> remove_from_free_space_tree+0x209/0x210 [btrfs]
>> Modules linked in: ipt_REJECT nf_reject_ipv4 iptable_filter
>> xt_connmark xt_mark iptable_mangle xt_comment iptable_raw wireguard
>> curve25519_x86_64 libchacha20poly1305 chacha_x86_64 poly1305_x86_64
>> libcurve
>> 25519_generic libchacha ip6_udp_tunnel udp_tunnel xt_nat xt_tcpudp
>> veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
>> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>> xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables br_netfilter bri
>> dge stp llc ipmi_devintf ipmi_msghandler overlay cfg80211 binfmt_misc
>> nls_iso8859_1 intel_rapl_msr amdgpu intel_rapl_common edac_mce_amd
>> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
>> snd_hda_intel snd_intel_dspcfg kvm_amd snd_intel_sdw_
>> acpi amdxcp drm_exec snd_hda_codec gpu_sched drm_buddy snd_hda_core
>> kvm drm_suballoc_helper drm_ttm_helper irqbypass snd_hwdep ttm
>> drm_display_helper snd_pcm wmi_bmof rapl cec snd_timer rc_core snd
>> k10temp i2c_piix4 soundcore ccp mac_hid dm_multipath bo
>> nding tls nfsd efi_pstore auth_rpcgss nfs_acl lockd grace
>>  sunrpc nfnetlink dmi_sysfs ip_tables x_tables autofs4 btrfs
>> blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
>> async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 crct10dif_pclmul
>> c
>> rc32_pclmul polyval_clmulni uas polyval_generic usb_storage
>> ghash_clmulni_intel nvme sha256_ssse3 sha1_ssse3 igb nvme_core ahci
>> i2c_algo_bit qlcnic xhci_pci libahci dca nvme_auth xhci_pci_renesas
>> mpt3sas raid_class video scsi_transport_sas wmi aesni_int
>> el crypto_simd cryptd
>> CPU: 1 PID: 3814 Comm: btrfs-balance Not tainted 6.8.0-41-generic #41-Ubuntu
>> Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
>> P3.70 02/23/2022
>> RIP: 0010:remove_from_free_space_tree+0x209/0x210 [btrfs]
>> Code: c7 c6 c0 5b a4 c0 e8 56 ca 01 00 41 b8 01 00 00 00 eb 81 41 89
>> c7 e9 48 ff ff ff 44 89 fe 48 c7 c7 e8 5b a4 c0 e8 97 2b 19 e8 <0f> 0b
>> eb dd 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>> RSP: 0018:ffffb6f700b3ba50 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff94421ed373f0 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffffb6f700b3ba88 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: 00005fca57b5c000
>> R13: ffff944204262a10 R14: ffff9442483f6000 R15: 00000000ffffffe4
>> FS:  0000000000000000(0000) GS:ffff944920280000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007012c82613f4 CR3: 000000018205c000 CR4: 00000000003506f0
>> Call Trace:
>>  <TASK>
>>  ? show_regs+0x6d/0x80
>>  ? __warn+0x89/0x160
>>  ? remove_from_free_space_tree+0x209/0x210 [btrfs]
>>  ? report_bug+0x17e/0x1b0
>>  ? handle_bug+0x51/0xa0
>>  ? exc_invalid_op+0x18/0x80
>>  ? asm_exc_invalid_op+0x1b/0x20
>>  ? remove_from_free_space_tree+0x209/0x210 [btrfs]
>>  alloc_reserved_extent+0x24/0x100 [btrfs]
>>  alloc_reserved_tree_block+0x1af/0x2a0 [btrfs]
>>  run_delayed_tree_ref+0x17f/0x200 [btrfs]
>>  btrfs_run_delayed_refs_for_head+0x2d0/0x550 [btrfs]
>>  __btrfs_run_delayed_refs+0x101/0x1b0 [btrfs]
>>  btrfs_run_delayed_refs+0x62/0x130 [btrfs]
>>  btrfs_commit_transaction+0x4ea/0xbe0 [btrfs]
>>  ? btrfs_release_path+0x2d/0x190 [btrfs]
>>  insert_balance_item.isra.0+0x104/0x400 [btrfs]
>>  ? psi_group_change+0x24a/0x550
>>  btrfs_balance+0x49a/0x990 [btrfs]
>>  ? __pfx_balance_kthread+0x10/0x10 [btrfs]
>>  balance_kthread+0x74/0x120 [btrfs]
>>  kthread+0xf2/0x120
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork+0x47/0x70
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork_asm+0x1b/0x30
>>  </TASK>
>> ---[ end trace 0000000000000000 ]---
>> BTRFS info (device sdd1: state A): dumping space info:
>> BTRFS info (device sdd1: state A): space_info DATA has 33173680803840
>> free, is not full
>> BTRFS info (device sdd1: state A): space_info total=137411433594880,
>> used=103127752634368, pinned=1073741824, reserved=0, may_use=0,
>> readonly=1108926414848 zone_unusable=0
>> BTRFS info (device sdd1: state A): space_info METADATA has 1313734656
>> free, is full
>> BTRFS info (device sdd1: state A): space_info total=111669149696,
>> used=109772881920, pinned=37240832, reserved=2768896,
>> may_use=542392320, readonly=131072 zone_unusable=0
>> BTRFS info (device sdd1: state A): space_info SYSTEM has 30539776
>> free, is not full
>> BTRFS info (device sdd1: state A): space_info total=41943040,
>> used=11403264, pinned=0, reserved=0, may_use=0, readonly=0
>> zone_unusable=0
>> BTRFS info (device sdd1: state A): global_block_rsv: size 536870912
>> reserved 536870912
>> BTRFS info (device sdd1: state A): trans_block_rsv: size 1835008
>> reserved 1835008
>> BTRFS info (device sdd1: state A): chunk_block_rsv: size 0 reserved 0
>> BTRFS info (device sdd1: state A): delayed_block_rsv: size 0 reserved 0
>> BTRFS info (device sdd1: state A): delayed_refs_rsv: size 142082048
>> reserved 16384
>> BTRFS: error (device sdd1: state A) in
>> remove_from_free_space_tree:865: errno=-28 No space left
>> BTRFS info (device sdd1: state EA): forced readonly
>> BTRFS error (device sdd1: state EA): failed to run delayed ref for
>> logical 105322659561472 num_bytes 16384 type 176 action 1 ref_mod 1:
>> -28
>> BTRFS: error (device sdd1: state EA) in btrfs_run_delayed_refs:2249:
>> errno=-28 No space left
>> BTRFS warning (device sdd1: state EA): Skipping commit of aborted transaction.
>> BTRFS: error (device sdd1: state EA) in cleanup_transaction:2020:
>> errno=-28 No space left
>> BTRFS info (device sdd1: state EA): balance: resume
>> -dconvert=raid6,soft -mconvert=raid1c3,soft -sconvert=raid1c3,soft
>> BTRFS info (device sdd1: state EA): balance: ended with status: -30
>>
>> $ uname -a
>> Linux nas 6.8.0-41-generic #41-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug  2
>> 20:41:06 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
>>
>> $ btrfs --version
>> btrfs-progs v6.6.3
>>
>> $ df -h /mnt/array/
>> Filesystem      Size  Used Avail Use% Mounted on
>> /dev/sdd1       162T   95T   31T  76% /mnt/array
>>
>> $ sudo btrfs fi show /mnt/array/
>> Label: 'array'  uuid: a-b-c-d-e
>>         Total devices 9 FS bytes used 93.89TiB
>>         devid    1 size 20.01TiB used 20.01TiB path /dev/sdd1
>>         devid    2 size 20.01TiB used 20.01TiB path /dev/sdb1
>>         devid    3 size 16.37TiB used 16.37TiB path /dev/sdg1
>>         devid    4 size 20.01TiB used 19.70TiB path /dev/sde1
>>         devid    5 size 16.37TiB used 16.37TiB path /dev/sdn1
>>         devid    6 size 20.01TiB used 16.44TiB path /dev/sdh1
>>         devid    7 size 16.37TiB used 16.37TiB path /dev/sda1
>>         devid    8 size 16.37TiB used 16.37TiB path /dev/sdf1
>>         devid    9 size 16.37TiB used 16.37TiB path /dev/sdc1
>>
>> $ sudo btrfs fi usage /mnt/array/
>> Overall:
>>     Device size:                 161.88TiB
>>     Device allocated:            158.01TiB
>>     Device unallocated:            3.87TiB
>>     Device missing:                  0.00B
>>     Device slack:                    0.00B
>>     Used:                        114.71TiB
>>     Free (estimated):             37.37TiB      (min: 35.59TiB)
>>     Free (statfs, df):            30.17TiB
>>     Data ratio:                       1.26
>>     Metadata ratio:                   2.57
>>     Global reserve:              512.00MiB      (used: 0.00B)
>>     Multiple profiles:                 yes      (data, metadata, system)
>>
>> Data,single: Size:43.31TiB, Used:42.31TiB (97.67%)
>>    /dev/sdd1      19.97TiB
>>    /dev/sdb1      19.96TiB
>>    /dev/sdg1      51.00GiB
>>    /dev/sde1       3.33TiB
>>
>> Data,RAID6: Size:81.66TiB, Used:51.49TiB (63.05%)
>>    /dev/sdd1       2.02GiB
>>    /dev/sdb1       3.00GiB
>>    /dev/sdg1      16.32TiB
>>    /dev/sde1      16.36TiB
>>    /dev/sdn1      16.34TiB
>>    /dev/sdh1      16.39TiB
>>    /dev/sda1      16.34TiB
>>    /dev/sdf1      16.34TiB
>>    /dev/sdc1      16.34TiB
>>
>> Metadata,RAID1: Size:45.00GiB, Used:43.27GiB (96.16%)
>>    /dev/sdd1      42.00GiB
>>    /dev/sdb1      42.00GiB
>>    /dev/sdg1       3.00GiB
>>    /dev/sde1       3.00GiB
>>
>> Metadata,RAID1C3: Size:59.00GiB, Used:58.96GiB (99.94%)
>>    /dev/sdn1      30.00GiB
>>    /dev/sdh1      59.00GiB
>>    /dev/sda1      30.00GiB
>>    /dev/sdf1      29.00GiB
>>    /dev/sdc1      29.00GiB
>>
>> System,RAID1: Size:8.00MiB, Used:4.47MiB (55.86%)
>>    /dev/sdd1       8.00MiB
>>    /dev/sdb1       8.00MiB
>>
>> System,RAID1C3: Size:32.00MiB, Used:6.41MiB (20.02%)
>>    /dev/sdh1      32.00MiB
>>    /dev/sdf1      32.00MiB
>>    /dev/sdc1      32.00MiB
>>
>> Unallocated:
>>    /dev/sdd1       1.00MiB
>>    /dev/sdb1       1.00MiB
>>    /dev/sdg1       1.00MiB
>>    /dev/sde1     317.00GiB
>>    /dev/sdn1       1.00MiB
>>    /dev/sdh1       3.56TiB
>>    /dev/sda1       1.00MiB
>>    /dev/sdf1       1.00MiB
>>    /dev/sdc1       1.00MiB
>> $
>>
>> ** Current state: remediated by adding /dev/sdj (1tb SSD) while
>> mounted with skip_balance
>>
>> $ sudo btrfs fi usage /mnt/array/
>> Overall:
>>     Device size:                 162.34TiB
>>     Device allocated:            116.20TiB
>>     Device unallocated:           46.14TiB
>>     Device missing:                  0.00B
>>     Device slack:                    0.00B
>>     Used:                        114.64TiB
>>     Free (estimated):             39.15TiB      (min: 16.65TiB)
>>     Free (statfs, df):            30.65TiB
>>     Data ratio:                       1.22
>>     Metadata ratio:                   2.57
>>     Global reserve:              512.00MiB      (used: 0.00B)
>>     Multiple profiles:                 yes      (data, metadata, system)
>>
>> Data,single: Size:43.31TiB, Used:42.31TiB (97.67%)
>>    /dev/sdd1      19.97TiB
>>    /dev/sdb1      19.96TiB
>>    /dev/sdh1      51.00GiB
>>    /dev/sde1       3.33TiB
>>
>> Data,RAID6: Size:51.87TiB, Used:51.49TiB (99.26%)
>>    /dev/sdd1       2.02GiB
>>    /dev/sdb1       3.00GiB
>>    /dev/sdh1      10.37TiB
>>    /dev/sde1      10.37TiB
>>    /dev/sdm1      10.37TiB
>>    /dev/sdg1      10.37TiB
>>    /dev/sda1      10.37TiB
>>    /dev/sdf1      10.37TiB
>>    /dev/sdc1      10.37TiB
>>
>> Metadata,RAID1: Size:45.00GiB, Used:43.27GiB (96.16%)
>>    /dev/sdd1      42.00GiB
>>    /dev/sdb1      42.00GiB
>>    /dev/sdh1       3.00GiB
>>    /dev/sde1       3.00GiB
>>
>> Metadata,RAID1C3: Size:60.00GiB, Used:58.95GiB (98.25%)
>>    /dev/sde1       1.00GiB
>>    /dev/sdm1      30.00GiB
>>    /dev/sdg1      60.00GiB
>>    /dev/sda1      30.00GiB
>>    /dev/sdf1      29.00GiB
>>    /dev/sdc1      29.00GiB
>>    /dev/sdj        1.00GiB
>>
>> System,RAID1: Size:8.00MiB, Used:4.47MiB (55.86%)
>>    /dev/sdd1       8.00MiB
>>    /dev/sdb1       8.00MiB
>>
>> System,RAID1C3: Size:32.00MiB, Used:3.17MiB (9.91%)
>>    /dev/sdg1      32.00MiB
>>    /dev/sdf1      32.00MiB
>>    /dev/sdc1      32.00MiB
>>
>> Unallocated:
>>    /dev/sdd1       1.00MiB
>>    /dev/sdb1       1.00MiB
>>    /dev/sdh1       5.94TiB
>>    /dev/sde1       6.30TiB
>>    /dev/sdm1       5.97TiB
>>    /dev/sdg1       9.58TiB
>>    /dev/sda1       5.97TiB
>>    /dev/sdf1       5.97TiB
>>    /dev/sdc1       5.97TiB
>>    /dev/sdj      464.76GiB
>> $

-- 
Chris Murphy

