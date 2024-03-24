Return-Path: <linux-btrfs+bounces-3536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D383888B87
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 04:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE11C2853D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE852ABE84;
	Sun, 24 Mar 2024 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqrJ7Cwx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606992002F5;
	Sun, 24 Mar 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322301; cv=none; b=DtockoKM48B68ukALdZsiml2HAbuCmUuf+sugGiHJnjTUFucNQAV5MQbU7W0B8+Ep7pvcbRcN1FcGt/6VCpbSeokJc8A1i3aGwUYyrfU0Fi8xjaURr+lKAJAZ/C/VQmTnkFiwVnE+8i22N/wqJNfeWSiWQbaZ44EoYGYaOtN3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322301; c=relaxed/simple;
	bh=vBU/pflBdLmZJMuDuDL9v0okN0Tx6M0I59I2YcJWzag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9JjJ7wHwORoW6BPcvE55OXSoCve4E9u3tGHFavFXuuXPceFdbKlv3DCADaroXBx0BWNoQh81XEdipt2fwQHkpWMt3CqrESBW13MIGew/Ubhz5mh3A3zdVR2KvxMZRJNbGFam3GSmjm9wnDQRJ3r0yVyzQTVrsS94gLt4oQyj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqrJ7Cwx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322299; x=1742858299;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vBU/pflBdLmZJMuDuDL9v0okN0Tx6M0I59I2YcJWzag=;
  b=fqrJ7Cwx3zxW2fC5t7fuER1bq05wCaGjq3Z1yBS1XdOh9xyGHAxLKxGK
   uUImiYIUNBCVq0kckf8OCz08Jt8M2vEMbNV1KdqbOJyYUADda7Nt7TYvw
   i3xNwU3aoW1A8jXMStNmf4ycg6U/5ROJI0/1xzoGpyjMyRoB9PTGTF9lg
   hhAjY4RH2IdAz4J0jau8Vjy8V3ix8cd/kXVulNRPmVtp5OkglCinFDZwc
   R6hBQEfKUZa2ubcqm3CZJchuCMO2SwLSfDtgtjZm4KyAm3MzwxfXnN7dZ
   F/iCm/n7a5jEA+tw9f7nqMT1+z5R0VKFaed4Manm5K5ZsLAx1FOGKFTvT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9260912"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9260912"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15842205"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:11 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Sun, 24 Mar 2024 16:18:08 -0700
Subject: [PATCH 05/26] cxl/core: Simplify cxl_dpa_set_mode()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-dcd-type2-upstream-v1-5-b7b00d623625@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=2474;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=vBU/pflBdLmZJMuDuDL9v0okN0Tx6M0I59I2YcJWzag=;
 b=fPq8+Av/qDsOx0C9MXtjtTcZ5bFsXczKaf3cCuDETt+WZxoouImZ+EB0z7WJd3A3cC3xCVvOV
 DjtIP9Nhs7VCRZnj3/AmW3gNiiSoEvv09UPaOP3QML8YIMvDQ2dWVRF
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

cxl_dpa_set_mode() checks the mode for validity two times, once outside
of the DPA RW semaphore and again within.  The function is not in a
critical path.  Prior to Dynamic Capacity the extra check was not much
of an issue.  The addition of DC modes increases the complexity of
the check.

Simplify the mode check before adding the more complex DC modes.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v1:
[iweiny: new patch]
[Jonathan: based on getting rid of the loop in cxl_dpa_set_mode]
[Jonathan: standardize on resource_size() == 0]
---
 drivers/cxl/core/hdm.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..66b8419fd0c3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -411,44 +411,35 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct device *dev = &cxled->cxld.dev;
-	int rc;
 
+	guard(rwsem_write)(&cxl_dpa_rwsem);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+		return -EBUSY;
+
+	/*
+	 * Check that the mode is supported by the current partition
+	 * configuration
+	 */
 	switch (mode) {
 	case CXL_DECODER_RAM:
+		if (!resource_size(&cxlds->ram_res)) {
+			dev_dbg(dev, "no available ram capacity\n");
+			return -ENXIO;
+		}
+		break;
 	case CXL_DECODER_PMEM:
+		if (!resource_size(&cxlds->pmem_res)) {
+			dev_dbg(dev, "no available pmem capacity\n");
+			return -ENXIO;
+		}
 		break;
 	default:
 		dev_dbg(dev, "unsupported mode: %d\n", mode);
 		return -EINVAL;
 	}
 
-	down_write(&cxl_dpa_rwsem);
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
-		rc = -EBUSY;
-		goto out;
-	}
-
-	/*
-	 * Only allow modes that are supported by the current partition
-	 * configuration
-	 */
-	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
-		dev_dbg(dev, "no available pmem capacity\n");
-		rc = -ENXIO;
-		goto out;
-	}
-	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
-		dev_dbg(dev, "no available ram capacity\n");
-		rc = -ENXIO;
-		goto out;
-	}
-
 	cxled->mode = mode;
-	rc = 0;
-out:
-	up_write(&cxl_dpa_rwsem);
-
-	return rc;
+	return 0;
 }
 
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)

-- 
2.44.0


