Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD85010F7F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 07:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfLCGnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 01:43:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLCGnE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 01:43:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 111B2ADB5
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2019 06:43:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: relocation: Work around dead relocation stage loop
Date:   Tue,  3 Dec 2019 14:42:54 +0800
Message-Id: <20191203064254.22683-5-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203064254.22683-1-wqu@suse.com>
References: <20191203064254.22683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are some reports of dead relocation stage loop, where dmesg is
flooded by "Found X extents".

The root cause of it is still uncertain, but we can work around such bug
by checking cancelling request so user can at least cancel such dead
loop.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 161d66f70190..23aa630f04c9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4417,6 +4417,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 
 		btrfs_info(fs_info, "found %llu extents", rc->extents_found);
 
+		if (should_cancel_balance(fs_info)) {
+			err = -ECANCELED;
+			goto out;
+		}
 	}
 
 	WARN_ON(rc->block_group->pinned > 0);
-- 
2.24.0

