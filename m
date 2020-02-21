Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 826B6168376
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgBUQbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:43784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQbi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6890BAEEE;
        Fri, 21 Feb 2020 16:31:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09D6EDA70E; Fri, 21 Feb 2020 17:31:20 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/11] btrfs: adjust delayed refs message level
Date:   Fri, 21 Feb 2020 17:31:19 +0100
Message-Id: <f8d0bd62a1cea81145756e5fb7857c8cd4dcc8a2.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The message seems to be for debugging and has little value for users.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 77e1b66ebcfb..ab8d975f071c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4280,7 +4280,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	spin_lock(&delayed_refs->lock);
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
-		btrfs_info(fs_info, "delayed_refs has NO entry");
+		btrfs_debug(fs_info, "delayed_refs has NO entry");
 		return ret;
 	}
 
-- 
2.25.0

