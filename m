Return-Path: <linux-btrfs+bounces-16574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D3CB3F3CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 06:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF91A85105
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 04:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1252F99;
	Tue,  2 Sep 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FxIbUKsr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F218DB02
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787414; cv=none; b=Sv4oQMXj3iJU1eNA87/iriNvwHidW1frDy4L4I79Vwd3bDrVri3u09q38Nh0aRoMjsA1z1ERq4MwS0xE6gYezp9AlIGekdrRM3O1a+VTOO5REKdjmWnkttVLH7HyipBMPHgGiyXEqQOHkf3tJgTs5B9plsVYnRk0QMxlA+s2Irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787414; c=relaxed/simple;
	bh=SoXDQGB3+CRr2/L9/pbhYJace9RrtqJ5AYdot56lAkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzHGsnPMWQTD1S5P8Nnz1qs82mi14lla3kCWErEg7+kDfdFqjp4CO6/TTVqsJAYDoZ5lAN+xzOeo0jbjptChJw2crnzsy29WNAv5eq7Q+mz++KrbnPflTfY9m7nGoAP66NAigGQbFf8YiboWXf8SbtUkiEXcL9/4nhjer2hcc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FxIbUKsr; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756787412; x=1788323412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SoXDQGB3+CRr2/L9/pbhYJace9RrtqJ5AYdot56lAkg=;
  b=FxIbUKsrrxqYXrgZl2uVE098I5mVLkttjUyUCBymCxHzp26IhCwPv+wk
   yhYgpacI1q3ABlV0Ne5kuiuZoiXu/oHjtAlPyzfjepttKPqtfj8XMQcUw
   XFR9jgOJjDmonAcdAo9m+OynR9gWP/mKZgoEdjoz+kKMyLtEcC25ZgCkt
   vuKik2GI2wqI3ERliiVKG+atgLAzIuNNd0ZixOXJ0/Wm+VkuNuwrmK+Ce
   +0PzljtZ/jjykdWR2vaypfCHyhrD7QqG6tZ+wdIPyYwthqVFZNx+lyDOF
   7+TjEsD/3GXA9waRSE3wqGlKr29Y/rdX1ntOkOYsM/opr0qKoBoFO6Cme
   Q==;
X-CSE-ConnectionGUID: NPZqSigZSPa+N3ax8EsNew==
X-CSE-MsgGUID: xKaj7tKrRACgscBA+tuJEA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106426374"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 12:30:12 +0800
IronPort-SDR: 68b672d4_HVVhbDUSS6PwbKTRoyLVL4LQPPiIz1/7etsLvZIly/sARbC
 WBn6+1KTvkVS9y45AR4e6FzzofC8ZIfxNyFxTPw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 21:30:12 -0700
WDCIronportException: Internal
Received: from wdap-uxdzwi0ixx.ad.shared (HELO naota-xeon) ([10.224.163.20])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2025 21:30:12 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] btrfs-progs: tests: add {,cond_}wait_for_nullbdevs
Date: Tue,  2 Sep 2025 13:29:19 +0900
Message-ID: <20250902042920.4039355-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902042920.4039355-1-naohiro.aota@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a nullb version of {,cond_}wait_for_loopdevs. It waits for all the
nullb devices are ready to use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/common | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/common b/tests/common
index 2c90acb90cfc..1df37c390bf6 100644
--- a/tests/common
+++ b/tests/common
@@ -984,6 +984,20 @@ cleanup_nullbdevs()
 		name=$(basename "$dev")
 		run_check $SUDO_HELPER "$nullb" rm "$name"
 	done
+	unset nullb_devs
+}
+
+wait_for_nullbdevs()
+{
+	for dev in ${nullb_devs[@]}; do
+		run_mayfail $SUDO_HELPER "$TOP/btrfs" device ready "$dev"
+	done
+}
+
+cond_wait_for_nullbdevs() {
+	if [ -n "${nullb_devs[1]}" ]; then
+		wait_for_nullbdevs
+	fi
 }
 
 init_env()
-- 
2.51.0


