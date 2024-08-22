Return-Path: <linux-btrfs+bounces-7410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2695BC71
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 18:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827FF1C219E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955E1CDA3B;
	Thu, 22 Aug 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itYhNd10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E518182DF;
	Thu, 22 Aug 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345424; cv=none; b=JQkYreh8Q0xCRzORLbtbr5H5UjBrZ/tR45vOIRp7yZ8BJX7oxmSAu7fWL/JivrSATjY9+Bgjs997UY8s8ehFb+hDq1D/LnjJnsVVmDaQ528TguQE91Lq9X54BlAPZoXnVSAEWM3xO+A1aRUeVv/ErGYf9iPgpGRUQh5+WM8u70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345424; c=relaxed/simple;
	bh=NCwOYKHYOxXoWk0xfYfIq4WyF4GNxsFkW/6/603e224=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRi0mMluswKmolPfG+q4Uo65bWLY2UZeygoL8oojUkvRQdvlZC5dcYXsHdNmxm5nqxfBXRTV6ED2VHXh782NuH/hZbU22h9FdTIhLRgF75tXtrL1ZBdNn1ZRYGccTxCK/8Jfvw3WBqgIByKEa09SODs/EAuOLBrq4VUouWzPDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itYhNd10; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428178fc07eso7442035e9.3;
        Thu, 22 Aug 2024 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724345420; x=1724950220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3unbMUhOla43eCltTkkVXdqseB7mJt30tHdRO+hF6s=;
        b=itYhNd10KCUYfP5Io/Kjg+u/UZsA6IIjV1DsYPJEyov1nUaPuFt3syWcLwokenkFxD
         qT/Hyt5aD3rMxyjwXy3WA/hbrKuRHUSGEzJanulwt25t9wKWu8nPoZ5+eHrk6BQPcnJQ
         DIaAPG41suAR4dabB6Fqb3qp4NH8FpLgY2zVIgeBHtvCzqAXZrX3Q+tJln4KNuKuRYga
         xmYA3f4BrjEOkzTb+l0gPLB5lnMWIBeuN4FvO2E9tlcaUlxP26D1fxr011Bqd7o66RnO
         ZOYyjiPbTV57UY63XIzSnXsJ+4tq6kSomvTr2J9I6oD6f+gQ/YgzYcx8QhcUL/WWpcKO
         ug1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345420; x=1724950220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3unbMUhOla43eCltTkkVXdqseB7mJt30tHdRO+hF6s=;
        b=wxHnfje8vx+/I8jxed1hdXLn3WlZpiq4HqLR8Fp8BDYE8iHDEtDZoapeJTS0/4zTPw
         Wy7ZsLXHXkOHfRWFW+uS+Y/2O/vhuB5vevaT8Tx6jYqrB9NqMGrMQRIS3LeiDwk5v5Nl
         iYDSpfA1IHwfeEdPmWn1smiFAjx/tIWPHkOlG2E1Mx8B4KS4HJ0f7so1pJxztM9ADoAi
         Wbx1uEcdS3qXQtupgPeHsElE3u8VvikqPwxbK+ez/zauarFEaF9R0JaF0mXLOhNio3sZ
         /hnFSeiw/n2CZQ61sZb3U6DZjEzFHu19OAJ+H+hhl7MgVuLRQy5zr6gkvgEajF0G4T29
         4NWg==
X-Forwarded-Encrypted: i=1; AJvYcCW/kFCsTLJBhKrFjZPOyhH0KuBKCA2yW5t0SJK60mfE3P0hn6PcX/2IHf8QRWL4GzOs0At0yJaGFMWPsQ==@vger.kernel.org, AJvYcCWFSrHjtncXCyvSp71NZqEpdp4MpgypSPcYf2PFgWf3DwdJlwWU/sN+Ohs+COHY+FEjE2UR+kArA+R8LFMW@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFrVwQD5XLkL3yvMpJd8PxTXTouJvRIG07zEX1aQJRm08wrwp
	ONoAHs7k3bJdAtbBIaAi4iLII3ZA3woAM0TEJNyicqrKin890JnuweC36VHm
X-Google-Smtp-Source: AGHT+IGdomA5eWn9DTUmWur5B3yIsU0TYNgbHmEdqsKbWNdS8kmRjGZgk+c7NKvwoRf3c/0/SqY+tw==
X-Received: by 2002:adf:b356:0:b0:371:9377:975f with SMTP id ffacd0b85a97d-37308c185b1mr1470026f8f.25.1724345419433;
        Thu, 22 Aug 2024 09:50:19 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37308265ae6sm2073725f8f.109.2024.08.22.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:50:18 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Don't block system suspend during fstrim
Date: Thu, 22 Aug 2024 18:48:21 +0200
Message-ID: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the system isn't able to suspend because
the task responsible for trimming the device isn't
able to finish in time.

Since discard isn't a critical call it can be interrupted
at any time, we can simply report the amount of discarded
bytes in such cases and stop the trim.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
I have no idea if that's correct, just something I implemented
looking at the same solution made in ext4 by 5229a658f645.

