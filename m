Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B573628F87B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 20:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbgJOS0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390708AbgJOS0Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 14:26:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41DC061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c13so62717qtx.6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qF1e+MFDITaUVCYooGG0+69uPpu8a0+nlLEch33f6Hw=;
        b=KXcBxZ81kOC3W1iOjYDQ88+UblfHLDaKZdw3MyRCntWj6rJpwNdkaetqIFaPu7P10b
         /flaxrNBhSUqCepQX5cEg3/J+MU7yUR+ozwlksGWg8R8BU7rJfhJcUM12iWCh0bbBd7s
         AXE0eLhbUJMXZdwD8TK+JHTE/LeSzj77lRbLaqSNUe4Fc0j0YYMz/aoR+aj0aLUGTy1/
         sq8eeQI7JURTpP/Qbk8DGpez+9nPSLMd66orLOJBAii9H83Vk9C13dUa7s+Qdpw3S6LF
         O1zPxFU2FlUQuadfckPRuPu90YK9E/NM5tS7HQIT0w6Mnp5rpkZMHU2ej/5voBytKcFI
         wwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qF1e+MFDITaUVCYooGG0+69uPpu8a0+nlLEch33f6Hw=;
        b=L0/5YCaYkyjlREVDBoc7QGJlQ6LnWH14h/peCHRSDciFpQnCQ9dsWXPa+FC21iRYrN
         BxhJrEhgEu9XL69FRpW+qijolwxaSZghSS64msb8NAoA118sMIGd1q+q1AyvOD3Iv2ZS
         5nQTdJuXWhznpo0VUHY9RTWYTvKNMgGE05LckjsdSLsiGpj+EkMoHqwwDZQnTiXNHqVN
         7bKLYOdir2Qdn8tVZgqMNNmOfyTBmTxW0X2kvu5rO6UY/Uf8cIpmCDZ0Yig/zRm6+Kqr
         9RXHTBRJqvv6uUImcLUVzpyh7EqcU1lzZlG14jmeJ8ZxbvaID4n/H0z7xGmevIN/GlaN
         iS3Q==
X-Gm-Message-State: AOAM533Iyt9/VUo5WfN0lbE5kUUm8JPiTAD7I6Vy1yCmLgOprovcLEY+
        b67wDqsnT6gGnIMIR9Ju+m3Scv3HSa1BG3h+
X-Google-Smtp-Source: ABdhPJx249qmZuBHIAD2sfo45LahHru8Y51rJxwJqgFSzgFOPAYqtDqYclhgQt7bFzH2V460Ez9R3Q==
X-Received: by 2002:ac8:1c1b:: with SMTP id a27mr5563550qtk.157.1602786375243;
        Thu, 15 Oct 2020 11:26:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r17sm43000qtc.22.2020.10.15.11.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:26:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/6] btrfs: stop running all delayed refs during snapshot
Date:   Thu, 15 Oct 2020 14:26:02 -0400
Message-Id: <59571e7b8eb8b93bab529addf4a0d91daa00b2d7.1602786206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1602786206.git.josef@toxicpanda.com>
References: <cover.1602786206.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added a very long time ago to work around issues with delayed
refs and with qgroups.  Both of these issues have since been properly
fixed, so all this does is cause a lot of lock contention with anybody
else who is running delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f4d55ac7f8f2..fc8f12e609a2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1189,10 +1189,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
-	if (ret)
-		return ret;
-
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret)
 		return ret;
 
@@ -1210,10 +1206,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	/* run_qgroups might have added some more refs */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		return ret;
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
@@ -1228,15 +1220,24 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
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
2.24.1

