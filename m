Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A1115387
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLFOqh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37813 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLFOqg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id m188so6676749qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yvDui0iKYsyOEKeBTybYCyx7WqxXlZPZ8xZ+K+VP0tk=;
        b=wfyYsxaygwaObzkl6GqK5AI+f6u8wYBrEWJrAyDPFUEDH3qQQKo+T71SJTby7VXlEG
         N56O+rhPVdNQ9JtQN6m6ZropQb5RB3RCdUb5Qkcur3B8jhiXPqG7DvBifKr+s6KckuZr
         hxGwh2AmvhNw2EgZaDUZp0U5LNS2vvFaGYiWMMR9e2tzHjR26GIkpV0demCjOR7JaJiB
         DKQt81oGMWii9nsN8zdc5oCHUIzlJfkpX/s1fjtStPmBpBx95eEEgF3yg5JXnPv6JX+I
         fma24un72qgFE2SMOFLxyqWgV+dChjNyvCMvy53pMbkOfA+1mMPhWzwy3OfYMwzzbuLm
         7voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvDui0iKYsyOEKeBTybYCyx7WqxXlZPZ8xZ+K+VP0tk=;
        b=fn6Z2lB8aM0tETFkL7Rz0O5Hae7g7CgD8ThMSxEGCoEGmJIzs21c26vZZVAWFI3SGL
         LBtq/3dgAhiohIQhcERjBalN+o338e2iBLKkeztFEwZ1qqwoch6b0wqfUk2Cka4UzObs
         bXzCMOpC4gXKnuHWB4OOyEBbptQFakBmUaWitqTJA2nIZaFldwUk9U3j1Y0rw1A2ZgTd
         B9C+nIISLGSGCoJkUiQcBFF353GbJU+uKZb+TK25E2FJEZH9R3nWXqjKVTJsynZ7/zb9
         kXvAICegFIUI/cn7oKiOYevN5CCk4mXwaO+06WSsI2v9ZiHWxSwi8IpyEpKsFjNpMLmy
         8ITg==
X-Gm-Message-State: APjAAAWpQWj6E2eEGf6Nbg1ku9E9w7DTacOw1EOKfI2Qa7Zyb+BGgEeT
        MY3Di2ME3bcTysf95PbX/EgHHnlsXLPTMQ==
X-Google-Smtp-Source: APXvYqwZL7bcNDMDg7qY+2klO7PsTNoVaVyX21V18yxRmb+PtYufwIJf86CvTDG9PBZNiNt9bAZFFA==
X-Received: by 2002:a37:388:: with SMTP id 130mr13243957qkd.366.1575643595059;
        Fri, 06 Dec 2019 06:46:35 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y184sm5996638qkd.128.2019.12.06.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 31/44] btrfs: hold a ref for the root in btrfs_find_orphan_roots
Date:   Fri,  6 Dec 2019 09:45:25 -0500
Message-Id: <20191206144538.168112-32-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup roots for every orphan item we have, we need to hold a ref on
the root while we're doing this work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 9617dcedf521..cac2407cc003 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,6 +257,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
+		if (!err && !btrfs_grab_fs_root(root))
+			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
@@ -288,6 +290,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
 		}
+		btrfs_put_fs_root(root);
 	}
 
 	btrfs_free_path(path);
-- 
2.23.0

