Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A142D12D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgLGN7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLGN7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:36 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE4C0613D2
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:39 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so12508399qkq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWlZsEARxMqv1Xgx8gX5c3Cln+ZPxSohBZjzdTTjAUQ=;
        b=Zx2HZpN8sEm0dXMylhRRjPNsFYYWq+FPXzdpB6RSpfL7FsKzVGtzTetL4qSIVjOZ8H
         1IRqQiMh1/h1Wx129L+PKLX+WtbPhsd+IqsmOAexJ5wkqPRg+SoG/uWFjINL+5Hhz99h
         WSiJsSFh0l/HOfdvynDg24oeV8CaWCLS9YGBiNFKvbcWmS8Zoli9zwdzZWchBjKVJXCO
         8Dw7Vrux52vJxRG6JovFXKCnkxwwNgBruMMUWJHtLpjEp6uT1SUd6ARrO2BBCMgOUs/I
         4i38ltKBitce9kHhzkBxUPHMF6r6v0yAXibQPZ9fvk58oDVXtGz0BUXK3p0RD6BAPx4+
         itHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWlZsEARxMqv1Xgx8gX5c3Cln+ZPxSohBZjzdTTjAUQ=;
        b=teHa5ShPu4KqY+a3yw+rQTdOeFDtlKCK6BIC+EpXhE+yR7PwEv0FpIOJ60raoqoV1M
         V2VYHwe399VCvZbLofHsy+qUkmIqf2A8qqip9HeOOUFC3yhjFtkEDjLU4fdFlTcl8OKV
         pjFNJyPqF9RkEe17UQ8j7ZfrENelePkokACnSpfDG9a3v0N/cuOkzsepAlPX89qPvhhv
         xmEjwXzxbTFQAixufUDcnbY03I+p1dVcUEcIWy74oR+E74GC6DcW9sXFHOI0lgrg04lT
         6kKAKMrAN0aTbW4BfAEoFHQrbZcy9MaKQZ6rWhR3mijdwC/j1s0KcmhHIwfIqm7mqUhc
         mnbw==
X-Gm-Message-State: AOAM530kVkp6PjwayqYag7LP1hVnCR9o8Q6vrvf7uHBxQ/XHul0XXkKl
        ibFT+wEKrEeGy6U+Z/bzq+btYurmkXeQ+iWH
X-Google-Smtp-Source: ABdhPJwIg7H6UC1coPxfUUjrsphrW47ZhhzcSPTZbtHhkmSScfFep3VQeFpzGY2bc042NSsFOzwcjA==
X-Received: by 2002:a05:620a:12d6:: with SMTP id e22mr24237452qkl.59.1607349518906;
        Mon, 07 Dec 2020 05:58:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b4sm10537801qtb.33.2020.12.07.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 27/52] btrfs: do not panic in __add_reloc_root
Date:   Mon,  7 Dec 2020 08:57:19 -0500
Message-Id: <5da4874bbf15dd264254c691d7784220f697ae71.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  This shouldn't happen
generally so leave an ASSERT() for this case, but return an error
instead of panicing in the normal user case.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4356af112025..a68ae34596d2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -638,9 +638,11 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		ASSERT(0);
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
-- 
2.26.2

