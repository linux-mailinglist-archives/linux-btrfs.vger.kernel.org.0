Return-Path: <linux-btrfs+bounces-20184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F989CFBA1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 02:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A49D2304860F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 01:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488A227BB5;
	Wed,  7 Jan 2026 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="cd908Ok+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2B1ADC7E
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750780; cv=none; b=Uouo6ce0xAIOss8CZQDQTHDr3hOgy8HUTfsYM2ZiG/B1x3QJa43lTdjjp6U1JDaLHtxHJV3jQNDUShvMeUiWaa8EGvvhZBHzMGWfL0LN3UTFT6WzI9YQSZ1BBz8TebwJwGpLUiJ/IM3IDStrdChfyxHk2OsKgCtk93MMzsJgLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750780; c=relaxed/simple;
	bh=QzDXoie6jW/LQnBhrpAu+qLMAjHImKIAvjOUAOaEPDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK5WP53SXQsohBTPkG8okt8yQi77SwSTWrA+vBOlloGVGy5yMWoyRyAdF7OM7BvB+AG2/pl9OkyiDwUyUGCDovmZg4mh9m5ON1+rlev1ZZp6O083ilEAIvnKmxyet741RFJTEnOh188q3W8mcBUsO7f2tQEt52saqV40/lx79BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=cd908Ok+; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1767750758; x=1768355558; i=christian@heusel.eu;
	bh=s9vjfyj5ssftHbLT6wOkFbXmbtqOOMAqh0ejhILZzxI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cd908Ok+elJ0ZJEcampgruBQ5xRGEWB5mhabvMCPAVXO9eD/cfZYIsJVGVKXpxiO
	 vPWP0Mxt5VGx5zvPwTUYtzwJV/gd6u8uckjQwlzxvd8GcWxHTGbRTGbJAwxm4HS85
	 zUghe+oV6l5gIjxUoYwsBKlEA9OEwgkpuqAVCGHOLBEd2/UJ3AJDUL1BEqbpdkEp+
	 57rwoXOv5lWPb9wrJIxR4b33rgETKSNIEnSKXIKe3vIAe0/ru28qmlX0mKu90irja
	 2uapGke0j0Bnn+CHHLOI3Vy82J+MKlwssRwN+hw/Q8c9MRNRdr9ZY04RAa8nygwpE
	 whq/Ud881cq2iZPkKw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.239]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4JiJ-1vd1k726zp-001IQr; Wed, 07 Jan 2026 02:52:38 +0100
Date: Wed, 7 Jan 2026 02:52:37 +0100
From: Christian Heusel <christian@heusel.eu>
To: Leo Martins <loemra.dev@gmail.com>
Cc: Gideon Farrell <gideon@solnickfarrell.co.uk>, 
	linux-btrfs@vger.kernel.org, regressions@lists.linux.dev, arch-devops@lists.archlinux.org
Subject: Re: refcount_warn_saturate in __btrfs_release_delayed_node for
 6.18.2-arch2-1
Message-ID: <46fba8b4-c694-48d8-b20b-6d0fdd18bf8b@heusel.eu>
References: <DFHUFTKLUCB5.11QUC5R2L77DO@solnickfarrell.co.uk>
 <20260107011054.2694891-1-loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ig2grltrgyicork3"
