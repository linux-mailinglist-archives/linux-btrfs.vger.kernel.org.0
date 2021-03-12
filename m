Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1B33983A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhCLU0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhCLUZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:47 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313C2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:47 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id i15so4896745qvr.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i2amck6xZdrsQXUWDvpt+mTCzs5n8YBqBaTJc1sKZog=;
        b=ktTsLulKa2+co7T8k7CWlu1IbnmBWwGVkw+zFhLyxSIi9wS/LHfZSiQKW/XenI8RWk
         dve5W11Ly2em03yAEAXSbr3pgSgHrDXEAHO1nYV0ciHDfuxR3FFIkb68R/JTmU9YyD5d
         eD0vO7Q1Kul91Ii3L/rTowavOwXMs8tG2/suYAvvxqKgXS9ejJAErLyyImVmJ4nUihae
         Y955IDk2YE8f+5q+48D5nXHC8S280RgDUhJiC1iTKdq6AwqeuG32Kbya6L4NfnlcuiV6
         wLFb3+vLed2pnBgr7ppbsixsjDj42tpWS0tSH97kLD9xiQa2EanE8S+E0j/CwD3GU9l9
         X+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2amck6xZdrsQXUWDvpt+mTCzs5n8YBqBaTJc1sKZog=;
        b=Ch5P48mEqIsZTvwuJjA7dLB1aMC1I9nD9RZXwlNzzLuw8aBfKSvS1zYpbMw0hgND3e
         M7I3H6Y7FbxhOKf/KAIjDYW1L9JXqjX/Q/0Z8430WncZP3lFipSQixYZ2vytkr/OdziW
         5UEy587fM+2OVvYrx7ZMQtSQyPiRJeKkNp0tOBfyU7HqdL/unuIqQh12Y4MPilWdrNn0
         j7q8V+mAE4vMS3yxZfQlq+YL8+oHQEHhgzUegjGR9CU/QlF+GMWNX2lOYyYX34BwqEmk
         xahsnSHjn5mfF7A+f85U5WSrg+vC/iviiMCyRMbC8glPvZGiQ5oXWilx1R5/9OjIr7FB
         FFfQ==
X-Gm-Message-State: AOAM53386TyMMhUvVqI9/19P/WhCoKSiS+svY7MV1csSRW201lf0Lcxj
        TqKf1kIftPAGArIRJr1jcVg45glaDYqSN/kR
X-Google-Smtp-Source: ABdhPJwEcGuw19ba1RGsuYLLeBmHyqZtOw28hlnvVDGGWpwnRUb/XameIIazW+B2+N0Dw2v9vDdTOw==
X-Received: by 2002:ad4:4cca:: with SMTP id i10mr14062298qvz.49.1615580745674;
        Fri, 12 Mar 2021 12:25:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d23sm5131220qka.125.2021.03.12.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 06/39] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Fri, 12 Mar 2021 15:25:01 -0500
Message-Id: <7ff494825bd0a0b4b67f00c761579c8b8d3c02c5.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally speaking this shouldn't ever fail, the corresponding fs root
for the reloc root will already be in memory, so we won't get -ENOMEM
here.

However if there is no corresponding root for the reloc root then we
could get -ENOMEM when we try to allocate it or we could get -ENOENT
when we look it up and see that it doesn't exist.

Convert these BUG_ON()'s into ASSERT()'s + proper error handling for the
case of corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b70a666612a7..28d49b14a23a 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1971,8 +1971,27 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
-	BUG_ON(IS_ERR(root));
-	BUG_ON(root->reloc_root != reloc_root);
+
+	/*
+	 * This should succeed, since we can't have a reloc root without having
+	 * already looked up the actual root and created the reloc root for this
+	 * root.
+	 *
+	 * However if there's some sort of corruption where we have a ref to a
+	 * reloc root without a corresponding root this could return -ENOENT.
+	 */
+	if (IS_ERR(root)) {
+		ASSERT(0);
+		return PTR_ERR(root);
+	}
+	if (root->reloc_root != reloc_root) {
+		ASSERT(0);
+		btrfs_err(fs_info,
+			  "root %llu has two reloc roots associated with it",
+			  reloc_root->root_key.offset);
+		btrfs_put_root(root);
+		return -EUCLEAN;
+	}
 	ret = btrfs_record_root_in_trans(trans, root);
 	btrfs_put_root(root);
 
-- 
2.26.2

