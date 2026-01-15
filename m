Return-Path: <linux-btrfs+bounces-20540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64842D25113
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 15:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08BC3302B999
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9224313E1D;
	Thu, 15 Jan 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="TqN9NiMq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09C34FF78
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488433; cv=none; b=avYUxlAY0n2uOrOBJ7bKKUK2H7TOgNN6L/mkGeElHLdiQDtjwI8/6LUik60QOoVcd2EcWuvQXcBs4+39DNHapxlxr/ck/7uKvSwuUM/Y55nhUgIjCl0qZF4QRCUfq30HhY7b5Fkyt+v/+ycjo9TivsZsc2oqzfhtvVYk0/abvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488433; c=relaxed/simple;
	bh=3bqvFUvfW49APPhb8JVHwg5CypHWMnMx4kMQCrJOttc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QaFzphhJNBXhk3GdjkWn0i7h6/QJdArnGNMre6a0ukzV3b/xyPQ9+N9yvsrkOV5JAHUiEGoVC/JG35Bks8ET6G/bCffDZOsAwuvTpK4ROKYfhgmdRprn0kcz1xFTuAEsTJR4o5AcgPPVxv+7vQvCnWg41gVPp7EfJ9ZoZR+Nj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=TqN9NiMq; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12332910300so2448375c88.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 06:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1768488425; x=1769093225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yV+e8fiQUxePU3AIXR8BxVxHLCmCn7fp90O9Mb3AOUY=;
        b=TqN9NiMq6kbk0fnRkMp5q8NDomhkEnPzJZGgKmKh/Ai9MxCgcQktdgKIWbzm6Wpm8R
         EU3Ua+/WZxgQ+Z/awS+1e+SXEYklfCvLFORGWCm77GxZZOKQ5qm2amjxPw+erQwoTm3E
         MpmPzx3x1+9eVClta9TleiU/2Pd6pOGPP9uuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488425; x=1769093225;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV+e8fiQUxePU3AIXR8BxVxHLCmCn7fp90O9Mb3AOUY=;
        b=TXPlODklbHuUZFGwdvqj5zUxzNJQ3qjF+I1c19Yyj1Jt5BODPum4GzU1hUTOD7fMf6
         dBJvGv4qAPHaX78Pt9MoGmLZuxSAFokyDFFFU0L5aWsMT4MJiG+C7iyfDDewXCCdQVSV
         kGafDwz3cG97UNtbl4HgqESC0oAhjWGc0UJ6gLWZwdfu5+1sfaN6f5wZF3fU00Ph6AAv
         IYAJ4meO+/cGHYIlMgOIwQ8VqcA64QBppN+IhX/hECtTSxzxwhp2nSw136wIr6VepacC
         zsSJ5cu892e4kNd3Mj1h/XRBJh2oJBp5k6ebV7DNtAfZrDnxOKfbFXkBaOi2Kd/XaRV2
         THnA==
X-Forwarded-Encrypted: i=1; AJvYcCV+DL0/etGJRTKyVmlb5LV6YxSCIgfeN9fLMVadQ2TGJTMZNPhpTrk9afSWy+4vHs3ckVTPyMrdHHI0ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21ByBRa6xPuWPYXA2ed2F/vBoN0Ita0ZFshXI3CE7TTHORlNY
	ao3t2LAmVpTEy9vbxftUWNwafGDrm/DGQAtPKqq8WoZQkucSRhadAghfmZcifUaFcsmTHABwYlP
	5j8FLiuaHOxDhkfuEQ92wOPYQv00v6Va2B4vGii0D
X-Gm-Gg: AY/fxX4lkNpwAVWMR+M39voTiuoqOHGXiQvW+8zJxcJwWD/nNQbk7lRI/UnxAJNxY1S
	zVLmO+ZKYN6JJtZ0EURvBKr4t0frtbSFGaEB8Mkh8PBcmTMpPSOz/EgeLqQZXiNDCyXiqbwQYDy
	oKMRRmxD18H3FuiCYHK8ENwwGMoy54C8+AlyR10BVAUQ4EU3slmYV/oB8yZTOetS6o3pHBZBRaH
	Zh9K0mPkwh8sbzZUQKfMLlizFoB96JA3IkODpmiJ4NiO/NNhnO1Ab/fCvBZCvRfdAP8dAD7
X-Received: by 2002:a05:7022:1081:b0:11b:9386:a3cf with SMTP id
 a92af1059eb24-12336adf6e5mr6383640c88.48.1768488424756; Thu, 15 Jan 2026
 06:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 15 Jan 2026 15:46:38 +0100
X-Gm-Features: AZwV_QhF9NSknM7AnWVxfceVwSkoCnMSlwbqEho-4pdhInyV0Hv-9w6GTNsjfys
Message-ID: <CAK8fFZ6EBcV2p8NRBbKxWQj16yzKVpn1gsobvcpgjz7QDnyxfA@mail.gmail.com>
Subject: btrfs: refcount_t underflow/use-after-free in delayed inode update on
 6.18.y (works on 6.17.y)
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc: Igor Raits <igor@gooddata.com>, Jan Cipa <jan.cipa@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

