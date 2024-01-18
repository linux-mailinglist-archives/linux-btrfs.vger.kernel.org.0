Return-Path: <linux-btrfs+bounces-1549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D258583152D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 09:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611981F239AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB9134C3;
	Thu, 18 Jan 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ku06Sjqe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8C125AD
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568130; cv=none; b=CK7FBIFaAgn8DbkWFYbrwb37uRP4G1wrH2jZlqVWX5tyQ+vaZCeDYGVGd+QBXhe5wz9m8tv52WhUFe6pe2/eIyZdXsABhnaV+Hy8VKAiVtCb6f0v8AoQvS361GxK3Qm9eYqDzxOT7znyf1PJFYtWoiY4RIkdE1CJr9EJrm+tbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568130; c=relaxed/simple;
	bh=Wq0dvxbZ3Nsi+94NPe30NBsbHpT2VpE2gjcVFVSpTyU=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:IronPort-SDR:Received:IronPort-SDR:WDCIronportException:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=WyQO93/N6Bbbq8L0DJR3C7unw1nymT25A2w+IlhXg1S9FrBijP+0Vy0V+j3DtnliOWhJxOc1eIfnfRVdrmb2FoyUWsqXirULG1K10hqGsYE8PPBw8RDANDvLvlLyJk4VGQyt1jg5MRwUZ9I2bjeZ9sDjOBW3qDA5bd5Cyua4Jgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ku06Sjqe; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705568128; x=1737104128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wq0dvxbZ3Nsi+94NPe30NBsbHpT2VpE2gjcVFVSpTyU=;
  b=Ku06Sjqen9etyZpt3gzHfVrX6foDwRbiZGNz6iNJXQ1z5hELjSZmQdnQ
   XZPAhof3GDdIxQeRl/3QKDuP9lgu9yZZ2zVgqnEZ+zvl3OQgsbT39RCkl
   IWPVeG55KAZQ2DukdD1Negn24aWTSRYHbROPT07ROARQHIDh3JL/6wPMs
   YIaSmZm3y0G0Tqawahjw1LBDG7TryLhk9jKQVBs/x2J8uflyLA6yNRSG8
   7+X07NGa4PonNa8GIw6Fv3UMOkFh/ZDXibcFi6J5xwHx5ZhmVJ70eXYZs
   cUnwHhVbigYSdYu9N58qIrdKtRknWMl4dPJXfXZEQVO1pqNh+KsBYAqJi
   g==;
X-CSE-ConnectionGUID: PjEAoWd4RTOic+9uXffvCQ==
X-CSE-MsgGUID: 0NGxVEaGQFGf8kULNTIGWQ==
X-IronPort-AV: E=Sophos;i="6.05,201,1701100800"; 
   d="scan'208";a="7171157"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2024 16:55:19 +0800
IronPort-SDR: SWqjHhrFZZKcJ8RB5jmgmoE02d4In8jQcU0bjOjsJv3oXEtGb4ZPEUbaziXShoobJPyLTuKDQR
 qyI1fRyyG+/w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2024 23:59:48 -0800
IronPort-SDR: E9IlumiqdGWS/wCaj0sgqBF7mB3yce4DANGONTJCpFK8/55C8Lp5fOjKMF/xtczWNAMJOR6J6O
 4Ilvcl2ZAkcg==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2024 00:55:19 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wangyugui@e16-tech.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: introduce inline_csum_mode to tweak inline checksum behavior
Date: Thu, 18 Jan 2024 17:54:50 +0900
Message-ID: <348a7b7de939c965cd705a671b287aa6bd18db77.1705568050.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705568050.git.naohiro.aota@wdc.com>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We disable offloading checksum to workqueues and do it inline when the
checksum algorithm is fast. However, as reported in the link below, RAID0
with multiple devices may suffer from the inline checksum, because "fast
checksum" is still not fast enough to catch up RAID0 writing.

To measure the effectiveness of inline checksum, it would be better to have
a switch for inline checksum.

This commit introduces fs_devices->inline_csum_mode, so that a FS user can
change the behavior by writing to /sys/fs/btrfs/<uuid>/inline_csum. The
default is "auto" which is the same as the previous behavior. Or, you can
set "on" or "off" to always/never use inline checksum.

Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/bio.c     |  8 +++++++-
 fs/btrfs/sysfs.c   | 39 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h | 19 +++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2d20215548db..222ee52a3af1 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -609,8 +609,14 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 
 static bool should_async_write(struct btrfs_bio *bbio)
 {
+	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
+
+	if (fs_devices->inline_csum_mode == BTRFS_INLINE_CSUM_FORCE_ON)
+		return false;
+
 	/* Submit synchronously if the checksum implementation is fast. */
-	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	if (fs_devices->inline_csum_mode == BTRFS_INLINE_CSUM_AUTO &&
+	    test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
 		return false;
 
 	/*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..f7491bc2950e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,6 +1306,44 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
+static ssize_t btrfs_inline_csum_show(struct kobject *kobj,
+				      struct kobj_attribute *a,
+				      char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	switch (fs_devices->inline_csum_mode) {
+	case BTRFS_INLINE_CSUM_AUTO:
+		return sysfs_emit(buf, "auto\n");
+	case BTRFS_INLINE_CSUM_FORCE_ON:
+		return sysfs_emit(buf, "on\n");
+	case BTRFS_INLINE_CSUM_FORCE_OFF:
+		return sysfs_emit(buf, "off\n");
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+}
+
+static ssize_t btrfs_inline_csum_store(struct kobject *kobj,
+				       struct kobj_attribute *a,
+				       const char *buf, size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	if (sysfs_streq(buf, "auto"))
+		fs_devices->inline_csum_mode = BTRFS_INLINE_CSUM_AUTO;
+	else if (sysfs_streq(buf, "on"))
+		fs_devices->inline_csum_mode = BTRFS_INLINE_CSUM_FORCE_ON;
+	else if (sysfs_streq(buf, "off"))
+		fs_devices->inline_csum_mode = BTRFS_INLINE_CSUM_FORCE_OFF;
+	else
+		return -EINVAL;
+
+	return len;
+}
+BTRFS_ATTR_RW(, inline_csum, btrfs_inline_csum_show, btrfs_inline_csum_store);
+
 /*
  * Per-filesystem information and stats.
  *
@@ -1325,6 +1363,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
+	BTRFS_ATTR_PTR(, inline_csum),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 53f87f398da7..f21cfe268be9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -276,6 +276,22 @@ enum btrfs_read_policy {
 	BTRFS_NR_READ_POLICY,
 };
 
+/*
+ * Checksum mode - do it in btrfs_submit_chunk() or offload it.
+ */
+enum btrfs_inline_csum_mode {
+	/*
+	 * Choose inline checksum or offloading automatically. Do it
+	 * inline if the checksum is fast, or offload to workqueues
+	 * otherwise.
+	 */
+	BTRFS_INLINE_CSUM_AUTO,
+	/* Never offload checksum to workqueues. */
+	BTRFS_INLINE_CSUM_FORCE_ON,
+	/* Always offload checksum to workqueues. */
+	BTRFS_INLINE_CSUM_FORCE_OFF,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 
@@ -380,6 +396,9 @@ struct btrfs_fs_devices {
 
 	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
+
+	/* Checksum mode - do it inline or offload it. */
+	enum btrfs_inline_csum_mode inline_csum_mode;
 };
 
 #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
-- 
2.43.0


