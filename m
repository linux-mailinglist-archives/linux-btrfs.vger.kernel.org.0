Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4017BE451
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377588AbjJIPOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377569AbjJIPOQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:14:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600D112;
        Mon,  9 Oct 2023 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864449; x=1728400449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wU7JZm64DecEQ0mzRvy2E8r0rjYjxULc1eVF+rvfSRI=;
  b=UYdZUGZVWhvY9wyaRM6BFrexhtMnItUck90ovY0MKSErR40xo0H4025I
   Bi/xWWEFVTJ+/v+oFLMtJDVI+FL57DtupCN88dslj/9jvSVvsYYo5i6A0
   a336D+HK4mLydBdLj6nTca1JMLf8bnyv3/24o3JMP8GUAbfFu1cFH+3W5
   UWS4FSI5z17l+bLLv2MaLUwnzkeeMyrbej2mpFxtLLonNRB82CXWvgQ0L
   n1ziY28XQaVb/dYLmzUx0p85z0xwx93nAPZP3q9xibOVxwqCambBlORA9
   vQMo/zaJccA02AnpN310QzXnyQn+SpeKhxLhq60cchdHjIJgqMuao8EAR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232555"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869288214"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869288214"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2023 08:13:52 -0700
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
Subject: [PATCH 14/14] lib/bitmap: add tests for IP tunnel flags conversion helpers
Date:   Mon,  9 Oct 2023 17:10:26 +0200
Message-ID: <20231009151026.66145-15-aleksander.lobakin@intel.com>
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
index 6037b66fd30a..23da19e1ff7e 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -14,6 +14,8 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+#include <net/ip_tunnels.h>
+
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define EXP1_IN_BITS	(sizeof(exp1) * 8)
@@ -1300,6 +1302,108 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(!res);
 }
 
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
@@ -1316,6 +1420,7 @@ static void __init selftest(void)
 	test_bitmap_print_buf();
 	test_bitmap_getset_bits();
 	test_bitmap_const_eval();
+	test_ip_tunnel_flags();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();
-- 
2.41.0