Hello

We started to see a kernel regression after rolling out Linux 6.18.y
(vanilla-based) on our fleet. Systems upgraded from 6.17.y and were
stable there. With 6.18.y we see refcount warnings in Btrfs related to
delayed inode updates, followed by a general protection fault and a
kernel panic.

We do not have a reliable reproducer. It happens during not big
production I/O workload (up to ~10k random rw iops) after ~1 day of
uptime

1768474930143 2026-01-15T11:02:10.143Z [96139.207712] ------------[
cut here ]------------
1768474930143 2026-01-15T11:02:10.143Z [96139.209823] refcount_t:
addition on 0; use-after-free.
1768474930143 2026-01-15T11:02:10.143Z [96139.210888] WARNING: CPU: 46
PID: 3652507 at lib/refcount.c:25 refcount_warn_saturate+0x74/0x110
1768474930143 2026-01-15T11:02:10.143Z [96139.211887] Modules linked
in: mptcp_diag(E) xsk_diag(E) raw_diag(E) unix_diag(E)
af_packet_diag(E) netlink_diag(E) udp_diag(E) tcp_diag(E) inet_diag(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) tcp_bbr(E) sunrpc(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E) zram(E)
lz4hc_compress(E) lz4_compress(E) tls(E) isofs(E) intel_rapl_msr(E)
intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) virtio_net(E)
net_failover(E) virtio_gpu(E) i2c_i801(E) irqbypass(E) vfat(E)
i2c_smbus(E) failover(E) virtio_balloon(E) virtio_dma_buf(E) fat(E)
fuse(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E)
ahci(E) libahci(E) libata(E) polyval_clmulni(E) ghash_clmulni_intel(E)
virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
raid6_pq(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
1768474930143 2026-01-15T11:02:10.143Z [96139.211952] Unloaded tainted
modules: amd_atl(E):2 edac_mce_amd(E):1
1768474930143 2026-01-15T11:02:10.143Z [96139.220067] CPU: 46 UID: 0
PID: 3652507 Comm: kworker/u200:13 Tainted: G            E
6.18.5-1.gdc.el9.x86_64 #1 PREEMPT(lazy)
1768474930143 2026-01-15T11:02:10.143Z [96139.220931] Tainted:
[E]=UNSIGNED_MODULE
1768474930143 2026-01-15T11:02:10.143Z [96139.221330] Hardware name:
RDO OpenStack Compute/RHEL, BIOS edk2-20241117-8.el9 11/17/2024
1768474930143 2026-01-15T11:02:10.143Z [96139.221981] Workqueue:
btrfs-endio-write btrfs_work_helper [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.222596] RIP:
0010:refcount_warn_saturate+0x74/0x110
1768474930143 2026-01-15T11:02:10.143Z [96139.222966] Code: 01 01 e8
2f 2d a3 ff 0f 0b c3 cc cc cc cc 80 3d 1d a9 ab 01 00 75 cb 48 c7 c7
80 0a 05 ab c6 05 0d a9 ab 01 01 e8 0c 2d a3 ff <0f> 0b c3 cc cc cc cc
80 3d fc a8 ab 01 00 75 a8 48 c7 c7 58 0a 05
1768474930143 2026-01-15T11:02:10.143Z [96139.224512] RSP:
0018:ffffa862cb1e3c80 EFLAGS: 00010286
1768474930143 2026-01-15T11:02:10.143Z [96139.225005] RAX:
0000000000000000 RBX: ffffa862cb1e3db0 RCX: 0000000000000000
1768474930143 2026-01-15T11:02:10.143Z [96139.225609] RDX:
ffff9ab9c3d2a0c0 RSI: 0000000000000001 RDI: ffff9ab9c3d1c080
1768474930143 2026-01-15T11:02:10.143Z [96139.226099] RBP:
ffff9aab067f4800 R08: 0000000000000000 R09: ffffa862cb1e3b28
1768474930143 2026-01-15T11:02:10.143Z [96139.226610] R10:
ffffa862cb1e3b20 R11: ffffffffabbde748 R12: ffff9aab16835860
1768474930143 2026-01-15T11:02:10.143Z [96139.227239] R13:
000000000119c11b R14: ffff9a52e9b17a10 R15: ffff9aab067f4800
1768474930143 2026-01-15T11:02:10.143Z [96139.227790] FS:
0000000000000000(0000) GS:ffff9aba1762c000(0000)
knlGS:0000000000000000
1768474930143 2026-01-15T11:02:10.143Z [96139.228311] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
1768474930143 2026-01-15T11:02:10.143Z [96139.228682] CR2:
00007ff1ffd07608 CR3: 0000004b97d7c002 CR4: 0000000000770ef0
1768474930143 2026-01-15T11:02:10.143Z [96139.229161] PKRU: 55555554
1768474930143 2026-01-15T11:02:10.143Z [96139.229421] Call Trace:
1768474930143 2026-01-15T11:02:10.143Z [96139.229675]  <TASK>
1768474930143 2026-01-15T11:02:10.143Z [96139.229928]
btrfs_get_delayed_node.constprop.0+0xe6/0x190 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.230386]
btrfs_get_or_create_delayed_node.isra.0+0x121/0x1c0 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.230833]
btrfs_delayed_update_inode+0x24/0x210 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.231263]  ?
kvm_clock_get_cycles+0x14/0x30
1768474930143 2026-01-15T11:02:10.143Z [96139.231589]  ?
ktime_get_real_ts64+0x41/0x100
1768474930143 2026-01-15T11:02:10.143Z [96139.231929]  ?
btrfs_update_root_times+0x62/0x90 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.232349]
btrfs_update_inode+0x5c/0xb0 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.232729]
btrfs_finish_one_ordered+0x5d4/0xa60 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.233161]
btrfs_work_helper+0xbd/0x1b0 [btrfs]
1768474930143 2026-01-15T11:02:10.143Z [96139.233544]
process_one_work+0x19d/0x3d0
1768474930143 2026-01-15T11:02:10.143Z [96139.233860]  worker_thread+0x23e/0x360
1768474930143 2026-01-15T11:02:10.143Z [96139.234206]  ?
__pfx_worker_thread+0x10/0x10
1768474930143 2026-01-15T11:02:10.143Z [96139.234538]  kthread+0xfb/0x230
1768474930144 2026-01-15T11:02:10.144Z [96139.234827]  ? __pfx_kthread+0x10/0x10
1768474930144 2026-01-15T11:02:10.144Z [96139.235168]  ? __pfx_kthread+0x10/0x10
1768474930144 2026-01-15T11:02:10.144Z [96139.235478]  ret_from_fork+0xe9/0x100
1768474930144 2026-01-15T11:02:10.144Z [96139.235785]  ? __pfx_kthread+0x10/0x10
1768474930144 2026-01-15T11:02:10.144Z [96139.236125]
ret_from_fork_asm+0x1a/0x30
1768474930144 2026-01-15T11:02:10.144Z [96139.236445]  </TASK>
1768474930144 2026-01-15T11:02:10.144Z [96139.236698] ---[ end trace
0000000000000000 ]---
1768474931145 2026-01-15T11:02:11.145Z [96140.184476] ------------[
cut here ]------------
1768474931145 2026-01-15T11:02:11.145Z [96140.185401] refcount_t:
saturated; leaking memory.
1768474931145 2026-01-15T11:02:11.145Z [96140.187212] WARNING: CPU: 9
PID: 3844192 at lib/refcount.c:22 refcount_warn_saturate+0x51/0x110
1768474931145 2026-01-15T11:02:11.145Z [96140.188840] Modules linked
in: mptcp_diag(E) xsk_diag(E) raw_diag(E) unix_diag(E)
af_packet_diag(E) netlink_diag(E) udp_diag(E) tcp_diag(E) inet_diag(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) tcp_bbr(E) sunrpc(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E) zram(E)
lz4hc_compress(E) lz4_compress(E) tls(E) isofs(E) intel_rapl_msr(E)
intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) virtio_net(E)
net_failover(E) virtio_gpu(E) i2c_i801(E) irqbypass(E) vfat(E)
i2c_smbus(E) failover(E) virtio_balloon(E) virtio_dma_buf(E) fat(E)
fuse(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E)
ahci(E) libahci(E) libata(E) polyval_clmulni(E) ghash_clmulni_intel(E)
virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
raid6_pq(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
1768474931145 2026-01-15T11:02:11.145Z [96140.188889] Unloaded tainted
modules: amd_atl(E):2 edac_mce_amd(E):1
1768474931145 2026-01-15T11:02:11.145Z [96140.196641] CPU: 9 UID: 0
PID: 3844192 Comm: kworker/u194:0 Tainted: G        W   E
6.18.5-1.gdc.el9.x86_64 #1 PREEMPT(lazy)
1768474931145 2026-01-15T11:02:11.145Z [96140.200127] Tainted:
[W]=WARN, [E]=UNSIGNED_MODULE
1768474931145 2026-01-15T11:02:11.145Z [96140.201729] Hardware name:
RDO OpenStack Compute/RHEL, BIOS edk2-20241117-8.el9 11/17/2024
1768474931145 2026-01-15T11:02:11.145Z [96140.204276] Workqueue:
btrfs-endio-write btrfs_work_helper [btrfs]
1768474931145 2026-01-15T11:02:11.145Z [96140.206340] RIP:
0010:refcount_warn_saturate+0x51/0x110
1768474931145 2026-01-15T11:02:11.145Z [96140.208047] Code: 84 bc 00
00 00 c3 cc cc cc cc 85 f6 74 46 80 3d 41 a9 ab 01 00 75 ee 48 c7 c7
58 0a 05 ab c6 05 31 a9 ab 01 01 e8 2f 2d a3 ff <0f> 0b c3 cc cc cc cc
80 3d 1d a9 ab 01 00 75 cb 48 c7 c7 80 0a 05
1768474931145 2026-01-15T11:02:11.145Z [96140.213626] RSP:
0018:ffffa86222ac7ca0 EFLAGS: 00010282
1768474931146 2026-01-15T11:02:11.146Z [96140.215313] RAX:
0000000000000000 RBX: ffff9a429927f5c8 RCX: 0000000000000000
1768474931146 2026-01-15T11:02:11.146Z [96140.217470] RDX:
ffff9a5fc3cea0c0 RSI: 0000000000000001 RDI: ffff9a5fc3cdc080
1768474931146 2026-01-15T11:02:11.146Z [96140.219720] RBP:
ffff9aab16835860 R08: 0000000000000000 R09: ffffa86222ac7b48
1768474931146 2026-01-15T11:02:11.146Z [96140.221884] R10:
ffffa86222ac7b40 R11: ffffffffabbde748 R12: ffff9a6041aa4ea0
1768474931146 2026-01-15T11:02:11.146Z [96140.224042] R13:
ffff9aab168358b8 R14: ffff9aab16835978 R15: ffff9aab16835888
1768474931146 2026-01-15T11:02:11.146Z [96140.226227] FS:
0000000000000000(0000) GS:ffff9a60175ec000(0000)
knlGS:0000000000000000
1768474931146 2026-01-15T11:02:11.146Z [96140.228743] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
1768474931146 2026-01-15T11:02:11.146Z [96140.230673] CR2:
000056230ef41a48 CR3: 0000005a83348005 CR4: 0000000000770ef0
1768474931146 2026-01-15T11:02:11.146Z [96140.232908] PKRU: 55555554
1768474931146 2026-01-15T11:02:11.146Z [96140.233891] Call Trace:
1768474931146 2026-01-15T11:02:11.146Z [96140.234826]  <TASK>
1768474931146 2026-01-15T11:02:11.146Z [96140.235702]
__btrfs_release_delayed_node.part.0+0x2d5/0x300 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.237748]
btrfs_delayed_update_inode+0x144/0x210 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.239661]  ?
btrfs_update_root_times+0x62/0x90 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.241453]
btrfs_update_inode+0x5c/0xb0 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.243110]
btrfs_finish_one_ordered+0x5d4/0xa60 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.244858]
btrfs_work_helper+0xbd/0x1b0 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.246478]
process_one_work+0x19d/0x3d0
1768474931146 2026-01-15T11:02:11.146Z [96140.247792]  worker_thread+0x23e/0x360
1768474931146 2026-01-15T11:02:11.146Z [96140.249040]  ?
__pfx_worker_thread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.250439]  kthread+0xfb/0x230
1768474931146 2026-01-15T11:02:11.146Z [96140.251533]  ? __pfx_kthread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.252778]  ? __pfx_kthread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.254074]  ret_from_fork+0xe9/0x100
1768474931146 2026-01-15T11:02:11.146Z [96140.255303]  ? __pfx_kthread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.256592]
ret_from_fork_asm+0x1a/0x30
1768474931146 2026-01-15T11:02:11.146Z [96140.257956]  </TASK>
1768474931146 2026-01-15T11:02:11.146Z [96140.258854] ---[ end trace
0000000000000000 ]---
1768474931146 2026-01-15T11:02:11.146Z [96140.260452] ------------[
cut here ]------------
1768474931146 2026-01-15T11:02:11.146Z [96140.262533] refcount_t:
underflow; use-after-free.
1768474931146 2026-01-15T11:02:11.146Z [96140.263013] WARNING: CPU: 2
PID: 3844192 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
1768474931146 2026-01-15T11:02:11.146Z [96140.264182] Modules linked
in: mptcp_diag(E) xsk_diag(E) raw_diag(E) unix_diag(E)
af_packet_diag(E) netlink_diag(E) udp_diag(E) tcp_diag(E) inet_diag(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) tcp_bbr(E) sunrpc(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E) zram(E)
lz4hc_compress(E) lz4_compress(E) tls(E) isofs(E) intel_rapl_msr(E)
intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) virtio_net(E)
net_failover(E) virtio_gpu(E) i2c_i801(E) irqbypass(E) vfat(E)
i2c_smbus(E) failover(E) virtio_balloon(E) virtio_dma_buf(E) fat(E)
fuse(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E)
ahci(E) libahci(E) libata(E) polyval_clmulni(E) ghash_clmulni_intel(E)
virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
raid6_pq(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.264222] Unloaded tainted
modules: amd_atl(E):2 edac_mce_amd(E):1
1768474931146 2026-01-15T11:02:11.146Z [96140.270816] CPU: 2 UID: 0
PID: 3844192 Comm: kworker/u194:0 Tainted: G        W   E
6.18.5-1.gdc.el9.x86_64 #1 PREEMPT(lazy)
1768474931146 2026-01-15T11:02:11.146Z [96140.272437] Tainted:
[W]=WARN, [E]=UNSIGNED_MODULE
1768474931146 2026-01-15T11:02:11.146Z [96140.272985] Hardware name:
RDO OpenStack Compute/RHEL, BIOS edk2-20241117-8.el9 11/17/2024
1768474931146 2026-01-15T11:02:11.146Z [96140.273980] Workqueue:
btrfs-endio-write btrfs_work_helper [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.274850] RIP:
0010:refcount_warn_saturate+0xba/0x110
1768474931146 2026-01-15T11:02:11.146Z [96140.275466] Code: 01 01 e8
e9 2c a3 ff 0f 0b c3 cc cc cc cc 80 3d d6 a8 ab 01 00 75 85 48 c7 c7
b0 0a 05 ab c6 05 c6 a8 ab 01 01 e8 c6 2c a3 ff <0f> 0b c3 cc cc cc cc
80 3d b1 a8 ab 01 00 0f 85 5e ff ff ff 48 c7
1768474931146 2026-01-15T11:02:11.146Z [96140.277169] RSP:
0018:ffffa86222ac7ce8 EFLAGS: 00010282
1768474931146 2026-01-15T11:02:11.146Z [96140.277768] RAX:
0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
1768474931146 2026-01-15T11:02:11.146Z [96140.278507] RDX:
ffff9a5fc3cdc088 RSI: 0000000000000001 RDI: ffff9a5fc3cdc080
1768474931146 2026-01-15T11:02:11.146Z [96140.279261] RBP:
ffff9aab16835860 R08: 0000000000000000 R09: ffffa86222ac7b90
1768474931146 2026-01-15T11:02:11.146Z [96140.279981] R10:
ffffa86222ac7b88 R11: ffffffffabbde748 R12: ffff9a52e9b17a10
1768474931146 2026-01-15T11:02:11.146Z [96140.280742] R13:
ffff9a513e3555a8 R14: ffff9aab168358b8 R15: ffff9aab067f4800
1768474931146 2026-01-15T11:02:11.146Z [96140.281477] FS:
0000000000000000(0000) GS:ffff9a51175ac000(0000)
knlGS:0000000000000000
1768474931146 2026-01-15T11:02:11.146Z [96140.282161] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
1768474931146 2026-01-15T11:02:11.146Z [96140.282619] CR2:
000056231f802078 CR3: 00000069eab30001 CR4: 0000000000770ef0
1768474931146 2026-01-15T11:02:11.146Z [96140.283172] PKRU: 55555554
1768474931146 2026-01-15T11:02:11.146Z [96140.283468] Call Trace:
1768474931146 2026-01-15T11:02:11.146Z [96140.283747]  <TASK>
1768474931146 2026-01-15T11:02:11.146Z [96140.284026]
btrfs_delayed_update_inode+0x144/0x210 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.284502]  ?
btrfs_update_root_times+0x62/0x90 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.284941]
btrfs_update_inode+0x5c/0xb0 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.285144] ------------[
cut here ]------------
1768474931146 2026-01-15T11:02:11.146Z [96140.285194]
btrfs_finish_one_ordered+0x5d4/0xa60 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.285424] refcount_t:
decrement hit 0; leaking memory.
1768474931146 2026-01-15T11:02:11.146Z [96140.285687]
btrfs_work_helper+0xbd/0x1b0 [btrfs]
1768474931146 2026-01-15T11:02:11.146Z [96140.285952] WARNING: CPU: 40
PID: 3939237 at lib/refcount.c:31 refcount_warn_saturate+0xfb/0x110
1768474931146 2026-01-15T11:02:11.146Z [96140.286186]
process_one_work+0x19d/0x3d0
1768474931146 2026-01-15T11:02:11.146Z [96140.286540] Modules linked in:
1768474931146 2026-01-15T11:02:11.146Z [96140.286714]  worker_thread+0x23e/0x360
1768474931146 2026-01-15T11:02:11.146Z [96140.287041]  mptcp_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.287284]  ?
__pfx_worker_thread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.287462]  xsk_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.287651]  kthread+0xfb/0x230
1768474931146 2026-01-15T11:02:11.146Z [96140.287830]  raw_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.287965]  ? __pfx_kthread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.288126]  unix_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.288293]  ? __pfx_kthread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.288449]  af_packet_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.288582]  ret_from_fork+0xe9/0x100
1768474931146 2026-01-15T11:02:11.146Z [96140.288739]  netlink_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.288891]  ? __pfx_kthread+0x10/0x10
1768474931146 2026-01-15T11:02:11.146Z [96140.289079]  udp_diag(E)
1768474931146 2026-01-15T11:02:11.146Z [96140.289278]
ret_from_fork_asm+0x1a/0x30
1768474931147 2026-01-15T11:02:11.147Z [96140.289434]  tcp_diag(E)
1768474931147 2026-01-15T11:02:11.147Z [96140.289659]  </TASK>
1768474931147 2026-01-15T11:02:11.147Z [96140.289819]  inet_diag(E)
rpcsec_gss_krb5(E)
1768474931147 2026-01-15T11:02:11.147Z [96140.290011] ---[ end trace
0000000000000000 ]---
1768474931396 2026-01-15T11:02:11.396Z [96140.290136]  auth_rpcgss(E)
nfsv4(E) dns_resolver(E) nfs(E) lockd(E) grace(E) netfs(E) tcp_bbr(E)
sunrpc(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E)
binfmt_misc(E) zram(E) lz4hc_compress(E) lz4_compress(E) tls(E)
isofs(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E)
kvm(E) virtio_net(E) net_failover(E) virtio_gpu(E) i2c_i801(E)
irqbypass(E) vfat(E) i2c_smbus(E) failover(E) virtio_balloon(E)
virtio_dma_buf(E) fat(E) fuse(E) ext4(E) crc16(E) mbcache(E) jbd2(E)
sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E) libata(E)
polyval_clmulni(E) ghash_clmulni_intel(E) virtio_blk(E) serio_raw(E)
btrfs(E) xor(E) zstd_compress(E) raid6_pq(E) dm_mirror(E)
dm_region_hash(E) dm_log(E) dm_mod(E)
1768474931396 2026-01-15T11:02:11.396Z [96140.295546] Unloaded tainted
modules: amd_atl(E):2 edac_mce_amd(E):1
1768474931396 2026-01-15T11:02:11.396Z [96140.299185] CPU: 40 UID: 0
PID: 3939237 Comm: kworker/u199:9 Tainted: G        W   E
6.18.5-1.gdc.el9.x86_64 #1 PREEMPT(lazy)
1768474931396 2026-01-15T11:02:11.396Z [96140.299887] Tainted:
[W]=WARN, [E]=UNSIGNED_MODULE
1768474931396 2026-01-15T11:02:11.396Z [96140.300275] Hardware name:
RDO OpenStack Compute/RHEL, BIOS edk2-20241117-8.el9 11/17/2024
1768474931396 2026-01-15T11:02:11.396Z [96140.300785] Workqueue:
btrfs-delayed-meta btrfs_work_helper [btrfs]
1768474931396 2026-01-15T11:02:11.396Z [96140.301286] RIP:
0010:refcount_warn_saturate+0xfb/0x110
1768474931396 2026-01-15T11:02:11.396Z [96140.301662] Code: 08 0b 05
ab c6 05 9d a8 ab 01 01 e8 9f 2c a3 ff 0f 0b c3 cc cc cc cc 48 c7 c7
d8 0a 05 ab c6 05 84 a8 ab 01 01 e8 85 2c a3 ff <0f> 0b c3 cc cc cc cc
66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90
1768474931396 2026-01-15T11:02:11.396Z [96140.302810] RSP:
0018:ffffa862c2a8bd68 EFLAGS: 00010286
1768474931396 2026-01-15T11:02:11.396Z [96140.303207] RAX:
0000000000000000 RBX: 0000000000000001 RCX: 0000000000000027
1768474931396 2026-01-15T11:02:11.396Z [96140.303648] RDX:
ffff9aaac3d1c088 RSI: 0000000000000001 RDI: ffff9aaac3d1c080
1768474931396 2026-01-15T11:02:11.396Z [96140.304127] RBP:
ffff9aab16835860 R08: 6e656d6572636564 R09: 3b30207469682074
1768474931396 2026-01-15T11:02:11.396Z [96140.304744] R10:
203a745f746e756f R11: 746e756f63666572 R12: ffff9a6041aa4ea0
1768474931396 2026-01-15T11:02:11.396Z [96140.305376] R13:
ffff9aab168358b8 R14: ffff9aab16835978 R15: ffff9a6041aa4ea0
1768474931396 2026-01-15T11:02:11.396Z [96140.305983] FS:
0000000000000000(0000) GS:ffff9aab1762c000(0000)
knlGS:0000000000000000
1768474931396 2026-01-15T11:02:11.396Z [96140.306720] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
1768474931396 2026-01-15T11:02:11.396Z [96140.307269] CR2:
000056232e392d34 CR3: 0000002e18afb004 CR4: 0000000000770ef0
1768474931396 2026-01-15T11:02:11.396Z [96140.307870] PKRU: 55555554
1768474931396 2026-01-15T11:02:11.396Z [96140.308222] Call Trace:
1768474931396 2026-01-15T11:02:11.396Z [96140.308480]  <TASK>
1768474931396 2026-01-15T11:02:11.396Z [96140.308718]
__btrfs_release_delayed_node.part.0+0x2f9/0x300 [btrfs]
1768474931396 2026-01-15T11:02:11.396Z [96140.309238]
btrfs_async_run_delayed_root+0x18c/0x290 [btrfs]
1768474931396 2026-01-15T11:02:11.396Z [96140.309661]
btrfs_work_helper+0x14f/0x1b0 [btrfs]
1768474931396 2026-01-15T11:02:11.396Z [96140.310068]
process_one_work+0x19d/0x3d0
1768474931396 2026-01-15T11:02:11.396Z [96140.310453]  worker_thread+0x23e/0x360
1768474931396 2026-01-15T11:02:11.396Z [96140.310754]  ?
__pfx_worker_thread+0x10/0x10
1768474931396 2026-01-15T11:02:11.396Z [96140.311109]  kthread+0xfb/0x230
1768474931396 2026-01-15T11:02:11.396Z [96140.311410]  ? __pfx_kthread+0x10/0x10
1768474931396 2026-01-15T11:02:11.396Z [96140.311719]  ? __pfx_kthread+0x10/0x10
1768474931396 2026-01-15T11:02:11.396Z [96140.312029]  ret_from_fork+0xe9/0x100
1768474931396 2026-01-15T11:02:11.396Z [96140.312349]  ? __pfx_kthread+0x10/0x10
1768474931396 2026-01-15T11:02:11.396Z [96140.312691]
ret_from_fork_asm+0x1a/0x30
1768474931396 2026-01-15T11:02:11.396Z [96140.313023]  </TASK>
1768474931396 2026-01-15T11:02:11.396Z [96140.313399] ---[ end trace
0000000000000000 ]---
1768474932647 2026-01-15T11:02:12.647Z [96141.543488] Oops: general
protection fault, probably for non-canonical address
0x3849d34819851300: 0000 [#1] SMP NOPTI
1768474932647 2026-01-15T11:02:12.647Z [96141.544661] CPU: 47 UID: 0
PID: 3482047 Comm: kworker/u200:8 Tainted: G        W   E
6.18.5-1.gdc.el9.x86_64 #1 PREEMPT(lazy)
1768474932647 2026-01-15T11:02:12.647Z [96141.546777] Tainted:
[W]=WARN, [E]=UNSIGNED_MODULE
1768474932647 2026-01-15T11:02:12.647Z [96141.547329] Hardware name:
RDO OpenStack Compute/RHEL, BIOS edk2-20241117-8.el9 11/17/2024
1768474932647 2026-01-15T11:02:12.647Z [96141.547817] Workqueue:
btrfs-delalloc btrfs_work_helper [btrfs]
1768474932647 2026-01-15T11:02:12.647Z [96141.548316] RIP:
0010:kmem_cache_alloc_noprof+0x237/0x570
1768474932647 2026-01-15T11:02:12.647Z [96141.548699] Code: 0f 84 6b
01 00 00 84 c9 0f 85 63 01 00 00 41 83 f9 ff 0f 85 49 01 00 00 41 b9
ff ff ff ff 41 8b 44 24 30 49 8b 34 24 48 01 f8 <48> 8b 18 48 89 c1 49
33 9c 24 c0 00 00 00 48 89 f8 48 0f c9 48 31
1768474932647 2026-01-15T11:02:12.647Z [96141.549793] RSP:
0018:ffffa8622ceab7f0 EFLAGS: 00010216
1768474932647 2026-01-15T11:02:12.647Z [96141.550192] RAX:
3849d34819851300 RBX: ffffe8ea265a0d00 RCX: 0000000000000000
1768474932647 2026-01-15T11:02:12.647Z [96141.550649] RDX:
000000009396602f RSI: 00002da7e86de6a0 RDI: 3849d34819851268
1768474932647 2026-01-15T11:02:12.647Z [96141.551120] RBP:
ffffa8622ceab848 R08: 00005772fdae9e5d R09: 00000000ffffffff
1768474932647 2026-01-15T11:02:12.647Z [96141.551568] R10:
0000000000000000 R11: ffff9aab0b0f3ae8 R12: ffff9a51046cef80
1768474932647 2026-01-15T11:02:12.647Z [96141.552022] R13:
0000000000000d40 R14: ffffffffc133bde9 R15: 0000000000000138
1768474932647 2026-01-15T11:02:12.647Z [96141.552478] FS:
0000000000000000(0000) GS:ffff9aba1766c000(0000)
knlGS:0000000000000000
1768474932647 2026-01-15T11:02:12.647Z [96141.552965] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
1768474932647 2026-01-15T11:02:12.647Z [96141.553370] CR2:
00007ff1ffddfe08 CR3: 0000003c8a8e3004 CR4: 0000000000770ef0
1768474932647 2026-01-15T11:02:12.647Z [96141.553806] PKRU: 55555554
1768474932648 2026-01-15T11:02:12.648Z [96141.554089] Call Trace:
1768474932648 2026-01-15T11:02:12.648Z [96141.554342]  <TASK>
1768474932648 2026-01-15T11:02:12.648Z [96141.554619]
btrfs_get_or_create_delayed_node.isra.0+0x39/0x1c0 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.555100]
btrfs_delayed_update_inode+0x24/0x210 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.555571]  ?
kvm_clock_get_cycles+0x14/0x30
1768474932648 2026-01-15T11:02:12.648Z [96141.555901]  ?
ktime_get_real_ts64+0x41/0x100
1768474932648 2026-01-15T11:02:12.648Z [96141.556286]  ?
btrfs_update_root_times+0x62/0x90 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.556676]
btrfs_update_inode+0x5c/0xb0 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.557058]
__cow_file_range_inline+0x1c3/0x400 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.557458]
cow_file_range_inline.constprop.0+0xd2/0x140 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.557865]
cow_file_range+0x27e/0x780 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.558245]  ?
ZSTD_compress_frameChunk+0x4ae/0x5d0 [zstd_compress]
1768474932648 2026-01-15T11:02:12.648Z [96141.558641]
run_delalloc_cow.constprop.0+0x8e/0xc0 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.559053]
submit_uncompressed_range+0x82/0x140 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.559454]
submit_one_async_extent+0x1fe/0x370 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.559833]
submit_compressed_extents+0xc1/0x1f0 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.560241]
run_ordered_work+0x71/0x230 [btrfs]
1768474932648 2026-01-15T11:02:12.648Z [96141.560605]
process_one_work+0x19d/0x3d0
1768474932648 2026-01-15T11:02:12.648Z [96141.560912]  worker_thread+0x23e/0x360
1768474932648 2026-01-15T11:02:12.648Z [96141.561220]  ?
__pfx_worker_thread+0x10/0x10
1768474932648 2026-01-15T11:02:12.648Z [96141.561527]  kthread+0xfb/0x230
1768474932648 2026-01-15T11:02:12.648Z [96141.561792]  ? __pfx_kthread+0x10/0x10
1768474932648 2026-01-15T11:02:12.648Z [96141.562106]  ? __pfx_kthread+0x10/0x10
1768474932648 2026-01-15T11:02:12.648Z [96141.562393]  ret_from_fork+0xe9/0x100
1768474932648 2026-01-15T11:02:12.648Z [96141.562675]  ? __pfx_kthread+0x10/0x10
1768474932648 2026-01-15T11:02:12.648Z [96141.562968]
ret_from_fork_asm+0x1a/0x30
1768474932648 2026-01-15T11:02:12.648Z [96141.563283]  </TASK>
1768474932648 2026-01-15T11:02:12.648Z [96141.563509] Modules linked
in: mptcp_diag(E) xsk_diag(E) raw_diag(E) unix_diag(E)
af_packet_diag(E) netlink_diag(E) udp_diag(E) tcp_diag(E) inet_diag(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) tcp_bbr(E) sunrpc(E) nf_conntrack(E)
nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E) zram(E)
lz4hc_compress(E) lz4_compress(E) tls(E) isofs(E) intel_rapl_msr(E)
intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) virtio_net(E)
net_failover(E) virtio_gpu(E) i2c_i801(E) irqbypass(E) vfat(E)
i2c_smbus(E) failover(E) virtio_balloon(E) virtio_dma_buf(E) fat(E)
fuse(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E)
ahci(E) libahci(E) libata(E) polyval_clmulni(E) ghash_clmulni_intel(E)
virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
raid6_pq(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
1768474932648 2026-01-15T11:02:12.648Z [96141.563542] Unloaded tainted
modules: amd_atl(E):2 edac_mce_amd(E):1
1768474932648 2026-01-15T11:02:12.648Z [96141.567826] ---[ end trace
0000000000000000 ]---
1768474932648 2026-01-15T11:02:12.648Z [96141.568236] RIP:
0010:kmem_cache_alloc_noprof+0x237/0x570
1768474932648 2026-01-15T11:02:12.648Z [96141.569333] Code: 0f 84 6b
01 00 00 84 c9 0f 85 63 01 00 00 41 83 f9 ff 0f 85 49 01 00 00 41 b9
ff ff ff ff 41 8b 44 24 30 49 8b 34 24 48 01 f8 <48> 8b 18 48 89 c1 49
33 9c 24 c0 00 00 00 48 89 f8 48 0f c9 48 31
1768474932648 2026-01-15T11:02:12.648Z [96141.570942] RSP:
0018:ffffa8622ceab7f0 EFLAGS: 00010216
1768474932648 2026-01-15T11:02:12.648Z [96141.571372] RAX:
3849d34819851300 RBX: ffffe8ea265a0d00 RCX: 0000000000000000
1768474932648 2026-01-15T11:02:12.648Z [96141.572376] RDX:
000000009396602f RSI: 00002da7e86de6a0 RDI: 3849d34819851268
1768474932648 2026-01-15T11:02:12.648Z [96141.573284] RBP:
ffffa8622ceab848 R08: 00005772fdae9e5d R09: 00000000ffffffff
1768474932648 2026-01-15T11:02:12.648Z [96141.574196] R10:
0000000000000000 R11: ffff9aab0b0f3ae8 R12: ffff9a51046cef80
1768474932648 2026-01-15T11:02:12.648Z [96141.575122] R13:
0000000000000d40 R14: ffffffffc133bde9 R15: 0000000000000138
1768474932648 2026-01-15T11:02:12.648Z [96141.576080] FS:
0000000000000000(0000) GS:ffff9aba1762c000(0000)
knlGS:0000000000000000
1768474932648 2026-01-15T11:02:12.648Z [96141.577009] CS:  0010 DS:
0000 ES: 0000 CR0: 0000000080050033
1768474932648 2026-01-15T11:02:12.648Z [96141.577491] CR2:
00007f25d3621000 CR3: 0000005a83348006 CR4: 0000000000770ef0
1768474932648 2026-01-15T11:02:12.648Z [96141.578419] PKRU: 55555554
1768474932648 2026-01-15T11:02:12.648Z [96141.579164] Kernel panic -
not syncing: Fatal exception
1768474932648 2026-01-15T11:02:12.648Z [96141.580514] Kernel Offset:
0x28a00000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)
1768474932648 2026-01-15T11:02:12.648Z [96141.581179] ---[ end Kernel
panic - not syncing: Fatal exception ]---

Any help will be welcomed!

Best regards
Jaroslav Pulchart

