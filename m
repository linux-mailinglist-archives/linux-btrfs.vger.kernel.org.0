Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E388A6D792D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjDEKA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 06:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjDEKAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 06:00:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CAE45;
        Wed,  5 Apr 2023 03:00:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p34so20545960wms.3;
        Wed, 05 Apr 2023 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680688842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wc5+cTG0cXhB4qfxZeR8Q4F8VVxHKnuvjJz5uJiWUg=;
        b=qo96Dg1VDQSG00CA+0bE+lyUMiu68oXuVWXQQl2YXwYHG5nrptP4LmbdoSJyy9Fk2k
         t1daXEiLhayu+08ar+/65Mxng8cCY/GHjOIRjqPQu1AXPFqF6JpOlQio355OfHDF9Uq8
         bpS5UpRapz3BuLBIBaKTFekxQzyzGNjG8FFjW6jmqV3nIruIzk1936LSD76WUI3Kvwur
         +K8NSDhQR9b8NwQkHH25x5eBrCAY0FzDEA4z0CkpsRSj/KtFWw2dE9edSst7bMZZVUbs
         kRI3rcfSUS62vbzGRKd4Dauf4PacVqbv0QzTm3mBWxuOvB6klRySBE/bSYJmEjU4NjK3
         nyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680688842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wc5+cTG0cXhB4qfxZeR8Q4F8VVxHKnuvjJz5uJiWUg=;
        b=qJ/eBOh41WlzR/bSsytFBql6saM6PAkVBt3voQwbCg6Kos1cM904C6qwv78zVgKhDt
         Dtd1Qj/ZBHrkkrpbiKTNyKIlh0F3jiR74a4spEYKK+kAsFWPuzExfNsXOdeWvZ3/z9nT
         /AOtndLhPW12MAk8lNrgTvJQIMsMyBAKKAodp89yfmcmp7QAE9K5YY9DOVOUWQdbma+S
         3yA1kzXeAY2Q/aXsWK7w44rqavrLW+k3huLROv6bPYGTB+Z935HtS95dmWIFjUPF398W
         Z3cFdEzrfKG8YpNNGta9cJpzpU5o22IlbR1xo1axWbWVIvFYIlAI0PzM/bIEV9pvzgSG
         AYUw==
X-Gm-Message-State: AAQBX9fsyy5JY8YVMNemaSmBAShkMiLTiGT68JxZCeNcR2jN77et3H9c
        VAk28P/zrJogVU8T2bjDPc0=
X-Google-Smtp-Source: AKy350YsFkzqaAK1aPYezmPaRdo9SzJ45IR+utrk3deIU+vBmPRF94CwMXVffoV7WKIPfizrrrjTPA==
X-Received: by 2002:a05:600c:2294:b0:3ed:2709:2edf with SMTP id 20-20020a05600c229400b003ed27092edfmr4179643wmf.13.1680688841945;
        Wed, 05 Apr 2023 03:00:41 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d21-20020a1c7315000000b003ed1f6878a5sm1717388wmb.5.2023.04.05.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:00:41 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: Fix spelling mistake "geneartion" -> "generation"
Date:   Wed,  5 Apr 2023 11:00:40 +0100
Message-Id: <20230405100040.12176-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a handful of spelling mistakes of generation. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/scrub.c        | 4 ++--
 fs/btrfs/tree-checker.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ccb4f58ae307..82e6b98878a8 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -69,7 +69,7 @@ struct scrub_sector_verification {
 		/*
 		 * Extra info for metadata verification.
 		 * All sectors inside a tree block shares the same
-		 * geneartion.
+		 * generation.
 		 */
 		u64 generation;
 	};
@@ -712,7 +712,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		bitmap_set(&stripe->error_bitmap, sector_nr,
 			   sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad geneartion, has %llu want %llu",
+		"tree block %llu mirror %u has bad generation, has %llu want %llu",
 			      logical, stripe->mirror_num,
 			      btrfs_stack_header_generation(header),
 			      stripe->sectors[sector_nr].generation);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index e2b54793bf0c..f106a50e6900 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1158,7 +1158,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	/*
 	 * For legacy root item, the members starting at generation_v2 will be
 	 * all filled with 0.
-	 * And since we allow geneartion_v2 as 0, it will still pass the check.
+	 * And since we allow generation_v2 as 0, it will still pass the check.
 	 */
 	read_extent_buffer(leaf, &ri, btrfs_item_ptr_offset(leaf, slot),
 			   btrfs_item_size(leaf, slot));
-- 
2.30.2

