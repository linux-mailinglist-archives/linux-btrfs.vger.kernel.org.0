Return-Path: <linux-btrfs+bounces-8801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A4998B70
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16641F27124
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6081CC888;
	Thu, 10 Oct 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijQAlkb7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EF15CD49;
	Thu, 10 Oct 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573907; cv=none; b=fAoAymH8daicJd7Cul0bq8ReNsvHMe6mvFgXrhiVJC0aDemOvPAA+X3NIXIQwYqmgjFUFEpW9A0lLKdRvCGGnEm6WFVmxp9ws0vigu3q65kUdA0Cj45jljqyfyPpyj+SdiTvJEU1fLwOeMH/rhXHrbHzm5m6vHvrDNKYW3sVos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573907; c=relaxed/simple;
	bh=wFjscxoz6XvnCiqFK6/8lNfUYxSfnBY637sI6B7vS4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oYboE6ICItxkdEPUlFw3mz8/E0pBJokzfuGEbUWyiIdkd0ihqR+Syg0kj7jLoHz/DAAFgDEFfeyxN1ScJ2fczc7eMh8yYwVIAOttK4dXcjdxF6LU+WFMu87SKwDoRJZLVWvZng85GNdV60Toq2FgloxHGiVhAd2vanRDufgMEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijQAlkb7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728573906; x=1760109906;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=wFjscxoz6XvnCiqFK6/8lNfUYxSfnBY637sI6B7vS4c=;
  b=ijQAlkb7ClS9Z5cdZHxFk38r9Qmd3ppfZoJgBWxKUXLGi+Be7FXzBPYl
   szLgVDd6HzgUulCYkv1Aroa/mpYip12nI4yPLlHSlwXKjgzEcANUM3iOB
   fZ7mFSQvqP8oNIjwX9wPNkJL212LKH6wBqRjQdsUU+yme+Lvj4gZUd+kE
   l0wxmzHejKghJ8Juj3JM3g5gprSbT4nej8iqV4mtZazTgKT8S2qcikAlr
   RcRNJQ//2CVsF96vvaou2DtQHqPn90NFMM8gd8dm3XSDEPFcyuCCnlu2z
   5I8JE/Wavvyr+o+IuEC7RrgQG4ebpXyhECtAhJ6fF1iDO6U6Plac7sFj7
   w==;
X-CSE-ConnectionGUID: OaB6hE6XTeyHIYZVKVV/TA==
X-CSE-MsgGUID: F+kvOhD1TXmlh2ssNOEnHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27387427"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27387427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:24:56 -0700
X-CSE-ConnectionGUID: 6uFVnloDRVycPF6k+JgZ7A==
X-CSE-MsgGUID: 1qWbc55LTfWwjqvNQ4dH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81148916"
Received: from vverma7-desk1.amr.corp.intel.com (HELO localhost) ([10.125.111.61])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:24:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 10 Oct 2024 10:24:42 -0500
Subject: [PATCH] kernel/range: Const-ify range_contains parameters
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-const-range-v1-1-afb6e4bfd8ce@intel.com>
X-B4-Tracking: v=1; b=H4sIALnxB2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNL3eT8vOIS3SKwlLGpibmphYFxooWRiRJQR0FRalpmBdi06NjaWgD
 Y7v7lXQAAAA==
To: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728573887; l=1083;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=wFjscxoz6XvnCiqFK6/8lNfUYxSfnBY637sI6B7vS4c=;
 b=tABY1h4widKOwrxP2fxhnTlcjE0XKWwrYz2BYyT6o74nNEZwbTG6aIwwYkayhTKdH/eDjumWZ
 1CdxjjawaySAeMoOntpAT/2HvvIA7/1i0daM0Zn4iOaTbibeuvxU43M
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

range_contains() does not modify the range values.  David suggested it
is safer to keep those parameters as const.[1]

Make range parameters const

Link: https://lore.kernel.org/all/20241008161032.GB1609@twin.jikos.cz/ [1]
Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/range.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/range.h b/include/linux/range.h
index 6ad0b73cb7ad..7dc5e835e079 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,7 +13,8 @@ static inline u64 range_len(const struct range *range)
 	return range->end - range->start + 1;
 }
 
-static inline bool range_contains(struct range *r1, struct range *r2)
+static inline bool range_contains(const struct range *r1,
+				  const struct range *r2)
 {
 	return r1->start <= r2->start && r1->end >= r2->end;
 }

---
base-commit: 27cc6fdf720183dce1dbd293483ec5a9cb6b595e
change-id: 20241009-const-range-35475803a824

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


