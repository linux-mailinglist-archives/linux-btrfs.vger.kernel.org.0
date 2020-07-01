Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44301210EE4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbgGAPQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 11:16:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgGAPQe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 11:16:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4A4CACF3;
        Wed,  1 Jul 2020 15:16:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07A67DA781; Wed,  1 Jul 2020 17:16:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: remove deprecated mount option subvolrootid
Date:   Wed,  1 Jul 2020 17:16:17 +0200
Message-Id: <57d957a39e77808ea5818ead220fa185dc89fc2d.1593616511.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1593616511.git.dsterba@suse.com>
References: <cover.1593616511.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The option subvolrootid used to be a workaround for mounting subvolumes
and ineffective since 5e2a4b25da23 ("btrfs: deprecate subvolrootid mount
option"). We have subvol= that works and we don't need to keep the
cruft, let's remove it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e204b42076d..f90ee35465ab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -349,7 +349,6 @@ enum {
 
 	/* Deprecated options */
 	Opt_recovery,
-	Opt_subvolrootid,
 
 	/* Debugging options */
 	Opt_check_integrity,
@@ -421,7 +420,6 @@ static const match_table_t tokens = {
 
 	/* Deprecated options */
 	{Opt_recovery, "recovery"},
-	{Opt_subvolrootid, "subvolrootid=%d"},
 
 	/* Debugging options */
 	{Opt_check_integrity, "check_int"},
@@ -540,7 +538,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_subvol:
 		case Opt_subvol_empty:
 		case Opt_subvolid:
-		case Opt_subvolrootid:
 		case Opt_device:
 			/*
 			 * These are parsed by btrfs_parse_subvol_options or
@@ -1087,9 +1084,6 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 
 			*subvol_objectid = subvolid;
 			break;
-		case Opt_subvolrootid:
-			pr_warn("BTRFS: 'subvolrootid' mount option is deprecated and has no effect\n");
-			break;
 		default:
 			break;
 		}
-- 
2.25.0

