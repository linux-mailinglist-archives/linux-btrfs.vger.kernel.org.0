Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93F39EC84
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 05:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFHDBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 23:01:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41374 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhFHDBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 23:01:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DEF92219C1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623121189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VD4VBVA7Hdiv2RAzgvtPzNcjCXpY7Y5uG6xk+i+dSg4=;
        b=NPyfvOFQMMt/hjSjvwrYQTl9SzwJrhOrvI8RVYSKeuyU/GAava+hxZOSbqiZiCo1OBtbqA
        uLK7sl8AhhVFR+G6OXfnkznYudmn+u/68a+QzpDWACB5fN4SX0Uv6gzARoMTw7PELP06JU
        LVcHHwBXg+L7CRnC8CtKB+YZgLBPR5w=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id D2505A3B8D
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/10] btrfs: defrag: enable defrag for subpage case
Date:   Tue,  8 Jun 2021 10:59:27 +0800
Message-Id: <20210608025927.119169-11-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608025927.119169-1-wqu@suse.com>
References: <20210608025927.119169-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the new infrasturture which has taken subpage into consideration,
now we should be safe to allow defrag to work for subpage case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6de1293da45f..dd0a633cec8d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2973,12 +2973,6 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		goto out;
 	}
 
-	/* Subpage defrag will be supported in later commits */
-	if (root->fs_info->sectorsize < PAGE_SIZE) {
-		ret = -ENOTTY;
-		goto out;
-	}
-
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFDIR:
 		if (!capable(CAP_SYS_ADMIN)) {
-- 
2.31.1

