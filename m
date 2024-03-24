Return-Path: <linux-btrfs+bounces-3539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF142888B95
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBD91C296B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0EC2ADE16;
	Sun, 24 Mar 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvOfUriz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6723658E;
	Sun, 24 Mar 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322304; cv=none; b=Fi5g82VbYiCGmJlKrNAUeV0mxZC+YtHZwbd4LObdKbY6d9fekuB5FeAeZDgi4rjwFfVc3XVfm6UqUvER0uEnJiKKgRujIDgUJ+yZp4iA6rAJvHprKE951xIQ1P+CjFzOLtuhUb8/jEzJZLHc3irtLCZpGWeHXEQdCPW3sCBhbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322304; c=relaxed/simple;
	bh=jpICBPUr8QKCqbR4SJy1LOgy8CWC6HE3wLUZi8Ng7QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RT3e4J5vMP9Nd1G7wcuit7VQvspDLoV7d9fEywWiOWAQoBPBvjaB3zsY2mR+14aE5Gh31Z/SjkUk9it/EaaDAvsvSwVT1RPc6G/gg3DNlxFps8f6m/hjdZjpcqulLh2pM9XqqN6PQnfuxCYa6704sSViktRhO36w4U4I6MR+swo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvOfUriz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322302; x=1742858302;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jpICBPUr8QKCqbR4SJy1LOgy8CWC6HE3wLUZi8Ng7QI=;
  b=jvOfUrizr10OCGWvoalLVSvC6SKLWKRxjMAezrlqLdEFy1YwOy9hkV3b
   Mvu81rbDTlgMH7MDvGjvsXVqkdXSdwYb7yDkbKBdhr9/xtE8jj8fhLl2Y
   fAKFt4QeerEdaXBr7N3KIqLrWz8bBW0lFJ39rzubHnhKP0dLKoNNvCy9g
   4Gx34n0Y9VXiU/1YSLsM8z2rBPHTji6BXyOKrsM4ggQY099qESfSZpFBu
   7mvK9cXk0gzfscnZ7Oi3/snM4tJSZbUAjJpJm/Que3U/99j0hd7IW3WI3
   fRBUblJmb6VHHqlyu18WzN8tTX/stJ9y7tqA7XbJQAqn8wgE1g/BKhEv8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6431724"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6431724"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15464695"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:18 -0700
From: ira.weiny@intel.com
Date: Sun, 24 Mar 2024 16:18:16 -0700
Subject: [PATCH 13/26] cxl/mem: Configure dynamic capacity interrupts
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-13-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=7384;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=afeKpiwwXvLku3qEQtUdlGCLPDe8+v1v2EDR9Z21gU0=;
 b=1CWhZo72Bc/KNO7mSZme0mvhCKIebSsHGuyOOKuKh7hjC9cPxXTiEC9s9Gbe1Bt1ITIafKZjy
 cy9QJof5DZpD1h0DjwHRMOpY2eTVe4aywAK/34OUtZQOhpL+FZG+gAd
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

Dynamic Capacity Devices (DCD) support extent change notifications
through the event log mechanism.  The interrupt mailbox commands were
extended in CXL 3.1 to support these notifications.

Firmware can't configure DCD events to be FW controlled but can retain
control of memory events.  Split irq configuration of memory events and
DCD events to allow for FW control of memory events while DCD is host
controlled.

Configure DCD event log interrupts on devices supporting dynamic
capacity.  Disable DCD if interrupts are not supported.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1
[iweiny: rebase to upstream irq code]
[iweiny: disable DCD if irqs not supported]
---
 drivers/cxl/core/mbox.c |  9 ++++++-
 drivers/cxl/cxl.h       |  4 ++-
 drivers/cxl/cxlmem.h    |  4 +++
 drivers/cxl/pci.c       | 71 ++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 14e8a7528a8b..58b31fa47b93 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1323,10 +1323,17 @@ static int cxl_get_dc_config(struct cxl_memdev_state *mds, u8 start_region,
 	return rc;
 }
 
-static bool cxl_dcd_supported(struct cxl_memdev_state *mds)
+bool cxl_dcd_supported(struct cxl_memdev_state *mds)
 {
 	return test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dcd_supported, CXL);
