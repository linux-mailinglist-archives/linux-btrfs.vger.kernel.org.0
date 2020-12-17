Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9C2DD314
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgLQOh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLQOh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:37:26 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9183C061248
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:15 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z11so26490752qkj.7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FaI7ZWwKpkMniwFNP6xNh9GRJwhsEqcacAMZKmWdnRU=;
        b=sIkupcHCI0oIhT3qNKL7WPMJjDcho4q4B6+LGvz+4gzU8481WGL2v0ADTYXTOlxq2+
         LyP5ysFff/kACU14ZpkTXpBSnVr0wf5s0QGJuuOHu/f7x1viEPF1iKsF/UUiWyQ85orN
         JP4SdL8bpV6lRFDqoapk/8vKQBKxBcf/i0fVaxJVhqC7AvQ0My1J+fYhSMHSFIjwU5SJ
         WSVAkKmYzfkuzjGG3fYFogLsXdky4PIBv7dk4iMdpEc0MUgapRXSvNe2W44FNeAyEKC8
         lDfBHiSJqM9NGTSGKvI121XZ8E4byzy0a09slZNZSnoyB4Z7Sdjg0/OpuqoNCsS0chqa
         BSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaI7ZWwKpkMniwFNP6xNh9GRJwhsEqcacAMZKmWdnRU=;
        b=j15FQWlmzGpA8WwoCZSFEz3qEvZ5MtJqz/jbn49NPfx7/ZA3u8KGnG/Y/EQjXxZ1Ew
         ruMxO0IKirc6x0gPKCtv2Mlh2HB4WCoUvysSNEkAVyO/SSSggJRue3KG1Q0x2Fkg/8nw
         F6bdSoNkXz6EHdeRCnVNcfdhT3qZ5ctfBR2lj4fa4v8su7zPZVR5FTYWXxBDUOzEtw0Y
         gEZqvN10G38lp0eOy0EbFJGRJMByc4FUhsK7i7dnSSNAPovljTD3ApmBDtHZa7VWFFwe
         f5sZQhhB+wA93JmVUjqym9u3lakFSA2/nNL+DXzl8E/ueOSDSP4FheFl+rqxq9YJs6UQ
         Q0PA==
X-Gm-Message-State: AOAM531yFhNQOezc3SLselXdk63z9h2qPINc+gAG8jqxg6+itcCM1slP
        dmj76sQNyekeMOzPDMybV6d+eLjJwLZNnKIF
X-Google-Smtp-Source: ABdhPJxjfJ/F9rh702/DIfJGXutxJRozida3ChtJl4cBvmGTEODTTow1/Baft14cyfaT8vltib6UKg==
X-Received: by 2002:a37:9cd6:: with SMTP id f205mr49698787qke.51.1608215774824;
        Thu, 17 Dec 2020 06:36:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v1sm3642361qki.96.2020.12.17.06.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 6/6] btrfs: run delayed refs less often in commit_cowonly_roots
Date:   Thu, 17 Dec 2020 09:36:02 -0500
Message-Id: <52a20cfa753203a17ecb01b20e02f6976cc097a8.1608215738.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608215738.git.josef@toxicpanda.com>
References: <cover.1608215738.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We love running delayed refs in commit_cowonly_roots, but it is a bit
excessive.  I was seeing cases of running 3 or 4 refs a few times in a
row during this time.  Instead simply update all of the roots first,
then run delayed refs, then handle the empty block groups case, and then
if we have any more dirty roots do the whole thing again.  This allows
us to be much more efficient with our delayed ref running, as we can
batch a few more operations at once.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 6e3abe9b74c0..bc9b3306eb36 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1227,10 +1227,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
-	if (ret)
-		return ret;
-
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret)
 		return ret;
 
@@ -1248,10 +1244,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	/* run_qgroups might have added some more refs */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		return ret;
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
@@ -1266,15 +1258,24 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		ret = update_cowonly_root(trans, root);
 		if (ret)
 			return ret;
-		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-		if (ret)
-			return ret;
 	}
 
+	/* Now flush any delayed refs generated by updating all of the roots. */
+	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	if (ret)
+		return ret;
+
 	while (!list_empty(dirty_bgs) || !list_empty(io_bgs)) {
 		ret = btrfs_write_dirty_block_groups(trans);
 		if (ret)
 			return ret;
+
+		/*
+		 * We're writing the dirty block groups, which could generate
+		 * delayed refs, which could generate more dirty block groups,
+		 * so we want to keep this flushing in this loop to make sure
+		 * everything gets run.
+		 */
 		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 		if (ret)
 			return ret;
-- 
2.26.2

