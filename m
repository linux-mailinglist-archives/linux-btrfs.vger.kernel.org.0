Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3BA7BE44B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377755AbjJIPOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbjJIPOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:14:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9364EA;
        Mon,  9 Oct 2023 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864435; x=1728400435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpadbYZ01czsjx6xeQZ678kvyMyhwvEZrm8aP1rQxlg=;
  b=fHvLYAAqEwzyUD7kJ1mcJt3sTfYE8KoK0Bqfve9epU6q3jUwm+30Ko9e
   x4mwmYRrTp9hUPDDuWHezJgHhp+/Kdc+Ouem/K732fdT79pqDFFHw26VW
   LMnEQyVQSgYlTs9pRzyOlhxHM5MEg4c3idew5XlEuYTBegXi4JbhsWtdc
   roquw/kYlLSscfX+9v8lZn2GboGsNyycMe3/Vm0nS1ZH1lpFb9bVp875g
   5uIuDDzWsrWztnx/qgYGK4kigeJwC7Dn+Z4OKmrvY1ohfiEYbs6aqIq6X
   xXgO5hTcwb2vnwH4hpt6bNA8VyZBa1fgrro8rk1/4ULli2EbS0vkl8Sih
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232503"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232503"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869288163"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869288163"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:45 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] lib/bitmap: add compile-time test for __assign_bit() optimization
Date:   Mon,  9 Oct 2023 17:10:24 +0200
Message-ID: <20231009151026.66145-13-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009151026.66145-1-aleksander.lobakin@intel.com>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit dc34d5036692 ("lib: test_bitmap: add compile-time
optimization/evaluations assertions") initially missed __assign_bit(),
which led to that quite a time passed before I realized it doesn't get
optimized at compilation time. Now that it does, add test for that just
to make sure nothing will break one day.
To make things more interesting, use bitmap_complement() and
bitmap_full(), thus checking their compile-time evaluation as well. And
remove the misleading comment mentioning the workaround removed recently
in favor of adding the whole file to GCov exceptions.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index f2ea9f30c7c5..cbf1b9611616 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1181,14 +1181,7 @@ static void __init test_bitmap_const_eval(void)
 	 * in runtime.
 	 */
 
-	/*
-	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
-	 * Clang on s390 optimizes bitops at compile-time as intended, but at
-	 * the same time stops treating @bitmap and @bitopvar as compile-time
-	 * constants after regular test_bit() is executed, thus triggering the
-	 * build bugs below. So, call const_test_bit() there directly until
-	 * the compiler is fixed.
-	 */
+	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
 	bitmap_clear(bitmap, 0, BITS_PER_LONG);
 	if (!test_bit(7, bitmap))
 		bitmap_set(bitmap, 5, 2);
@@ -1220,6 +1213,15 @@ static void __init test_bitmap_const_eval(void)
 	/* ~BIT(25) */
 	BUILD_BUG_ON(!__builtin_constant_p(~var));
 	BUILD_BUG_ON(~var != ~BIT(25));
+
+	/* ~BIT(25) | BIT(25) == ~0UL */
+	bitmap_complement(&var, &var, BITS_PER_LONG);
+	__assign_bit(25, &var, true);
+
+	/* !(~(~0UL)) == 1 */
+	res = bitmap_full(&var, BITS_PER_LONG);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
 }
 
 static void __init selftest(void)
-- 
2.41.0

