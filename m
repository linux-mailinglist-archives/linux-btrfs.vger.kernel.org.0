Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AB2DC49D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLPQuZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgLPQuZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:25 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08DC0617B0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:43 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d14so22473607qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIfUdd9SMDMV7st/xib0XwZ+96qQemHgJNdz3/SGt4o=;
        b=mEdvCku8cUTU4ytkdx5/xTyVHsgf5crSy8V0g14UjjJjpbAZLOZ25NrH8h8gMmJ1Wh
         hsf45dDXjPAKrQVjyVOGVmzQ5aRBMmFlCkYg0hLF3ufBf3xDW117H4Eg0GHYwMx51SpU
         NjAghfY27TfB2Mqp/eH/xds0rv3cuLjuO1WhNUmnay/+t1d0DRzQ9yqE4z3L+oEo0ERI
         dsrkcIUihAjO3GJ4sdDvA949J2mCIv6LDZ8+6q/GUsTbxLvRH/8TiVE+A2RezFUL8CCp
         jaRYp5fvBaNwCMDuO53chpF8+gA78ZkZWOpmdyNFyULifSCFR9Ax8g589p0AL+TcOGs7
         NP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIfUdd9SMDMV7st/xib0XwZ+96qQemHgJNdz3/SGt4o=;
        b=TftXxB0AMARqxIyXgczyG/G44Gyg+1Ny24eY1qiirSd2EWP6opm9MAAytqrfMJXn+b
         ZnrZ5l4kGy41xMMIZIMaX9Up4zpUQj+OqUR+e3cxA33hFkHee+Rrz9oveH/MvdDN+K3v
         jzh89083GdUG5Xvm2xCuwg7MluhJusOMUIwPDiib/26LAjDLj3dvlhzyR8Zw05l3p1aO
         Dy4DFsRHRx86zWtx++Y45i2+vmeuStnNQMAT7/hM59pyhiDxl42oyTeL/oGQv3+miGuZ
         9mC7oETkxr7iq1tAnh1UiOI6qzGraRip0SRQs/nvIOOcLc68WIDJzmH2Z4jjeCTC5rQR
         fGxw==
X-Gm-Message-State: AOAM5318bfIfSTqUm+viiIhv0uoS7Mo1CNBzy126p6DPgb0Ii/u6TvCn
        RCAa7yHjIyOHp8MiMLHq0+ZdOxu+jSXiVzaA
X-Google-Smtp-Source: ABdhPJx27wTtrnuCqfqbrYn0atKoooWzbQFvNOVe+TVzw0T9ITw6nyxBKHyZgu7DtUZSHRKMkiSGEg==
X-Received: by 2002:a05:620a:126a:: with SMTP id b10mr3941842qkl.354.1608137381908;
        Wed, 16 Dec 2020 08:49:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 190sm1559030qkf.61.2020.12.16.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 3/6] btrfs: delayed refs pre-flushing should only run the heads we have
Date:   Wed, 16 Dec 2020 11:49:31 -0500
Message-Id: <a32cf92bd7cfc7bc4b2baaa1e251860626c39231.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137316.git.josef@toxicpanda.com>
References: <cover.1608137316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously our delayed ref running used the total number of items as the
items to run.  However we changed that to number of heads to run with
the delayed_refs_rsv, as generally we want to run all of the operations
for one bytenr.

But with btrfs_run_delayed_refs(trans, 0) we set our count to 2x the
number of items that we have.  This is generally fine, but if we have
some operation generation loads of delayed refs while we're doing this
pre-flushing in the transaction commit, we'll just spin forever doing
delayed refs.

Fix this to simply pick the number of delayed refs we currently have,
that way we do not end up doing a lot of extra work that's being
generated in other threads.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d79b8369e6aa..b6d774803a2c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2160,7 +2160,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	if (count == 0)
-		count = atomic_read(&delayed_refs->num_entries) * 2;
+		count = delayed_refs->num_heads_ready;
 
 again:
 #ifdef SCRAMBLE_DELAYED_REFS
-- 
2.26.2

