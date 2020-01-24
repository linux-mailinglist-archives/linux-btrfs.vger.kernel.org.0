Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145D814894F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbgAXOeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41335 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbgAXOeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:34:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so1626636qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y98z689vOUInjSVPqNQnpoOFgpKnVs7895GrjYLrbYM=;
        b=t4QlFf9/vv/xp1t8Mj85TlpAL5MrKUMWgH/ZSlPIghRYcGvWilphuk6W2Srjl6hKvh
         Vn4SRQbSmEo0OgVp/1xrbsTSf+MP9KHbs7dL+Z9z3V60cpmO+avp3/My8PtQNCEgVKsh
         skL7iTgckMkYbdN1V8mw4gXJXXfuCmrwB3SS+vuCZmP24is8MfbafUsmpdpNMXa+/h8I
         jb4vS534K5NcUBlZX6atRwkGwurWssSzqTFljgatwUph549KmpcZpju/ibVMt7WmB4m9
         Bp6qRDBt7eFkAlNhgXxf2y2Kmuuj+O2dTyvmWWWH4KQrsBtgy4Hb4NBXFXucJKOYYiDp
         aPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y98z689vOUInjSVPqNQnpoOFgpKnVs7895GrjYLrbYM=;
        b=YCqDIEaNqUMzTSXLZkJqkfoUDG8s4aAgunG0hmopUxALhzCmbQqfLKxoXIjUvHGxw7
         FzEiyuwM2lEptjGaJirTf3mcMnI0+VrarA0MI2L+hvMqAPnxeibB1Pbs2Z4ZigNnD20Z
         Oji5nda3/4C0dvIgfXTZoG/k086UKbyOEWVJ7h4wZlurGoHxwDKx3xdbVoLgdVbPmSja
         Ufd0T5qLSTzJetXveHaOcZl1upPRUquPLG8yKHOB3+5m3gJEZo15C1BGG/zaa0MjDndV
         l/VIaXj7LXHtMN5TLmVABdZmhzFVXVBhEwO7UBElDhMtpNjZkJS0SaNBuwefEgtxDyUw
         pvsQ==
X-Gm-Message-State: APjAAAUNyI3gGtfj5WY7DoSE6bkgUtqBft+44aJnSuOmXAd1gJtHkoqa
        Lg0NEgoXWPMUr15lZ8B59C4cbFGChr7zwg==
X-Google-Smtp-Source: APXvYqxUYnChIyAR1kNyqwLGkxRS5P8SGzzFfBLbT63cFyyOtSkdpbr8WJGGjMBVl1S0b3dnp7hOyA==
X-Received: by 2002:ac8:4244:: with SMTP id r4mr2373583qtm.169.1579876451451;
        Fri, 24 Jan 2020 06:34:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w23sm3188164qto.97.2020.01.24.06.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:34:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 37/44] btrfs: hold a ref on the root in open_ctree
Date:   Fri, 24 Jan 2020 09:32:54 -0500
Message-Id: <20200124143301.2186319-38-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the fs_root and put it in our fs_info directly, we should hold
a ref on this root for the lifetime of the fs_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c605be6ba889..433c29ddfca7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1537,6 +1537,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	kfree(fs_info->free_space_root);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
+	btrfs_put_fs_root(fs_info->fs_root);
 	kvfree(fs_info);
 }
 
@@ -3203,6 +3204,13 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_qgroup;
 	}
 
+	if (!btrfs_grab_fs_root(fs_info->fs_root)) {
+		fs_info->fs_root = NULL;
+		err = -ENOENT;
+		btrfs_warn(fs_info, "failed to grab a ref on the fs tree");
+		goto fail_qgroup;
+	}
+
 	if (sb_rdonly(sb))
 		return 0;
 
-- 
2.24.1

