Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E9117EB3F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCIVdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45608 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCIVdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id b22so4520124pls.12
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=liJbOg/qh8eI1EH0nzrSmHQQ3FWUVUdFOFKZ+RXSbm4=;
        b=uhOkNM8zukTViLfTeBabOQS/77uxs6I2H+1R1kCyBUt0gAVPjrEq+Ev+16z7tIsdDZ
         NjIKZ4jLN6WGzWcqWJWXaCVZpe56fLPZ45ATstd0jPOQXijqqSb6xy5a8AWDCySQKpVt
         ypPOPyr6wVgpzOaviP0RKTGvTqqwXmQqG6/LFJmnLBCfnNMVdQD9AMWcWYDnQXg5zDxx
         WTygufiein9wzMu77OaSf2QoPsOuJrJMkr5y9h2Jxj7cWEEFUFIqCNjqYLcFzVeyW8pB
         Q5e/yHUVJQ6xl3vPtW5mYYPDremnWZICe92bTUHNu9qJlFYHP28zyM0Yrq7M40L/ztZm
         4Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=liJbOg/qh8eI1EH0nzrSmHQQ3FWUVUdFOFKZ+RXSbm4=;
        b=iWI53P4Ay33PmNTg9mG1oYlI7ANl3bKppHOhkS2Ja/DivjSUJIuhHmpAr62fG51aRy
         ev1VI7HjkSffhuy+8E/9Te11ljoxp5czFY+gvqBV1OT9jllfjxtzy8HWafleYuikOfS8
         5oJ4Hvz9X+iz7gfeGsUWV2tTZq1ZR73gH1a4iDTJ0ZS/xvnCuQ+kYxWQzWuHjlauA5Ld
         tGrUQ8cmf1F+mR00xkR/erky60VUV0Y8Yz1zYWVt+3dfaWKWk98vbvm/TEaHVQ02KaFj
         Ox7dYP+U3ddG2X21cbxbLCU744Kxo8vs/dWvysL3KWSGC4zy04bt9eiT8dCnfdVr4eBH
         I+Dg==
X-Gm-Message-State: ANhLgQ1xadri7cxa07+EB6Iz/w5XVsd9wr6vniOjS+fcMz8PImiMsu72
        RSpl5THxUbIXQChj+LPg50lKFdp/hCw=
X-Google-Smtp-Source: ADFU+vs75VZamV7n1udzU2iPD1IZdCsa3ixWJ3YjIxohdEyqxh4qSkA9PktuEtuOlKUh8zltDZ9FAw==
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr938925pjb.97.1583789583297;
        Mon, 09 Mar 2020 14:33:03 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:02 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/15] btrfs: move btrfs_dio_private to inode.c
Date:   Mon,  9 Mar 2020 14:32:34 -0700
Message-Id: <7cb31cf9673d1d232e770145924ef779d3681058.1583789410.git.osandov@fb.com>
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

This hasn't been needed outside of inode.c since commit 23ea8e5a0767
("Btrfs: load checksum data once when submitting a direct read io").

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/btrfs_inode.h | 30 ------------------------------
 fs/btrfs/inode.c       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 27a1fefce508..ade5c6adec06 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -293,36 +293,6 @@ static inline int btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 	return ret;
 }
 
-#define BTRFS_DIO_ORIG_BIO_SUBMITTED	0x1
-
-struct btrfs_dio_private {
-	struct inode *inode;
-	unsigned long flags;
-	u64 logical_offset;
-	u64 disk_bytenr;
-	u64 bytes;
-	void *private;
-
-	/* number of bios pending for this dio */
-	atomic_t pending_bios;
-
-	/* IO errors */
-	int errors;
-
-	/* orig_bio is our btrfs_io_bio */
-	struct bio *orig_bio;
-
-	/* dio_bio came from fs/direct-io.c */
-	struct bio *dio_bio;
-
-	/*
-	 * The original bio may be split to several sub-bios, this is
-	 * done during endio of sub-bios
-	 */
-	blk_status_t (*subio_endio)(struct inode *, struct btrfs_io_bio *,
-			blk_status_t);
-};
-
 /*
  * Disable DIO read nolock optimization, so new dio readers will be forced
  * to grab i_mutex. It is used to avoid the endless truncate due to
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 50476ae96552..9d3a275ef253 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -54,6 +54,36 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
+#define BTRFS_DIO_ORIG_BIO_SUBMITTED	0x1
+
+struct btrfs_dio_private {
+	struct inode *inode;
+	unsigned long flags;
+	u64 logical_offset;
+	u64 disk_bytenr;
+	u64 bytes;
+	void *private;
+
+	/* number of bios pending for this dio */
+	atomic_t pending_bios;
+
+	/* IO errors */
+	int errors;
+
+	/* orig_bio is our btrfs_io_bio */
+	struct bio *orig_bio;
+
+	/* dio_bio came from fs/direct-io.c */
+	struct bio *dio_bio;
+
+	/*
+	 * The original bio may be split to several sub-bios, this is
+	 * done during endio of sub-bios
+	 */
+	blk_status_t (*subio_endio)(struct inode *, struct btrfs_io_bio *,
+			blk_status_t);
+};
+
 struct btrfs_dio_data {
 	u64 reserve;
 	u64 unsubmitted_oe_range_start;
-- 
2.25.1

