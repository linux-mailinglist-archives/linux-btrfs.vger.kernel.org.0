Return-Path: <linux-btrfs+bounces-2012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AD8457BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCCD1F24E81
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9F626AB;
	Thu,  1 Feb 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7xPW30T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FE6216D;
	Thu,  1 Feb 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790305; cv=none; b=cTLRfvGM892Y+caZb1OT/GpGYiE3EHggCn3iBPfowIlQRRWBTBbxEyUag8rDb7K2pQqL0q+oIkDHJJ+y3bKs+HyY4zXFH9lybIG9f+QTl/zK322jBhmrvKS3RRik0AtlTKGL5CkkVPm4rjWzFSU3ytE2btB0AnnHlsMIr7VWlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790305; c=relaxed/simple;
	bh=tciizGYemdvBRZOCIgw7Jb9cIFJ+BUDzQuABjrAFCx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmQaivrVHnXoiGxRUModOPFVqkDVmhcNOJuBY7xueHJbvAGQPxvQsayafF/FMwIbfPKgq7+odtY9F5+wg7ot7hGEcd33XeSjcvR/4XvUaitNXunRJwTtxY/ZsOfHY/NJYwv4bjU1+DlIfEqWxsIkjwtSvp6eiQ8GjMRfG/Ltxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7xPW30T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790302; x=1738326302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tciizGYemdvBRZOCIgw7Jb9cIFJ+BUDzQuABjrAFCx8=;
  b=P7xPW30T7pn46dndW/IS2HTjbxD4S2/IRxeLvCidyKxdMj2wm/8McZE5
   6nk31UoVknHvqJWiFBaoShMTpeBi9Sn0h0Gi697onWE0EezkFhzvzujYz
   as1lw/OmYFYayYmn5HcptJI5sNrRATkzq36ZtKTrUq9MSij6QAMGK9j9L
   ClJfhoBvjHynAvVBpiLS8g2w/rv+CFOirvnC/lagJb6ZzVJRRcwHOIElW
   yeaGHcR7kefRDH9YPxEs2pUCFHQy3xmDJ2E7YX/JQQoOqom0bOId7jmMh
   cDlucZxfdTjxVvZQwsjcNP0OjXwyg6BPjyPXw2QiMQfy6r9ZhJp3W4JHh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747184"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747184"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499170"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:56 -0800
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
Subject: [PATCH net-next v5 17/21] lib/bitmap: add tests for IP tunnel flags conversion helpers
Date: Thu,  1 Feb 2024 13:22:12 +0100
Message-ID: <20240201122216.2634007-18-aleksander.lobakin@intel.com>
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

Now that there are helpers for converting IP tunnel flags between the
old __be16 format and the bitmap format, make sure they work as expected
by adding a couple of tests to the bitmap testing suite. The helpers are
all inline, so no dependencies on the related CONFIG_* (or a standalone
module) are needed.

Cover three possible cases:

1. No bits past BIT(15) are set, VTI/SIT bits are not set. This
   conversion is almost a direct assignment.
2. No bits past BIT(15) are set, but VTI/SIT bit is set. During the
   conversion, it must be transformed into BIT(16) in the bitmap,
   but still compatible with the __be16 format.
3. The bitmap has bits past BIT(15) set (not the VTI/SIT one). The
   result will be truncated.
   Note that currently __IP_TUNNEL_FLAG_NUM is 17 (incl. special),
   which means that the result of this case is currently
   semi-false-positive. When BIT(17) is finally here, it will be
   adjusted accordingly.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4ee1f8ceb51d..270afc0cba5c 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -14,6 +14,8 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+#include <net/ip_tunnels.h>
+
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define EXP1_IN_BITS	(sizeof(exp1) * 8)
@@ -1409,6 +1411,108 @@ static void __init test_bitmap_write_perf(void)
 
 #undef TEST_BIT_LEN
 
