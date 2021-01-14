Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D552F6A69
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbhANTDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANTDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:03:32 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30097C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:52 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a1so2797920qvd.13
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JYefdxrobOV1rQEofDea+JCI8iReXUtrHjFcLZAe9Xw=;
        b=B8hyGL5KRJEQi9J2lzt6BOdgQI9MV35TuBkycEOLhFB7EBsY2V/YEEnMIwX3MTtwKv
         jPdfFG6M3GMfmEVFr/ps3MefwxVUzcXxdbV9VOMPaeIcBivgci9PRcWek4e/yWZHgTrM
         5MiiPOIdkIHEQlQQCBH+WveJsnlsLNGh6vyqSUae9tUDD7Zp4CsNe+Oep5hlqSnnB0rZ
         8hNme6xoQ+96F0k99N7L9StahV61quIVGa9JX0vPjRa9zFifnt7/1EzZDz4YhTu40ay0
         gVGgExPVRQYRXDu4aV2jHLHGk/IE5hqD5IzrBODc5eILN9bkKh7DHr4hrA8/FSCiE5G8
         sYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYefdxrobOV1rQEofDea+JCI8iReXUtrHjFcLZAe9Xw=;
        b=nLFExKYjgi3zulpQwzxW/lQff1VLEA1zgkvMf92kcMrubkWTGn3cxUMaizgVgFnso4
         Wv/KaE4+HRXHXN0op+pYvJfapd4aonCNzvWLnr0iitmHk8u6bZrode6wl5G/Rk8iKyr2
         T+YxRMpNE9yja1UxmjjznnUHJJ1W1r9rMMz9B9vPQGaEOA6Jl/zBmFQRdku+vmM77AFd
         f83MfFmikBJboAy+mbnO4GcTfIZwESyHPUQXp5reqiy3Hgm2fYLrd0pymTFxqX4B0VKg
         4IyNSeogowrdVFwGeDEK3HC4w1XM1GPHTPlLHTx5JB8fenRyCwhbS9+VXCki/7C90A0n
         NQlg==
X-Gm-Message-State: AOAM533u+xaAXtZ3fIXo5yA0udI6xw5g8/nDop3mhFBsdez1Shc22M8Z
        QD1OkOErZ9MdTOeffg1DH/URqOyPauXNWD3O
X-Google-Smtp-Source: ABdhPJxJ0FJQ/U+9+9oaZ8vIfIYJmWOKZX4oSpwxluWFg5Bt68Ektcu5cFEHz8+DP+cE/ZARCY0p3g==
X-Received: by 2002:a0c:ebc2:: with SMTP id k2mr8551518qvq.24.1610650971023;
        Thu, 14 Jan 2021 11:02:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c20sm3327671qtj.29.2021.01.14.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:02:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/5] btrfs: fix reloc root leak with 0 ref reloc roots on recovery
Date:   Thu, 14 Jan 2021 14:02:42 -0500
Message-Id: <aa39cd6739424107752368ca4911b605b64eac07.1610650736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610650736.git.josef@toxicpanda.com>
References: <cover.1610650736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When recovering a relocation, if we run into a reloc root that has 0
refs we simply add it to the reloc_control->reloc_roots list, and then
clean it up later.  The problem with this is __del_reloc_root() doesn't
do anything if the root isn't in the radix tree, which in this case it
won't be because we never call __add_reloc_root() on the reloc_root.

This exit condition simply isn't correct really.  During normal
operation we can remove ourselves from the rb tree and then we're meant
to clean up later at merge_reloc_roots() time, and this happens
correctly.  During recovery we're depending on free_reloc_roots() to
drop our references, but we're short-circuiting.

Fix this by continuing to check if we're on the list and dropping
ourselves from the reloc_control root list and dropping our reference
appropriately.  Change the corresponding BUG_ON() to an ASSERT() that
does the correct thing if we aren't in the rb tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9f2289bcdde6..d29baf3822a7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -669,9 +669,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 			RB_CLEAR_NODE(&node->rb_node);
 		}
 		spin_unlock(&rc->reloc_root_tree.lock);
-		if (!node)
-			return;
-		BUG_ON((struct btrfs_root *)node->data != root);
+		ASSERT(!node || (struct btrfs_root *)node->data == root);
 	}
 
 	/*
-- 
2.26.2

