Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D24C047C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiBVWXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiBVWXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:13 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9956A052
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 8so3525677qvf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UEPp2e53ngJl+3Oyq7uK+LzqZHJ/Nia41q0m5X2uOBY=;
        b=GYT0Y8d+BecjzUjyd/nH7+WnAthzA+Mr6Pbov8IGUGKZBi65IdEsmiPPwCeA2LJAYI
         wOm36BtRUNkrbM4tGSsd5gpX2GqOl6fBQbo0HcBoNFJwnrUAK/DahxzPc6VoemdxErw1
         Xo2SO46IYprvedFsG2CKPZE99YA4mTqLNbuUzX7WWGOn0busFU7nW3cndk8nItQ6cQUN
         1BbuyXRLjZakTQ1+NG9j6oNtoiUJJtQZS/Eu1W7QM35JdEEDMncUBZtBS7wIOl59HnXe
         LsLLSdbpqtg5t7z+RPyxxvhPrmv8QIBxbCehG6SS/WzW/yvY+mxU1Vkl7H8VKlADXyiQ
         N78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEPp2e53ngJl+3Oyq7uK+LzqZHJ/Nia41q0m5X2uOBY=;
        b=cGvVxl7MzXFTCmbbaouw0CXKxA00Mu7uodfsO9JpX2obLI2Kmp+hhVA0Im05gpcWQo
         1w/g3EIIIeeXSOTwMFwg/2Jh+2qFTHhL/HH5MqwMtViPtdMVqOc5ijZ7jCy2FIw0B97N
         zrno0cFoh6bhYVH+HMtB/XAZY7uC+hsWJ2DRkrXPUU99ltLTvuL2hd877elDhby3FGBE
         GTZMDgFsZXwWy0X4HVQgGdDn2pIQYykqEQ6QL0+USdIL+ndyaCWHGHmL0VDKbVV4sZ2z
         x2mu5jJ7GCK9jJElwpchIDTog7gPYCu5EwtbjYJ6FABpWNFHTjos89EeO9hf7WZvrzpx
         o90w==
X-Gm-Message-State: AOAM531poWCdRZULxS4JEAM8R47KHR/PfwwD7lwh2q3rzgklj15XAdoE
        E90i7ghF9JL/UBNULROx1ras2ezoslYUeVRu
X-Google-Smtp-Source: ABdhPJyG+v7lbEdW2qy2oOJhepVNhD2ABKZUrAsoTJ1z+dsOnfvGS4Dqlig1r7SuTxQYLerKRBwk8g==
X-Received: by 2002:a05:622a:148d:b0:2d6:b8ec:70bf with SMTP id t13-20020a05622a148d00b002d6b8ec70bfmr23840319qtx.520.1645568566355;
        Tue, 22 Feb 2022 14:22:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v145sm595149qkb.63.2022.02.22.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/7] btrfs-progs: fuzz-tests: use --force for --init-csum-tree
Date:   Tue, 22 Feb 2022 17:22:37 -0500
Message-Id: <88a86bf01abf5f367afb36f0b028d89d08c43403.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
References: <cover.1645567860.git.josef@toxicpanda.com>
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

I noticed that 003-multi-check-unmounted was taking a long time, this is
because it was doing the 10 second countdown for each iteration of
--init-csum-tree.  Fix this by using --force to bypass the countdown.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/fuzz-tests/003-multi-check-unmounted/test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/fuzz-tests/003-multi-check-unmounted/test.sh b/tests/fuzz-tests/003-multi-check-unmounted/test.sh
index e93a20af..c6f9cc9f 100755
--- a/tests/fuzz-tests/003-multi-check-unmounted/test.sh
+++ b/tests/fuzz-tests/003-multi-check-unmounted/test.sh
@@ -14,7 +14,7 @@ check_image() {
 
 	image=$1
 	run_mayfail $TOP/btrfs check -s 1 "$image"
-	run_mayfail $TOP/btrfs check --init-csum-tree "$image"
+	run_mayfail $TOP/btrfs check --force --init-csum-tree "$image"
 	run_mayfail $TOP/btrfs check --repair --force --init-extent-tree "$image"
 	run_mayfail $TOP/btrfs check --repair --force --check-data-csum "$image"
 	run_mayfail $TOP/btrfs check --subvol-extents "$image"
-- 
2.26.3

