Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487AE2D12F3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgLGOAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbgLGOAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:13 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6D0C061A51
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:20 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id x25so12515410qkj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VBqQlKo+y28HzS2kFjKmlnG3P9jtMBKWYu1T6njenUY=;
        b=PvA+vs3MTeGNcsmPWJ/N+92Ikf2kJyIpIn8S5PQ+I16yJhGrvQFb5mF8zLpOrMi72I
         s5LTTygaDH6i1bPurs2K05/yJrwvc05wJaXilTjsmVnh1xlXqJX0D4blcxBKLXcoLXtJ
         kxhN5PS5j84otkD/r4aeYuDM6pdBIMFK/Wuqgvgc1qzGthkWz4w6NHman2+n1IMqhqWQ
         hf4zbNXWONHKIljfbl4c7ScomjrnROTgqnF2kfuvZY8ZfaldSiXM1X3OSulWsXEDeWsD
         KW3TwCqTqmp4RdKl5/lZax7JKaRVEzJPjHI8b5rOPUpY99g5K8NElVqedW66dCq2Aup0
         Vecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VBqQlKo+y28HzS2kFjKmlnG3P9jtMBKWYu1T6njenUY=;
        b=lV9cKeURgZj6EitI0Rp948yi0qekrLU8tuQH5F589LLU8/XOwCCOUs2qGjZIgBLAE7
         KofS9tHUQ0fYh4+BNjXFvTF/b8k2+q8L22vS5vPaBxCloQvEOjsysQ8a/oMS9M28OknE
         VPTu8ggLLT4/F2EGXDIi2kGyqTANm6pakdhiMbtfi+BBRTgr/FEb3ZrfvoJw4Gauy85C
         ogNlCwiAw1e3DwHQmV+PLAuYcJuz2Q2kFdRXc0fhhubgxtazKI9MM+rFSI3wZCYgcCM9
         3Hh3fdRtWcMBRd/HABvB/KFzpQ7ByaNxF5RSdVHImRnlcpIMR8rkzOMlupGFbxNDvPie
         011g==
X-Gm-Message-State: AOAM530hKKbv39hLiJLZIjciEsimUlUXJQr8mJFCOdLBRZBGBVYDIKSm
        FEs3xmq+lbrhF08Smmn/moEGMmFr+v2/dJrY
X-Google-Smtp-Source: ABdhPJx5tX0EV5kVcPEw7WtBcuNTaJsOxytDdsChMCFJzhMuOkzAZ+16un3V1gIcpDcb+BRh4o51SQ==
X-Received: by 2002:a37:bbc2:: with SMTP id l185mr9957771qkf.379.1607349558732;
        Mon, 07 Dec 2020 05:59:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 84sm2879748qkd.46.2020.12.07.05.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 48/52] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Mon,  7 Dec 2020 08:57:40 -0500
Message-Id: <ca914135742ad49d4325ea2248e589a261f98c46.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1b0309f538f8..61b0931c8ad1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1905,7 +1905,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3442,8 +3442,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3602,7 +3601,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2