+
+void cxl_disable_dcd(struct cxl_memdev_state *mds)
+{
+	clear_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_disable_dcd, CXL);
 
 /**
  * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 15d418b3bc9b..d585f5fdd3ae 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -164,11 +164,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
+#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
 
 #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
 				 CXLDEV_EVENT_STATUS_WARN |	\
 				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+				 CXLDEV_EVENT_STATUS_FATAL|	\
+				 CXLDEV_EVENT_STATUS_DCD)
 
 /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
 #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4624cf612c1e..01bee6eedff3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -225,7 +225,9 @@ struct cxl_event_interrupt_policy {
 	u8 warn_settings;
 	u8 failure_settings;
 	u8 fatal_settings;
+	u8 dcd_settings;
 } __packed;
+#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
 
 /**
  * struct cxl_event_state - Event log driver state
@@ -890,6 +892,8 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
+bool cxl_dcd_supported(struct cxl_memdev_state *mds);
+void cxl_disable_dcd(struct cxl_memdev_state *mds);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 12cd5d399230..ef482eae09e9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -669,22 +669,33 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 }
 
 static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
-				    struct cxl_event_interrupt_policy *policy)
+				    struct cxl_event_interrupt_policy *policy,
+				    bool native_cxl)
 {
 	struct cxl_mbox_cmd mbox_cmd;
+	size_t size_in;
 	int rc;
 
-	*policy = (struct cxl_event_interrupt_policy) {
-		.info_settings = CXL_INT_MSI_MSIX,
-		.warn_settings = CXL_INT_MSI_MSIX,
-		.failure_settings = CXL_INT_MSI_MSIX,
-		.fatal_settings = CXL_INT_MSI_MSIX,
-	};
+	if (native_cxl) {
+		*policy = (struct cxl_event_interrupt_policy) {
+			.info_settings = CXL_INT_MSI_MSIX,
+			.warn_settings = CXL_INT_MSI_MSIX,
+			.failure_settings = CXL_INT_MSI_MSIX,
+			.fatal_settings = CXL_INT_MSI_MSIX,
+			.dcd_settings = 0,
+		};
+	}
+	size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;
+
+	if (cxl_dcd_supported(mds)) {
+		policy->dcd_settings = CXL_INT_MSI_MSIX;
+		size_in += sizeof(policy->dcd_settings);
+	}
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
 		.payload_in = policy,
-		.size_in = sizeof(*policy),
+		.size_in = size_in,
 	};
 
 	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
@@ -731,6 +742,31 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
 	return 0;
 }
 
+static int cxl_irqsetup(struct cxl_memdev_state *mds,
+			struct cxl_event_interrupt_policy *policy,
+			bool native_cxl)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	int rc;
+
+	if (native_cxl) {
+		rc = cxl_event_irqsetup(mds, policy);
+		if (rc)
+			return rc;
+	}
+
+	if (cxl_dcd_supported(mds)) {
+		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
+		if (rc) {
+			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
+			cxl_disable_dcd(mds);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
 static bool cxl_event_int_is_fw(u8 setting)
 {
 	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
@@ -757,17 +793,25 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_event_interrupt_policy policy = { 0 };
+	bool native_cxl = host_bridge->native_cxl_error;
 	int rc;
 
 	/*
 	 * When BIOS maintains CXL error reporting control, it will process
 	 * event records.  Only one agent can do so.
+	 *
+	 * If BIOS has control of events and DCD is not supported skip event
+	 * configuration.
 	 */
-	if (!host_bridge->native_cxl_error)
+	if (!native_cxl && !cxl_dcd_supported(mds))
 		return 0;
 
 	if (!irq_avail) {
 		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
+		if (cxl_dcd_supported(mds)) {
+			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
+			cxl_disable_dcd(mds);
+		}
 		return 0;
 	}
 
@@ -775,10 +819,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (!cxl_event_validate_mem_policy(mds, &policy))
+	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
+	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
@@ -786,12 +830,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds, &policy);
+	rc = cxl_irqsetup(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
 
+	dev_dbg(mds->cxlds.dev, "Event config : %d %d\n",
+		native_cxl, cxl_dcd_supported(mds));
+
 	return 0;
 }
 

-- 
2.44.0


