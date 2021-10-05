Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF0421ED4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhJEGZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61157 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhJEGZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415014; x=1664951014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=coGRL6ere+uLYVXkW4YuQGcH68/yaIyRKc16YOLoH4I=;
  b=FOt2L/9W9/Yv8BtoihJ8j8hOQaOriipi6gYQM2iJ/78fFmloC/U3TdLa
   ZtRtYhmGaqsmOQCMDORFSgw7or2fHJixwp/xDoED2nI+YHMLqg/zTa+IN
   escsRe2h9Kl5mjt2LTAEpQhIJRugHZScID8OcTKcGi7/CRJp0EwPArLka
   lT3EU71+upfVCPRFgGbx0OvfJv2A3E4cYZTdjIyT96h3jihXnnpG2/q+1
   TXmGkzs4BMr++NX8IgrqjK+cYjCd/7UFHJGHWA9W9ItCoJzLA/HRy14bU
   Cnak63jT4iQi5PRiwq4R+th9IQXZWM4XC2kFLlqWwsQtwqNNLzebjQvFe
   g==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648918"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:34 +0800
IronPort-SDR: HYX8jOO2nrj9FyUi5js1yQ1NfltzMyxGc87YYJdAi/9tETLL7OUn0NqMUikBQq/LDDGTIO3wNg
 TUM0+0bbpjk15u6gqhBU1AmJVabhr2JcgksUPFtvfPH9lvTatnvJmvbkeef1tfbqTGHVPZuznx
 uv4XzfmHw2iSehganyhGIP6Vk+Oa32xT8aifweLu/iSwKj60FmwDykNguO4IrbVX8O18XkBtEy
 waCSLU/t3jIR0yar0gDWfNXPUfOm4uCxftDN4axsLnBSDo0krIp64DzYf+Kxq2nsbWNpVHqODx
 1XC6OS8RJBUCqo3wVRGIrWNX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:58 -0700
IronPort-SDR: enm0BsSvdhB5+n1Myyh1Bg0O7+yAfBUz2OSR6t1Mt6eVwjFTcdgydY2IfpMrCE7Hc06PXbsLED
 3RAT4jBmRHEVLI8qmWNzUI5Stw2VHk46gj/yTQX98Ok7Xz0RWyaamxRVUhqZTEprehiSZjkOXH
 TO1/WnpK0/KlHk4OOXZ5RXNtO80DbZGjw7x/3qdcK16TnYUfUckXMYN1Kr+m3ijnfBw7mHb/Be
 liWjKeO5YcyqV+jQEU4iFHVcvCQ2zoQKWXR8EClEPkyiWGuvlJYh/Wb3w6GrscDkHpFc2fHTxK
 ydg=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:34 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 7/7] btrfs-progs: use direct-io for zoned device
Date:   Tue,  5 Oct 2021 15:23:05 +0900
Message-Id: <20211005062305.549871-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to use direct-IO for zoned devices to preserve the write
ordering.  Instead of detecting if the device is zoned or not, we simply
use direct-IO for any kind of device (even if emulated zoned mode on a
regular device).

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
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
index 2ef2a8618d1f..bfa60812ef97 100644
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
index 314d608a5cc5..11a0989be281 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -893,6 +893,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool ssd = false;
 	bool zoned = false;
 	bool force_overwrite = false;
+	int oflags;
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
@@ -1305,12 +1306,16 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
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

