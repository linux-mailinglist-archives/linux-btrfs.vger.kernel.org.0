Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327BC2B2045
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgKMQYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgKMQYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:24 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21552C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:24 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so7014412qtb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rtxcBB97h95YBiR49jgxCLvDOaDGaQtG758ny/QbjE8=;
        b=BamYw3WWovWKl/JcrHAltwvdIGUak+vT5pTZ2CEI+0p42HIzlqvZ7oGcC2UWi7w0Mq
         ZAl8iIqAnFJToP5zbllzaTPPOxvXnH7mFyh7Sb/kUx6XBRCkPIwTN4EqnjGpW//KAl1h
         tlwFvEwUWa6LKPCDW7RJZ7jBz/TvepfOIyReqcVm8ptVZjgvcOfZy/NvP+MZbaFNR8Gv
         CFgrL1joNk/Ds3h62cTTvRE+zZjvDcEeWkl8ltHTGdPAX7z0t81nxl1moQTCKcODv09D
         IRfO7sOOUhWZuZfWSTTur5JNt5Gzx2R2RIOCjmcodNNeecNN62PDqe8OEIKihh6AnxW6
         VV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtxcBB97h95YBiR49jgxCLvDOaDGaQtG758ny/QbjE8=;
        b=TtvCeYKTcbZ3WkKD0VNnCg3lgDvgTNkWvUyZWtxzVyKHqx93v0xGIY8BKdykhMaNy6
         8l1wtuFAcA8CcjKTea7sP5vdjX2uV+vdtni5FQdBUu/pH7HTV79I1WqG3vcFiyrjThFz
         gE1Z1VmOtHV8azQ527OST2TX0dBnrrk8pYmkHBau3IeiLJT8CTAh3I0t7f+xozep9hiA
         YAEmYhuZaqCcY95iOIp8iZv5nR17BWQscxBwVCX6Vb0TgH0XZgifz8oBQ46ugYkyZS0J
         JBZAdjzQXOrg9boD5xwMxMj6luQRytO0WwAwWtuKAJXZgacVHk2o7HC31vyKjwb24e5n
         x4Yg==
X-Gm-Message-State: AOAM533ym9nagCjSUgDunPpKhCn4aMlfgA1QUubwDhtVTiDh90P8WUcv
        L/jbtAyLIQvrSusIC+1GV4dU0A/lHhDsTA==
X-Google-Smtp-Source: ABdhPJwtVSgYzPHuop8IQnAvgf+j0owtClDCKtJMjDQ/UaJF+DOnKaHP19dFRRsBFWu70MSdTk8qrA==
X-Received: by 2002:ac8:7b30:: with SMTP id l16mr2757944qtu.360.1605284657625;
        Fri, 13 Nov 2020 08:24:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 72sm7268094qkn.44.2020.11.13.08.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 23/42] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Fri, 13 Nov 2020 11:23:13 -0500
Message-Id: <de330a2ae354cb84971c5c0f03b9812a5b5e2811.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0aa6d8ddad21..1dac76b7ea96 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1346,7 +1346,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			err = btrfs_update_reloc_root(trans, root);
+			if (err)
+				return err;
 
 			btrfs_save_ino_cache(root, trans);
 
-- 
2.26.2

