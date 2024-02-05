Return-Path: <linux-btrfs+bounces-2111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2C849B5F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 14:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF492B28BE4
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA522F00;
	Mon,  5 Feb 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P5B4dllD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F720DF7
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138161; cv=none; b=mPN1rWUvxhMmAhl7p6mPd+P9vhEMRVgoAqIzGXlEeXgweMRvDtm7zL8fT+HJc7DJu9iK+m+4QHRf6C9s2D4iQWJBR13qgmWBrbufahJb99kWrLrpxbHntsifms6tszUA64VgjDMXFocbM7Zc8QxOQCsrY3bSnWPL+1KGNbMhz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138161; c=relaxed/simple;
	bh=bfv642IZio9GeCPuPtbIudF4DiTsT5f444MN0Mn3hSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf282E0Y5IvM2SyjEEgayAo+kk90iZL5LvHaAVQi0MZU3wc+X5O1asP0oUYhrESbw+AMKHcVoqB/w2dcWhNNrTRnGwfeJsETWM3Pgx9Dzyuip213ASU65ITMNgqt4mPyihgDOGVYdCkDrL0Tf+dxS/zi96dH3zp1ltnviFl/OdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=P5B4dllD; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707138159; x=1738674159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bfv642IZio9GeCPuPtbIudF4DiTsT5f444MN0Mn3hSA=;
  b=P5B4dllD5WSiDVgAXYTKNAF2bx55Mur7cx/RFHgp3WuUfQRt3DtkdHw1
   pTWIpXF+cRQuTBzVFn0Jukm7QJgMPJV4GHJncq70wwEKDteH4JCTe+J0O
   KmHXM6X1wuzNGAuhmlKGmxL7+Db/tCYvsJj+N85PPysgjWTXR5FTatNpz
   hMZ3IqWjnG1hzY+DskHaL1cIwuuddoFjyR5TPziZAAtkc1xNUvDq8H4x1
   4o4KUwRakIqC+vsmpMXaTf0bXmPKnzoWuybQ9J9GF5X5Ozqx1vMWUQTJ3
   HXbK2IIjs/+vF2LoGj4pV21xqm3WLnNVEzKop1H3pko/FriZoK+tFlPsj
   A==;
X-CSE-ConnectionGUID: +lDwB/x8TsKRDl0O6heA/g==
X-CSE-MsgGUID: QsPzSXSzTaCV5FMJ9t1iHA==
X-IronPort-AV: E=Sophos;i="6.05,245,1701100800"; 
   d="scan'208";a="8768045"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2024 21:01:31 +0800
IronPort-SDR: 6wZT88D8dB6G2cgLBdVQmogHrisqahXOqlkthli/keYA/dR6tmFzCYbTPIikpqmFlliRDDqENU
 7jNo9ExFE+ZA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 04:11:18 -0800
IronPort-SDR: qaWZsHM6Ke0v8GgA0aY0mGEHtuTrqSq9avJKhQsyWnfpHkEYUoV6qa7ajPGLYw+c0axtAawJei
 c4EqrTYnt2hw==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.23])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Feb 2024 05:01:31 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wangyugui@e16-tech.com,
	clm@meta.com,
	hch@lst.de,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3] btrfs: introduce offload_csum_mode to tweak checksum offloading behavior
Date: Mon,  5 Feb 2024 22:01:16 +0900
Message-ID: <8dc4a312da70bb93f042f32a75efb7ec848cc08b.1707122589.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We disable offloading checksum to workqueues and do it synchronously when
the checksum algorithm is fast. However, as reported in the link below,
RAID0 with multiple devices may suffer from the sync checksum, because
"fast checksum" is still not fast enough to catch up RAID0 writing.

To measure the effectiveness of sync checksum and checksum offloading for
developers, it would be better to have a switch for the checksum offloading
under CONFIG_BTRFS_DEBUG hood.

