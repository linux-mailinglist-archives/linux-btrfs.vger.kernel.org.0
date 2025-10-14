Return-Path: <linux-btrfs+bounces-17768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D89BD8416
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 10:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786734F62BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5A2DAFD2;
	Tue, 14 Oct 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rjBn21e7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EA212568;
	Tue, 14 Oct 2025 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431600; cv=none; b=PoK6a4uZL6KKXAPq/XONS+m8/MqUWZGXE9vsmvQF7rlhwAvBbZna/hyAwmGofQ7NxTnJ+tu2vSiw0riby7M7zJ8OT26yMX+0iaK86AJuTxyWqzBZzibXcdhrcgL3nakQ8nbN8M4mlf/rmUdatDIj5iPn7yU/wJY5ePNa/68ZIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431600; c=relaxed/simple;
	bh=1d/P1xs0Ke3DuTrcCW4py4vEpJIi+s06dOqtNtGPwCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFwSVwiAW3L7HfmBHFWhvR5XJhorqyB1RonwTEhrCfBfdI5AJT0X9xoST7eXRGNtZg4tRWnnkd77i7w+De17kS57cvog1nlsI4HxczqSXos40plizwiFvqQZ8+0mbmTTmDqb6uEfK9I7QeQ/X4nb2yuH203Prdk/ZSV2pOQKkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rjBn21e7; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760431599; x=1791967599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1d/P1xs0Ke3DuTrcCW4py4vEpJIi+s06dOqtNtGPwCI=;
  b=rjBn21e7y24GRFJMBhTJb0gf9ek9wrkbVlXECNQhcHK4u4oFI50PTYMb
   zglcKgELGXO0KQhFu6eivlUmqg9J1ds4YzEzwWUm0Dt4dPD2wsguZJzDe
   nWIIrn9pMHlCx7/pVkEMGhc9uBVULsFRIYghbnf1Mo0SzC+OsMDXGG9jN
   vcyii8afotrJBDdYro0naL39K99k1ldx796VP+ugR1jaiHnPFeen33bI8
   EYvHDGLgKdLpxg52BcmsCuW/0gYxYVhfF+yxveppRN5dK2JmUhsGwg55G
   /RDe98HUA6MhwvuOIMgH3kUN5f0lBo59DqoDaI+76h1jJyLFBZXhTfGpX
   w==;
X-CSE-ConnectionGUID: 4lCUFn/cT6KRzacD+OOQmQ==
X-CSE-MsgGUID: TvGPzyEoRl6rgYMpMohKvw==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="130180112"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 16:46:35 +0800
IronPort-SDR: 68ee0deb_bgd7q8pldR2f5O18eROmVcNLt/ecT5lPuG35V3xjeXA+eX7
 KQSrhU2LBWx4cdG5O9RlOR8/M7mAot747w7o0hg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2025 01:46:35 -0700
WDCIronportException: Internal
Received: from wdap-pnj1f24hc3.ad.shared (HELO neo.fritz.box) ([10.224.28.28])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Oct 2025 01:46:32 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 1/3] common/zoned: add _require_zloop
Date: Tue, 14 Oct 2025 10:46:23 +0200
Message-ID: <20251014084625.422974-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _require_zloop() function used by tests that require support for the
zoned loopback block device.

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/zoned b/common/zoned
index eed0082a..41697b08 100644
--- a/common/zoned
+++ b/common/zoned
@@ -37,3 +37,11 @@ _zone_capacity() {
 	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
     echo $((size << 9))
 }
+
+_require_zloop()
+{
+    modprobe zloop >/dev/null 2>&1
+    if [ ! -c "/dev/zloop-control" ]; then
+	    _notrun "This test requires zoned loopback device support"
+    fi
+}
-- 
2.51.0


