Return-Path: <linux-btrfs+bounces-21841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GsNGT1rnGmcGAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21841-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:59:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0909A178552
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75B1314EA16
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BF2609FD;
	Mon, 23 Feb 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp3MDkcD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1F45BE3
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858530; cv=pass; b=S5cZNUtGMea7UAnUDx6jf4hIcSZinKy6ta4n2wmNq9f2zYYjy8Z4hg9/vJIe79MzTRSeQQVw2nNk6N8e3bLo26zDLJ+uSd9Ig5XznYzpu71thisgtuqBt11xpFaPz233bFysc4zFk7/Lar1O8EOoCQCDbD6d9OFnj9T6Awvy5bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858530; c=relaxed/simple;
	bh=0S9V/YhXZo7uGst4267IYCROffUc26o3x1Dy0pnGjG8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HuNCOlgST2hUX65xitcGv40Vav65FkKs8aL4NdQnMneUlLOa5JyLslk9vEWawLpQr6T4sjKk7fN+fMY35DiZk2hopDPvyGUiG3unuK4Gs/0Tly/FdaoQQpfthAvaLINCl95UhNmjdzc3DGh9PflYnZdBhIrrj/to+OtXBjoAsGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp3MDkcD; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2387675a91.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 06:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771858528; cv=none;
        d=google.com; s=arc-20240605;
        b=WVQti8+N7rYucgneIAlg+lExqzNwg7eY3j05BJucCNrqc1YDH2FNPBvmfnJZcXGwoq
         3pgYJjnaiMUXBRLkety9E/OdsvwYU8W1sO/dIl1W3UphaPnTTCF8SSc4snb18LTksSnZ
         7K44D8yPPRQSd1OtS3VM2oS/3olHL4mIXlSAknVqrz9lNBsZV0IZaY6TQDSIRzlVlVva
         ieNu3CD7LiI6TyZe6zXsneJZSEiSKTJvi1Edme4N2gZbe4f1iMMU9H/sMYOYBuPTyfa1
         DwY9WhUHt1vaiKdDLcH0yJNce/EpZSoYdcE57CCE12P2OL8FlcF7H/28c8YyIi8D86Xt
         RDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ipA8SeqswOWp5iyV+yNL1tYSYEFH6cRfHdMqb7hBklY=;
        fh=zUaOpz0duJc6HvyGXcDI20OSz3S9aVeoUH2haB+ve4Y=;
        b=b+Csk5VUQFRUpcU4s8MqjA2/TzB836kwqtBG0kvmh/H9RV2pMry4q1CgBCgpq445Vt
         +QR/V6soiClYJnioxOhMOmIZ4JRkDEDjlJqfNlDa3myZIixshCF8+sHlv/TQPGoRccCb
         i+QpUfiMY+sQRCsYAZJ1/GMbzNOWcPrx5vkr4vmbMYh6GQgyfwpXUSORaEsX2+r+G11M
         QcGIlmww2E2L4VXWvu+Z/ME43srprIor69RZF5wYnNO6LzITppq8Y1gKp0e8bvw1e4xg
         X43IhXD/sHv0PjXuPNgHXOc/ZUhFL+fDBr2t0KCr/0KsPb2w/8VWytmkrOea7Ei3Ivpp
         5JPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771858528; x=1772463328; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ipA8SeqswOWp5iyV+yNL1tYSYEFH6cRfHdMqb7hBklY=;
        b=Zp3MDkcD7ESSbvKkJBYHsZv3dNMGF7WBcQZUs7Kp7UH/7678lDFNvd6IAS8FhQM1TY
         r9NSZTbDhtltwjtwegbwhZ9QXga+T8o3O+LsRNASv+FiNaC0wTqv3vo+AEZHQF6TAKSB
         WsNmBh4oreM+dHLdwuB6iX2yZwnzqv5GrQnu+eKibc7Hvt5hIKQ0/oxTHjAwbwquADyq
         JyQNTAcwXfcQMgY/WnYzPzd6khVtqi+SHSs2HSnGz6PWq97bpTVjQIqzDPm+PTt2RSYb
         p8GPhP+pG24dwyqLV6zLtzUmzPsx8xPEq5FXEudNVGIbCUetm3/60aKek89enuKfDp08
         Txvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858528; x=1772463328;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipA8SeqswOWp5iyV+yNL1tYSYEFH6cRfHdMqb7hBklY=;
        b=cc1F+EHXZOGP2FgnP2K1+cPPPmvhx3M1T8iPOYRjG0+AhGYYqOJHktzua1vkgoid0L
         3DJdrjk5Jhvmg1NIYTE4R+XrckMUwQgg46up609Auk9VK5K+UkLrKF8kJrGFB0lnt9n/
         kBcOQkwTpJRtH/v4c9kOiu3elyfqTL/qwV6gae133r/r64L6UgT4BEfMt9HV2FwgqHzO
         Ow9aF4+469nHs7Hv1s1eOLCmVM99RdvA+L4PZ5NlqepfSoTZs/HeNmk6On3VcicHtHiW
         /YFa7xxKye9T9RDOXz3yKkaX41SQbJleqo72/JYpWJqGewqJ5Wg+cJj2d2CwI6PEvCV5
         iXzg==