This commit introduces fs_devices->offload_csum_mode for
CONFIG_BTRFS_DEBUG, so that a btrfs developer can change the behavior by
writing to /sys/fs/btrfs/<uuid>/offload_csum. The default is "auto" which
is the same as the previous behavior. Or, you can set "on" or "off" (or "y"
or "n" whatever kstrtobool() accepts) to always/never offload checksum.

More benchmark should be collected with this knob to implement a proper
criteria to enable/disable checksum offloading.

Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/bio.c     | 14 +++++++++++++-
 fs/btrfs/sysfs.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h | 24 ++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 960b81718e29..477f350a8bd0 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -608,8 +608,20 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 static bool should_async_write(struct btrfs_bio *bbio)
 {
+	bool auto_csum_mode = true;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
+	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
+
+	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_OFF)
+		return false;
+
+	auto_csum_mode = (csum_mode == BTRFS_OFFLOAD_CSUM_AUTO);
+#endif
+
 	/* Submit synchronously if the checksum implementation is fast. */
-	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	if (auto_csum_mode && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
 		return false;
 
 	/*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..d2d485f103bd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,6 +1306,47 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
+#ifdef CONFIG_BTRFS_DEBUG
+static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
+				       struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	switch (READ_ONCE(fs_devices->offload_csum_mode)) {
+	case BTRFS_OFFLOAD_CSUM_AUTO:
+		return sysfs_emit(buf, "auto\n");
+	case BTRFS_OFFLOAD_CSUM_FORCE_ON:
+		return sysfs_emit(buf, "1\n");
+	case BTRFS_OFFLOAD_CSUM_FORCE_OFF:
+		return sysfs_emit(buf, "0\n");
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
+static ssize_t btrfs_offload_csum_store(struct kobject *kobj,
+					struct kobj_attribute *a, const char *buf,
+					size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	int ret;
+	bool val;
+
+	ret = kstrtobool(buf, &val);
+	if (ret == 0)
+		WRITE_ONCE(fs_devices->offload_csum_mode,
+			   val ? BTRFS_OFFLOAD_CSUM_FORCE_ON : BTRFS_OFFLOAD_CSUM_FORCE_OFF);
+	else if (ret == -EINVAL && sysfs_streq(buf, "auto"))
+		WRITE_ONCE(fs_devices->offload_csum_mode, BTRFS_OFFLOAD_CSUM_AUTO);
+	else
+		return -EINVAL;
+
+	return len;
+}
+BTRFS_ATTR_RW(, offload_csum, btrfs_offload_csum_show, btrfs_offload_csum_store);
+#endif
+
 /*
  * Per-filesystem information and stats.
  *
@@ -1325,6 +1366,9 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
+#ifdef CONFIG_BTRFS_DEBUG
+	BTRFS_ATTR_PTR(, offload_csum),
+#endif
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da7..1f6f73ce48f9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -276,6 +276,25 @@ enum btrfs_read_policy {
 	BTRFS_NR_READ_POLICY,
 };
 
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Checksum mode - offload it to workqueues or do it synchronously in
+ * btrfs_submit_chunk().
+ */
+enum btrfs_offload_csum_mode {
+	/*
+	 * Choose offloading checksum or do it synchronously automatically.
+	 * Do it synchronously if the checksum is fast, or offload to workqueues
+	 * otherwise.
+	 */
+	BTRFS_OFFLOAD_CSUM_AUTO,
+	/* Always offload checksum to workqueues. */
+	BTRFS_OFFLOAD_CSUM_FORCE_ON,
+	/* Never offload checksum to workqueues. */
+	BTRFS_OFFLOAD_CSUM_FORCE_OFF,
+};
+#endif
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 
@@ -380,6 +399,11 @@ struct btrfs_fs_devices {
 
 	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/* Checksum mode - offload it or do it synchronously. */
+	enum btrfs_offload_csum_mode offload_csum_mode;
+#endif
 };
 
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
-- 
2.43.0


