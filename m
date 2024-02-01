Return-Path: <linux-btrfs+bounces-1998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0A845777
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCC5290509
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971A2161B54;
	Thu,  1 Feb 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaNBGkGq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943716089E;
	Thu,  1 Feb 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790231; cv=none; b=iYdpgjSK4LjvzjrMGCB+X+lrwoQTJo6tYJPTRcOlBr6sPgedIkZfhs7/LKJiPP7Bi9u8AWO+Zep3FcQg5hI9hpaJ+6ZiHAcqJDOc5M7hAYZ0cV2suXYqndsBCca5mvUbgaCy0LaHEe2MtFECb/Qb33uvMDqaF3Cik2DWuFfGxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790231; c=relaxed/simple;
	bh=C0jCnN2niwUwVCK3xrfR+OUG4g6M8f7iVWlMtJ0aO34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEYiPpBiHBNuwQ+rFmbx72IJxXghHOyj0MXZXITgsV/SoPaCLdc6tkvnR4Py2CC5TtZIyerZIkWL3eRCFtDX85lEE6emJG5CS6G+c9TK9Fvdq6JfjyPpPiTG6YzNOOBwItcgeHWgyq3drlAdBfy0jprnhNY8yIoNbPSr4VEFwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaNBGkGq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790228; x=1738326228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C0jCnN2niwUwVCK3xrfR+OUG4g6M8f7iVWlMtJ0aO34=;
  b=aaNBGkGq+afEERKaz3UwE7bUdbbWjDIlqT7FMjAbi81mrY8nGA8wM6cv
   IOivIF+CrYDPII3YRSOMQO+vGKX89LCjP6qFsMWJjPsdk70C31rzyIFdX
   BA6YOb6f0JQDBZ2SzMjIrDq9pDizZf4FLah74LRszmLdXW2UiThm3RzYk
   Eq6ZHp/5rYEwi61O/DQwAqpQqV2j8z9rx9/23bSmxoIRbGHWmEp/Xmvwe
   Jt41xnbcO1K/2TWeyfZgILv+EgU9Wu/ytkpFi3B6rMpqRa+iZVlOhaKzU
   Y0EK1JUUA9XfhILegbWOE0CUXhrpOqYgLmhkL46XrUNOGwCEnR852tRKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3746901"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3746901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499090"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:23:42 -0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 03/21] lib/test_bitmap: use pr_info() for non-error messages
Date: Thu,  1 Feb 2024 13:21:58 +0100
Message-ID: <20240201122216.2634007-4-aleksander.lobakin@intel.com>
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

From: Alexander Potapenko <glider@google.com>

pr_err() messages may be treated as errors by some log readers, so let
us only use them for test failures. For non-error messages, replace them
with pr_info().

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 46c015468077..a6e92cf5266a 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -507,7 +507,7 @@ static void __init test_bitmap_parselist(void)
 		}
 
 		if (ptest.flags & PARSE_TIME)
-			pr_err("parselist: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
 					i, ptest.in, time);
 
 #undef ptest
@@ -546,7 +546,7 @@ static void __init test_bitmap_printlist(void)
 		goto out;
 	}
 
-	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
 out:
 	kfree(buf);
 	kfree(bmap);
@@ -624,7 +624,7 @@ static void __init test_bitmap_parse(void)
 		}
 
 		if (test.flags & PARSE_TIME)
-			pr_err("parse: %d: input is '%s' OK, Time: %llu\n",
+			pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
 					i, test.in, time);
 	}
 }
@@ -1380,7 +1380,7 @@ static void __init test_bitmap_read_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 static void __init test_bitmap_write_perf(void)
@@ -1402,7 +1402,7 @@ static void __init test_bitmap_write_perf(void)
 		}
 	}
 	time = ktime_get() - time;
-	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
 #undef TEST_BIT_LEN
-- 
2.43.0


