Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD57BE632
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjJIQTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377358AbjJIPOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:14:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4F10E;
        Mon,  9 Oct 2023 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864446; x=1728400446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MDqxXWy3FQK4bmmnOnFrjc86dXXtL75Q8r+lD3avrI0=;
  b=SIGwEomj3Rhy5xumK/gV9ijGyIOYKp3OZkAx24fGojKPIAngXpO40WtO
   NHnyBnZYtALEqGCJ6uiFwUP8mX5pknU8Mnt4k3kDpM3k+uQ8sz1bjm1iW
   5UnqNLfyv7z1s+cHTZY93EtVdpQICd5T/zknX7GTPBVS1QW7i95W9Xi+x
   IvzW039OI4l0R2pi6xOmboFd6/7j/IwKKsxlx9ZDvWDPFLGiNARNGOOYr
   u4sk6Y5Tc1jFnvQ4HKIkPR7ukbz3p11sGYnJU5k0PkuEGFTdqvKvib1Dv
   ghGgE+30j44kK7/3pk2rqwqgjR8FYkQfOS+J8OmVVOYXDljOb+AqvCCzI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232534"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232534"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869288197"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869288197"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:48 -0700
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
Subject: [PATCH 13/14] lib/bitmap: add tests for bitmap_{get,set}_bits()
Date:   Mon,  9 Oct 2023 17:10:25 +0200
Message-ID: <20231009151026.66145-14-aleksander.lobakin@intel.com>
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

bitmap_{get,set}_value8() is now bitmap_{get,set}_bits(). The former
didn't have any dedicated tests in the bitmap test suite.
Add a pack of test cases with variable offset, width, and value to set
(for _set_bits()), randomly generated with the only limitation:
``offset % 32 + width <= 32``, to make sure the tests won't fail or
trigger kernel warnings on 32-bit platforms. For _get_bits(), compare
the return values with the expected ones, calculated and saved manually.
For _set_bit(), do several modifications of the source bitmap and then
compare against the expected resulting one, also pre-calculated.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index cbf1b9611616..6037b66fd30a 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1161,6 +1161,82 @@ static void __init test_bitmap_print_buf(void)
 	}
 }
 
+struct getset_test {
+	u16	offset;
+	u16	width;
+	union {
+		u32	expect;
+		u32	value;
+	};
+};
+
+#define GETSET_TEST(o, w, v) {	\
+	.offset	= (o),		\
+	.width	= (w),		\
+	.value	= (v),		\
+}
+
+static const unsigned long getset_src[] __initconst = {
+	BITMAP_FROM_U64(0x4329c918b472468eULL),
+	BITMAP_FROM_U64(0xb2c20a622474a119ULL),
+	BITMAP_FROM_U64(0x3a08cb5591cea40dULL),
+	BITMAP_FROM_U64(0xc9a7550384e145f8ULL),
+};
+
+static const struct getset_test get_bits_test[] __initconst = {
+	GETSET_TEST(208, 16, 0x84e1),
+	GETSET_TEST(104, 8, 0xa),
+	GETSET_TEST(224, 32, 0xc9a75503),
+	GETSET_TEST(64, 16, 0xa119),
+	GETSET_TEST(169, 1, 0x1),
+	GETSET_TEST(144, 8, 0xce),
+	GETSET_TEST(80, 4, 0x4),
+	GETSET_TEST(24, 4, 0x4),
+};
+
+static const struct getset_test set_bits_test[] __initconst = {
+	GETSET_TEST(56, 4, 0xa),
+	GETSET_TEST(80, 16, 0xb17a),
+	GETSET_TEST(112, 8, 0x1b),
+	GETSET_TEST(0, 32, 0xe8a555f2),
+	GETSET_TEST(16, 2, 0),
+	GETSET_TEST(72, 8, 0x7d),
+	GETSET_TEST(47, 1, 0),
+	GETSET_TEST(160, 16, 0x1622),
+};
+
+static const unsigned long getset_out[] __initconst = {
+	BITMAP_FROM_U64(0x4a294918e8a455f2ULL),
+	BITMAP_FROM_U64(0xb21b0a62b17a7d19ULL),
+	BITMAP_FROM_U64(0x3a08162291cea40dULL),
+	BITMAP_FROM_U64(0xc9a7550384e145f8ULL),
+};
+
+#define GETSET_TEST_BITS	BYTES_TO_BITS(sizeof(getset_out))
+
+static void __init test_bitmap_getset_bits(void)
+{
+	DECLARE_BITMAP(out, GETSET_TEST_BITS);
+
+	for (u32 i = 0; i < ARRAY_SIZE(get_bits_test); i++) {
+		const struct getset_test *test = &get_bits_test[i];
+		u32 val;
+
+		val = bitmap_get_bits(getset_src, test->offset, test->width);
+		expect_eq_uint(test->expect, val);
+	}
+
+	bitmap_copy(out, getset_src, GETSET_TEST_BITS);
+
+	for (u32 i = 0; i < ARRAY_SIZE(set_bits_test); i++) {
+		const struct getset_test *test = &set_bits_test[i];
+
+		bitmap_set_bits(out, test->offset, test->value, test->width);
+	}
+
+	expect_eq_bitmap(getset_out, out, GETSET_TEST_BITS);
+}
+
 /*
  * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
  * To workaround it, GCOV is force-disabled in Makefile for this configuration.
@@ -1238,6 +1314,7 @@ static void __init selftest(void)
 	test_mem_optimisations();
 	test_bitmap_cut();
 	test_bitmap_print_buf();
+	test_bitmap_getset_bits();
 	test_bitmap_const_eval();
 
 	test_find_nth_bit();
-- 
2.41.0

