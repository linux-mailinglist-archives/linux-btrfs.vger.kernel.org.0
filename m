Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12755B41C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiIIVyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiIIVyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D12100427
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d17so1442918qko.13
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=BZNzRO0bHGDbnRpPEkZRyj4nlvwiHnduw36Zc83fb6o=;
        b=n/7uzKbQTi77VmeAXCl5iJvIPbsmbpT79eywahflig+O7tnbZHZ+TzImMlte+T00RT
         IoKmH5mKxmxACvB+mPByXnQ1YkslO1tCUX7WCfMc8rZAkgwITqZAwbqTPgzCY2YpqAx/
         bDiJE/zQrMSJKrVk9dypCLlxkHnEpIvqBb5d00Zti9EjbP4Mf0/iZ++pXNT7ziUiQBPG
         jlUg1vd4T8z6lKoHpQvWM+VLQ7D3BBHIwrvEghszY2YgyLgS9MkPiTba8axQ6fjWoE/o
         uUOCyUEMEKew6N3rexI+pFsYgpkzGbfy78hhRHxX8cDJ+x4IABoir5pbOnn4QhBrxrA1
         ob8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BZNzRO0bHGDbnRpPEkZRyj4nlvwiHnduw36Zc83fb6o=;
        b=MluNL/TAww7ZNW5s0eLURIWI0yIAwqnke1eeTtqpt0InXliWKIp+iZoSD/KXv2TyFi
         SUk9V4XXoun0I4wm9LYzMpbORKhJjeXMPZieoWtJD1BFwBxWy62SC47IlEJADLmNZNK+
         ysqzQjlc4oSZyIbJXs8Lu1yHAzbhG6wYIyJjXm6P8b+T5MRJ6MmarhKEa/yvHbjkvXlY
         qskfQARJgKk8xebmElpzDTsA7AKowbV+mK5uCWd2ipqiW4Y4G8VcTEn97a9rNtOBdhes
         LcyhBslELgJ8Ll6fi5DFNUIAQepPJ3rcjkrEIyvOnpSdfzJOEHW/sBr7wQplgQtKAkz1
         Ck8Q==
X-Gm-Message-State: ACgBeo3oBd2gA2+YiPG7o+SZorTYCkiaivDsIDYK7yWpwOo2YpCC8g/u
        P9YHwsPXnLaswXcng9LAP3uJomn/HdSuPg==
X-Google-Smtp-Source: AA6agR5kS8eZqGLP4IaiN/TrM+yCIufTwKDSMuiO5KpwtK/VV4bEEH3syOqJyE4HUs2ZQrTPVbNpHA==
X-Received: by 2002:a05:620a:9d9:b0:6cd:d438:8b8a with SMTP id y25-20020a05620a09d900b006cdd4388b8amr2853186qky.300.1662760447030;
        Fri, 09 Sep 2022 14:54:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006bb83e2e65fsm1621019qko.42.2022.09.09.14.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/36] btrfs: export wait_extent_bit
Date:   Fri,  9 Sep 2022 17:53:24 -0400
Message-Id: <510e884aacf27cf2c4dabd53797670c1b7bfb783.1662760286.git.josef@toxicpanda.com>
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

This is used by the subpage code in addition to lock_extent_bits, so
export it so we can move it out of extent_io.c

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 1 +
 fs/btrfs/extent_io.c      | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 16a9da4149f3..3b63aeca941a 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -253,6 +253,7 @@ int extent_invalidate_folio(struct extent_io_tree *tree,
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits);
 
 /* This should be reworked in the future and put elsewhere. */
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb4abca913f4..ebe36ad40add 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -753,8 +753,7 @@ static void wait_on_state(struct extent_io_tree *tree,
  * The range [start, end] is inclusive.
  * The tree lock is taken by this function
  */
-static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-			    u32 bits)
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 {
 	struct extent_state *state;
 	struct rb_node *node;
-- 
2.26.3

