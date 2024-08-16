Return-Path: <linux-btrfs+bounces-7261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D69954CB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953D11F22A15
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36B1BE250;
	Fri, 16 Aug 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTaQuAAZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26291BDA85;
	Fri, 16 Aug 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819466; cv=none; b=cYrXZX69C2Ek1RLHDnZDRpcOwTuMHEbNWXwGyStCvYzgrLfIaLrZjoJ2Fx+DgUU9V0DZL6jCqHLVH+2PyjGPhu+KjJt9tESLVsMEurBisyOM0WQ2atU3Mh7dj+9FCXxrJ9sCZ08EMU+1PX//AWy7Ve7qy+BexpOloCDStNnaORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819466; c=relaxed/simple;
	bh=4PkH1xqJoyauYPLTeFqwpXSPhLz7QrsYzPhGNpKM7KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOuD0LrZ8A1LP5eZgHYmPNBzJCjD7UJUEdqCPMVE2a0ZP6nhhorXzAw6WcVBQfSQDJ0W7U1uYK9N1huxikvodcGTGBs1/vjic2CSdc4xV++BZBXbvPJ3GtLeeyTBhHu8IlcF8ZqU73liy17W13rj4Tdolq24Y4z86n32OXAdwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTaQuAAZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819465; x=1755355465;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4PkH1xqJoyauYPLTeFqwpXSPhLz7QrsYzPhGNpKM7KQ=;
  b=FTaQuAAZefdsYMR1vMwmeMAgcF52cq8SLFUVJYwOM+VBJuUqHwyy4vLe
   MR6WXUi9Wclmm5lqzLv1BPug+RvL1BMxbG8eUg9Rp6wvQyje+pggADaKI
   wO1TtXPy9gJb9dsKZIu8MLRcLjbgggcYRNF+USalLim7EYOuQd03g7MRE
   bq4EDYfbkFf0rDrW7ACn8Bvwh7Nc4tGAKIVg/LCT0We7gnOpt3fz4tFpq
   WO16WJ2CyOYl+stY+/kdd0yrMelmS12tWMmJxjihsVSbDlFEKn4OxNvWf
   YmWotPUzZwOK0deyyDrZYhV3uDNA9qcc1hqYj7vtCQ0y3q82+Lj7fPnK+
   w==;
X-CSE-ConnectionGUID: dIWNRgFkQ1SRJBXrCtdOgQ==
X-CSE-MsgGUID: 3PK8W8PhSyq4+m4KkWXrPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32753013"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32753013"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:24 -0700
X-CSE-ConnectionGUID: iZkQ4oa+QiaB6bk/YMP0yA==
X-CSE-MsgGUID: G0fWL+o6RuKhi0eM5lrbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59532440"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:44:10 -0500
Subject: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819455; l=4286;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=4PkH1xqJoyauYPLTeFqwpXSPhLz7QrsYzPhGNpKM7KQ=;
 b=6r6sIh+04tW8YlHxbGBVQD82Dmhv11gSd5E30E9/6StER4sJmG1uBU0qP6PsYOd94wGMAn6uz
 kiZO8Udfh7dD2NCcYi2mN9yoCJb+hOEBdjKpKuMClLl3AL5cNT53k6D
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


