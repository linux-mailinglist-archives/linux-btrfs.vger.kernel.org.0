Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4550E3B5C59
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhF1KTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 06:19:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39188 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhF1KTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 06:19:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C337E20251
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624875402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5oR14tc2HFaKMVUV1iG68+XjG7B/JnKLJjsZ4e70OQ=;
        b=Bu5TuitQyrmVQ/iBxGG8VSdqbQIYRIKNjO3krgiE8X81C8SUt9wR+MF9ARMsupzQjP1rwr
        LGDhO48YEcB9oHb5MCqL4FKPJTqsKq/AMRyla1PFzkcmvo2PYgFR1lQcOXLjYmcqPDowG+
        JMi3GR3Z5BB9j1FX86Txn7e8ZHvLdz4=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id B1E23A3B8E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: return -EINVAL if some user wants to remove uuid/data_reloc tree
Date:   Mon, 28 Jun 2021 18:16:35 +0800
Message-Id: <20210628101637.349718-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628101637.349718-1-wqu@suse.com>
References: <20210628101637.349718-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ioctl BTRFS_IOC_SNAP_DESTROY_V2 supports a flag to delete a subvolume
using root id directly.

We check the target root id against BTRFS_FIRST_FREE_OBJECTID, but not
again BTRFS_LAST_FREE_OBJECTID.

This means if user passes rootid like DATA_RELOC (-9) or TREE_RELOC
(-8), we can pass the check, then get caught by later dentry check and
got error number -ENOENT, other than -EINVAL.

It's not a big deal as we have extra safe nets to prevent those
trees get removed, it's still better to do the extra check and return
proper -EINVAL error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..889e27c24e3a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2932,7 +2932,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			if (err)
 				goto out;
 		} else {
-			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
+			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID ||
+			    vol_args2->subvolid > BTRFS_LAST_FREE_OBJECTID) {
 				err = -EINVAL;
 				goto out;
 			}
-- 
2.32.0

