Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1A43E91A
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJ1TxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhJ1TxI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 15:53:08 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5EAC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id v17so6939045qtp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZhE0WDidkgjD/VYVZAoc6Tgasuc5WBjQ+0QjfMw719E=;
        b=r+n7jSrUwS+8z7RYHctAUt5m8EcszoSlZN+1OdSL+3vlFq8i8iXsCsGffWSYW1r7TX
         jkzC/6s6jKFVH6jFELlVYefFlCkxaAQi7OgCNyta3GEtcuGANC/T6iLduFZOiS4RDwpy
         x3wxoiFH7bX2jaItYZqLOvHRUZkqkBFhqQm3KvszcdOGVmU+SLnXxO+UwSeLdXJxRUb7
         sQXvapGMfb1TvB2J0a/RJZS+KzkNVOuq9IHyrShGs/Hz3HIpMB/z+NneOVpEPTKiBIhU
         lJ9PMSJFnqAnfWfwzhcNRYL9YGON1Xkts0fNIHWgZ8Lp0/y9v/zVxyHh0y0BhS5mq+gX
         tohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhE0WDidkgjD/VYVZAoc6Tgasuc5WBjQ+0QjfMw719E=;
        b=HANH/hZ79Bdxi0AcqmOUURGSmrJQWSyRuM71JJ/Z5/SS1gGkmLZ1Pc4wh0nLZqVsTf
         SaO3glcv4Qu4h0SlCEld1ur2ogRen/VRVNdIc9vjOnEKHte53BSbEgCc+HPbhEisytHX
         FZqz0HDiiuLvmiYt7mfp/53bSQDSXEEIaYcgdqhONAFl3mkqHSkU1JkXqB7pDCPCtkCC
         BPia23pezhUXd9kvtafTqyrZfL//H8+7g507zW/VgNeC2lBbS7OvECcPe2V4gHlvjis1
         eyxEnpYujVQXdgZaJH2P1JASMxy5whLJ9gCnykWrxTJnOY+JDEavHVBnoLEYvIlfu0Mv
         B9LQ==
X-Gm-Message-State: AOAM532WVxJxeZumo/6GckowFjXUKFe28q4r4OHeqSq78yp2e3JdumzK
        OX9wbxzkcgJNLJej3XH00fC94PeCYTTjqA==
X-Google-Smtp-Source: ABdhPJyuEzx1ydMeif0IUzCuMltk+1xqyy2O2NBt6xb8jldifxxfYA/4HIyhafpp2Gisqea9/OIauw==
X-Received: by 2002:a05:622a:310:: with SMTP id q16mr7073243qtw.10.1635450640183;
        Thu, 28 Oct 2021 12:50:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u11sm2750282qko.119.2021.10.28.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:50:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: remove global rsv stealing logic for orphan cleanup
Date:   Thu, 28 Oct 2021 15:50:34 -0400
Message-Id: <58f93c86b8adad28df72e11b9ff660b597551bf1.1635450288.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1635450288.git.josef@toxicpanda.com>
References: <cover.1635450288.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is very old code before we were stealing from the global reserve
during evict.  We have proper ways to steal from the global reserve
while we're evicting, so rip out this code as it's no longer necessary.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c548d34aed28..25579b772639 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1607,16 +1607,9 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 				 enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
 	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes, flush);
-	if (ret == -ENOSPC &&
-	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
-		if (block_rsv != global_rsv &&
-		    !btrfs_block_rsv_use_bytes(global_rsv, orig_bytes))
-			ret = 0;
-	}
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      block_rsv->space_info->flags,
-- 
2.26.3

