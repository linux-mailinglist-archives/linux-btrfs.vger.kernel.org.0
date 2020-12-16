Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C51F2DC41F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgLPQ1j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgLPQ1j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:27:39 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C6C06179C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:26:58 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h16so7178996qvu.8
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVK6HYY5L6khzQdNnCfvNhn+/fCGGpYOkn+GtTYGk6c=;
        b=JHGgtmkMrgYFH6oIWwDFcFbrICfdNWo0PaOulzPmsrHR8DPV2pgvfF9FYhnJ/j7isQ
         IYvsAYWI7NuFZ/USuUpCtrDV6NKM9WGs2kUPZsIACqRBvuYwH1bM8xOxcBqUm1aIFdHl
         uUUfosb9vVTK7Tn+RsNs6kCcR/JkZh5UEv8OZRRkC9meGq2srYOyq2DQBPd2sO+j/fdT
         sFCMouFOCkkpbLeZSFQY2iQ6CZrajd+id+QQVmfy6pWO5CgRcWJ7dh/LmF6p08IIEFDZ
         ObGjNqWUDgg8EaY6z+/7ANc5I2KtaZ34dcAjrqRUBYFbfrG5JPwOYhU7Zjwot++A+E8/
         ffyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVK6HYY5L6khzQdNnCfvNhn+/fCGGpYOkn+GtTYGk6c=;
        b=BGuXUtGaKDqEyTzKC6csZI/Jc/zsFsluwk1aKdze1g42uL3QTDq63/3SrtuhWzoq9y
         ogCFOf1QPUXo1eeYAaRAxHT+dwU9z9hZVRl/RMnr0JwdEKKD1JkCj1W2M28lXHtY4oiW
         Z0a8b1g+TLkjtx5dNSJfWi3ICPN07vULDpSKPnbdpIc3WN8kyV1g6nNDgZEpKNIQHgD2
         uVjCiNyw+PkTcXcv3+MdK0y0+dCj23gq3tCq+G3feYiP64xHP6p0ZambAA8PZYdrI7b+
         wnIFhsn5XG0Rjk8IU6pJdIBDSa4pUPN2VH4XUg0edQKca1SfzOkXEsXKu1qKipKF+r+9
         tr+g==
X-Gm-Message-State: AOAM530fgq2AMhC8OInPpS9laWL4UKpiZMMcSoSs3NnHl/DNC0oMHV7x
        2MH29Gsb9kXwESh01BYwR8mHI+vVXXj3aomv
X-Google-Smtp-Source: ABdhPJzU3hE/t55cgCNwPrc4Up9BMmmn1QTQ9W5lxO2T9wWThe17bD+Bp5rcPcYTGec4WApZoouSZw==
X-Received: by 2002:ad4:4aac:: with SMTP id i12mr41126120qvx.10.1608136017737;
        Wed, 16 Dec 2020 08:26:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm1145434qtc.90.2020.12.16.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:26:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 01/38] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Wed, 16 Dec 2020 11:26:17 -0500
Message-Id: <a71e2bfa9cd2133fe73a631620ba7b09217628e0.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a couple of BUG_ON()'s in relocate_tree_block() that can be
tripped if we have file system corruption.  Convert these to ASSERT()'s
so developers still get yelled at when they break the backref code, but
error out nicely for users so the whole box doesn't go down.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8cb9a7b364d8..08ffaa93b78f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2454,8 +2454,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	if (root) {
 		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
-			BUG_ON(node->new_bytenr);
-			BUG_ON(!list_empty(&node->list));
+			/*
+			 * This block was the root block of a root, and this is
+			 * the first time we're processing the block and thus it
+			 * should not have had the ->new_bytenr modified and
+			 * should have not been included on the changed list.
+			 *
+			 * However in the case of corruption we could have
+			 * multiple refs pointing to the same block improperly,
+			 * and thus we would trip over these checks.  ASSERT()
+			 * for the developer case, because it could indicate a
+			 * bug in the backref code, however error out for a
+			 * normal user in the case of corruption.
+			 */
+			ASSERT(node->new_bytenr == 0);
+			ASSERT(list_empty(&node->list));
+			if (node->new_bytenr || !list_empty(&node->list)) {
+				btrfs_err(root->fs_info,
+				  "bytenr %llu has improper references to it",
+					  node->bytenr);
+				ret = -EUCLEAN;
+				goto out;
+			}
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-- 
2.26.2