Content-Disposition: inline
In-Reply-To: <20260107011054.2694891-1-loemra.dev@gmail.com>
X-Provags-ID: V03:K1:zhEH7xgSBahBSYNuzTwV4mb29g9E8cMCP6M1YtJGirGegdLkYiM
 jySCp9h/I5s2KtUnwBL/x0vPUzBpQt2foTevA3xgukOmZc7GRescD7x0pmfCWbZ+LLaYEBg
 1cUyafmc3he1z/kyLn8utF9RnjvxSa3NYiGPWRAgrg/vvqxEhAqv3RNohVi7uvdzPYdLvRS
 Q5lAvuvlxsuBmealHh/KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YKmpeO+/3WQ=;hdKcwXZg+ylUHA7KVHQMpyPQCEJ
 w4EFA6XUqo1RSFAHOiTdJlGEP4Xa/SB0g7UTkgDiq0vH+7z991kkkOHhJvbctkOxVNJlFoyWZ
 rZBc30jEbJjBbohJ0u32gOA3l4ThQT06Yz9g1q/qXy0jLnCJZ96PyfDQTs2bitmBA2cokH1/t
 GkH+bntwg1SaOlkzSy3uFLphi12JHvzEUrdaOBR1XISCYcya7nVCJdBqwnCYKOLn1SYPf40dU
 VKY6FK+xe6+lxfzVfmO96+B1e5wyez9wvHrCkz3g/lX9rNJKa67N7XJvwxE5XIz6UwODNYpbF
 7Ty6GMc/KtMfD3TzCCMHJgYbwDPQqZZWjyEpjcpdNU1BmP6Apj5mVh80jBPI4LKs9d4zywRpU
 2lmI/iXc/D3Y1gdejwcJfeLjYqIwxnpn0mM7q/O+ze3qPJIdd4KROei7wpFou+3J0J+5/PnU0
 ffLEcKbUR4C13bjGj/erNl1sjI3L/SBQx8mh+nE9Dy++wJkNEeyVvB1g7FHLdxrva/582HBVu
 oK6x5W4C8zZBGIxhRZJPDoMdqWuuPue6EGBY8EdBv1Ox0qouP3QB5SOmKgXLuJQBp4Hb3QW4l
 39yMiQH4tN7NiJAQMIupfeS7h6J4YKbB3hQUJEjv0fKewCfsfaKUoAdRGFdRmrNxYj1vP8rbq
 8Tl7EZuucLHE/hd9C5JikNp6Yl6A2+Y1QHoC/FlAiYvG3xNAZiBuG3ckLUbumwGTPjIkeejKq
 serbG05f31tS5BtLyzLC7pK38ECvtAKfwDxlP+VaHDotAX6E6bjfjKiXrwjnh/ojh/yfZgvO4
 ZSYmOBqUoiHO9kNlz7xEYtCOQLJcBz+SlplHJIBIT7NFxnawFUUMvKrTSUCITph3CoRGlTo6b
 AGeRbP3Qlz4hBkwqL7DVrXOFh2iAjuM3LzPFQio01eP79x5oR3D+nF9EwgXteFoksAL1V0qbb
 W77Wxtfs/n2Sq5E63E+F8By8yiTphHsOokcF1qa4RqeCkAPsvLi+lhXx8rNg0cd26PTj21z3z
 IOyTRSfnuFyGGc8FU05G/AX8ERGyB7CkM8+CKEiPxgdWlDy0dTCe2A5ifPeExKZSbcORdHKQO
 xcsPlrNZ8rUVqtc8bADdVDXdNBKX1+dp5F9LxN4RHDH+V58IZDBkH80JR2BbZNYaOeefIbmNa
 A8/pV9zXWq2WOy4y5CaWkmuxpgEv/Ba44Ux3eqzvXS9YP9Gm6TMNwF+gHbo2LxO3NSycry1J4
 kmHEXpNkNH8nMD8vAT2lv4cEFQa1Fipy+MN4CYk0zopvr+eMyPtRn4sPG2yBuoHXY+hHP6KJi
 cK0o62GmDzuLFdSHQcaiwM4wbBMd3ZoAaTsNwX9ZlvF/f3pbUXncYoY/CmNlRUUJRJVEbs7MI
 XjsfEl8ObCOr1H0bYXaB036ZIMJGQAFSTe0LQUfe/hHTJpF7i4cILzt8/ZXwi23vJ8zzwB7Ie
 89QBVpe0ZcTAWNJB1EhHF5wo8Kw3+Q95n6gsDcORVHORYdH8P1MYfN5g4sEtsxkeOiYMFAMhC
 efBnZZu/3BPYdF68KqeMBllZ0UPlzGx1tTqsqYVWtG4Q88/cCdYQH8n2sg4HTtC5gHRtLYecm
 jGRnD3l5rpHa5iz1hX36CxFVtgwxf6mNYMTp5KHxzbcb6SgvOOsZxAkpOFjjnGGvLxgL0SaY0
 IsH9zCVhGdQF6JjlM8lNYMda8rH+LbwfaH1Tq3tB/ho2IUxrAfSgor5UVeNNYbwxXzoQFZCsD
 vUiY4dg8cBqeX8cTTxZFO3hDLXIo8t8kiLJOOpXREtMCY431dFcsrAcDGj18DFU9AulPjishr
 EQCB


