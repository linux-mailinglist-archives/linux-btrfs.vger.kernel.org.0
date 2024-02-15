Return-Path: <linux-btrfs+bounces-2417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D72856203
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C741F2517A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9C12B15C;
	Thu, 15 Feb 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aQqfS5kK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CF57872;
	Thu, 15 Feb 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997633; cv=none; b=MIquC905qV1TsHazALfe0T51jyv5Yh5CcG8f7hfTbi6dj8V8tAd95lap80KRgepYSf8bs3Ea6dK0h7GRFe9YAd+UNoNXJjyZY8yPxeZb83OUBoZPj0YJWPtCQvtamAn9y7RvVPxTBL5FnvTI6kHqNUN7p7gJ6NqYLICvMX7vDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997633; c=relaxed/simple;
	bh=DHagoA8SxeV0zdtLBbp+ii5HURLfR7Zs9XqY6fKNRik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9nYWVQ5uCVQ8omPIG5sOmnypRC3VZURN5WssXYwCXpHcCPkOAcD913DnGF+e7wL0BXZx1aheOZ2PwS1SpP2MM1rzuMLJVpcm0LVqh62BeQjjt+CI1v4C87U416KlMPu36TvXrrSGgcPQsKGFqBWiipOvmVeFospAyIW4RUvwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aQqfS5kK; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707997631; x=1739533631;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DHagoA8SxeV0zdtLBbp+ii5HURLfR7Zs9XqY6fKNRik=;
  b=aQqfS5kKyi6m7FGQyQ5kYPU9gcTTDR8Z8Y03BvX3ZnwnqZcjKSgJFaSg
   05mNt9zKdys7FASsDf41kA5ATvoqNIO6vl10beaKA4/z0JrK2h5wuyfMK
   Ux4e2UA9NofKC8XDUz2y+WIRTiEy5GnO801KTqKArbc6X5epLKk7ogcgb
   vZWngyLDieDEAq4TfmsRbwC42JtW/EcFoxIaFB4+L5tJ/YCu7JVdVUc1v
   j30mFxig9ApGKhsHkZg2sWPjq4TWMek47/GdfWl65gOpSgN1abJ9GAR6a
   KYH/Ie0w+WEQI/+3Ahwi0/7lcTldl9bV2VE9WLqkaBgeTfBiBn9+8zV3s
   g==;
X-CSE-ConnectionGUID: 8usngS0wTOGmcJihwIGnRQ==
X-CSE-MsgGUID: WknTjTS1QiyGhHx5LLMDRg==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="8967196"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 19:47:10 +0800
IronPort-SDR: oed83op9MxeQp0xlzQOAL9xBWV/fNyP2PsbXx9N1gtKqgFkATz2KsQBcTNWCzurTcZH8AAeZ4r
 i26sF1rdwYGw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:56:44 -0800
IronPort-SDR: 51EBZHP2vdY1P9iiEyS46m5CkKlo9g2Se/y7xLOQ9cAqf4nHD9T155R10Pi/eQMUI0NVOEFFB3
 eE0v3/+9fd2w==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Feb 2024 03:47:09 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 15 Feb 2024 03:47:04 -0800
Subject: [PATCH v3 1/3] filter.brtfs: add filter for conversion
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-balance-fix-v3-1-79df5d5a940f@wdc.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
In-Reply-To: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, fdmanana@suse.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707997627; l=728;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=DHagoA8SxeV0zdtLBbp+ii5HURLfR7Zs9XqY6fKNRik=;
 b=piMOqiexYFPPqFDJUCeTymh/WVHsZeKJaaIPWNUjauWnQ5zlzgKop7AdaIEj/g2ve55pD2tY2
 vN2GhHdTBhLAh2dCsQn6tEGyhp7xV1DOsT+abYPVkLvERCpEE0Hl/J5
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a filter for the output of btrfs-balance with a convert argument.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/filter.btrfs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 8ab76fcb193a..ea76e7291108 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -141,5 +141,11 @@ _filter_stripe_tree()
 		-e "s/bytes used [0-9]+/bytes used XXXXXX/"
 }
 
+# filter output of "btrfs balance start -[smd] convert
+_filter_balance_convert()
+{
+	_filter_scratch | \
+	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
+}
 # make sure this script returns success
 /bin/true

-- 
2.43.0


