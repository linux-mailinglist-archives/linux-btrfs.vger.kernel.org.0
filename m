Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502AA229F68
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 20:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgGVSmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbgGVSmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 14:42:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE88C0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 11:42:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t11so1496522qvk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n7UK+jfic/++H4lXi3GbD9fGinwDuLSRfO/tJ0ecZvk=;
        b=1TNh0OVYPHAR1tvoVPMm5S+jwWnn9dyKr6Xm5hxLfat1FRk4x6n91RGTbf3bFyZQgd
         2qJ9shOo3CeB3BjaqStcD8AFFMnG3x4/46XIBrDFOAj6L9PtTenD9x3Nk184oDJQzN/t
         5EFccUCEKo5pxqOD8hIK/HySegDi9tEBq652/0qwscRqRvYwO2GhfKP4wxsgyQTJVqxE
         N4JWD1zSlONPJdmikqokwgjYTYnDT9S4Jc9uKNsg0xsZ/AVzfTopu68anE8jberRrEC9
         U2U0VNWvwEnISr1rQhjlxiNs/4DUbTCOB/Ek2yrHXVK0YAHCMTXtoJmj0IeZKw+me/gV
         W+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n7UK+jfic/++H4lXi3GbD9fGinwDuLSRfO/tJ0ecZvk=;
        b=ZA4IPsAY5QY7813TpaZyTMVEFAJEGMS98/ebzl324f4VvmfD2BRqeftIx1Tt1mnKSa
         drX6dK2PAJ3+LPFGeoJwZEtHK9fbZkLN/bKVgcmcnaIbKXw2Yy7Jyrcmxu22QZ3p0DO4
         iLLLuhdmaaDwV1D4ErlV3+YvRUK5kWnlx+cuq8O4Pw8teVhqm/FolTHhxDAFh38kVcd3
         vvktHI8I0SjG72suWMj9lPwHsOWioXzkdHI18Rpb8q+kQ7anGHko2Yj9An+PtIspn5P8
         +5nWnFV6DfUSys6p7bOl9Qsrp9Ku6uWbR5w6Jcu/39gpKr6i92IOxQA3PUl2CyT06uYN
         6sNg==
X-Gm-Message-State: AOAM530PxXVjW+qkY54vgtiK4tFd+aoGZ7b0J8LWpLcqmqGRLF9aMY3k
        lCuxNwRZuoIeAjQDr9P9zja3qdCVMrwImA==
X-Google-Smtp-Source: ABdhPJyQC6yfA4vmozwzE+1mx10io4OqLBKP5c+GOw/ElgVjY/8fNLFtjJXC7pyijxrlDx1U1SZL5g==
X-Received: by 2002:a0c:8643:: with SMTP id p61mr1401550qva.43.1595443367884;
        Wed, 22 Jul 2020 11:42:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4sm433260qtf.43.2020.07.22.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:42:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: unset left_info if it matches right_info
Date:   Wed, 22 Jul 2020 14:42:45 -0400
Message-Id: <20200722184245.19699-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The CVE referenced doesn't actually trigger the problem anymore because
of the tree-checker improvements, however the underlying issue can still
happen.

If we find a right_info, but rb_prev() is NULL, then we're the furthest
most item in the tree currently, and there will be no left_info.
However we'll still search from offset-1, which would return right_info
again which we store in left_info.  If we then free right_info we'll
have free'd left_info as well, and boom, UAF.  Instead fix this check so
that if we don't have a right_info we do the search for the left_info,
otherwise left_info comes from rb_prev or is simply NULL as it should
be.

Reference: CVE-2019-19448
Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6d961e11639e..37fd2fa1ac1f 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2298,7 +2298,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	if (right_info && rb_prev(&right_info->offset_index))
 		left_info = rb_entry(rb_prev(&right_info->offset_index),
 				     struct btrfs_free_space, offset_index);
-	else
+	else if (!right_info)
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
 	/* See try_merge_free_space() comment. */
-- 
2.24.1