--ig2grltrgyicork3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: refcount_warn_saturate in __btrfs_release_delayed_node for
 6.18.2-arch2-1
MIME-Version: 1.0

On 26/01/06 05:10PM, Leo Martins wrote:
> On Tue, 06 Jan 2026 22:01:58 +0000 "Gideon Farrell" <gideon@solnickfarrel=
l.co.uk> wrote:
>=20
> > Hi there,
> >=20
> > I recently experienced a type of crash I haven't seen before on this sy=
stem which seems to originate in __btrfs_release_delayed_node on Kernel 6.1=
8.2-arch2-1.
>=20
> Hey, thanks for the report. This looks very similar to a different
> report that has been fixed in 6.19-rc5.
> Report: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.co=
m/

I think this is the issue we have been seeing on the Arch Linux
infrastructure aswell, see this issue for reference:

https://gitlab.archlinux.org/archlinux/infrastructure/-/issues/788#note_385=
420

This has caused us to downgrade the kernel on all hosts in our
infrastructure due to the crashes caused by this.

> Fix: https://lore.kernel.org/linux-btrfs/7c89417ac3352ce3cb0a6373a1746155=
c1e2754d.1765588168.git.loemra.dev@gmail.com/
>=20
> Please let me know if this fixes your issue.

So far we have not found a good lab-setting to reproduce the issue
outside of the production machines workloads (but we have also not
looked into the issue a lot).

Do you have a good reproducer already that we could use to verify the
fix?

Also the fix is not yet even scheduled for inclusion in the stable
trees, since it is still not in linus tree right?

