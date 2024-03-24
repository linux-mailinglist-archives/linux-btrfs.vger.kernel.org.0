Return-Path: <linux-btrfs+bounces-3544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51C888C70
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 05:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76720B278BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C518AFD4;
	Sun, 24 Mar 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6C3eXtT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9615ECC0;
	Sun, 24 Mar 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322311; cv=none; b=Z0uaTI2BWlGO7Em47VYKLw8Pz0BFcuVHotHuT+HKhPZ5U7GpBmbQM0rZDv31tU+RXyKlsx2kNilp6ZYo/4nBBgzWAyIdug70uwNv8xer+RrttKJxuNC7RPV8iDBVKMT81yyuNE0Pl+jrTQNhiQRV4t8JAA1LKTBub8dTjFQf8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322311; c=relaxed/simple;
	bh=SdKJxNmCpZI7diYOjhg3gzpenx7d7Y4+UcdBECqzHV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ud5NSveDl3AzT1laHz+61lEx/cYkQ4J6Ppb21acp9KHVgX5k7J1Yj63PkH+3AvDmpsP3tpT86P4uaSITO+OlFethqiG/a0JJb45Sjok7ijwkSsYOitg6igNRjJUJiu1G8kdwgk6faCD4xEAmhs7rYKCcJ9Kp1n9lWYsrxfUkkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6C3eXtT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322310; x=1742858310;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SdKJxNmCpZI7diYOjhg3gzpenx7d7Y4+UcdBECqzHV0=;
  b=k6C3eXtTKZAHwUUpne0qIJ3GxNE32ymGILouBC4ZsC2jClwp12b9KNfb
   SUndVFsiEnc9ZdHxEWhAT7HVaJVzEJ8fYFCw00oB8EZJlgo0Cy77k0I2Q
   jLN7d3yjBD++Owwp4yRqMWKmrQxs5b1eAC+DLfO6VP1hpQSHGYW9TzRM/
   yDgD7rUPFi3412xj0jh9YOqUgXhYVHGH9EJTpHxfv+7UObzHGx18xhJMw
   w60xRzKThrd4vFHOdiu1K7VQlRVWtZJzkYAYSWSTFxZTaeYAMK6315fWL
   bmEtggX88p3ofqEAdC9ypUyad3DI6rsT6u4H6DHpoW4/COOz1oJkCtdB1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431762"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464730"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:22 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:24 -0700
Subject: [PATCH 21/26] dax/region: Prevent range mapping allocation on
 sparse regions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-21-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=925;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=SdKJxNmCpZI7diYOjhg3gzpenx7d7Y4+UcdBECqzHV0=;
 b=j4GxZzdCdz6VRtuvgsE/aGqiV1S2P6y/VmyhkFz9BzgBE5/gjCqHSjGiLoXM/n/CvC2x1f70n
 cy40TEvGDUfAFuMAbbNUF0ZJGaG9zb4THvgqpVqx+28odB3iqzjByie
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Sparse regions are not fully populated with memory and this complicates
range mapping of dax devices on those regions.  There is no use case for
range mapping on sparse regions.

Avoid the complication by prevent range mapping of dax devices on sparse
regions.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index bab19fc578d0..56dddaceeccb 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1452,6 +1452,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_mapping.attr && is_static(dax_region))
 		return 0;
+	if (a == &dev_attr_mapping.attr && is_sparse(dax_region))
+		return 0;
 	if ((a == &dev_attr_align.attr ||
 	     a == &dev_attr_size.attr) && is_static(dax_region))
 		return 0444;

-- 
2.44.0