+struct ip_tunnel_flags_test {
+	const u16	*src_bits;
+	const u16	*exp_bits;
+	u8		src_num;
+	u8		exp_num;
+	__be16		exp_val;
+	bool		exp_comp:1;
+};
+
+#define IP_TUNNEL_FLAGS_TEST(src, comp, eval, exp) {	\
+	.src_bits	= (src),			\
+	.src_num	= ARRAY_SIZE(src),		\
+	.exp_comp	= (comp),			\
+	.exp_val	= (eval),			\
+	.exp_bits	= (exp),			\
+	.exp_num	= ARRAY_SIZE(exp),		\
+}
+
+/* These are __be16-compatible and can be compared as is */
+static const u16 ip_tunnel_flags_1[] __initconst = {
+	IP_TUNNEL_KEY_BIT,
+	IP_TUNNEL_STRICT_BIT,
+	IP_TUNNEL_ERSPAN_OPT_BIT,
+};
+
+/*
+ * Due to the previous flags design limitation, setting either
+ * ``IP_TUNNEL_CSUM_BIT`` (on Big Endian) or ``IP_TUNNEL_DONT_FRAGMENT_BIT``
+ * (on Little) also sets VTI/ISATAP bit. In the bitmap implementation, they
+ * correspond to ``BIT(16)``, which is bigger than ``U16_MAX``, but still is
+ * backward-compatible.
+ */
+#ifdef __BIG_ENDIAN
+#define IP_TUNNEL_CONFLICT_BIT	IP_TUNNEL_CSUM_BIT
+#else
+#define IP_TUNNEL_CONFLICT_BIT	IP_TUNNEL_DONT_FRAGMENT_BIT
+#endif
+
+static const u16 ip_tunnel_flags_2_src[] __initconst = {
+	IP_TUNNEL_CONFLICT_BIT,
+};
+
+static const u16 ip_tunnel_flags_2_exp[] __initconst = {
+	IP_TUNNEL_CONFLICT_BIT,
+	IP_TUNNEL_SIT_ISATAP_BIT,
+};
+
+/* Bits 17 and higher are not compatible with __be16 flags */
+static const u16 ip_tunnel_flags_3_src[] __initconst = {
+	IP_TUNNEL_VXLAN_OPT_BIT,
+	17,
+	18,
+	20,
+};
+
+static const u16 ip_tunnel_flags_3_exp[] __initconst = {
+	IP_TUNNEL_VXLAN_OPT_BIT,
+};
+
+static const struct ip_tunnel_flags_test ip_tunnel_flags_test[] __initconst = {
+	IP_TUNNEL_FLAGS_TEST(ip_tunnel_flags_1, true,
+			     cpu_to_be16(BIT(IP_TUNNEL_KEY_BIT) |
+					 BIT(IP_TUNNEL_STRICT_BIT) |
+					 BIT(IP_TUNNEL_ERSPAN_OPT_BIT)),
+			     ip_tunnel_flags_1),
+	IP_TUNNEL_FLAGS_TEST(ip_tunnel_flags_2_src, true, VTI_ISVTI,
+			     ip_tunnel_flags_2_exp),
+	IP_TUNNEL_FLAGS_TEST(ip_tunnel_flags_3_src,
+			     /*
+			      * This must be set to ``false`` once
+			      * ``__IP_TUNNEL_FLAG_NUM`` goes above 17.
+			      */
+			     true,
+			     cpu_to_be16(BIT(IP_TUNNEL_VXLAN_OPT_BIT)),
+			     ip_tunnel_flags_3_exp),
+};
+
+static void __init test_ip_tunnel_flags(void)
+{
+	for (u32 i = 0; i < ARRAY_SIZE(ip_tunnel_flags_test); i++) {
+		typeof(*ip_tunnel_flags_test) *test = &ip_tunnel_flags_test[i];
+		IP_TUNNEL_DECLARE_FLAGS(src) = { };
+		IP_TUNNEL_DECLARE_FLAGS(exp) = { };
+		IP_TUNNEL_DECLARE_FLAGS(out);
+
+		for (u32 j = 0; j < test->src_num; j++)
+			__set_bit(test->src_bits[j], src);
+
+		for (u32 j = 0; j < test->exp_num; j++)
+			__set_bit(test->exp_bits[j], exp);
+
+		ip_tunnel_flags_from_be16(out, test->exp_val);
+
+		expect_eq_uint(test->exp_comp,
+			       ip_tunnel_flags_is_be16_compat(src));
+		expect_eq_uint((__force u16)test->exp_val,
+			       (__force u16)ip_tunnel_flags_to_be16(src));
+
+		__ipt_flag_op(expect_eq_bitmap, exp, out);
+	}
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1428,6 +1532,7 @@ static void __init selftest(void)
 	test_bitmap_read_write();
 	test_bitmap_read_perf();
 	test_bitmap_write_perf();
+	test_ip_tunnel_flags();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();
-- 
2.43.0


