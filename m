Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960DB495CDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379746AbiAUJdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 04:33:51 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:33614 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379744AbiAUJdu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 04:33:50 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 093D66C006DB;
        Fri, 21 Jan 2022 11:33:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1642757629; bh=tPmJpCkn0aP5/3HvWT6AkJrgIDDukse2LqY9QDHORJE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:X-ESPOL:
         from:date:to:cc;
        b=QjOlo2qqwsjIfwT8VbVucPozwelCu6rXHgd4XpWVdyKokkftIza2LUo+BPRXwOF2I
         bGjklnxOCUMiqDPttWPZnpYyBmcWRD3CRhRYBw1MUVvcJIl28nQC5f6YgnLxMc7BU7
         za9DwaK9eI4HYvR+AHzCJY0zOPvLgk84Z6CPDzAs=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id EECEE6C006CC;
        Fri, 21 Jan 2022 11:33:48 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Tvs2e0QaxBrT; Fri, 21 Jan 2022 11:33:48 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B7F786C0066C;
        Fri, 21 Jan 2022 11:33:48 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH 2/2] btrfs: tree-checker: check item_size for dev_item
Date:   Fri, 21 Jan 2022 17:33:35 +0800
Message-Id: <20220121093335.1840306-3-l@damenly.su>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121093335.1840306-1-l@damenly.su>
References: <20220121093335.1840306-1-l@damenly.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlYpNBD+giECgR3rABwYzs1k3Ua26u/vYoxBbgBmOPC+CfkkPWBO2mWpqPg+1xF8X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check item size before accessing the device item to avoid out of bound
access.

Signed-off-by: Su Yue <l@damenly.su>
---
 fs/btrfs/tree-checker.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 2978fc89c093..87fff4345977 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -965,6 +965,7 @@ static int check_dev_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, int slot)
 {
 	struct btrfs_dev_item *ditem;
+	u32 item_size = btrfs_item_size(leaf, slot);
 
 	if (unlikely(key->objectid != BTRFS_DEV_ITEMS_OBJECTID)) {
 		dev_item_err(leaf, slot,
@@ -972,6 +973,13 @@ static int check_dev_item(struct extent_buffer *leaf,
 			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
 		return -EUCLEAN;
 	}
+
+	if (unlikely(item_size != sizeof(*ditem))) {
+		dev_item_err(leaf, slot, "invalid item size: has=%u expect=%zu",
+			     item_size, sizeof(*ditem));
+		return -EUCLEAN;
+	}
+
 	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
 	if (unlikely(btrfs_device_id(leaf, ditem) != key->offset)) {
 		dev_item_err(leaf, slot,
-- 
2.34.1

