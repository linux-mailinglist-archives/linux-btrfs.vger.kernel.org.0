Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3153C8B41
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhGNSuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 14:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbhGNSuc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:32 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB201C061767
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 11:47:39 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o9so1537768qvu.5
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xk61Zn1WGvZe9oDMxIvYakdXIuBAH34lTAxcJ/5AdLQ=;
        b=C/tU9se623yVpBbPLXzFaiqyH5+3u2knGq7aYpkFU2IFNxYVmHnF4ubtLLIKmwU/ba
         VlbsOEykpVidDiKXTPu6Qb7LUJZaVaqn52Y+TR2QnpmWqkl9VnSNlAy72Qd8jlucIIyP
         MpISqrlGcdEd/7u3jcvx2D/jc8mIA4quJUZjX8arcjY1lGE2FT0we3ncgNQzDrEORb2T
         3zhKTtPOAjpwttUJ1ud+pLS7y3hxbKtk8zT/AvvrAJRnwPgsJ1+rimZ5tLXaRO02xQaX
         vuLa0Om6VU+knEndziipA/1eSWQpnf8bbRmwFwBydyhp3AeIuOAu8ijLOjOA+FrXcadY
         txVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xk61Zn1WGvZe9oDMxIvYakdXIuBAH34lTAxcJ/5AdLQ=;
        b=pYwGYV/GV7JnycKVxM7HymQ8rahAY6+orjVUcKnKrK+boCskmwM8jgknAbdOvuEIQN
         4l5naRASPD1zrfE1Qg9z37Ddx26UtQdCMs266uXlmbckkGAjgC6nrgPhtbc1fEYaBUXg
         Hhm0wXlet3HYOz3bUDoUZCfF4rMFiQgxPQ1jVsIVSDbmIuZYb8NJAC/JQhnjdqUkT9TZ
         LS5+HHjDI0tdYC7MXLB+R1v5zTrAWIX8oO3IEOwKej104epGLIBlSIAY5WGeMsYnN4dm
         jfJjnfX8YQy0Egc55b2eVIJHK9cRyuMcAzW1AUuRVMPmj1g+KFCRS8tMYu7J+Tn+TSj7
         a8wQ==
X-Gm-Message-State: AOAM530XydPT7jTAAREo1kEn4uqcDXQkzZ1yI3x4M7I+wn7JBVi9sIs9
        uBMM7Xp78H0mhzY+bF30Ga1qS8ynQQniREwo
X-Google-Smtp-Source: ABdhPJw3QYNBAYnp6RjYuMBTO3Ziqr3hboUy69T139RW4CtDXDHnTyQ2CAeV6P+JinJdVKM8Wjn9+g==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr12153276qvt.47.1626288458688;
        Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a190sm1474962qkf.9.2021.07.14.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 8/9] 9p: migrate from sync_inode to filemap_fdatawrite_wbc
Date:   Wed, 14 Jul 2021 14:47:24 -0400
Message-Id: <696f89db6b30858af65749cafb72a896552cfc44.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to remove sync_inode, so migrate to filemap_fdatawrite_wbc
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/9p/vfs_file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 59c32c9b799f..6b64e8391f30 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -625,12 +625,7 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
 
 	inode = file_inode(vma->vm_file);
-
-	if (!mapping_can_writeback(inode->i_mapping))
-		wbc.nr_to_write = 0;
-
-	might_sleep();
-	sync_inode(inode, &wbc);
+	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
 }
 
 
-- 
2.26.3

