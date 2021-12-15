Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E42476384
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhLOUkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:22 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E7C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:22 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d21so14009936qkl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGxXdYS04ohly22ErslGy7DWlMCbHKr36m2lpVdaULQ=;
        b=A1ROlvyqukdoXB3unQqr3P86ZGzqByGGrzqdMV7A79uu4z/lJV8sxgF+wA5sXXNWLL
         xF6YHyFTRp5VxfPLFql/xpGL2mtnI3K/wxhElhRGXueAxmawD4ksZyNlUlpvtVz0bXW8
         gQEoKXalIkiij/38iB2r4Mfs0DvZp6tOphyIB/Y3ZAo9p20/kA5O/L7xF219spWDCxTy
         TvTOqz4ZjZLqy7PSw3q8vW4QcFowtXfvuV5GEOnmPGlIp5g8lbmJmT1+d5GlAFrGOX5Y
         Hs80HBOeMfIh0L2oJAzJWzELmp+DqfNwR4khbSHrwiF84ylhhvwTqzK0u/Mo1UYNNZBk
         +zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGxXdYS04ohly22ErslGy7DWlMCbHKr36m2lpVdaULQ=;
        b=JXri/QqZMNTqRN4z8o9bu6jQkd8wfj6eaxF+SBbL7VZhrAolwH0i8NI3lnfNHdQ/8h
         lA+TdW8vFd7I31Nm4fpMcoSnmcXO7TigjYKdOG1C2vuJbBgY3xJJE4TNeD9yurtWexbg
         Ep+DSC6ckmiRi5fUX6l65oXzg/6tAS/ppLoaS7YxvcL3RhLzfRB1QLFtYaVk8iG8614h
         DBQvaTxSBoYfxx4/gKjRR/nccJPdyM/zYboGlWFdUdfsvpt7wtilGX1kPIS4rJYid5EH
         y028bwnrdfUfpVgi4EbX1mIKMq/h0fg1TrEJaqDA8Oo2T0ZvWxuXzvMULlVZZS28ZilN
         w+sQ==
X-Gm-Message-State: AOAM531Ko8PiocMCkHSmDtb3wpqCIq7ry9P05jVCp1weaM++7Xok/XB+
        2oOVDQRFugYun+8gvE8HfRSigXDh62QZjQ==
X-Google-Smtp-Source: ABdhPJyrdRRSCOAOop1NSbnvpFj3nBWaR91Zq+rIFSsgshMIaT5T3LaRufH9XEtRK+NzH+gWuMdF+A==
X-Received: by 2002:a05:620a:4712:: with SMTP id bs18mr10085591qkb.246.1639600821364;
        Wed, 15 Dec 2021 12:40:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m8sm1610148qkh.120.2021.12.15.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/11] btrfs: tree-checker: don't fail on empty extent roots for extent tree v2
Date:   Wed, 15 Dec 2021 15:40:05 -0500
Message-Id: <dea7aad47114697da7646dd0b4c19c25e76c9ca6.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
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
index 72e1c942197d..ef7d624b0672 100644
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

