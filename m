Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD428F62F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfHOVEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:04:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41332 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbfHOVEV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so1825642pgg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzvhP7oZSYNZD4sI7ZmaVO+DL6Z60759QPD7Y9bxg2E=;
        b=mOhSs+ZS/1ya+QNErGzP9WnCDoaEvfOdZ7wmbPtPr+axBCingCGhGjepwIzrZxZpNc
         6kGVPVBkMEnxnKGU6fWOd5+PZcGU/EO0vlANhkgD2u7JxJHU9UvCk3gm/50PfrYZwRel
         rIKiq+8geebbIDOQn/+qyzdT754OzR18QIdlDWhM4pp9urMc3CtCijVG9LuqcmxfLR2U
         wHHosJYHoCLhOcCiihXCkv76VHT56PfyxuE6GiQVSIyfzxsritLoYj97T6yVtjHLOBrx
         qeWjWdax8F1pM0u4xIf9u/bAOg5Y43+epxG4tssD08szZEVI9gkxi3PanN5kjZa04p02
         FdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzvhP7oZSYNZD4sI7ZmaVO+DL6Z60759QPD7Y9bxg2E=;
        b=ZvP4SyhzhV+y+g4qWHe2pfIEz5T8xJjRbtUxa7aOefaQ9VRI4avUxgRs+9Lp6V3N20
         H16imBNt050Zw7FSRCr3Eks1aWQX1oW7H1nMpusJGkhhRi0RT+CliQKCSPc/T7C+yqRo
         dvXo3gdBE+9ip2J/s/NVatc2hBx7OpoYBZxDsDbGA6KjyRiNKOsd1a5nLHJVKlawzYcC
         ED52nWM8U1yQ6jRKyzaNb+jpGbuavDYJnji/AXfSEgiQ5rJh1bzokqU2IE1DAmqI+zDE
         aOIh5zNSnZ4eSCKro16sPk+ORQvRB3Sf/j1b0FV76aQbur8GLi6x0X8ZT04cpPTw7Ijm
         nxPw==
X-Gm-Message-State: APjAAAUFojYOYuEfQGxOdjgTvTm8Yg7QFE3SxXO/7L7LAFu8yvlvaETA
        7OA1aonY+bilm+Rc80kSwggVnVWJP0E=
X-Google-Smtp-Source: APXvYqw8OHfPtIAkwUnd7GuwbzgEJ5ce99a4V8KpIEeybYfQ5srIn/0ICHv+qPn8izutyjTcN4eZlg==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr7607913pfa.90.1565903060267;
        Thu, 15 Aug 2019 14:04:20 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id i124sm4073230pfe.61.2019.08.15.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:04:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 2/5] Btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
Date:   Thu, 15 Aug 2019 14:04:03 -0700
Message-Id: <ba7aa871e255c0e264a782b863513b9afd499f91.1565900769.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565900769.git.osandov@fb.com>
References: <cover.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In btrfs_file_write_iter(), we treat a write as synchrononous if the
file is marked as synchronous. However, with pwritev2(), a write with
RWF_SYNC or RWF_DSYNC is also synchronous even if the file isn't by
default. Make sure we bump the sync_writers counter in that case, too,
so that we'll do the CRCs synchronously.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4393b6b24e02..27223753da7b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1882,7 +1882,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	u64 start_pos;
 	u64 end_pos;
 	ssize_t num_written = 0;
-	bool sync = (file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host);
+	bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
 	loff_t pos;
 	size_t count;
-- 
2.17.1

