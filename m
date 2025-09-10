Return-Path: <linux-btrfs+bounces-16769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44CB50CFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229C3468653
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8192BE65A;
	Wed, 10 Sep 2025 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aidbIHnu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24A277CB1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480678; cv=none; b=krEzPZBxtf/aDoUGeovFA+i875Wlyg92i5TOqSWmctlEDgYq1YrmXmlNIO1Lfmlac6juzsHega5U4zl8Gnq2wrjncHzl29ZLhbjtQgPwdCIBjH49zOQvafXtZqQmrrjXYGUxVAeR3xVlNOOyXTW/Kjf00U+KTfGXq3xhhpEUpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480678; c=relaxed/simple;
	bh=UONHk4/Hvv8VdP/k6dD0a5awAmMJ4fchN8ZWKNekMso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY4LEhMmkeXlt7m/PcMlKvVlVkC8AudweWkrNs61RHFiDGnPLwGIieXv3zbZl3u20YsJ7JjHVdvTz3dk/ac/l+qdjV1kBmhSkarn+c0X3OeiMc/XkBUjsBpm/BYLkUNc1tJ3qCqmP5Y+mlEns4kfxhh6t86/0hm66n/IOy6qLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aidbIHnu; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757480677; x=1789016677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UONHk4/Hvv8VdP/k6dD0a5awAmMJ4fchN8ZWKNekMso=;
  b=aidbIHnuBvozka35X1aMtN/GesMNqtR9+zczl1iUfse6H8dnvU+k9LdC
   pUK9NdbBohD02VWw7wwIYWk8hBF5pNTigrkJlP8V7JScCtzYipM9EUnIu
   Yjj2JFMtTWJ4E66GhlX8TsuX8RkreHEMwMI0XCeXEvyLdVuyktbH3wVFu
   wJU8lnuu5C2rIkPFwInhWrhmhvgzGumbYlt0y1Nwg3l96v40J/wG/kcEk
   3HuOgn6f92yG4EgTNDj0AQMukMyiKa6Jone9/heIKfxe2kE9MKY2bjKwi
   7e0cLCJLN5Xta94lnBY7ic6yi1jqJTQTU8JJrw0RaBe9jqwKpWvAOvsn1
   A==;
X-CSE-ConnectionGUID: yODtHqUlRTGt1DtzOxs64A==
X-CSE-MsgGUID: fKDdeY+kTMSLXLHOSc+h1A==
X-IronPort-AV: E=Sophos;i="6.18,253,1751212800"; 
   d="scan'208";a="114170352"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2025 13:04:35 +0800
IronPort-SDR: 68c106e3_2avHe7I/6fGC+ua9IlM0fkGNZZ1oc7YeRWp17AU2L3NU1KE
 1kvWnYuqOCzlPTMi1YGUhDxeg3zhRJfScqwNyJQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 22:04:36 -0700
WDCIronportException: Internal
Received: from wdap-vuijzzqtlv.ad.shared (HELO naota-xeon) ([10.224.173.18])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 22:04:34 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/4] btrfs-progs: tests: add wait_for_nullbdevs
Date: Wed, 10 Sep 2025 14:04:11 +0900
Message-ID: <20250910050412.2138579-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910050412.2138579-1-naohiro.aota@wdc.com>
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a nullb version of wait_for_loopdevs. It waits for all the nullb
devices are ready to use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/common | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/common b/tests/common
index 2c90acb90cfc..42733c215f96 100644
--- a/tests/common
+++ b/tests/common
@@ -984,6 +984,14 @@ cleanup_nullbdevs()
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
 }
 
 init_env()
-- 
2.51.0


