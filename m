Return-Path: <linux-btrfs+bounces-16768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E787B50CFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D5846860B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F406D2BE638;
	Wed, 10 Sep 2025 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mP0PcDy+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2978221FC4
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480677; cv=none; b=KN7ld/6ZSIkhYwmxUQfVlPYpfbvCe9//0lzN+iiWIySEHb/Mvf3ACRdIdJinucjp0V9xPPP1Lm2OJg8tAnCp1YIPwsFSI4RyoDtwE3K2Vhar84UY0IjGTGd/+9QL4iJ3Cnj0/t69ZEENJC16EVU8bIjlDyvNuuN27C5CsfquwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480677; c=relaxed/simple;
	bh=QK6O7fc3jTH/bmuVvb8+C2tc8E2JfjlCn7muYd5pysk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2zn7xEJDEjnMZhgyNMakL1OkriG34RdZ8G+xdNasTP011fqW7d5ua2R/z7tb2Vt6fxCVfSs2yqZfdNTIfswPFRwaiG11pgChQ+CnNXbi7ngJEoSiDCtOTNxUyJPmnNxQ9cfV5QSWxSb+Cbz7o5URj1MO8L67fPlH53hKxtJYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mP0PcDy+; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757480675; x=1789016675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QK6O7fc3jTH/bmuVvb8+C2tc8E2JfjlCn7muYd5pysk=;
  b=mP0PcDy+oHOJENH1gdHEnQfM+aXlWtQnu+/7Adw1xjWR8yUnCqJwjccn
   PIfu9FMjEACJ1sxZ7LN/CUF9PTtUppPjH6mfVPFnJYJVcctn+F5eYStCW
   YafzLFSVCjw9+Rw3nbCeeJng/EIW6Uy3O/efxek5irAXZuQBRlR1ZwTVI
   yGdJ1OdhXAlvd2W9nDZLnVejc3I4Z/4KE0gnBc1Aup4qdmZLUkDlcYi0/
   b5BPi57qQ44QJz1y0gUzb+o2i6ZUsvdBD0GuuvnVVLt4ln58+otuUW4z5
   txKBw08wIh4ni5/c+4Kz4TWpazo2Mf9l8vuOd+EjQEPNSxseNhwgyf/Id
   A==;
X-CSE-ConnectionGUID: 8/pRbGK9SmWRenH8lZdHww==
X-CSE-MsgGUID: /jdjXYlgQfqs1u1h1+n9Bw==
X-IronPort-AV: E=Sophos;i="6.18,253,1751212800"; 
   d="scan'208";a="114170335"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2025 13:04:34 +0800
IronPort-SDR: 68c106e2_fSi2thO/bpMs87SFhZe0efof+efjohQg9gQSsT4UIc1GDRW
 NroZszF9oxlZ7poIcgTgmUF66h2VttI7hcPdXCg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 22:04:35 -0700
WDCIronportException: Internal
Received: from wdap-vuijzzqtlv.ad.shared (HELO naota-xeon) ([10.224.173.18])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 22:04:34 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/4] btrfs-progs: tests: check nullb index for the error case
Date: Wed, 10 Sep 2025 14:04:10 +0900
Message-ID: <20250910050412.2138579-3-naohiro.aota@wdc.com>
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

"_find_free_index" can return "" when an error occur. Check the return
value for the case and fail the test.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/nullb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/nullb b/tests/nullb
index f3cdf9c19e16..721da8f13f12 100755
--- a/tests/nullb
+++ b/tests/nullb
@@ -146,6 +146,9 @@ fi
 if [ "$CMD" = 'create' ]; then
 	_check_setup
 	index=$(_find_free_index)
+	if [ -z "$index" ]; then
+		exit 1
+	fi
 	name="nullb$index"
 	# size in MB
 	size=$(_parse_device_size "$@")
-- 
2.51.0


