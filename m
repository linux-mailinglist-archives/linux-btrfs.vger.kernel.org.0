Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F91814FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 10:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgCKJdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 05:33:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:34086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgCKJdZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 05:33:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1B6FB20E;
        Wed, 11 Mar 2020 09:33:23 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:33:23 +0100
Message-Id: <20200311093323.24955-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 fs/btrfs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 93cf76118a04..d3dc069789a5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -310,12 +310,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 		 * This "trick" only works as long as 'enum btrfs_csum_type' has
 		 * no holes in it
 		 */
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
 				(i == 0 ? "" : " "), btrfs_super_csum_name(i));
 
 	}
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
@@ -992,7 +992,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
 			continue;
 
 		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
-		len += snprintf(str + len, bufsize - len, "%s%s",
+		len += scnprintf(str + len, bufsize - len, "%s%s",
 				len ? "," : "", name);
 	}
 
-- 
2.16.4

