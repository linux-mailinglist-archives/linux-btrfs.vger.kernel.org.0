Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24082339853
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhCLU0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbhCLU0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:17 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F6C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:16 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 130so25673023qkh.11
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQoML6oSbZ+u08kLXaeYpQkpl0U3XOHsxglIYPmzeVw=;
        b=WbbPALtDC9BAssh6VKapYxOumSAbE3TL9U3qdjkM31ywUGnvch+3T06Z9p3o2/9RA2
         GvP0ofNvTwSniAOra3NdFfoNnahy5quBnAKEHzG2sg/iP+Qbw6/aSMIOebdyF5dLM17w
         HqgXK2AhTbqsaLs3unNfdt9BHFwvYVmWsY4Gl5mc5WXufHhxFJRzlO+O3TJ1fEsvz3D+
         5ZCtySiMYordTUC0Y6J/8iYJIXnF2Q4jUMthjmxc4urFVkOZGMmR9PfNKHgszCWMqf6V
         uvAa86BPr0Ype2a3NpNQ2c8knQcCNEtmC8Ld7lNU4i+YsW0d8hjvquSkUtBjdHZ6Z42M
         vXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQoML6oSbZ+u08kLXaeYpQkpl0U3XOHsxglIYPmzeVw=;
        b=QNjMgdWNTvZlde976LKdxTvR1cs75rSk/MvWoWTZHWUOmF8Ru6myMiquTwQI+59naL
         HuQkYUjOzffBnztq+43yfAjSppr2xWV5OlMHUR1pwy6NOTNS3T458tSm1IPn8z6Qo5N9
         9BkP4oauXxxEF+s2BT8yTkjILYWzOT87hGVO/qoob6VVgZuaim+Hi+A3S40bi3GNBcZj
         POfnrkyPnkn15z6lhHqAxW0DHDP9CSHvIW/pJBzDa8YXBoXMz4hi7GI9c4BgUdwdnk8i
         MEVLNNY/Ppl5iXTrswlKE7+kkdbNwZpzCewkLxh/FTWMzB9Rsn4At4JW+6bHgNKvm/jn
         IXlQ==
X-Gm-Message-State: AOAM532Hgex0ywa9NJ9nQoCbo6EQugJRf15055U8XZoFe9eDab+zIu+p
        ensTp3I79TuHtXDP1emJux9kTxy/tFoq3R5u
X-Google-Smtp-Source: ABdhPJxUGtj0z2pMPfHWbbn14V6mOKvyxkVdEhwcVM5Hhwq+SSfI3aNv2rYmnvnQahY0/D9b2c1fFQ==
X-Received: by 2002:a05:620a:22f5:: with SMTP id p21mr14158086qki.225.1615580775417;
        Fri, 12 Mar 2021 12:26:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p12sm4487008qtw.27.2021.03.12.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 25/39] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Fri, 12 Mar 2021 15:25:20 -0500
Message-Id: <d1cb53886d888efffa348f5300db788fab432218.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We call btrfs_update_root in btrfs_update_reloc_root, which can fail for
all sorts of reasons, including IO errors.  Instead of panicing the box
lets return the error, now that all callers properly handle those
errors.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b9cc99d4b950..7b242f527bd8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -902,7 +902,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!have_reloc_root(root))
-		goto out;
+		return 0;
 
 	reloc_root = root->reloc_root;
 	root_item = &reloc_root->root_item;
@@ -935,10 +935,8 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 
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

