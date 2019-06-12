Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E241C4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 08:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfFLGhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 02:37:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730957AbfFLGhI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 02:37:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16838AC40
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 06:37:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: Remove "recovery" mount option
Date:   Wed, 12 Jun 2019 14:36:55 +0800
Message-Id: <20190612063657.21063-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612063657.21063-1-wqu@suse.com>
References: <20190612063657.21063-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 8dcddfa048de ("btrfs: Introduce new mount option usebackuproot to
replace recovery") deprecates "recovery" mount option in 2016, and it
has been 3 years, it should be OK to remove "recovery" mount option.

As we're even going to deprecate the successor, "usebackuproot" mount
option, there isn't really much need to keep the original option.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0645ec428b4f..64f20725615a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -311,7 +311,6 @@ enum {
 	Opt_defrag, Opt_nodefrag,
 	Opt_discard, Opt_nodiscard,
 	Opt_nologreplay,
-	Opt_norecovery,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
 	Opt_skip_balance,
@@ -329,7 +328,6 @@ enum {
 
 	/* Deprecated options */
 	Opt_alloc_start,
-	Opt_recovery,
 	Opt_subvolrootid,
 
 	/* Debugging options */
@@ -374,7 +372,6 @@ static const match_table_t tokens = {
 	{Opt_discard, "discard"},
 	{Opt_nodiscard, "nodiscard"},
 	{Opt_nologreplay, "nologreplay"},
-	{Opt_norecovery, "norecovery"},
 	{Opt_ratio, "metadata_ratio=%u"},
 	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
 	{Opt_skip_balance, "skip_balance"},
@@ -396,7 +393,6 @@ static const match_table_t tokens = {
 
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
-	{Opt_recovery, "recovery"},
 	{Opt_subvolrootid, "subvolrootid=%d"},
 
 	/* Debugging options */
@@ -670,7 +666,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_clear_and_info(info, NOTREELOG,
 					     "enabling tree log");
 			break;
-		case Opt_norecovery:
 		case Opt_nologreplay:
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
@@ -759,10 +754,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_clear_and_info(info, AUTO_DEFRAG,
 					     "disabling auto defrag");
 			break;
-		case Opt_recovery:
-			btrfs_warn(info,
-				   "'recovery' is deprecated, use 'usebackuproot' instead");
-			/* fall through */
 		case Opt_usebackuproot:
 			btrfs_info(info,
 				   "trying to use backup root at mount time");
-- 
2.22.0

