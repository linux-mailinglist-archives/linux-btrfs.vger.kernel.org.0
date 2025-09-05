Return-Path: <linux-btrfs+bounces-16642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD06B459B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97EC7BC77D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2735E4EA;
	Fri,  5 Sep 2025 13:54:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483135E4EE
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080497; cv=none; b=UyYPyLe5GxutMZLp1lSzUPfTR0mYGlWDkjGRiIPIoQf6jG1SVWGapWbC96aWmAVtXtxg+K3LMOEmYHHN59kohCIDKfwa5QBTSlHTne+KOVXN7TrZxn2HSJOSQv+ZRK6UGCIeXj3KEgYVq39kbau2ywW/fDJaxMv6EuQ3OBxtsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080497; c=relaxed/simple;
	bh=LSpfjMnRNqsoFSFkkI05b2TyN/SotF0SCKim12ANsVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Id9tUg7zqQ6+lF9Cx3BLD3JLh+4HsOS5HXUD3r6OVPtV8V3C/lX3hN5BsqmcbU3Xf9bQhUAI+i6FduLDb43xCim6bxKRYs6SJ+swtWW/2AVKqm2OIbuHWerUL0dhUP4p5yv9GEMgk+ZKOIo8Yg2Guw+gx0pdCQ7vpsPEYzz+zFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b00a9989633so397496166b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Sep 2025 06:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080494; x=1757685294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJU+Rj5m4vc0GSbBxHOx8LDqCkmBVtKUvZh/4bpqVNo=;
        b=UvKn7g7C6bwTMsZgENcuJEgnpi2Duh2RI+kw1/sA5J+F9m7X8rDDj7HGTcnXrt2SFT
         B96TtSpgjY6xHYoXT5h8DXfg0L1An6Mra77eDy1UzAWY/83GwIMhaWsa4VjmaBHgC0kF
         5mXL30e6a4FuG7kDm14AVjcbY3MwfQs9rALg0M5lBSpp7hNUZ42MXXGupUxujpVEqwSC
         rnP4K2SOIkfuaUS+zR6UKyVkqDJ+Svl6GbrgYx3TfOSul8RbMGQ+kWIC1b//40X3ogjn
         mCXB7EZhD6jpEnbA19bao+Ti0JYszHA0pCLNv48GTJX/jiUKH+kpeYuMwBvbLpZSgVqV
         y+Ug==
X-Gm-Message-State: AOJu0YyzqPR/YK6fbEzuP22WE/ufYfbzwqdz18di9J7fPkJ3qGBgAb7S
	QR0lnWR4Vt52qZsVQ1W9k951LkP3XGL57djHj9KP4R8zAEUfxryU2k6oD00M6w==
X-Gm-Gg: ASbGncujZN3zYulSXOdi8GMLt62nD3ltmOeOs0LmyU18ddFm35/u3iGBFHoRw4Qp2Sg
	jW7hdcSkEVp/xVenZ9swzRsVed7nHT3DWIpFJXSVUa87Y499WG/PtoPgxlinPIoY1/Ozk8Wuj1h
	WTs35jqyySnH3IM0xnJLSd6W5GnfZxlqY46mCPOn4WvZU6YEif3Tgf9BFAy1y7nN9rVSGtWliLt
	0tz5sm+aGonD/QBrtqXGQ3lFY8BJV9W9o9ianl+5h4Nb8YcMMAUF1rqbhKrs8+QcMxnzZJHIxWM
	b1LHk3Z8j3eyrgq7S9p/+/bcvJS7T+ErBtHxsJyQfh3lJ4A1Z/3hjP72JB5gi0R4h6Gu69ic4/s
	GANdFprbFEDuXg4LlFHnJsV6Se4XWtMXksjAHms82XmVfgbajMehfPpQPwM2DnS3BBYBikvrdoo
	iFMzBKcwkmjWzy6CbNFqwV
X-Google-Smtp-Source: AGHT+IFgJlou+8Ale+U7Pk+yXKelIc9a1G5ILm5NFy8JrSP6WxAvsvp0p0kBAHx9DsnGbQRtZG5WLA==
X-Received: by 2002:a17:906:dc93:b0:b02:d867:b837 with SMTP id a640c23a62f3a-b0493084d31mr390736166b.7.1757080493769;
        Fri, 05 Sep 2025 06:54:53 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f713d700b091d658a2e005c5.dip0.t-ipconnect.de. [2003:f6:f713:d700:b091:d658:a2e0:5c5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046aa92242sm630354266b.59.2025.09.05.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:54:53 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] btrfs: zoned: fix incorrect ASSERT in btrfs_zoned_reserve_data_reloc_bg
Date: Fri,  5 Sep 2025 15:54:43 +0200
Message-ID: <20250905135443.188488-1-jth@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When moving a block-group to the dedicated data relocation space-info in
btrfs_zoned_reserve_data_reloc_bg() it is ASSERT()ed that the newly
created block-group for data relocation does not contain any zone_unusable
bytes.

But on disks with zone_capacity < zone_size, the difference between
zone_size and zone_capacity is accounted as zone_unusable.

Instead of ASSERT()ing that the block-group does not contain any
zone_unusable bytes, remove them from the block-groups total size.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-block/CAHj4cs8-cS2E+-xQ-d2Bj6vMJZ+CwT_cbdWBTju4BV35LsvEYw@mail.gmail.com/
Fixes: daa0fde322350 ("btrfs: zoned: fix data relocation block group reservation")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6e66ec491181..ba444e412613 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2588,9 +2588,9 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
 			spin_lock(&space_info->lock);
 			space_info->total_bytes -= bg->length;
 			space_info->disk_total -= bg->length * factor;
+			space_info->disk_total -= bg->zone_unusable;
 			/* There is no allocation ever happened. */
 			ASSERT(bg->used == 0);
-			ASSERT(bg->zone_unusable == 0);
 			/* No super block in a block group on the zoned setup. */
 			ASSERT(bg->bytes_super == 0);
 			spin_unlock(&space_info->lock);
-- 
2.51.0


