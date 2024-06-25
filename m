Return-Path: <linux-btrfs+bounces-5958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC8916B5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C371C23750
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDE16EC07;
	Tue, 25 Jun 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lB4A+yb9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB916E89E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327587; cv=none; b=fKBnuZkKOLuzCrgWLFQ6PsK2/HSgGIzmfpavRvW0ZQSbuyWaDvkYLBw8uVDo13qoLk+vwXw3p4l74NaTak0rWsuSP+86zDRf6jWRKrRp9D5xQsmWj8YKs5UiarPDw2OT1095FB4iXnmPRYmjQLJM7U/kYRhohGO7hzwhCyoUhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327587; c=relaxed/simple;
	bh=v3bQ3Cxsxe/6+vf/GJ0zAWLC400y/unCNaM/qJo0fHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uU7+cWI7zyFbNy7McRHuH2mP4VItFsjRV17c9VWcGsAfo3xYW48ADQVMxL/rIO5wFN18RE4cpyBXg0a5w+mVoce+cqyPsTTFzNCBtZvXtD+On2WBqnZUEOSuQpLtVb1MtGYWHQ2J2SJNvbt85mNTIgfZIRDVAbULoUnlQfP5uOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lB4A+yb9; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719327584; x=1750863584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v3bQ3Cxsxe/6+vf/GJ0zAWLC400y/unCNaM/qJo0fHQ=;
  b=lB4A+yb9jGNL8JZtnS1SU4AX58L5yD7wDwxMaem8cjTH8XO8uBp/xHoA
   ORpwcHVpLf4mpYQsIkYnUT24ce/qnM/QvSasxje136mOipUs6fK6/5RVj
   fMZqwddr/kWueCQsHXVVh9axtdWJX8wzItgtZHzBf/aJujGy1e0Ra1ihg
   +XtXf+ssq3ou5UaqeZ4Rn/dO/1gEaDQwU9y194vNQwI3F2Ks/1c6DEJ2E
   Kp/cgiShruMnuwiPKDvRuHKTJAcA1RZgds5Vm7skNwdkAHcVrJV4oRftW
   Ktg3R2/XC2257OCEJgQqa2T6TjNBnywV/79F5b5vH+NAh88hrNXh/roKV
   Q==;
X-CSE-ConnectionGUID: VkAJ3Y7EQy6vgKBObAbJAA==
X-CSE-MsgGUID: yNry8Zm3Seum/5umbe425A==
X-IronPort-AV: E=Sophos;i="6.08,264,1712592000"; 
   d="scan'208";a="19971388"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 22:59:38 +0800
IronPort-SDR: 667acd94_wW4gAQHz9VqnEajE9Rma0ALtGEQ1auauHI6R9rrc1pI/yFi
 0SvPPvMh8MfMp3OPXfBVF3ULz8+TEE+3Owbineg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 07:00:52 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.83])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2024 07:59:38 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: boris@bur.io,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix calc_available_free_space for zoned mode
Date: Tue, 25 Jun 2024 23:58:49 +0900
Message-ID: <0803c4de21aac935169b8289de1cb71c695452be.1719326990.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calc_available_free_space() returns the total size of metadata (or system)
block groups, which can be allocated from unallocated disk space. The logic
is wrong on zoned mode in two places.

First, the calculation of data_chunk_size is wrong. We always allocate one
zone as one chunk, and no partial allocation of a zone. So, we should use
zone_size (= data_sinfo->chunk_size) as it is.

Second, the result "avail" may not be zone aligned. Since we always
allocate one zone as one chunk on zoned mode, returning non-zone size
alingned bytes will result in less pressure on the async metadata reclaim
process.

This is serious for the nearly full state with a large zone size
device. Allowing over-commit too much will result in less async reclaim
work and end up in ENOSPC. We can align down to the zone size to avoid
that.

Fixes: cb6cbab79055 ("btrfs: adjust overcommit logic when very close to full")
CC: stable@vger.kernel.org # 6.9
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
As I mentioned in [1], I based this patch on for-next but before
Boris's "dynamic block_group reclaim threshold" series, because it would
be easier to backport this patch. I'll resend this patch basing on
for-next, if you'd prefer that.

[1] https://lore.kernel.org/linux-btrfs/avjakfevy3gtwcgxugnzwsfkld35tfgktd5ywpz3kac6gfraxh@uic6zl3jmgbl/
---
 fs/btrfs/space-info.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0283ee9bf813..85ff44a74223 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -373,11 +373,18 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 	 * "optimal" chunk size based on the fs size.  However when we actually
 	 * allocate the chunk we will strip this down further, making it no more
 	 * than 10% of the disk or 1G, whichever is smaller.
+	 *
+	 * On the zoned mode, we need to use zone_size (=
+	 * data_sinfo->chunk_size) as it is.
 	 */
 	data_sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA);
-	data_chunk_size = min(data_sinfo->chunk_size,
-			      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
-	data_chunk_size = min_t(u64, data_chunk_size, SZ_1G);
+	if (!btrfs_is_zoned(fs_info)) {
+		data_chunk_size = min(data_sinfo->chunk_size,
+				      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
+		data_chunk_size = min_t(u64, data_chunk_size, SZ_1G);
+	} else {
+		data_chunk_size = data_sinfo->chunk_size;
+	}
 
 	/*
 	 * Since data allocations immediately use block groups as part of the
@@ -405,6 +412,17 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 		avail >>= 3;
 	else
 		avail >>= 1;
+
+	/*
+	 * On the zoned mode, we always allocate one zone as one chunk.
+	 * Returning non-zone size alingned bytes here will result in
+	 * less pressure for the async metadata reclaim process, and it
+	 * will over-commit too much leading to ENOSPC. Align down to the
+	 * zone size to avoid that.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		avail = ALIGN_DOWN(avail, fs_info->zone_size);
+
 	return avail;
 }
 
-- 
2.45.2


