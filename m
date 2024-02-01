Return-Path: <linux-btrfs+bounces-2001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1528784578C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DA8295086
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547221649D2;
	Thu,  1 Feb 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/QtCQ6+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA541649C5;
	Thu,  1 Feb 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790244; cv=none; b=jxUoYcLAmpIlkwTdCo1hPmDtGYPRIb4ZtSYOvU2UVDKRWnS3REJRBEdZwsIzVpPWO5pATamnnwwq6kw4xroQymq8zrrX6drv1o+0it6MEKzACl8k08Y3YuFlZ87UKUh7aelPrwziFQacbq3UAKCl2G2xmmAIYJDqbspi9JgUhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790244; c=relaxed/simple;
	bh=SoA/u9+ab8IWfX0PrdnuNf/ZyTjLUt7GJssFy85j9T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM4UwVeJQyYgWC3GiJ23M6kpLobhfE4RvTCz+aJcBIAR4k9xztXTDrATOpW47D1wu5ecSqU1by+pJnATqQSwnW5H3rjqkZYm5rs/aPd54tQXMmS9VGNxKE3p52VqJHujOFKLu0W6LFxC7GrE3gWZvByH0vSsAi1dGGgr1etWBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/QtCQ6+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790244; x=1738326244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SoA/u9+ab8IWfX0PrdnuNf/ZyTjLUt7GJssFy85j9T4=;
  b=B/QtCQ6+6zS9xgkahcW9mD8LE3nFzTjX4bUDg8aTqSaO7RPli38u3AdO
   sWJFAMZjNNNb+3okTBfYzmb4+zVA9y/SSNl1ZOnMWXRLSFdgTodKn0OBY
   jOw3q0myLh5lQz6bQE2bVq1qkD0MAGXrrZ55isHgON1+NqY6mSbZ8FnMh
   Ez7pdIDv4aJZudsC+apq7ZU2Uujs1nHX3iL/wEU3d16EKxoEPWqIpwsWE
   K+3u1RK9hScoitgIseXKAWNkSnIIuNWwrzovQjEw3Fa8sfOvuBdi0JjCE
   8RerQVbHl8zgTRW3Khri9loLuWkDFjnlcvspG/JXrOlBv0q1UxW8QlLiz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3746983"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3746983"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499104"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:23:57 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v5 06/21] bitops: let the compiler optimize {__,}assign_bit()
Date: Thu,  1 Feb 2024 13:22:01 +0100
Message-ID: <20240201122216.2634007-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
as `volatile` (as we usually do for bitops) or was hoping that the
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

Atomic assign_bit() is less affected due to its nature, but let's
convert it to a macro as well to keep the code consistent and not
leave a place for possible suboptimal codegen. Moreover, with certain
kernel configuration it actually gives some saves (x86):

do_ip_setsockopt    4154    4099     -55

Suggested-by: Yury Norov <yury.norov@gmail.com> # assign_bit(), too
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitops.h | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index e0cd09eb91cd..b25dc8742124 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -275,23 +275,11 @@ static inline unsigned long fns(unsigned long word, unsigned int n)
  * @addr: the address to start counting from
  * @value: the value to assign
  */
-static __always_inline void assign_bit(long nr, volatile unsigned long *addr,
-				       bool value)
-{
-	if (value)
-		set_bit(nr, addr);
-	else
-		clear_bit(nr, addr);
-}
+#define assign_bit(nr, addr, value)					\
+	((value) ? set_bit((nr), (addr)) : clear_bit((nr), (addr)))
 
-static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
-					 bool value)
-{
-	if (value)
-		__set_bit(nr, addr);
-	else
-		__clear_bit(nr, addr);
-}
+#define __assign_bit(nr, addr, value)					\
+	((value) ? __set_bit((nr), (addr)) : __clear_bit((nr), (addr)))
 
 /**
  * __ptr_set_bit - Set bit in a pointer's value
-- 
2.43.0


