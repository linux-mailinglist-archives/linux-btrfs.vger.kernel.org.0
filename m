Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BBE241260
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHJVbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 17:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgHJVbU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 17:31:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE6C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 14:31:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p4so9876469qkf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzpr7IP7j22lilsKJ6D89ZtD+jUFTvmnDT19lAZI16U=;
        b=wF0zkoLiwBjHhyXm6iNwx7C7+ftwTwETN6mJ9Owspd2rD3+JId9hDff323uBzHugR4
         pX0+14+s5bjXxEKBq6nSJ+jfXWTevNuIZjr/J1Xd3l/i2Q7vjthXRQncH2PuEwtxKquL
         /+z9Jq1JrTahxA6TakyrNZYJWpYxYLrESQ7oj5lPVtR9sL6+qzycUyzw0CCNp8B3d+wo
         TsFDk5PcW0n8GODxot2Fe/tHup81BO/Nl4Z6LUQgw4benP4R3623Vdl17u09Naa0KNEZ
         YllG5t4alQjShNkiv+f8b/Uf2rxwsnwUO0UmXlSp/IVmZO3p3GFVwFCvs8fE8j+W5R3L
         GRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzpr7IP7j22lilsKJ6D89ZtD+jUFTvmnDT19lAZI16U=;
        b=TcQxcyPZlj+7yYJ3jClonwYopmU+PmuDAnG+mQewb6m2Pc9sRPuhi9eYz8wxqIGcnS
         5qFb1suJE7YEC4CNv78rUkmzPw45F7L/fG3gCwFaCKOv2uAeBiEcbqaefaH83l8b2nsd
         vKsbFHro13NSXE/hsE9VHcvU18ttlZZx/G+9+vW+qwlxnTfn9bHCnCKXNM9CUz7yGLgV
         bDZjOGWxuJQqfqJFgtSn6AizXNKhyD9BCMp9hNzbw+c21TOqHtQYTOk2X5l8JgbBdVKO
         A8+qYM3Xqd1qd3jT4D7BfG6+MW83ExNKnQo6HQlmozZiY44m624CenH/Hs7Mwrwa4Dz2
         3AZA==
X-Gm-Message-State: AOAM530iXZISuPb6jOLfSD0LWMg4VWO94E/zsy3V/E/W+cKhpx2udppk
        YBDEf7Ft6jt3DK2lyW9Gcw0SUr/d5WOiHQ==
X-Google-Smtp-Source: ABdhPJxEVsnFgrTTMte/maQ8uoiCQty4GTjJn4m13T/ILHbV7EMWbSDCsz7dk1i6EZT7q7Iq4U+0Nw==
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr26695273qki.158.1597095078086;
        Mon, 10 Aug 2020 14:31:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f92sm6092220qtd.9.2020.08.10.14.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:31:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: check the right variable in btrfs_del_dir_entries_in_log
Date:   Mon, 10 Aug 2020 17:31:16 -0400
Message-Id: <20200810213116.795789-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With my new locking code dbench is so much faster that I tripped over a
transaction abort from ENOSPC.  This turned out to be because
btrfs_del_dir_entries_in_log was checking for ret == -ENOSPC, but this
function sets err on error, and returns err.  So instead of properly
marking the inode as needing a full commit, we were returning -ENOSPC
and aborting in __btrfs_unlink_inode.  Fix this by checking the proper
variable so that we return the correct thing in the case of ENOSPC.

Fixes: 4a500fd178c8 ("Btrfs: Metadata ENOSPC handling for tree log")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e0ab3c906119..bc9ed31502ec 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3449,11 +3449,11 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&dir->log_mutex);
-	if (ret == -ENOSPC) {
+	if (err == -ENOSPC) {
 		btrfs_set_log_full_commit(trans);
-		ret = 0;
-	} else if (ret < 0)
-		btrfs_abort_transaction(trans, ret);
+		err = 0;
+	} else if (err < 0 && err != -ENOENT)
+		btrfs_abort_transaction(trans, err);
 
 	btrfs_end_log_trans(root);
 
-- 
2.24.1

