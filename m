Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11D69184B59
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCMPo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:44:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42982 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCMPo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:44:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id g16so7837946qtp.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=usB50WR/Edm48JN68lsnmBnKkhKLOjJoGtCIpKn3Uyk=;
        b=IXAH/J/S0F8e2g358KJnrfspCLxfNYdsfNd0IilrGRzN4nCD9UEV1unkRqAjZUaxKb
         yRTCSe3gXCfzB15gmfkpOrQWGSWjZUPOcLCCjNdXc3Awe/tUZGLErNKXTdzUArBBT13j
         hz8cZ0nPKluz9bSfXuQ/p00NxprcskgPqFY6Fw6nB22mH0C8W6FjZSnSFAHMJXhiY8uF
         6c3FXhT0IafOicmGspWIE+42feqVWtrRQBDUGiIVTJ45G/BMlonu4/V4epTNiiSlU6wk
         T+CzAGcXkTjclzhGdjNRJC3NuVbQh0ceMmJ549w4DkxeY+FVkMVoBbu6ENSsBagZVGgH
         ucIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usB50WR/Edm48JN68lsnmBnKkhKLOjJoGtCIpKn3Uyk=;
        b=NCU7xwd2pI64CU4C9+gYxDcK4o3GdMkkM2E36nFCur9Las/rbrd29Sk0jKYRVBdPKq
         3idpIrZbPrn4xoP/Zas0zTMvsDmZu1RiXBN+lAcYuGrWW1P/cbkb7Nub8EFSepBDLA0R
         xvxLuvxaNmyS+aAY3HMV8lJcMtBxy5shd72PCq5aKB4McAcxTSarbN0+mvkb1+RloJWw
         JXj4FAxiSl4yxD93dIC5iKOdQCUeNdBmJtNVxwga53MwC7hvzqwPVMOH7xtOKtgxVcPP
         FrmYXpC6bPqGSA7p5MMQPjTpwbL0mrX4/bVnyhhcMfNX45oXjy927yK93px/CJ+w8iRk
         XVRA==
X-Gm-Message-State: ANhLgQ2oTdDNCy8uFMPmYLzAc26XJBydGFBqjcplcpHxgyghkIbTK4xF
        zeZAZO+Mfzm5bUgt1gfIPi7oCFTaBZo=
X-Google-Smtp-Source: ADFU+vsKaCmHw1ZcPd6HNABU8wltQkWW6ImMjz8E4wOWZAMT66N0sgXp5sEJJ1eWvFBQ8HjMgZsEAA==
X-Received: by 2002:ac8:6043:: with SMTP id k3mr13425384qtm.336.1584114296699;
        Fri, 13 Mar 2020 08:44:56 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z9sm11148340qtu.20.2020.03.13.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:44:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 3/8] btrfs: unset reloc control if we fail to recover
Date:   Fri, 13 Mar 2020 11:44:43 -0400
Message-Id: <20200313154448.53461-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to load an fs root, or fail to start a transaction we can
bail without unsetting the reloc control, which leads to problems later
when we free the reloc control but still have it attached to the file
system.

In the normal path we'll end up calling unset_reloc_control() twice, but
all it does is set fs_info->reloc_control = NULL, and we can only have
one balance at a time so it's not racey.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2141519a9dd0..c496f8ed8c7e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4657,9 +4657,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		unset_reloc_control(rc);
 		err = PTR_ERR(trans);
-		goto out_free;
+		goto out_unset;
 	}
 
 	rc->merge_reloc_tree = 1;
@@ -4679,7 +4678,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
-			goto out_free;
+			goto out_unset;
 		}
 
 		err = __add_reloc_root(reloc_root);
@@ -4690,7 +4689,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	err = btrfs_commit_transaction(trans);
 	if (err)
-		goto out_free;
+		goto out_unset;
 
 	merge_reloc_roots(rc);
 
@@ -4706,6 +4705,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
+out_unset:
+	unset_reloc_control(rc);
 out_free:
 	kfree(rc);
 out:
-- 
2.24.1

