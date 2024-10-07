Return-Path: <linux-btrfs+bounces-8601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA936993AB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C28CB21E8B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65BD192D92;
	Mon,  7 Oct 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/TulIXq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF551917EC;
	Mon,  7 Oct 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342978; cv=none; b=aQgsUEZaH0l5xP1GAfqt/72b3SmdOEhVHYbiHDxChoI7hUFtKhHbAYC1gEpBp9m7gm2hvw/t6FwRPLns8u+5rS97nnz3Am3ZJtdyLuZgL+yHeOjY2uzZTqZy5eHp8msp7Bc1YfHfVBU1xucCq1R6BWUWriuMvFIXCHIUh2X8avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342978; c=relaxed/simple;
	bh=mEvzvCXf6Xza6jOx3b/q6LhMdILU5TioeMlGqu/lJ+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rvvfey5isPZrJA1qc1pSzpOxlLYIys0QsOcHnj8put3FC1dYJ3zJLzRYpofnXEzOWmHu9tKsiYOc2SQh0NjYgBVRg2nYyfRtW1QkGZlQFCHBylfolaICOExnyyEYa2XJF0eBTN6fdwK8tWgacX1BP1ZjiYX+asG/G/Xv0jB6XFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/TulIXq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342977; x=1759878977;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mEvzvCXf6Xza6jOx3b/q6LhMdILU5TioeMlGqu/lJ+w=;
  b=b/TulIXq1+j/5fnxmeY4jkjKRFjxSK4My3vQc1nmNFwyA63bypuvEGVB
   CqbeYAFfTFwMj1zROpWPeYXu/61OHUrGpLUFxq9Nd7JVW9szEkMLZEoOB
   WkZi8uzjvTJ1uWzzcqQGK1klyEYFQ2SWvb8HD/DMxCJpxdIz1LXL4podW
   zAe/n/63/JxxFs6fruV+m1QlVRGepGMzHUzstBxKG81xLd7JKUwn1XYb2
   rCCv0Y3gHtfXI1sOIBOibExaJR+bqQqAfojy23N4GkMTvhDUlEBNoxkfw
   82Rd/0pP4A6p14z7gZuzQ1IwrvWDkW7shtERS9HNFmhBBUURLCKbLnPhU
   g==;
X-CSE-ConnectionGUID: YpXk0p79SgaBQkM6YvZqUA==
X-CSE-MsgGUID: 7Tnsf953RbCpz2mUJsV3Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38078855"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38078855"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:16 -0700
X-CSE-ConnectionGUID: qXdqmIHpSwKsZGA8D1BkCw==
X-CSE-MsgGUID: fBjkVD1tSTGYTU4TuQCUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75634540"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:14 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 07 Oct 2024 18:16:07 -0500
Subject: [PATCH v4 01/28] test printk: Add very basic struct resource tests
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-1-c261ee6eeded@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=2032;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=mEvzvCXf6Xza6jOx3b/q6LhMdILU5TioeMlGqu/lJ+w=;
 b=+7p2NcUHW4TM8xK1Eqk4w5yBfrhYTxqcYs3XsZaF/Bq9d/QibzNzizj+3cQ75STcaelDbiCj1
 9XgQ45VbwrrDj3l2jXLZu3MfkbkVFjDmP3UpncnWM2lEB1JsKYUDPwa
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The printk tests for struct resource were stubbed out.  struct range
printing will leverage the struct resource implementation.

To prevent regression add some basic sanity tests for struct resource.

To: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
[lkp: ensure phys_addr_t is within limits for all arch's]
---
 lib/test_printf.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8448b6d02bd9..5afdf5efc627 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -386,6 +386,50 @@ kernel_ptr(void)
 static void __init
 struct_resource(void)
 {
+	struct resource test_resource = {
+		.start = 0xc0ffee00,
+		.end = 0xc0ffee00,
+		.flags = IORESOURCE_MEM,
+	};
+
+	test("[mem 0xc0ffee00 flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xc0ffee,
+		.end = 0xba5eba11,
+		.flags = IORESOURCE_MEM,
+	};
+	test("[mem 0x00c0ffee-0xba5eba11 flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xba5eba11,
+		.end = 0xc0ffee,
+		.flags = IORESOURCE_MEM,
+	};
+	test("[mem 0xba5eba11-0x00c0ffee flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xba5eba11,
+		.end = 0xba5eca11,
+		.flags = IORESOURCE_MEM,
+	};
+
+	test("[mem 0xba5eba11-0xba5eca11 flags 0x200]",
+	     "%pr", &test_resource);
+
+	test_resource = (struct resource) {
+		.start = 0xba11,
+		.end = 0xca10,
+		.flags = IORESOURCE_IO |
+			 IORESOURCE_DISABLED |
+			 IORESOURCE_UNSET,
+	};
+
+	test("[io  size 0x1000 disabled]",
+	     "%pR", &test_resource);
 }
 
 static void __init

-- 
2.46.0


