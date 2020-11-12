Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C701E2B100A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgKLVUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgKLVUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:09 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E80C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:09 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b16so4982463qtb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WLaG2lMVEp53Y+M2Z+ny+Ml2k4g38fw1Jjg+mofShrQ=;
        b=tPCp8IsMiwYEPeGyJ280JTRzwsjAP+ElorxmG9otviNsjpN3Q7Nc8mggp9jyz9H0bu
         AJ2zLG1wxPHdtMTaP+jZDqOeviuPeIjY7EOhrR8jVgqoGUfdI005H2oG56FySzfx+5sr
         xBr3bHl6EzrbaoPFds5DfhUQ2NDReMnPpt8wZR1FuHTdR5z97DtWKG0v3WFPxCDiFFzd
         EYngJoDDEHPW0rLMx3sREtks0fhfd2rZVOtq5xEx9tcSRb5vZWeUIo8LcXQ4WiumVDor
         nvcYgzMOkEzZ0Nv6/FmYeT7AtXR3DJgXn0S/FAiSKMELo2JL2jHo9THOuG0Ra8rZS5TD
         449g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLaG2lMVEp53Y+M2Z+ny+Ml2k4g38fw1Jjg+mofShrQ=;
        b=D82n6KfP52YkaEcLNxRtMoxEXmYbH2A9vdZG9bhMeawEF5nXwfWqqIkMd14o6+0zvQ
         ijS0YlMbNPDsNZx/OdHUp25fZRtIP/qSL3c9VbQ3SXmvUN+4CATw9lQO85UwbwiCBPnU
         jf7GiFBNIQI2mMpaZs5NVFDZlNKEl76tXgMyW32zP3CHEXComdj1OAmlGZlhCN721rFA
         Vj94RJSEkWtcM/tGgeeHGlP2gEhItKsYTahNDfYT6agQl3VUmzrzPdpzFKVz5d8Yc0PQ
         /XVbKFlY6FPG/rNDtlOpoDgQMvShOnu03Q8MkXQ2X/qpVvmjnLtLyhStNkW5MUvHRiPe
         V7gQ==
X-Gm-Message-State: AOAM531K/M8+Z+jU0pCNtb70eRS64Ky9MWOGGKB/eZbpAqp2a5JU8e6d
        +9JncIPL0n4OnNLixQUJpbS3XrlNYNQ93w==
X-Google-Smtp-Source: ABdhPJyctm+BZojQCF5vMpxfwCaAFHhfkrElOYGzDDHgMjAQpl2+cgasExBiRdKzk0pLr1RcyBm8FQ==
X-Received: by 2002:aed:22ab:: with SMTP id p40mr1182143qtc.200.1605216008068;
        Thu, 12 Nov 2020 13:20:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm5591592qkm.62.2020.11.12.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/42] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Thu, 12 Nov 2020 16:18:55 -0500
Message-Id: <20fb7e0108f8cb6d7c1704afb1a430d087754f30.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 04a0eb2d434c..2d1aab778fb6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1202,8 +1202,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1236,7 +1236,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		struct btrfs_key first_key;
 
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

