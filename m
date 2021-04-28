Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC836DE7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbhD1RkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbhD1Rjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:46 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE058C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:39:00 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id n22so7700062qtk.9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7g6xGjOHYNHKhLW5t0Cgmu0S4h9xleWu943+SBo0kL8=;
        b=A8q5xXGOVZXcIGwWvuuwDXuqCpPPENyKPZyfdOy3KN4hxuOawRSUPNrW+x0E2tY3gg
         GNzhywqJTwAyKYJOXTOg5cIl5UWOIaKmBej33FX5yodcd8COzUmw0blFq+pFIV5Pe3Tm
         fV7Kr7Ra2gIc7fdpJ9FzSnxTGWe7n9/mYpQjARZ9l/qFnLbwPkn8bcY51YSnKV647dk/
         SE5+HF5TtZRChHTQjfrygXBNhFM/8H6aAC8G71RTeuhqeHm8BvPfA9Mei/7Yo+McdK2B
         SJJTeONpddEJY8ng7aollBFEOVed8Zc9cAnLvB9xvl6b4B3O6P8tjUmLaKyDjlPyumID
         vK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g6xGjOHYNHKhLW5t0Cgmu0S4h9xleWu943+SBo0kL8=;
        b=T7QmW9ECEBRdph4h3efHx2QJprh+dzRvNlm5LlJiM1EphJmOiof7mLMzQrZ3dAz0Pg
         lkMHLM4E99BnsihFw4BJb81wigYKqy2uMJ4zW3hGlM+TMYY5jCp3016wbRDDy24mM9vs
         D4lR6sz5NToMGfpK1OjxffGvyky7gNzldbHpIyAEI4jqQqyc4iO3fLwJSN7d7jelM60Z
         JXReZYHsGUE3rPkp/MLj8lCMOACjkFZCIgSTsXOfwOXeHQtePIxr4sM1T/5Oj/2kDHlY
         5yspllGoVcUvsjT1lV+ApxeO+y5pob23srzDvoaCvHA43p7m+EY3yvObuKKErmOxOcQs
         MoEA==
X-Gm-Message-State: AOAM531GkfUfYET/p4BViE10WLXCUUUoXgsJuCM/f1od+9Wl+B3Ql6jD
        jamtaldMzHDmT+mkdO2DSP6L85LYBRSnZw==
X-Google-Smtp-Source: ABdhPJw+X3R31ueDdtX5+IgJkSJzo9H6ZZcQljDZIlRigipKDgWUadPt0fSnp09YhcwBAzYiMMkzeQ==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr28125158qtx.53.1619631539799;
        Wed, 28 Apr 2021 10:38:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y6sm271570qkd.106.2021.04.28.10.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] btrfs: handle preemptive delalloc flushing slightly differently
Date:   Wed, 28 Apr 2021 13:38:48 -0400
Message-Id: <63c38e3b1c4b1214859852dbc83dac9115a2f26a.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we decide to flush delalloc from the preemptive flusher, we really do
not want to wait on ordered extents, as it gains us nothing.  However
there was logic to go ahead and wait on ordered extents if there was
more ordered bytes than delalloc bytes.  We do not want this behavior,
so pass through whether this flushing is for preemption, and do not wait
for ordered extents if that's the case.  Also break out of the shrink
loop after the first flushing, as we just want to one shot shrink
delalloc.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cf09b23f3448..b2d834b92811 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -495,7 +495,8 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 			    struct btrfs_space_info *space_info,
-			    u64 to_reclaim, bool wait_ordered)
+			    u64 to_reclaim, bool wait_ordered,
+			    bool for_preempt)
 {
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
@@ -532,7 +533,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	 * ordered extents, otherwise we'll waste time trying to flush delalloc
 	 * that likely won't give us the space back we need.
 	 */
-	if (ordered_bytes > delalloc_bytes)
+	if (ordered_bytes > delalloc_bytes && !for_preempt)
 		wait_ordered = true;
 
 	loops = 0;
@@ -551,6 +552,14 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 				break;
 		}
 
+		/*
+		 * If we are for preemption we just want a one-shot of delalloc
+		 * flushing so we can stop flushing if we decide we don't need
+		 * to anymore.
+		 */
+		if (for_preempt)
+			break;
+
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets) &&
 		    list_empty(&space_info->priority_tickets)) {
@@ -702,7 +711,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
 		shrink_delalloc(fs_info, space_info, num_bytes,
-				state == FLUSH_DELALLOC_WAIT);
+				state == FLUSH_DELALLOC_WAIT, for_preempt);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
 	case FLUSH_DELAYED_REFS:
-- 
2.26.3

