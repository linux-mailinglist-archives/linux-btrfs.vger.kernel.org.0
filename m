Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C92DC4A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgLPQu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLPQu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:58 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460FC061285
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:50 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b64so19137901qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8gAbf/w+Rfm6OuF2tFIhcPW/oJc3NjJb7aciQ2l7xDI=;
        b=A6DApy+5kW4760NawwHX7kSvOHvIi8Irv7Td55dn0bYRRFSqZkQbSTgIO8dxYqI9rN
         yJJovmpPhSA/ooUJWM+8UIxPj3y5Ccvg2okUV/JBVOqyM9+x1mvg//8GYxDM15+TW4VW
         /EkklcuwaeYVW8TCNdUC8M0ABceJHfiS10IkDXcBbuYEMSARwoHlTdz+OGtenXlAzDdu
         stoA1jtTtMJrEV8PAASZ1+k38965HzE3kImdxn6lFR73DY0Ajfxu4rMEYeu/6o5y7jzG
         fiFsVRWUn9vKfYOZ0ZpQ4MIEUGPq55RsSiHVTxTikDkRkE7cAgaV4BOXVU9rQEhO5D9I
         JmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gAbf/w+Rfm6OuF2tFIhcPW/oJc3NjJb7aciQ2l7xDI=;
        b=jZGQYzEV6J06za/WikuhQwsaDfsP9sevoIgBnEVtwDLZvIRzUZEx31FdBRF4XGk5X9
         yiOgihuEdVt6XJlQXL9i1niZohruNuHeHbcY2EwknttjrQoPZDinSiPk7x7EQ4m7FDbo
         UoOjAFOhpEkgEHafaU6RQhBkGwKkXVpLRGZ13OqnFEWtTCAj45zWKSI5gs6iCOJp9TnO
         jEgcdsF6tlIBzMK7bwPk7mrKE7I+efiTpE23DwiNamEPkxHgh/IZwFj/eWqn2OkmnYsM
         KGXgb9Z1qNJj5If91f92gEVWe8sV/Hut6NRdfjPEhefr3uAriu5m6nOTE91eYq8BzRUo
         aIww==
X-Gm-Message-State: AOAM531dlrXFiKBpjHpEqU/r3zLDHHihufw3ZzqQb3/IFQMEY5CpJyJj
        b009hRG4Uau0fTEcwZenIWhWg2TxsY3QZZq/
X-Google-Smtp-Source: ABdhPJyFNE9PQCylPRrblRar8+XJZxE0Lytd8fyipVnlTtviIQwrwKLWxDkQ2UvbotXRz8qC/dV3fg==
X-Received: by 2002:ae9:eb8b:: with SMTP id b133mr44772144qkg.399.1608137389170;
        Wed, 16 Dec 2020 08:49:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a10sm1448883qkk.52.2020.12.16.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 6/6] btrfs: stop running all delayed refs during snapshot
Date:   Wed, 16 Dec 2020 11:49:34 -0500
Message-Id: <3643159e2e5f04612b0a3197ea32bd8591243131.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137316.git.josef@toxicpanda.com>
References: <cover.1608137316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added a very long time ago to work around issues with delayed
refs and with qgroups.  Both of these issues have since been properly
fixed, so all this does is cause a lot of lock contention with anybody
else who is running delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 51c5c2f6e064..70cbc15fc58a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1228,10 +1228,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	btrfs_tree_unlock(eb);
 	free_extent_buffer(eb);
 
-	if (ret)
-		return ret;
-
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 	if (ret)
 		return ret;
 
@@ -1249,10 +1245,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	/* run_qgroups might have added some more refs */
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret)
-		return ret;
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
@@ -1267,15 +1259,24 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		ret = update_cowonly_root(trans, root);
 		if (ret)
 			return ret;
-		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-		if (ret)
-			return ret;
 	}
 
+	/* Now flush any delayed refs generated by updating all of the roots. */
+	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
+	if (ret)
+		return ret;
+
 	while (!list_empty(dirty_bgs) || !list_empty(io_bgs)) {
 		ret = btrfs_write_dirty_block_groups(trans);
 		if (ret)
 			return ret;
+
+		/*
+		 * We're writing the dirty block groups, which could generate
+		 * delayed refs, which could generate more dirty block groups,
+		 * so we want to keep this flushing in this loop to make sure
+		 * everything gets run.
+		 */
 		ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
 		if (ret)
 			return ret;
-- 
2.26.2

