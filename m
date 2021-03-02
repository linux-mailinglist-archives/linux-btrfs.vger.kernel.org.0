Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E7532B26F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhCCB6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380893AbhCBKp3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 05:45:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614681882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=77vu4aPi6A71p5cCwya9adlqLxyZIaky8XkaoESrkaA=;
        b=Dx0nCE3VT5F4n3MUhWkcY3wCFUmuPDSig3A/I7xueQ4HTnlSQ3FFly+raOJQQxjbdTjiOn
        HP29+8EKMR4vRDs4OoJvqIO1KohK9cAx7r28IwfmEwpJHshaCUNaTARa3xFVxVNnc7uPfu
        kz1I/wlBZGhXT/k0RD9ycEoYS6Wn1hk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98325AAC5;
        Tue,  2 Mar 2021 10:44:42 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Don't opencode extent_changeset_free
Date:   Tue,  2 Mar 2021 12:44:40 +0200
Message-Id: <20210302104440.2318989-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/qgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 4ee51a082af6..1b7d3cadc39e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3617,8 +3617,7 @@ static int qgroup_reserve_data(struct btrfs_inode *inode,
 	qgroup_unreserve_range(inode, reserved, start, len);
 out:
 	if (new_reserved) {
-		extent_changeset_release(reserved);
-		kfree(reserved);
+		extent_changeset_free(reserved);
 		*reserved_ret = NULL;
 	}
 	return ret;
-- 
2.25.1

