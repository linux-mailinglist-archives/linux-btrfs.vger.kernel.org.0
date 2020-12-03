Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8862CDD73
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgLCSZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgLCSZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:02 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270CDC094254
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:05 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id es6so1429525qvb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ3N5Xz5HqHBUZlvTRm0YcZnf8FPKOJb+gKET8jp7xc=;
        b=vtG54BmrB0f8I63T/dfFw75RBiOYjp25dm6Nil4ZhXPobg+EG6kk5Io1kmfXGeavW9
         HBHfkW0n9y/wm/RJMhEKA8k+NhEjY6hjuqPaop9D4WfZbbhITspEjsVFjapV+FkQAU+v
         7crdbF0CHwEZ1n9odxdkeui1NP7UFBWifXE22nYX+c3S1OqL95Xki/VNirq79mb5GV2W
         YbxRAEPiJo83wACs+fAzKqtcyz4+A2VWMCXQE95wp5Yj2I7v1xzY/EA76Pxiv01KFPaL
         rHMlWiU+Rh7PT0bcw4ofezg8+8Zo2tvshPmIDVjXBVG6BLP+K+r8fhsiXVwMvh4OmlVb
         tuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ3N5Xz5HqHBUZlvTRm0YcZnf8FPKOJb+gKET8jp7xc=;
        b=PJ5PBHRx32NcqyZjrbvkC4J5KNCJTf5QACRWt9EpdO3FzNQzYqQMz44bLD4reoGWC3
         HaywmvBTxpDayYqE31hS0+e4eUp6qP3kG2sy/F8zRKSNekcN+mh3s7XlvNbZ1FLQmzyM
         ConUDkKicIkPHOMuljt338Q3BYLR2u4+fzJwdta0cXnuJNIgCmQ/7YHxenqjXcEIieR0
         FmyVJCscHPBKULj2czL33Wt/2k04v2flfLLJfaYE+IGBgggd7fg0Azk58nZs6sFwBNYe
         TM51jc6nc8mL8Ld8MxtUFapdyDh/qycK8CmrTzFdPO3bQN+/MMNB/GPDTGO8EmZP1p3E
         HbEg==
X-Gm-Message-State: AOAM530eD8u3h5UImqDZMS2//h8qROvOKGStknHKuN6kBEAhovxi1T7h
        Q2i2irxckTnc/GAQHBB4iLhJSQV4DEvSHyRk
X-Google-Smtp-Source: ABdhPJxHrrMSTG5brAehmQrkasZWFCpmmXOwv28b52T/VXQRb6p71C+ox+UtLuQpXnkJyJfn4jkwfw==
X-Received: by 2002:a05:6214:b83:: with SMTP id fe3mr207944qvb.24.1607019844097;
        Thu, 03 Dec 2020 10:24:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y23sm2062682qkb.26.2020.12.03.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 36/53] btrfs: do proper error handling in btrfs_update_reloc_root
Date:   Thu,  3 Dec 2020 13:22:42 -0500
Message-Id: <c4e7971a763f562efbdab30a21a5aa797751d430.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index b4ced3a0ca6f..ee175d2a5abe 100644
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

