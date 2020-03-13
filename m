Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1A185100
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCMVXw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40794 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgCMVXw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id j2so2297440qkl.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G08ksGNnBKdttQkIG65mLPKcCadIDPby6s3DYKD2PkE=;
        b=AfS17Ng/YbidxmggfvGCQQ7Pk4ha04594mzpbVA4shAiNXn+83y0WXs18zv+tmfXGA
         FeQmmu7tovIxOvMgmUtZx73X6OEOdJGLN/qfU03KtRGBgrc8B7lnbmjjvAbCSyRmzmpc
         qk/P0oZyQnyi8VghiIAsVnpTCmgtHoQO4vKG9gyKkW7mcAyRUD6l7nhOmcbRFDZFoz1M
         BblyyolWyn29Wgiy+e27HMZkLMgEbycfSAUt1QeR1rgR83gNswH7WXm9nw3QaenWPpxS
         OQpIOmewLpBSjHXayNJ3XsejUe8OnwIJkBEz++tq0KixUVZRng0HONrWuLV/LnK0yIkf
         I9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G08ksGNnBKdttQkIG65mLPKcCadIDPby6s3DYKD2PkE=;
        b=RJkktILLDEDNTk+O/6hHCsuFQe0bNezLzsp9W0bPkLX62etSPCp4thDUVrLGmrUt6G
         zWfOYDa+FDqchRHvbSe87fjmuAvaYlgdXF7YX2dCMn4e9UfzFM32NEife94Boeb7z+wO
         3FdiJqyjISvBHviB0VUd1bh6jEma927RAF5f+sgS1Wc6SYgMpdoYZKoeODv65YUKt6e2
         WnYgxrZJzPNXOQU2H33cUjktBLOn2RP363ywga9/vSLWS1ynh2oCL+vFNrIOFZNCcVFr
         X1Fraba6fxcwWD0BZUBoXm1KlGInJctTfOxOlyTjY8Exc+cd9xAmr5F+CggQPQb/oSI2
         sI0Q==
X-Gm-Message-State: ANhLgQ3lCXFKvfWZLVNsTHOZoerVbWFuPig1+6fyldvfMPUmkVYM/o4w
        /kq9+TJUUF9uW5TZJ0G8yop3j9V1PoVjDg==
X-Google-Smtp-Source: ADFU+vvv01KEhmglKLfc2cUr6k2JMhkUtU4mqGng1vRUMpy+NpUYHce7Ham8jik1N+5aFq2M68akyA==
X-Received: by 2002:a37:4b4c:: with SMTP id y73mr14866994qka.467.1584134630473;
        Fri, 13 Mar 2020 14:23:50 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o81sm4652474qke.24.2020.03.13.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/13] btrfs: handle uncontrolled delayed ref generation
Date:   Fri, 13 Mar 2020 17:23:27 -0400
Message-Id: <20200313212330.149024-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some operations can generate way too many delayed refs, resulting in the
async flusher being unable to keep up.  To deal with this keep track of
how often we're needing to throttle the trans handles, and if it's too
much increase how many delayed refs they need to wait on each iteration.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.h |  3 +++
 fs/btrfs/transaction.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 16cf0af91464..03590a13f86e 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -157,6 +157,9 @@ struct btrfs_delayed_ref_root {
 	atomic_t entries_run;
 	wait_queue_head_t wait;
 
+	atomic_t mult;
+	time64_t last_adjustment;
+
 	/* total number of head nodes in tree */
 	unsigned long num_heads;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ac77a2b805fa..6f74f9699560 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -308,6 +308,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	cur_trans->delayed_refs.dirty_extent_root = RB_ROOT;
 	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
 	atomic_set(&cur_trans->delayed_refs.entries_run, 0);
+	atomic_set(&cur_trans->delayed_refs.mult, 1);
 	init_waitqueue_head(&cur_trans->delayed_refs.wait);
 
 	/*
@@ -902,6 +903,17 @@ btrfs_throttle_for_delayed_refs(struct btrfs_fs_info *fs_info,
 {
 	unsigned long threshold = max(refs, 1UL) +
 		atomic_read(&delayed_refs->entries_run);
+	time64_t start = ktime_get_seconds();
+
+	spin_lock(&delayed_refs->lock);
+	if (delayed_refs->last_adjustment - start >= 1) {
+		if (delayed_refs->last_adjustment)
+			atomic_inc(&delayed_refs->mult);
+		delayed_refs->last_adjustment = start;
+	}
+	spin_unlock(&delayed_refs->lock);
+	refs *= atomic_read(&delayed_refs->mult);
+
 	wait_event_interruptible(delayed_refs->wait,
 		 (atomic_read(&delayed_refs->entries_run) >= threshold) ||
 		 !btrfs_should_throttle_delayed_refs(fs_info, delayed_refs,
@@ -973,6 +985,15 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 		err = -EIO;
 	}
 
+	if (!throttle_delayed_refs && atomic_read(&cur_trans->delayed_refs.mult) > 1) {
+		time64_t start = ktime_get_seconds();
+		spin_lock(&cur_trans->delayed_refs.lock);
+		if ((start - cur_trans->delayed_refs.last_adjustment) >= 1) {
+			atomic_dec(&cur_trans->delayed_refs.mult);
+			cur_trans->delayed_refs.last_adjustment = start;
+		}
+		spin_unlock(&cur_trans->delayed_refs.lock);
+	}
 	if (run_async && !work_busy(&info->async_delayed_ref_work))
 		queue_work(system_unbound_wq,
 			   &info->async_delayed_ref_work);
-- 
2.24.1

