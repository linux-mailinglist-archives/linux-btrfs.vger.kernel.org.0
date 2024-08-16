Return-Path: <linux-btrfs+bounces-7278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F6954D00
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99D11F290C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED41CB306;
	Fri, 16 Aug 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzUZ1Aka"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570471C9EBA;
	Fri, 16 Aug 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819524; cv=none; b=nQR8U3JUTWgjXGw9kiMCpQwkQZL26IgeV6JrI2cA7cq+QDb1ZzuhJcWQPfd7YjpYWINpqBKP8x+zDWw4D10qLNiKP0tWBfFX5b1K9WzTWsoe1jG4WqEp3FjPU95cd3RBSNrFZt2dX2YxiiMmOiPn/kL8oj+IU6NzNiG4Nr7FzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819524; c=relaxed/simple;
	bh=TT1Kr8PjO9EzFFK+7ZI6aOJhz7Bla3ibNxpdthisd9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKkcMEgYQPbtxx7lbQYGj3uAWRUK254apce+c3f4fuLl43Ew7uKGfbDSbTFKuac5hUKP/wQWINDSU9N0MRpunQzbOMgmoN4uwtHc5WmapcymEPF1wMx5ghdlyPKoAchEAeV1Yj6FOJBVTGIn6Dy6emK8BuIhNoLIsmWKaG0Ntx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzUZ1Aka; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819522; x=1755355522;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TT1Kr8PjO9EzFFK+7ZI6aOJhz7Bla3ibNxpdthisd9I=;
  b=QzUZ1Akalk/lTbNAuTt0p6gaWqfJbOr8jyrwqpLPoLOj1MFENSMzSHQ7
   ZH9ctY81j8VTfuxgcVkablBNHk85SnRWP5X/g6G75awVPLD5+vecmXdS5
   p6DaoaWs8JyjrmuELKhmgZzpBqpSljffEy2vHzZ+eQGj5Bk9EWTg/3Cy2
   HbNuyA6ppOLT0DG8x7RBtB75cuykindbWnCxGukWx8fRQMGxMtMEJ1VWZ
   oP0+r4xY9pSO/GONzI6lX2NZcRB07DIqf0NCnXqbWweYS6ZUHXtCbyfGz
   6g10/qpucdHJMQuc7PFjpphXdf72PtYI9BWas+3Lfek5WeiGj5T0pQu0p
   A==;
X-CSE-ConnectionGUID: lmBQQiMHQWu+Rny+9EqJ9A==
X-CSE-MsgGUID: 9jKAaHTwSxCcCFyhNjjEpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21973076"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="21973076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:16 -0700
X-CSE-ConnectionGUID: tUYCTGFkSzaPN9P6zbceww==
X-CSE-MsgGUID: dprJ10YzQJileWRUBUkIBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="97205589"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:45:14 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:44:27 -0500
Subject: [PATCH v3 19/25] cxl/region/extent: Expose region extent
 information in sysfs
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-19-7c9b96cba6d7@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819456; l=4265;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=P6/+fplyb/+ZFSyo0jMPTE6EnFG/uQFiP+mkQTWMlTw=;
 b=jJ/QAzyqkapSRG4kL6kqyv7V1JLB/WbgPKA6B6ukODICQ1/SWCQ8h15xfdofW4liBTcfefaIg
 gmpp1pYAv5iCarZOWUqZWJfKimfBxDTV8xbsQMPKGfg3COoln/jHsWX
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Extent information can be helpful to the user to coordinate memory usage
with the external orchestrator and FM.

Expose the details of region extents by creating the following
sysfs entries.

        /sys/bus/cxl/devices/dax_regionX/extentX.Y
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: split this out]
[Jonathan: add documentation for extent sysfs]
[Jonathan/djbw: s/label/tag]
[Jonathan/djbw: treat tag as uuid]
[djbw: use __ATTRIBUTE_GROUPS]
[djbw: make tag invisible if it is empty]
[djbw/iweiny: use conventional id names for extents; extentX.Y]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 13 ++++++++
 drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3a5ee88e551b..e97e6a73c960 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -599,3 +599,16 @@ Description:
 		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
 		the number to the closest initiator and access1 provides the
 		number to the closest CPU.
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
+		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
+		/sys/bus/cxl/devices/dax_regionX/extentX.Y/tag
+Date:		October, 2024
+KernelVersion:	v6.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only]  Extent offset and
+		length within the region.  Users can use the extent information
+		to create DAX devices on specific extents.  This is done by
+		creating and destroying DAX devices in specific sequences and
+		looking at the mappings created.
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 34456594cdc3..d7d526a51e2b 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -6,6 +6,63 @@
 
 #include "core.h"
 
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	return sysfs_emit(buf, "%#llx\n", region_extent->hpa_range.start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t length_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+	u64 length = range_len(&region_extent->hpa_range);
+
+	return sysfs_emit(buf, "%#llx\n", length);
+}
+static DEVICE_ATTR_RO(length);
+
+static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &region_extent->tag);
+}
+static DEVICE_ATTR_RO(tag);
+
+static struct attribute *region_extent_attrs[] = {
+	&dev_attr_offset.attr,
+	&dev_attr_length.attr,
+	&dev_attr_tag.attr,
+	NULL,
+};
+
+static uuid_t empty_tag = { 0 };
+
+static umode_t region_extent_visible(struct kobject *kobj,
+				     struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	if (a == &dev_attr_tag.attr &&
+	    uuid_equal(&region_extent->tag, &empty_tag))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group region_extent_attribute_group = {
+	.attrs = region_extent_attrs,
+	.is_visible = region_extent_visible,
+};
+
+__ATTRIBUTE_GROUPS(region_extent_attribute);
+
 static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
 				 struct cxled_extent *ed_extent)
 {
@@ -44,6 +101,7 @@ static void region_extent_release(struct device *dev)
 static const struct device_type region_extent_type = {
 	.name = "extent",
 	.release = region_extent_release,
+	.groups = region_extent_attribute_groups,
 };
 
 bool is_region_extent(struct device *dev)

-- 
2.45.2


