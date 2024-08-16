Return-Path: <linux-btrfs+bounces-7255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA25954BC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B33A1F22954
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FB51C7B91;
	Fri, 16 Aug 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0JI5v9O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019761C7B74;
	Fri, 16 Aug 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816835; cv=none; b=gA1Iq2ne3PZcTlhST0osIj/fbx4yWkm9A+pn6map/GKtwV0qzh0TV+J9jMnk83zrknkIK5mmSCCvKckf3EN4Skr/A7I2ZU0xMRAGMM08rHfs8j4m5SBnU0fzwFuKrRyEsEQxEPQWSeNdbhR44Udq8njn1diQ57GXll4W/BcIHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816835; c=relaxed/simple;
	bh=TT1Kr8PjO9EzFFK+7ZI6aOJhz7Bla3ibNxpdthisd9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6H7OgIpM5aOGwNneRmVqog9LQBOLXB6zV9kGZ8bNq+kjK4ov1NeEHt7bWA+Z13uJ7t8ysVAg64ozaaHtukCKrmWf0hELKmqzUSMaCQYfG/M3Z5qtRnBXnOud5L7jTPqilj67VTAL2ltzjPuU7C7AOabk/rGjfjlV+YU0RNnp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0JI5v9O; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816834; x=1755352834;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TT1Kr8PjO9EzFFK+7ZI6aOJhz7Bla3ibNxpdthisd9I=;
  b=E0JI5v9OmRBHSZkJ7jxrF+jFe/sORAO1dd3pHxTscCZPhR1zpcURMyRo
   3W1mE4GYhDxz1DpfCxaHg0JHWFFHH0XcKgQ9xF2qG08i6rwly6WBeHBrv
   2I0pykmP0rp0ZAHcz3tQwdPQpPP5YNXl84wJ5auO6/HeEcIUET/SVkW55
   /aPav+Udg2ipAAEZZ2ufACmMF5ym6C11wvhLQk4UVnAsGJEcSbT3idoBm
   HRFZILY7zIet7zMowzYIYLl0INBHB+oWvo+al9QEHg3BH8by48LhXNMId
   n3uElgdnf50mQz886dUrxm43oV5tu7ZyBtR3OsdmDfqrjcLfd7zSH7Doe
   Q==;
X-CSE-ConnectionGUID: nmtdOkQqTKqMtwZ/mR+fqA==
X-CSE-MsgGUID: 4XbTybdKQ2GovHlYrXQgkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272862"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272862"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:33 -0700
X-CSE-ConnectionGUID: kRAu1SCXTDuFjmycXki5eg==
X-CSE-MsgGUID: OIcegIcMQqm0LzTbVMcp6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90411560"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:00:32 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:00:07 -0500
Subject: [PATCH v2 19/25] cxl/region/extent: Expose region extent
 information in sysfs
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-19-20189a10ad7d@intel.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=4265;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=P6/+fplyb/+ZFSyo0jMPTE6EnFG/uQFiP+mkQTWMlTw=;
 b=Ht4VUB4lUoW6HLr0DGeUGmgn4vQB7mfeJwl39HvNlsPZI23vyqigFJK55bGpkg1zw5n7Z40TY
 DNmyqu75J2lA21RVsh8GJZ5NBFg3m3ll4N9GM9RNeVXoHLVEBAnoTz/
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


