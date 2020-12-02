Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0D2CC705
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgLBTwD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgLBTwD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:03 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580FC0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:17 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so2446669qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nGgc80leMdV+08LRmyAhyBLDvsv2J2a7K6KC1wBGOqo=;
        b=OJMtoT5+k/Azl16n49rxvwahwAU3i79fgeQoJz9e+xxFLYb3M2o293yaiTJxxEBVNU
         SjO5AMT4cef7MDOSSLjjDNnDOtRApu+fzgzBho5GouPC4mU2qfTr/txwxyi3zB2B/y08
         022Y+jplG6WBu2Kh4SN2972vCM/fUGz/RJY3h13CQ0SF0thrC9+JE909oWi1F5CE7OHw
         +3/JOazvm6yTySaM75cYAvbY3+7FSWz4ZOABFAryh8A9GU0KUebTrK5as0kTHqsm4SOo
         TlR7m6R7atMU5UJpALf51tbky9gHAf64P8G9sAN2VWwT2cy/K35E+9n9zBx4mKERX9sK
         sr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGgc80leMdV+08LRmyAhyBLDvsv2J2a7K6KC1wBGOqo=;
        b=gcl8L0HjIHGr9lP4jUR7QsfYV52z/eW31esxntP95VHusRZZ+mru9sbUKMLK+a4WDI
         PpYMxDwxuYlhx0vh0Bd8/yFddhaaWMjpn0H6wCiX89U3TiTi7AePIq6A/MViEWEU53LM
         vapbJbwXgOmiIrDoLr7bE20sB2iXy+tQfXPk4k1lI5JzSOUL/7+vR/Owftb+SoaC9ZG+
         qvVow4kquMO3fXwMBMw8aI+bWeT9CBLHGmv8/AKO30QyVj3g8WsKzdIDtXjJPdBojyq6
         9qJQiuKkz7F5t13qcA+IpQ+0vY29C+VIZB+txepL+POkTQhYgswmD39X1kaDZfZlYBkq
         kd3g==
X-Gm-Message-State: AOAM533sKjdix1lDwb9rR1ot8h4e7lyBeO29eqT11mnaXRrU+hHI65mB
        yOCtYEzJa1A3UBzCOQ//nFpLlSAA/iixwA==
X-Google-Smtp-Source: ABdhPJyKZlWAo/vlKtWJ47CzTPtB8Gq+x8IwjIhhQHD5g8KWhm3gVehT/pGuK7sw6lsznGuOksvDAQ==
X-Received: by 2002:a05:620a:21ce:: with SMTP id h14mr4353544qka.363.1606938675953;
        Wed, 02 Dec 2020 11:51:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s130sm2034017qka.91.2020.12.02.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 01/54] btrfs: fix error handling in commit_fs_roots
Date:   Wed,  2 Dec 2020 14:50:19 -0500
Message-Id: <502d2273052e95e19366d785ee85e542e86fe61e.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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