>=20
> >=20
> > Here's the stack trace:
> >=20
> > ```
>=20
> Are these the first refcount_t: warnings in your dmesg? I would
> expect an earlier warning that looks like
> refcount_t: addition on 0; use-after-free.
>=20

This is what our stacktrace looks like:

[231923.304874] hrtimer: interrupt took 3785426 ns
[472012.335914] ------------[ cut here ]------------
[472012.335919] refcount_t: addition on 0; use-after-free.
[472012.335953] WARNING: CPU: 0 PID: 378191 at lib/refcount.c:25 refcount_w=
arn_saturate+0xe5/0x110
[472012.335978] Modules linked in: wireguard libcurve25519 ip6_udp_tunnel u=
dp_tunnel cfg80211 rfkill nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nf=
t_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat=
 ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf=
_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw =
iptable_security nf_tables ip6table_filter ip6_tables iptable_filter ip_tab=
les x_tables intel_rapl_msr intel_rapl_common intel_uncore_frequency_common=
 isst_if_mbox_msr isst_if_common skx_edac_common nfit libnvdimm encrypted_k=
eys trusted asn1_encoder tee polyval_clmulni ghash_clmulni_intel aesni_inte=
l rapl i2c_i801 i2c_smbus psmouse pcspkr i2c_mux joydev iTCO_wdt intel_pmc_=
bxt mousedev iTCO_vendor_support mac_hid tun nfnetlink vsock_loopback vmw_v=
sock_virtio_transport_common zram vmw_vsock_vmci_transport 842_decompress 8=
42_compress vsock lz4hc_compress lz4_compress vmw_vmci qemu_fw_cfg virtio_n=
et sr_mod net_failover cdrom virtio_scsi lpc_ich failover
[472012.336187]  intel_agp virtio_balloon virtio_gpu intel_gtt virtio_dma_b=
uf serio_raw virtio_rng
[472012.336217] CPU: 0 UID: 0 PID: 378191 Comm: kworker/u8:7 Not tainted 6.=
18.2-arch2-1 #1 PREEMPT(full)  e9d53cde2ee9d1bdaa4464d2214ad0f22bd43723
[472012.336226] Hardware name: Hetzner vServer/Standard PC (Q35 + ICH9, 200=
9), BIOS 20171111 11/11/2017
[472012.336233] Workqueue: btrfs-delalloc btrfs_work_helper
[472012.336243] RIP: 0010:refcount_warn_saturate+0xe5/0x110
[472012.336249] Code: 7c 7b ff 0f 0b c3 cc cc cc cc 80 3d 27 ce ae 01 00 0f=
 85 5e ff ff ff 48 c7 c7 88 4a 1d 9a c6 05 13 ce ae 01 01 e8 bb 7c 7b ff <0=
f> 0b e9 14 70 83 00 48 c7 c7 e0 4a 1d 9a c6 05 f7 cd ae 01 01 e8
[472012.336251] RSP: 0018:ffffd0da0550bb68 EFLAGS: 00010246
[472012.336257] RAX: 0000000000000000 RBX: ffff8f5461439618 RCX: 0000000000=
000027
[472012.336259] RDX: ffff8f55b5c1d008 RSI: 0000000000000001 RDI: ffff8f55b5=
c1d000
[472012.336261] RBP: ffff8f5546bee368 R08: 0000000000000000 R09: 00000000ff=
ffefff
[472012.336263] R10: ffffffff9aa613c0 R11: ffffd0da0550ba00 R12: ffff8f5459=
b7b310
[472012.336265] R13: 00000000071412e0 R14: ffff8f54869aec00 R15: ffff8f5546=
bee000
[472012.336267] FS:  0000000000000000(0000) GS:ffff8f561a4f2000(0000) knlGS=
:0000000000000000
[472012.336269] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[472012.336271] CR2: 00007f1662c2d000 CR3: 00000000011d0001 CR4: 0000000000=
7706f0
[472012.336276] PKRU: 55555554
[472012.336277] Call Trace:
[472012.336280]  <TASK>
[472012.336282]  btrfs_get_delayed_node.isra.0+0xda/0x1b0
[472012.336302]  btrfs_get_or_create_delayed_node.isra.0+0x134/0x1b0
[472012.336306]  btrfs_delayed_update_inode+0x28/0x1e0
[472012.336310]  ? btrfs_update_root_times+0x75/0xa0
[472012.336314]  btrfs_update_inode+0x59/0xc0
[472012.336319]  __cow_file_range_inline+0x16c/0x3f0
[472012.336325]  cow_file_range_inline.constprop.0+0xd7/0x140
[472012.336357]  compress_file_range+0x3d6/0x5c0
[472012.336368]  ? __pfx_submit_compressed_extents+0x10/0x10
[472012.336372]  btrfs_work_helper+0xe1/0x380
[472012.336376]  process_one_work+0x193/0x350
[472012.336382]  worker_thread+0x2d7/0x410
[472012.336387]  ? __pfx_worker_thread+0x10/0x10
[472012.336391]  kthread+0xfc/0x240
[472012.336394]  ? __pfx_kthread+0x10/0x10
[472012.336397]  ? __pfx_kthread+0x10/0x10
[472012.336400]  ret_from_fork+0x1c2/0x1f0
[472012.336405]  ? __pfx_kthread+0x10/0x10
[472012.336407]  ret_from_fork_asm+0x1a/0x30
[472012.336415]  </TASK>
[472012.336416] ---[ end trace 0000000000000000 ]---
[514764.706607] clocksource: timekeeping watchdog on CPU1: Marking clocksou=
rce 'tsc' as unstable because the skew is too large:
[514764.706619] clocksource:                       'kvm-clock' wd_nsec: 503=
967155 wd_now: 15063bc7c98819 wd_last: 15063ba9bf9a66 mask: ffffffffffffffff
[514764.706623] clocksource:                       'tsc' cs_nsec: 504385576=
 cs_now: 43249c5a1bef6 cs_last: 4324980a5e4ee mask: ffffffffffffffff
[514764.706626] clocksource:                       Clocksource 'tsc' skewed=
 418421 ns (0 ms) over watchdog 'kvm-clock' interval of 503967155 ns (503 m=
s)
[514764.706629] clocksource:                       'kvm-clock' (not 'tsc') =
is current clocksource.
[514764.706631] tsc: Marking TSC unstable due to clocksource watchdog
[565801.098513] BTRFS critical (device sda2): failed to delete reference to=
 index, root 5 inode 119459904 parent 4158694
[565801.098639] ------------[ cut here ]------------
[565801.098643] BTRFS: Transaction aborted (error -2)
[565801.098718] WARNING: CPU: 1 PID: 3731148 at fs/btrfs/inode.c:4297 __btr=
fs_unlink_inode+0x41f/0x440
[565801.098772] Modules linked in: wireguard libcurve25519 ip6_udp_tunnel u=
dp_tunnel cfg80211 rfkill nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nf=
t_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat=
 ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf=
_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw =
iptable_security nf_tables ip6table_filter ip6_tables iptable_filter ip_tab=
les x_tables intel_rapl_msr intel_rapl_common intel_uncore_frequency_common=
 isst_if_mbox_msr isst_if_common skx_edac_common nfit libnvdimm encrypted_k=
eys trusted asn1_encoder tee polyval_clmulni ghash_clmulni_intel aesni_inte=
l rapl i2c_i801 i2c_smbus psmouse pcspkr i2c_mux joydev iTCO_wdt intel_pmc_=
bxt mousedev iTCO_vendor_support mac_hid tun nfnetlink vsock_loopback vmw_v=
sock_virtio_transport_common zram vmw_vsock_vmci_transport 842_decompress 8=
42_compress vsock lz4hc_compress lz4_compress vmw_vmci qemu_fw_cfg virtio_n=
et sr_mod net_failover cdrom virtio_scsi lpc_ich failover
[565801.099194]  intel_agp virtio_balloon virtio_gpu intel_gtt virtio_dma_b=
uf serio_raw virtio_rng
[565801.099264] CPU: 1 UID: 967 PID: 3731148 Comm: git Tainted: G        W =
          6.18.2-arch2-1 #1 PREEMPT(full)  e9d53cde2ee9d1bdaa4464d2214ad0f2=
2bd43723
[565801.099294] Tainted: [W]=3DWARN
[565801.099304] Hardware name: Hetzner vServer/Standard PC (Q35 + ICH9, 200=
9), BIOS 20171111 11/11/2017
[565801.099320] RIP: 0010:__btrfs_unlink_inode+0x41f/0x440
[565801.099339] Code: 9a 89 04 24 e8 82 35 a3 ff 0f 0b 8b 04 24 41 b8 01 00=
 00 00 e9 ee 6e 91 ff 89 c6 48 c7 c7 08 b6 1b 9a 89 04 24 e8 61 35 a3 ff <0=
f> 0b 8b 04 24 41 b8 01 00 00 00 e9 f5 6e 91 ff b8 f4 ff ff ff e9
[565801.099347] RSP: 0018:ffffd0da05fc3ae0 EFLAGS: 00010246
[565801.099363] RAX: 0000000000000000 RBX: ffff8f54514cf400 RCX: 0000000000=
000027
[565801.099369] RDX: ffff8f55b5d1d008 RSI: 0000000000000001 RDI: ffff8f55b5=
d1d000
[565801.099374] RBP: ffff8f554f875800 R08: 0000000000000000 R09: 00000000ff=
ffefff
[565801.099379] R10: ffffffff9aa613c0 R11: ffffd0da05fc3978 R12: ffff8f5447=
173770
[565801.099383] R13: ffff8f554059c930 R14: ffff8f5546bee000 R15: ffffd0da05=
fc3bf0
[565801.099388] FS:  00007fce22144740(0000) GS:ffff8f561a5f2000(0000) knlGS=
:0000000000000000
[565801.099395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[565801.099402] CR2: 0000561bbb192000 CR3: 000000000fc4a001 CR4: 0000000000=
7706f0
[565801.099415] PKRU: 55555554
[565801.099419] Call Trace:
[565801.099424]  <TASK>
[565801.099438]  btrfs_rename+0x3d2/0xd10
[565801.099475]  btrfs_rename2+0x28/0x60
[565801.099484]  vfs_rename+0x7f3/0xd90
[565801.099500]  do_renameat2+0x40e/0x580
[565801.099515]  __x64_sys_rename+0x7a/0xc0
[565801.099521]  do_syscall_64+0x81/0x7f0
[565801.099531]  ? do_user_addr_fault+0x21a/0x690
[565801.099542]  ? clear_bhb_loop+0x50/0xa0
[565801.099549]  ? clear_bhb_loop+0x50/0xa0
[565801.099555]  ? clear_bhb_loop+0x50/0xa0
[565801.099561]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[565801.099568] RIP: 0033:0x7fce21e60adb
[565801.099665] Code: c0 48 8b 5d f8 c9 c3 0f 1f 84 00 00 00 00 00 b8 ff ff=
 ff ff eb eb 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 52 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 01 72 1a 00 f7 d8
[565801.099670] RSP: 002b:00007ffc913073b8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000052
[565801.099677] RAX: ffffffffffffffda RBX: 0000561bbb167650 RCX: 00007fce21=
e60adb
[565801.099681] RDX: 00000000ffffffff RSI: 0000561bbb16b020 RDI: 0000561bbb=
16a700
[565801.099685] RBP: 00007ffc913073e0 R08: 0000000000000000 R09: 0000000000=
000034
[565801.099689] R10: 0000000000000000 R11: 0000000000000246 R12: 0000561bbb=
16b020
[565801.099693] R13: 00007ffc91307530 R14: 0000000000000000 R15: 0000000000=
000000
[565801.099716]  </TASK>
[565801.099719] ---[ end trace 0000000000000000 ]---
[565801.099736] BTRFS: error (device sda2 state A) in __btrfs_unlink_inode:=
4297: errno=3D-2 No such entry
[565801.099779] BTRFS info (device sda2 state EA): forced readonly
[565801.099929] BTRFS: error (device sda2 state EA) in btrfs_rename:8588: e=
rrno=3D-2 No such entry
[565843.595829] systemd-journald[382]: /var/log/journal/7c70006779c84e4289a=
748b91a60ece7/system.journal: Journal file corrupted, rotating.
[565843.596029] systemd-journald[382]: Failed to rotate /var/log/journal/7c=
70006779c84e4289a748b91a60ece7/system.journal: Read-only file system
[565843.637938] systemd-journald[382]: Failed to write entry to /var/log/jo=
urnal/7c70006779c84e4289a748b91a60ece7/system.journal (24 items, 790 bytes)=
 despite vacuuming, ignoring: Bad message
[565875.550945] systemd-journald[382]: /var/log/journal/7c70006779c84e4289a=
748b91a60ece7/system.journal: Journal file corrupted, rotating.
[565875.551005] systemd-journald[382]: Failed to rotate /var/log/journal/7c=
70006779c84e4289a748b91a60ece7/system.journal: Read-only file system

Cheers,
Chris

--ig2grltrgyicork3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmldvGUACgkQwEfU8yi1
JYVL6Q/9FvRlmhfnQF9dxaz2TRTpkIkSfDqjo7YCNI2UobA4Egeg7dhKVswpOH7p
RVjNn7pUurrZK1krDkdwQ4rkGC4OhyLYb+JFHUs8KqulV9iVIN870TjYyxAE1ssm
zJE2CoR5cfExuhVr8+QbeHbo3LO636I4uVqdpL1GvEboD/YKSAyLS6FvKRiYSp+W
5s2/2vquwpLWzbbFSres5r+8rGqAiRrULmLVTSQsooYCqutNeWFq9c3LPeAR4YuG
rN6/61hyfb5FIz4Yi2c7aHB4O3jLlFcAgPZOSnqX+V+gBUTkmZmLfdkT/U3uVPUV
7L/fPj0l9/SNYittm2TS+wmdHjO45j2cFky3IQUuis11bBcD8lCAFLEV3l3SIO0e
Buw/f7at4koJ7lwtBhMkV81OUCvY4b6zBiN3i0aHaTK4Ma2bp9TOYuMsiXycd6mx
mTdDfkNJbGxn9uuc4KZ4X/k+Tl6KIJuCXXiM+GE/Kv1Nx9mdxDOHjNOY/+qedHSu
vWpIGjcemTatNfQIDf9sups8178hRYnnuOHhS5VHTUIK3Ge+3c6GoDLgloSol7ys
Clk4PcHGwdvPKW3RkHZXodtbWPvSwQKZnkxmlswXlYcPq7NB0HPNzZs1DJCNSl20
WaGsqkGsiNPzqaknIQuzD3kMDGCQ+rMWbXwddE2+3DqXwAfgLgE=
=8m5x
-----END PGP SIGNATURE-----

--ig2grltrgyicork3--

