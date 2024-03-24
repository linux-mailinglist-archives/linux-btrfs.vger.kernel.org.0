Return-Path: <linux-btrfs+bounces-3534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C297F88909C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 07:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F98F1F28B55
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203192AA9C4;
	Sun, 24 Mar 2024 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6v21Mb9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1102002E4;
	Sun, 24 Mar 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322300; cv=none; b=S1ESHq7RHYr1SFgU0keZXgpVMV07c1CwGLlCH/+617QxmC3t89keeQi9nx5J54HAot8eDRXrN+GeEFnZP76fHkFl6IVKepQ3glzjZFOuUQvov0gHxCgTzVpHqinlFd6XcCkzbtN+zrGrb2aBqGvaDYGglvLStXxEvVYjpYnxmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322300; c=relaxed/simple;
	bh=ym05624QlF+M51JYEl67O0kD6CiBDhKaB/w5yQTYn9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWEuCWzJAIXCZcAazLdaTJXn6CZkTbnsjLwMXzCZcEll6/woFxb03P84HxccCUjDHuDFd6IxK+J1JUov7wLbD9O6StMtNERXDFbYYdl7Oi9ubqKI+Up11WjYBuX+BgtwPF3DTcVVeWbD9yL+w7dgUt+Saf6LeQ0tnlXgb1yXHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6v21Mb9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322298; x=1742858298;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ym05624QlF+M51JYEl67O0kD6CiBDhKaB/w5yQTYn9k=;
  b=c6v21Mb9E0YMQvXxUYlTm14w7DPwtcWn52Z6R2EWYXy8DW9PP4YVS553
   1eGgIpWZIw8FJPvovtGbyScyzjE8HXXTF92+mw5a6AwLlXssymoeErIt6
   Bse5aieMwQs0+uY/Eg1DXc7HYGl2egZ/nFMw0bFfyTuBPoyavKC7F5o/q
   mdr6aRK+c9+gZWmHEPhChBQ0zuOGimBEq2EW839ga+AbeNIITjp1MKb83
   9wetxe1H5OHZVHV07NBZpxeaO5p3FKBrpdlPQZ6D7lgk1EuUNqJ4OC4/O
   9gVcslPemjMUDvy9Xh7eL4C6r7ryYILXMI/WwnIvrl2o4biE5a4kqaPrn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10078015"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10078015"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15869362"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:13 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:11 -0700
Subject: [PATCH 08/26] cxl/mem: Expose device dynamic capacity capabilities
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-8-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=4987;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Wq3gb7omnGtPtB2eYEFuqUs1HeX/Mmr6GMdslTnf6Tg=;
 b=O9UTPyK9mGikrLriFRWsu3itRU7wDUho/u57Kv9yshveTfdziesP7bxPSwFf2Mn9EUkPwvYKr
 WJd1eNEu1L9CDHuzPE0WK7GsuAw9KiIUeLgnaHpGt53sYpAstA3YRW7
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

To properly configure CXL regions on Dynamic Capacity Devices (DCD),
user space will need to know the details of the DC Regions available on
a device.

Expose driver dynamic capacity capabilities through sysfs
attributes.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1:
[iweiny: remove review tags]
[iweiny: mark sysfs for 6.10 kernel]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
 drivers/cxl/core/memdev.c               | 76 +++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8b3efaf6563c..8a4f572c8498 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -54,6 +54,23 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/dc/region_count
+Date:		June, 2024
+KernelVersion:	v6.10
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Number of Dynamic Capacity (DC) regions supported on the
+		device.  May be 0 if the device does not support Dynamic
+		Capacity.
+
+What:		/sys/bus/cxl/devices/memX/dc/regionY_size
+Date:		June, 2024
+KernelVersion:	v6.10
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Size of the Dynamic Capacity (DC) region Y.  Only
+		available on devices which support DC and only for those
+		region indexes supported by the device.
 
 What:		/sys/bus/cxl/devices/memX/pmem/qos_class
 Date:		May, 2023
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d4e259f3a7e9..a7b880e33a7e 100644
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
@@ -492,6 +504,63 @@ static struct attribute *cxl_memdev_security_attributes[] = {
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
+static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
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
+	/* Show only the regions supported */
+	if (n < mds->nr_dc_region)
+		return a->mode;
+
+	return 0;
+}
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -567,11 +636,18 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
 	.is_visible = cxl_memdev_security_visible,
 };
 
+static struct attribute_group cxl_memdev_dc_attribute_group = {
+	.name = "dc",
+	.attrs = cxl_memdev_dc_attributes,
+	.is_visible = cxl_dc_visible,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
 	&cxl_memdev_security_attribute_group,
+	&cxl_memdev_dc_attribute_group,
 	NULL,
 };
 

-- 
2.44.0


