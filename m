Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC4418E1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhI0ERt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 00:17:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhI0ERs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 00:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632716171; x=1664252171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hv1JnP2LJNSkf2cXFkljyPQQ6LFpJDxTkeG2sNr+Z4=;
  b=ZsznW6szCREB5PNUnnzT5M4mwHX9EpCExqSmy04iqOa2JLTqcoj/Hi4G
   moyyfNzCWr1OhXeJAu6uv/ljYMkCNb8LaoyBCfYcVmgEYU3x6N+Tm9K8y
   9NTfJPl8QhZI5w8hduC37E1Nbh2k8LqlsvHWpSKd2YAF9iWXL5ItIOt0T
   cwhsD0ffc9JOICERs4HENBMl0ocmCTk+Lx3/4ROnaHVgyUsaLHQutEZaJ
   CT3SWp8Pb7ICuTEc2JIjGxKaT5+M5t3UPnjIZgSmFLY+sTWA2ntOJ4sJ8
   IIkMQOJHH5xaW+a78eCV/KA95KUqnl1f2s6ylZAp1M109u20cc+vC0zxN
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180095518"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 12:16:11 +0800
IronPort-SDR: a/kq3dxlyo69gO+3puga2Y77gwm3u02cwls1tqnP0j3vYFxUP6M8WPp74Dnw7IsbR24bxMhyL4
 IH3dKLD/DGzJ3emwDnOyWzRvSkhRjH8i6uyl1khIQn5eLyAGv6YBjzpzzuBsgq+8cBSNrej2d2
 Uewn0fjQwEsXkDLb1wD4aXnv3gqaSxuSiBWQfYE1522WwYeIhOQ1pSfF1c9uJck/Q6iElyeqE9
 Hfmal7u9bnrKb9X0XnCrb8ETmSnG3lijhQqanST4OKR//FfjNQ2r9wyA3cwMTIBgc3LxY0hX9k
 2IyNptbsP3Kj8KsWY3U3/AqH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:50:45 -0700
IronPort-SDR: 8bcp2gf3Qs6aDTc32Gi+IlKF8ld6OIvq2t7Ylp9QPDeC28kuIlfp6giLga24PzzNNtWbELwZko
 pDtq9nyo5FW9iAYhgv0r4N0rHthKvqrAXoHSwUicmErDrKbifKaFYaYQNu7Bp1XiiICuXAqFyu
 KL5eEqikC+W6l1UMV1yISwFt2+Z7btaXui49PNOca05VrURX0KalLBupGtqCxXjbX3aUN+Aug6
 o7AQCLRUT52e8VE1kf1pARrpO4QLgJyLEhKJ/f8BfOQVmFaVTiSF0XQLbDOXA0hxzLpXOWz253
 bCI=
WDCIronportException: Internal
Received: from 1r3v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2021 21:16:11 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 5/5] btrfs-progs: use direct-IO for zoned device
Date:   Mon, 27 Sep 2021 13:15:54 +0900
Message-Id: <20210927041554.325884-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927041554.325884-1-naohiro.aota@wdc.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to use direct-IO for zoned devices to preserve the write ordering.
Instead of detecting if the device is zoned or not, we simply use direct-IO
for any kind of device (even if emulated zoned mode on a regular device).

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/disk-io.c | 3 +++
 kernel-shared/volumes.c | 4 ++++
 mkfs/main.c             | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index dd48599a5f1f..aabeba7821ed 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1382,6 +1382,9 @@ struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
 	if (!(ocf->flags & OPEN_CTREE_WRITES))
 		oflags = O_RDONLY;
 
+	if ((oflags & O_RDWR) && zoned_model(ocf->filename) == ZONED_HOST_MANAGED)
+		oflags |= O_DIRECT;
+
 	fp = open(ocf->filename, oflags);
 	if (fp < 0) {
 		error("cannot open '%s': %m", ocf->filename);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index b2a6b04f8e3d..ff4bd0723dbb 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -455,6 +455,10 @@ int btrfs_open_devices(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 
+		if ((flags & O_RDWR) &&
+		    zoned_model(device->name) == ZONED_HOST_MANAGED)
+			flags |= O_DIRECT;
+
 		fd = open(device->name, flags);
 		if (fd < 0) {
 			ret = -errno;
diff --git a/mkfs/main.c b/mkfs/main.c
index b925c572b2b3..01187763a90c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -894,6 +894,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	int ssd = 0;
 	int zoned = 0;
 	int force_overwrite = 0;
+	int oflags;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
@@ -1310,12 +1311,16 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	dev_cnt--;
 
+	oflags = O_RDWR;
+	if (zoned && zoned_model(file) == ZONED_HOST_MANAGED)
+		oflags |= O_DIRECT;
+
 	/*
 	 * Open without O_EXCL so that the problem should not occur by the
 	 * following operation in kernel:
 	 * (btrfs_register_one_device() fails if O_EXCL is on)
 	 */
-	fd = open(file, O_RDWR);
+	fd = open(file, oflags);
 	if (fd < 0) {
 		error("unable to open %s: %m", file);
 		goto error;
-- 
2.33.0

