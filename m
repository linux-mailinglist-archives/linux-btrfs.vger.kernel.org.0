Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3E339836
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhCLU0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhCLUZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:42 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94AC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:42 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id t16so4894740qvr.12
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lmor2AJUSCuxsJBoEJr6kaL14eqXc0DDeokCLxHSgMM=;
        b=C9UMBOiWFmAeOOFqvQXFU+dQzsDQ06YUXjXH+phPv/BIhF30yZusYG30E3/lDeLr4D
         C0idN2uKV/oHU8QJ8FgBVB5kFpO2O70vclXgaLpId/EU6/yD97Nt3KrmH0HeHaW0oyxB
         zD1nWDTRiXGnA16shw8jksSuUcsTjznTFhVqIGIrHkMi8zqhxPMJa047GVAcgZ/vJ/E3
         d8CxtQTDze7WrWHLQ6O31J+mbY3RXFjyJjbm+kRrrTL2NR09HTG3EO5Jeg4/DiTBzhPe
         F6gfUvutV5AXeZbAX5OvcrumrICnNXWIGqqffFLKSY4mP7Gon9vt2LSwTesxORuuEanN
         5c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lmor2AJUSCuxsJBoEJr6kaL14eqXc0DDeokCLxHSgMM=;
        b=HBtelCXDzizXPMCUKbskrybcjt0XXvVBE/YU8Ift3MiiaetYpuucXRvJTCYdb/73HM
         VH+VeGOr8rpQ3Cq3Vg7d8rXa4n1Fj3DiXrXcjxIm4ZBer3CqViCAdo3OpWo5bW5MdzOA
         E1Izhhzd0RH+CjvyOeWPLlzJXCFp5Dvip3kYw3wp6u3V9XX2wtf9ZyOkiB0qbRt2gvIl
         oczEiegOurIdTZWgzYhqUbIbgtHgBpZD5BIG+qCdMdcejseAa83448t69SGA3gvDO0O5
         /AM3ED0j42vrDYhyWdtvr8lDQ0L1ewbXv9rcNNYUPIrjpa5t70s3+wz42RH1LuiksXCW
         QcIQ==
X-Gm-Message-State: AOAM533d+t+5YGhwBZOO7LBgZGuq9Q9/DgiLfmbQAisFOJ7YlB4dcS8e
        AuHHI1IjnuM3xTjVNeqEVQGN8ylrp+9YY+A7
X-Google-Smtp-Source: ABdhPJzp6w8fI+jbjJLZIIHY/VENior6yG+5yZ++acWxnoR/49B+BafRow4+7Q/TTerdYVHQrivf2g==
X-Received: by 2002:a05:6214:1085:: with SMTP id o5mr69204qvr.5.1615580740957;
        Fri, 12 Mar 2021 12:25:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v7sm5199509qkv.86.2021.03.12.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 03/39] btrfs: handle errors from select_reloc_root()
Date:   Fri, 12 Mar 2021 15:24:58 -0500
Message-Id: <3d5aa5f2697cfc8847f344c2bc6d6a9207e4a508.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently select_reloc_root() doesn't return an error, but followup
patches will make it possible for it to return an error.  We do have
proper error recovery in do_relocation however, so handle the
possibility of select_reloc_root() having an error properly instead of
BUG_ON(!root).  I've also adjusted select_reloc_root() to return
ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
error case easier to deal with.  I've replaced the BUG_ON(!root) with an
ASSERT(0) for this case as it indicates we messed up the backref walking
code, but it could also indicate corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1f371a878831..097fea09e2d2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2024,8 +2024,14 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		if (!next || next->level <= node->level)
 			break;
 	}
-	if (!root)
-		return NULL;
+	if (!root) {
+		/*
+		 * This can happen if there's fs corruption or if there's a bug
+		 * in the backref lookup code.
+		 */
+		ASSERT(0);
+		return ERR_PTR(-ENOENT);
+	}
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2196,7 +2202,10 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2

