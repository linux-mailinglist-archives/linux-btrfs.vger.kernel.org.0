Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158733985E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhCLU0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhCLU0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:35 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF5C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:35 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 94so4838007qtc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N7PFobv7GOoDGWrv7ZgloXVvkkOJbiEbbF/Z7e/aCP4=;
        b=Cu9m1IgikktpZ722y8eIVZvXEEkLneUKylIXEKh9MRIxR6130VeAyQRwq+ZVi/c8q/
         ZeAdGICu1Kx0zzzObNVjmlJALePMH/fqKGntqRaxvmYrg6cCcHH/coxxGnWeOJqn/F4t
         XA1/ztseYbCCAc1G7W8npCvGLvDOp0l7XiosycjFXgtDcj/oX2HtrWpqr0cajVRlHRwB
         n+RxcV/1pUsjrJDp/Vtmz8VLPKuM2vf790vC5N/0thPi2edk8m4KChgBRCDAFvgLi7EH
         eXRtgJVvVpNjqB0xVkQqQVx9QLyu4dkKSHQl39ohNLRaBMNVUCQG0B3JzP5p29D7hZ/a
         U4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7PFobv7GOoDGWrv7ZgloXVvkkOJbiEbbF/Z7e/aCP4=;
        b=cYAwzHDTdKdq0HiBSxXZYjpx2etTNuOqF+hEO7Gki/keyjgMUaE2B8iFuxS8aPRwn/
         owSwzwdys1IuwRKO/ePZ7uTpkPCI2E9y4EQFv8KbwZ1igzbFNH9gFQhfzl3vojEYR74l
         519ZaReRzFaVqn8M+aZGKlDg4toQutD6OEDBYWrJ84mBEJkHRwT8zwiO25dgaaAGQgZN
         yZJa50kqkD3FsY+oub4JNxZHTwZ4Efe0rO3OHT0trdhqoYmBln+Y6hU06bXdtiK6eV/7
         Nt6WHi38MbXj+l7H7RcaI3Oh8NsV3dVXIGoCdTtYpQVubIROieL2JEsR5NhgJ4UBGkuA
         t9vQ==
X-Gm-Message-State: AOAM531Sl3BnbwdR8SERx90Xhwm6hVmsX1RVi/ZIe+pZFfEDsxtYKj57
        DyndL64gaCXM1wpdtvmN/ea1h580StTVutaC
X-Google-Smtp-Source: ABdhPJxMOBjORYk+C2XIxCPb/UmY01j/vwe7DxuhX5DQ7+gfSdQZUzBl1dOukcHIPM/PAHC+PdG2FQ==
X-Received: by 2002:ac8:4e51:: with SMTP id e17mr11658347qtw.204.1615580794522;
        Fri, 12 Mar 2021 12:26:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a11sm4699893qti.22.2021.03.12.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 38/39] btrfs: do proper error handling in merge_reloc_roots
Date:   Fri, 12 Mar 2021 15:25:33 -0500
Message-Id: <23538f3428180bd62d67d961a93822dcff3677d9.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 621c4284d158..557d4f09ce7f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1960,8 +1960,29 @@ void merge_reloc_roots(struct reloc_control *rc)
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

