Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD22F6A6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbhANTEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANTEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:04:09 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DFC0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:03:00 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id p14so9324926qke.6
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Kg+g9k9Xgo+a8nvYyCZ2YvBKfy3R8nKXhmyCv6ietbI=;
        b=KB/zKjwdwwCoW+4VQ4LUn9ZFLd7O9CHb2EDSYCL/ALc2k8TUxHN8vops5chHpWBIQS
         qjg8gU8lSOHkldCdlce5Jb8pabgJhDm59ftZFsK9toeblZcyhvwkArkXH2Zzjh6Bpe7j
         hb4/c5n1qOUxP5Xcxb5D5hkn92DK7tVtqwy3VvGn6OrkFyUdQW4nwcGsbf63owspurXV
         JBXedbILdsirrwumkuzdGh09LkTiIow83ufeQtj4yZM1sZ0jsO09eWfR/r4YnBZYwmQ8
         Pvmn302KsFmyxSe0/B7Ab1L62abFrAh7hga2fAOwf/DYteXvqbGUCt+L3n3Z/dODLecS
         6hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg+g9k9Xgo+a8nvYyCZ2YvBKfy3R8nKXhmyCv6ietbI=;
        b=HaIZ90DjVh5ShcQ9Rme2os/ueWLM6izWI1dkboxoSfScWcWqxpRPlMzPk9c/nW24WM
         2dS3X7bHKHowomfivK65D4O9YKqek4wf5nHjvOLrMt2hBx2BTXdgevJC+JFIxm5Ak3u5
         F51nJL1/QtH0MPNC4XiJYF3LIYO6aZ28IauAQtq24EJOWcRvCGRqD8bV1ec4iKzAvdTt
         gREEKKdxcMCyjL6lnrZwmmCoixk1YByY8+eVkDzEpIMmc19G//Xi1rvOlGVS3+xI4A+s
         Ik3Ei1xvxopMt0RItvIvsZHlanIZSR5JZNmB4fjJO5vUKJv85kU/AuI2KZJFK31EJfwa
         /+ow==
X-Gm-Message-State: AOAM532zyjzGJD+vkbEDsF0K37QbXo33euFUPwfAIEf9guCTUAliRgot
        YW9LrDPQimtqtlW1TLA/LQmiehXUrqJjiyvN
X-Google-Smtp-Source: ABdhPJzqZY/j7P6jXxwkpIZ6WvJHQnt1hMOQjTMp02ET/VjnwTxbdIbDaiqedUfVIjPhRz0TjqhSJA==
X-Received: by 2002:a37:e211:: with SMTP id g17mr8307963qki.298.1610650979083;
        Thu, 14 Jan 2021 11:02:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 60sm3345639qth.14.2021.01.14.11.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:02:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/5] btrfs: abort the transaction if we fail to inc ref in btrfs_copy_root
Date:   Thu, 14 Jan 2021 14:02:46 -0500
Message-Id: <d8c8d547526b4cb3f0141caf297679021eff2365.1610650736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610650736.git.josef@toxicpanda.com>
References: <cover.1610650736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing my error handling patches, I added a error injection site
at btrfs_inc_extent_ref, to validate the error handling I added was
doing the correct thing.  However I hit a pretty ugly corruption while
doing this check, with the following error injection stack trace

btrfs_inc_extent_ref
btrfs_copy_root
create_reloc_root
otrfs_init_reloc_root
btrfs_record_root_in_trans
btrfs_start_transaction
btrfs_update_inode
btrfs_update_time
touch_atime
file_accessed
btrfs_file_mmap

This is because we do not catch the error from btrfs_inc_extent_ref,
which in practice would be -ENOMEM, which means we lose the extent
references for a root that has already been allocated and inserted,
which is the problem.  Fix this by aborting the transaction if we fail
to do the reference modification.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 56e132d825a2..95d9bae764ab 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -221,9 +221,10 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 	else
 		ret = btrfs_inc_ref(trans, root, cow, 0);
-
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
 	btrfs_mark_buffer_dirty(cow);
 	*cow_ret = cow;
-- 
2.26.2

