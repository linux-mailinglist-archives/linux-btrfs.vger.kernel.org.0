Return-Path: <linux-btrfs+bounces-17349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4EBB4D37
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A64D19E642C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5528852B;
	Thu,  2 Oct 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NvkMJJCd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965232741B3;
	Thu,  2 Oct 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428257; cv=none; b=XhxJrLlVySTIR5W0IXdFNdyUFyccas1yQqdf/QCclM7XdaGjNTgPAfUPQ7S6luG5x/o+j7JFPX3+DjIMxzgZCKASKs8E/6LPaGRAqYX+q/pJT7saU5na39RqySWm9c5aPEbD1aV8o+vUjja3igrV+w1QC6GelsIQ7gWVU6+VTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428257; c=relaxed/simple;
	bh=M+DzBGorF0x2HwKxbRALu5Mz4okNvOwcKTlN8glrxuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2yNDvL9OwpZHjuvRfWwGtDJ5NU2rHA0/FxJlqhQO03p6kaVnqTFeQKM/oq4QLiDQ2TrQens0DGajNGuOS+N8uchZlwRn51v5Va0YSpg1QcSTuLvPdEMoj4cP9AXZQYvkg9xbEdlTH8RNE39gXaDk7RVQcMNpdBloiQAlTx1syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NvkMJJCd; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759428255; x=1790964255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8djAgabF22BDsxfYcNFa72Q6mXnC3doUyHk+thXHzBc=;
  b=NvkMJJCdP9ISnUf/ixjYNBdjbqT+JVvJGND5E6YqGdyfoP0HStoxK2xM
   EMph0nMKh06WuCHERKIa4tuvahXBaMZUVhr8rfrebcbxx5PWFPeISIIM3
   M6bzdGz4wIvWVVg8iwvaxxrHUfk/byEIfidcVPVPzQpnOJKh+0bYkWYTF
   RGIblacRDenRFnywQ5sT9AMLNI4vaWb/dkpE9pzT9UWBS/OsIpgwCtCya
   4WfI0xw/C6IEQtTWDfhngYEyxEkVCcSHPhEsSCsKEPMjV2+JN2qFHnOsX
   iNyu8PprQGr2nJqK8odhuq2HuBx4r1eDEidQC2wCcml6vAVdWiMxf657n
   g==;
X-CSE-ConnectionGUID: F7O/5rBXTzqs19lYsV5CmA==
X-CSE-MsgGUID: o2hCyg+aTY+SwcYUrqeRgA==
X-IronPort-AV: E=Sophos;i="6.18,310,1751241600"; 
   d="scan'208";a="3022665"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 18:04:12 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:20291]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.161:2525] with esmtp (Farcaster)
 id 37e09462-d867-4507-b788-f974d13c29ea; Thu, 2 Oct 2025 18:04:12 +0000 (UTC)
X-Farcaster-Flow-ID: 37e09462-d867-4507-b788-f974d13c29ea
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 2 Oct 2025 18:04:10 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 2 Oct 2025
 18:03:58 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <kenneth.feng@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
	<tglx@linutronix.de>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <agk@redhat.com>, <snitzer@kernel.org>,
	<mpatocka@redhat.com>, <clm@fb.com>, <dsterba@suse.com>,
	<luc.vanoostenryck@gmail.com>, <pmladek@suse.com>, <rostedt@goodmis.org>,
	<andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
	<senozhatsky@chromium.org>, <akpm@linux-foundation.org>,
	<lijo.lazar@amd.com>, <asad.kamal@amd.com>, <kevinyang.wang@amd.com>,
	<David.Laight@ACULAB.COM>, <amd-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <dm-devel@lists.linux.dev>,
	<linux-btrfs@vger.kernel.org>, <linux-sparse@vger.kernel.org>,
	<stable@vger.kernel.org>, <farbere@amazon.com>
CC: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Jens Axboe <axboe@kernel.dk>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v3 10/11 6.1.y] minmax.h: simplify the variants of clamp()
Date: Thu, 2 Oct 2025 18:00:28 +0000
Message-ID: <20251002180036.33738-11-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002180036.33738-1-farbere@amazon.com>
References: <20251002180036.33738-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 495bba17cdf95e9703af1b8ef773c55ef0dfe703 ]

Always pass a 'type' through to __clamp_once(), pass '__auto_type' from
clamp() itself.

The expansion of __types_ok3() is reasonable so it isn't worth the added
complexity of avoiding it when a fixed type is used for all three values.

Link: https://lkml.kernel.org/r/8f69f4deac014f558bab186444bac2e8@AcuMS.aculab.com
Signed-off-by: David Laight <david.laight@aculab.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 include/linux/minmax.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 75fb7a6ad4c6..2bbdd5b5e07e 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -183,29 +183,29 @@
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
 
-#define __clamp_once(val, lo, hi, uval, ulo, uhi) ({				\
-	__auto_type uval = (val);						\
-	__auto_type ulo = (lo);							\
-	__auto_type uhi = (hi);							\
+#define __clamp_once(type, val, lo, hi, uval, ulo, uhi) ({			\
+	type uval = (val);							\
+	type ulo = (lo);							\
+	type uhi = (hi);							\
 	BUILD_BUG_ON_MSG(statically_true(ulo > uhi),				\
 		"clamp() low limit " #lo " greater than high limit " #hi);	\
 	BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),				\
 		"clamp("#val", "#lo", "#hi") signedness error");		\
 	__clamp(uval, ulo, uhi); })
 
-#define __careful_clamp(val, lo, hi) \
-	__clamp_once(val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
+#define __careful_clamp(type, val, lo, hi) \
+	__clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
 
 /**
- * clamp - return a value clamped to a given range with strict typechecking
+ * clamp - return a value clamped to a given range with typechecking
  * @val: current value
  * @lo: lowest allowable value
  * @hi: highest allowable value
  *
- * This macro does strict typechecking of @lo/@hi to make sure they are of the
- * same type as @val.  See the unnecessary pointer comparisons.
+ * This macro checks @val/@lo/@hi to make sure they have compatible
+ * signedness.
  */
-#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
+#define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
@@ -217,7 +217,7 @@
  * This macro does no typechecking and uses temporary variables of type
  * @type to make all the comparisons.
  */
-#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
+#define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
 
 /**
  * clamp_val - return a value clamped to a given range using val's type
@@ -230,7 +230,7 @@
  * type and @lo and @hi are literals that will otherwise be assigned a signed
  * integer type.
  */
-#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+#define clamp_val(val, lo, hi) __careful_clamp(typeof(val), val, lo, hi)
 
 /*
  * Do not check the array parameter using __must_be_array().
-- 
2.47.3


