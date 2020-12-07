Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD52D12DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLGN7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGN7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:55 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E405C08E863
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:23 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id l7so1139466qvt.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=41DzNviF+cXvKLLpMN146LL13hp9ctwVOiWwtInzkqY=;
        b=RaUVHnmA6ClrEJUQf0zcMRM1z9pCqzWrLaEFj2kgV+7VgkyKPqNaC9eF7O0pIWHE/e
         n8hJaO5ZEonnB9gDzhRk0aPVm4t8LnL8oCXbUDbvgRX3Cl9mj9IMUQiH2FmGDPaieYIJ
         8smpMeiht3b7VT2ag0dma+ZdzteJheTqL04YVlrHWVKg7hpH1Sow3HsAZ9rrIBN79oqb
         Qf4zBlJ1TEHnrL33yQqZRYxtmWDmv3XNsAaQCTUOUJ9h19HDrjn7X6n9Rn1Ax63W781v
         ajG3Z7WIJUyGUOspq6C4CZHCvYvjkSKMJhsbTb9POILVWrbTds3xlghai0jnL3qQ5ANA
         5kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41DzNviF+cXvKLLpMN146LL13hp9ctwVOiWwtInzkqY=;
        b=IM0ABlTV+742aohMXxPVuYLt1yZ8j8NTb18lLrSS3RSBschuU/gmLIZ9qamVqxjF4L
         Bu6+sAxOXD0vcszq0WfvqM9oqT0AHLTNPXyskSPLQlllz7ht4dHv/aDec6qGOsI1HWcw
         gGBvle7y2oWQiSwOc+KLpkjwo5foy7mXhhJsQVMzUa5PSU18NqYLuf2mqr4DwUhOeArC
         Pj8nG1u+QefYCnyEoK8Nv20lX4k1pb1aromPJ4ZJSJVODoHTorEns2kfe6QqQMYryXCR
         Skiy13oCIjnCmUmDpr4xHDD5JKnXc+JwPc+A9hmdJ91334twY2VfBdcEpNzL89ocTlHX
         FiGg==
X-Gm-Message-State: AOAM530TH+04LfkOiZIEVdN4GVnZpuFfujjbyBEPS3Gj7+j6+DXbuUt0
        CPf2ehnxqDcavYF9cU321lC3vwGlL6BnUT7i
X-Google-Smtp-Source: ABdhPJw0E07CCneRtasFJo4Pa4xMSIWd3h3WJXmEVP3vaatUjLjg4n9tig1f80Uiwwky7K5nW9dKYA==
X-Received: by 2002:ad4:418d:: with SMTP id e13mr309850qvp.20.1607349502083;
        Mon, 07 Dec 2020 05:58:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i7sm11393003qkl.94.2020.12.07.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 18/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Mon,  7 Dec 2020 08:57:10 -0500
Message-Id: <87e53e785f84d024e83fc2045a976d5148a447f5.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2f8bb8405ac6..bcbae8b460c0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9205,8 +9205,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	ret = btrfs_set_inode_index(BTRFS_I(new_dir), &index);
 	if (ret)
-- 
2.26.2

