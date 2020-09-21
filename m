Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB35A273047
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgIURDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 13:03:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42100 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgIURDv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 13:03:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id b12so14837345lfp.9;
        Mon, 21 Sep 2020 10:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CrJyG3ddy1yqE5EHK/s9PAflZP2qnO9iNUuDmPM0w0=;
        b=YT2SKmOC+yeJYQ3mPZQyCYNV32dSvUpe9vG7L2gLqBGV37o4whDorIp92e3hJXBkOD
         JXU1tp2SLXjkW+qDqu0E1+G7sBf1rHv4mR4+VqeqmNg/UqNAoxMw4gcqha+0rdw/gFx4
         y+eRhuD+Xx/wUx24NOCtoBMoJ60BganonQl3mN16KkmzY4BXEYH41khSkkTT6bjwM480
         vR/LjixgOTvb7rm1cdxgYpKdQNqB+RJBRgzViyMw1bB7AFkoaFqxgW7C0y3tXv1zemtl
         JsvQYMrQsKF8oxM4LoZmbJC+HGbelG+/vJmnWHkY4cT49O/sT8qMM09OtOSr2AWABVlZ
         zVow==
X-Gm-Message-State: AOAM531s1s/EURFTm/6yAOOwnBkJ0ieBw8Nt7CWYG/BMfNlxXEflpyWm
        H5mgC5RXSKnB4CJap9vVZfA=
X-Google-Smtp-Source: ABdhPJzdz2V3SyrsoMH/S6hyA0iHuIAZywlJV57P81G63zh0Zscugbwew5VnSJhP09HLn2VJQ9jb0g==
X-Received: by 2002:ac2:53a3:: with SMTP id j3mr333399lfh.86.1600707828703;
        Mon, 21 Sep 2020 10:03:48 -0700 (PDT)
Received: from green.intra.ispras.ru (winnie.ispras.ru. [83.149.199.91])
        by smtp.googlemail.com with ESMTPSA id c22sm2689992lff.202.2020.09.21.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:03:48 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] btrfs: check allocation size in btrfs_ioctl_send()
Date:   Mon, 21 Sep 2020 20:03:36 +0300
Message-Id: <20200921170336.82643-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921170336.82643-1-efremov@linux.com>
References: <20200921170336.82643-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace kvzalloc() call with kvcalloc() that checks
the size internally. Use array_size() helper to compute
the memory size for clone_sources_tmp.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/btrfs/send.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c874ddda6252..9e02aba30651 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7087,7 +7087,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	u32 i;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
-	unsigned alloc_size;
+	size_t alloc_size;
 	int sort_clone_roots = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -7179,15 +7179,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	sctx->waiting_dir_moves = RB_ROOT;
 	sctx->orphan_dirs = RB_ROOT;
 
-	alloc_size = sizeof(struct clone_root) * (arg->clone_sources_count + 1);
-
-	sctx->clone_roots = kvzalloc(alloc_size, GFP_KERNEL);
+	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
+				     arg->clone_sources_count + 1,
+				     GFP_KERNEL);
 	if (!sctx->clone_roots) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	alloc_size = arg->clone_sources_count * sizeof(*arg->clone_sources);
+	alloc_size = array_size(sizeof(*arg->clone_sources),
+				arg->clone_sources_count);
 
 	if (arg->clone_sources_count) {
 		clone_sources_tmp = kvmalloc(alloc_size, GFP_KERNEL);
-- 
2.26.2

