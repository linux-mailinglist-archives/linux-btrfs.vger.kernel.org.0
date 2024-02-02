Return-Path: <linux-btrfs+bounces-2055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C684691C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 08:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07FD1F25F25
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2FB17BBA;
	Fri,  2 Feb 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FUQDn1FH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAF17BA0
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858225; cv=none; b=n1nPKl4GMFRvw6FOUlcQbYWfnl6IKUULt/muCk6NOmjNoyOWBBfLU0jVRv610ClmmfzGHgdGPcuBgmXEte7QQCeHcinGgWpsqV+veDcinFouoooS0igstapbcYRAmr4aJo2ZANe6LtV8X+MMSKDWNOvt/xU1elD12hpbnt1Wyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858225; c=relaxed/simple;
	bh=ZrTu0XyE+6tvz9D3Xgeg8bJbOaNORdgNUlstdr/TVCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oy4MWSU6LEfAoz+YpZbO+Ee6GDvZyAlpjUbgC6dQGTzpf79oOsNrVVlnuDQ79ls32NgjKPzi9Yol81e4oqm3Zh2o3Qsx/DXW4G9ZLRAVB6H/0GZCaFVwg5sdsjXzow585V1wkdt13lW8oKt5YeYZ7GpgMC/7JHRAyPxi6w68xJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FUQDn1FH; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706858223; x=1738394223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZrTu0XyE+6tvz9D3Xgeg8bJbOaNORdgNUlstdr/TVCQ=;
  b=FUQDn1FHlhRw5eGVERw3w6B8kA4wRW8yGLyASlGiLX4Tt3n9vZGFOUha
   6/qQS6abMskiVrujMfmX/lQnNEm19UXKPhMaliISQ26101gXbAi002Fky
   ARQA95ydz93ukcRwjYGBAcyTqroLb2f9aQKDlux+W/6wS89/1Qq/h8f+X
   NsQpA9WDYoTB5BeOHUYelR9Di7ZvtdCS9F4hlNLp8jX4K0wIbym2l33wh
   hUlGfF9FeOeUy6esuYWLPjrDqhGN/jbvObt4tvPovJYtWUzKo9yzOGVU7
   eYrHVdeYpCrT2zwLXXW5VUVurF9pWJ1Et+F+dsTmQ0A7Z+Ps+ZFqdey7p
   w==;
X-CSE-ConnectionGUID: QgHV6c35TQiBwg363zklTA==
X-CSE-MsgGUID: emDnG4QbTBGvcpQ8hMg1dw==
X-IronPort-AV: E=Sophos;i="6.05,237,1701100800"; 
   d="scan'208";a="8261321"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2024 15:17:00 +0800
IronPort-SDR: Q4hn/CT+bhZvrnYpr/cpWKWXAge8u6o/3JiVkidKCS8Q1Fbia1rWvO9h7bt4Z1fjgh3RMPjtZF
 /lRiDRyTsWqg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 22:26:50 -0800
IronPort-SDR: vhOktJJ9gFGqExcnpvpxqlb6GQsh7nrhhQpiav7aBALReWz4uUEzNXZ4Hc3PT+N9krmy4GX3AT
 sDTBf2U9vG1w==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2024 23:17:00 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: use (READ_/WRITE_)ONCE for fs_devices->read_policy
Date: Fri,  2 Feb 2024 16:14:57 +0900
Message-ID: <ff28792692e72b0888fff775efad8178889b9756.1706858039.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we can read/modify the value from the sysfs interface concurrently,
it would be better to protect it from compiler optimizations.

Currently, there is only one read policy BTRFS_READ_POLICY_PID available,
so no actual problem can happen now. This is a preparation for the future
expansion.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c   |  7 ++++---
 fs/btrfs/volumes.c | 10 +++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..21586ecc35bf 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1228,11 +1228,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	const enum btrfs_read_policy policy = READ_ONCE(fs_devices->read_policy);
 	ssize_t ret = 0;
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (fs_devices->read_policy == i)
+		if (policy == i)
 			ret += sysfs_emit_at(buf, ret, "%s[%s]",
 					 (ret == 0 ? "" : " "),
 					 btrfs_read_policy_name[i]);
@@ -1256,8 +1257,8 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
 		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
-			if (i != fs_devices->read_policy) {
-				fs_devices->read_policy = i;
+			if (i != READ_ONCE(fs_devices->read_policy)) {
+				WRITE_ONCE(fs_devices->read_policy, i);
 				btrfs_info(fs_devices->fs_info,
 					   "read policy set to '%s'",
 					   btrfs_read_policy_name[i]);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 474ab7ed65ea..224345658ea5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5942,6 +5942,7 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
 {
+	const enum btrfs_read_policy policy = READ_ONCE(fs_info->fs_devices->read_policy);
 	int i;
 	int num_stripes;
 	int preferred_mirror;
@@ -5956,13 +5957,12 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	switch (fs_info->fs_devices->read_policy) {
+	switch (policy) {
 	default:
 		/* Shouldn't happen, just warn and use pid instead of failing */
-		btrfs_warn_rl(fs_info,
-			      "unknown read_policy type %u, reset to pid",
-			      fs_info->fs_devices->read_policy);
-		fs_info->fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+		btrfs_warn_rl(fs_info, "unknown read_policy type %u, reset to pid",
+			      policy);
+		WRITE_ONCE(fs_info->fs_devices->read_policy, BTRFS_READ_POLICY_PID);
 		fallthrough;
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
-- 
2.43.0


