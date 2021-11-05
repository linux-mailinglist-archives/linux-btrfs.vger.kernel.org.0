Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C054469D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhKEUnk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhKEUnj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:39 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08CFC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:59 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g25so8025122qvf.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KNkMciKNt/whslgMekzPaIvfMEwa+U3L0W4rFrYFXc4=;
        b=GCXTXk+U7vgTVifJvLJ5J7+4WyIhRnW49iLN28P/Fsn+gSuYXwIbDT6d95HF3+NMBf
         EvQEdsrLVCUKbeIErjpSlfdKdevC/xkTAXHMSsY37jhbT/idcFJBO+F4ZXe4GPqsjs96
         ZyS7L9JzuIb1ij9ablF4qLpyeJUWTYrZnn1dUstRnklbYATiexnrv9OqDeaweXdwR8oq
         yiDinz+/zB2DE8UkW3uGj1cGu7GHQ6PdgyoCJNe0kUo2Nf0Rbghf+JFWC8iOplfvV6YU
         aw81iZFGmPJW8qKb0WlA7DZYJunfsU4y3v06qS/KiGPYBw9C5v1TRkh61LwGOYePMqBA
         cW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNkMciKNt/whslgMekzPaIvfMEwa+U3L0W4rFrYFXc4=;
        b=VB6fCwPDLqiCyHFHIARjTMkrK0kEOpoTPVDY/5xh9TKEH5+TS3w9qitB8AyjgIPG1E
         5YQ9Y4DzEZbFM7yhjO7/ldqch1yD0xp9BBHtjhNB7Mn0lG6V7CCGvQUfuGZzsJpPcM3r
         4nsQfoXDoRda4DracAWWEIukRRwCN4ORAwQHW7vZiWt86DU9e6yuCcqgeUoDGGpxR588
         oZAnKguhwp+43CVkMAYHNvdlRQUAXiVLP7O0+AHpbYEc0Rv8aF7iqSVJaIDwMXwkt8Ik
         D36ZVUB7pzS/D/ijf3ljXg2P1QJmDj6pCmQ4YMaKs12cL7t4kLnJ5OMTghfTtpHb3Cp6
         YGrQ==
X-Gm-Message-State: AOAM532IoC71ykIElfJMG41L7P6fHvW8LeEJ7U+YZ2tQKs+4z3M1oy1Z
        w+iHqS4jg87TkJzOYlh9QxT6uXrXRbSayA==
X-Google-Smtp-Source: ABdhPJxt5+HOWeMVo/eYPd4ZUpY68D99McrYsZBU8b9fHFc81sI1+vknOA0G6ZG+sCIXWls/OyKOhg==
X-Received: by 2002:ad4:5bc4:: with SMTP id t4mr1502151qvt.3.1636144858670;
        Fri, 05 Nov 2021 13:40:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v18sm6816202qkp.129.2021.11.05.13.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/22] btrfs-progs: check-lowmem: use the btrfs_block_group_root helper
Date:   Fri,  5 Nov 2021 16:40:33 -0400
Message-Id: <b1a98e58bcc1dad11aa2fd7c8f9c195284343989.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we're messing with block group items use the
btrfs_block_group_root() helper to get the correct root to search, and
this will do the right thing based on the file system flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index cc6773cd..263b56d1 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -266,7 +266,7 @@ static int modify_block_group_cache(struct btrfs_block_group *block_group, int c
  */
 static int modify_block_groups_cache(u64 flags, int cache)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_key key;
 	struct btrfs_path path;
 	struct btrfs_block_group *bg_cache;
@@ -331,7 +331,7 @@ static int clear_block_groups_full(u64 flags)
 static int create_chunk_and_block_group(u64 flags, u64 *start, u64 *nbytes)
 {
 	struct btrfs_trans_handle *trans;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	int ret;
 
 	if ((flags & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0)
@@ -419,7 +419,7 @@ static int is_chunk_almost_full(u64 start)
 {
 	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item *bi;
 	struct btrfs_block_group_item bg_item;
 	struct extent_buffer *eb;
@@ -4591,7 +4591,7 @@ next:
 static int find_block_group_item(struct btrfs_path *path, u64 bytenr, u64 len,
 				 u64 type)
 {
-	struct btrfs_root *root = btrfs_extent_root(gfs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(gfs_info);
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
 	int ret;
-- 
2.26.3

