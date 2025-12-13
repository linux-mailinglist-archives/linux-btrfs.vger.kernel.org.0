Return-Path: <linux-btrfs+bounces-19712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD63CBB313
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 21:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5907A30056ED
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621E2E282B;
	Sat, 13 Dec 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaishome.de header.i=@kaishome.de header.b="mD2qxPfB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC23B8D75
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765656586; cv=none; b=MdNL8xBL5OEWn63khrZn0885VR/TQr08MR/XRwHQX5iaMKjMamKAHXigDrnjYYBmwIrHQDJT6tZxG5rG83VVahozu3YLE8IDzAj7JCytKrxJv5Bux0f7IkACtzKGa1lAbqqIJT6a8RSTGpS0jsabZiBOB0FXqNo90lvnZc7es18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765656586; c=relaxed/simple;
	bh=j4aWBJcyPxyRyUdrsKGNpN1lR6OAiDGTySh6nKkVBDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=frbCHq+QEayVZWVjxWg4RdJCSejUFGtt17givlyh9y8KwEbcKdTGzfromJ+Q0Tvex82CIU3geSp8MTAH+yN0HJaqmFNo68xoyrH8eUbRTruGB9a0dvFUerz6cc7sqSavrKvcCxCio7mdPNoDBdlfbpvo6A4Aqjt/X4xA5FOJMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaishome.de; spf=pass smtp.mailfrom=kaishome.de; dkim=pass (1024-bit key) header.d=kaishome.de header.i=@kaishome.de header.b=mD2qxPfB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaishome.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaishome.de
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79e7112398so459120366b.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google; t=1765656581; x=1766261381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmAdSJ8SFjNLplCRzCQ2INPCc8kOe48erv+8v1mPcYE=;
        b=mD2qxPfBmTfDcfiqmS+z8zjfuSR0WzVg12bXUaLt7uTgLFJ0GQDHvn3KOkW0rAMVtz
         vpvy0hKC56USbomAmPAyFXo3oeh5CIPe1P3kS1GxrgoHYNRszZGp75ut9SOurPN5GziN
         5Zrjb0+E/sB50kSGjAQVYeH+EDnwto5bLPPzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765656581; x=1766261381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmAdSJ8SFjNLplCRzCQ2INPCc8kOe48erv+8v1mPcYE=;
        b=AimsiXJtuVs9K7yafZSMEc/yptGuVyhKmOErEXyXp0W6tj2gxhrNaFX8te0Wk952NY
         cGsBze6hA3uhmNAmMn0zgC3uwH75SJQXgTAu7QVvMBEkxxKC0StmViV3py1gzdLYl4Nw
         8fvwTSa0tPe2U1mSbYt2mr2yhSl3c0K2Uzib/mOBOGPyxsn6kPeHLJ+qfk8nEBAH3RXq
         P15rh1Py4rbcWoTQqiY0oziPnGfsJ3JFMZPoqTZUTC2B3xWsRfBd2vl4HDuOOEjOgWyY
         I1VgiVCNCg21SqpRqUB8/DJl378iXYpnOnTl1JAv4d2IRcM+XCls7m3fMC8ncYc/W9eO
         4xrQ==
X-Gm-Message-State: AOJu0YyyBrePPTFnKcnXQxdrFGC0d/C1AFgUEPcYj4JEiKLkPaotIRtp
	lH/qu5ytfGVgTMEbWLEHz//bKcr0wKcyk5rggMYUwr8tFQVk5BsC1tr9dKdme0sDPJXsiL5tGbG
	4Ha+flTg=
X-Gm-Gg: AY/fxX6VLrKfl3WlsSokfTMviI2CvotT5xnnOFJ/1/mM86UleI68hZZ2j2FZkYstf/1
	azJl/N1S/oMH8UQyrGFi1Qeoh1X3p3jQar6Med3JAdZyrvoO6/eYbZfhV1DjFNo7s0fW7TWbqw6
	FLKiGZpc8CbQhblU+LvMrkgFIFgKksDLCo86UmDjlsrcALL3tqQYlomsR3erqKjvtW88JwqvGvM
	o6+jMfr5433TdkS9Ebc0mObcUVlbGkohH/+b0UUp7Z9oFbt0nJSnYEgx8ofIUaVWcHk3yUozDcY
	QLaoNZZcGN9UnDb6qVj1/+KTuzChYyKz/nOD558uggEJqR59u3Tv3jUGi0NiZKm4t3eiC28ZxoC
	+ut02K0jLgUhXUBZHZ9JPOnxZvTf9notXY30ByOyG5M6DrkGw8WeJiCMMKtS3+7YaUdlwetlzQY
	Zgz1y382/TEqFlnAKz9jkESD+JD2LF59yLBYVrEwA=
X-Google-Smtp-Source: AGHT+IFOj8sUk4Q8QMjyb4EExLyznVLIFPw2gadtF79+IQnUhIS+R42EMuet/jnrhMWSO+Ht2Da5nQ==
X-Received: by 2002:a17:907:60cf:b0:b5c:753a:e022 with SMTP id a640c23a62f3a-b7d236e0441mr660284266b.29.1765656581255;
        Sat, 13 Dec 2025 12:09:41 -0800 (PST)
