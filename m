Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A832029EB33
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgJ2MC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:02:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2MC5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:02:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wyao9tgNDfwAZharNKXbovVBmRxW04oXBneHOVokknc=;
        b=bdHmU7Qk0oR6VS/B07rU1G8LX2E94M3RX/+Rbf7/y4ePnYnxaL7zSt18HMgMnt4JzL/xKP
        KcFosNzplgUER/7ZXTSaSmGzlBEpBxMXYw+445rf7SOXGGb8Gyv9PeYjPZH91+QOWiX2Gb
        GpzQf+f/A4OkEkpnTWu0RfWx1DtvomE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9036AF16;
        Thu, 29 Oct 2020 12:02:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1BDFDA7D9; Thu, 29 Oct 2020 13:01:21 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/8] btrfs: use the right number of levels for lockdep keysets
Date:   Thu, 29 Oct 2020 13:01:21 +0100
Message-Id: <99aee7f3f5271314a134974d2b627fbfba921eb3.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
References: <cover.1603972767.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_MAX_LEVEL is 8 and the keyset table is supposed to have a key for
each level, but we'll never have more than 8 levels.  The values passed
to btrfs_set_buffer_lockdep_class are always derived from a valid extent
buffer.  Set the array sizes to the right value.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 601a7ab2adb4..c4052f171f04 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -153,8 +153,8 @@ struct async_submit_bio {
 static struct btrfs_lockdep_keyset {
 	u64			id;		/* root objectid */
 	const char		*name_stem;	/* lock name stem */
-	char			names[BTRFS_MAX_LEVEL + 1][20];
-	struct lock_class_key	keys[BTRFS_MAX_LEVEL + 1];
+	char			names[BTRFS_MAX_LEVEL][20];
+	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
 } btrfs_lockdep_keysets[] = {
 	{ .id = BTRFS_ROOT_TREE_OBJECTID,	.name_stem = "root"	},
 	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	.name_stem = "extent"	},
-- 
2.25.0

