Return-Path: <linux-btrfs+bounces-18357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA429C0C21A
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 08:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A56F18A1DCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150D92DE70D;
	Mon, 27 Oct 2025 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DI17uxw6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B6A55
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550153; cv=none; b=BNnRRnf/0Q8HYm5IpIrGovQArrObfhX7uiRerOr1co/f8bDkOsrqnPM/NeEtH/MvcEwnNb1Ji+t71ZnEecal5StfoXppfKVJq0INaRod8G7XlEI5V//tLLrr4vZLBZlg7UAUzy1kqiMgMducU6PAsVEhxuVEWeM5NvEWKlqctZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550153; c=relaxed/simple;
	bh=uhNjqzucqUmRKRyyQkXbIxEmETfrkomyJfMy2ICfGYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=louku7fOWW6Pg3+qryT/tYUsxNdEayfGqZTiYcGgt0G/Et6iSwR8Xr7AyWC0rsfIrtk21mOTjPIWZ9ZQn8bJVNOS3NWzQLBoS6XFlBe2R41ZToxipp73ZnHJzA6fPgb8fHiCPcAba4NYNSVUsz3Gg54cEA04p4QOKx2oxgRHDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DI17uxw6; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761550151; x=1793086151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uhNjqzucqUmRKRyyQkXbIxEmETfrkomyJfMy2ICfGYY=;
  b=DI17uxw6SjPcOOeWxgdDL10fBARFeSxGUQpjjheh1TIKtwAGen0OwHeY
   NqBb4Wtq7wip37R84cluiGa5KCzPbRN4pPMsVJNZ1y+io7/d2FusGUiZf
   yJxGVb828yVZ0GpEWG4tbrYTinXca5Hj84QmVB4U1/wIefDUfPjecgOMD
   29Y6u+uO3M+NMte9QKxMF1ZZTDiafpa46kZ4VlqfjUpOnc6Ncq4xkpdrC
   Bq2xzuQlqHRrkoMdjYFwSUvl3MYfsIRvOPLX3LFj+VKVMvlpxe0SzYWx1
   71RlJaGfaaOafKlTOdQxeVd97+1hWwCDMpKltl3AsPbC4XDFimT9qVZk4
   w==;
X-CSE-ConnectionGUID: FVlpUQufRFWGAwbpL5q9Gg==
X-CSE-MsgGUID: +mt1frcvQIyIiTJUVlsHEw==
X-IronPort-AV: E=Sophos;i="6.19,258,1754928000"; 
   d="scan'208";a="130947252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2025 15:29:04 +0800
IronPort-SDR: 68ff1f3f_01Hl65/UJ8nc3chYtSPlROdvCHWMQJLqNz+ykDWl1KHZaO9
 Scds/ZdV8srMiAoPiOBF6bOaA1dVTFyTFaEgBwQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2025 00:29:03 -0700
WDCIronportException: Internal
Received: from wdap-xbhuzc2r95.ad.shared (HELO naota-xeon) ([10.224.105.146])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Oct 2025 00:29:02 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] fix zone capacity/alloc_offset calculation
Date: Mon, 27 Oct 2025 16:27:56 +0900
Message-ID: <20251027072758.1066720-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a conventional zone is in a block group, we cannot know the
alloc_offset from the write pointers. In that case, we use the last
extent in the zone to know the last allocation offset. We calcualte the
alloc_offset from it, but the current calculation is wrong in two ways.

First, the zone capacity is mistakenly set to the zone_size if there is
at least one conventional zone in the block group. That should be
calculated properly depending on the raid type.

Second, the stripe width is wrongly set to map->stripe_size, which is
zone_size on the zoned setup.

This series fixes these two bugs.

Naohiro Aota (2):
  btrfs: zoned: fix zone capacity calculation
  btrfs: zoned: fix stripe width calculation

 fs/btrfs/zoned.c | 62 +++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

-- 
2.51.1


