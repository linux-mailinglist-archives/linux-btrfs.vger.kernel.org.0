Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677D12CDD88
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502066AbgLCSZW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502062AbgLCSZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C98EC09425F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:25 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 1so3057644qka.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vlA2+6ci/9kPU/ENKvxuZ7QCJG1m9/oR5ZiPrjIAHg=;
        b=ZfGLqHj/RYRCuVi69q+7Q4VXCgANHm49BdPGAxUsrSxM+xXOvGsg+II3wddFGIWrdc
         SCcLSQgQ5tYQVjjY8jQfqb3YyuZ/n+06+d707P/SQWLSJfgIVXUxvDKT+zv1TuLiQx4h
         B8SKJ53DyWYd64yASgGHyHUZsGyZfm+ejLtKZFDYahSBAqC9l7McP2DoVMhHVQBVgf5c
         P0KfylsWc998YjnTZ9Xhh1+XIhb4A60NC4PZ0TqnUeRMvsKDAmsAu1IqxHKwITQIU8PW
         ssGL032HH1H6MnVknaxXRqHo9B3oJjFyiggfdyxAWAFVSD0g2nKqujrb/FqcJ5k9YUQu
         2iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vlA2+6ci/9kPU/ENKvxuZ7QCJG1m9/oR5ZiPrjIAHg=;
        b=o9SR6434INxb1eAE5xqIbLvETlJeBYHzweuflm8jB6pKNWWQtNpOdSofqNSMlhZZvH
         GWDQ4P3XRO86tgHxP5tMl+J/Uu2PNh9cWq4sSXqFgV7yhID+8ov1OoNxoL2bOS8e9pUE
         aJ1AVrbWcf7zPvyUgZ/GTpW15ilpI5A40PSbvtEW8Wh5v4LSx1NKFycJK3ikho6ChQ7f
         yPRGpp1/u6+4CGGEPlqFRnRHlLrWkDPz5rM3Napp/93BxuDAd/9gGxYL3wd/npde7VjO
         AteH8dKVoj3svr0sFWpwtRrjpUAWDKrHD4HrNQtlW9rlKeiv4/IFoV3gMdiCbemBVYbd
         b/5g==
X-Gm-Message-State: AOAM531nTke0m5+MpKDi8E3NM8936nO03okfXjEEnXe2dodIKJfAbiNx
        6qRq8GXQpLpHxfaggFOuFjysV5ZzKYvdkSWp
X-Google-Smtp-Source: ABdhPJxM7d9VPaWz+kY1kWOiEkw2kUegJSEsz44MfwQxCvGNt3TkljT+Mgoz/86xsizHTFtYyzww4g==
X-Received: by 2002:a37:30c:: with SMTP id 12mr4244087qkd.110.1607019864484;
        Thu, 03 Dec 2020 10:24:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b73sm2287348qkc.87.2020.12.03.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 48/53] btrfs: do proper error handling in merge_reloc_roots
Date:   Thu,  3 Dec 2020 13:22:54 -0500
Message-Id: <9ad2a3b417b1f54d75231b1c1a3b6531b9746f79.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a BUG_ON() if we get an error back from btrfs_get_fs_root().
This honestly should never fail, as at this point we have a solid
coordination of fs root to reloc root, and these roots will all be in
memory.  But in the name of killing BUG_ON()'s remove this one and
handle the error properly.  Change the remaining BUG_ON() to an
ASSERT().

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 511cb7c31328..737fc5902901 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1949,9 +1949,19 @@ void merge_reloc_roots(struct reloc_control *rc)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
+		if (IS_ERR(root)) {
+			/*
+			 * This likely won't happen, since we would have failed
+			 * at a higher level.  However for correctness sake
+			 * handle the error anyway.
+			 */
+			ASSERT(0);
+			ret = PTR_ERR(root);
+			goto out;
+		}
+
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			ASSERT(root->reloc_root == reloc_root);
 			ret = merge_reloc_root(rc, root);
 			btrfs_put_root(root);
 			if (ret) {
-- 
2.26.2

