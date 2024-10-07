Return-Path: <linux-btrfs+bounces-8602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA10993ABD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E131B238B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351B1BAED7;
	Mon,  7 Oct 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hou60Htl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AB194AF0;
	Mon,  7 Oct 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342981; cv=none; b=ZCY04ShgErNK/i536RdZN7NtraILDH5ttWvh1K16o5Dv2PYZ4r9uouWnHE/if0Z7FFXe9VERVs8PbcW+s3/abuXheXPRcAHZkvWg+tqIGIEDHXSWQkLnweboxdiQ9OOXNfatGuW/Oqqm1pjk6gIrljAyh15bhZwVXdPeZy5+gPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342981; c=relaxed/simple;
	bh=2azPbNODrjYmNjVNeBlPJpXVLjjSwLlrJnazo0gxtFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKpmWGxH+1pHkimvqvSfKn9sZrGEw+Q1sgBFr1NdxhGKGT11+BtF9gvuQBRCryXJe1vME698JL7EmAYwZIH6fHglh+cDhn4ZKrgV0F4+gAZsNjcMAhJnVBhVplfeXt5mgxqBMX8cwsmlxMX5jpH8u7/m2SRv+T7YNUfi2rRJzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hou60Htl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342980; x=1759878980;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2azPbNODrjYmNjVNeBlPJpXVLjjSwLlrJnazo0gxtFA=;
  b=hou60HtllgELiZuV3dTuif4IBFxHgrpiY7VMYZUgeNjj6swfftCc/HUF
   0gucgUC7xqYIJZQH+OtsSIR1bSDlwJqDwiBqPWU7qT2dQfReYISK8zfSv
   cdru7VGayilRwwY2HpIvskon6DQ/im4mKWAFD+0DyByBb7GH95MXeY3jb
   qcEfrooriNv390CpHEtJT/Wd+P/M8ArZKgOcTTS2doriqk+xDrf3kHZNm
   WgnAoUypaazI9OEITYe3hXATkElnUp3dUs2Ub9au9McClYqH4dPYgQ3RV
   kOSaK/wfKiPaXco2y8+mDula2R0qCSFIltBSBRkUCgiDO1aLk1hXQyQF2
   w==;
X-CSE-ConnectionGUID: RjwR8Qp5T8mVnkWAaRO0ow==
X-CSE-MsgGUID: PU241h6zRLS5IorRkk7cTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38078875"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38078875"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:20 -0700
X-CSE-ConnectionGUID: zC210RiYReCH8Im+Cn5CAg==
X-CSE-MsgGUID: thoQvsXtRTOzupBTbzsjcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75634559"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 07 Oct 2024 18:16:08 -0500
Subject: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
In-Reply-To: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=6990;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=2azPbNODrjYmNjVNeBlPJpXVLjjSwLlrJnazo0gxtFA=;
 b=uheFMODMxqI+W1CF3n0CWj08b8LoVoS0YUgv795yVEe+/HX8vHx8arbpZnRo7KUMd4I3wXfR8
 VGejBDsPafjD/swzWmrmN1yiDyDAURXR5C4Dt8o18tqrS+znLiDS6bI
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The use of struct range in the CXL subsystem is growing.  In particular,
the addition of Dynamic Capacity devices uses struct range in a number
of places which are reported in debug and error messages.

To wit requiring the printing of the start/end fields in each print
became cumbersome.  Dan Williams mentions in [1] that it might be time
to have a print specifier for struct range similar to struct resource

A few alternatives were considered including '%par', '%r', and '%pn'.
%pra follows that struct range is similar to struct resource (%p[rR])
but need to be different.  Based on discussions with Petr and Andy
'%pra' was chosen.[2]

Andy also suggested to keep the range prints similar to struct resource
though combined code.  Add hex_range() to handle printing for both
pointer types.

To: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Link: https://lore.kernel.org/all/66cea3bf3332f_f937b29424@iweiny-mobl.notmuch/ [2]
Suggested-by: "Dan Williams" <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[Andy: create new hex_range() and use it in both range/resource]
[Petr/Andy: Use %pra]
[Andy: Add test case start > end]
[Petr: Update documentation]
[Petr: use 'range -']
[Petr: fixup printf_spec specifiers]
[Petr: add lib/test_printf test]
---
 Documentation/core-api/printk-formats.rst | 13 ++++++++
 lib/test_printf.c                         | 26 +++++++++++++++
 lib/vsprintf.c                            | 55 +++++++++++++++++++++++++++----
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 14e093da3ccd..03b102fc60bb 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -231,6 +231,19 @@ width of the CPU data path.
 
 Passed by reference.
 
