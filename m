Return-Path: <linux-btrfs+bounces-17527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A5BC4C18
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 14:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F3334F205C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F50231830;
	Wed,  8 Oct 2025 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="ENDih1v/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30F1F9F70;
	Wed,  8 Oct 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925966; cv=none; b=t+LMrNDcCNDJ5zvfbTWaCr/EiI7FKagvAkNdWqNmlfygTmiQQrqw6OEDRXAtXrqOekFwFk4r1X2pqgEs+9O5Z4em58wlMq5yAt+C263bbNn+A/7ym+msVbYcp/eF2L3u9kJxMcNDoKfZ4M+eEW27Yc7q1Y8h5YbSj0IeNw1UD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925966; c=relaxed/simple;
	bh=wKu3WqjXdB1c9YRP/iP0zlVMLYEzvndp2qi0kReVdRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2EKCasQqxdMEPNWASc+yu+rxCePVlakbKG/d8HcObyLuq2FqfqhKe5zbon2F2nbgH/ZZtvx46cOaSVkcSRSzV3H6RIbI1oFA5QUnVpnun6cw6FX5oOrcamW+OEXxYdZRHp8FTsDk8FGuHWFV6hnNl4yXmUSU0Tr8EGbwGcINDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=ENDih1v/; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4chX9v3955z9y2T;
	Wed,  8 Oct 2025 14:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759925955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmOpM2qm7Colf9npuwqingVIcKyYgccD1oLMynd94Yw=;
	b=ENDih1v/92t4H9svgn7tt5C9/Sh8HOmPCJxSbeKngHzq/Flxp+9N7nLpWTn/5PdmOVngb7
	f4QjfqHyu5OYIuDiTrC/g8C7DwoByIhymTeT9mLtV/EIJe7CBM09/ZJa2kQ1C9xH9gEV5X
	Re2bhK1jp2juyhJ+AeLV5W25ij+S9xTF+LrGXCcbVB3Odxf0TL+oh/O0N70DBclMrFpDCj
	S+9nZycD4JePEJSA/OGdcOCIWXIQOLgoRMkTyKD3tg81SE6NIKkpmQu/keZGtbqIc3Ap2F
	H4mDrUucd3v93d95U6bE9L2jJ+KNeMWBNgZGeklwtDeoaZbI6+h8yWt9SkdAbw==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	naohiro.aota@wdc.com,
	boris@bur.io,
	johannes.thumshirn@wdc.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v3] btrfs: fix memory leaks when rejecting a non SINGLE data profile without an RST
Date: Wed,  8 Oct 2025 14:18:59 +0200
Message-ID: <20251008121859.440161-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At the end of btrfs_load_block_group_zone_info() the first thing we do
is to ensure that if the mapping type is not a SINGLE one and there is
no RAID stripe tree, then we return early with an error.

Doing that, though, prevents the code from running the last calls from
this function which are about freeing memory allocated during its
run. Hence, in this case, instead of returning early, we set the ret
value and fall through the rest of the cleanup code.

Fixes: 5906333cc4af ("btrfs: zoned: don't skip block group profile checks on conventional zones")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
Changes in v3:
  - Remove comment which was deemed unnecessary.

Changes in v2:
  - Change 'goto' to just assigning the 'ret' variable and falling through.

 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3341a84f4ab..838149fa60ce 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1753,7 +1753,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	    !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
 			  btrfs_bg_type_to_raid_name(map->type));
-		return -EINVAL;
+		ret = -EINVAL;
 	}

 	if (unlikely(cache->alloc_offset > cache->zone_capacity)) {
--
2.51.0