X-Gm-Message-State: AOJu0YxGFACpbPj5+RywNZt2bYfUwfrp94gLWQtUqtH19/bWQ2fTG9lS
	AWm/RPIj3xJfZC3ctjE8UOrcuKozHdSCt+0p9Uh9zi23Ktf9j3jEdqjqoOgDFLDGx9qgJB6e+L9
	OsOtY7bc70PIEjiqVIpOfvs+zLHNWKz1+V8fA
X-Gm-Gg: ATEYQzzoY8maoJkBkjWDxOweLXQLLEed9ZuMxYMdn2/WvNNzkhNrSVZ1mH2d616ro74
	1hN5lL6vJ6ejyRtio9ms+AOfglSdAiicHA7v6U1sXLfdmmiqw6C/pEuFa30KCwMmBkzCJ/IOSfV
	mXHot6CglT6c2qG6KphJT0ew9Ki/9a2+gfYQWITOnvknvtcRUGKIBfTFuIMW356PHLByzNKJdTq
	/Q/ra7z5SLKmGM5wWEFHZlI4tUZdW5QKkLsVkz8rO8XlT16+nhCyC0RQPvz+qfKomg0843RfUlP
	2oAeSemB5KmRKx4upn44ebuAa7PQrefvmJvS0gE=
X-Received: by 2002:a17:90a:e707:b0:343:edb0:1012 with SMTP id
 98e67ed59e1d1-358ae8a42bcmr6224138a91.21.1771858528281; Mon, 23 Feb 2026
 06:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jorge Bastos <jorge.mrbastos@gmail.com>
Date: Mon, 23 Feb 2026 14:55:17 +0000
X-Gm-Features: AaiRm53QvBzJpn9bzP1sUf1QWM8-6PmqRL32j359YdthSAHVI9erCBFwRWPjyfo
Message-ID: <CAHzMYBSfK7Ms9W9rc1mzsyP0aRkXg=3G6VXuur15jm7OE2JoCA@mail.gmail.com>
Subject: Btrfs with zoned devices
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-21841-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorgemrbastos@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0909A178552
X-Rspamd-Action: no action

Hi,

I'm using a zoned device for the first time; it's a 27TB WD Ultrastar
HC680, formatted with single data and DUP metadata.

This will be used for non-critical WORM media data, but during the
initial data load, using a single rsync thread, the filesystem crashed
twice, 1st time after copying around 1.25T, 2nd time around 2.5T
total.

I'm now using some mount options suggested by LLMs, and it hasn't
crashed so far, but it's not been long; currently at 3.58T used.

mount -o rw,noatime,commit=60,flushoncommit,discard=async

My question is, are these mount options good for HM-SMR or do you
recommend different ones, and could they help with the crashing?


These were the crashes I saw, they look similar to me, and after
unmounting and remounting, it worked again:

Kernel 6.18.9
btrfs-progs v6.17.1

