Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A1151C3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBDOcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 09:32:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41396 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgBDOcu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 09:32:50 -0500
Received: by mail-qv1-f68.google.com with SMTP id s7so8623828qvn.8
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5J6Ek4hzUve+e8R5ZLGFZHJQcANfHjuLHxkqFiigqjk=;
        b=snpNQS0XTYTgMWqiQVM7Wvmqt+DLYrOM3ezpX7mldNeF5hy7bwgoIWlaWwgUVpi0Wh
         XzwEvrUu7VZXUA3FIMb880sSb20kICsUdiklISCJyLo92RqIcotWGFbUMmpOYq5PcdK7
         hoFQdUpLejRukJTyU+WbQU6Js7896tr0GgpALtkF0oV6IaTCFxOf9dzWPOkxTh7KY9wG
         kPWZOPEBCxNGEbIqIvCAPQxOYitqtdpPpPbnMTQc1lXVDRRxVuKnLRf1QRewl+J1AtC9
         0NpzCbZA4l9dWKi826t+dgZso2sLH84PHn8PYZor+BLLPz1xy79Lne+GQhYamzWgnBfN
         FkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5J6Ek4hzUve+e8R5ZLGFZHJQcANfHjuLHxkqFiigqjk=;
        b=iVm/ieW0KBTbPMarZW7su5WHm96v/bsrQAGlorlanVHUK1b/53Vjr2BJZbERwV6DLY
         4wfAuQrmRdGNMKGz74DRk7oaf58EpTZ3iHJGoD764c+tuC88yWN5orRB3FFfrT7KU+CH
         9QJEjAyAZvjCHuqBm5uROI34xS0X8yx6Vp8hr3fcko0E8QpBIyjmqAuqtLeKichskurq
         lZ2eF7yr4K9pyAXctLrgyIvc6RfKs1s2QOsnGNB58dcEsMHghoNUXsQw+9F4OgtwhMJr
         0hnpTutYSk34HFUd6KfTaFyIN8Ci0f/kZp6QHuWOepIknjpaS9TDlc3LO4aD2u/f7y6P
         GRUQ==
X-Gm-Message-State: APjAAAXxoP5RLz3wQiSQS+ZxV8lT6w7521rqfTEEmvZmPufgMiGWVo9K
        ihN6WrABTwCkZoZvkNpjZUWu/LqhDFYKCg==
X-Google-Smtp-Source: APXvYqwFk6Auwgjtglo5uC8UaDFwrDy72gH+CvjQ/Piy2mWJ56xgWdDHp0qAsJyuvGv7Pna1P/bSlg==
X-Received: by 2002:ad4:58a8:: with SMTP id ea8mr27518963qvb.93.1580826769079;
        Tue, 04 Feb 2020 06:32:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t2sm10930302qkc.31.2020.02.04.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:32:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: fix lowmem check's handling of holes
Date:   Tue,  4 Feb 2020 09:32:41 -0500
Message-Id: <20200204143243.696500-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204143243.696500-1-josef@toxicpanda.com>
References: <20200204143243.696500-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lowmem check had the opposite problem of normal check, it caught gaps
that started at 0, but would still fail with my fixes in place.  This is
because lowmem check doesn't take into account the isize of the inode.
Address this by making sure we do not complain about gaps that are after
isize.  This makes lowmem pass with my fixes applied, and still fail
without my fixes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2f76d634..fd503aa6 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2029,7 +2029,8 @@ static int check_file_extent_inline(struct btrfs_root *root,
  * Return 0 if no error occurred.
  */
 static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
-			     unsigned int nodatasum, u64 *size, u64 *end)
+			     unsigned int nodatasum, u64 isize, u64 *size,
+			     u64 *end)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key fkey;
@@ -2152,7 +2153,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	}
 
 	/* Check EXTENT_DATA hole */
-	if (!no_holes && *end != fkey.offset) {
+	if (!no_holes && (fkey.offset < isize) && (*end != fkey.offset)) {
 		if (repair)
 			ret = punch_extent_hole(root, path, fkey.objectid,
 						*end, fkey.offset - *end);
@@ -2165,7 +2166,8 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 		}
 	}
 
-	*end = fkey.offset + extent_num_bytes;
+	if (fkey.offset + extent_num_bytes < isize)
+		*end = fkey.offset + extent_num_bytes;
 	if (!is_hole)
 		*size += extent_num_bytes;
 
@@ -2726,7 +2728,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 					root->objectid, inode_id, key.objectid,
 					key.offset);
 			}
-			ret = check_file_extent(root, path, nodatasum,
+			ret = check_file_extent(root, path, nodatasum, isize,
 						&extent_size, &extent_end);
 			err |= ret;
 			break;
-- 
2.24.1

