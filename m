Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB537BE425
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376508AbjJIPNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376657AbjJIPNc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:13:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40881124;
        Mon,  9 Oct 2023 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864400; x=1728400400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mAuoN5CYARcVqA0dlQJabm7qQGV1vBT1FJZYTn4rWfo=;
  b=GrifmPVf90mrQcTzAw1CEVqAJCz2G63Zlra1aZTwbufmOeMQ6vP5v47Q
   O5ojZ6AJA2mPXW8K3m//ZBiQmOU/KfTv2qBTJpX3eH91MuOP2T5c81gkY
   mtEcmdhp23vJ2p7ugmQ5FTVHtVpvJNi7u5iZZsXuPlZCk6YjWy5z+pxGQ
   xrIq/6b2pm0JXtvLSioVU6F+967lHgl6FszOrOMgq4HzzkBnxTPXRKbq4
   HgGDfs96rdyyDcSafjbU4UYWot6x2064Pg0lNX2Jghttv89RpmEdw/XsT
   LXVrvwN/q7Pu42A/YlOQv/25A81JDM7G1QxyGnhOJdEd0HIHBbs4L32SA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232065"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869287957"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869287957"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:11 -0700
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
Subject: [PATCH 03/14] bitops: let the compiler optimize __assign_bit()
Date:   Mon,  9 Oct 2023 17:10:15 +0200
Message-ID: <20231009151026.66145-4-aleksander.lobakin@intel.com>
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
on compile-time constants"), the compilers are able to expand inline
bitmap operations to compile-time initializers when possible.
However, during the round of replacement if-__set-else-__clear with
__assign_bit() as per Andy's advice, bloat-o-meter showed +1024 bytes
difference in object code size for one module (even one function),
where the pattern:

	DECLARE_BITMAP(foo) = { }; // on the stack, zeroed

	if (a)
		__set_bit(const_bit_num, foo);
	if (b)
		__set_bit(another_const_bit_num, foo);
	...

is heavily used, although there should be no difference: the bitmap is
zeroed, so the second half of __assign_bit() should be compiled-out as
a no-op.
I either missed the fact that __assign_bit() has bitmap pointer marked
as `volatile` (as we usually do for bitmaps) or was hoping that the
compilers would at least try to look past the `volatile` for
__always_inline functions. Anyhow, due to that attribute, the compilers
were always compiling the whole expression and no mentioned compile-time
optimizations were working.

Convert __assign_bit() to a macro since it's a very simple if-else and
all of the checks are performed inside __set_bit() and __clear_bit(),
thus that wrapper has to be as transparent as possible. After that
change, despite it showing only -20 bytes change for vmlinux (due to
that it's still relatively unpopular), no drastic code size changes
happen when replacing if-set-else-clear for onstack bitmaps with
__assign_bit(), meaning the compiler now expands them to the actual
operations will all the expected optimizations.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitops.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index e0cd09eb91cd..f98f4fd1047f 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -284,14 +284,8 @@ static __always_inline void assign_bit(long nr, volatile unsigned long *addr,
 		clear_bit(nr, addr);
 }
 
-static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
-					 bool value)
-{
-	if (value)
-		__set_bit(nr, addr);
-	else
-		__clear_bit(nr, addr);
-}
+#define __assign_bit(nr, addr, value)				\
+	((value) ? __set_bit(nr, addr) : __clear_bit(nr, addr))
 
 /**
  * __ptr_set_bit - Set bit in a pointer's value
-- 
2.41.0

