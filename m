Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A098425C8B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 20:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgICSaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICS35 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 14:29:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A7C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 11:29:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so4012659qki.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gt/eDVeEdFuDn8dqTT0SBDSm0LPtNSpyzVzDlaPztTY=;
        b=xJ7eoUkbANo2rIhh7LZ0Rf1WAvMxdhWMG3Dc5gVBf+VUzGvw2P/FFRo0cTBlDpCpSO
         Pm7RcNwqcmG1SJqlYar4o/xaae/lFq4W92OhEjGggMFB/3FxLDtWFbnt9b9mJVut+h/J
         0vhhcUCXLF+sh6vMBzL724BGB9rgTjK6z+U+QmpHqsmGM91TmssO3W28asgaYGBK+S/r
         /sGRZncXxW1VKO1mltNW0von1/ieoAs+ywPafhJSSpL9h1sI1Irue0zthKNOQ0GbI90s
         yL7Iz5HKGQnWmIBzNseX/l8J5NtTBnhudEnqbzw/FO/z6akug8eqE0ck69FQD0PksbVl
         MpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gt/eDVeEdFuDn8dqTT0SBDSm0LPtNSpyzVzDlaPztTY=;
        b=ahK9WRfyUeWw8Mx3+ydWixd1LWF/nfpfUvfC1uBKKgXSBXNDt2zkXsXIicrWwibp/h
         qBq9wHo5AthgEEGIN+m8r8XolFfKAbGuPfSH9BoULT45+mIeZSFUkTwbS59gOs8RsASt
         w4OmNHtv81C6CHg6/PmOQiQ+bGpTwYOln8Clv6RlEHXWkQPGruHuk44wgDgkFsBab293
         Vw96rvDH99FsLtlWrb4EZbmdGvO7jvoj/W1lYE9nE7smzI8ORGqR3TBKaZwC57y0gZ6k
         BAdV6eH0BwNlpzHHGesJvGSth9Di2Z2dspiBanwvgZoxjMJVP/U4ZcaeJfrtSLyqjZ+m
         LGlQ==
X-Gm-Message-State: AOAM530DwYVcXQsKeRgORGxj1+NxYhn61VxAE/6XMqGcFUQ6zcoft/5M
        5Szb6Th/+kATow/gr86Zw5YiPee7vqLHLO2l
X-Google-Smtp-Source: ABdhPJwybeAWekQunoCBBw+1vfFo0p4oKr15BxXPIsrS24TlBgFwRZkIt+psItdKNwhcuIesG/IGaQ==
X-Received: by 2002:a05:620a:78f:: with SMTP id 15mr4276985qka.340.1599157796141;
        Thu, 03 Sep 2020 11:29:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n33sm2611929qtd.43.2020.09.03.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:29:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: free fs roots on failed mount
Date:   Thu,  3 Sep 2020 14:29:50 -0400
Message-Id: <1b78425a6899ac5689e432151b6bf6c6e73fd73c.1599157686.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599157686.git.josef@toxicpanda.com>
References: <cover.1599157686.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing a weird problem with -o degraded, I noticed I was getting
leaked root errors

BTRFS warning (device loop0): writable mount is not allowed due to too many missing devices
BTRFS error (device loop0): open_ctree failed
BTRFS error (device loop0): leaked root -9-0 refcount 1

This is the DATA_RELOC root, which gets read before the other fs roots,
but is included in the fs roots radix tree.  Handle this by adding a
btrfs_drop_and_free_fs_root() on the data reloc root if it exists.  This
is ok to do here if we fail further up because we will only drop the ref
if we delete the root from the radix tree, and all other cleanup won't
be duplicated.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0df589c95d86..7147237d9bf0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3415,6 +3415,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_put_block_group_cache(fs_info);
 
 fail_tree_roots:
+	if (fs_info->data_reloc_root)
+		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
 	free_root_pointers(fs_info, true);
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 
-- 
2.24.1

