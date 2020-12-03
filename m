Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EC2CDD7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502026AbgLCSZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502016AbgLCSZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:11 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B1C09425A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:15 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so3008484qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=Kaq3kH3pylNJsJdGLynPb3XP6zE7cKVRZ2hM2FtLh/BHYxc2Dk6+Auh8d1G7z23Mx+
         xLlF0ABODdpYXeRpBdW3R4CKhZDhVinpKf3cBl9CW4ZWQoahDz6HjujZ56cYbxzn+N3X
         4U0goJKEOlno1COKs92M/8CjSiuHZQQg22LhIuAZxvkQPZG1vumQyq6930LPyhHqDpO9
         yIajFvD+kDxqw5StIhDqMvzZx44x5r8ww3W3t3GhBmytERmfrvK5tw0nw/whs0C7lejb
         I5I0Wqw7SKgB5lICLks0qvX3LwZrSBrFPmD26gsIAlPvt5/M2RnRS4jOvZps92Uli1GT
         sH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=DmT+hOjwvispu51kNGpbvJYbIqJ1Q+BS6CYWyKrG7uy/R3h7huJJBsMsMnuxuB/5Rl
         +Pku/pcZ6iFCjoRMHhC3Sco3B2+1iVDVsQh7TqFEEw0dWqASjDDIqN3lN4ei1f/hc40a
         JICGsfNmwnqD4LL/rMMIXz1hFuu9w1Uz6V5wRKppShaR93fVTW14lzPRz2BxaSY7BC9O
         mwxhVHDFnGq2oB9XmqxpbIAyZF66qhAUsKb3q7oN3YKpNCx+pm2RTOz/krIQ+m30f3mK
         7QwvuadpS3vAuQecHKyqjlFxG5wsPA5yxCscrZ72KwrJBVgCjKZeXLYGrbjgGy0qg26r
         Zo5A==
X-Gm-Message-State: AOAM531m8Z2hdphuR/EZHrAoEHPZ7MWa7DBq0lwoIqpONLjPGZGRQUjS
        okGjH93d8mtXG/kMkg65tvgNG+Judcx3Ucsx
X-Google-Smtp-Source: ABdhPJw5pniRy+OwhSYO8aE83DYp61JA5AB5PH4hRJJgW/Tan4IXlreMzni+lcEZKkngqkVSD+DnCw==
X-Received: by 2002:a05:620a:1590:: with SMTP id d16mr4210743qkk.88.1607019854621;
        Thu, 03 Dec 2020 10:24:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y192sm2354375qkb.12.2020.12.03.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 42/53] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Thu,  3 Dec 2020 13:22:48 -0500
Message-Id: <07199465ce4388a84f3aa4371ecea64f8305d1b2.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 028e733e42f3..39714aeb9b36 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1283,6 +1283,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
 	}
 	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
 
-- 
2.26.2

