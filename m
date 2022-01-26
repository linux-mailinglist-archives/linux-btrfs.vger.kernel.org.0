Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60F49D3E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiAZUzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiAZUzP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:55:15 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D6C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 12:55:15 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v5so782358qto.7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 12:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hjga/oK1u4sxDzWE2mPh2dTfIsnKzCmH25GEAzFPFM=;
        b=q+4mKc1T4bh+ja8tUp6TDt1WK6QrkoOfZENJjqDgoB/IaXFTfGcTKLJ7enUhbSngOS
         CcCZxYCYJ1G3pBrJTTGk6ta62KWobKHE7mCgFy3g6JLkzVWOmQ0NJZccCH1nlSrJDV52
         5fFd7hdadzmWI7NyIICWmmB4FMhu9hd60YvUDevO0MT5WwbVptzGuncQPqw4EtkBegbT
         Ci2O7A1th4KhUNrF8L3OCzpA7L7n9djKGvOp6HCKrjf2TTy5mWJwXq41cedeFCndYId+
         ADz1Q//xhR1tmpNzfoLkxhjFyClN9f6fKCC2e4rs/q+2gyM8fGzKOPXZBdSNvDVCHByT
         dsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hjga/oK1u4sxDzWE2mPh2dTfIsnKzCmH25GEAzFPFM=;
        b=AV7ToAW7BOFFrlrhd+cCs96N/+KKlDz6FmYN7E7nl8DOHHDivU3O5tURIIJkxLCufQ
         q7zVeX6LZcNmnHKx5GIYWbhlDCFpz0aJnjEVCkLkXA0DcuFxFjfAip6xzruOZXlmINf6
         Kg4gyW5WJ0D/uX1Dgk0DjX/VF9tNhDFMtcd5RFnTBQmMIco5F8LeYGXQdB4BZeOlJ0/r
         JhJldRDXlvULVctlAGIQsyaFwObi0bXNdOwEQB5gmnO8CEwoABh/8X3lJiRnkc6G+GVA
         Tc8Udr6/+z5grO9u24FYfHagf1v3eZPEIqMFzjrF7z476gpOA3wISKeXLX0UhktW9A4o
         95pA==
X-Gm-Message-State: AOAM533CohU+h8E3vKFsQIbazt9Lt0rZ+Ly9+I4shi84ivefdqfxYTm9
        W3ETc7IoJ756Y1hdhp5imqOBnkalxiDR2A==
X-Google-Smtp-Source: ABdhPJwYpOv1aBX/lNNY8nfUJz6jZt8sS5RFO/DDd5mqdYixb+cLIy4+AJGkJIcuAqbzz64a2/gxiw==
X-Received: by 2002:a05:622a:148e:: with SMTP id t14mr450180qtx.152.1643230514564;
        Wed, 26 Jan 2022 12:55:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d6sm199639qtb.55.2022.01.26.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:55:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix 64bit mod compile error
Date:   Wed, 26 Jan 2022 15:55:12 -0500
Message-Id: <139a265095afb1b3103d58bd3c8e19a89014db13.1643230494.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernelbuild test bot complained about a 64bit % operation in the patch

btrfs: add support for multiple global roots

Fix this using div64_u64_rem.  This can be folded in to the original
patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 4c793b87adc3..3113f6d7f335 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2452,6 +2452,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
 {
 	u64 div = SZ_1G;
+	u64 index;
 
 	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
 		return BTRFS_FIRST_CHUNK_TREE_OBJECTID;
@@ -2460,7 +2461,9 @@ static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
 	if (btrfs_super_total_bytes(fs_info->super_copy) <= (SZ_1G * 10ULL))
 		div = SZ_128M;
 
-	return (div_u64(offset, div) % fs_info->nr_global_roots);
+	offset = div64_u64(offset, div);
+	div64_u64_rem(offset, fs_info->nr_global_roots, &index);
+	return index;
 }
 
 struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,
-- 
2.26.3

