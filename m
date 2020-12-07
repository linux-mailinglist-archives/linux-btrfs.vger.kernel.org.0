Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60D62D12F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgLGOAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLGOAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:13 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D5C061A54
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:17 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id l7so9361971qtp.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tx0bw7iAiZ+XpoU64UedJPe/xnIcNadhED1vRBh9COA=;
        b=IHhQ9oMcdKC35i/XANWWZM4cdqPXjueedjyF+v2ipASlXNouHvuuNd6i3H8Cyj4S1h
         Or+RxIWPwgC03z/ajdOsRD2ojPIGvdWyt2Xsd6ftIW345+AsauCUMP5niqc9EJnqipKZ
         jdqDViBGARFcLa49I10MJYXRXzsMpeouHY4NqJETku7lDgjd0TmXJx6ycY/RY9qRQkRR
         VNm2jKSQmwlYZSi1U3fHpbLbSNav07sawq7aFtMIP5CnmJn1Ef7VM93zirpXg1svu+A8
         oNIwDRkZQrelpfCToM3iRpbMKeKhQ82Add/SYluO2pTWO7IM+kaGO6j243twGt38E4oz
         CUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tx0bw7iAiZ+XpoU64UedJPe/xnIcNadhED1vRBh9COA=;
        b=ePWYznLxRl+Nu/XZegmqU4pJiOIpV8ocXlhnaZuiypfjNOrbakfHhU7tb9rz9J/PNL
         ykPmd0cQjhyv46WVKVLjSTzmz4OZw10tqiCdTXBkmxxI/JUc2HFtTO87Frap8qY8KcFZ
         WAdSqgHsDJKqmafoafRzSzxwPZej1nI02nncTK1PdDkmk4rF4e69y9cEehJXy+HAoU67
         IQ9j6Yx65GDbfhAaAevXK4jTfEh7ZSjS024rw8GL6OrLXRLP5mBw41UlAkhk5RiRSfCX
         WVSOLAqF2PWkgqKEDnuf1EgkyRNnaHpD9c9Of+dPvqUa4WYyw6or2Uh/TldeF3AJKsqZ
         bs9Q==
X-Gm-Message-State: AOAM530ED8KwAslPqhAKFXm+8WNkO11ZPYlQRqZqM4XJpCY3u/JGA1Ft
        yDNd66To6jweQhDEtS5qxmcBXeobLR61e/Qr
X-Google-Smtp-Source: ABdhPJwEZB9wkSR0fKfa0AG4CrjbahaM4hJ5iepRZ+2MK0kXVu2UXxpBuArcRoMRGFAPT6Dx5GGoNQ==
X-Received: by 2002:ac8:74d4:: with SMTP id j20mr6760958qtr.101.1607349556873;
        Mon, 07 Dec 2020 05:59:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h1sm10469293qtr.1.2020.12.07.05.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 47/52] btrfs: do proper error handling in merge_reloc_roots
Date:   Mon,  7 Dec 2020 08:57:39 -0500
Message-Id: <109de73b99945ba05c65dbcc3fc796a322e40ddb.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove these and handle
the error condition properly, ASSERT()'ing for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 511cb7c31328..1b0309f538f8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1950,8 +1950,29 @@ void merge_reloc_roots(struct reloc_control *rc)
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			if (IS_ERR(root)) {
+				/*
+				 * For recovery we read the fs roots on mount,
+				 * and if we didn't find the root then we marked
+				 * the reloc root as a garbage root.  For normal
+				 * relocation obviously the root should exist in
+				 * memory.  However there's no reason we can't
+				 * handle the error properly here just in case.
+				 */
+				ASSERT(0);
+				ret = PTR_ERR(root);
+				goto out;
+			}
+			if (root->reloc_root != reloc_root) {
+				/*
+				 * This is actually impossible without something
+				 * going really wrong (like weird race condition
+				 * or cosmic rays).
+				 */
+				ASSERT(0);
+				ret = -EINVAL;
+				goto out;
+			}
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2