The patch in itself seems to solve the issue.

repro is as follows:
sudo /sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo --verbose --quiet-unsupported &
sudo ./sleepgraph.py -m mem -rtcwake 5

[836563.289069] PM: suspend exit
[836563.909298] PM: suspend entry (s2idle)
[836563.935447] Filesystems sync: 0.026 seconds
[836563.951391] Freezing user space processes
[836583.958957] Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
[836583.959582] task:fstrim          state:D stack:0     pid:241865 tgid:241865 ppid:241864 flags:0x00004006
[836583.959592] Call Trace:
[836583.959595]  <TASK>
[836583.959600]  __schedule+0x400/0x1720
[836583.959612]  ? mod_delayed_work_on+0xa4/0xb0
[836583.959622]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959628]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959631]  ? blk_mq_flush_plug_list.part.0+0x1e3/0x610
[836583.959640]  schedule+0x27/0xf0
[836583.959644]  schedule_timeout+0x12f/0x160
[836583.959652]  io_schedule_timeout+0x51/0x70
[836583.959657]  wait_for_completion_io+0x8a/0x160
[836583.959663]  submit_bio_wait+0x60/0x90
[836583.959671]  blkdev_issue_discard+0x91/0x100
[836583.959680]  btrfs_issue_discard+0xc4/0x140
[836583.959689]  btrfs_discard_extent+0x241/0x2a0
[836583.959695]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959702]  do_trimming+0xd2/0x240
[836583.959712]  trim_bitmaps+0x350/0x4c0
[836583.959723]  btrfs_trim_block_group+0xb8/0x110
[836583.959729]  btrfs_trim_fs+0x118/0x440
[836583.959734]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959738]  ? security_capable+0x41/0x70
[836583.959746]  btrfs_ioctl_fitrim+0x113/0x180
[836583.959752]  btrfs_ioctl+0xdaf/0x2670
[836583.959759]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959763]  ? ioctl_has_perm.constprop.0.isra.0+0xd8/0x130
[836583.959774]  __x64_sys_ioctl+0x94/0xd0
[836583.959782]  do_syscall_64+0x82/0x160
[836583.959790]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959793]  ? syscall_exit_to_user_mode+0x72/0x220
[836583.959799]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959802]  ? do_syscall_64+0x8e/0x160
[836583.959807]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959811]  ? do_sys_openat2+0x9c/0xe0
[836583.959821]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959825]  ? syscall_exit_to_user_mode+0x72/0x220
[836583.959828]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959832]  ? do_syscall_64+0x8e/0x160
[836583.959835]  ? syscall_exit_to_user_mode+0x72/0x220
[836583.959838]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959842]  ? do_syscall_64+0x8e/0x160
[836583.959845]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959849]  ? do_syscall_64+0x8e/0x160
[836583.959851]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959855]  ? do_syscall_64+0x8e/0x160
[836583.959858]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959861]  ? do_syscall_64+0x8e/0x160
[836583.959864]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959868]  ? srso_alias_return_thunk+0x5/0xfbef5
[836583.959873]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[836583.959878] RIP: 0033:0x7f3e4261af2d
[836583.959944] RSP: 002b:00007ffec002f400 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[836583.959950] RAX: ffffffffffffffda RBX: 00007ffec002f570 RCX: 00007f3e4261af2d
[836583.959952] RDX: 00007ffec002f470 RSI: 00000000c0185879 RDI: 0000000000000003
[836583.959955] RBP: 00007ffec002f450 R08: 0000562d74da7010 R09: 00007ffec002e7f2
[836583.959957] R10: 0000000000000000 R11: 0000000000000246 R12: 0000562d74daafc0
[836583.959960] R13: 0000000000000003 R14: 0000562d74daa970 R15: 0000562d74daad40
[836583.959967]  </TASK>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..7e4c1d4f2f7c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -16,6 +16,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/lockdep.h>
 #include <linux/crc32c.h>
+#include <linux/freezer.h>
 #include "ctree.h"
 #include "extent-tree.h"
 #include "transaction.h"
@@ -6361,6 +6362,11 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
 	unpin_extent_range(fs_info, start, end, false);
 }
 
+static bool btrfs_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 /*
  * It used to be that old block groups would be left around forever.
  * Iterating over them would be enough to trim unused space.  Since we
@@ -6459,8 +6465,8 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
-			ret = -ERESTARTSYS;
+		if (btrfs_trim_interrupted()) {
+			ret = 0;
 			break;
 		}
 
@@ -6508,6 +6514,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	cache = btrfs_lookup_first_block_group(fs_info, range->start);
 	for (; cache; cache = btrfs_next_block_group(cache)) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		if (cache->start >= range_end) {
 			btrfs_put_block_group(cache);
 			break;
@@ -6547,17 +6556,20 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (btrfs_trim_interrupted())
+			break;
+
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 			continue;
 
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
+
+		trimmed += group_trimmed;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
 			break;
 		}
-
-		trimmed += group_trimmed;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
-- 
2.46.0


