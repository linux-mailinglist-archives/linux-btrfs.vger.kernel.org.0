Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1932D12D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgLGN7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLGN7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:37 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6E2C09424A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:47 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q22so12508718qkq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/v7OXjRav6KqGI7SIs6G5lf5b7HJWr83Ws2znh3xAg=;
        b=xC0HyQtAcFNTyRIvKl7ZJYSRfF1DCkcCHzjbcqgbl5cxE8SitWjko9PsfGFNN1cNPu
         OcYIerln9tjLfC29FnBTPlNR9QQVkORpu7vyPIOetUwCnm3T6L9050MzSmYf4UOmXnRa
         SvyhhtPlSfxe8tp+2E/GuxQHWp0cNgOOjP78y28o1UBiTWK+4+8PqWPf1W1ePQowIi9r
         JJFEkxAOYxSP/jfipJ/LCMiaiGKDun8FogGwAXQlo6rztqdhju+uJywlkfrl9zRtn61X
         5pQ2NtxK42md/rZ7vbUxn6KCBDn7KZdnhCBY+m+94Y6w0CHe3sUhBb/pDQ2/LKvbJFtE
         TYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/v7OXjRav6KqGI7SIs6G5lf5b7HJWr83Ws2znh3xAg=;
        b=ZDi9XOawtj1EuANjQAh8+Dfb00qPDg5qFxsp6n830YNo5YX3JjNJP6fF8T2E/+8DBA
         7Pi2iWr/Vp3P5D/P2F1Lz2y4jdm0WVGsIuJQBqGi5DRYwWhgN91RfnF/pG6S61gHyGVv
         ovv7Xrpdmp7wA1wlqSnmPgwujDN+GsHcOUu2EXGaIqkwvtY5CPlg5HBOPDia8vcJpayg
         4yf3sNqZdQz6dhCZPJTteQPWbg15mVKzm71yVk4soqx5XbNUXv8nS+soRejKBzYnC9cq
         rQL0SnYkV3foEaIuizQq5yN4LuPCOwCq4VeGkGlgT22MmvuwbXGKNoBaq7Frp6bJw+mP
         6xYw==
X-Gm-Message-State: AOAM531Q/jsjZR7iyS4/AFhF6Pnbh76ymalieBYNTv4nBca6lod20DAS
        nCZXOiQjmmAc2tM1vA0YvIfEYeMK7x7rR+Fy
X-Google-Smtp-Source: ABdhPJypcWEBBcarb0hXcftW30oEpsooI4OAxi4caN/OQOsO1c/hKxRumnHOhjShMM/Gy9erID+mug==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr24404375qkj.259.1607349526294;
        Mon, 07 Dec 2020 05:58:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i7sm11393806qkl.94.2020.12.07.05.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 31/52] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Mon,  7 Dec 2020 08:57:23 -0500
Message-Id: <8eeddeed2fa7ca839fbcfabd9a9d7a5d740fc78f.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5393c0c4926c..5064beff3f9f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1344,7 +1344,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			err = btrfs_update_reloc_root(trans, root);
+			if (err)
+				return err;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-- 
2.26.2

