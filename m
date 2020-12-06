Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51E92D05CB
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Dec 2020 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgLFQAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Dec 2020 11:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFQAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Dec 2020 11:00:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01FC0613D3
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Dec 2020 07:59:51 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id f190so11437044wme.1
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Dec 2020 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MTZNTj9112GUR4EWB5wrXSfr5LJhNHZqAO0IoO3ucUo=;
        b=o4GoEIXKzg7vekzOMwGVL357Bq/bcuGoN14zfqaYgUN/m1GBqstfjKqC0tAT31xPqG
         i4aAhxYVrfvtR1F6vpELJWpDM7ab+ZtEwACi+gco2FS9ZoZ8ps6q9QFNwQzA1aOfFMY2
         ELhkphTRqiOiFLpaCB2oZ2N9oHjHR50cJVJ4ejV3yjGpY6Kt2F1Uowkn8q9ijXaW9Xok
         VyNhdfQ5aXBrRSBG74Q1JEMf3xRPMpOfDJXU58fPDikU/6/othq9de73jJPaVVbHGRvn
         khgpXp+Hr9/cg8hIoBHJQ7/zU9CzIwnSvtaAhrfehgB1ICibrNP/gUU3Img+VPfQtBKZ
         XVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTZNTj9112GUR4EWB5wrXSfr5LJhNHZqAO0IoO3ucUo=;
        b=SG1+EJlv+CwTGcCCmMrE4Ugzx/bHDI4EfvCZe3TQ5LEWZ6Qbc7yPrnrNBAd/bukI+9
         Y9r0NA1DFKuz3rnqUVatvjql50zvk0wiyiFUL19yE29DOSjTNc9yrpRZoBf4sFRJ+plz
         MgSV9N797eNeVinDndBkVCx/3KXiiXA4CYhKiwOqCz4UMdt0ttDQUU0kyE6fIs9fuaeR
         LbLcN9HA6jU4dA79N/woXQt82DNKjf+KbRIh6QAgMaDK+KbZgqHEJY2eehj7jb37Ve3s
         gp8vnKsEuHESHIqJrg/3SLvroX8BYp6PBUPbZYc2jCDTdvWcXisNW9h4HTS0B4V/Jmj3
         O2FQ==
X-Gm-Message-State: AOAM531l21pifcsNZBaNkZcvEbjOrhigV6fJxYKu0xyXLtn/7w+NaJqv
        /zVcrAS3Z+9TEl9BZnWgynY=
X-Google-Smtp-Source: ABdhPJxqZCrR30Ujd19DOYKuCfAnIYGe73fUEY/5nhMtWKU/UckDhLY7VoEnuYnqEaHAVX7/lFOueg==
X-Received: by 2002:a1c:a9c8:: with SMTP id s191mr14215072wme.89.1607270390434;
        Sun, 06 Dec 2020 07:59:50 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.92])
        by smtp.gmail.com with ESMTPSA id h14sm9933355wrx.37.2020.12.06.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 07:59:50 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: fix racy access to discard_ctl data
Date:   Sun,  6 Dec 2020 15:56:21 +0000
Message-Id: <a6d9f2e4912cd174bf796b822cc8ed56fca89d86.1607269878.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1607269878.git.asml.silence@gmail.com>
References: <cover.1607269878.git.asml.silence@gmail.com>
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
 fs/btrfs/discard.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 36431d7e1334..d641f451f840 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -477,13 +477,6 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
@@ -499,7 +492,10 @@ static void btrfs_discard_workfn(struct work_struct *work)
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