1st one:

Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb) in
btrfs_commit_transaction:2536: errno=-11 unknown (Error while writing
out transaction)
Feb 22 21:35:56 Tower7 kernel: BTRFS info (device sdb state E): forced readonly
Feb 22 21:35:56 Tower7 kernel: BTRFS warning (device sdb state E):
Skipping commit of aborted transaction.
Feb 22 21:35:56 Tower7 kernel: ------------[ cut here ]------------
Feb 22 21:35:56 Tower7 kernel: BTRFS: Transaction aborted (error -11)
Feb 22 21:35:56 Tower7 kernel: WARNING: CPU: 8 PID: 109946 at
fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
Feb 22 21:35:56 Tower7 kernel: Modules linked in: md_mod br_netfilter
nft_compat af_packet veth nf_conntrack_netlink xt_nat iptable_raw
xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
xt_addrtype xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables nfnetlink
ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_filter
ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
kvm_amd ast kvm drm_shmem_helper drm_client_lib drm_kms_helper
ipmi_ssif ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq
backlight i2c_algo_bit input_leds joydev led_class ccp i2c_piix4
i2c_smbus acpi_ipmi ses enclosure i2c_core k10temp ipmi_si button
zfs(PO) spl(O) [last unloaded: md_mod]
Feb 22 21:35:56 Tower7 kernel: CPU: 8 UID: 0 PID: 109946 Comm:
btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
PREEMPT(voluntary)
Feb 22 21:35:56 Tower7 kernel: Tainted: [P]=PROPRIETARY_MODULE,
[W]=WARN, [O]=OOT_MODULE
Feb 22 21:35:56 Tower7 kernel: Hardware name: Supermicro Super
Server/H11SSL-i, BIOS 2.4 12/27/2021
Feb 22 21:35:56 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+0x994/0xb20
Feb 22 21:35:56 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48 c7
c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 4b
81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 07 00
00 4c 89 e7 48 c7 c6
Feb 22 21:35:56 Tower7 kernel: RSP: 0018:ffffc9003cac7de0 EFLAGS: 00010282
Feb 22 21:35:56 Tower7 kernel: RAX: 0000000000000000 RBX:
00000000fffffff5 RCX: 0000000000000002
Feb 22 21:35:56 Tower7 kernel: RDX: 0000000000000027 RSI:
ffffffff825f9e70 RDI: 00000000ffffffff
Feb 22 21:35:56 Tower7 kernel: RBP: ffff88826a27d000 R08:
0000000000000000 R09: 0000000000000000
Feb 22 21:35:56 Tower7 kernel: R10: 0000000000000000 R11:
00000000312d2072 R12: ffff888290a1b7e0
Feb 22 21:35:56 Tower7 kernel: R13: ffff888249304c00 R14:
ffff88826a27d000 R15: ffff888100ec6300
Feb 22 21:35:56 Tower7 kernel: FS:  0000000000000000(0000)
GS:ffff88a04997c000(0000) knlGS:0000000000000000
Feb 22 21:35:56 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 22 21:35:56 Tower7 kernel: CR2: 00007ffcad620af8 CR3:
00000001f5915000 CR4: 0000000000350ef0
Feb 22 21:35:56 Tower7 kernel: Call Trace:
Feb 22 21:35:56 Tower7 kernel: <TASK>
Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 22 21:35:56 Tower7 kernel: ? start_transaction+0x46e/0x5e0
Feb 22 21:35:56 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x60
Feb 22 21:35:56 Tower7 kernel: transaction_kthread+0xf0/0x170
Feb 22 21:35:56 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x10
Feb 22 21:35:56 Tower7 kernel: kthread+0x1ce/0x1e0
Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 22 21:35:56 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 22 21:35:56 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0x210
Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 22 21:35:56 Tower7 kernel: ret_from_fork+0x24/0x130
Feb 22 21:35:56 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 22 21:35:56 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
Feb 22 21:35:56 Tower7 kernel: </TASK>
Feb 22 21:35:56 Tower7 kernel: ---[ end trace 0000000000000000 ]---
Feb 22 21:35:56 Tower7 kernel: BTRFS: error (device sdb state EA) in
cleanup_transaction:2021: errno=-11 unknown

2nd one:

