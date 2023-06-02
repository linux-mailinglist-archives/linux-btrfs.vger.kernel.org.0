Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4972001E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjFBLIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjFBLHf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 07:07:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD102E77;
        Fri,  2 Jun 2023 04:07:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso18615585e9.0;
        Fri, 02 Jun 2023 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685704033; x=1688296033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fs8b67W2fti6J7Z0gwYSWzYfyFCmJ2g7oLo+X0ig/HE=;
        b=Fe91xXtUbkE5mefTe0dSKto5KDsGHabYOpXsNgU8RBrbDl1QGTPHJntc8P/kTb1Wev
         A9UWSQNH9dxDn1qU5cdtb6T1yophEXyC7QZcx8I3zIHVYkjRIKPbD47WZTNHyBjDvNWT
         FVkpV9Icoz6HcJJMGJPXrZdxM/GKC49H71CIqQC1F7uo7jiVxE/LQWm2hz4BJgvYr7q4
         mg5/4vlWeQ0DxOxEYw48N2osmYbUshJsyTDNuTnbjey43cUcU9PEQP2VlpKd8NTgjB0W
         IdIX3HJxEDFXMge8GsqPPofnIkJAJTPj9NW+ipDz6xbF8anH/wfVqiIMQKIc6KKn+TWI
         hTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685704033; x=1688296033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs8b67W2fti6J7Z0gwYSWzYfyFCmJ2g7oLo+X0ig/HE=;
        b=BP7GFoGhxpWEJm87mpyYKjSqw/BGt+cV0SOEsfUskOfGFGJpw0M/QxjiN4Q7rF25dL
         OcKmFSOhVEJQOizKRGcxhGbkhvyjmQEmeq9CxZ6Ui0r8NvUBFZM0KblhN1iXNyP+LVM5
         U728H4xWSKPMyP/gKxHSQpBjYCBojgBlYi0SgPSHL3vFq99we90pLCME/inLUkLQ1TQG
         ENhaxxbwx5PZZe5aibxIjSWPQJC6Is3vzPS1Urkc/C7yQeFHrWs2/VRYj//bp49ZE6IK
         BKoLOZc6rK5wgiB4gc/JssWUlvYMpxGjy4bku+iK+aNnhvC/wf4dmOhf0uu4uj0opgH+
         uyZA==
X-Gm-Message-State: AC+VfDyU0hYBaV7mx76PkoTFcwYeiJOthVBSIW97zjltACX+i1m9ndGp
        AwaajA0fcfbdUZXg1uRvFaiv/rfm494d4g==
X-Google-Smtp-Source: ACHHUZ6SdiuhviilJXjb0CZIzCRGfogTrFJCle0uJ26UO0xzv/U3fAvlP2BObfGEh7aE8qpOAGLnQg==
X-Received: by 2002:a05:600c:2287:b0:3f6:2d8:4823 with SMTP id 7-20020a05600c228700b003f602d84823mr1787821wmf.3.1685704033025;
        Fri, 02 Jun 2023 04:07:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c205100b003f604ca479esm5188918wmg.3.2023.06.02.04.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:07:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: remove redundant variable pages_processed
Date:   Fri,  2 Jun 2023 12:07:11 +0100
Message-Id: <20230602110711.1232370-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Variable pages_processed is being accumulated but it is not being
used after this. An earlier commit 6d6a31e7fc99 ("btrfs: split page
locking out of __process_pages_contig") removed the check on
pages_processed, so this variable is now redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ed83ef4cb72..af60476c0ecf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -227,7 +227,6 @@ static void __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long pages_processed = 0;
 	struct folio_batch fbatch;
 	int i;
 
@@ -242,7 +241,6 @@ static void __process_pages_contig(struct address_space *mapping,
 
 			process_one_page(fs_info, &folio->page, locked_page,
 					 page_ops, start, end);
-			pages_processed += folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.30.2

