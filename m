Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466D02DC423
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgLPQ2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgLPQ2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:17 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B2C06138C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:05 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id a13so11593877qvv.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTzuJtm30OfFhLvIQZavh2mDl4CzhSzLQaF3f51kQio=;
        b=GPSdHJFZXlxNAOdvJyhmApI+CLD0l9RGNqS4AydzwZmEstWja7cKIsYhZmDQG9fpFL
         du4fo7TBf6pmxRchvLiJHqbzyuCRqxsEk/gZje5/iM3NmhoOZ4flsw8HUvzTq4uKkWy6
         K4IKyILvkz33aJdFb1YVpuvXJNYyMTUnW5bXJ3bUP2ZwCLLFYslcP0zBZg4imJipfAPb
         FlfxBcDkJWa0dzNUFxQ6v2Uq9qHLIL1ZhnATA9305uDBmenAfpBY2JsG9fbukguF8Me0
         Q4iIJNdUXLWt+e20cOYWm47hTrkvRBIkES8VhNl0hFPZeHmXIHq3EZq9HLApePUA1EO4
         rCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTzuJtm30OfFhLvIQZavh2mDl4CzhSzLQaF3f51kQio=;
        b=s98pQwIYEF7+M4QUtgc1e4AlW7uB/vQdzChjtInE6G9d8P1fAgGlOzLd2zhdqO2ktb
         lET6anqbavzFq6TTCnpgs+TU2TBV3AeZTmvgD0VewGt1rBk1xkS8uPbWJQu/EX/JsdBz
         s9mplckt80HWycCIzZ3Ejj60gYqR8g25DWfDjll0ihs5phBJsiAGmlwk/1QF2Cd/fRUZ
         AGEupbzpQHso+855XKVXe1GA1MAjyyOyaLuk5wo5IwmTYfodel+iYvxxS+doHsBnrQAe
         ivUTiLbeXCDupvk53yvKPR0IIjoJzJpECDohTP+FHqNfjJbxMz+/FjbHNohXX0pKNuv7
         s0lA==
X-Gm-Message-State: AOAM530WMVO6P8rXZlytzuDAvOQlR9x4njSd2nP95a+kUMLbiXHfk0Wb
        9YQu73HtQ7Vrr09hbdjd/egPxGlSQg5v8MIh
X-Google-Smtp-Source: ABdhPJyljYOXl3KAqewIOBiafBl0GNKvIR/Ze9syzyWdMnPu+E0E7TJOZjubFPHX/YfYg230JkkvTQ==
X-Received: by 2002:ad4:4c50:: with SMTP id cs16mr43674069qvb.33.1608136024473;
        Wed, 16 Dec 2020 08:27:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n188sm1427755qke.17.2020.12.16.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 05/38] btrfs: check record_root_in_trans related failures in select_reloc_root
Date:   Wed, 16 Dec 2020 11:26:21 -0500
Message-Id: <42bb8fda7ad569b8b3ea4ed21655bb8abba40792.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will record the fs root or the reloc root in the trans in
select_reloc_root.  These will actually return errors in the following
patches, so check their return value here and return it up the stack.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2a0f3c0dbbc0..1c36b10fdd02 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1988,6 +1988,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_node *next;
 	struct btrfs_root *root;
 	int index = 0;
+	int ret;
 
 	next = node;
 	while (1) {
@@ -2023,11 +2024,15 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 		}
 
 		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
-			record_reloc_root_in_trans(trans, root);
+			ret = record_reloc_root_in_trans(trans, root);
+			if (ret)
+				return ERR_PTR(ret);
 			break;
 		}
 
-		btrfs_record_root_in_trans(trans, root);
+		ret = btrfs_record_root_in_trans(trans, root);
+		if (ret)
+			return ERR_PTR(ret);
 		root = root->reloc_root;
 
 		if (next->new_bytenr != root->node->start) {
-- 
2.26.2

