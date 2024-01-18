Return-Path: <linux-btrfs+bounces-1550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49F83152E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E54E1C20FE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA651400F;
	Thu, 18 Jan 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aRyWV/3g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BE125D3
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568131; cv=none; b=tkzVCqBYgitWMjHD8sQC8o+4XrNSB86X8ximk2ptrkbOGYHWHXZSS1IMifY9fZ8LDuH2p+WIHnzqDda96dQGZc/detz7AtFrWKmt2U/XNJtJYZN6yYcSQwPS6zQKAdKaZa1Fc7UBtUyx2qO7Z64RavZSB9a6eKxenjD7LnjtLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568131; c=relaxed/simple;
	bh=O3ugqyKW5IREP+vllE7DVw2XW3bYhQ0xft9i/fQ3ioE=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:IronPort-SDR:Received:IronPort-SDR:WDCIronportException:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=tEJToJmkWUT82YZ/7IDk8X+7t5n/1G58oZAMvWk1yMYWgLePz6AJVGLjWPC5QzQZZePQE73mhnwnX48DsUwcg/yybxspZRNSpoQn/kW4mFAj/kTVp9AVB/tbNNX3S+Eb/bf1cg8d/vj1z8vCsCSuhJR1tah9ig54zsW1bYT06NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aRyWV/3g; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705568129; x=1737104129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3ugqyKW5IREP+vllE7DVw2XW3bYhQ0xft9i/fQ3ioE=;
  b=aRyWV/3glWeIf93HY3nIEz4IOMBaXf0rNIbWCaJNG1PWLdoS3w40+xtD
   W3VWP7hKeIl8h08f6HQ267OvtuLCwRJNrVjHaHFLFh7e/pXCo3H06YQtQ
   TZgEI9SpskQRmbvzzqL4WsrV6P7tEw/I4mFGgYazbkN+Mi+P+eFGSitMY
   eJl8zD9PQcMN92B2nEfa37jxOPIwOrkzvAsnO+HQocmjUrALuePOTIjn9
   CME/Z1MBWNc4rwCVWcCrWBX2rCwbxnjrhEjYjzyAR7ACZnhGb26jr+s35
   mPtQIJnkAO3xF9kDEkGsO55XiVdJ6iY4mhzGpZ0/1DDqjeCfq8QARz7cx
   g==;
X-CSE-ConnectionGUID: h4NY4jTyRE2WbwVmJ0bVlw==
X-CSE-MsgGUID: 8gMv7AeHT4WeCmzs5sAkXw==
X-IronPort-AV: E=Sophos;i="6.05,201,1701100800"; 
   d="scan'208";a="7171163"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2024 16:55:20 +0800
IronPort-SDR: QFIcD+PDEEWHCXL7R5dyEV40wgdjwklvsPqRTA8KY2myfYJtb2Ii2XPwphd8gseA7nBjsnUU3t
 B5hvVv7jsHnA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2024 23:59:49 -0800
IronPort-SDR: bw30ruGvuaQxO2uTmSmzfo+M7s+yY+aLRuW5TeIgBTMCBpf2LL3S+PmextlM+kP4QKTKqa4Atg
 uV5toOGU4psQ==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2024 00:55:20 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wangyugui@e16-tech.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/2] btrfs: detect multi-dev stripe and disable automatic inline checksum
Date: Thu, 18 Jan 2024 17:54:51 +0900
Message-ID: <7ce85c808b96be3c8352ffa03fedbaacf0dc6d27.1705568050.git.naohiro.aota@wdc.com>
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

Currently, we disable offloading checksum to workqueues if the checksum
algorithm implementation is fast. However, it may not be fast enough for
multiple device striping, as reported in the links.

For example, below is a result running the following fio benchmark on 6
devices RAID0 (both data and metadata) btrfs.

fio --group_reporting --rw=write --fallocate=none \
     --direct=0 --ioengine=libaio --iodepth=32 --end_fsync=1 \
     --filesize=200G bs=$((64 * 6))k \
     --time_based --runtime=300s \
     --directory=/mnt --name=writer --numjobs=6

with this patch (offloading checksum to workques)
    WRITE: bw=2084MiB/s (2185MB/s), 2084MiB/s-2084MiB/s (2185MB/s-2185MB/s), io=750GiB (806GB), run=368752-368752msec
without this patch (inline checksum)
    WRITE: bw=1447MiB/s (1517MB/s), 1447MiB/s-1447MiB/s (1517MB/s-1517MB/s), io=517GiB (555GB), run=366017-366017msec

So, it is better to disable inline checksum when there is a block group
stripe-writing to several devices (RAID0/10/5/6). For now, I simply set the
threshold to 2, so if there are more than 2 devices, it disables the inline
checksum.

For reference, here is a result on 1 device RAID0 setup. No degradation
introduced as expected.

with this patch:
    WRITE: bw=445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s), io=302GiB (324GB), run=694199-694199msec
without this patch
    WRITE: bw=441MiB/s (462MB/s), 441MiB/s-441MiB/s (462MB/s-462MB/s), io=300GiB (322GB), run=696125-696125msec

Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/bio.c     |  8 ++++++--
 fs/btrfs/volumes.c | 20 ++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 222ee52a3af1..dfdba72ea0da 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -614,9 +614,13 @@ static bool should_async_write(struct btrfs_bio *bbio)
 	if (fs_devices->inline_csum_mode == BTRFS_INLINE_CSUM_FORCE_ON)
 		return false;
 
-	/* Submit synchronously if the checksum implementation is fast. */
+	/*
+	 * Submit synchronously if the checksum implementation is
+	 * fast, and it is not backed by multiple devices striping.
+	 */
 	if (fs_devices->inline_csum_mode == BTRFS_INLINE_CSUM_AUTO &&
-	    test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	    test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags) &&
+	    !fs_devices->striped_writing)
 		return false;
 
 	/*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d67785be2c77..79c1af049e9e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -41,6 +41,12 @@
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
 
+/*
+ * Maximum number of devices automatically enabling inline checksum for
+ * a striped write.
+ */
+#define BTRFS_INLINE_CSUM_MAX_DEVS 2
+
 struct btrfs_io_geometry {
 	u32 stripe_index;
 	u32 stripe_nr;
@@ -5124,6 +5130,19 @@ static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID1C34);
 }
 
+static void check_striped_block_group(struct btrfs_fs_info *info, u64 type, int num_stripes)
+{
+	if (btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)].devs_max != 0 ||
+	    num_stripes <= BTRFS_INLINE_CSUM_MAX_DEVS)
+		return;
+
+	/*
+	 * Found a block group writing to multiple devices, disable
+	 * inline automatic checksum.
+	 */
+	info->fs_devices->striped_writing = true;
+}
+
 /*
  * Structure used internally for btrfs_create_chunk() function.
  * Wraps needed parameters.
@@ -5592,6 +5611,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
+	check_striped_block_group(info, type, map->num_stripes);
 
 	return block_group;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f21cfe268be9..c32501985c64 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -384,6 +384,8 @@ struct btrfs_fs_devices {
 	bool seeding;
 	/* The mount needs to use a randomly generated fsid. */
 	bool temp_fsid;
+	/* Has a block group writing stripes to multiple devices. (RAID0/10/5/6). */
+	bool striped_writing;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-- 
2.43.0


