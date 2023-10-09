Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08F7BE428
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbjJIPNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376666AbjJIPNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:13:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3302FD;
        Mon,  9 Oct 2023 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864404; x=1728400404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Yna5gTXo7UZceq8nYgGY6hXKf64iK95iaaag7rQQik=;
  b=c6beRt/GgOnihtoIH4HWRvzuc3XgIdIK7qEAwX59ticBUffy3jQi2UgF
   WP6uTAvtyJrGS1Kes3NxAcBFtdf2iPidaBOjJY44XB/nOrXhST9px9Htf
   bSrhM5ChOfpBnOMHMqQY9HMS6buS8jrZyS4CFKVtlU9A6+1Hk2vDZi/lP
   L2I6Hx1BKtT2yMK3j1NyXZVjIKgp25uRezpmPCxmYQ9vQpLJJZttUK/m5
   K8NtQxG7uILbjOl8Lr8AfuNZkJmRJhcogpwTw6REoQD6DafnrngVVfBrE
   cFNj/ON6QMiAQzfI6bj7po2fAVoMwZHX8uk3xzlylPSVexEsc6hNV/RZn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232096"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869287975"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869287975"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:14 -0700
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
Subject: [PATCH 04/14] linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
Date:   Mon,  9 Oct 2023 17:10:16 +0200
Message-ID: <20231009151026.66145-5-aleksander.lobakin@intel.com>
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

Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
on compile-time constants"), the non-atomic bitops are macros which can
be expanded by the compilers into compile-time expressions, which will
result in better optimized object code. Unfortunately, turned out that
passing `volatile` to those macros discards any possibility of
optimization, as the compilers then don't even try to look whether
the passed bitmap is known at compilation time. In addition to that,
the mentioned linkmode helpers are marked with `inline`, not
`__always_inline`, meaning that it's not guaranteed some compiler won't
uninline them for no reason, which will also effectively prevent them
from being optimized (it's a well-known thing the compilers sometimes
uninline `2 + 2`).
Convert linkmode_*_bit() from inlines to macros. Their calling
convention are 1:1 with the corresponding bitops, so that it's not even
needed to enumerate and map the arguments, only the names. No changes in
vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
doesn't necessarily means the change is meaningless.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/linkmode.h | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 15e0e0209da4..f231e2edbfa5 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -38,10 +38,10 @@ static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
 	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
-{
-	__set_bit(nr, addr);
-}
+#define linkmode_test_bit	test_bit
+#define linkmode_set_bit	__set_bit
+#define linkmode_clear_bit	__clear_bit
+#define linkmode_mod_bit	__assign_bit
 
 static inline void linkmode_set_bit_array(const int *array, int array_size,
 					  unsigned long *addr)
@@ -52,25 +52,6 @@ static inline void linkmode_set_bit_array(const int *array, int array_size,
 		linkmode_set_bit(array[i], addr);
 }
 
-static inline void linkmode_clear_bit(int nr, volatile unsigned long *addr)
-{
-	__clear_bit(nr, addr);
-}
-
-static inline void linkmode_mod_bit(int nr, volatile unsigned long *addr,
-				    int set)
-{
-	if (set)
-		linkmode_set_bit(nr, addr);
-	else
-		linkmode_clear_bit(nr, addr);
-}
-
-static inline int linkmode_test_bit(int nr, const volatile unsigned long *addr)
-{
-	return test_bit(nr, addr);
-}
-
 static inline int linkmode_equal(const unsigned long *src1,
 				 const unsigned long *src2)
 {
-- 
2.41.0

