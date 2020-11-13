Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DC12B2049
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKMQYc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKMQYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:31 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B4C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:31 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so9309931qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MOQXJosSEEsBSw/9PpMa1Vi34G13SUfbMB8xHmoqWWU=;
        b=CnCuU97zpQSQFUnk1SBg7Tg5UsTMqbGAgPXoV20BJI6t+gfhWA7bIq5Yt0UtBACrPN
         RYr4A8aFMpgbcK9KaSD1AYTBnlfo27o8DY7FtttXd5BTtGY3Ccg+AErsgH/RKJ9Vs0Ia
         CQdbZu2h/o3RJFCeCqRL4w67dNmrHxlC0wX4vWEItNTmWCQPsAXdo3uUiQqeLANec7Dj
         mkJGnSgkHXiMOdgoEFXqczqHQoOQIgw22QiZkDi1hf8n3bpzK4A2/9MTmv/AA58e2FU9
         CRlGSVyfPFn71NGQ3ToZ42bBS9FsRJi89vZlJhpJiXsxDjvcmAYLhalnLq54bkml3/hF
         HWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MOQXJosSEEsBSw/9PpMa1Vi34G13SUfbMB8xHmoqWWU=;
        b=ZZbW58olmzL7Wys6I1xH/qwjkGRMeWPXM+2A5nsZjYU9LhQ3358Ii9xJC142wpuZ+y
         GHUQeq1fCgN1q2OQ1+LwWeQnh5dNzXdyDJyAhufPjoALM23A7YNFMuFOpqDylrergL75
         8AcWivW7SiEe/PTFWCOCX+qCGkK+/4uRQ4vvUNMkZkRzRtiIKgL7NUWFFot6epo21wqO
         +tLPBcnhE43YqvDSs6HY02mn4tAAT2KEC1wkwSSBATvsO80P6kXOoJke4X1DWhWo8PG8
         hsGwz2MgsMP2lbcUCrWoTjD9dNEJX6XFFQo250MiCPyXKbEfaY2KZDGq0YBjHrEdDwWP
         NZ0w==
X-Gm-Message-State: AOAM532/tFVzLEqpo53ewGjk0rpDF/FzFVO1SsDGKG/78PWleLjt7rwj
        cDucnq57CSrTJmB7W7KALGderK+z7pejKQ==
X-Google-Smtp-Source: ABdhPJwf0sVJ/94d3KkweG/TXeyfbA0ty6RZCXer9iuY1F6gWOXW6XbPk1MnkgHSEKN0n4y5cH1MEg==
X-Received: by 2002:a37:4491:: with SMTP id r139mr2801699qka.244.1605284665028;
        Fri, 13 Nov 2020 08:24:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d184sm7069717qkf.136.2020.11.13.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 27/42] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Fri, 13 Nov 2020 11:23:17 -0500
Message-Id: <d2e734f398a77ec28c2e24fdda104147d8bcb45a.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 75272ef03486..ec6228de3ff6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -894,7 +894,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -927,10 +927,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&reloc_root->root_key, root_item);
-	BUG_ON(ret);
 	btrfs_put_root(reloc_root);
-out:
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.26.2

