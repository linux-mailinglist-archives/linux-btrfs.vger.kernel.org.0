Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D744CA61
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhKJUSE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhKJUSE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:04 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A06C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:16 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id b17so2628280qvl.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MsHd+omzg3fLiFS+pOt2YWV8wr0jRWzNLntxMRqjGoU=;
        b=zfJtMMkeOcrXjQhBn/jt1I0SSMiU7vKIdeSpQiIYAXMbuOXd19gBbDN1eoGw5Fa8ph
         PyByE8cwdngIOvn0ndYRd4YkyBXgjGNh+FSArCgC9HbDweK/XFHtHEm+dv+2Hy6eDHXi
         5hfmNBwIGyiV1y4Zvek3g2zj47ui1xIP6owDpE4s4BTr9fVnmufFnRze/fB9f7kiKivo
         GvuMhbYUF3VueHIbhr5NtOyldrReDL2rmSz3swssQ3n5M+2JAzvCVY22xGN7MyYAJiwY
         ap3ThmNoNpT7lY9KIO7qMeZ0GYOVB05wtl9rxqBbKA1+cRlLWu5vaWT3yWKwhlMv9D8I
         OcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsHd+omzg3fLiFS+pOt2YWV8wr0jRWzNLntxMRqjGoU=;
        b=xE/GWRD19CH8RnnTKZUuvk/mBbUoFHjpEniY0sQJ9h087wdV/LVhGjj4UcUSCGiADn
         eeNXu6b8T6aLy2vZtf/YJlqE4N3WIfrDTAlhZsVOw6V0r/su2W3/CffR9DmLTKjaMCAs
         MeOxcB3ddyogNKPFeIYBIdujwO+nU2Y0DKF84/l0P/EsNnmrfJkwodHGf2JS6ksKwBy+
         EKRLeLw2ZGb6mMBvEO2HTgCMhCuAAo4hUgJqT2jEOneoQUT2YStWDut7aF1jHisjWWAD
         oEa1D/sRcvq/F+E3QCTimpdjakKjtsvb6MB4PdjTCNkvhb2eyX5eSvoNnmogwMi2OUvd
         1p6Q==
X-Gm-Message-State: AOAM533VK0JIKc1nswmyoLu5I54/vJR4egG6D1ZtPk1ki//q8kcHNZj7
        l8StdsdgfmiMU7pzBtHomVT9j7P91YP1Cg==
X-Google-Smtp-Source: ABdhPJwErUy4bfzh9IkJzAeOpJdyPzbQZEXbKl54DXkuFcWoV5u/grMBXipYKRtW6tvs99IJNGCvfw==
X-Received: by 2002:a05:6214:29ed:: with SMTP id jv13mr1578751qvb.8.1636575315140;
        Wed, 10 Nov 2021 12:15:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 139sm396790qkn.37.2021.11.10.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 19/30] btrfs-progs: qgroup-verify: scan extents based on block groups
Date:   Wed, 10 Nov 2021 15:14:31 -0500
Message-Id: <505a3728582df29d13becae5738b0edf8e879dc1.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we switch to per-block group extent roots we'll need to scan each
individual extent root.  To make this easier in the future go ahead and
use the range of the block groups to scan the extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0813b841..45007d8c 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1400,6 +1400,7 @@ static bool is_bad_qgroup(struct qgroup_count *count)
  */
 int qgroup_verify_all(struct btrfs_fs_info *info)
 {
+	struct rb_node *n;
 	int ret;
 	bool found_err = false;
 	bool skip_err = false;
@@ -1430,10 +1431,17 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 	/*
 	 * Put all extent refs into our rbtree
 	 */
-	ret = scan_extents(info, 0, ~0ULL);
-	if (ret) {
-		fprintf(stderr, "ERROR: while scanning extent tree: %d\n", ret);
-		goto out;
+	for (n = rb_first(&info->block_group_cache_tree); n; n = rb_next(n)) {
+		struct btrfs_block_group *bg;
+
+		bg = rb_entry(n, struct btrfs_block_group, cache_node);
+		ret = scan_extents(info, bg->start,
+				   bg->start + bg->length - 1);
+		if (ret) {
+			fprintf(stderr, "ERROR: while scanning extent tree: %d\n",
+				ret);
+			goto out;
+		}
 	}
 
 	ret = map_implied_refs(info);
@@ -1507,6 +1515,7 @@ static void print_subvol_info(u64 subvolid, u64 bytenr, u64 num_bytes,
 
 int print_extent_state(struct btrfs_fs_info *info, u64 subvol)
 {
+	struct rb_node *n;
 	int ret;
 
 	tree_blocks = ulist_alloc(0);
@@ -1519,10 +1528,17 @@ int print_extent_state(struct btrfs_fs_info *info, u64 subvol)
 	/*
 	 * Put all extent refs into our rbtree
 	 */
-	ret = scan_extents(info, 0, ~0ULL);
-	if (ret) {
-		fprintf(stderr, "ERROR: while scanning extent tree: %d\n", ret);
-		goto out;
+	for (n = rb_first(&info->block_group_cache_tree); n; n = rb_next(n)) {
+		struct btrfs_block_group *bg;
+
+		bg = rb_entry(n, struct btrfs_block_group, cache_node);
+		ret = scan_extents(info, bg->start,
+				   bg->start + bg->length - 1);
+		if (ret) {
+			fprintf(stderr, "ERROR: while scanning extent tree: %d\n",
+				ret);
+			goto out;
+		}
 	}
 
 	ret = map_implied_refs(info);
-- 
2.26.3

