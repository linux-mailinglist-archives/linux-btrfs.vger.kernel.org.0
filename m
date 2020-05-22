Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCD1DF119
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgEVV3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgEVV3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 17:29:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8305C061A0E;
        Fri, 22 May 2020 14:29:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so12122783qkh.11;
        Fri, 22 May 2020 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YnkleiRVR9Tj35XAzzQB+JDWcUaygxu/Dj+0wqS0CKM=;
        b=JPttV3u5QsPhDrtKcc0NrtTsbNyfJR1LAVv5omshDRvz1FF7apALqHYBHEVw6nyP4D
         /WzbfMGHjCfLdqCoVmtcE7WgrybJdsIJD8y3Ki1CXDVl3L8MYc4m94m7eqsoLv/3l96V
         sMZ8jjI9Nb+y9i4l9DtZpAssuVaxP4hKpf1saHGJQHYaG9k+Efwd/aCdBPr86+09Bkss
         HRuMymlB/k7JzTaJraErrn9NP739ovEQteAfjVOZ3UEDdpR/pMw9nW9It6QbKJ84R+0L
         4nIV/aNF16qMk5c8c/I+HaWFXJI9pIgREM6XbiMN1mwRaDCWYcqIu0C2Bo3dcXPKmjBC
         QFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YnkleiRVR9Tj35XAzzQB+JDWcUaygxu/Dj+0wqS0CKM=;
        b=NepddcnGPgZPzEXlD3AXNwFwG5kLQhTtNUOjNL4qF4w9wTVbTisX4aX0GF++YgGebx
         YHrFElwfidTeJfr5WdufgxBNjtd9h1Vd34RhQIGxvGojK8VjsTJ662cu58GJjOox3dHD
         ikbde2S9CIkh2Rju5KLGqwqkMUxTVDT1+CtH0yx9SF9ezP1CKcsuujsSanBv0Kq0H+yw
         wXhfeKCOxgb6i+RJarj7cHN34qn4zFexe9PqB9o/0LNLcLlb6a68XlIhOT6qh9pA8Ue9
         U8LYhuW1tRKgsyI5xpWVDWMWpzu0O3uFeBVK2VdGBg1f6U/dlvK+LOUCI3+lZv8pOGQ+
         pTIA==
X-Gm-Message-State: AOAM530uz0CyHJQyAL11AKrl6vVwIbOX+CkMDzfg36M/BnB85zy7hJ//
        JMixAYL9kKAX+uhyZw2Vobw=
X-Google-Smtp-Source: ABdhPJw8nCgBxKaNZJCtODgdJNJvWFVRgtgmeHTbcnalvmD8hqFpF4/HGZFaMe3+Sb4IdQya2xS8kg==
X-Received: by 2002:a37:ad02:: with SMTP id f2mr16427574qkm.486.1590182947862;
        Fri, 22 May 2020 14:29:07 -0700 (PDT)
Received: from localhost.localdomain ([71.219.209.197])
        by smtp.gmail.com with ESMTPSA id w94sm2357779qte.19.2020.05.22.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:29:07 -0700 (PDT)
From:   Ethan Edwards <ethancarteredwards@gmail.com>
To:     clm@fb.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Ethan Edwards <ethancarteredwards@gmail.com>
Subject: [PATCH] FS: BTRFS: ulist.c: Fixed a brace coding style and space before tab
Date:   Fri, 22 May 2020 17:29:02 -0400
Message-Id: <20200522212902.20994-1-ethancarteredwards@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Ethan Edwards <ethancarteredwards@gmail.com

Fixed coding style

Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
---
 fs/btrfs/ulist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index 3374c9e9be67..1e0484c8d244 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -22,7 +22,7 @@
  * ULIST_ITER_INIT(&uiter);
  *
  * while ((elem = ulist_next(ulist, &uiter)) {
- * 	for (all child nodes n in elem)
+ *	for (all child nodes n in elem)
  *		ulist_add(ulist, n);
  *	do something useful with the node;
  * }
@@ -266,11 +266,11 @@ struct ulist_node *ulist_next(struct ulist *ulist, struct ulist_iterator *uiter)
 		return NULL;
 	if (uiter->cur_list && uiter->cur_list->next == &ulist->nodes)
 		return NULL;
-	if (uiter->cur_list) {
+	if (uiter->cur_list)
 		uiter->cur_list = uiter->cur_list->next;
-	} else {
+	else
 		uiter->cur_list = ulist->nodes.next;
-	}
+
 	node = list_entry(uiter->cur_list, struct ulist_node, list);
 	return node;
 }
-- 
2.26.2

