Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3B44CA59
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhKJURw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhKJURv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:51 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA72C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id j2so3677058qkl.7
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QKXiyseXhQbPFFyxX7MyImwdI7hDpamDr18fg7TVr34=;
        b=pkyuFes1n1IymtzcqQKwZ9Dw4fKLUT1C4SPYQFBJgMNBSMwyOnrHIJmX0LkKZka7fc
         2bDvW19T97aySe/X8V7gf6eZ7pLQ/6Hie8pw1KKZo/8DvFq2YDn+viL7WQ/1pnoKryWr
         eGlpWQCji/MEIrhBxyNcWg/GmryEM8f/kGrMOUxemWmF/C11L4rlqyIwmHAo5/i0CtaM
         gdEV7bBPAJP8UKVl7uyu1kRH5pa4l6JTg83sOu7qqPEy41TSVwvnJznYsjEB4jJfl52O
         JXR2GPQr1dEAKZYS0In7O18e+3rrzVAtRVMUJ5M34OVtCAYf9WI6sBhkOMG33wbRuk9f
         visw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKXiyseXhQbPFFyxX7MyImwdI7hDpamDr18fg7TVr34=;
        b=DK03alBl2eSqcvWD9BFmWzeerjDAS7PqpSVjAxHdn0YPp5TKv2o0BM+dQ8RNM4OmwL
         p5mt0oL14TJVc4B7kM6pu2vkLij8SyPz9RczCJBi+9jx4s3UTo00mz/EH11kkpxcdHKy
         rUw1/sqI7K//CeD76WCIRTdsCRtzPgHhjzfdRWY2bujxamY3iTOi+9HbqGMoTb70Iuu+
         ul/u2wFJ9NpaoKs4DtMJ0zDfFPax4YFgUDTEIBsYK+X3z3g+CeGEoGr8pmujMo/qsZvt
         f0PWRvGlldmBQOPZH328UMVFrT+ubH/EYCwv6FB895HuWeZufzJpaA2Akj0eSPGejMtJ
         LYoA==
X-Gm-Message-State: AOAM532APxQqtnlasIWnQDE6D5GwXGjHoN7hpsZEt+vgO3nVpk4tN5Pi
        ETRXX46579O5FIpOk5OkfCVjZbgw8vZ2xw==
X-Google-Smtp-Source: ABdhPJycI2G5DJrhwGfghTpC+jXxsAnKVcXeKBV/EaL1wdP5WwQS8ZIIkWwitSgNjhfVyLAW6FrfMw==
X-Received: by 2002:a05:620a:228c:: with SMTP id o12mr1695283qkh.367.1636575302762;
        Wed, 10 Nov 2021 12:15:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m68sm396273qkb.105.2021.11.10.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/30] btrfs-progs: add on disk pointers to global tree ids
Date:   Wed, 10 Nov 2021 15:14:23 -0500
Message-Id: <80e94990528f7c02caf66e06d41e5d430b974258.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to start creating multiple sets of global trees, which at
the moment are the free space tree, csum tree, and extent tree.
Generally we will assign these at block group creation time, but Dave
would like to be able to have them per-subvolume at some point, so
reserve a slot for that as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 17216053..e54e03c4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -824,7 +824,13 @@ struct btrfs_root_item {
 	struct btrfs_timespec otime;
 	struct btrfs_timespec stime;
 	struct btrfs_timespec rtime;
-        __le64 reserved[8]; /* for future */
+
+	/*
+	 * If we want to use a specific set of fst/checksum/extent roots for
+	 * this root.
+	 */
+	__le64 global_tree_id;
+        __le64 reserved[7]; /* for future */
 } __attribute__ ((__packed__));
 
 /*
@@ -1709,6 +1715,12 @@ BTRFS_SETGET_FUNCS(block_group_flags,
 BTRFS_SETGET_STACK_FUNCS(stack_block_group_flags,
 			struct btrfs_block_group_item, flags, 64);
 
+/* extent tree v2 uses chunk_objectid for the global tree id. */
+BTRFS_SETGET_STACK_FUNCS(stack_block_group_global_tree_id,
+			 struct btrfs_block_group_item, chunk_objectid, 64);
+BTRFS_SETGET_FUNCS(block_group_global_tree_id, struct btrfs_block_group_item,
+		   chunk_objectid, 64);
+
 /* struct btrfs_free_space_info */
 BTRFS_SETGET_FUNCS(free_space_extent_count, struct btrfs_free_space_info,
 		   extent_count, 32);
-- 
2.26.3

