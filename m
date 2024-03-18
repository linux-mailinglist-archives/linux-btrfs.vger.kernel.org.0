Return-Path: <linux-btrfs+bounces-3351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F187E993
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0351C21350
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6F38FA6;
	Mon, 18 Mar 2024 12:49:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336738DDC
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766195; cv=none; b=T2+0Sr0c0g7fDQXZ5PZ5+aczMtMvuydizfmhSTpTnLa9Nct8+9NyweLzzx/hpCM8ewbltacOA6Ae0OPYPWa6KrUJyvzo5BD0HRSamWzxIpQ5V98L+JEsdaZ+1U9cBhBNJYj9I8m25VOwBpiTC6cI45XDpJC0VDq0f6M+XFAlp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766195; c=relaxed/simple;
	bh=OdpP6Lx+ElclbLk+UIjJ74djk6pYahfbxcixCWqXySw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amcZdyoeLyd28T7qU0DxCQ3NbZjguE55YAOugPQQvdTOMacGXiMIkx+n9oDUZa8FXLjiax9N25B0DOqRgGEdXuzcckq4DQKTLhv7jHFxJ1oZ6+fY5evH6puvnTFYIU0b755PvR3olAQcXkYzC8W0px/815aDwCBEPEXcoNztq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ac74611bso256737066b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 05:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766192; x=1711370992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F9RWas7r1/659HOJAKYZzWiYw54oPL4Gm/LoDrY9b8=;
        b=thxmCHIqlxic8ZsxbwQqZKclMr1436nlNVbTlkhgBzQQRsyLqvPm6SLYymUZJQLkGa
         WWgqFe+54xKk2+FPbF2hSnVdjCJrlDTaIhs0Z7IK8a1Nf5InWaHaOYvmCiSRg3VXfqTH
         tfnD5/3esqh/GGSERRm2N6J9jw0cDuZhX6qVHj+2+SCxK5s21t4BSSe6TSvs/QRk0W5d
         kxXY1bc8oNv2bn5T6YFupESH89mGua7pD+hZL/JxmfnJizXtutEUxfN35qNg1HK4vabG
         fHkdEOsPbRizTqbWEVL4OInRDB+1AuyPK1sZGkjrqePAJMFVeAAzV4LLzmh0jcGifJ05
         2Y9A==
X-Gm-Message-State: AOJu0YwvmUg4/7Su0Int0w3O02x6DYp23Gyqwh0kweWNr/wGKIo2v9Lj
	qTVe6c5U6uSZnHHHmOyQKM324io1+Mp/tv/naXiQ6Ss5Sl72lXnQG8Meu0MR
X-Google-Smtp-Source: AGHT+IH4g/PmkODN1LmTjISOqg0SRONUg6yb7ISeH4Szi8Qda5NzX/zUbTGbLF0oLsisOBM5TNNwSQ==
X-Received: by 2002:a17:906:6c8e:b0:a46:b9eb:ae5 with SMTP id s14-20020a1709066c8e00b00a46b9eb0ae5mr2961320ejr.24.1710766191721;
        Mon, 18 Mar 2024 05:49:51 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id lg21-20020a170906f89500b00a46cc25b550sm539339ejb.5.2024.03.18.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:49:51 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: zoned: don't skip bgs with 100% zone unusable
Date: Mon, 18 Mar 2024 13:49:43 +0100
Message-Id: <b46794f0115a70b4d0dd1ececa993bd0186a80d8.1710766178.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit f4a9f219411f ("btrfs: do not delete unused block group if it may be
used soon") changed the behaviour of deleting unused block-groups on zoned
filesystems. Starting with this commit, we're using
btrfs_space_info_used() to calculate the number of used bytes in a
space_info. But btrfs_space_info_used() also accounts
btrfs_space_info::bytes_zone_unusable as used bytes.

So if a block group is 100% zone_unusable it is skipped from the deletion
step.

In order not to skip fully zone_unusable block-groups, also check if the
block-group has bytes left that can be used on a zoned filesystem.

Fixes: f4a9f219411f ("btrfs: do not delete unused block group if it may be used soon")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5f7587ca1ca7..1e09aeea69c2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1559,7 +1559,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * needing to allocate extents from the block group.
 		 */
 		used = btrfs_space_info_used(space_info, true);
-		if (space_info->total_bytes - block_group->length < used) {
+		if (space_info->total_bytes - block_group->length < used &&
+		    block_group->zone_unusable < block_group->length) {
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
-- 
2.35.3


