Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6461850F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCMVXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45457 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMVXg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so15138252qke.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDMGhZnl37BOJRojF7Zy9aa81J1R9HIRdkxL7MvIeKA=;
        b=aFMn+xvKx/tVkRnnh2XF4wcpeagxa+q6adiVFuuAp816/z3IyNIwQdf3O2U45XJdKD
         pLd5L6oIHcqdd+DYqJP+aMRgzlGMSi0bMLPYRiDpllnFf0P591aHlswltD0yZ+40aA06
         BcSx3MeuMDQf85e5SLaIZNdYq/u5aVeM+jNKc9sA9mCvwMGfqnR9Itu3ZZGrH8zQqkRS
         L40zJx8JiLcr8w84YiFdJm70RQGjbtgkWoICpNIFZ1FOyeiCuUlE9UNdxZuEEhHpH94c
         9WZ/6e960HO50w4NjYS86dRXEErLbnSmBQDTVXpB/qtKHoGe/rklzRIu5va7F2UpEjGG
         Q88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QDMGhZnl37BOJRojF7Zy9aa81J1R9HIRdkxL7MvIeKA=;
        b=sYfgy9kVyQf+ZEn2cl8tFK7dKHauti7u5z6/AsXg/+Mm+V88FxDLbH//SGz9dALjuY
         xcYH+lsuJg/f4GYiUKqW0vLw74Gtn6RySaaRR+E9GEvmnul1Xs9XqwLF0pz7SMw1MkbK
         bS7wRavfFJPzh8NZH8s+CFyT/gW3XDRu+2nUCUkRIjPuj9Iro5eawAkZIbtZJ3Cdhx/f
         kzyzU1Zv/qg3MsuyEXWk7BJ51+yEsHogWnMIvbSw6+xyYhTLFz+oPPJ7OtVv6PeOKyO+
         8XKRkhj2vuElAIyNUz5uuCdxJA2rwiFwFW41GMAvDGdO7qtWhBKXllSQMpjGhtCT34uF
         doHA==
X-Gm-Message-State: ANhLgQ38Q/DxERN8DV/V4mLGazFtXY9wIIT1nPkl+t5cnNgOE1IB4CNF
        2LhVCBbJUwh/Zm+Fl+7jng2HqWJIRNO/OQ==
X-Google-Smtp-Source: ADFU+vsFHIbi8JoRCbh1YJw2WjeOvxhDhm4gwqAjc8OG5AItZN/Wo2gYkLFAZw42ygc+rGxwNqEG0A==
X-Received: by 2002:a37:a78e:: with SMTP id q136mr15157716qke.252.1584134614520;
        Fri, 13 Mar 2020 14:23:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u26sm5523745qku.97.2020.03.13.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH 01/13] btrfs: use a stable rolling avg for delayed refs avg
Date:   Fri, 13 Mar 2020 17:23:18 -0400
Message-Id: <20200313212330.149024-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>

The way we currently calculate the average of delayed refs is very
jittery.  We do a weighted average, weighing the new average at 3/4 of
the previously calculated average.

This jitteriness leads to pretty wild swings in latencies when we are
generating a lot of delayed refs.  Fix this by smoothing out the delayed
ref average calculation with 1000 seconds of data, 1000 refs minimum,
with a 0.75 decay rate.

Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  7 +++++++
 fs/btrfs/disk-io.c     |  3 +++
 fs/btrfs/extent-tree.c | 19 +++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2ccb2a090782..992ce47977b8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -620,7 +620,14 @@ struct btrfs_fs_info {
 
 	u64 generation;
 	u64 last_trans_committed;
+
+	/*
+	 * This is for keeping track of how long it takes to run delayed refs so
+	 * that our delayed ref timing doesn't hurt us.
+	 */
 	u64 avg_delayed_ref_runtime;
+	u64 delayed_ref_runtime;
+	u64 delayed_ref_nr_run;
 
 	/*
 	 * this is updated to the current trans every time a full commit
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 772cf0fa7c55..b5846552666e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2734,6 +2734,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->tree_mod_log = RB_ROOT;
 	fs_info->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 	fs_info->avg_delayed_ref_runtime = NSEC_PER_SEC >> 6; /* div by 64 */
+	fs_info->delayed_ref_runtime = NSEC_PER_SEC;
+	fs_info->delayed_ref_nr_run = 64;
+
 	/* readahead state */
 	INIT_RADIX_TREE(&fs_info->reada_tree, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	spin_lock_init(&fs_info->reada_lock);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2925b3ad77a1..645ae95f465e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2082,8 +2082,23 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		 * to avoid large swings in the average.
 		 */
 		spin_lock(&delayed_refs->lock);
-		avg = fs_info->avg_delayed_ref_runtime * 3 + runtime;
-		fs_info->avg_delayed_ref_runtime = avg >> 2;	/* div by 4 */
+		fs_info->delayed_ref_nr_run += actual_count;
+		fs_info->delayed_ref_runtime += runtime;
+		avg = div64_u64(fs_info->delayed_ref_runtime,
+				fs_info->delayed_ref_nr_run);
+
+		/*
+		 * Once we've built up a fair bit of data, start decaying
+		 * everything by 3/4.
+		 */
+		if (fs_info->delayed_ref_runtime >= (NSEC_PER_SEC * 1000ULL) &&
+		    fs_info->delayed_ref_nr_run > 1000) {
+			fs_info->delayed_ref_runtime *= 3;
+			fs_info->delayed_ref_runtime >>= 2;
+			fs_info->delayed_ref_nr_run *= 3;
+			fs_info->delayed_ref_nr_run >>= 2;
+		}
+		fs_info->avg_delayed_ref_runtime = avg;
 		spin_unlock(&delayed_refs->lock);
 	}
 	return 0;
-- 
2.24.1

