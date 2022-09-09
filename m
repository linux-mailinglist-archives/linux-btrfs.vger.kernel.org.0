Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED165B41BD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiIIVyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIVyF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42CFF6BA2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r20so1645226qtn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=8wPG5OFv/+Cm5y2CedtG1fVh2+JfzN3tKiGya+HyIbQ=;
        b=7kgtLUKDLzHNhyZj3iQ4bDl0cm3/hHatwBNVZpYHzGQ0Ri9jMYfUyQumBCuBSIg1uF
         0efwRGZjvlmKuv2yoZ12wChis42QZHdlEiUu2F2jz42+RnQaB7IoTtxXvRGBAKkM3LE/
         gf/EOttoxK1j4zc1X/2hen/cUnsPwkELz8kBS3lziSZrw9u9zrcDU9Lvck0HJmZ+6YLn
         CniPJ10MUtaEHSrzc9fpJcjJ89e+LwWLSMJpXDe1DX/1NhBR61Dj+iyX3vP3uEHvKRfo
         axBPRU2ftTEt7A6WWKw0l3g3HrCAYmEpxKebP2n40/OFB1clI3ytLYcTuuvR67rPTtI7
         0BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8wPG5OFv/+Cm5y2CedtG1fVh2+JfzN3tKiGya+HyIbQ=;
        b=K3Aj17VqeNMA9hBh9/8/DVpAJbUGJOzrzMkoiR9l5wHlpyiWP6Sqs0htFivDXXhBHF
         Uqg2hARZqCbZTBW1wIZKCw/+H3GRqC7Cvkg6IkjKeZYKuCb7pX8QzJ4QSDzexL7MdUQ0
         jjshtwdeGkEuHasVJmRqUVXCPGfu7So1egNrqPjSvWH4UDIguMiliGFtWvMxycVPGf6y
         wt5WxUjE0curRtpYoi7DFUM5xmlG4HnxUFdIYTEh2ZpprEUmDmqVkBRCLlMfvcZ4tgBX
         ki9MXwxg3TCF+qb2oKJrbiBiH7F4jFUxEwdVbI48qnfYtvjd15/Xk9v3ri6rDMT/Vkth
         iKEw==
X-Gm-Message-State: ACgBeo0+I5PJmMUgEvomwUeseTR/Mh/NXVy3O4OWA02Zg+YvME6EZeEw
        tJVgtpv+v1Uie69M2CpfZcqw5BKPgkeHsQ==
X-Google-Smtp-Source: AA6agR4BiR2PtLe10uJKdwivKl19XpJ7tcMNTJytGzboM2K9YrxYklWdDdXyfDZIgr/w41yFz+ewrw==
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id z19-20020a05622a061300b00342f81f4f7emr14251758qta.198.1662760444296;
        Fri, 09 Sep 2022 14:54:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b919c6749esm1324815qko.91.2022.09.09.14.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/36] btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's
Date:   Fri,  9 Sep 2022 17:53:22 -0400
Message-Id: <f8bbc048691e020cfa0a7121bad620d54a5a7824.1662760286.git.josef@toxicpanda.com>
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

We only call these functions from the qgroup code which doesn't call
with EXTENT_BIT_LOCKED.  These are BUG_ON()'s that exist to keep us
developers from using these functions with EXTENT_BIT_LOCKED, so convert
them to ASSERT()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ae746857dd6c..5ad22bc27951 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1293,7 +1293,7 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 * either fail with -EEXIST or changeset will record the whole
 	 * range.
 	 */
-	BUG_ON(bits & EXTENT_LOCKED);
+	ASSERT(!(bits & EXTENT_LOCKED));
 
 	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
 			      changeset);
@@ -1321,7 +1321,7 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 * Don't support EXTENT_LOCKED case, same reason as
 	 * set_record_extent_bits().
 	 */
-	BUG_ON(bits & EXTENT_LOCKED);
+	ASSERT(!(bits & EXTENT_LOCKED));
 
 	return __clear_extent_bit(tree, start, end, bits, 0, 0, NULL, GFP_NOFS,
 				  changeset);
-- 
2.26.3

