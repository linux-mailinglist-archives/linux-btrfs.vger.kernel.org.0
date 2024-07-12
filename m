Return-Path: <linux-btrfs+bounces-6412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E98B92F672
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E72830B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF94140E38;
	Fri, 12 Jul 2024 07:48:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABD18E0E;
	Fri, 12 Jul 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770526; cv=none; b=ZRiwNAZLCnqRfjf0w19l/RMaPq23/+Cv/YxFSxjp61Rf2fyCXTOgcfpn+Qa2ElQwaNrJsld8CiWfoKTeXpOCTAc6ZF/CLqND1+DNN4r7FhXC4iWlaxsE2wfEwP5ayUMsckcu4nZkze8fpMpHrihoPYKMbFe3RQiZuBOC0oU7gwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770526; c=relaxed/simple;
	bh=YEgKLCkmYkVWSAIDMb9ijyQwfTPUV016Tt9CI0jz9TY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cDvbDEmMz6uaUF3KLnO7bPKMQNZdwWCqemtyzojBNPuNWRY6RJKITjKxl/sTIsc6oOtYgFxyhLveWlzEosmKHq0P7Dm3+CgIYZbJfLXfFVwG9w74SQ2MPDCiFs+68mvZ1JfGkO9J40BZfMxUZJ6GUUN1Il/lR5/tRuqALvCsCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42795086628so11095765e9.3;
        Fri, 12 Jul 2024 00:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720770523; x=1721375323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUPisyfvdzsHKWJVl5LpxJEyXU4nxhEVT7pzzccqaEs=;
        b=FWx28W7KNWLyxWGlSWoJrdf3sGHrYIn8JhrLL3dPLCEyGcxS67qWc1T7edH/yGQNAo
         AFacfYA2ySSfBHfXW/BK9S5BVyZOif0lO+OAtnzm8rI7MNGnaUSJe1ilGHk3einh03RU
         aq92t+sDD2zxuEfQQDt5zT4Ga872KMiVq6Tuy3FpjALGMhwnS0Ve/xdALEH4j364ORVi
         GL1bJn8ArKR7D/nPY2S7AEcrvCweKPEL9/MQGmJbWKrOalJKPUtJuEFL2XiQnfInu0db
         5sE+wYcYjWTUVEi8U48sYSulP08K1H+2Kozqk3dm/HgP+hJgMrmOjRZNHV4xGIrMaIJi
         7Saw==
X-Forwarded-Encrypted: i=1; AJvYcCVqLL+P0jDI8CAEmdfox4SbQsgD1s6MVjG9B12mOnub3ZJGNMRkOP3wQdAWDe5XypxfZ7f4I8mlDOtg9P8tQt2qc2Lv4tMd5FCIapLV
X-Gm-Message-State: AOJu0YxtZuQQ9Nv0Ls5UDIKuk+Au7ofvArQBCE1nck3+2/LUnpnJa/ZS
	05rpgxscRjzd0eLNsvM42FBME2meAvrGKJ4LKUiraDTjo8BdVgT5UfgBFQ==
X-Google-Smtp-Source: AGHT+IE5DGsuivt2214AdmlS7Xkx0s4Yj2BtR9cp79wF0zDV1jPB6BcWKb2xp9HihWt+5rCY3inWmA==
X-Received: by 2002:a7b:c414:0:b0:426:6379:3b56 with SMTP id 5b1f17b1804b1-426707d895amr73856205e9.15.1720770523289;
        Fri, 12 Jul 2024 00:48:43 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d74d5sm13532115e9.46.2024.07.12.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 00:48:42 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 0/3] btrfs: more RAID stripe tree updates
Date: Fri, 12 Jul 2024 09:48:35 +0200
Message-Id: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPfkGYC/3XMQQ6CMBCF4auYWVszLRiKK+9hXFBmgEYDZIqNh
 nB3CyuNcfle8v0zBBbPAU67GYSjD37o08j2O6i7qm9ZeUobDJocCyyVy5WEST1GqiYOyrmyRs7
 Lmo4OEhqFG//cgpdr2p0P0yCvrR/1+v5NRa1QGUSLSA1jQ+cbS8/3wyAtrK1oPrzWP94kT4WzW
 mdkrSu+/LIsb/vwTqTtAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=jth@kernel.org;
 h=from:subject:message-id; bh=YEgKLCkmYkVWSAIDMb9ijyQwfTPUV016Tt9CI0jz9TY=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRNuH/zq+e+C6s+pSw/qco6xeuBYIxA66tVDiF/f67Kj
 N0zYa+gU0cpC4MYF4OsmCLL8VDb/RKmR9inHHptBjOHlQlkCAMXpwBM5L0Dw/98lZvLOa82MGSt
 v24RG8N758fp6lxhrtzDbO/f/FTaJbuTkeHXltjPtgtf/9qnvuBmSush9bTOiJfXJbw6Vua5Tby
 lkM4BAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Three further RST updates targeted for 6.11 (hopefully).

The first one is a reworked version of the scrub vs dev-replace deadlock
fix. It does have reviews from Josef and Qu but I'd love to head Filipe's
take on it.

The second one updates a stripe extent in case a write to a already
present logical address happens.

The third one correects assumptions in the delete code. My assumption was
that we are deleting a single stripe extent on each call to
btrfs_delete_stripe_extent(). But do_free_extent_accounting() passes in a
start address and range of bytes that is deleted, so we need to keep track
of how many bytes we already have deleted and update the loop accordingly.

NOTE:
The next big bug in RST is related to relocation. When relocation is
reading from disk (via relocate_file_extent_cluster() ->
page_cache_ra_unbounded()) we're trying to lookup logical addresses that
for some reason RST does not know about and this leads to a tree dump and
ultimately a panic afterwards.

---
Changes in v3:
- Add Qu's Reviewed-by on patch 3
- Change patch 2 to using write_extent_buffer() (and drop Qu's R-b again)
- Link to v2: https://lore.kernel.org/r/20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org

Changes in v2:
- Add Qu's Reviewed-by on patch 2
- Add patch 3
- Link to v1: https://lore.kernel.org/r/20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org

---
Johannes Thumshirn (3):
      btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
      btrfs: replace stripe extents
      btrfs: update stripe_extent delete loop assumptions

 fs/btrfs/raid-stripe-tree.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c          | 28 +++++++++++++++++-----------
 2 files changed, 55 insertions(+), 11 deletions(-)
---
base-commit: 584df860cac6e35e364ada101ccd13495b954644
change-id: 20240709-b4-rst-updates-bb9c0e49cd5b

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


