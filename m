Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F58446A25
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhKEUwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhKEUwe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:34 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA197C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s20so1684991qtk.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tzf8Yva+0YhPoiLObWasAseWpPes8ikc1qSGc/tHFB4=;
        b=GlgQhsowo4Vr5BGYWuJiUIw4Ubni9DSDzttHeDH9xtvd8owD/LxMZD/AG34dOzHBGU
         yYbVyirFYedBQSA0/CCt/E4kIKhe7I6b3X2hla4Kv9r1XttJlNbDA3el5GteR59w8dZB
         grhW4Q3/WnkaSaJcKlaIK+lilMpbar+YCS9IVTYBR80m2hVvjobBWsjYExMCcAu050I/
         4l9udydilM8vbRjEB5k5LDYlKKMXB8ehRsyUcUaiNydLOwvJqNyglR1cNCwK0rwCG8P4
         BtAwhf5yck2bHiKRblQSR1Gc9PLpkW1v8aEuGBpsWAsDxMI0AgwLWXXCjyUASJmjgQVs
         M9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzf8Yva+0YhPoiLObWasAseWpPes8ikc1qSGc/tHFB4=;
        b=v3BbUHHI/58PrKrMTiVvI4sB4Efqdc16dEj5/f7ra5ucRHUJBsxhBfCnxXcDgIFwCX
         J8NIUBYKSmN75afcMr1VLsMpiyS2RmpfG8YSZ3eHnRhgrE3e2MzrUN/ShTVbqI/Vb4Lo
         Gz4qivzUZTzHO0rWEcJqoBop+sqU2mTbWMNmXYaGQ0uGo76WSuB49qj6E7zqyjY7TkOe
         E2qvARoE/x6+XBNWyxqKeaC+vRtKps6YqT3OWRRfPreMZVhdtuFCkWuFYcUg/l9+iiGJ
         11+RB5aWZS3ByidEl+6G4Wa/SzmOxRZf+oc8bWKo4Vr9HpVX5wFz1EHaa7OlwcQizYt0
         PzZQ==
X-Gm-Message-State: AOAM531DITOhGSTkG4pRhvpqmXcOvK77zSZlNEA0wJLh5PEl0hlVXhOX
        Wruvz6BNl04LRZ8ojcD5w0ZA5kh6ewxdEA==
X-Google-Smtp-Source: ABdhPJw2UvLl0y5XhZmHOCJgNaRvnPQggHlfeVgEr0RH98DEQuvfgX4kqIQnhjqEm3JDz3uUzfUOgQ==
X-Received: by 2002:ac8:7d4f:: with SMTP id h15mr43932551qtb.336.1636145393912;
        Fri, 05 Nov 2021 13:49:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s14sm863088qkg.115.2021.11.05.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: tree-checker: don't fail on empty extent roots for extent tree v2
Date:   Fri,  5 Nov 2021 16:49:42 -0400
Message-Id: <8fada4dda40dbfb5cefad7eabd16ac00a340896d.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For extent tree v2 we can definitely have empty extent roots, so skip
this particular check if we have that set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7733e8ac0a69..1c33dd0e4afc 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1633,7 +1633,6 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 		/* These trees must never be empty */
 		if (unlikely(owner == BTRFS_ROOT_TREE_OBJECTID ||
 			     owner == BTRFS_CHUNK_TREE_OBJECTID ||
-			     owner == BTRFS_EXTENT_TREE_OBJECTID ||
 			     owner == BTRFS_DEV_TREE_OBJECTID ||
 			     owner == BTRFS_FS_TREE_OBJECTID ||
 			     owner == BTRFS_DATA_RELOC_TREE_OBJECTID)) {
@@ -1642,12 +1641,25 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
 				    owner);
 			return -EUCLEAN;
 		}
+
 		/* Unknown tree */
 		if (unlikely(owner == 0)) {
 			generic_err(leaf, 0,
 				"invalid owner, root 0 is not defined");
 			return -EUCLEAN;
 		}
+
+		/* EXTENT_TREE_V2 can have empty extent trees. */
+		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+			return 0;
+
+		if (unlikely(owner == BTRFS_EXTENT_TREE_OBJECTID)) {
+			generic_err(leaf, 0,
+			"invalid root, root %llu must never be empty",
+				    owner);
+			return -EUCLEAN;
+		}
+
 		return 0;
 	}
 
-- 
2.26.3

