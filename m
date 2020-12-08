Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F52D2FA0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgLHQ0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgLHQ0Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:24 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD6C0619DC
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:16 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y18so16395405qki.11
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ahctvAGM6XY64zu2BVGUKBwiv00peOLEBIhqPgdaxkM=;
        b=qnEVL9OxNdOPpgDkuOO3cs0FR+sCPu5+pvUhJ+05s8pIArGGwPLJO02FADbatKLCO6
         tWg3aT+GkR0Bj91SkbXhH/+thn//w0zFjf8RyDfOWwo71u7JMYU25v8sLxv/IaG4Y9+a
         dURZ+6fdQlOAhqUGxIa9dZIwn/xfmD2HJgXMr15wYcfXaZXSFcbGrMhHp33VLuT0qGaF
         nqnFi4kLLqk/e2rXCHYcB9wsDLrX9dSfm/tNICByNF8amPcc1C8QJoOGjCG323pR0kOi
         wl/Q1aOuOcJu4oAzezlljsQdcPIhX20ZQOpSOtZwLD3T9y0dCoBtV7WVCuTyDHllikxC
         EhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahctvAGM6XY64zu2BVGUKBwiv00peOLEBIhqPgdaxkM=;
        b=njO5ktG6Hvb3FwCB96Jk73RM2tHuiGQ1fY+dc2CQN7BNVa/fmHRQJZpOeybsmrviQB
         5I0DSOGZYhmsAI+e1+An20Tdi7Amk7TZhSfQ853WZk1JCNw7Sn3o83LUQc7whubRCuAo
         775y9VKIPqe8TvlNxME9HZuLfrKvlv3GT+G8za4ZLBwgODUAh1ZhteE038IDy6SwvSBQ
         kyml09Lkw7MlVqGoWae0e6VGCTSZbU6yuQZem8ua+360l4NLqR202jXpIAEh5IFQmnXc
         +9W8VSebqdEFRXRItyVwNhIrS9vlzTlODUtCjidT2ILBxfsKGM48CO1MQiAbkuAUA89J
         Nkkw==
X-Gm-Message-State: AOAM533KUZfn4Ymo+gtL7ZNxrVKZPYKUD5AdoGgB6JZZ46BYZAmzelTm
        8rYSlANRREJeL4Ia5aImdO9UI4oWUGr1VXjU
X-Google-Smtp-Source: ABdhPJxK/V7QxdATzECBp+pzO1QaQl1dh3nPyFkmAl1CgrFladhsoMKe25diUyoaOmA+t9LTr+zUNA==
X-Received: by 2002:a37:4c4a:: with SMTP id z71mr31852399qka.2.1607444715885;
        Tue, 08 Dec 2020 08:25:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u20sm13491715qtw.88.2020.12.08.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 34/52] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Tue,  8 Dec 2020 11:23:41 -0500
Message-Id: <cc97c407f8426346fdf84b9792b5a5a3b708f26c.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 916f9ebedc8b..c99f50969e24 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1860,10 +1860,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2

