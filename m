Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84ED1315F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgAFQUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:20:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:49128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQUk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 11:20:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17E50B00D;
        Mon,  6 Jan 2020 16:20:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5E9EDA78B; Mon,  6 Jan 2020 17:20:29 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove unused member btrfs_device::work
Date:   Mon,  6 Jan 2020 17:20:28 +0100
Message-Id: <20200106162028.10029-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a leftover from recently removed bio scheduling framework.

Fixes: ba8a9d079543 ("Btrfs: delete the entire async bio submission framework")
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3c56ef571b00..81f21e42b887 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -120,8 +120,6 @@ struct btrfs_device {
 	/* per-device scrub information */
 	struct scrub_ctx *scrub_ctx;
 
-	struct btrfs_work work;
-
 	/* readahead state */
 	atomic_t reada_in_flight;
 	u64 reada_next;
-- 
2.24.0

