Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F007D2CC6E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgLBTnt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgLBTnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:43:49 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC764C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:43:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so10625899wmi.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fJhESfHKiNX8SD67hnYRudkmIYhXIzdckGtb1EU5s5Q=;
        b=OykHbB1NCRYPbBa2DJCcIQT6BQTGBTcGoOBzVDxCYVfT0erZEMHOQhOS2kyujx4QVL
         8OIxZQL7O6BPuPq6wCIP5ja5A1ddnYATJdh6ZdCtabReyfndM7+G4+2Nf3IG3FF5yD3U
         A3IIYTkGMmZyhg6I/B5zJVbOH2E2wo3p7t1DKNKM/N0fkpdH8UsA4OHKNLPLUypKUeIV
         rNk6tcdc+s6f6sM3IN/v9lbkzIbvJuYItIcRrZuF2wVowrbqJjM0TrsJxbVu0dMvPDh/
         B+rgVHWkHJBvDAKFAPDNj2dnKj4L1TiIP1M4YF9g9gxKp3azLAR1pEL872+znC2ee80M
         hyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJhESfHKiNX8SD67hnYRudkmIYhXIzdckGtb1EU5s5Q=;
        b=IUkQGxHu61PtDzG33FH8v98rXPj2MDkyvM5V4lXlsFQ8oMmn6w3ljQLOvYDfhOPojS
         /4v0+lCHWvfU7oifA8hHv58tbEm+o8Uf9xj+h2siQ0pu2QGoXtMlMg5S9sRNkL34z1Iz
         xOJ4OMgbUnTT/S5OU9iqPzaVnnnh+z9E43kESNKAf9J1Z3rJvYgzE3vuaiRzTcmLRDjb
         5hTpXqsrlC7+3JvhoarplNQKdsnBHHIHclpiNqYt+o2NVoD1v/GTTb+XLhLgrL1T+g1S
         ONQOmhM9GISMtkkqPwOVNdvK01snTnY7KzRzEAcsFJHDg2ERdpIjakmRH1jhbzEnyAlG
         KUNw==
X-Gm-Message-State: AOAM5301ZxNcHkAKQOauMOsFNyJXHUAwym/79PudIfUDFNYmnTBKM9/C
        K2BLxkZ10+WqNkofBBiZJng=
X-Google-Smtp-Source: ABdhPJxBf5XVQGhwpPw2uBIhNiw/IeTcvDqqJ1Z14Ik6wATuH1y4fdEsYKa3zXnzbHEnlYJ3kel51Q==
X-Received: by 2002:a1c:3d55:: with SMTP id k82mr4664752wma.57.1606938187470;
        Wed, 02 Dec 2020 11:43:07 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id q16sm3251540wrn.13.2020.12.02.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:43:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: fix async discard stall
Date:   Wed,  2 Dec 2020 19:39:41 +0000
Message-Id: <f281023a1df3246d227a3af226eb6d612b4c3a4a.1606937659.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606937659.git.asml.silence@gmail.com>
References: <cover.1606937659.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It might happen that bg->discard_eligible_time was changed without
rescheduling, so btrfs_discard_workfn() would be awaken before that
eligible time, peek_discard_list() returns null, and all discarding
going to sleep until somewhat else calls for rescheduling again.

Fix the stall by keeping btrfs_discard_workfn() going by always calling
btrfs_discard_schedule_work() when there is any block group in the
discard lists.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/discard.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 1db966bf85b2..4ca852445873 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -199,10 +199,9 @@ static struct btrfs_block_group *find_next_block_group(
 static struct btrfs_block_group *peek_discard_list(
 					struct btrfs_discard_ctl *discard_ctl,
 					enum btrfs_discard_state *discard_state,
-					int *discard_index)
+					int *discard_index, u64 now)
 {
 	struct btrfs_block_group *block_group;
-	const u64 now = ktime_get_ns();
 
 	spin_lock(&discard_ctl->lock);
 again:
@@ -224,10 +223,7 @@ static struct btrfs_block_group *peek_discard_list(
 		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
-	} else {
-		block_group = NULL;
 	}
-
 	spin_unlock(&discard_ctl->lock);
 
 	return block_group;
@@ -438,13 +434,18 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	int discard_index = 0;
 	u64 trimmed = 0;
 	u64 minlen = 0;
+	u64 now = ktime_get_ns();
 
 	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
 
 	block_group = peek_discard_list(discard_ctl, &discard_state,
-					&discard_index);
+					&discard_index, now);
 	if (!block_group || !btrfs_run_discard_work(discard_ctl))
 		return;
+	if (now < block_group->discard_eligible_time) {
+		btrfs_discard_schedule_work(discard_ctl, false);
+		return;
+	}
 
 	/* Perform discarding */
 	minlen = discard_minlen[discard_index];
-- 
2.24.0

