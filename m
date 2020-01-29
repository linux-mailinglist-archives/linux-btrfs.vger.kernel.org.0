Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6120514D400
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgA2Xug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33140 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Xug (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id h23so1240924qkh.0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5QPWfPqC1i2fW0/DV4vlv3yN6PcWCR69yRBz1IPO1ok=;
        b=jAP4IlkjhSu2cD32AVa+ur7jC5ZcVnjHnx4M0g1R29tpGYUQqDDlN1/a5CpVg16fIs
         jiZb7s4Kl5TrGx4HAwi+c7xBB40fwv3o+9XjfNIMhaOPrrSTX1XFYqIsMJ90s5r4pHHo
         NJKv81B7qEOzH6VhK1E+KNGf5ngwXQQek269M2sHmdpNRYU4ZyR89/kIY20oZ4G/sSI2
         F60H+HqSTv1ar7WSVP/W9Oigu+Yx9fNtDka+/VIIwkbFPRgNiwqxZcXupDwIdVz0kcLy
         r2BdvpZM6loICGCM3loUtvK1uXFrJL6sE1vXfjIbvX0wAx+yoi7I77Zsk82IwCtSsfOd
         N7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5QPWfPqC1i2fW0/DV4vlv3yN6PcWCR69yRBz1IPO1ok=;
        b=Pq/tVSqw6RbnSKW3fGBbq0XaiRa3HVNk/xgAkSTTlxnmqCu0nCcgrcbMT2Oa4RcXee
         rI8UxRX66IAyzf9MUUAV6zX/s25vI0yayL6eunkIQQT8MnGvTJF+OIEahzGF5F1WU3KU
         ACIDmA+ZpOeeP2OMIBo0HQ18Eo/CR8IlHV0sz0A5Im4V/LhMrtU1m6VEOriLcsoD11Sm
         vh1TGitt1cimtvLoj3bLT2+hvPkcqZh/3DZzB1Fx91l/rfetmRlfdKyV9q3Knibjz+Rt
         YjxOHwz2FJ3s12h92N/hdr8ttkvpLpQ95fi0IDe4lMEmjCTTQuC+Sglk1Mheh55Bcr9/
         BP8Q==
X-Gm-Message-State: APjAAAVu0cDc8WTa4B3/IJpIrfQTJtle0mu3w8jct5rHQ3Z2EN/Jj07U
        7p8c/uOdz6hiH5SL3NSwiHe9Lt5b+WKXLA==
X-Google-Smtp-Source: APXvYqyu4C/Cy4JYK1h+2YGVNd+t8kEc0W1mZD3TImE93KMtFBrhO5svNXT1hlX3KWzfn9d2TwjUdA==
X-Received: by 2002:a37:94d:: with SMTP id 74mr2596255qkj.352.1580341834611;
        Wed, 29 Jan 2020 15:50:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g6sm1921298qtp.53.2020.01.29.15.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/20] btrfs: make shrink_delalloc take space_info as an arg
Date:   Wed, 29 Jan 2020 18:50:08 -0500
Message-Id: <20200129235024.24774-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently shrink_delalloc just looks up the metadata space info, but
this won't work if we're trying to reclaim space for data chunks.  We
get the right space_info we want passed into flush_space, so simply pass
that along to shrink_delalloc.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 924cee245e4a..17e2b5a53cb5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -349,10 +349,10 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 /*
  * shrink metadata reservation for delalloc
  */
-static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    bool wait_ordered)
+static void shrink_delalloc(struct btrfs_fs_info *fs_info,
+			    struct btrfs_space_info *space_info,
+			    u64 to_reclaim, bool wait_ordered)
 {
-	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
@@ -378,7 +378,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
@@ -580,7 +579,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes,
+		shrink_delalloc(fs_info, space_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

