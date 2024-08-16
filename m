Return-Path: <linux-btrfs+bounces-7270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186E954CE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D807B24BBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F741C68B3;
	Fri, 16 Aug 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RecpEXiO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0F1C6887;
	Fri, 16 Aug 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819496; cv=none; b=ltrL+f4wHuyWP/uHMhcbLg++hatyxmMChmcq+dH2tcPs1k3dyU5obZbYj4eWwfvWPKq9wIuP7rAe8rx6jtdHXcfv0IiXdl+KeVLFCTaFMFBEDXEhH9qRLCmUzwVMla9TXggQva79jcw4YXb8R1myt2P0mMsCzoykuRi3xAnXT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819496; c=relaxed/simple;
	bh=EuwIZdTBxuucZWNs1IHHx7UI5yCAFWOZzZein89o/lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENkErrzzC0exuTh4yV4ubUaBI+sefpZWMjbrrrsU7u3PalITr8SdD4Jd55ozjcq/AucqXV4Z1i89pXLM23vJgyb3f7JaBxj2nDJAEWZtVu8SXC/cGTVrXPyf8kmjjPhr0Usgdk61lpKcHGwYD1QlFTEa+5ugY4XjOwxShdE95kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RecpEXiO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819495; x=1755355495;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EuwIZdTBxuucZWNs1IHHx7UI5yCAFWOZzZein89o/lg=;
  b=RecpEXiOkLhLp2SLkm9n/83tXIRGZI0usRcyWNLTdZbThlypx6ckokaI
   CvjiXrIonKfEq3Zriv8L1eCLLi0jU58aYk3G9tfLROoNVxM+Qa51w6+BJ
   nYCm1iO8HtCnKe1iA1c44dX9UY+LvmRFQI5GK1pUGnrhhFMScqzeBpxY/
   xcyg4MSEcWCmI+jtgnU4Aq7PHoW8uOifsvQt9nWkoaESemlt8Ipm0QHa/
   DTmZtX/nmKtL60hsi37ElTd7k4iV3hCl6sskpQXFA4aih1E5Uw2v9juyd
   osBxc/X4uY2f1ud8sRsYIRj1wNHjdtlsBBEZoevioXnkHpgA6uDIL/oyx
   A==;
X-CSE-ConnectionGUID: jkHkZH+VT0+6R0xu22F+bQ==
X-CSE-MsgGUID: rggiEP7uR1uQ7wxRcTdE6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32753166"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32753166"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:54 -0700
X-CSE-ConnectionGUID: aPYJYDYKTzGQyYRzHFUiWw==
X-CSE-MsgGUID: Cf9jMqDJQHqJnnVIvq6Dqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64086989"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:44:53 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:44:19 -0500
Subject: [PATCH v3 11/25] cxl/mem: Expose DCD partition capabilities in
 sysfs
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v3-11-7c9b96cba6d7@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819455; l=5476;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=YPz6lE5LA4LvIZp/Ltai16uHx+vNTDp+xGMjO2PW7AM=;
 b=0Q2ijg863GOxnUfUHkzlUi/7zFYfI2RE5PFVg9JpqHbMp3FvHi9MQzgPynO2KYGjIgfWaprCn
 qliZyR43QakCM5vCZP+h37ndsafhXTLFHDV+4Pk8Ek6Q0pmot88phN/
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

To properly configure CXL regions on Dynamic Capacity Devices (DCD),
user space will need to know the details of the DC partitions available.

Expose dynamic capacity capabilities through sysfs.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: remove review tags]
[Davidlohr/Fan/Jonathan: omit 'dc' attribute directory if device is not DC]
[Jonathan: update documentation for dc visibility]
[Jonathan: Add a comment to DC region X attributes to ensure visibility checks work]
[iweiny: push sysfs version to 6.12]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 12 ++++
 drivers/cxl/core/memdev.c               | 97 +++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 957717264709..6227ae0ab3fc 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -54,6 +54,18 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/dc/region_count
+		/sys/bus/cxl/devices/memX/dc/regionY_size
+Date:		August, 2024
+KernelVersion:	v6.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  The dc
+		directory is only visible on devices which support Dynamic
+		Capacity.
+		The region_count is the number of Dynamic Capacity (DC)
+		partitions (regions) supported on the device.
+		regionY_size is the size of each of those partitions.
 
 What:		/sys/bus/cxl/devices/memX/pmem/qos_class
 Date:		May, 2023
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..7da1f0f5711a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -101,6 +101,18 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t region_count_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%d\n", mds->nr_dc_region);
+}
+
+static struct device_attribute dev_attr_region_count =
+	__ATTR(region_count, 0444, region_count_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -448,6 +460,90 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	NULL,
 };
 
+static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
+}
+
+#define REGION_SIZE_ATTR_RO(n)						\
+static ssize_t region##n##_size_show(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
+{									\
+	return show_size_regionN(to_cxl_memdev(dev), buf, (n));		\
+}									\
+static DEVICE_ATTR_RO(region##n##_size)
+REGION_SIZE_ATTR_RO(0);
+REGION_SIZE_ATTR_RO(1);
+REGION_SIZE_ATTR_RO(2);
+REGION_SIZE_ATTR_RO(3);
+REGION_SIZE_ATTR_RO(4);
+REGION_SIZE_ATTR_RO(5);
+REGION_SIZE_ATTR_RO(6);
+REGION_SIZE_ATTR_RO(7);
+
+/*
+ * RegionX attributes must be listed in order and first in this array to
+ * support the visbility checks.
+ */
+static struct attribute *cxl_memdev_dc_attributes[] = {
+	&dev_attr_region0_size.attr,
+	&dev_attr_region1_size.attr,
+	&dev_attr_region2_size.attr,
+	&dev_attr_region3_size.attr,
+	&dev_attr_region4_size.attr,
+	&dev_attr_region5_size.attr,
+	&dev_attr_region6_size.attr,
+	&dev_attr_region7_size.attr,
+	&dev_attr_region_count.attr,
+	NULL,
+};
+
+static umode_t cxl_memdev_dc_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	/* Not a memory device */
+	if (!mds)
+		return 0;
+
+	if (a == &dev_attr_region_count.attr)
+		return a->mode;
+
+	/*
+	 * Show only the regions supported, regionX attributes are first in the
+	 * list
+	 */
+	if (n < mds->nr_dc_region)
+		return a->mode;
+
+	return 0;
+}
+
+static bool cxl_memdev_dc_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	/* No DC regions */
+	if (!mds || mds->nr_dc_region == 0)
+		return false;
+	return true;
+}
+
+DEFINE_SYSFS_GROUP_VISIBLE(cxl_memdev_dc);
+
+static struct attribute_group cxl_memdev_dc_group = {
+	.name = "dc",
+	.attrs = cxl_memdev_dc_attributes,
+	.is_visible = SYSFS_GROUP_VISIBLE(cxl_memdev_dc),
+};
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -528,6 +624,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
 	&cxl_memdev_security_attribute_group,
+	&cxl_memdev_dc_group,
 	NULL,
 };
 

-- 
2.45.2


