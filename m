Return-Path: <linux-btrfs+bounces-1951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23F843779
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3AFB26745
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAE67E90;
	Wed, 31 Jan 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qOE82/Om"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250167E60
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685249; cv=none; b=u6UnipJM3d+OfISufH/7H2SZEGpPwKOUDgaGHYZLgqazKRC+mkpD6Q+KbVsZ41YgQzVKpfmn95Y2H5aqE/tmPpj+byguKxa/rdZlwy2SK/pTC6AJ4RYs73vB4URg8DB5W5rh/2aYPv7bZ5N/SRVhDBgnDRjSd/ZIvTKzfdWQNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685249; c=relaxed/simple;
	bh=k7z6iPKoNTgzprzxJJYvYjZu0AkITtleWqgfLLiRFeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEU/fk9zcTXLF2OlrwmN8kDZf/yhX2TIyraGr69Tbrt/FebjlGI7RwupfvNyyF3kSVUA1Aimt0ZghicuiAHNL9v+gKOtyKgnq/6QthNRj5KDy/FCY2LcI9sLdml5F2MqTBh+dN5xHYbIpbz2GR49gWlPi660ijxfDW1tSfBncsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qOE82/Om; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706685247; x=1738221247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k7z6iPKoNTgzprzxJJYvYjZu0AkITtleWqgfLLiRFeo=;
  b=qOE82/OmCNFSZDYEqq6fRNzfAENkEqjMaRl7iNhA7qeFibzdZC76/28x
   Wwhrg7z/OYj2Toat1ATSCq0FfY/0pzH6Rb2kgRXka1Y1xxjAqC8GJ11px
   9MX3nkUole3vADOWbtsTYS9wARMRSYSyDa+k0mwTV+Obpy0IVW4JXw/3X
   Eidv5zWiyrjdsVm5mSB9X62fary5BzLwMwM0QAWib6e7HG/9E1sbnM6HN
   wwiqXFO25afqaAwWPLJGoQVYHpXM6vOxuKavpDIH6/L4AflaklRdEkPFX
   PWiluN/78k8RM6cJgWktBnjFrltDY+xtkNYG/SEJwLcWV7YwKMgIHmst/
   w==;
X-CSE-ConnectionGUID: 9j67+pzUTZyRK9sH61gYXA==
X-CSE-MsgGUID: 8cmGkbbHSxqaeeL4vhluMw==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="7841891"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 15:14:01 +0800
IronPort-SDR: HdsPPpIoKz5bCgWYM8zAJLmYyQD4AltOlnMFW40ILeTaIFxN67YZaccd+9AitSgx+ZNs3uc5Yh
 FVMS1HLwHzGA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 22:23:53 -0800
IronPort-SDR: YA79nETXkWnxe0a4ljJEaKSlRky7W6ZeRdsDbNBOuhtdaULt7/TTj/0ke1hS1UYrjbyj+pcnAX
 rdqlKt8gvmmQ==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.126])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Jan 2024 23:14:00 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wangyugui@e16-tech.com,
	clm@meta.com,
	hch@lst.de,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync checksum behavior
Date: Wed, 31 Jan 2024 16:13:45 +0900
Message-ID: <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
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

To measure the effectiveness of sync checksum for developers, it would be
better to have a switch for the sync checksum under CONFIG_BTRFS_DEBUG
hood.

This commit introduces fs_devices->sync_csum_mode for CONFIG_BTRFS_DEBUG,
so that a btrfs developer can change the behavior by writing to
/sys/fs/btrfs/<uuid>/sync_csum. The default is "auto" which is the same as
the previous behavior. Or, you can set "on" or "off" to always/never use
sync checksum.

More benchmark should be collected with this knob to implement a proper
criteria to enable/disable sync checksum.

Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
v2:
- Call it "sync checksum" properly
- Removed a patch to automatically change checksum behavior
- Hide the sysfs interface under CONFIG_BTRFS_DEBUG
---
 fs/btrfs/bio.c     | 13 ++++++++++++-
 fs/btrfs/sysfs.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h | 23 +++++++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 960b81718e29..c896d3cd792b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -608,8 +608,19 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 static bool should_async_write(struct btrfs_bio *bbio)
 {
+	bool auto_csum_mode = true;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
+
+	if (fs_devices->sync_csum_mode == BTRFS_SYNC_CSUM_FORCE_ON)
+		return false;
+
+	auto_csum_mode = fs_devices->sync_csum_mode == BTRFS_SYNC_CSUM_AUTO;
+#endif
+
 	/* Submit synchronously if the checksum implementation is fast. */
-	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	if (auto_csum_mode && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
 		return false;
 
 	/*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..ea1e54149ef4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,6 +1306,46 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
+#ifdef CONFIG_BTRFS_DEBUG
+static ssize_t btrfs_sync_csum_show(struct kobject *kobj,
+				    struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	switch (fs_devices->sync_csum_mode) {
+	case BTRFS_SYNC_CSUM_AUTO:
+		return sysfs_emit(buf, "auto\n");
+	case BTRFS_SYNC_CSUM_FORCE_ON:
+		return sysfs_emit(buf, "on\n");
+	case BTRFS_SYNC_CSUM_FORCE_OFF:
+		return sysfs_emit(buf, "off\n");
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
+static ssize_t btrfs_sync_csum_store(struct kobject *kobj,
+				     struct kobj_attribute *a, const char *buf,
+				     size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	if (sysfs_streq(buf, "auto"))
+		fs_devices->sync_csum_mode = BTRFS_SYNC_CSUM_AUTO;
+	else if (sysfs_streq(buf, "on"))
+		fs_devices->sync_csum_mode = BTRFS_SYNC_CSUM_FORCE_ON;
+	else if (sysfs_streq(buf, "off"))
+		fs_devices->sync_csum_mode = BTRFS_SYNC_CSUM_FORCE_OFF;
+	else
+		return -EINVAL;
+
+	return len;
+	return -EINVAL;
+}
+BTRFS_ATTR_RW(, sync_csum, btrfs_sync_csum_show, btrfs_sync_csum_store);
+#endif
+
 /*
  * Per-filesystem information and stats.
  *
@@ -1325,6 +1365,9 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
+#ifdef CONFIG_BTRFS_DEBUG
+	BTRFS_ATTR_PTR(, sync_csum),
+#endif
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da7..9b821677aeb3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -276,6 +276,24 @@ enum btrfs_read_policy {
 	BTRFS_NR_READ_POLICY,
 };
 
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Checksum mode - do it synchronously in btrfs_submit_chunk() or offload it.
+ */
+enum btrfs_sync_csum_mode {
+	/*
+	 * Choose sync checksum or offloading automatically. Do it
+	 * synchronously if the checksum is fast, or offload to workqueues
+	 * otherwise.
+	 */
+	BTRFS_SYNC_CSUM_AUTO,
+	/* Never offload checksum to workqueues. */
+	BTRFS_SYNC_CSUM_FORCE_ON,
+	/* Always offload checksum to workqueues. */
+	BTRFS_SYNC_CSUM_FORCE_OFF,
+};
+#endif
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 
@@ -380,6 +398,11 @@ struct btrfs_fs_devices {
 
 	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/* Checksum mode - do it synchronously or offload it. */
+	enum btrfs_sync_csum_mode sync_csum_mode;
+#endif
 };
 
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
-- 
2.43.0


