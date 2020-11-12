Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540DE2B1009
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgKLVUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgKLVUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:07 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842AC0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:07 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so6893238qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/PV80ZRYhMtwulzYtMH59nNCcl8hb6n+7ulDXREEkZI=;
        b=lbfyIvDYeNqGimc/wxiQVG223HGeRanXFB/J/q8+OwfYaH+EmMjT5CFolXNbe57S4J
         ONgKV02CPoWMD18ivaoXknvBZhEksktD3yRyV0EyPCSmx7Crqq6pb+oyb430OhwkEd/z
         k25s6lsqQwxaeflx5kifYDGyQxMAJ9zanrlSl3YDaHCIswjfao/ntDmV9q4ljhgWrko0
         eXxoS8viV4B6NimKX4lIovOiYRF6vqJFmSiFPcZPVuTd+VWChNdJCf5KgwA0SZ/hedNS
         UtxGFm7KZPopIiNqHc2nUry7A+FVwpeJ53zZnW/uGztBORRCAtk6RPXT67BS7njvfcfP
         t5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PV80ZRYhMtwulzYtMH59nNCcl8hb6n+7ulDXREEkZI=;
        b=LVWiGGvMFUslu8Zibxr6zsIM+UuKolKbZWdUVfN/qPIfYHo/jPja5v1BiGvit72Bh4
         hcD3+PSe/HrLMIM2NEhXySOszp1Qf5KRblAN37x8q4m9RT8gqv2SbgUxORxKxTKD2IFw
         zLLAjIl1z+IyMICcvpN7sDEVnspTq/3z+dVnLKHME3WoBINv0Rkpci3GDJd24y5H3s0R
         cGZSxASeP/gsXZCIFS474nwKp9eUXQG+nrDhDdiJYlyOfJx7kXHPGzDZ+8sjvbMlFnEl
         7j3Sg/uVK4I22rURKVQUEDqgt/cmZoRhmJX7ZABTGjXIrpTiHYmYbSB94wE3+6nog5Uu
         dCEQ==
X-Gm-Message-State: AOAM533+ELyYIyXdRfmDhhkwEhdWYD+TX4T9ZFxAsuXCGHidoc1N+44y
        d+ZEDZENYFxEvl4aBFLINaPWiyV8fkKoWw==
X-Google-Smtp-Source: ABdhPJzUN44KHbdTmDx4bHxBkeLwABWpBF+MBiSBTP9T6qrVJtAQ0IWRBaMISRdABVjeyXETuvK8fw==
X-Received: by 2002:a37:9a07:: with SMTP id c7mr1780755qke.43.1605216006052;
        Thu, 12 Nov 2020 13:20:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x24sm1397305qkx.23.2020.11.12.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/42] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Thu, 12 Nov 2020 16:18:54 -0500
Message-Id: <1624573650c14c23e2cb56771495a99ff292eb94.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0daa4e671182..04a0eb2d434c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -894,7 +894,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -927,10 +927,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
-	BUG_ON(ret);
 	btrfs_put_root(reloc_root);
-out:
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.26.2

