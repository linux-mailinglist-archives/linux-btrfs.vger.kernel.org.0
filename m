Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895813F513B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhHWTYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHWTYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95697C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 22so20451594qkg.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVcw1RhiRjOL+ZrEm/KStvvoMKp1dlG80CzeuEO6/+o=;
        b=DlDfYjY8BxfJ2Pap8YcMf4AiBt7V29KQEaVzyt9iynxsJWO4AR3075hlKUv3h/z8eR
         Mq7gLrMsUd4oSuQ6dTwj4FinDLAaiTLcDVB518JpabnftqY6oG38k7rKJSNdcziSb9k5
         oLbTYTeSBqC6u5e776Qlp6dDG8S9VK22viqNar7cjwoRq2gwYTGnAL8/G0NGW1iHGwNJ
         z4DH1GSHiFKD319YAcbizOzKPbFjBZmuiFCnmW0bo92wvmxVZkqlptaXFGTtgSfw2ct9
         4UGiH8G1B5TjbvyJIEfS3bA7w9WN/RRFZc3TUlQeEMhR9Pbo2zAX9JuZxViAQPhqbzbX
         bkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVcw1RhiRjOL+ZrEm/KStvvoMKp1dlG80CzeuEO6/+o=;
        b=X5ll/ipMSCBKW01CBfnaZ/tKS0TbjE7YPRcA7gy9xBg1KmwF1EWc1AyBcyvLlbwNJB
         DwY7z1NZZ/I3i01sic16leC5oNGFEE7/OlNTUKkz905OY2WXPbiNzyhrhSYL3cexbouD
         CDMDmAzJiJHkewcTHZiNPKNj+4pHBD2RfaKNXwaidBXUmrjNtkdmzCz6nWNPQnGDTjnq
         ZD8ZcQWc+wEqHo4gWcaL4xxR6+OqxyPvQ4lTe7ul2dnAuxdYxAHh1ZRK9p0F8zROHJ+Y
         yuIgmeILkSZA+LRbjHKrtXtDpqtOyyBTk1m+G78VWA5aMqn32D9V+dVOfAuaoS39jZ5w
         RaeA==
X-Gm-Message-State: AOAM530t5PPLs4fr6UGjqQzDfWVGn+fNhFwcY24T2r8tKdvpXHy5FlG+
        TwpmsxyouS52LXbY5sj7IU6d4WJVTMHRYg==
X-Google-Smtp-Source: ABdhPJxyZmRShzcHw0TdMjF+U/eEbqKqoIxqSPezRVyrJUQi0/+bFS/YgOMCg2HLJYOc8ZCr4cOvxg==
X-Received: by 2002:a37:6c2:: with SMTP id 185mr18032257qkg.260.1629746608510;
        Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u6sm9063554qkp.49.2021.08.23.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 7/9] btrfs-progs: check: detect issues with btrfs_super_used in lowmem check
Date:   Mon, 23 Aug 2021 15:23:11 -0400
Message-Id: <48b9b7334f233d9e3d1ad650085262c892420cae.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already fix this problem with the block accounting code, we just
need to keep track of how much we should have used on the file system,
and then check it against the bytes_super.  The repair just piggy backs
on the block group used repair.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 13 ++++++++++++-
 check/mode-lowmem.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index cb8e3ab8..a1ad9606 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -28,6 +28,7 @@
 #include "check/mode-lowmem.h"
 
 static u64 last_allocated_chunk;
+static u64 total_used = 0;
 
 static int calc_extent_flag(struct btrfs_root *root, struct extent_buffer *eb,
 			    u64 *flags_ret)
@@ -3645,6 +3646,8 @@ next:
 out:
 	btrfs_release_path(&path);
 
+	total_used += used;
+
 	if (total != used) {
 		error(
 		"block group[%llu %llu] used %llu but extent items used %llu",
@@ -5547,6 +5550,14 @@ next:
 	}
 out:
 
+	if (total_used != btrfs_super_bytes_used(gfs_info->super_copy)) {
+		fprintf(stderr,
+			"super bytes used %llu mismatches actual used %llu\n",
+			btrfs_super_bytes_used(gfs_info->super_copy),
+			total_used);
+		err |= SUPER_BYTES_USED_ERROR;
+	}
+
 	if (repair) {
 		ret = end_avoid_extents_overwrite();
 		if (ret < 0)
@@ -5559,7 +5570,7 @@ out:
 		if (ret)
 			err |= ret;
 		else
-			err &= ~BG_ACCOUNTING_ERROR;
+			err &= ~(BG_ACCOUNTING_ERROR|SUPER_BYTES_USED_ERROR);
 	}
 
 	btrfs_release_path(&path);
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index da9f8600..0bcc338b 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -48,6 +48,7 @@
 #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
 #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
 #define INVALID_GENERATION	(1<<26)	/* Generation is too new */
+#define SUPER_BYTES_USED_ERROR	(1<<27)	/* Super bytes_used is invalid */
 
 /*
  * Error bit for low memory mode check.
-- 
2.26.3

