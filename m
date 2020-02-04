Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA8151C40
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 15:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBDOcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 09:32:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35937 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgBDOcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 09:32:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so18109282qki.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SVveTweD7pRJBCgwGMJkijo5InLnOXzel1JZpscbdsk=;
        b=Pzr/9RRWIbDO2ZVr2Ni4oFiuSm0Qh+32AOQTl7zVTY3ZeR+SdJ1CUaufTAvvjlyUis
         varsKsKcwuFX/hdKFBqrsojxVODeWuOMLC/k6Tf1nfzTtbitdxDzc0SyP4Q1kkfxVGc+
         UfCK+TgTiDgImfpoqQXe0RR+38ce55Ku01Qt8GO4brBnRtgFuXLovkebLJ4UN1BReE/1
         HMh8M1wyhCsuRUsDQ+/2MlgeyepCXGtSWMrdxqfFAUZn9b4l3r2wY8/vrcmHohAOQp3O
         8tOb1w99Ju7cGjUhCoLGFHRWhr0t7T86YwgQnsH7al2fvFbe1YT7+ePFqhmoICBrXmvE
         yrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVveTweD7pRJBCgwGMJkijo5InLnOXzel1JZpscbdsk=;
        b=BHECUeTLqyIQkxh497mEdLWZBga0Hwv2IfNg7k7SMCyerjleFdyiBfB2yp+jgjCI/Z
         T2LGk2ZVSJiXLaFjsFZuNnkOYzyJKTe3YVjSveChxL8fvZ17+76EY4/MqnIrYsji1OKa
         GRfXf+bsfnzE3SP3QMKMArAo2MVt4tBTAFNBzVlQhq8rwhX1av+cCwX1DgvHfzCqkZHo
         qM6+5rC9UfWhWOlxsMTkWXcCtEHFDTnyM4mkMM95PALOkiKc3qgawcY5kjMTITteNRPm
         1AUjq3Lws9j8o7aV2SsX1zqPph1fjPWlgJBFddMR9puqN1MsqRndPplaepzu4TsdLAjB
         fYYA==
X-Gm-Message-State: APjAAAVDeXTbldyL4zlm7A3nwuoqz3cdo4KMInsPYsetbP+tTEE/ICYW
        dcolOcVtGFwB4mVyN2NUUVUJQNQdpljAew==
X-Google-Smtp-Source: APXvYqw9ldg/+mpt1Uj7jpqrRyU8VixC5c62yCTLecropb4UFpZ1mC4eZOAMFLXvHq07PRddVHeHUA==
X-Received: by 2002:a05:620a:16ad:: with SMTP id s13mr28774338qkj.388.1580826770594;
        Tue, 04 Feb 2020 06:32:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v1sm11103722qkg.90.2020.02.04.06.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:32:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fix hole error output in fsck
Date:   Tue,  4 Feb 2020 09:32:42 -0500
Message-Id: <20200204143243.696500-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204143243.696500-1-josef@toxicpanda.com>
References: <20200204143243.696500-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we don't find holes in our hole rb tree we'll just assume there's a
gap from 0 to the length of the file and print that out.  But this
simply isn't correct, we could have a gap between the last extent and
the isize, or 0 and the start of the first extent.  Fix the error
message to tell us exactly where the hole is.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 22f4e24c..71b68ff9 100644
--- a/check/main.c
+++ b/check/main.c
@@ -639,10 +639,20 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 				hole->start, hole->len);
 			node = rb_next(node);
 		}
-		if (!found)
-			fprintf(stderr, "\tstart: 0, len: %llu\n",
-				round_up(rec->isize,
-					 root->fs_info->sectorsize));
+		if (!found) {
+			u64 start, len;
+			if (rec->extent_end < rec->isize) {
+				start = rec->extent_end;
+				len = round_up(rec->isize,
+					       root->fs_info->sectorsize) -
+					start;
+			} else {
+				start = 0;
+				len = rec->extent_start;
+			}
+			fprintf(stderr, "\tstart: %llu, len: %llu\n", start,
+				len);
+		}
 	}
 
 	/* Print dir item with mismatch hash */
-- 
2.24.1

