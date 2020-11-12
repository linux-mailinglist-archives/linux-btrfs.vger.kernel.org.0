Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EC2B1018
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgKLVUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgKLVUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:39 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64080C0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:34 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so6883519qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NLE7VHDfPJX58ak2qw7sS3NxJL6JmvmiT4/6MJcSvvY=;
        b=gk2pJBAgRz0eGhAgysj8mgsSHaUjyKSUvKbt+6nYSrUKrZNMDlSvHFv3n6BNIYO9Z8
         DsNsBQ3S4+M9VvD3C9t/QhMiWVF3P4IUglqwT9GuWpL+6ocC+qGBbn56mO7hSJEFlK4W
         AZji9UVgSmCordQG9P/XfhOFNQwglVnyTHWxLHSmFr4dzE9m1vPGxMSi8B546vDnTRTc
         74LArWIYWZv/6u3Y2VITeAXCbJ7eaIJXhYryWjTuUzh0mHGDzvkFY+yj9YGnkS8bMKSp
         LMaaLWJU5FRzJOVgvPQr1PUg3zG0cWeb8ge6EsUKCUYmRq0PTSrjztL3D2IVzjM40IPr
         hjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLE7VHDfPJX58ak2qw7sS3NxJL6JmvmiT4/6MJcSvvY=;
        b=IOBDi5RRHVomHU7DqwCpROxBwsUZkQHVdm5L2vPf2uB0VFgb9zIGFS4LEaku1vY33d
         yZPgjKKErVwzspYIvB2HhqqwEeoH1dcFuxNsnj32eEdGQplCfjj3ts6LhjtfugfVpZFq
         XUWi1XlfxAPHi1NKJd48ZbW/N+IGOqhZHMQoz522s8N7/5goCDKWA9/nuxX6oAMPdkmq
         l1yHyCzIz/BelOiRuXwQge2Q+aRLo4pK1OLk92+YrcuWJ6JkIt9ChRpI5FfaCJORKpHc
         7q8IUg58DZV9KZup2QO1/erLw5ffQY7t0rYMnk/DUIRr4+k6hgcJTVIoU+mo7u413c4D
         oKZw==
X-Gm-Message-State: AOAM530wqXWF6xjxaNFJBiUqRWPUaUIFk1dM8JybsILUauKMs+On4lcN
        wC/eVqGZ0DjA3O8iHHYPc4V7HTMmnTn50Q==
X-Google-Smtp-Source: ABdhPJzyHTLBfQ6eYGIalj85hjgu/mwSZ3oC8SPP+lESzraogT8pLeoG/pcOxvQnKU6rvAr3CN+5UA==
X-Received: by 2002:a37:b4e:: with SMTP id 75mr1761152qkl.78.1605216033355;
        Thu, 12 Nov 2020 13:20:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v128sm5677583qkh.131.2020.11.12.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 38/42] btrfs: handle __add_reloc_root failure in btrfs_reloc_post_snapshot
Date:   Thu, 12 Nov 2020 16:19:05 -0500
Message-Id: <f9b8d42c975a8c8b7588592df6270c27c99a60ba.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to add the reloc root, drop it and return the error.  All
callers of this function already handle errors appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 832bf7c19dac..651295864ec0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4198,7 +4198,10 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	new_root->reloc_root = btrfs_grab_root(reloc_root);
 
 	if (rc->create_reloc_tree)
-- 
2.26.2

