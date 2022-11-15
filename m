Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC572629EA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiKOQQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiKOQQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:27 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D62AC56
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:27 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z6so9000555qtv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B6+OIlb58W5naN5L6pQYFYKHzaAa0xWTDBO6WCdnWU=;
        b=aphTRMAcSjFaCNG0Pf5iIGD8PdfUsXcA200vwqHO3g7bLipFH7qhsWCcH3hUn5bQVZ
         8KfWHPosD0ikcaMQUp4wuTw7NL1BzQ0xvKJKulahtCXIKSyEJpEcdKkansyYYbzrnLkT
         FyS/8lbx3iPW6hqT8i88bpob7Vdkx927KXsbol+LtqOK3jAOVdUoQwkiR3snqiulQP0a
         9Wvpl8r4/k0nrkDa5hrgdJE+jbDEurYM5oXsZxvkmjIrXnPZTVdW3S41teiyxV892UtG
         vcTmGQXgUbV4RfiDoTKyy6he5qTqoB5fCzz7T3nILmDN+LNdjwzJnBzskK6YGq93ESli
         deaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7B6+OIlb58W5naN5L6pQYFYKHzaAa0xWTDBO6WCdnWU=;
        b=xPpxiV0AzDyjX19Sj5lRyAE29iMXcBf1r3JnznrZWZxBecrjXai4sT41+R7daW9+TM
         Sf5eZh+cVlgSZRURe1YznNye6X/BJ4REi+0RQ0MFvsDNOuVpo2hEbvYydqYPtKilVuF3
         pR017yexk7MrgcsWvBPeWGJWk/4KQ1m40MtZFPwYcmAqqG46tmuXeqDIL6XCurKFVxhB
         o9yAJAaHWvOoZ+irW35gkB/FUWe7V7q0eeO0ijZmf2LnOoWAJ2+jGKkiAMN92z3U5v2N
         NXRJxO6BAZ8vjmKodXfVKaoeqUn5kvs2SvwY5mvYOVMOJzmjQvXPc/yRcp1vaVDEzeLs
         sukA==
X-Gm-Message-State: ANoB5pmcmIWhWRn6x8sx6MaMADuQkMfDC7YeDODtRuMLJlh8AP4Ez42+
        zNCkotbaIL3jqmvRgGiZ6+TeA9+ePOuG0g==
X-Google-Smtp-Source: AA0mqf4+/D+9QIszMY3U6KphMn9Uh1UHiCEDHMKVb5v8gNVP3Alhxvr8b0plPmAWoPOiIqxt7ba6Dg==
X-Received: by 2002:a05:622a:997:b0:3a5:58f9:cd0b with SMTP id bw23-20020a05622a099700b003a558f9cd0bmr17379181qtb.404.1668528985978;
        Tue, 15 Nov 2022 08:16:25 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id p70-20020a374249000000b006eef13ef4c8sm8293919qka.94.2022.11.15.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/11] btrfs: move leaf_data_end into ctree.c
Date:   Tue, 15 Nov 2022 11:16:11 -0500
Message-Id: <9b57e241bcf733479552803d3cd7997330f8b87f.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is only used in ctree.c, with the exception of zero'ing out extent
buffers we're getting ready to write out.  In theory we shouldn't have
an extent buffer with 0 items that we're writing out, however I'd rather
be safe than sorry so open code it in extent_io.c, and then copy the
helper into ctree.c.  This will make it easier to sync accessors.[ch]
into btrfs-progs, as this requires a helper that isn't defined in
accessors.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 13 -------------
 fs/btrfs/ctree.c     | 13 +++++++++++++
 fs/btrfs/extent_io.c |  6 +++++-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 57ba6894a5f4..b9d9a69685df 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -897,19 +897,6 @@ const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
 
-/*
- * The leaf data grows from end-to-front in the node.  this returns the address
- * of the start of the last item, which is the stop of the leaf data stack.
- */
-static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
-{
-	u32 nr = btrfs_header_nritems(leaf);
-
-	if (nr == 0)
-		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
-	return btrfs_item_offset(leaf, nr - 1);
-}
-
 /* struct btrfs_file_extent_item */
 BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
 			 type, 8);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8443a2e42fd5..a70355d2edca 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -51,6 +51,19 @@ static const struct btrfs_csums {
 				     .driver = "blake2b-256" },
 };
 
+/*
+ * The leaf data grows from end-to-front in the node.  this returns the address
+ * of the start of the last item, which is the stop of the leaf data stack.
+ */
+static inline unsigned int leaf_data_end(const struct extent_buffer *leaf)
+{
+	u32 nr = btrfs_header_nritems(leaf);
+
+	if (nr == 0)
+		return BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
+	return btrfs_item_offset(leaf, nr - 1);
+}
+
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
 {
 	u16 t = btrfs_super_csum_type(s);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 859a41624c31..6b382070b4ad 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2664,7 +2664,11 @@ static void prepare_eb_write(struct extent_buffer *eb)
 		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
 		 */
 		start = btrfs_item_nr_offset(nritems);
-		end = BTRFS_LEAF_DATA_OFFSET + leaf_data_end(eb);
+		end = BTRFS_LEAF_DATA_OFFSET;
+		if (nritems == 0)
+			end += BTRFS_LEAF_DATA_SIZE(eb->fs_info);
+		else
+			end += btrfs_item_offset(eb, nritems - 1);
 		memzero_extent_buffer(eb, start, end - start);
 	}
 }
-- 
2.26.3

