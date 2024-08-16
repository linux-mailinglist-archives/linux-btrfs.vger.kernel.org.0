Return-Path: <linux-btrfs+bounces-7238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEBC954BA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7112F1F24456
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7C1BD515;
	Fri, 16 Aug 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFMgH9vB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A521BCA0C;
	Fri, 16 Aug 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816800; cv=none; b=fPKJfKAV7PU5ylAVb6DzN44eDAMmmt/KS/y+ZBiB23pgDZya+dLs93xMZ5TEaXhSXAKyGS33vNMLvubcAi0Xzewl/WsoDoInntR4Zdq27x2d3wviw9+FeFdRFiVKjCKZ9jBT9D7Yy82H2+OGTMeilMmkJMd7F+QDJpsbDE7sNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816800; c=relaxed/simple;
	bh=4PkH1xqJoyauYPLTeFqwpXSPhLz7QrsYzPhGNpKM7KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OB7hwxX1MwwRPREq7Nmu7Me4grWeJF33J+ksRsEDwWMa6a8/cnipv1Dpoa1yhkACIkqdfxXiur9znEAYkmlEyDVGKssIwOG6ke4K01NX3urzy2FyoZpKUu6U2ClNXhIkF0/wpgWnY5T7Kn8Io/FTqJvw/+qc6GtiGb9NtMKWJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFMgH9vB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816798; x=1755352798;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4PkH1xqJoyauYPLTeFqwpXSPhLz7QrsYzPhGNpKM7KQ=;
  b=EFMgH9vBgUra+xfJub4zH5EunJ7VY+FDjeERBo3T7oW7hvTyDUQWgjlb
   DeXmUbA+5fb7gZpOskzu1uDYbTHL0+Hm/sE0mtiQWvR0wnT0D3fgQqT5T
   2zSP0U8QfmNVwW3TSUTwM4UknulYewe9iD2nqBgZEnzH92/sa2bs55br/
   u8/5BcrxtiJP+m+W3jm2EUan6iv4zbQ1kNRBl29JUJ1LlZ+3qAa8iLe7s
   NvNqyNT5Jwruw5KOkBWKvSz8yhHZLwzAPKm94TlVkOtZ9c3q3twGXLsYO
   TnFtaP5W7fLWZodpfUiMrNThQjTOHs4nmh5vjoxbiZbSWwrwwp0kXlXM+
   Q==;
X-CSE-ConnectionGUID: EZtpySuRTcaZsgrogD4mBA==
X-CSE-MsgGUID: jYjSkizhQaSK+U0abjlFcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272733"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272733"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:57 -0700
X-CSE-ConnectionGUID: jW0ko+rETeeKZeMEcDL96w==
X-CSE-MsgGUID: zFuzs5tqSDShBwmW/Bez+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411023"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:57 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 08:59:50 -0500
Subject: [PATCH v2 02/25] printk: Add print format (%par) for struct range
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-2-20189a10ad7d@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=4286;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=4PkH1xqJoyauYPLTeFqwpXSPhLz7QrsYzPhGNpKM7KQ=;
 b=t10lP1XtEXcLhFatOm25WwMYhWOifjIkp49NUsu7pjvvp2GsgxzzD0r48iSokf+1HgjbEThrV
 eQs5WVLY9hQDOLd6c4Pe2MmdUE4F0K9gfOQRh/wDs8v7yjwCFVnjZNX
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The use of struct range in the CXL subsystem is growing.  In particular,
the addition of Dynamic Capacity devices uses struct range in a number
of places which are reported in debug and error messages.

To wit requiring the printing of the start/end fields in each print
became cumbersome.  Dan Williams mentions in [1] that it might be time
to have a print specifier for struct range similar to struct resource

A few alternatives were considered including '%pn' for 'print raNge' but
%par follows that struct range is most often used to store a range of
physical addresses.  So use '%par' for 'print address range'.

To: Petr Mladek <pmladek@suse.com> (maintainer:VSPRINTF)
To: Steven Rostedt <rostedt@goodmis.org> (maintainer:VSPRINTF)
To: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: "Dan Williams" <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/printk-formats.rst | 14 ++++++++++++
 lib/vsprintf.c                            | 37 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 4451ef501936..a02ef899b2a6 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -231,6 +231,20 @@ width of the CPU data path.
 
 Passed by reference.
 
+Struct Range
+------------
+
+::
+
+	%par	[range 0x60000000-0x6fffffff] or
+		[range 0x0000000060000000-0x000000006fffffff]
+
+For printing struct range.  A variation of printing a physical address is to
+print the value of struct range which are often used to hold a physical address
+range.
+
+Passed by reference.
+
 DMA address types dma_addr_t
 ----------------------------
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2d71b1115916..c132178fac07 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1140,6 +1140,39 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	return string_nocheck(buf, end, sym, spec);
 }
 
+static noinline_for_stack
+char *range_string(char *buf, char *end, const struct range *range,
+		      struct printf_spec spec, const char *fmt)
+{
+#define RANGE_PRINTK_SIZE		16
+#define RANGE_DECODED_BUF_SIZE		((2 * sizeof(struct range)) + 4)
+#define RANGE_PRINT_BUF_SIZE		sizeof("[range - ]")
+	char sym[RANGE_DECODED_BUF_SIZE + RANGE_PRINT_BUF_SIZE];
+	char *p = sym, *pend = sym + sizeof(sym);
+
+	static const struct printf_spec str_spec = {
+		.field_width = -1,
+		.precision = 10,
+		.flags = LEFT,
+	};
+	static const struct printf_spec range_spec = {
+		.base = 16,
+		.field_width = RANGE_PRINTK_SIZE,
+		.precision = -1,
+		.flags = SPECIAL | SMALL | ZEROPAD,
+	};
+
+	*p++ = '[';
+	p = string_nocheck(p, pend, "range ", str_spec);
+	p = number(p, pend, range->start, range_spec);
+	*p++ = '-';
+	p = number(p, pend, range->end, range_spec);
+	*p++ = ']';
+	*p = '\0';
+
+	return string_nocheck(buf, end, sym, spec);
+}
+
 static noinline_for_stack
 char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		 const char *fmt)
@@ -1802,6 +1835,8 @@ char *address_val(char *buf, char *end, const void *addr,
 		return buf;
 
 	switch (fmt[1]) {
+	case 'r':
+		return range_string(buf, end, addr, spec, fmt);
 	case 'd':
 		num = *(const dma_addr_t *)addr;
 		size = sizeof(dma_addr_t);
@@ -2364,6 +2399,8 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  *            to use print_hex_dump() for the larger input.
  * - 'a[pd]' For address types [p] phys_addr_t, [d] dma_addr_t and derivatives
  *           (default assumed to be phys_addr_t, passed by reference)
+ * - 'ar' For decoded struct ranges (a variation of physical address which are
+ *        most often stored in struct ranges.
  * - 'd[234]' For a dentry name (optionally 2-4 last components)
  * - 'D[234]' Same as 'd' but for a struct file
  * - 'g' For block_device name (gendisk + partition number)

-- 
2.45.2


