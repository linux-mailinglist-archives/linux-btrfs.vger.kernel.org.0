Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D072FFFC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbhAVKGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:06:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbhAVKAn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaAgTtdj8LVuJe/d8ZAkWwkEsgpZLPVxK2krUamc1VQ=;
        b=ncCuHp67dKgBR+sJTahRAtWOu6wgiKRZjWJOwWSfi2yRLngFuOOk3QwQ0KbSp+UImEUbum
        oLMNoZIxCT3fdmC/LQnXH7akNnmf2WwF17jJ9oxWFNFWTRy1c+N4mU/vyuXZWPBShOkR8M
        BrC/JIV5MqMMdheEXXgkaefzlr4F8lA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EC36B7B0;
        Fri, 22 Jan 2021 09:58:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 09/14] btrfs: Document btrfs_check_shared parameters
Date:   Fri, 22 Jan 2021 11:58:00 +0200
Message-Id: <20210122095805.620458-10-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/backref.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ef71aba5bc15..bbe50affb554 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1501,7 +1501,13 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 }
 
 /**
- * btrfs_check_shared - tell us whether an extent is shared
+ * Checks if an extent is shared or not
+ *
+ * @root:   root inode belongs to
+ * @inum:   inode number of the inode whose extent we are checking
+ * @bytenr: logical bytenr of the extent we are checking
+ * @roots:  list of roots this extent is shared among
+ * @tmp:    temporary list used for iteration
  *
  * btrfs_check_shared uses the backref walking code but will short
  * circuit as soon as it finds a root or inode that doesn't match the
-- 
2.25.1

