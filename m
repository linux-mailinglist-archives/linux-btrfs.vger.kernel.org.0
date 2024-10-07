Return-Path: <linux-btrfs+bounces-8605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E806993ACB
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A4A284F98
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C011CDFB8;
	Mon,  7 Oct 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbKtm8sR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4B1C6F41;
	Mon,  7 Oct 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342990; cv=none; b=RPje1SPFwejiO222IUsz/FhP+Hgh9yFLfzVXYftTyeG4HKumW9/xsD8LWGE2T0HjR2hwmAv5gUAIJdeldCUKUMl98U7gBsRa4pV3zxNeAEew+A2V6/EcXyf2xxtRvlxVbFzgHyad69XWunzVXPW+Iq/+yAmIMVemBU/QfWvN6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342990; c=relaxed/simple;
	bh=hWsDUBefFdkosrQznD7jEStCUK3gPSVKUIHxPmvCS38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZS3i8tUp91n/fZ7iG6Wbv4OJUS3+yk71sMIGCh7lE5fNip3nQKUiqDjVcVL8csi+Ptyq0AWRi4LIO4A56mhZxdZR3GU9uoHEfOvduQ5kBIXxNp1SDrrPyMLc7Q1wMEeKZs7lC4hDcRzoy5MJEEUjxvrH6HmxVJkLKNURlUgUSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbKtm8sR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342989; x=1759878989;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hWsDUBefFdkosrQznD7jEStCUK3gPSVKUIHxPmvCS38=;
  b=IbKtm8sRjE9L+ZH9v5QpZhK7FcXkDr0xhERWN5tTuX1v0+kUkjm0oteW
   0AjIU3QA8qW+zMlmo3pYm1Asc9mKCTwlqw6jR5C9qS2zo1vVMC9DnSg75
   4bcYVJhW1G4s97KHx5o0/hGnDLipjhIu5kVXU44MgS4pxmCPKnYnAJa8N
   XiUe5IAIXhgIyBcTQGhxrp9aWf/RqWbIc/zrhUJXnBIcaNM/aE+Aoyrlq
   4XhaW8fb08D3UZXe82aGEyL/NvtoCPh+zZw/tj5ZLkIsuNNIHcahjmd+D
   w79FETtwaKfURbzaVavPqUQDqFQsmDN6lqeeovLooh/GvlPXoG1Hzctsf
   w==;
X-CSE-ConnectionGUID: MUvYqB+SRA6HJbZQIBOJCA==
X-CSE-MsgGUID: uyhHSBa9Thi7NSgrdMhfDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38078907"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38078907"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:29 -0700
X-CSE-ConnectionGUID: QrAHQopkSXK2GAbw2Wd16A==
X-CSE-MsgGUID: vAn1qCbkRxar+1CmAMdhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75634578"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:27 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 07 Oct 2024 18:16:11 -0500
Subject: [PATCH v4 05/28] dax: Document dax dev range tuple
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-dcd-type2-upstream-v4-5-c261ee6eeded@intel.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=1068;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=hWsDUBefFdkosrQznD7jEStCUK3gPSVKUIHxPmvCS38=;
 b=aUWLYYdqOIA3Rmp8nv+lOT+fip1UXd4gYU0eKLJgsYhRakMtaG+Vs36bWmi+I3ux237Urq3c8
 ODinuwDLZ9VBxr22exVqzeweZhN3KQslU35xMrjPEKMT9Y1/TvtnjUc
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The device DAX structure is being enhanced to track additional DCD
information.

The current range tuple was not fully documented.  Document it prior to
adding information for DC.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[iweiny: move to start of series]
---
 drivers/dax/dax-private.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aea..ccde98c3d4e2 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -58,7 +58,10 @@ struct dax_mapping {
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
2.46.0


