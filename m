Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC09A2B0FFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgKLVTk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgKLVTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:38 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDECC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:38 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id 7so5239694qtp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XMkg0QcQV6bhxQ/hWUzX164aMXcHEsWUW8HBzPst+As=;
        b=NqHBVgvdTdtaLAn9JDtRECtG/Ti8qTge+wILtLI8IJExrXhFCYEt+UR/wH6iekLv59
         5fCOofYQZIkPKjQx4elHWRD6OQ8ccVGpzHWK03x1bqnJnHbPeox/5sZQlZT3QS+d+rf4
         r5BOy+3BfXflmZd0uMvwTQYYPg4kPOpjH8MjqyKoF7TL/p4Ejsh3TdI09UHZ5PxEhywx
         8aBOLr/eCqXAUj6Nrw24lWZUc/GweGZXfYSDRPwgHFkrBqcSfddmh2LAJttB3EgX0JLZ
         neMmjSVxikw3IxhPlk68/JQhvVJbDD7cUjh7WRIzU9aY+5BTmb+r7TzD0//5H1OLWy8Z
         xgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMkg0QcQV6bhxQ/hWUzX164aMXcHEsWUW8HBzPst+As=;
        b=SEBfrhUdsncSO10cvBuJkbBrqz8bpyawRA1CvlkU6cSqqnI9FG0nzt8vpmCrXpI6IX
         2fLIZ37VyLc9RIf7+ItNTwO4TCs0c86uM4kaj1lrkdkCgHqeGwZcyOheOKWvfUOGYUSK
         r39D0ZGGl9fDT4VBhSysRYA49R3lRdtmmdDR0Jkh2HuzRgAG/bstHXYW1hqsyvxBcoiK
         rrT57iXueqJ/sxEiqqfwPehW7HhsmotoHsn2U2S622cZmouhnuNXEu2syzuxZruCpmQo
         GZ2+CQksYO3qkPCzN2q2RPvd3BPgfmQz/sHATDKsERVy94fOoHj48gj+pp100JhXjIoV
         c/2Q==
X-Gm-Message-State: AOAM530sqhnmWqZk6i1jbncROjK9zFGjnrmGfNXEP85nFTq+rQlUj++9
        wM3fgP4lynRqwgZbfNM5703Um1Wp4n2poA==
X-Google-Smtp-Source: ABdhPJxpp2bLKAZJ/nPg4a8Nbkk4fzSonvUoyQLdCrfN8i+Ak0hH/xsIPx8PHIEOtzLf2ubWWxadEg==
X-Received: by 2002:ac8:5c13:: with SMTP id i19mr1207439qti.250.1605215977628;
        Thu, 12 Nov 2020 13:19:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k11sm5770600qtu.45.2020.11.12.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Thu, 12 Nov 2020 16:18:40 -0500
Message-Id: <678a2561f7622b2756cec03a9489fbbc4db04e1a.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_recover_log_trees.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index eb86c632535a..70f7413726d9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6261,8 +6261,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = log;
-		btrfs_record_root_in_trans(trans, wc.replay_dest);
-		ret = walk_log_tree(trans, log, &wc);
+		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		if (ret)
+			btrfs_handle_fs_error(fs_info, ret,
+				"Couldn't record the root in the transaction.");
+		else
+			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.26.2

