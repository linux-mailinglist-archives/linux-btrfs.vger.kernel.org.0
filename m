Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773275B41D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIIVyt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiIIVyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205B13D44
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:40 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cr9so2321610qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=+cvKfWDiZhslKUZD7t/TWW47wwwZwgmnyjsI8JiDq1U=;
        b=pPBybdTIutMZ4pEnztnqjB7nPr9xJppmRlDSxaaezjDvvbgUqW62TP8nBdYwrd+yM+
         UPh4/c2qtOkIie1hReZz9tIsiqKiC5+l8eYLmi57DQnbNMN97Mr54/V9cjtFWuZGDIVJ
         zjTrbN7K3/rOjCYy9jzIS6LEBYFoDa7ZLaCKLKheri18L4ShKc53CLy91pK2nts1yRpM
         DI3BV19NN0G5rnaDrEGs8czfUzsoAAyy8wnKEPDziLd6MyPFUTM359BvFD/8NBJrydOZ
         1tiBqGfjLF8vp7eB+jkImi5M/LSIx1r0TLicCY3JNeZp9oUkns/deue9SJtW11CSSFQr
         Vw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+cvKfWDiZhslKUZD7t/TWW47wwwZwgmnyjsI8JiDq1U=;
        b=R5q3SO8OOLk8cgPdWLo0iSjabb0ieIkYay3yBXQ8Dqgy6ZtVSR5cyuBwM4ZU5bigkS
         NK7n8SKPTTubj299rDhxs+nGc6aULKBxG+pk/1iIZbXCfZwtkAJkvrSVkmRDBbjnXPgO
         nzh/LnE2FNeeLtjwH0mdeqmvEmJgF1djTHxs65d3rOaDA8kk4JZsCLbYULY2l77amyEd
         +Ckl8K2YzSSHIIsPonzxpp8oIUFJny8a9oym111DeCxY1fkjA7wmWUgqil8WK3kt1s1+
         DZRuFInrITfwF4N0X9ffymzTH/u59AjQ51ZpumdHQNMJyXtQN4jro6rgx3UrQxksbirl
         sMEw==
X-Gm-Message-State: ACgBeo1jNQBxiCjsrY0APNRqRyKrT3GMjcuF+tplrxB60REYdBxSO4ql
        4ChII9mFQuzTDcvjAWhN0voRJlzWIhMl1Q==
X-Google-Smtp-Source: AA6agR4TneYxtF+Ik8FndlxHY+m19nk9xfZe5U7cjsIxAyBWgp8LP848alzGifCECNFRiQdtyOTnwg==
X-Received: by 2002:a05:622a:1743:b0:35b:a8d6:ff6e with SMTP id l3-20020a05622a174300b0035ba8d6ff6emr35988qtk.269.1662760479361;
        Fri, 09 Sep 2022 14:54:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t2-20020ac865c2000000b00342f6c31da7sm1113949qto.94.2022.09.09.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 33/36] btrfs: don't clear CTL bits when trying to release extent state
Date:   Fri,  9 Sep 2022 17:53:46 -0400
Message-Id: <54da6f3356933057b122b7fa7f16008d8b57cd70.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When trying to release the extent states due to memory pressure we'll
set all the bits except LOCKED, NODATASUM, and DELALLOC_NEW.  This
includes some of the CTL bits, which isn't really a problem but isn't
correct either.  Exclude the CTL bits from this clearing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 597b89826f53..d69d9213da6a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3389,15 +3389,17 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
 		ret = 0;
 	} else {
+		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
+				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
+
 		/*
 		 * At this point we can safely clear everything except the
 		 * locked bit, the nodatasum bit and the delalloc new bit.
 		 * The delalloc new bit will be cleared by ordered extent
 		 * completion.
 		 */
-		ret = __clear_extent_bit(tree, start, end,
-			 ~(EXTENT_LOCKED | EXTENT_NODATASUM | EXTENT_DELALLOC_NEW),
-			 0, NULL, mask, NULL);
+		ret = __clear_extent_bit(tree, start, end, clear_bits, 0, NULL,
+					 mask, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
-- 
2.26.3

