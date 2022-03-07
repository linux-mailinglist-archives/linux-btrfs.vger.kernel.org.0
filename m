Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC64D0AD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiCGWSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiCGWSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F1403FE
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:17:53 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id c7so13243163qka.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=beKo6/e//hVQD951oE83tbWY2gApLeOtTmfF4hyol4E=;
        b=VeRVRY19EIdud83alUddsMkBfxF8fWOEhZlk8Zaovs10mQ/gBPSmQu2LDqgWjIp9uF
         h4TW5gaCTOHDBYSQEbK4v1DsMQ1ha0G0EBWJCcGA5a5Pf2nskKUkXQPg9h9XeXyfAk0P
         wyzG+eIF+g03bDARQ88ApFSze0HsfvElTCOMagS2N2DW1MlA3AGsSh/J+gAebmKvYNvp
         dFPqwAhYK7z20VtGnsnCPu2PWQbV5iFu9xX17b6Kkx18Zlaz0NsYg69MjWBBGzr4IIrR
         +mxcZt1mokPjWSKKsJo4/SeM5/6KUayV8yZrcWJ1xdS2xX7PJ9urjUs0EUY10kLlEwIa
         hFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beKo6/e//hVQD951oE83tbWY2gApLeOtTmfF4hyol4E=;
        b=G5UIxsnkaLuxTahJx4Cd/deSiAJ2lu4NlFwyL2veJ/3PCdxFE1rjkSIktkqtm/gAcl
         vX6s8Dyqoa7KPN3u0/zpjEvfMTNWBrGAAoMNH6cPsdrkIAhQSaNQs8aAUtmN3N75t+qm
         HMul7RWCJE8Ifd4VEiiOiqGASC1pLlbIfU7epoMtW/xVc/gf5dNLqCVRp+yEQeFDGSNL
         Rrjz3eTCe2fMVqUSI92jGARQGQUjNVP+BAMQrYa5VAhZuieBxzuhJ8QH8sbWATVbfLis
         fZd6MT3qLJ1rByMhGa2J9I6hFGEM6NGRdDtrSvb4cx9Rj7g42XjcKxcyd1Os7u6K+tEz
         mVsQ==
X-Gm-Message-State: AOAM530TYih7f0CZXqLkrjPFc9dW4cooIjnwpVSy9o8JxIdKvFsIGkAX
        sqF5q8ooQg99prI4EiEZcNl6cMbg7jI+ke5+
X-Google-Smtp-Source: ABdhPJwrLoS646gOYgsHl9FJjI1i0gmOqu76X66XNbvC6ZHwQK6TfSSNu2ln8X/NVoX7f1959hT8FA==
X-Received: by 2002:a05:620a:45a0:b0:67a:ee33:3c19 with SMTP id bp32-20020a05620a45a000b0067aee333c19mr8200496qkb.150.1646691472565;
        Mon, 07 Mar 2022 14:17:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u14-20020ac858ce000000b002de89087e7dsm9208802qta.78.2022.03.07.14.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/15] btrfs-progs: use btrfs_item_nr_offset() in btrfs_leaf_data
Date:   Mon,  7 Mar 2022 17:17:35 -0500
Message-Id: <4dec0d425c9c0e32234cef44110ff562602b5b2b.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

btrfs_leaf_data returns offsetof(struct btrfs_leaf, items), which is
equivalent to btrfs_item_nr_offset(leaf, 0).  Change the helper to
simply call btrfs_item_nr_offset().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 72c87485..f3343840 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2387,7 +2387,7 @@ BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
 
 static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
 {
-	return offsetof(struct btrfs_leaf, items);
+	return btrfs_item_nr_offset(l, 0);
 }
 
 /* struct btrfs_file_extent_item */
-- 
2.26.3

