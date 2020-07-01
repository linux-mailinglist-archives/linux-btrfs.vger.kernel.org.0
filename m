Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC690210EE3
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbgGAPQc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 11:16:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgGAPQc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 11:16:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67DCEACBD;
        Wed,  1 Jul 2020 15:16:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2E3DDA781; Wed,  1 Jul 2020 17:16:15 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: remove deprecated mount option alloc_start
Date:   Wed,  1 Jul 2020 17:16:15 +0200
Message-Id: <a0da2bf1c12108891964c437d3c6db5b6eed9926.1593616511.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1593616511.git.dsterba@suse.com>
References: <cover.1593616511.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mount option alloc_start has no effect since 0d0c71b31720 ("btrfs:
obsolete and remove mount option alloc_start") which has details why
it's been deprecated. We can remove it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3c9ebd4f2b61..7e204b42076d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -348,7 +348,6 @@ enum {
 	Opt_rescue_skipbg,
 
 	/* Deprecated options */
-	Opt_alloc_start,
 	Opt_recovery,
 	Opt_subvolrootid,
 
@@ -421,7 +420,6 @@ static const match_table_t tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 
 	/* Deprecated options */
-	{Opt_alloc_start, "alloc_start=%s"},
 	{Opt_recovery, "recovery"},
 	{Opt_subvolrootid, "subvolrootid=%d"},
 
@@ -726,10 +724,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				goto out;
 			}
 			break;
-		case Opt_alloc_start:
-			btrfs_info(info,
-				"option alloc_start is obsolete, ignored");
-			break;
 		case Opt_acl:
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 			info->sb->s_flags |= SB_POSIXACL;
-- 
2.25.0

