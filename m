Return-Path: <linux-btrfs+bounces-19692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B63CB8155
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 08:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F1D63085B32
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68230F52C;
	Fri, 12 Dec 2025 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g54UckgB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457A244671
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523426; cv=none; b=nbWnu3eO4Z8AaNHMK4DXpJoiza9rdE7u5sBNheDbWCNedPuITXjsY2Q32IUu6eUzbSOfUEVcIIC1sYwP4PIacdhYYKatjI/74zD1vNWa89qUHpJ7IGpGkTW3B58wGMNDhZ8uDvLVnN/zMVlESaKctLN1Jt3rkTvOpJztVtgKf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523426; c=relaxed/simple;
	bh=uQmfs43OjHpddkYpIH4Z3eIzTRm56vcxBIbKNnpUKqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVejchCPhVZwV+YtVDIcdbv02X8QbkOPGY//ZsWJhRqBbQp4lU8dw9OkeCaDtuiyjRsQiw1eMZD6JENUP/bcBKbQN7S8Sf6th0ZvwOYQTimxyatnQe9Hwp+yFW0dYwxJva3IEIed4zlD5UrmdyaW5fVlFovRA3fCmCHhjzLB0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g54UckgB; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765523424; x=1797059424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQmfs43OjHpddkYpIH4Z3eIzTRm56vcxBIbKNnpUKqc=;
  b=g54UckgB0fLvfUKpipDi4QHpEVW4c5zCF/KXI9UgM2/nla0oOJuyGA46
   uTHRJMkeWZgoZte1ZRAuFUiHBaasGQGr0VlwB4eg29fbxYO80NWJTZkpa
   YjSZ4z/rV6TX8vVGBG5ch+e5+Q00UTb/qHvDuQPD2gVjsKWD4SrTaD+VR
   XBCaTQP0NhyD7kg1FsTrwSNUg7knhy6mwOtqqpzVZ7XTMeQ+19/xjM9t4
   i+i4zLabJ0Z3AwhXBylx1LATrFC9LyZlTO3EDzzZudGe6+20o5CRbQ0x/
   OSk4OCNBCOpWzz5ha0VCI+kfs6ol6tk07262lDsmfWzYy+jU0Bgfignsx
   A==;
X-CSE-ConnectionGUID: hczxmdfgSm60EEUdI3WLxA==
X-CSE-MsgGUID: tIsJKHklQtW+50H7ysdItw==
X-IronPort-AV: E=Sophos;i="6.21,143,1763395200"; 
   d="scan'208";a="136927272"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2025 15:10:21 +0800
IronPort-SDR: 693bbfdd_4OaL3RWK35OSkuOwdU8rIUf3/7s7y0KNiJ8rNVVgKIM/t4e
 BL2ZMkInn0FhbM3hhdyVecPi4aGIpdKbj8yqhqQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 23:10:21 -0800
WDCIronportException: Internal
Received: from 5cg1430htq.ad.shared (HELO neo.wdc.com) ([10.224.28.119])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2025 23:10:17 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 3/4] btrfs: zoned: print block-group type for zoned statistics
Date: Fri, 12 Dec 2025 08:09:59 +0100
Message-ID: <20251212071000.135950-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing the zoned statistics, also include the block-group type in
the block-group listing output.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2235187a2807..63588f445268 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -3018,9 +3018,9 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_file *s)
 	seq_puts(s, "\tactive zones:\n");
 	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
 		seq_printf(s,
-			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+			   "\t  start: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
 			   bg->start, bg->alloc_offset, bg->used, bg->reserved,
-			   bg->zone_unusable);
+			   bg->zone_unusable, btrfs_space_info_type_str(bg->space_info));
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 }
-- 
2.52.0


