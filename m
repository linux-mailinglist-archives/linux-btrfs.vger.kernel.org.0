Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE12C8969
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 17:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgK3Q0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3Q0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 11:26:21 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115CC0613D2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:25:40 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id z7so16983661wrn.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rcKTA5KGE4nWslF18pAr/90KwDnlEsEfK09+Yniqs10=;
        b=Z1kuYjifD0yaBDEQ4qAlCghmd6HAWMU/n3n+c0t3n2CFpA9vJNlC1hMgdw7KDJiOs+
         TOFEFG4iJmTB/ug+Q1nJtoXLNMM4nZJyGr+q7oDb9H+eHs/B5wqru3L1uSkSp4GDXUxI
         TWORH36SyNb9X6v/tW7Syr86gHrKYuC+Bud1KfcToaaXplCr2m6PgLoKoEdMK9jL5yGN
         BlDum+DiAyeXaixa5W733qwHVsJ78xbj/srdc5p2cbz5ZoAtRLfJD4hzt3ZaeC65Satk
         B6hVbmlwvj/l5NA30fM/AtBf2ZV/FmxbWzCUs6HgjkTDaN/u6UwtwDhwNyPbzdNv4VB0
         EeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcKTA5KGE4nWslF18pAr/90KwDnlEsEfK09+Yniqs10=;
        b=mowgqIE56+zYJAb3TjTpI2wvT9G629oKAX3a78eYTpsD7dykEgcBsfA7QYN/zoPIkI
         AV9mPnJmCdc6B0416jValRmwbjMeQvtOS864baKdfdNv6U0xsISo/9YPyFpf2GSo1zIa
         12LnrVZqVKB8mQIWUvvfuUwHNFG41U+bzas9CYKE/l/pBkMaYcqnsbwcj8XRX1dD3orh
         GMFXEhMCZXhwFIz/IkY+d/e35IjxatsXCAOuB//mZN6tlpjDa4ALnQzVD6HUE3u1Q4zn
         HSIyARzr6+lwON6c8CkPWzIkFd8spi7Qq7qvljKW76YMCfENFfEzM77bkBCSJeNc5zZ6
         rggA==
X-Gm-Message-State: AOAM530o9Gv3fvAwnbM0LGgSUY373ju0E6eFM7CRFpaTNbPsTzQg5hPd
        HGVxnQ+QrkUN6dKmEPh5Smo=
X-Google-Smtp-Source: ABdhPJyDLWsR3EEvs+2LLKm5yOvvnsUB3/x55kaCp7rpA4nFghEf7eYOgLVZf4Ncy4mwsShQcyxYmg==
X-Received: by 2002:a05:6000:364:: with SMTP id f4mr29127108wrf.290.1606753539575;
        Mon, 30 Nov 2020 08:25:39 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id l16sm29539476wrx.5.2020.11.30.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:25:39 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix racy access to discard_ctl data
Date:   Mon, 30 Nov 2020 16:22:16 +0000
Message-Id: <36b18f2dcc56ff5553d700afa7b360572c8181f3.1606752605.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606752605.git.asml.silence@gmail.com>
References: <cover.1606752605.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Because only one discard worker may be running at any given point, it
could have been safe to modify ->prev_discard, etc. without
synchronisation, if not for @override flag in
btrfs_discard_schedule_work() and delayed_work_pending() returning false
while workfn is running.

That may lead lead to torn reads of u64 for some architectures, but
that's not a big problem as only slightly affects the discard rate.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/discard.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 1db966bf85b2..05e2b8150142 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -438,6 +438,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	int discard_index = 0;
 	u64 trimmed = 0;
 	u64 minlen = 0;
+	u64 now;
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
@@ -474,13 +475,6 @@ static void btrfs_discard_workfn(struct work_struct *work)
 		discard_ctl->discard_extent_bytes += trimmed;
 	}
 
-	/*
-	 * Updated without locks as this is inside the workfn and nothing else
-	 * is reading the values
-	 */
-	discard_ctl->prev_discard = trimmed;
-	discard_ctl->prev_discard_time = ktime_get_ns();
-
 	/* Determine next steps for a block_group */
 	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
 		if (discard_state == BTRFS_DISCARD_BITMAPS) {
@@ -496,7 +490,10 @@ static void btrfs_discard_workfn(struct work_struct *work)
 		}
 	}
 
+	now = ktime_get_ns();
 	spin_lock(&discard_ctl->lock);
+	discard_ctl->prev_discard = trimmed;
+	discard_ctl->prev_discard_time = now;
 	discard_ctl->block_group = NULL;
 	spin_unlock(&discard_ctl->lock);
 
-- 
2.24.0

