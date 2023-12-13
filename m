Return-Path: <linux-btrfs+bounces-916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B524881103A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7273A282247
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37224B37;
	Wed, 13 Dec 2023 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c7LM+L93"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80F114;
	Wed, 13 Dec 2023 03:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702467341; x=1734003341;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SrNCAwEsJo1UM4mmIzdwJpUzppVy34ero4srnNdxS5Y=;
  b=c7LM+L93qjgEITJCEZ+rox/U6RV7vi9uiyjTC1drMnwvsFhJ+zXL4mtg
   U8aSuLWXv6E7ZvUCatFsOcc/N29PeTgHIPVjcTwqGp1SbGJBajDzGF7SJ
   bPOYrG/g+CLUuHEktgiTzdI+kC0pTlRSimEHk1cBFNHFjyUroatp3lZIO
   6KVsOc6jGNWFlgatzAiX1hOeXjBJnAk9Kx/dWNOL/OAo3Tys+s+z4ElVs
   kfB8xb9zFA6GLW4B0G145PwJdANFnhFyW+8MJLga672nwBXUrob5KjSm1
   teCo4W4lOUJvYQ6c/bykoYBRv3hBWVci0vaoiPD+3FIz4w1+hPt4H6xUm
   g==;
X-CSE-ConnectionGUID: 0NceXpY0QNG12BhRQLjWXg==
X-CSE-MsgGUID: YkBldq6SRP2NAAQurMrqhg==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4718834"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 19:35:29 +0800
IronPort-SDR: RJZX/PoYAupVXjD0T0d1hRS9DrYLmLHg+9aaf5dA47GisEvh4q/i2QF4W3pVPZHJe8ZeL8FdH4
 k1teywbwM+NQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 02:40:41 -0800
IronPort-SDR: kP4NVaZD0wLmYvQzXk2K8vPjWbgsuTbqe74xbTGRRdGxvY1bXyNt5EkfD0foRkbwjKFk+pcm/A
 G2rhIyUtkHQw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 03:35:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 13 Dec 2023 03:35:25 -0800
Subject: [PATCH v6 4/9] common: add _require_btrfs_free_space_tree
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs-raid-v6-4-913738861069@wdc.com>
References: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
In-Reply-To: <20231213-btrfs-raid-v6-0-913738861069@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702467323; l=685;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=SrNCAwEsJo1UM4mmIzdwJpUzppVy34ero4srnNdxS5Y=;
 b=4HwvpPGd5PwdoHVOLG+h5eoD4fagSJLhSwcLNyQIib16BPrhJ6prslV7UId30KqG9OSwGEoed
 tfyKk9rIJwxDKocc9WHrLVQDNMy/QYENrwgnIyiTmaPoRH9vkplcnV2
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/btrfs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index a80ff0264c6a..2196c3d58360 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -137,6 +137,16 @@ _require_btrfs_no_block_group_tree()
 	fi
 }
 
+_require_btrfs_free_space_tree()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	if ! $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
+		grep -q "FREE_SPACE_TREE"
+	then
+		_notrun "This test requires a free-space-tree"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1

-- 
2.43.0


