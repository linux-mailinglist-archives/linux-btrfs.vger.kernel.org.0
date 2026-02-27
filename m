Return-Path: <linux-btrfs+bounces-22061-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJEnMi2FoWlEuAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22061-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 12:51:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 291041B6BF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 12:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E6B303CA69
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD263148DC;
	Fri, 27 Feb 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YEtR9HuX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36245038
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772193060; cv=none; b=fk0qsPlrMVzv+Ke+PlnaaQbvUMjz/wWDsVTyhTree+uSq49gb5POYy7682Jz4t18BCHxgFS5OVt/Fs3fhNDLmkq1fFRuPVUz1Brrn5yMqDm7G7VtA/cn6kM2Gb/i/MSnDd38rdo0WXXtuE821l/A13lD7f+o+67e5Las69Qugzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772193060; c=relaxed/simple;
	bh=doAbsbeVIQE2oTC7LR8BSDavpbwQyVZ7D7BbfFRFkJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxFs6SzSnLZvIGM4HqlQudWJ6mLyCCIVboryQU1kU3poZsL8fz1i7TO3moFCBE21e5KxJ1DkYtIPa4FtyJvy1YZC29D4ER1zw500aajwfqGXdAJsT05lcCE8Xxzysj3hxr2XDjWwbr5cZIhUy/UflQNRF6pSjCSBxKAaPQDhC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YEtR9HuX; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772193059; x=1803729059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=doAbsbeVIQE2oTC7LR8BSDavpbwQyVZ7D7BbfFRFkJA=;
  b=YEtR9HuX3R/36Stjzn2ENnvfsScgrIGdbXYqGimfUWoL6eVdnN2G9kBY
   u/NBqq7B3ht9haSXCBNh4lN7fRxS823PIiL3aB1z7FByousW1VHaYnje0
   YGu01I1LNMaAQRzZvyTvPPNs16JSHeXZX5ieogaMM6JilxMdGzPHFrIoa
   87peuKnX9rspfacIKeHv1WPzwMvokEuHQzey3Dxr1Fnbw09iavgpKz1xR
   qiSzfWtFmv0BS/bP06zHidgqFNpIF2ZTnuaUlNv5mpaW8nKLzKltgcHED
   oDn6Q1IJH+BjFL7G+HJQBxClNZENb56IxTyOjr9GlN26qu2GFTcI/s/SJ
   Q==;
X-CSE-ConnectionGUID: mvUfr4GHT5ya6uQO9rZtAQ==
X-CSE-MsgGUID: TuC6lbhBSgKr+MPv7vCqCA==
X-IronPort-AV: E=Sophos;i="6.21,314,1763395200"; 
   d="scan'208";a="141587912"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2026 19:50:58 +0800
IronPort-SDR: 69a18522_nyRdhxmjBtQCeA7pRP/crgHMe55vg2BYycpQIKGyqVihRdB
 aPr9j4ofdt3Z6nRSXIUW8k9hE2QHVk0EgR1JuMQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 03:50:58 -0800
