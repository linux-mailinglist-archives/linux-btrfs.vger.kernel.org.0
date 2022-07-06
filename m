Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D853568920
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 15:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiGFNPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 09:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGFNPj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 09:15:39 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134DB5F77;
        Wed,  6 Jul 2022 06:15:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 7BF261BA23679;
        Wed,  6 Jul 2022 21:10:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1657113014; bh=mrQNKI4KC3vKIi8mGBtl801ZRNnPh+3BDudhW/ttL10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KKUzzIjJi/bFhFkStKvW7z7PKXookZURXDHR5Cr7D/7LbzkPRt6D2G/NPZCBh8UAM
         dGHqgR/h3WyuQPl+0Gh+msi0QouLYwmyhbHsT8zQy2mjGsDqIV0E7l/u/MRN5zyp0K
         nX/lLZQJ28gINnHhE72d2lEcnmF0s1Lg7xMejCnc=
From:   bingjingc <bingjingc@synology.com>
To:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, robbieko@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH 1/2] btrfs: send: introduce recorded_ref_alloc and recorded_ref_free
Date:   Wed,  6 Jul 2022 21:09:02 +0800
Message-Id: <20220706130903.1661-2-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220706130903.1661-1-bingjingc@synology.com>
References: <20220706130903.1661-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Introduce wrappers to allocate and free struct recorded_ref*.

Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/send.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index fa56890ff81f..420a86720aa2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2749,6 +2749,26 @@ struct recorded_ref {
 	int name_len;
 };
 
+static struct recorded_ref *recorded_ref_alloc(void)
+{
+	struct recorded_ref *ref;
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref)
+		return NULL;
+	INIT_LIST_HEAD(&ref->list);
+	return ref;
+}
+
+static void recorded_ref_free(struct recorded_ref *ref)
+{
+	if (!ref)
+		return;
+	list_del(&ref->list);
+	fs_path_free(ref->full_path);
+	kfree(ref);
+}
+
 static void set_ref_path(struct recorded_ref *ref, struct fs_path *path)
 {
 	ref->full_path = path;
@@ -2766,7 +2786,7 @@ static int __record_ref(struct list_head *head, u64 dir,
 {
 	struct recorded_ref *ref;
 
-	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
+	ref = recorded_ref_alloc();
 	if (!ref)
 		return -ENOMEM;
 
@@ -2781,14 +2801,12 @@ static int dup_ref(struct recorded_ref *ref, struct list_head *list)
 {
 	struct recorded_ref *new;
 
-	new = kmalloc(sizeof(*ref), GFP_KERNEL);
+	new = recorded_ref_alloc();
 	if (!new)
 		return -ENOMEM;
 
 	new->dir = ref->dir;
 	new->dir_gen = ref->dir_gen;
-	new->full_path = NULL;
-	INIT_LIST_HEAD(&new->list);
 	list_add_tail(&new->list, list);
 	return 0;
 }
@@ -2799,9 +2817,7 @@ static void __free_recorded_refs(struct list_head *head)
 
 	while (!list_empty(head)) {
 		cur = list_entry(head->next, struct recorded_ref, list);
-		fs_path_free(cur->full_path);
-		list_del(&cur->list);
-		kfree(cur);
+		recorded_ref_free(cur);
 	}
 }
 
@@ -6216,9 +6232,7 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
 		ret = send_unlink(sctx, ref->full_path);
 		if (ret < 0)
 			goto out;
-		fs_path_free(ref->full_path);
-		list_del(&ref->list);
-		kfree(ref);
+		recorded_ref_free(ref);
 	}
 	ret = 0;
 out:
-- 
2.37.0

