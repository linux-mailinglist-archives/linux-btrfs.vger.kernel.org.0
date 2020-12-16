Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549132DC440
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgLPQ2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgLPQ2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:51 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD4C061282
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:28:03 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id s6so11599385qvn.6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08eHlwv1HFrRUWzwFWY8rmWFXTfTj0GvVO545rzAiVQ=;
        b=kvzWb6GSDyOjhCR8+w1ir4ZWLdIhgcSN6qkknr5QtRpaAlQjI7ghT1jLcF9E9qVhGt
         Yr0fUP965dgCwii0Iivyf8GVapSXsRwmZKY91iE3qrJ0CLichMMA4+yI0s3bKTWNIMUv
         uEgd4ZKDHJt67d0xf8F5u4DVlh24936d1a7kCi1r8gIyLE1DhEHw+HO4vPblIDQ/gPRH
         vIE/SOgXxJ1atSSXMgfKzKYFzCJmYzWndv67rm48uunJAiHrws/0n027i4WFC3+qiyzT
         MtyfStOj4r7123Zq8J7phwFvh4GgrN0K208GyxoJpFVzzPxP6pskx3bisiDH+obnCvaM
         DW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08eHlwv1HFrRUWzwFWY8rmWFXTfTj0GvVO545rzAiVQ=;
        b=TIuyZdWlWeS84OsWg3mXKH6ir8DFKuns+giPZwCNCvknt113MpTnFulLazjUcl62xG
         dezV5mtk5ZKv6qItJhwocYvOqjJhNX25aUlpM+krV3nZGD14Y0vOQWE7CbuTbOqMMtaW
         ktPmsZkZwQHlrCBxuW1dEbR0zYYZxTm1DhBdaIj9wQmzEMNzoJV68Zi208csOFmuSHji
         bOQUE+OH83AVCa1rg4EkyGSEQlLHKu89SIrjHC/7SPUjRS7BQMkX6QB5TWvln2Pz5alw
         Tl+3KCf1mJtVimLZetsA6UoqpkuWCXXf6+t+8ZF6B+V4YlcSx5hSHw9+Ga9urvaweSnQ
         5UdA==
X-Gm-Message-State: AOAM530P+gYg9fhounpaIlDfz6xVmEfHU9J7LYa7lceFFGQpPC5N5bQ3
        dl8RrZ9Lmn9fZ6ZtWUhsl9YSibitLA+VfiKg
X-Google-Smtp-Source: ABdhPJygSpbUch8mKUURubL+O6r0KD9QzvC6WfiYonx4OoCM/q9enbpdiD2tAcVt+A0kQBJxzcy07Q==
X-Received: by 2002:a0c:fa4c:: with SMTP id k12mr43670533qvo.16.1608136082397;
        Wed, 16 Dec 2020 08:28:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w187sm1419194qkb.81.2020.12.16.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:28:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 38/38] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Wed, 16 Dec 2020 11:26:54 -0500
Message-Id: <1a52fe84b41022f24cea283cbc621e2bbde2183b.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 44743d1fe414..26ecc55e9f59 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1915,7 +1915,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3450,8 +3450,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3610,7 +3609,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
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

