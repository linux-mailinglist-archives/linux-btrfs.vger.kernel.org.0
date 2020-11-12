Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991192B100E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKLVUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgKLVUS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:18 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BF8C0613D1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:03 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so5190996qte.11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xp66q+qZpt2NBdKbsHUgvts/wy+hLZxErKqgqR97Ma0=;
        b=v7lTRtJNBrZQTsScszxS5bia1jQxdPqquvaJiUsMToV6V4NpHkxqu2hsRCqSM4Rh7d
         vD61DUGOVr63RtdDU99c5kwkak+ImiQHn2G+oDSLqFL/BayqsIofIbQfO1lxEBkaxvY2
         dVe8WkF7AucWFZ+OUqa4511ARXtNT9Sd8KKI8YsY6uoiHE66lIIQ6dQujqFCC4YD1q4b
         ymy5Lm5dmr0PBEcGsisPOXcWldFQD6RX7CBdtEbrLEA9IE9B5x19B46dYh4g4HKioakM
         FsC/OLXfD6ZYzH+mpNCOSyyuejVOgckBAShe17swlE9S8Rxgc7MHrTZVvT3dq85ZXe5v
         dYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xp66q+qZpt2NBdKbsHUgvts/wy+hLZxErKqgqR97Ma0=;
        b=g78hiQDQcD22zuOtBPZe5UvUEOD1iLnzlbAA9ern3gGoHDGdPt5HxlLhSYD1Pj/yMq
         VZV7dnLSP9MKy5UksmAoBW1nnMKx8FChywGRtPv8pvl2yIPkkd0gT2u6FfbxzbG34a6O
         kFG8vNKJKTBfrYfznD3TmkcX9oerThSlFJHeXbqgDpSkbzpahabRDGJLa+IGFwQjobLd
         A5IfXZW3lbUKJa+AsCrfdHee/1s/hqcWL9QxRRJZ35ZLM5N4fCdCOgJXYV4D1QKKB0CO
         MMK1N1MmFehMc0VqUpegDoQSr+Q8593JKIlIQcmENCErQldFcmRR0yIToi4irouO3sYo
         m4/A==
X-Gm-Message-State: AOAM532gS5xaZuzAvSERUcK8OF4Q1ao4b2Se10MIOR3HAStTKcSYOa8N
        jVvQhtFgoRaZ9DSQofcWFnUW9jWDaR2yZg==
X-Google-Smtp-Source: ABdhPJxA4sP3BeEQFS0MYxqvfVTfaKxBa1hLAPH7pnzxpmAivhUPV2TTAx8OIOwSQ2Y6DGOkXAe3VQ==
X-Received: by 2002:aed:38ca:: with SMTP id k68mr1206305qte.28.1605216001965;
        Thu, 12 Nov 2020 13:20:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v126sm5573319qkc.104.2020.11.12.13.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/42] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Thu, 12 Nov 2020 16:18:52 -0500
Message-Id: <922431997fdb89b8fef3b0272883b21c49e397d6.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in insert_dirty_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5174f5b2765e..d75c9be438bb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1581,6 +1581,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1591,7 +1592,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		sizeof(reloc_root_item->drop_progress));
 	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
-	btrfs_update_reloc_root(trans, root);
+	ret = btrfs_update_reloc_root(trans, root);
+	if (ret)
+		return ret;
 
 	if (list_empty(&root->reloc_dirty_list)) {
 		btrfs_grab_root(root);
-- 
2.26.2

