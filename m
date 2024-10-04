Return-Path: <linux-btrfs+bounces-8560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2499903E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C211C21922
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94219156872;
	Fri,  4 Oct 2024 13:19:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8E20FAA4;
	Fri,  4 Oct 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047956; cv=none; b=KseBsdpAOa+bevQwHi4JF3nMZPlIGlQE5pAQjv180PUKdD+v6z7YKPWcGauVgozS3aDw/Uish3qZUNNl8ITC+jzuT/vPy/b+Ja5UUtGHgr77RJK0OZ1QgpFHzKRiUn/Stzbf5dz/ywg7G2feS4ZnvsWNDm3J2V2X38QFD2q0LAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047956; c=relaxed/simple;
	bh=9pd0g5NRuW0OoKQvQfD4kc4y5rgN6O3XZmxtYDj6WzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plumWzZVcf/dyf5qRvbXz2vu07SStFXO9BJVBAKsEdDolFztXnUNvdFlhAbted+40XvluAxh/IuTThVqiVggmwuFtAta7RzIxAqcg9z2JZMlcP4NZvxywFSFCYJS+tZjirO49A2jLyD2pRERTs8VXl/NXj2V025Xy2RYirKXaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ce9644daaso1440994f8f.3;
        Fri, 04 Oct 2024 06:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047953; x=1728652753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNnCppYLxIGhffsDy6p+mSN8RvEoWQUoD8xWvgVlqA0=;
        b=vgDuCTN7+zNahxU7uV2de+2cl7JcxyGAcpMRgjIQrgcoEEuppuU2HNZfCyYYOMwkL8
         luXWr7ZtEzSaaC354w/nQfZBKDhuBX3MaGhKbhAOnb1m2fXeKi+P8yxWht7V1K6fmWob
         BOsGsCDPtlQ7rc6N/k83maoDJkmMY5SDv+n1JqV7U2YNAYdH8vwopoe8qjV6iNrgndZG
         Bfp8Xo6xr6o4EZXZe3VIHr10w8niCywCWD844VxILIVVkRosLmANMja7+iBoZ8VI/Hjc
         R/nY0onbUFVaCRMx/1UF969V9eR6S+U1Pz0I5SgJdezRBit//CLi/oQLbtV2hh6i5Kj0
         mb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+pJyNtdcM3V73tLkxsHo7OTOT/38ehEM30/q5l3VaOT1O5W96Na/qsf+9kPGfGJ5XBty+36mQmgTQo2zm@vger.kernel.org, AJvYcCWcmPZXa+4zugQTx7sO9b4tA+EKJ6JY3xz3A2c4GosYhjxybb+h9ESfmSejX+/JU+NLFZcpKHgzgjNfJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQNJ3ZFw+nxQQ3tjQn+ctjt7KpBv/ubpr6zoK3oScav1LC6wZ
	QiD+G29tc8Ky+ZMRYWL7Tc94spryDmJLpqZqJwIss439HWPIsvOo
X-Google-Smtp-Source: AGHT+IFp/kBkMK6qU0pGozVHgf+5tR134P1Et7KYZWsoNYK8MOLyJUAbwGxztfbviOS4pjLO92GP3A==
X-Received: by 2002:a5d:44cf:0:b0:374:c621:62a6 with SMTP id ffacd0b85a97d-37d0e8f065dmr1708929f8f.47.1728047952463;
        Fri, 04 Oct 2024 06:19:12 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08234048sm3246607f8f.47.2024.10.04.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:19:12 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Qu Wenruo <wqu@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] btrfs: don't BUG_ON() NOCOW ordered-extents with checksum list
Date: Fri,  4 Oct 2024 15:19:01 +0200
Message-ID: <20241004131901.21720-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Currently we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
ordered-extent that is flagged as NOCOW, but it's checsum list is non-empty.

This is clearly a logic error which we can recover from by aborting the
transaction.

For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() that the
list is empty.

Suggested-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
Changes to v2:
* Move ASSERT() out of if () block (Filipe)
* goto 'out' after aborting the transaction (Filipe)

Changes to v1:
* Fixup if () and ASSERT() (Qu)
* Fix spelling of 'Currently'
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 103ec917ca9d..ef82579dfe09 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3088,7 +3088,12 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 
 	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
 		/* Logic error */
-		BUG_ON(!list_empty(&ordered_extent->list));
+		ASSERT(list_empty(&ordered_extent->list));
+		if (!list_empty(&ordered_extent->list)) {
+			ret = -EINVAL;
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 
 		btrfs_inode_safe_disk_i_size_write(inode, 0);
 		ret = btrfs_update_inode_fallback(trans, inode);
-- 
2.43.0