WDCIronportException: Internal
Received: from wdap-c0ecwecpdk.ad.shared (HELO neo.wdc.com) ([10.224.28.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Feb 2026 03:50:58 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: take rcu_read_lock before dereferencing device->name
Date: Fri, 27 Feb 2026 12:50:51 +0100
Message-ID: <20260227115051.136255-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22061-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 291041B6BF9
X-Rspamd-Action: no action

When mounting a zoned filesystem with lockdep enabled, the following splat
is emitted:

 =============================
 WARNING: suspicious RCU usage
 7.0.0-rc1+ #351 Not tainted
 -----------------------------
 fs/btrfs/zoned.c:594 suspicious rcu_dereference_check() usage!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 3 locks held by mount/459:
  #0: ffff8881014dec78 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig+0x2ae/0x680
  #1: ffff888101ddd0e8 (&type->s_umount_key#31/1){+.+.}-{4:4}, at: alloc_super+0xc0/0x3e0
  #2: ffff888101e294e0 (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: btrfs_get_dev_zone_info_all_devices+0x45/0x90

 stack backtrace:
 CPU: 2 UID: 0 PID: 459 Comm: mount Not tainted 7.0.0-rc1+ #351 PREEMPT(full)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x80
  lockdep_rcu_suspicious.cold+0x4e/0xa3
  btrfs_get_dev_zone_info+0x434/0x9d0
  btrfs_get_dev_zone_info_all_devices+0x62/0x90
  open_ctree+0xcd2/0x1677
  btrfs_get_tree.cold+0xfc/0x1e3
  ? rcu_is_watching+0x18/0x50
  vfs_get_tree+0x28/0xb0
  __do_sys_fsconfig+0x324/0x680
  do_syscall_64+0x92/0x4f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f88d294c40e
 Code: 73 01 c3 48 8b 0d f2 29 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c2 29 0f 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffd642d05e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
 RAX: ffffffffffffffda RBX: 000055c860d48b10 RCX: 00007f88d294c40e
 RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
 RBP: 00007ffd642d0730 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
 R13: 000055c860d49c40 R14: 00007f88d2acca60 R15: 000055c860d49d08
  </TASK>
 BTRFS info (device vda): host-managed zoned block device /dev/vda, 64 zones of 268435456 bytes
 BTRFS info (device vda): zoned mode enabled with zone size 268435456
 BTRFS info (device vda): checking UUID tree

Fix it by holding the rc_read_lock before calling into rcu_dereference()
to dereference the rcu protected device->name pointer.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index ab330ec957bc..e69a05f492a6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "linux/rcupdate.h"
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
@@ -401,17 +402,22 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 
 	/* We reject devices with a zone size larger than 8GB */
 	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
-		btrfs_err(fs_info,
-		"zoned: %s: zone size %llu larger than supported maximum %llu",
-				 rcu_dereference(device->name),
-				 zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
+		rcu_read_lock();
+		btrfs_err(
+			fs_info,
+			"zoned: %s: zone size %llu larger than supported maximum %llu",
+			rcu_dereference(device->name), zone_info->zone_size,
+			BTRFS_MAX_ZONE_SIZE);
+		rcu_read_unlock();
 		ret = -EINVAL;
 		goto out;
 	} else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
+		rcu_read_lock();
 		btrfs_err(fs_info,
 		"zoned: %s: zone size %llu smaller than supported minimum %u",
 				 rcu_dereference(device->name),
 				 zone_info->zone_size, BTRFS_MIN_ZONE_SIZE);
+		rcu_read_unlock();
 		ret = -EINVAL;
 		goto out;
 	}
@@ -427,10 +433,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	if (!max_active_zones && zone_info->nr_zones > BTRFS_DEFAULT_MAX_ACTIVE_ZONES)
 		max_active_zones = BTRFS_DEFAULT_MAX_ACTIVE_ZONES;
 	if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
+		rcu_read_lock();
 		btrfs_err(fs_info,
 "zoned: %s: max active zones %u is too small, need at least %u active zones",
 				 rcu_dereference(device->name), max_active_zones,
 				 BTRFS_MIN_ACTIVE_ZONES);
+		rcu_read_unlock();
 		ret = -EINVAL;
 		goto out;
 	}
@@ -469,9 +477,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		zone_info->zone_cache = vcalloc(zone_info->nr_zones,
 						sizeof(struct blk_zone));
 		if (!zone_info->zone_cache) {
+			rcu_read_lock();
 			btrfs_err(device->fs_info,
 				"zoned: failed to allocate zone cache for %s",
 				rcu_dereference(device->name));
+			rcu_read_unlock();
 			ret = -ENOMEM;
 			goto out;
 		}
@@ -507,10 +517,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	}
 
 	if (unlikely(nreported != zone_info->nr_zones)) {
+		rcu_read_lock();
 		btrfs_err(device->fs_info,
 				 "inconsistent number of zones on %s (%u/%u)",
 				 rcu_dereference(device->name), nreported,
 				 zone_info->nr_zones);
+		rcu_read_unlock();
 		ret = -EIO;
 		goto out;
 	}
@@ -522,10 +534,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 				zone_info->max_active_zones = 0;
 				goto validate;
 			}
+			rcu_read_lock();
 			btrfs_err(device->fs_info,
 			"zoned: %u active zones on %s exceeds max_active_zones %u",
 					 nactive, rcu_dereference(device->name),
 					 max_active_zones);
+			rcu_read_unlock();
 			ret = -EIO;
 			goto out;
 		}
@@ -591,10 +605,12 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		emulated = "emulated ";
 	}
 
+	rcu_read_lock();
 	btrfs_info(fs_info,
 		"%s block device %s, %u %szones of %llu bytes",
 		model, rcu_dereference(device->name), zone_info->nr_zones,
 		emulated, zone_info->zone_size);
+	rcu_read_unlock();
 
 	return 0;
 
-- 
2.53.0


