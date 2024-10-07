Return-Path: <linux-btrfs+bounces-8611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A946993AE7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0B1C21162
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D71DED64;
	Mon,  7 Oct 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAa0XeO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729F19340A;
	Mon,  7 Oct 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343033; cv=none; b=Rrx4WzpGnFf/SGRdeo0GG185RupoQ031lMin7gKqGcKmbWK98RmaS3yNXT7Krut4sY2ShPMDEn7AwskklmnA2Zo8ttYKQHFbUmKflnjMtavARLjR2nrvJhAy7DW/CbHtM/Vvz6iBQ0skNZ4wn5xwkVw5nRp4IIWWMNbQPnwiB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343033; c=relaxed/simple;
	bh=KIDARv9C/pTmyCfO2S9Xd79mSlfA+k9JqDcB/epNNo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7HOLqH2poL0XqyJGMVItN2MBsnFhmowOU6VSWkhJR97BvroFUqBsxuNKKFjSd30+hiqKH/T/LQo1MqeN+wGbrqZkZlGzdVse08vCwCuRsH7KviNKkId7+2MO6b4ePVlBExp583TobztAsxsnLRtRPF9kaglFPEEtxiUGZbi8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAa0XeO5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728343031; x=1759879031;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KIDARv9C/pTmyCfO2S9Xd79mSlfA+k9JqDcB/epNNo8=;
  b=OAa0XeO5v5G+i6jCN3royUVohHPKom/5vTOuNJbq/uULeqolmLaleJ56
   oei2hOvNSAP7cOoHBrMscP4M4+ls090Tkb18enRtQaayC2AaRACKNJKyk
   H+VR/9CWc8igPsouo0VwNBSD8Ic5S1gdQ0ERgghVGjjDBZrqmFSOyrPXS
   6M0fXnByl8nSW/Xo3YMICpnOVimFmUVNSY2y93KkAEW22epz0NAnO6Aeb
   8ngKXTAsXIuu48qVnDrslYjYC2K2YXmbadz0ukaD0BETpeVzSYn4UitGY
   UzRRRwC3ccQ8mAc9aNKwxgy+1ffEKuI8c7JWhr1LujY1yM/XZbAP+edZh
   Q==;
X-CSE-ConnectionGUID: pFPjeknwTS+eye4fuWWNXw==
X-CSE-MsgGUID: s8fixKYuRhKEWuy+xOlOVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="45036908"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="45036908"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:50 -0700
X-CSE-ConnectionGUID: JXCQ9nUqQG290KCFAJgJdQ==
X-CSE-MsgGUID: ypgP+KcNTzymaTO4P35fkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75309097"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:47 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 07 Oct 2024 18:16:18 -0500
Subject: [PATCH v4 12/28] cxl/cdat: Gather DSMAS data for DCD regions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-12-c261ee6eeded@intel.com>
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
 linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=5051;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=KIDARv9C/pTmyCfO2S9Xd79mSlfA+k9JqDcB/epNNo8=;
 b=i30jEbPdlKb2FUP3XXrKlgJq5yUSUjhPC2hh0aVlB0A0kndpZEFGyCFmDTOT8XciyvJCYstnn
 1GVdzVOMRMkB4U8FhocWfVYElbyqeXabkgcEIYbTLWcGhYm9YvZWUFQ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Additional DCD region (partition) information is contained in the DSMAS
CDAT tables, including performance, read only, and shareable attributes.

Match DCD partitions with DSMAS tables and store the meta data.

To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: new patch]
[iweiny: Gather shareable/read-only flags for later use]
---
 drivers/cxl/core/cdat.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c |  2 ++
 drivers/cxl/cxlmem.h    |  3 +++
 include/acpi/actbl1.h   |  2 ++
 4 files changed, 45 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bd50bb655741..9b2f717a16e5 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -17,6 +17,8 @@ struct dsmas_entry {
 	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int entries;
 	int qos_class;
+	bool shareable;
+	bool read_only;
 };
 
 static u32 cdat_normalize(u16 entry, u64 base, u8 type)
@@ -74,6 +76,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 		return -ENOMEM;
 
 	dent->handle = dsmas->dsmad_handle;
+	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
+	dent->read_only = dsmas->flags & ACPI_CDAT_DSMAS_READ_ONLY;
 	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
 	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
 			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
@@ -255,6 +259,38 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
 }
 
+
+static void update_dcd_perf(struct cxl_dev_state *cxlds,
+			    struct dsmas_entry *dent)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = cxlds->dev;
+
+	for (int i = 0; i < mds->nr_dc_region; i++) {
+		/* CXL defines a u32 handle while cdat defines u8, ignore upper bits */
+		u8 dc_handle = mds->dc_region[i].dsmad_handle & 0xff;
+
+		if (resource_size(&cxlds->dc_res[i])) {
+			struct range dc_range = {
+				.start = cxlds->dc_res[i].start,
+				.end = cxlds->dc_res[i].end,
+			};
+
+			if (range_contains(&dent->dpa_range, &dc_range)) {
+				if (dent->handle != dc_handle)
+					dev_warn(dev, "DC Region/DSMAS mis-matched handle/range; region %pra (%u); dsmas %pra (%u)\n"
+						      "   setting DC region attributes regardless\n",
+						&dent->dpa_range, dent->handle,
+						&dc_range, dc_handle);
+
+				mds->dc_region[i].shareable = dent->shareable;
+				mds->dc_region[i].read_only = dent->read_only;
+				update_perf_entry(dev, dent, &mds->dc_perf[i]);
+			}
+		}
+	}
+}
+
 static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 				     struct xarray *dsmas_xa)
 {
@@ -278,6 +314,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 		else if (resource_size(&cxlds->pmem_res) &&
 			 range_contains(&pmem_range, &dent->dpa_range))
 			update_perf_entry(dev, dent, &mds->pmem_perf);
+		else if (cxl_dcd_supported(mds))
+			update_dcd_perf(cxlds, dent);
 		else
 			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
 				&dent->dpa_range);
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4b51ddd1ff94..3ba465823564 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1649,6 +1649,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
+	for (int i = 0; i < CXL_MAX_DC_REGION; i++)
+		mds->dc_perf[i].qos_class = CXL_QOS_CLASS_INVALID;
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0690b917b1e0..c3b889a586d8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -466,6 +466,8 @@ struct cxl_dc_region_info {
 	u64 blk_size;
 	u32 dsmad_handle;
 	u8 flags;
+	bool shareable;
+	bool read_only;
 	u8 name[CXL_DC_REGION_STRLEN];
 };
 
@@ -533,6 +535,7 @@ struct cxl_memdev_state {
 
 	u8 nr_dc_region;
 	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
+	struct cxl_dpa_perf dc_perf[CXL_MAX_DC_REGION];
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 199afc2cd122..387fc821703a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -403,6 +403,8 @@ struct acpi_cdat_dsmas {
 /* Flags for subtable above */
 
 #define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
+#define ACPI_CDAT_DSMAS_SHAREABLE           (1 << 3)
+#define ACPI_CDAT_DSMAS_READ_ONLY           (1 << 6)
 
 /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
 

-- 
2.46.0


