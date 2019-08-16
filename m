Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BEF903E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfHPOUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33214 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfHPOUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so6294264qtb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i94VvDnK17PUvV9OcgH95abZS6VHVDlI4IPES9QFUU8=;
        b=qfyeBODxclk9CTDnVXKxPM4qvDdrSJudbYnwhIN+Cwnc/JauJwOCK3CPz5LkEgWxFZ
         gN6zL4EUR+VjTOYVepqyhpjKF3fzw9Xgh3EKozBx+J8qqPfwPbqgjI2gcpzdlhR2i/F0
         eanwPk767aAinJYoGayZAJM76C1fjova5Tx98HqcVOJKnJEhK7ToWTAROCq3BHi7vKtN
         M0L6oe4mEj1X+VHZyWNMvuN6ZOonCvGyRmi40BQA+UeRGq+7W35FcHc3BPzeMX1YNrYN
         58cZhfm/wHWmR9fQKMm4yVKjiOPdx7vE1vjV6sKREulJGB+8d8g/y5c2Hk2GZnwRL7/J
         jy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i94VvDnK17PUvV9OcgH95abZS6VHVDlI4IPES9QFUU8=;
        b=UlFymUmWFG8jrWQKNrs3hXmcPq+Vdbjlh4o0GbVg5i4YpNyTnfmCwuyDkLaruK3Af3
         BgnFVNr/2vNe4HfVveVC2BAdTyeM8NvFikysO4j+Xp/v3G42DE7ilMZ8/dT8CoZzuIJY
         jpuc9tkHBEeiijl0uUIKARcEY1QDqDiJgtKcjDLomFB5bTyv+gREvl6/wwiZS0DbQqXf
         l3LZTwrZ5j4ASreDGwRaAu683q9xmEmVO4llvfZHDODL91CL0VSvJsy46aJKCwOzc+d1
         ILx0NFFPCDtKs5WQ/oPVx1wZOpQmu1gVRFMSiyD+m8kp3thicVDxKitxkdAjEc+i4VTK
         J5fw==
X-Gm-Message-State: APjAAAW8K1hWpJTiEBCBLOBK4miFLAXWIQ7nf0oj9rz6u5Fv9ocV9t+T
        1Rt2gN7xZ+1I08Ru+gRvUBOhV1T7yfKRPg==
X-Google-Smtp-Source: APXvYqyUuWT4Fg6CdOSjoLV9WicfF6xJx89+u9vxQfwwB23ei5Ky08hI4rduQORmQKHBgR8Wy+ibbw==
X-Received: by 2002:ad4:4562:: with SMTP id o2mr2024202qvu.116.1565965208033;
        Fri, 16 Aug 2019 07:20:08 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b18sm3020530qkc.112.2019.08.16.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:20:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: fix may_commit_transaction to deal with no partial filling
Date:   Fri, 16 Aug 2019 10:19:51 -0400
Message-Id: <20190816141952.19369-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we aren't partially filling tickets we may have some slack
space left in the space_info.  We need to account for this in
may_commit_transaction, otherwise we may choose to not commit the
transaction despite it actually having enough space to satisfy our
ticket.

Calculate the free space we have in the space_info, if any.  Then check
to see if its >= the amount of bytes_needed after we've accounted for
the space being used by the delayed refs rsv.  If it's not subtract it
from the bytes_needed before doing the final pinned check.  If we still
don't have enough space then we are truly out of space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bd485be783b8..f79afdc04925 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -471,12 +471,19 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 bytes_needed;
 	u64 reclaim_bytes = 0;
+	u64 cur_free_bytes = 0;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	if (trans)
 		return -EAGAIN;
 
 	spin_lock(&space_info->lock);
+	cur_free_bytes = btrfs_space_info_used(space_info, true);
+	if (cur_free_bytes < space_info->total_bytes)
+		cur_free_bytes = space_info->total_bytes - cur_free_bytes;
+	else
+		cur_free_bytes = 0;
+
 	if (!list_empty(&space_info->priority_tickets))
 		ticket = list_first_entry(&space_info->priority_tickets,
 					  struct reserve_ticket, list);
@@ -522,6 +529,18 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 		goto commit;
 	bytes_needed -= reclaim_bytes;
 
+	/*
+	 * We don't partially fill tickets anymore, so we could have some free
+	 * bytes in the space_info already, just not enough to satisfy the
+	 * ticket.  If bytes_needed is already below cur_free_bytes after taking
+	 * away the delayed refs and delayed rsv's then we can commit.
+	 * Otherwise subtract our cur_free_bytes from bytes_needed before we
+	 * check pinned.
+	 */
+	if (bytes_needed <= cur_free_bytes)
+		goto commit;
+	bytes_needed -= cur_free_bytes;
+
 	if (__percpu_counter_compare(&space_info->total_bytes_pinned,
 				   bytes_needed,
 				   BTRFS_TOTAL_BYTES_PINNED_BATCH) < 0)
-- 
2.21.0