Received: from jupiter.sol.kaishome.de ([2a02:8109:c11:9c00:4cfe:14ff:fe36:c983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5d2680sm921095266b.70.2025.12.13.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 12:09:40 -0800 (PST)
Received: (nullmailer pid 1809444 invoked by uid 1000);
	Sat, 13 Dec 2025 20:09:40 -0000
From: Kai Krakow <kai@kaishome.de>
To: linux-btrfs@vger.kernel.org
Cc: Kai Krakow <kai@kaishome.de>, Eli Venter <eli@genedx.com>
Subject: [PATCH] btrfs: harden __reserve_bytes() with space_info==NULL
Date: Sat, 13 Dec 2025 21:09:15 +0100
Message-ID: <20251213200920.1808679-1-kai@kaishome.de>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During mount, the global block reserve might not have its space_info
initialized yet. If we try to reserve bytes in this state (e.g. via
early sysfs writes), we must not crash.

This happened while developing patches which allow modification of the
devinfo.type field via sysfs. If this write access is executed by the
user before the mount finished, the kernel crashed with a NULL pointer
dereference:

> Noticed an oops with these patches when doing echo 1 >devinfo/2/type
> while mount is still ongoing. My btrfs is big so the mount takes
> 20-30 minutes. Reboot and wait until mount is complete and this
> worked fine.

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0
Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 4 UID: 0 PID: 3520 Comm: bash Not tainted 6.12.52-dirty #2
Hardware name: Penguin Computing Relion 1900/MD90-FS0-ZB-XX, BIOS R15 06/25/2018
RIP: 0010:_raw_spin_lock+0x17/0x30
Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0
Call Trace:

__reserve_bytes+0x70/0x720 [btrfs]
? get_page_from_freelist+0x343/0x1570
btrfs_reserve_metadata_bytes+0x1d/0xd0 [btrfs]
btrfs_use_block_rsv+0x153/0x220 [btrfs]
btrfs_alloc_tree_block+0x83/0x580 [btrfs]
btrfs_force_cow_block+0x129/0x620 [btrfs]
btrfs_cow_block+0xcd/0x230 [btrfs]
btrfs_search_slot+0x566/0xd60 [btrfs]
? kmem_cache_alloc_noprof+0x106/0x2f0
btrfs_update_device+0x91/0x1d0 [btrfs]
btrfs_devinfo_type_store+0xb8/0x140 [btrfs]
kernfs_fop_write_iter+0x14c/0x200
vfs_write+0x289/0x440
ksys_write+0x6d/0xf0
trace_clock_x86_tsc+0x20/0x20
? do_wp_page+0x838/0xf90
? __do_sys_newfstat+0x68/0x70
? __pte_offset_map+0x1b/0xf0
? __handle_mm_fault+0xa6c/0x10f0
? __count_memcg_events+0x53/0xf0
? handle_mm_fault+0x1c4/0x2d0
? do_user_addr_fault+0x334/0x620
? arch_exit_to_user_mode_prepare.isra.0+0x11/0x90
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fd6e27a1687
Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffecb401260 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd6e270f740 RCX: 00007fd6e27a1687
RDX: 0000000000000002 RSI: 0000557a2c38ad20 RDI: 0000000000000001
RBP: 0000557a2c38ad20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 00007fd6e28fa5c0 R14: 00007fd6e28f7e80 R15: 0000000000000000

Modules linked in: rpcsec_gss_krb5 nfsv3 nfsv4 dns_resolver nfs netfs zram lz4hc_compress lz4_compress dm_crypt bonding tls ipmi_ssif intel_rapl_msr nfsd binfmt_misc auth_rpcgss nfs_acl lockd grace intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp rapl intel_cstate s>
intel_pmc_bxt ixgbe ehci_pci iTCO_vendor_support xfrm_algo gf128mul libata mpt3sas xhci_hcd ehci_hcd watchdog crypto_simd mdio_devres libphy cryptd raid_class usbcore scsi_transport_sas mdio igb scsi_mod wmi usb_common i2c_i801 lpc_ich scsi_common i2c_smbus i2c_algo_bit dca
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:_raw_spin_lock+0x17/0x30
Code: 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 ff 05 e8 c0 d8 5e 31 c0 ba 01 00 00 00 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 97 01 00 00 0f 1f 80 00
RSP: 0018:ffffbc13a95837c8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000008 R08: ffffbc13a9583a07 R09: 0000000000000001
R10: d800000000000000 R11: 0000000000000001 R12: ffff9bee913db000
R13: 0000000000000000 R14: 00000000fffffffb R15: ffff9bee913db000
FS: 00007fd6e270f740(0000) GS:ffff9bfddfc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 00000008d9986004 CR4: 00000000003706f0

Reported-by: Eli Venter <eli@genedx.com>
Signed-off-by: Kai Krakow <kai@kaishome.de>
---
 fs/btrfs/space-info.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 97452fb5d29b..cbb6c4924850 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1752,6 +1752,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ASSERT(flush != BTRFS_RESERVE_FLUSH_EVICT);
 	}
 
+	/*
+	 * During mount, the global block reserve might not have its space_info
+	 * initialized yet. If we try to reserve bytes in this state (e.g. via
+	 * early sysfs writes), we must not crash.
+	 */
+	if (unlikely(!space_info))
+		return -EBUSY;
+
 	if (flush == BTRFS_RESERVE_FLUSH_DATA)
 		async_work = &fs_info->async_data_reclaim_work;
 	else
-- 
2.51.2


