Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E422CC6E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgLBTnu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgLBTnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:43:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD370C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:43:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w206so1373799wma.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s86X+eDA8hhIRjHaeal4jt/BLgtlzaWk2iIqWYJYm2c=;
        b=Yct0I5GVqizswyKwHh8qjjsxAvQDF1UCyie1Igu72dLZBRpODT03kRtvusoVdLkJmB
         dvf9ig0ALNYvLncg6aMYcAue92id3FnoH+w2yVFEpDdoQCMVR8dlxnKSGKg7r8YBEaLt
         p3mzU0hD+vgcNQZi/+1yaNd+5xXbyWmvGx/znSXbiIVHhd/RvQoHE36OdBLUkCpP/P2d
         nB9+wIOLboumOfgNsyCRSPlC6XLM7oOFWhFsaxT1JN7VFEWFBq5RRgT7mwOUm3q/Aubo
         Zi2DcPDjVwaRp0mQyVO4oAFyp59YXB0EjCObFGI/LrzYe/f9KtpvZ9x5pv59JzqGQwiy
         T89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s86X+eDA8hhIRjHaeal4jt/BLgtlzaWk2iIqWYJYm2c=;
        b=Aos+4esOuQMfE9v1I21NQd5dj0WDh5a/S140a2rO/s3xt/JuRWtDLPsB7Z1lOVxsXu
         Cj6m+pHk4xGI50AGl70A5Zny9pFRV9XeQqUsW2efpFzeoKE2ooLzJwkb6AmzZ66P19fg
         rzW4ed0Ik5yqKlo+MV8u8AczyNQw2w26f9tLlKQKaWbUO6kkgrV0dAdxtPJciv9NaedT
         Dk1uLMMIvCNIsrp7IuQl+q+cEWfHN0bxPZDEfMNZorXO0HFBvhVtD1iC0xMr0oxuF/0m
         bOpa3ircJD3JRLOxFJGNkhhO+DxAHaHl8MHfCcPCKGiSxa+nfupqBQ4JFuHKyYbvGCuD
         yUbQ==
X-Gm-Message-State: AOAM533lUgoGKMgY3oo1PjIXbUteeg8sWT46rihQ8+uMxdu89O4m1w7A
        BRV70/m7e4FhcdcWBrgLtvA=
X-Google-Smtp-Source: ABdhPJzx6b6n4tRhd8ZH4g9XdmAmoMfdgmBIYOYSTUWSXLbVLQgj8TPxmPm0zmYSC/2oW0PcKa8u2w==
X-Received: by 2002:a1c:43c5:: with SMTP id q188mr4704810wma.163.1606938188496;
        Wed, 02 Dec 2020 11:43:08 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q16sm3251540wrn.13.2020.12.02.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:43:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: fix racy access to discard_ctl data
Date:   Wed,  2 Dec 2020 19:39:42 +0000
Message-Id: <0f03c766b7e04ba87d81c7764fe2d1d820818b4a.1606937659.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606937659.git.asml.silence@gmail.com>
References: <cover.1606937659.git.asml.silence@gmail.com>
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
index 4ca852445873..a338f44fec3b 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -475,13 +475,6 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
@@ -497,7 +490,10 @@ static void btrfs_discard_workfn(struct work_struct *work)
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

