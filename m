Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752D211538B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLFOqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37829 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfLFOqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id m188so6677101qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jBx27Gqp2ekqvTSlDXB8wC6n+Fi1D6493NIr4uiaG7Y=;
        b=v4/TlfEgK+em1gXzgCfLDMGi4eR/37YBFph/UdCt17qg+ZUQJb43HHtx4tQjKUscdL
         ekBXgrNqv7PMMrEaC4sQm6bmazYZvsYvnh4O9QUzCzjvus2JSFG/QZN9hEKPRLlXnSTJ
         SPpT6laOwROxBCC3TAqLCfyyuQ6hSQTGUh9xG3K+ZaYQPvTnWDHkrWWCaasSnf/Ym7cE
         sYIbwigCxs7ME3ML2yGmNhTxqHl+PROYJdVrqMVxB9E04BpKX3VhhzJdNz5UUNZckO2e
         kv8SP84QJtX+vT0wkvCJqPCc2kduKiQW4gVlrDpOO/ygC1FFm39ZiadoO1SCwRbvqJrn
         NkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBx27Gqp2ekqvTSlDXB8wC6n+Fi1D6493NIr4uiaG7Y=;
        b=As27F+OT26DBf5sGqIww7JMKhBpgtnW8UATpZ45O5Yur9TlAiRb6YE5vLj07lc5O2E
         qkLMbEpTEw/EoNd8nNZGYJ8cuhmY1YnSPIVHxj6umM2eeehc2eyfmOwIPl11KFmnOy2v
         u4YabNwJWRHzTLidTqpmVdXy/pae+Yl32UtfkyhfYMGbZYYmvem0fG53C1tt675+r3N0
         T4PwhulZ46ubP9FzQtNfhJXKRBm9PqFQhZv3KeG2x0u7IIA0WyaXjiyIaIaa7zKTIwc6
         EChEPwR0MvfFhDQF9cgrwMTnTlk6PKu/vzk8HLMy8aRTIqu32qFj3vy/WJ33scF1ETsR
         XWRg==
X-Gm-Message-State: APjAAAUOR0AUxWjjjYGm9PZn8a1cP6G18dOigoV7qBNrbelUdvFaUs5o
        GGJgKB1RCJGBHPNsqVQh6Xn3yXuqJO0l5w==
X-Google-Smtp-Source: APXvYqzC0l5wF2XzIit74kaqpz9U+WwhdT/USujD04p5VpVmcKajLinlUNekZTgjxjdoObQf6qvq7w==
X-Received: by 2002:a37:b95:: with SMTP id 143mr14160611qkl.73.1575643602339;
        Fri, 06 Dec 2019 06:46:42 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x1sm6063752qke.125.2019.12.06.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 35/44] btrfs: hold a ref on the root in create_pending_snapshot
Date:   Fri,  6 Dec 2019 09:45:29 -0500
Message-Id: <20191206144538.168112-36-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We create the snapshot and then use it for a bunch of things, we need to
hold a ref on it while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c       | 1 +
 fs/btrfs/transaction.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a3223bec3f5b..d5a994ab9602 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -875,6 +875,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	d_instantiate(dentry, inode);
 	ret = 0;
 fail:
+	btrfs_put_fs_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
 	if (snapshot_force_cow)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e194d3e4e3a9..7008def3391b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,6 +1637,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(pending->snap)) {
+		ret = -ENOENT;
+		pending->snap = NULL;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_reloc_post_snapshot(trans, pending);
 	if (ret) {
-- 
2.23.0

