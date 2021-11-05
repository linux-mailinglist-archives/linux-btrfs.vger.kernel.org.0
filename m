Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FEB446A02
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhKEUs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhKEUsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:54 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460BC06120E
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u7so8336974qtc.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=asZdoKSDjmIrE7eQTEkp38011/Esa3FZnRjeOqa44VE=;
        b=r2Pv+9MrSeRWxDkXA8lPhRaYJG+cBHoqzm5ccxI9thcoaUXVUygE3MhaxeSeYcTXMI
         4vE/NiM4cd1/9FLifCUeEUgDElVNLLKmYUzbSsK7+DAKDSIHji5W+bpCcfhXNg1lN2Fv
         7sISkCHe8YcXyb6tBNpqlzwxyzXk9CX8iOqxL+X4Rmz8aFcBLdKeUPq/BC/3k+GXHqDR
         kajbBw+6IdTXcHRjDjYCXGBsFWMEAHZCpkW8le+UPcwj2MbdKRjq6Hp6mGfW3huplFDk
         EdNhPdjwvGMD56P/5DrgFtO4GR2LGnjFqzp05ADn5lkS+wruTXrtpDkGGRXEpIzGFTUn
         WiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asZdoKSDjmIrE7eQTEkp38011/Esa3FZnRjeOqa44VE=;
        b=2kGPyG9KPJMo9uEwbA/OxAYZ32U3I1edRjBKvUnbSMDVN5+8XYXBWiL8sqF4t3cz7s
         +LiyYgHsvsdZWesbbB2EtR/e9P7ZY0oKGhnkLuK9YECYyMaG2IaTfVcj5gTlriO8XLEi
         9t7DhpF15uXBKws0JlHt9hCZdyoabAz86u2FPt/5ZoPEGMd2rutnnibzRJuiHTnQaQfA
         rzoxdQpwUBLEXDz8N2Ssa7IptP3orlIEtGNSUMnnPyICn2vKudF5R/34kP/xh5FW2W4d
         e+9n580A1DtSQHrYlsxr4FxPHaLJYvD94jTo1uGkj+DtNFihX1G4EiCyYQuTa0Jc8wQp
         aiZw==
X-Gm-Message-State: AOAM532QU3j5nxgaDBFYDSV/LDJVrrwYYqWzIA0P+qK25RGCHR1ovkms
        Ajnd5Kj0AOhoqA41VIawjP2mUELVIcroAA==
X-Google-Smtp-Source: ABdhPJwMtZdutnZ+2xS43q7ektfvX+uXCsJ/6m6ipHQGCCGo6I7D5DSV2rktedIBQXEAcyYrVYezZA==
X-Received: by 2002:a05:622a:198a:: with SMTP id u10mr20996519qtc.156.1636145172477;
        Fri, 05 Nov 2021 13:46:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i67sm5790887qkd.90.2021.11.05.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/25] btrfs: remove unnecessary extent root check in btrfs_defrag_leaves
Date:   Fri,  5 Nov 2021 16:45:40 -0400
Message-Id: <044f71dad030673718c4c888e1df2ca023ff5dbb.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only defrag leaves on roots that have SHAREABLE set, so we don't need
to check if we're the extent root as it doesn't have SHAREABLE set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-defrag.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index 7c45d960b53c..b6cf39f4e7e4 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -27,14 +27,6 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 	int next_key_ret = 0;
 	u64 last_ret = 0;
 
-	if (root->fs_info->extent_root == root) {
-		/*
-		 * there's recursion here right now in the tree locking,
-		 * we can't defrag the extent root without deadlock
-		 */
-		goto out;
-	}
-
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		goto out;
 
-- 
2.26.3

