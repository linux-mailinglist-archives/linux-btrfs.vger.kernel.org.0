Return-Path: <linux-btrfs+bounces-17390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAB2BB6A81
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 14:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066854ED650
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 12:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7F2F39C2;
	Fri,  3 Oct 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BBnCEa2r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E662F3625;
	Fri,  3 Oct 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493906; cv=none; b=udAQhk91BXNw5lP9K2ZN3DHNJPM46HHImJw6mPykrSdX+P9dcUnVR2m1+Xk/kL4mcAROnPNZ7knfSWrwU6gLqLuPAZBJZ6jyQMS8qghFCXZ0o0sjLV7HcyYo8nK4OxN8HDv58QEhRInYTUGS3GK1sT/4Kf3wKyNLtBeMVCOmy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493906; c=relaxed/simple;
	bh=V2L3IilwofpV6SrsfVTvut5ipDXkokIOm+dTBT4i7eQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFFNnyj7W60lMOr3MkTLJpfULJgeWigEtqDbJOyMg+ciHMOgzy8cOPJUXmQ6bjot0+Kh25w59QH3X3PARxtHNCpWlkjzgchrcDGmfGQ7YHIrLVlbWu5bESaJ+IRxVhBU70yN4aAgkXCofCo9oW9021MwLHfHVKvhD6+UjNnxIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BBnCEa2r; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759493904; x=1791029904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0dUe76w+6n5/NfsPbyefGVCom+xh3GGcFcV3Olhmks=;
  b=BBnCEa2rgWxHW5JvqvxuMGIrGHtEGqInEO0wEdi3CYaexPyFR6RF9KYk
   WqYpTk90HLwusgrLlvsUnykacDYIRLFxhC1jo7sRv/LWBzKtj+27V8lyV
   iod6dbbM4iuFlKwZ5XHbnNWphNTYKjU/lphh41bSuvLfKkJSvsC/gX4AT
   PLgHm22dLYOgkHorQNINtfz0+HGchiuD+bT5Y7jwtlrYFvk9MXUUya67W
   nmRKX4rTi6PfyQ9j8saK+mrAfCqmkzZm3MXg8laudnN/9DmczFf98WOiG
   ymoQbm7rcgxlzsit92jHFASQRvP5vPXBYeF/G6Ju6iLdy4EJjjkdh6Jgz
   g==;
X-CSE-ConnectionGUID: iHjhxUPQRHe2B4gOSiKoaw==
X-CSE-MsgGUID: DWm3LlXiQW+twGunnV0KdA==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="3061377"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 12:18:13 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:28099]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.19.222:2525] with esmtp (Farcaster)
 id 30f3960f-1ebe-474e-89a0-a1458ac740d9; Fri, 3 Oct 2025 12:18:13 +0000 (UTC)
X-Farcaster-Flow-ID: 30f3960f-1ebe-474e-89a0-a1458ac740d9
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 12:18:13 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 12:18:01 +0000
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
Subject: [PATCH v4 11/11 6.1.y] minmax.h: remove some #defines that are only expanded once
Date: Fri, 3 Oct 2025 12:15:20 +0000
Message-ID: <20251003121520.8176-12-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251003121520.8176-1-farbere@amazon.com>
References: <20251003121520.8176-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: David Laight <David.Laight@ACULAB.COM>

[ Upstream commit 2b97aaf74ed534fb838d09867d09a3ca5d795208 ]

The bodies of __signed_type_use() and __unsigned_type_use() are much the
same size as their names - so put the bodies in the only line that expands
them.

Similarly __signed_type() is defined separately for 64bit and then used
exactly once just below.

Change the test for __signed_type from CONFIG_64BIT to one based on gcc
defined macros so that the code is valid if it gets used outside of a
kernel build.

Link: https://lkml.kernel.org/r/9386d1ebb8974fbabbed2635160c3975@AcuMS.aculab.com
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
 include/linux/minmax.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 2bbdd5b5e07e..eaaf5c008e4d 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -46,10 +46,8 @@
  * comparison, and these expressions only need to be careful to not cause
  * warnings for pointer use.
  */
-#define __signed_type_use(ux) (2 + __is_nonneg(ux))
-#define __unsigned_type_use(ux) (1 + 2 * (sizeof(ux) < 4))
 #define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
-	__signed_type_use(ux) : __unsigned_type_use(ux))
+	(2 + __is_nonneg(ux)) : (1 + 2 * (sizeof(ux) < 4)))
 
 /*
  * Check whether a signed value is always non-negative.
@@ -57,7 +55,7 @@
  * A cast is needed to avoid any warnings from values that aren't signed
  * integer types (in which case the result doesn't matter).
  *
- * On 64-bit any integer or pointer type can safely be cast to 'long'.
+ * On 64-bit any integer or pointer type can safely be cast to 'long long'.
  * But on 32-bit we need to avoid warnings about casting pointers to integers
  * of different sizes without truncating 64-bit values so 'long' or 'long long'
  * must be used depending on the size of the value.
@@ -66,12 +64,12 @@
  * them, but we do not use s128 types in the kernel (we do use 'u128',
  * but they are handled by the !is_signed_type() case).
  */
-#ifdef CONFIG_64BIT
-  #define __signed_type(ux) long
+#if __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__
+#define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
 #else
-  #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L))
+#define __is_nonneg(ux) statically_true( \
+	(typeof(__builtin_choose_expr(sizeof(ux) > 4, 1LL, 1L)))(ux) >= 0)
 #endif
-#define __is_nonneg(ux) statically_true((__signed_type(ux))(ux) >= 0)
 
 #define __types_ok(ux, uy) \
 	(__sign_use(ux) & __sign_use(uy))
-- 
2.47.3


