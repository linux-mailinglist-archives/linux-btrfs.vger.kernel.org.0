Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516912D12DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgLGN7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgLGN7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:52 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF44C094252
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:03 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so9365330qtp.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBEbE2A955QTpSYe7t3gEC9f7kk4UL/5SdXRttPLrCs=;
        b=AkgBFoVQ9pQSQbWLZeMQ1+IHq1tXgkZizEsLBpDSAHYqw1olpfc8jzIL1fo8pVRPm8
         TYppiHJ58UM/zb5BR20JHMMQ13buUkAuO1u0KvQWbusiFgVJQdZJhQExKRUVxxz9GKCb
         LEOQbnDIDEdtqM82B8XLiL7XnbLz/XY1/3UdVlykiLKoWjRpZG3rbEHLnnGv6+T4U5g+
         bE6ZdjziyWQsmxapNZjYvsD3N22mpn1CmMA6VUfU1G+Xj+AVtVK3r8zbMks/ZMoAMEMu
         fHI0DrWxO6gzaH5loV3e5lZ2eyZ8fwC3HD77ET3iFVWJgXAjQiWJSyeKlz7Cedm3Qh/k
         BfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBEbE2A955QTpSYe7t3gEC9f7kk4UL/5SdXRttPLrCs=;
        b=gOzaAfBzcq4gvdNfddyILiz3htfoyXObRK1pO+zS+mVyYs7oqwQpcpsYz5wfMD8Am/
         mR0ViDlBinLdLBsMvRn+EA9rgERsQzce4648aFAuL/Ijf4CDFZFmdfnpWX4EPSzxxq6P
         MZgxNEr75ygYODpvjpYSb4503L6lu7mTj/5uNek8EXwjVRWOXCYg2/uf1tr5OYOsk8za
         4Y3ryYw0Qecba3s+uZo7vnOB+8HdMwOgDoLY+HnTa5bfZIo/8O8miNYKkE/VdoZyfGc/
         KnBzMdAUONxxvONWIbcXhzXmwl65NeKTOeFAwp6ZRwY/v3OtCg3w69WXJRZtwMWVfSrA
         PE0g==
X-Gm-Message-State: AOAM530lnlzqc7lkJQKEy5DsFTzQIhN3KZ1fyPhEMimJ0mVLxb0iEFHz
        yOpAI/QnPRYREqd32XIRQcM8ZCBrmsZX16Av
X-Google-Smtp-Source: ABdhPJzi5KUFIJPTfQxN6GDYFhMib2Eb1vqm8gIBpjAmA353/xAeVh8TvLznm6aNPQ1jjUa1dYTQmg==
X-Received: by 2002:ac8:4cdd:: with SMTP id l29mr2909381qtv.216.1607349542260;
        Mon, 07 Dec 2020 05:59:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m65sm11884600qtd.5.2020.12.07.05.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 39/52] btrfs: handle errors in reference count manipulation in replace_path
Date:   Mon,  7 Dec 2020 08:57:31 -0500
Message-Id: <44b393f0c6dfa5d07e295a12f1c7dbada7d5aae9.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If any of the reference count manipulation stuff fails in replace_path
we need to abort the transaction, as we've modified the blocks already.
We can simply break at this point and everything will be cleaned up.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6ce46977ec05..e025cb052d77 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1355,27 +1355,39 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 		btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_bytenr,
 				       blocksize, 0);
 		ref.skip_qgroup = true;
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ret = btrfs_inc_extent_ref(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_bytenr,
 				       blocksize, path->nodes[level]->start);
 		btrfs_init_tree_ref(&ref, level - 1, src->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_bytenr,
 				       blocksize, 0);
 		btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objectid);
 		ref.skip_qgroup = true;
 		ret = btrfs_free_extent(trans, &ref);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			break;
+		}
 
 		btrfs_unlock_up_safe(path, 0);
 
-- 
2.26.2

