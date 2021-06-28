Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D563B5C5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhF1KTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 06:19:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39194 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhF1KTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 06:19:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6E46220252
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624875404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xax51JurA1q0fUV4YPZytFXEDWB2LjndnmsGQLex+o8=;
        b=P4bykaqzgo/Fn0NNCyXU3HeH4b/buEO9SroShHrNC4IamcU+gsiOvkAjmyeaL3IpZ4XKra
        uRE3263bcdHo8MaijNc5VAs74QtsRtNERl4VLm6iieb12BtVX/Fpg43k668QnMs3twg6+d
        e+XMAPm45OKmxh6y3KljXJlif2Ys/t4=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 66017A3B8E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:16:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: remove dead comment on btrfs_add_dead_root()
Date:   Mon, 28 Jun 2021 18:16:36 +0800
Message-Id: <20210628101637.349718-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628101637.349718-1-wqu@suse.com>
References: <20210628101637.349718-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The old comment is from the initial merge of btrfs, but since commit
5d4f98a28c7d ("Btrfs: Mixed back reference  (FORWARD ROLLING FORMAT
CHANGE)") changed the behavior to not to allocate any extra memory,
the comment on the memory allocation part is out-of-date.

Fix it by removing the dead part and change it to modern behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/transaction.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 73df8b81496e..29316c062237 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1319,9 +1319,10 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 }
 
 /*
- * dead roots are old snapshots that need to be deleted.  This allocates
- * a dirty root struct and adds it into the list of dead roots that need to
- * be deleted
+ * Dead roots are old snapshots that need to be deleted.
+ *
+ * This helper will queue them to the dead_roots list to be deleted by
+ * cleaner thread.
  */
 void btrfs_add_dead_root(struct btrfs_root *root)
 {
-- 
2.32.0

