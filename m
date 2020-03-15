Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74572185E37
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgCOPcm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:32:42 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:56052 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728634AbgCOPcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:32:42 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id DV7vj4MthjfNYDV7wjCbpW; Sun, 15 Mar 2020 16:24:32 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584285872; bh=HH/zUL/c86XZEh6SI7bKuJSU2cVbiPHN00FsiieENcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eoy8TRhJDFWy9XmEmtRVkDR2DvzKn5qSYCWdVuMZgRgUHckAlZMiyj1Ycyf0s3UT0
         bvcnvzzqu91Oxk81JLxLiY07VMM2qQzv0oV1bQsOKPOzTrXoeQ711IAjTXub/0oI+Y
         EHH+IYv056NW1SEfGxf3Ya7bTJ4W382js0zwSeOA40pswy8s/mNiqDvmuntHQ7nrSW
         K62ReVkXtkfahS8lq7FO0SxRk5KXRXTm3RPvlMd7sF03V0ZOe2HtOrmZ+gcQAzsv/S
         SbSjjDJPw1rFfwzlXBOZRhMgHdStkKCphD/jfQmry6LiPXvvjVMrlTc/wK6WE63cDf
         Z0tje/QPOlRtA==
X-CNFS-Analysis: v=2.3 cv=BYemLYl2 c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=6WV4O0IgfxjFiaMIU6oA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/3] btrfs-progs: remove use BLKGETSIZE64
Date:   Sun, 15 Mar 2020 16:24:28 +0100
Message-Id: <20200315152430.7532-2-kreijack@libero.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315152430.7532-1-kreijack@libero.it>
References: <20200315152430.7532-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKeuC/zBMoiSUPj6vKAcEqpN98nRdSfcvkr9W7omw91sQbYuyvGGIkHAn9VgnTVZXXPuMGBIHFLvLNwQZ5IVvoCnMW7AYn57rrfajnvPlymCK7jC05wm
 KZUPI7v/C+2eiYevZ/GcZkmt3qGa15jX6zPKogjaQBP/+fx5PZh3WPYT12XIu/PlqPd6lDyrE7hFvt+ytTSWFwuWcnG5logk5LXsYTk7Zc/2SrdLRGdDqtAF
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Allow the get_partition_size() to be called without
root privileges.

Signed-off-by: Goffredo baroncelli <kreijack@inwind.it>
---
 common/device-utils.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index b03d62fa..9519dbce 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -17,6 +17,8 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/statfs.h>
+#include <sys/types.h>
+#include <sys/sysmacros.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -238,17 +240,28 @@ u64 disk_size(const char *path)
 
 u64 get_partition_size(const char *dev)
 {
-	u64 result;
-	int fd = open(dev, O_RDONLY);
+	struct stat statbuf;
+	int r;
+	int fd;
+	char buf[100];
 
-	if (fd < 0)
+	r = stat(dev, &statbuf);
+	if (r != 0)
 		return 0;
-	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
-		close(fd);
-		return 0;
-	}
+
+	snprintf(buf, sizeof(buf),
+		"/sys/dev/block/%d:%d/size", gnu_dev_major(statbuf.st_rdev),
+		 gnu_dev_minor(statbuf.st_rdev));
+
+	fd = open(buf, O_RDONLY);
+	BUG_ON(fd < 0);
+
+	r = read(fd, buf, sizeof(buf)-1);
 	close(fd);
 
-	return result;
+	BUG_ON(r < 0);
+	buf[r] = 0;
+
+	return atoll(buf) * 512;
 }
 
-- 
2.25.1

