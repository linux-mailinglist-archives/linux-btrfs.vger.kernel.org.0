Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3D168373
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgBUQbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQbc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C6F7AEEC;
        Fri, 21 Feb 2020 16:31:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21073DA70E; Fri, 21 Feb 2020 17:31:13 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/11] btrfs: adjust message level for unrecognized mount option
Date:   Fri, 21 Feb 2020 17:31:13 +0100
Message-Id: <a3813ca2dcfa6d75e118f4924811487dea4c52a0.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

An unrecognized option is a failure that should get user/administrator
attention, the info level is often below what gets logged, so make it
error.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5c16b4bcde9b..e6784cd3f179 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -873,7 +873,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			break;
 #endif
 		case Opt_err:
-			btrfs_info(info, "unrecognized mount option '%s'", p);
+			btrfs_err(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
 			goto out;
 		default:
-- 
2.25.0

