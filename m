Return-Path: <linux-btrfs+bounces-3551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23C8894EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC71F2E1DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4FA3986A5;
	Mon, 25 Mar 2024 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iow/FmYU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DB236D0A;
	Sun, 24 Mar 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322309; cv=none; b=ICxoUtKaUvuw0Kl5MP7wUe7BDSZJamDydxG5VlFdjKh2CZ0jLtuqjsMBZnMsE6ONAKpeHtXUvqWThIlQkS1TZaBHPebJl6DJ9pplS1xvB1X6NphfQPiXweMnfG6iL+2Q3SeGxr/OH64DEJaj4U1LzyoeITJyL/TOeuhk6wzRKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322309; c=relaxed/simple;
	bh=+DJc1mIap7mEkFNzdwzl72773SLqKqtas6uS8idaz98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZd8J5O6s7/qr4Ew6wsaEHA06Kp7FP+LfMw2TWAxJBZQZmCY2FQq83eopwTq9KhS36ndzY/+HDPcYJPU6NaiNka4EsMnpiVvxQO4L5if46Y2TvMy/l00DjkTB11vI4iZn3v21Xci2ZTmootHbjDHqdt8r6OmZNyR6Lh0bqBpc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iow/FmYU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322308; x=1742858308;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+DJc1mIap7mEkFNzdwzl72773SLqKqtas6uS8idaz98=;
  b=Iow/FmYULklMNX+0qCkIU5tFysnN2RcUiMlsfRUOqzxr15Thn0yQfpvE
   8DuKxmUzaue5rDMd2bf8CuR2wr4vLwGuf6DwJ/bhehSP93Hb8O0a1FDOT
   SYppxywdShgZOwT/KBWKjvG5fVTqvYST73BjqTWNhBu0bUb8sUmU8wV8R
   gJENH9095XkZP84VQmSmMiajCOufQH706vwZOnI34MAfR82+ThAgW+drh
   1T/+MsytyZ0R8lE87J5mRCZZ6Saw2RKFc2IaG2rWfyAAoGUAxtPn7n+RB
   w2+5FwhNKgRAESG/xRM7gCK+wN5ojFLDvf059rVi09LLMF+RV4OdjmSnT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431757"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464727"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:21 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:23 -0700
Subject: [PATCH 20/26] dax: Document dax dev range tuple
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-20-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=1060;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=+DJc1mIap7mEkFNzdwzl72773SLqKqtas6uS8idaz98=;
 b=PUQMR0mymeyY/LriUmBNTsS94i+lzbBY8csOAgPv7zWU+jRoNvvbcOd4mM6iKKXvl18QxJVjt
 VuuyFuZUZRmCMduN5qFdVGLi5EDLGi7Ra6czf/F83o95lhq//so/i8F
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The device DAX structure is being enhanced to track additional DCD
information.

The current range tuple was not fully documented.  Document it prior to
adding information for DC.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[iweiny: new patch]
---
 drivers/dax/dax-private.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index c6319c6567fb..ac1ccf158650 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -70,7 +70,10 @@ struct dax_mapping {
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
  * @nr_range: size of @ranges
- * @ranges: resource-span + pgoff tuples for the instance
+ * @ranges: range tuples of memory used
+ * @pgoff: page offset
+ * @range: resource-span
+ * @mapping: device to assist in interrogating the range layout
  */
 struct dev_dax {
 	struct dax_region *region;

-- 
2.44.0


