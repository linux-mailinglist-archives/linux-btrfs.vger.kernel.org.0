Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455A62B202C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgKMQXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:48 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FDAC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:48 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so9310056qkf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oSIx8Xb2vns9io5O45zseAJQaQohertkzO5BDw+SD14=;
        b=thCG/kcfTpCSQC9i+gQc+2atnQlL/fWeOIsL33TRotxIXKA/7AM/KuO7fQ/3ZKVfBO
         xfMFHCJUi9MLhyCEZG+U853vg6uba5vbeje5HKI5flIum9SgVQLRrEoTH53T5Li425gj
         ahe3We0nfUNZxWOvYRm+vdw2XwWtTl8AYxdGZjAZtb6nUAoY7wuwuLdkebv9jAIRSJoy
         LRWKM+M7wkvqGrDIFUuvm6rklS1xwuHVAVCfbwoRJ2zudZ+Hogku6fLtuzzFRt2cuiWY
         7vM5Ytp6K1OltLqvUcFf0vpRkIbXSuQhyjTDxDE2yzppxWMS4l5CcL8bLNkPq29z7qaO
         eBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSIx8Xb2vns9io5O45zseAJQaQohertkzO5BDw+SD14=;
        b=Vpa3ZKvvevahzBOZXv9IIpCWF/6hgyCUtqiGrpWOv+30zooyJL+smEaj0g2c+uYvob
         BPLkCfMqfJqzBVxPPrjn+zZ+Hx+X7jmYxfmjvkh8KkvwWpYKPk5Jd3jZ0Zc6dAawQlp8
         La2wBu5zRPyZexGTOgoZ/BO5h9KgjHDS8LJ0qM/lWMdAxX9xiUK1PORdbtM8jOAdOiQi
         ZKt0wHTw6xnBWjWYDToExWyGI4bJ4TrA6mFwuUAQB9n9kjW+e29yaY8JmFuQKuGDHG2s
         gTpU7cH5bnPXsEhNcFTetGg7cggIn3RjYpTgdLSH4nWUurZaLM+4mpyI1eaqK/wEkbec
         kK+g==
X-Gm-Message-State: AOAM533DnNmbPNfKsXRM6OqPvhO65deHUpBJsyy8EUkCaVtRUzJu2OZU
        ++W2MM71sPnDSuGqT8XCnFcARWXIzLCP9A==
X-Google-Smtp-Source: ABdhPJx1ZAkapjpUjAgCYO+G3JOCwWh12pvM1jBDjTrwfoT57AUj6kXBsPC2g/96zSq3trq8I6pD+g==
X-Received: by 2002:a37:a88f:: with SMTP id r137mr2904176qke.437.1605284622005;
        Fri, 13 Nov 2020 08:23:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u24sm6795452qtv.83.2020.11.13.08.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/42] btrfs: convert BUG_ON()'s in relocate_tree_block
Date:   Fri, 13 Nov 2020 11:22:54 -0500
Message-Id: <f68183e94c9a9c0f9b2c0b882bbb9557be33491e.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a couple of BUG_ON()'s in relocate_tree_block() that can be
tripped if we have file system corruption.  Convert these to ASSERT()'s
so developers still get yelled at when they break the backref code, but
error out nicely for users so the whole box doesn't go down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d4cf982c78ff..3a5e89c82fa5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2475,8 +2475,28 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	if (root) {
 		if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
-			BUG_ON(node->new_bytenr);
-			BUG_ON(!list_empty(&node->list));
+			/*
+			 * This block was the root block of a root, and this is
+			 * the first time we're processing the block and thus it
+			 * should not have had the ->new_bytenr modified and
+			 * should have not been included on the changed list.
+			 *
+			 * However in the case of corruption we could have
+			 * multiple refs pointing to the same block improperly,
+			 * and thus we would trip over these checks.  ASSERT()
+			 * for the developer case, because it could indicate a
+			 * bug in the backref code, however error out for a
+			 * normal user in the case of corruption.
+			 */
+			ASSERT(node->new_bytenr == 0);
+			ASSERT(list_empty(&node->list));
+			if (node->new_bytenr || !list_empty(&node->list)) {
+				btrfs_err(root->fs_info,
+				  "bytenr %llu has improper references to it",
+					  node->bytenr);
+				ret = -EUCLEAN;
+				goto out;
+			}
 			btrfs_record_root_in_trans(trans, root);
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
-- 
2.26.2

