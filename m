Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992DA75D537
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGUTsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGUTsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 15:48:31 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009F2D7E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 12:48:30 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-cb4de3bd997so5092100276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689968909; x=1690573709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=REYU7wtoXPaXK5+8EvlWJ8j+7C0tsyFIsn1U4/RaKF4=;
        b=S40iCYrXBJCfKekHhG+dtDqL8RK6YYYtYdXlEK4J922vHeq2HMUD1vEYowKgXKRpA+
         u/nDU9B3gqkARHzWZw9SBlvOi1fO8j8ehY4HqyINvUXBBmzrNS38OhB3mEfbYfaJeOqF
         yFjQi29pGZqL/IB/i0J4D2Pi7dkn/UUoKrKMpUldpS4TrUwVufYiJJGFn/5YasgDyr9r
         oHctTGt1U9PGhIvySEnau9FWi0h/tCwsKZWFtAxEdaAg368QSBhsUJkxQ/mFC2N7silb
         pPrupRJ6gJEy8sdwHqc1pgrd1rTWc9sH42cX28M9WRH8SgIIUqQm4shmgAklUz+/1P4c
         n7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968909; x=1690573709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REYU7wtoXPaXK5+8EvlWJ8j+7C0tsyFIsn1U4/RaKF4=;
        b=ipZBKix7tyB7WPsw2yknfpEywpq1hew39nREq79zMAG75hUgA2iPFPJk8rVEbJTKfB
         BY59SryQed8LlbgkSBH/K/ggn/2ZGrLKPtZ++MCUJsZ7flZi5e/a9guExC5oXwgWpjeZ
         QOY7AOSM5Y2blL43vlz1lJNFgFcSHS/SzGgZlrP0eSoHSAsnhMckNayk7xk7HiAvf/QH
         oWTNUTlFBDLbkpXhuYgcjOc0TGj8Rf5v1ZxbaleJBj9RwjXggawGyL+KLTQeeuAs8tZa
         ctlO01uf4ZAcHx9j5+xmi/hqwVaLWWQ6gF9Z93C9TS86G3IBCBi0eIsiK2zatwJWB/xG
         mzfw==
X-Gm-Message-State: ABy/qLbaBwZJskvMSVR2+acRvRFuUGLrIBb51ZceSdUX0TBi1jeR51YX
        Q9zph3L6ghysZq3Ql7mwT0scgN23gp2IcToOLpHA2g==
X-Google-Smtp-Source: APBJJlFGzEVa0fOW8ScjNavSS4gM69gJn2NDFgoSEp0arq3j9lhlInFNfNBSrui4LRhy3EvlpDECgg==
X-Received: by 2002:a25:ff19:0:b0:cfc:d478:be7e with SMTP id c25-20020a25ff19000000b00cfcd478be7emr6313741ybe.10.1689968909005;
        Fri, 21 Jul 2023 12:48:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b12-20020a25ae8c000000b00bc68b767cf9sm959434ybj.41.2023.07.21.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:48:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: make check actually honor expunged list
Date:   Fri, 21 Jul 2023 15:48:24 -0400
Message-ID: <732fc62557b3dfdba820b83cd9643de314b6976e.1689968898.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The patch 60054d51 ("check: fix excluded tests are only expunged in the
first iteration") messed up the logic, if _function will be true if it
gets 1, so the _expunge_test return values are inverted.  Also it
appears bash swallows the output in this calling convention, so you
don't get the 'expunged' output.  I noticed this when my CI system
stopped honoring my exclude list, this makes everything work properly
again.

Fixes: 60054d51 ("check: fix excluded tests are only expunged in the first iteration")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/check b/check
index c8593252..b731af74 100755
--- a/check
+++ b/check
@@ -570,11 +570,10 @@ _expunge_test()
 
 	for f in "${exclude_tests[@]}"; do
 		if [ "${TEST_ID}" == "$f" ]; then
-			echo "       [expunged]"
-			return 0
+			return 1
 		fi
 	done
-	return 1
+	return 0
 }
 
 # retain files which would be overwritten in subsequent reruns of the same test
@@ -870,6 +869,7 @@ function run_section()
 
 		if $showme; then
 			if _expunge_test $seqnum; then
+				echo "       [expunged]"
 				tc_status="expunge"
 			else
 				echo
@@ -896,6 +896,7 @@ function run_section()
 
 		# check if we really should run it
 		if _expunge_test $seqnum; then
+			echo "       [expunged]"
 			tc_status="expunge"
 			_stash_test_status "$seqnum" "$tc_status"
 			continue
-- 
2.41.0

