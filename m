Return-Path: <linux-btrfs+bounces-10294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079129EE0A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64872168314
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63ED20B81E;
	Thu, 12 Dec 2024 07:56:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE962010F2
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990160; cv=none; b=dVoXU8gS8890UrhhFZ3DGc4W9Hgy+ZeSaiLtkbxo8FLvrK1KzWV6BXxfP1L74xHX4s7av/EI4Vc820gKYpbs2Pb6fBjsBWG5cxRn17OOsqKGW73+iELuzZsUwTOOF19gKQR8ShFgGiuEhx3kqVmRxmbiMHyh6l+R4pI4QPvQb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990160; c=relaxed/simple;
	bh=OCaXa0NzEIm6ZCKngS0pAtWSnax0jtvF50XJF0y+/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSaH4zV/V9F2g0dPmxGKkE6nvuK3av/Pd929yavjXj+IV5Ggi7ZAZgD2zeMjQXk/HS43CqhoKt+BY+45t/ZPCmeRjiX1bbYZ2BzdbVGw3bH9SKdFVBgu3cz/DyUnW8O+MgbN1bjNAl8boyKpU5gznbEhhVu8qj89djRbiI1QZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa689a37dd4so49100466b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990157; x=1734594957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A27WXwlr+NKMxDnhWBcMq6poAJO8ZvIuq9iuqLy5Wv4=;
        b=JpXze8eyMDkXQmJNWObADoIENqZ29SwnUYrpIXVRerzzSyaXNAio4zE1FJ7koihUZz
         Ef6SNbIfPpDpC3WpRcXjz0WU/2Gg/7pOU6qDT8pyXlspq+8rws8HDqZSz0rq+3YfnK8f
         E1pUzI18H6Dn+WOy+wy6JTvhlMtQlzC9YlJeJoiZVtH+HDZfmOoxOjo1WgKhoHOJ3z20
         dqDIFfiCepOZNIcDzi2n5PTFNebFOsSDUdDPbDcEroaHfBf5YsJ4fCxdbs/nNxwluLuW
         tKXb9XTkG8VDYse7DF5u/r0M9y4IhQ9SmZaH7R8OuPRzt1uIt6R9ljh38IKjGtXABfBp
         ohrA==
X-Gm-Message-State: AOJu0YxTvshlrhZilTwxLX1HwrEIhYAzG/44meF8PxNFwCwZVZnlWcI5
	0dyzxBP/8W8vwXP3OvLBFVnm5V13uqGxOStrqjV3YDUEajvkos61F8t83oAb
X-Gm-Gg: ASbGncuhb2HxFk003wZtZlBt7y2V7/biMFg+0oKVQdAbw54VJGJDmz/O9Pe6J1KDs/Q
	njEka1twnyp8+Cga2odznStlwG9PtTpSCcNtL9zauI09LgGnTTR9880kzGQoyQ6UPtxbXLk922L
	YHtNxHwH5VxPgi+/FxdSqspUoStbxu+/rTwwoGQUIGIfe9rY2T4oetS6HvP254Wdpv39UrBnfUd
	4j5qrmLc44GNCCaOEJLuJlsjxoao9nD/IGp/oa0G04SxlRyw5mqoWQG8EzzU11+KUWAasKUvxeA
	2hlvnP8WURxjj9yHo7F7Ckkhgt2DzCdDCkfC8CE=
X-Google-Smtp-Source: AGHT+IHzKsHW8gN2myRt/SqPPrjJFWtSF6NXzUO9+kpJbKwPYEkTAbDq1iAc+QpVr2Y2X6OvQ/UbHA==
X-Received: by 2002:a17:906:319a:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-aa6b10f521fmr517639266b.5.1733990156865;
        Wed, 11 Dec 2024 23:55:56 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:55:56 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/14] btrfs: assert RAID stripe-extent length is always greater than 0
Date: Thu, 12 Dec 2024 08:55:21 +0100
Message-ID: <83cba5c8af717d24462ff9d9490dd0849d604f64.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When modifying a RAID stripe-extent, ASSERT() that the length of the new
RAID stripe-extent is always greater than 0.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 2c4ee5a9449a..d341fc2a8a4f 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -28,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.offset = newlen,
 	};
 
+	ASSERT(newlen > 0);
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
 
 	leaf = path->nodes[0];
-- 
2.43.0