+Struct Range
+------------
+
+::
+
+	%pra    [range 0x0000000060000000-0x000000006fffffff]
+	%pra    [range 0x0000000060000000]
+
+For printing struct range.  struct range holds an arbitrary range of u64
+values.  If start is equal to end only 1 value is printed.
+
+Passed by reference.
+
 DMA address types dma_addr_t
 ----------------------------
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 5afdf5efc627..e3e75b6d10a0 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -432,6 +432,31 @@ struct_resource(void)
 	     "%pR", &test_resource);
 }
 
+static void __init
+struct_range(void)
+{
+	struct range test_range = {
+		.start = 0xc0ffee00ba5eba11,
+		.end = 0xc0ffee00ba5eba11,
+	};
+
+	test("[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
+
+	test_range = (struct range) {
+		.start = 0xc0ffee,
+		.end = 0xba5eba11,
+	};
+	test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
+	     "%pra", &test_range);
+
+	test_range = (struct range) {
+		.start = 0xba5eba11,
+		.end = 0xc0ffee,
+	};
+	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
+	     "%pra", &test_range);
+}
+
 static void __init
 addr(void)
 {
@@ -807,6 +832,7 @@ test_pointer(void)
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
+	struct_range();
 	addr();
 	escaped_str();
 	hex_string();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 09f022ba1c05..f8f5ed8f4d39 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1039,6 +1039,19 @@ static const struct printf_spec default_dec04_spec = {
 	.flags = ZEROPAD,
 };
 
+static noinline_for_stack
+char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
+		struct printf_spec spec)
+{
+	buf = number(buf, end, start_val, spec);
+	if (start_val != end_val) {
+		if (buf < end)
+			*buf++ = '-';
+		buf = number(buf, end, end_val, spec);
+	}
+	return buf;
+}
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -1115,11 +1128,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		p = string_nocheck(p, pend, "size ", str_spec);
 		p = number(p, pend, resource_size(res), *specp);
 	} else {
-		p = number(p, pend, res->start, *specp);
-		if (res->start != res->end) {
-			*p++ = '-';
-			p = number(p, pend, res->end, *specp);
-		}
+		p = hex_range(p, pend, res->start, res->end, *specp);
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
@@ -1140,6 +1149,34 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	return string_nocheck(buf, end, sym, spec);
 }
 
+static noinline_for_stack
+char *range_string(char *buf, char *end, const struct range *range,
+		   struct printf_spec spec, const char *fmt)
+{
+#define RANGE_DECODED_BUF_SIZE		((2 * sizeof(struct range)) + 4)
+#define RANGE_PRINT_BUF_SIZE		sizeof("[range -]")
+	char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
+	char *p = sym, *pend = sym + sizeof(sym);
+
+	struct printf_spec range_spec = {
+		.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * 8 */
+		.flags = SPECIAL | SMALL | ZEROPAD,
+		.base = 16,
+		.precision = -1,
+	};
+
+	if (check_pointer(&buf, end, range, spec))
+		return buf;
+
+	*p++ = '[';
+	p = string_nocheck(p, pend, "range ", default_str_spec);
+	p = hex_range(p, pend, range->start, range->end, range_spec);
+	*p++ = ']';
+	*p = '\0';
+
+	return string_nocheck(buf, end, sym, spec);
+}
+
 static noinline_for_stack
 char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		 const char *fmt)
@@ -2277,6 +2314,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  * - 'Bb' as above with module build ID (for use in backtraces)
  * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
  * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
+ * - 'ra' struct ranges [range 0x00 - 0xff]
  * - 'b[l]' For a bitmap, the number of bits is determined by the field
  *       width which must be explicitly specified either as part of the
  *       format string '%32b[l]' or through '%*b[l]', [l] selects
@@ -2399,8 +2437,13 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		fallthrough;
 	case 'B':
 		return symbol_string(buf, end, ptr, spec, fmt);
-	case 'R':
 	case 'r':
+		switch (fmt[1]) {
+		case 'a':
+			return range_string(buf, end, ptr, spec, fmt);
+		}
+		fallthrough;
+	case 'R':
 		return resource_string(buf, end, ptr, spec, fmt);
 	case 'h':
 		return hex_string(buf, end, ptr, spec, fmt);

-- 
2.46.0


