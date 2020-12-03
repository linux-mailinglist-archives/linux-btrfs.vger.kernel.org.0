Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6582CDD52
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgLCSXx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgLCSXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:23:50 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8BBC061A4F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:04 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so2999848qkk.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKLj6+/uDMAOxZtOXFOiq0hL6TkEN0Z1qIX5Qv9mpj0=;
        b=WhZTSOBQ1dtglqAObMhcodk4iSQn6XAE7S1bUlL6dBBhoPekjYTsfavRcACSZWv85n
         RbraDug/9m/YYOUjDRMfwuvAJlOb0+XlgIURgEHTfEbJqrEprzAmGybehBXggeW8NBPn
         EfEkifE76ayW58gSAQOvJZyJbPP/6CGJQELIBSFxL6E+rMsrQHV55YdoDPps78thn3sJ
         cKE14IHlGHdgbMmeMOVhN6AfhKgjeBacgBkB5mNQduhc74Bfio93k2AFlodKCzZpjbSM
         hyGUO8EblFJrkrXvZqVAM8WleAd7AXRC63FoxCSZkgvWQ358OyaePo615i4BqYIcW0a0
         uWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKLj6+/uDMAOxZtOXFOiq0hL6TkEN0Z1qIX5Qv9mpj0=;
        b=BAUqxXkYTokYQ4y3neeVAdvR6Uqze2yTXMo1B7E6MzJbjE2V+xNalCPDlkDEGSYEAY
         wm0vJHSlilHEqbzW1+eQWogpdBelxMLDcfPpEtPHNASUSvqup6TCmmEvbpJitE0Q0bN5
         bmvZVOwgGi3FSEk4Fre6fBHb0YS5mzB0AFRvr4XfuCPMhsyPnpojYftSvhQd9Uh684Ll
         8+GOmnVUbaY/IgteFFsSzYMO7ZMRVjSh5OZnJ3qoa3HbJ/r+rkLUsFuIoC9nIooK25T5
         NH3CSMZ7PCD2/r2yxYLCCsr2K0p9cs79TfUB1iHk264gqywvOmNFFNTow46RguUE2MOP
         Uztw==
X-Gm-Message-State: AOAM533k85YnMKyhj5pbdIzRIzbWiWu58uURHaqe0ZqyhmC+/SMTpUGF
        9h14QATJ5P1w+3kBmJOGsDs90oprOxrUoI7k
X-Google-Smtp-Source: ABdhPJzL6iVzGhNRhXdWlpTts3jBmGno87oLas1H+8p4/lyTlopE2G9NsOU6u+VhN6yO8nbEBr1IRQ==
X-Received: by 2002:a37:68ce:: with SMTP id d197mr4201722qkc.178.1607019783105;
        Thu, 03 Dec 2020 10:23:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 200sm2170003qkl.60.2020.12.03.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 01/53] btrfs: fix error handling in commit_fs_roots
Date:   Thu,  3 Dec 2020 13:22:07 -0500
Message-Id: <267b07e04d3d7bfa99a3fcffdc6b8f56cf1fdd44.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection I would sometimes get a corrupt file system.
This is because I was injecting errors at btrfs_search_slot, but would
only do it one time per stack.  This uncovered a problem in
commit_fs_roots, where if we get an error we would just break.  However
we're in a nested loop, the main loop being a loop to find all the dirty
fs roots, and then subsequent root updates would succeed clearing the
error value.

This isn't likely to happen in real scenarios, however we could
potentially get a random ENOMEM once and then not again, and we'd end up
with a corrupted file system.  Fix this by moving the error checking
around a bit to the nested loop, as this is the only place where
something will fail, and return the error as soon as it occurs.

With this patch my reproducer no longer corrupts the file system.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8e0f7a1029c6..a614f7699ce4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1319,7 +1319,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	struct btrfs_root *gang[8];
 	int i;
 	int ret;
-	int err = 0;
 
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	while (1) {
@@ -1331,6 +1330,8 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			break;
 		for (i = 0; i < ret; i++) {
 			struct btrfs_root *root = gang[i];
+			int err;
+
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
@@ -1353,14 +1354,14 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			err = btrfs_update_root(trans, fs_info->tree_root,
 						&root->root_key,
 						&root->root_item);
-			spin_lock(&fs_info->fs_roots_radix_lock);
 			if (err)
-				break;
+				return err;
+			spin_lock(&fs_info->fs_roots_radix_lock);
 			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-	return err;
+	return 0;
 }
 
 /*
-- 
2.26.2

