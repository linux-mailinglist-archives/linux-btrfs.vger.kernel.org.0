Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E352B1007
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgKLVUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgKLVUF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:05 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A6C0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:05 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id i12so5237076qtj.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=thkBblNH0qPlbpRUoRc2ja03JpZhQJ97MjPnBXzAA7M=;
        b=hBmqc1j92PTLdXXMJjM7vMwGwWDpH9lVuyWb3FCGTfj7b5LcIxJpb8AqBFOMlnOklb
         8s9DgYqzqge6chzu/HaAjQeAWx5yBU10EWRevTs5fUIYGUfaDdSs320vF7LAOpMCD3Dn
         /MPq1NU4sZj7362ZLb3YQg9GTZlpLWsXerWWwR0tzsVvESTjqsoFd3Jt5FmlsavT5z3u
         /w2ybnf6RCkhmBc4TV1dL6/hCLYq8ci7Fln7Nm/TurIj8YDQ28hm+ilb1N237FSFRk+G
         nEnhlIq9pdIWQm2wDl0tdIoQO+K+WiswD2hjgvL1Yq2czDsYfRHtd8c24S++9ZZcffUM
         uYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thkBblNH0qPlbpRUoRc2ja03JpZhQJ97MjPnBXzAA7M=;
        b=Tu07T0nFc5uIloJHZ8tMOIy5y7rRVnpQ7wVOBDfXQ/2GzW9dHPsEjRf7DD0l25Qjog
         uRgi7qgW22UXK9lwvbmizlm34Qw+CNTof+nE7K4fmri29X963fNTU+osHdCG5IGjVNSf
         f1m5F78wane8bOIUaULgQooTBLG5O5C0OYBG03N0JB0Da3pcKA/EA/rOkor1NKvcpso8
         +XD7jqtp0s7ccvxy7hA1g6qft6eg87UMFsKXQbipBnbtHBpyHoAEMnktLPNWp2fg84Wc
         eatuRYPs/b7fRtHdy0EwptTTxrjgt4usznlNXzVLtn96Lnb2TyVxd/a8YvO/Rr1zXdw8
         ebvw==
X-Gm-Message-State: AOAM533OA5GPoKI+ErsVbaIjDgbhVs1jAxXTcNEdkn1b1d2tFwsWeNWT
        xDolDdCTSZFSAHXdnzF4ZL7tcKvyyX5xPA==
X-Google-Smtp-Source: ABdhPJxv2rq/0eeQWsOyD3tGDzXpsSD6VH9XkDtzJ27SRGYSuWSqhp329Q/EOchpWDnHPmtIUywTAg==
X-Received: by 2002:ac8:13c1:: with SMTP id i1mr1241724qtj.78.1605216003990;
        Thu, 12 Nov 2020 13:20:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b197sm5317616qkg.65.2020.11.12.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/42] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Thu, 12 Nov 2020 16:18:53 -0500
Message-Id: <6470b3a65b6e3e2a8d2b552da1202f606a8d8626.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d75c9be438bb..0daa4e671182 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1891,10 +1891,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2