Feb 23 06:50:21 Tower7 kernel: BTRFS: error (device sdb) in
btrfs_commit_transaction:2536: errno=-11 unknown (Error while writing
out transaction)
Feb 23 06:50:21 Tower7 kernel: BTRFS info (device sdb state E): forced readonly
Feb 23 06:50:21 Tower7 kernel: BTRFS warning (device sdb state E):
Skipping commit of aborted transaction.
Feb 23 06:50:21 Tower7 kernel: ------------[ cut here ]------------
Feb 23 06:50:21 Tower7 kernel: BTRFS: Transaction aborted (error -11)
Feb 23 06:50:21 Tower7 kernel: WARNING: CPU: 8 PID: 2604334 at
fs/btrfs/transaction.c:2021 btrfs_commit_transaction+0x994/0xb20
Feb 23 06:50:21 Tower7 kernel: Modules linked in: md_mod br_netfilter
nft_compat af_packet veth nf_conntrack_netlink xt_nat iptable_raw
xt_conntrack bridge stp llc xfrm_user xfrm_algo xt_set ip_set
xt_addrtype xt_MASQUERADE xt_tcpudp xt_mark tun nf_tables nfnetlink
ip6table_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ipmi_devintf ip6table_filter ip6_tables iptable_filter
ip_tables x_tables macvtap macvlan tap mlx5_core mlxfw tls igb
intel_rapl_msr amd64_edac edac_mce_amd edac_core intel_rapl_common
kvm_amd ast kvm drm_shmem_helper drm_client_lib drm_kms_helper
ipmi_ssif ghash_clmulni_intel aesni_intel drm rapl acpi_cpufreq
backlight i2c_algo_bit input_leds joydev led_class ccp i2c_piix4
i2c_smbus acpi_ipmi ses enclosure i2c_core k10temp ipmi_si button
zfs(PO) spl(O) [last unloaded: md_mod]
Feb 23 06:50:21 Tower7 kernel: CPU: 8 UID: 0 PID: 2604334 Comm:
btrfs-transacti Tainted: P        W  O        6.18.9-Unraid #4
PREEMPT(voluntary)
Feb 23 06:50:21 Tower7 kernel: Tainted: [P]=PROPRIETARY_MODULE,
[W]=WARN, [O]=OOT_MODULE
Feb 23 06:50:21 Tower7 kernel: Hardware name: Supermicro Super
Server/H11SSL-i, BIOS 2.4 12/27/2021
Feb 23 06:50:21 Tower7 kernel: RIP: 0010:btrfs_commit_transaction+0x994/0xb20
Feb 23 06:50:21 Tower7 kernel: Code: ba ff 49 8b 7c 24 60 89 da 48 c7
c6 2a 81 57 82 e8 81 14 a9 ff e8 2c ef ba ff eb 10 89 de 48 c7 c7 4b
81 57 82 e8 6c d5 b1 ff <0f> 0b 41 b0 01 41 83 e0 01 89 d9 ba e5 07 00
00 4c 89 e7 48 c7 c6
Feb 23 06:50:21 Tower7 kernel: RSP: 0018:ffffc9000e6f7de0 EFLAGS: 00010282
Feb 23 06:50:21 Tower7 kernel: RAX: 0000000000000000 RBX:
00000000fffffff5 RCX: 0000000000000002
Feb 23 06:50:21 Tower7 kernel: RDX: 0000000000000c21 RSI:
ffffffff828b5a88 RDI: 00000000ffffffff
Feb 23 06:50:21 Tower7 kernel: RBP: ffff88814a3f5000 R08:
0000000000000000 R09: 0000000000000000
Feb 23 06:50:21 Tower7 kernel: R10: 0000000000000000 R11:
00000000312d2072 R12: ffff888227266690
Feb 23 06:50:21 Tower7 kernel: R13: ffff8882e753b400 R14:
ffff88814a3f5000 R15: ffff8882190ae300
Feb 23 06:50:21 Tower7 kernel: FS:  0000000000000000(0000)
GS:ffff88a04997c000(0000) knlGS:0000000000000000
Feb 23 06:50:21 Tower7 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 23 06:50:21 Tower7 kernel: CR2: 0000148aabc77d74 CR3:
00000001f5915000 CR4: 0000000000350ef0
Feb 23 06:50:21 Tower7 kernel: Call Trace:
Feb 23 06:50:21 Tower7 kernel: <TASK>
Feb 23 06:50:21 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 23 06:50:21 Tower7 kernel: ? start_transaction+0x46e/0x5e0
Feb 23 06:50:21 Tower7 kernel: ? hrtimer_nanosleep_restart+0x50/0x60
Feb 23 06:50:21 Tower7 kernel: transaction_kthread+0xf0/0x170
Feb 23 06:50:21 Tower7 kernel: ? __pfx_transaction_kthread+0x10/0x10
Feb 23 06:50:21 Tower7 kernel: kthread+0x1ce/0x1e0
Feb 23 06:50:21 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 23 06:50:21 Tower7 kernel: ? srso_return_thunk+0x5/0x5f
Feb 23 06:50:21 Tower7 kernel: ? finish_task_switch.isra.0+0x139/0x210
Feb 23 06:50:21 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 23 06:50:21 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 23 06:50:21 Tower7 kernel: ret_from_fork+0x24/0x130
Feb 23 06:50:21 Tower7 kernel: ? __pfx_kthread+0x10/0x10
Feb 23 06:50:21 Tower7 kernel: ret_from_fork_asm+0x1a/0x30
Feb 23 06:50:21 Tower7 kernel: </TASK>
Feb 23 06:50:21 Tower7 kernel: ---[ end trace 0000000000000000 ]---
Feb 23 06:50:21 Tower7 kernel: BTRFS: error (device sdb state EA) in
cleanup_transaction:2021: errno=-11 unknown

Thanks,
Jorge

