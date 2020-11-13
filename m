Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73D72B204F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKMQYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgKMQYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:42 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A0C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:41 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h15so9246296qkl.13
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X0UJmpg+QnO1iZG84z7Q5pqsYhsZkdU3o8WkJr7nXLw=;
        b=hQbEzlMAnslXJjVcSe4nWSBtHBArOBIswcM1FalAM0TmqvT3ZVuMPYPAN0tr8ykjDC
         k/MR3M/WbVrVvFfRiSro47PSkmYRS3xeoWIGUCjCLbqZ5DbXXEswmVCWuMKVaPV7w1eQ
         UcVfVMpJxPjFuMVjuG/JQKTlKhG32MCpU0MV+ieDFrClo8j1HobDbbOOYZI8Dv9hHRCQ
         iZYfWROM527qkK4De3SKgH92UqZy8VXhSQKHpC7zAR77bIDqmUZB8DqRRjkErOpORL83
         zis1mI6kyyct+nTheGqxopFQYzDP82dtfnE0tPC9l9GTPerEifvSHyqqKHoQ+XM74ym8
         b6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0UJmpg+QnO1iZG84z7Q5pqsYhsZkdU3o8WkJr7nXLw=;
        b=G6KywrXlAtRyq1bbo7Y3Ep5k0UOMT/ea1re+3ePN8q9SzPACh7/FyWuoXKI6Qr3DRT
         jaTMm+LjxBDLmtA6pwsYGZw7AwU19+B9sMM/sa1BHYVsb6p1i6D4HMPSjwyundBvyb7j
         Z+a1ss1xPOPRlGKAGM8CpJXFp0CCbbXN8lX9EhLyzwcS1xdlYMycP14N7+5cbat46AWo
         cJxoxdtBw2AbPyU18ATdjMFFeSFk1Jml2GMIhy3asG7Zd/Eu8KZKgHM0GqzgvCkJQOzG
         My0lTGYc6iWnkSySB0ctTuN9CwDoxPABIuhZQ01LReer6bhbYFWG5FgIPCyjctKDGIbN
         sCHA==
X-Gm-Message-State: AOAM532NGXC6Ak5m3qn/vHh5W0NeqpcrY9W6hdnY70sMfUoEJ8eDbV/t
        XTxJJIJ3UnO6wtIJGuL1cHmyKXlP37rGJQ==
X-Google-Smtp-Source: ABdhPJx9GxR6wBIPqq56m9W15KP+PJaFZ2PVm0k5qgn9r8hR3RHstwvSFEU0vBSHNlxTAmqvgbbPHQ==
X-Received: by 2002:ae9:eb10:: with SMTP id b16mr2755561qkg.494.1605284675870;
        Fri, 13 Nov 2020 08:24:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o63sm6722521qkd.96.2020.11.13.08.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 33/42] btrfs: handle extent reference errors in do_relocation
Date:   Fri, 13 Nov 2020 11:23:23 -0500
Message-Id: <9c5ebe55c78553d1a07559f63d26a446d5642bc3.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 74d52fc457c7..bc63c4bb4057 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2447,10 +2447,12 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				btrfs_drop_subtree(trans, root, eb, upper->eb);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				err = ret;
+			}
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

