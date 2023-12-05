Return-Path: <linux-btrfs+bounces-628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB5805506
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 13:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD761F215D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87165D8F7;
	Tue,  5 Dec 2023 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LMacoShu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC68134;
	Tue,  5 Dec 2023 04:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701780313; x=1733316313;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
  b=LMacoShuTtz5FBK2G0W3OR0KkJKDUv+4fS4jOd19e+7FXe53wto/8e9H
   TMm1qmsVPqvT98QqmxpR4jazJH86sy84pYOC7JllVNisU88/mTILJ4rYZ
   huw4iGekpBTRTuqSZILFs1N+aehfOKmW5rlu+SbqJrKFRwQbGci/ov+Xn
   nsJrg0Rmf05+BjZm6wLgOYa6e2IN0IxrHismgFP6Y0HUaUq9C0cbgj5as
   JHWnkS++lYCPXO3+PajA648JlzdTBOYXaJ1v+fmdfsKwUmZ+IdebWYWZd
   16Ooo9W3/GUIWo92ij8g7hFDbQpHVrE0nW7/TZsrYukP8pBxGNp3Fx8lW
   Q==;
X-CSE-ConnectionGUID: x/gPJsyfQRip3p1F1OnSkA==
X-CSE-MsgGUID: j18GS1zGSOKDvpVhJVKoHw==
X-IronPort-AV: E=Sophos;i="6.04,252,1695657600"; 
   d="scan'208";a="4043894"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 20:45:13 +0800
IronPort-SDR: OywhGj5uSwVoK4QfqJsOkjUfGrdvAPy/vQXnga2lk5ncoPGJfPICYAD1DuoCyyM4A1frBaPbi0
 DcJwMAdoCVqQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 03:56:15 -0800
IronPort-SDR: Wx9i/wOC1NxVPBcCAM52diWwXFXkg7XhD/PQ/J8q63kIZjvjvCgKctgO1genTVe2rlrx3dsiqm
 heW4AWxy0tOQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Dec 2023 04:45:12 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 05 Dec 2023 04:45:07 -0800
Subject: [PATCH v2 1/7] fstests: doc: add new raid-stripe-tree group
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-btrfs-raid-v2-1-25f80eea345b@wdc.com>
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701780310; l=705;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=vH5ll84B3/EfTeO+vugCYebs+7bGkX44oA4L317bX/A=;
 b=bW19jpSa3QzFgSKhThZ5FToPrIPW7A3X/PzhJnFGlJjYz0qRTxxo4/BplIfvq29Jc+Uq/29bu
 87k2F9HUyRMCA8Og1KZsmjtDkuCn5b41/Fb9Su19FMFDMe/DA5UmkE/
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a new test group for testing the raid-stripe-tree feature of btrfs
with fstests.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 doc/group-names.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index c3dcca375537..9c1624868518 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -94,6 +94,7 @@ punch			fallocate FALLOC_FL_PUNCH_HOLE
 qgroup			btrfs qgroup feature
 quota			filesystem usage quotas
 raid			btrfs RAID
+raid-stripe-tree	btrfs raid-stripe-tree feature
 read_repair		btrfs error correction on read failure
 realtime		XFS realtime volumes
 recoveryloop		crash recovery loops

-- 
2.43.0


