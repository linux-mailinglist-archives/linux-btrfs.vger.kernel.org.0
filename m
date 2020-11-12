Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902C82B0FF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKLVTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVTZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:25 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1801EC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:25 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ec16so3590406qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xH3Ox0Mgc/zVfDLEJgesHypyregZQu4ghlZMZyUxMHA=;
        b=1WT3gqRHELPV0fGy/1joZRvjiwrvncIdX9da1pWjbqvFuhCpFZdiMsFCdYRqI9RBEh
         lwNp9zU0sEx+MzmQTDDJSiVMydwEezeAnbrjtrjLrTaWaG3DtPuDacsHp8EljgK0Enq7
         FLF8Uge3GOi108zaioYQlTG/uz1Z+YnOZYlArHz0BFvMibWWxxOlhU8KGg7n6kPw9l/g
         okiNEZYCN8xPKiC6eV400xSGIN3gx1LR8P7h46LAfHV6lnPwVtgKbAiDHSBmojuZOrl+
         jPj4YkfyVg0tqmczG5SBqyga9tTLJYjGQtb01oAtJvACOzkTQ8ljJhnYwmHo03kRUE86
         ijeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xH3Ox0Mgc/zVfDLEJgesHypyregZQu4ghlZMZyUxMHA=;
        b=Bm1NZ8KYPTJdLRyxBcowvA/T0aHIuIx9zgrLgJm0G6MTYKM/YbgELOuilK8LA2NF04
         y49YxrRaNG5MqhzIED3K7sv0Y2mqOXOmLoA2+CQmkcMeSrBIFrFeeeznr9GCy5Sbd+TW
         TAd9JSgHUnKxPbowJD0zNd23IjTnNazpFOwT7FZMHEUKFn89I9q4gkMEqeb9DWUmrRiN
         wUdVLJw0ZLtho15tYs7nMrIgE+Cmj3cPJhjO9KMUYWJJe2/yo8cZvvZ7LdtTMzk1YLn6
         i2duR33jzYVWFzyx1uIW8AjnVJvz2nE4sKaHhew2zAObYJYwduFit6dKyaU0Il13eI5y
         SKCg==
X-Gm-Message-State: AOAM532uYEbVo/5UNnMnOvYPfX0KeolKZrboqlwynscCO0GwBvXrthba
        pHd7Tv/uGUvnfrmV84dIa2EflSpp0UUJqQ==
X-Google-Smtp-Source: ABdhPJx4Qvs1bS6ndlh70Zxll3aW3G4tNDuglTvKZBc7eBvcPYxSI21zi9lTcMUVO3G/pqVsjsQvhA==
X-Received: by 2002:a0c:9c05:: with SMTP id v5mr1570925qve.7.1605215963533;
        Thu, 12 Nov 2020 13:19:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm5147301qti.88.2020.11.12.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/42] btrfs: handle errors from select_reloc_root()
Date:   Thu, 12 Nov 2020 16:18:33 -0500
Message-Id: <30bc49ac37e7af23f71260f69df81d8d6c364dbf.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
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
ASSERT(ret != -ENOENT), as this indicates we messed up the backref
walking code, but could indicate corruption so we do not want to have a
BUG_ON() here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bc598eb014fd..a94671199e8d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2056,7 +2056,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			break;
 	}
 	if (!root)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2231,7 +2231,18 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			err = PTR_ERR(root);
+
+			/*
+			 * This can happen if there's fs corruption, but if we
+			 * have ASSERT()'s on then we're developers and we
+			 * likely made a logic mistake in the backref code, so
+			 * check for this error condition.
+			 */
+			ASSERT(err != -ENOENT);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2

