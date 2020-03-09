Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C817EB41
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCIVdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:08 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36046 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCIVdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:06 -0400
Received: by mail-pj1-f65.google.com with SMTP id l41so486507pjb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2RsQPRD0w7048dytJeUmrGKvsDH4YsdJs1InlBl878=;
        b=MdbEJqPuT1gDR8ahrp5wuPF+Ze8hFsye3FXTj9cAbNzv+PpeZov6uZnIlIazeglSkP
         9mB228Ij1BKvhVO2H7uQ/6nFcREvE2gobOpjV0j8/ULIsQT/QSy4tQoT4z1ING0HhpAY
         orxd/5dUVp9sbSZrGiuyAXxG2JXpB346oenWbD6dWGw66dY5Wiul9m9qFHNiiRg19poL
         s2W3qyIFeJoFtwyb7URKAeQvge5fpouFoITIH5kZiHrQmrxPbgE6gWpFUNZDuyMuiPoO
         1EfNMOoYBdPuEe2b0ZbdWjxvfv7DJxpyKBNCR9fNB2/+gv8w25f86uYaIBu81ofW9FVL
         a1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2RsQPRD0w7048dytJeUmrGKvsDH4YsdJs1InlBl878=;
        b=oggmB86R6/ReuWDV5Z+PJwFcvUtiOAUB9ckVkgJp3ekeDR2OaaCfnqrKlxKPeV3jVW
         n/jO4e9TGnCf1oQmNl4mJGOVQ4Df6Y21UKf3wgbqCux4c6y0esd+saHvNVd6KImF36Pt
         RnmKlU+IGtVFEWkrfuWkrsgBqYBub3al3LyROtJ6JuM88BJpRc/n+x47porZHdClmWsu
         AV+/sGHnF0y40fjd+zMPACTtGnHAYRrTOsWYsL3a00HUg16novSMr5+zl6SiAZRTobJk
         txfi7kjp/9YgXgvYQiabwMVbKVZ93Ev/A2A8nwC312KvEHHfHW42XvZLjUErOKEc+AvA
         8GmQ==
X-Gm-Message-State: ANhLgQ37Nt+Mwz1n33N8CxrP8nrOja7vQ7OlfxawByjCX1yj6R8zJfOe
        QHz6akZPuHhRtmGjn62hHX7FQDPJrPw=
X-Google-Smtp-Source: ADFU+vv4rQr1AIXBAjPfeAq7IJYFhKkwWTy95eyT7dRfpeC692UKjUnuTS0r5ShDa3q2vLuMp/gN7w==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr1254607pje.90.1583789585379;
        Mon, 09 Mar 2020 14:33:05 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:04 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/15] btrfs: convert btrfs_dio_private->pending_bios to refcount_t
Date:   Mon,  9 Mar 2020 14:32:36 -0700
Message-Id: <ca4884807ed430e3f546e50cc06678517f439df7.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is really a reference count now, so convert it to refcount_t and
rename it to refs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cc8741b3fec..a7fb0ba8cde4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -63,8 +63,11 @@ struct btrfs_dio_private {
 	u64 disk_bytenr;
 	u64 bytes;
 
-	/* number of bios pending for this dio */
-	atomic_t pending_bios;
+	/*
+	 * References to this structure. There is one reference per in-flight
+	 * bio plus one while we're still setting up.
+	 */
+	refcount_t refs;
 
 	/* IO errors */
 	int errors;
@@ -7849,7 +7852,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	}
 
 	/* if there are more bios still pending for this dio, just exit */
-	if (!atomic_dec_and_test(&dip->pending_bios))
+	if (!refcount_dec_and_test(&dip->refs))
 		goto out;
 
 	if (dip->errors) {
@@ -8001,13 +8004,13 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 		 * count. Otherwise, the dip might get freed before we're
 		 * done setting it up.
 		 */
-		atomic_inc(&dip->pending_bios);
+		refcount_inc(&dip->refs);
 
 		status = btrfs_submit_dio_bio(bio, inode, file_offset,
 						async_submit);
 		if (status) {
 			bio_put(bio);
-			atomic_dec(&dip->pending_bios);
+			refcount_dec(&dip->refs);
 			goto out_err;
 		}
 
@@ -8036,7 +8039,7 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	 * atomic operations with a return value are fully ordered as per
 	 * atomic_t.txt
 	 */
-	if (atomic_dec_and_test(&dip->pending_bios))
+	if (refcount_dec_and_test(&dip->refs))
 		bio_io_error(dip->orig_bio);
 }
 
@@ -8074,7 +8077,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	bio->bi_private = dip;
 	dip->orig_bio = bio;
 	dip->dio_bio = dio_bio;
-	atomic_set(&dip->pending_bios, 1);
+	refcount_set(&dip->refs, 1);
 	io_bio = btrfs_io_bio(bio);
 	io_bio->logical = file_offset;
 
-- 
2.25.1

