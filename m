Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9820F680
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbgF3N7b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388177AbgF3N7a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E14C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:29 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h18so9291448qvl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpLoVxtYuKq3xuBN6YWOovH3J+ch/wI4zzBLssFwCZc=;
        b=x6AoSOidWYQ/0pSAI/cqWcxBwOmYMz+mvy7YpzTTAI+hXtvJbKRUAvonwkd395kf96
         Lbjk3N3WdwxFL6wSZZk8+VKLsu6pPXnEdj/LdOcqel+8NCGwKiOGtavLXrGRKR7fQ8wR
         MG7aNRVY9QxSzHwvedCOQqlxTKJpfuboqyncqzjKjEjDEoyivvMd2/6iohMWOoWAqPiF
         5wK+Sck9yb8UE32X6r4RAp//kaFqiStevZbeVVHTWeYVhMhJfD01c3vZtrb5KeMz0sX4
         lpf24YPTczSmlW18+2o6+HlNH1h4rwrPAGezL6d6HXor3PHpnyoDytg+NZ83DcxgAbFp
         5Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpLoVxtYuKq3xuBN6YWOovH3J+ch/wI4zzBLssFwCZc=;
        b=jRWooVgb/CtDPrKMW+ZRbBe35/nv6EYdAZVZ3FJMwuXk7IPP/IT49f2K9NTSkkFIUq
         YPYhgcaXFngZy3C1PwcYApJBpNLxnXAbAghuP1xm+cLEpF5aSrCm+pNBfnV+FCE9cDF6
         31NoeYeb5buIZMokEgzR82erItmZpZFqa7uAwrCkHmt4v7ghaIQrNc1UvmC2g0h7WUct
         c/mebgO9ye0Z44uc+S6T5kdHs0O94+iYG0cftBkt+a+kbtNf/ZEX6IDSjCXxgEFpyYTE
         mApPtVktjuwnVwDoKQ8a9Q/6XQOTIb6JVFkOZcU8wR0B3VXoUO9wXPYdzcEbFKrMh9ZE
         CIDg==
X-Gm-Message-State: AOAM5303ifZQaXM20Y+jx24VikkXlK7TjEZ0+RuGJ5oIq1O5pTFOWAmA
        LQN4Q9238iRp3NLuZlgrUXoSipdqMI2MVg==
X-Google-Smtp-Source: ABdhPJyZoW3Ltlj9nDVGrQ731dTdVOnzlkrhdrMX6NOXmWXwFVn6pvVChDxTscc+ey30o/odLU3AxQ==
X-Received: by 2002:a0c:fe01:: with SMTP id x1mr19561062qvr.246.1593525568711;
        Tue, 30 Jun 2020 06:59:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p125sm2847058qke.78.2020.06.30.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Date:   Tue, 30 Jun 2020 09:59:00 -0400
Message-Id: <20200630135921.745612-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 571b87cf1c41..266b9887fda4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -517,7 +517,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  * shrink metadata reservation for delalloc
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
+			    bool wait_ordered)
 {
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -742,7 +742,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+		shrink_delalloc(fs_info, num_bytes * 2,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

