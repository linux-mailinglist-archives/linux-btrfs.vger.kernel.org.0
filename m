Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386BE7B0B4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjI0RrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0RrP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:47:15 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42960A1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-418148607c2so38188801cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695836833; x=1696441633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XawQw8pM4FCGlnKBQnr/sTgSHhTznWGJtzSsWCZMhc=;
        b=S9GstarF2MLP240iCW0nYnj8IbkdmIFjqFqXgNAdMwGJAEYtQkOU0Q16pEaBOuhz5S
         fFsqfOTuRUauwQhZccHxxtx5WaNy56F+1eI77sR0aaGIPZXIaRq8QlbovzWg/hYEYxLc
         NbpfeoAEn/pAih8bzZl7BsxqYAntN+8Oot0nrtoeMv2CjxeX2V5jn6iI92x/k4KUKasb
         21cNwReytvAx5TKoEAZDQYdw9RZ6W5/SJnJlnamFMABZPAHX+3anj1IqztkwCP3ocbz0
         naAytKvvUgjkpURJ9MuhsInNtKuPJo6PjaN8VHRv65pW2/izuUCJpBPZD6ud4ILuTeQh
         byRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836833; x=1696441633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XawQw8pM4FCGlnKBQnr/sTgSHhTznWGJtzSsWCZMhc=;
        b=euvOpUGigzc3B/W187Ntu1gmJS7Ti0HmVricroLAXA4l9phCMUb1Rw2z8i+EGdO7YJ
         fkTuScLL1JtPT0Gex6aisCXylNFCCOrdYA3wZBgDZkiI/6fDj3MgIUsDDFXYRkhZ5hHb
         aJtDv67YN0vreRYIt/HxkgF2xTzNc6E+ojhP4aUBxcPmr/c+IRjXYPot75tVqwbjc1Yz
         uA9AAgmcTwGQ8AZ43vgv+kiRDbvNA78Fk9BYFJWin5yB0blFQirk6s5mzkDFnAfVEwMR
         ngTtkJeCz8bJ1UtD18DqMGu8glWGweYawwAPwjI+xxuiEftBJ2RGY70IViPQ6PEyejb0
         IBPg==
X-Gm-Message-State: AOJu0YzDO8eIbpUFqn/5QrXQVlkcU6QZSodMPvj5Jq78Vxo0Xp3Z/GmO
        gCxICI9LeJ04LwpUjK4jJG2acHYc6WLkTHUfzv0Pgw==
X-Google-Smtp-Source: AGHT+IH5w6EdHJsA9DN6GTm2XcI8RVpVJC86QkrorSORMBBp6/1SdTA99XjKGjyBWrV46Zi9HoTEeA==
X-Received: by 2002:a05:622a:551:b0:417:d600:115d with SMTP id m17-20020a05622a055100b00417d600115dmr3000060qtx.66.1695836833120;
        Wed, 27 Sep 2023 10:47:13 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j4-20020ac84c84000000b004195b8554efsm705650qtv.24.2023.09.27.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:47:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/3] btrfs: adjust overcommit logic when very close to full
Date:   Wed, 27 Sep 2023 13:47:01 -0400
Message-ID: <4f76978ee26b73ecadd24a6cc7aab6187f35adf4.1695836511.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695836511.git.josef@toxicpanda.com>
References: <cover.1695836511.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A user reported some unpleasant behavior with very small file systems.
The reproducer is this

mkfs.btrfs -f -m single -b 8g /dev/vdb
mount /dev/vdb /mnt/test
dd if=/dev/zero of=/mnt/test/testfile bs=512M count=20

This will result in usage that looks like this

Overall:
    Device size:                   8.00GiB
    Device allocated:              8.00GiB
    Device unallocated:            1.00MiB
    Device missing:                  0.00B
    Device slack:                  2.00GiB
    Used:                          5.47GiB
    Free (estimated):              2.52GiB      (min: 2.52GiB)
    Free (statfs, df):               0.00B
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:                5.50MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:7.99GiB, Used:5.46GiB (68.41%)
   /dev/vdb        7.99GiB

Metadata,single: Size:8.00MiB, Used:5.77MiB (72.07%)
   /dev/vdb        8.00MiB

System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
   /dev/vdb        4.00MiB

Unallocated:
   /dev/vdb        1.00MiB

As you can see we've gotten ourselves quite full with metadata, with all
of the disk being allocated for data.

On smaller file systems there's not a lot of time before we get full, so
our overcommit behavior bites us here.  Generally speaking data
reservations result in chunk allocations as we assume reservation ==
actual use for data.  This means at any point we could end up with a
chunk allocation for data, and if we're very close to full we could do
this before we have a chance to figure out that we need another metadata
chunk.

Address this by adjusting the overcommit logic.  Simply put we need to
take away 1 chunk from the available chunk space in case of a data
reservation.  This will allow us to stop overcommitting before we
potentially lose this space to a data allocation.  With this fix in
place we properly allocate a metadata chunk before we're completely
full, allowing for enough slack space in metadata.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7e8cd4f140c..f1cc3ea4553c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -345,8 +345,10 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
 {
+	struct btrfs_space_info *data_sinfo;
 	u64 profile;
 	u64 avail;
+	u64 data_chunk_size;
 	int factor;
 
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
@@ -364,6 +366,36 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 	 */
 	factor = btrfs_bg_type_to_factor(profile);
 	avail = div_u64(avail, factor);
+	if (avail == 0)
+		return 0;
+
+	/*
+	 * Calculate the data_chunk_size, space_info->chunk_size is the
+	 * "optimal" chunk size based on the fs size.  However when we actually
+	 * allocate the chunk we will strip this down further, making it no more
+	 * than 10% of the disk or 1G, whichever is smaller.
+	 */
+	data_sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA);
+	data_chunk_size = min(data_sinfo->chunk_size,
+			      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
+	data_chunk_size = min_t(u64, data_chunk_size, SZ_1G);
+
+	/*
+	 * Since data allocations immediately use block groups as part of the
+	 * reservation, because we assume that data reservations will == actual
+	 * usage, we could potentially overcommit and then immediately have that
+	 * available space used by a data allocation, which could put us in a
+	 * bind when we get close to filling the file system.
+	 *
+	 * To handle this simply remove the data_chunk_size from the available
+	 * space.  If we are relatively empty this won't affect our ability to
+	 * overcommit much, and if we're very close to full it'll keep us from
+	 * getting into a position where we've given ourselves very little
+	 * metadata wiggle room.
+	 */
+	if (avail <= data_chunk_size)
+		return 0;
+	avail -= data_chunk_size;
 
 	/*
 	 * If we aren't flushing all things, let us overcommit up to
-- 
2.41.0

