Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389CF7A5318
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 21:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjIRT2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 15:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIRT17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 15:27:59 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FD10D
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 12:27:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76dbe263c68so219285685a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695065272; x=1695670072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrnW9w7Bff3OqXDJ3QdH6+2Nj0fAyZu2yCrcvc0u6gw=;
        b=tTrYcUUs8mOpDt2Q+koTgU7x3HwUDaDxIKTHeoaJRvWqF18XNhDGBIlY9OH4a9lTcp
         5gFIdOLMlGE6YX/CoYjcrI5Gxi01W3WgiB+4yucFxLI+Fc/HXWwXR8Eenpa8QsLE4kXk
         vPhp4NS6TpHXRW8NzyXTdoWfc6k5wjGLPlaMOD9obynkX21a8hM1GOMHwRwAu2UgN25a
         Rdlmf29rOUcHlUBi7WNIWU0ePeadtwPjtSJpJ/Pl7geOJQVAdrMem3LOHackkmD4lieX
         tmYkLpAuVAYNKxSCf6/VEh0pv0Y0H0GQmP3WCCYZTYZ++JoBC48/qiGRr4khgZPYXqov
         3/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695065272; x=1695670072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrnW9w7Bff3OqXDJ3QdH6+2Nj0fAyZu2yCrcvc0u6gw=;
        b=wAe8E+oV5oe9+N/OUTMGVoJyBzI4lfCHEnHH2OdkWSXhWuMtJ0EPxzdcJfi4iWvcQa
         wEVWUZPmJYKiHQjy6M0Qcgo8JHGOoU2u9+QSH1bcHkRKYXYblQOJyM8bmp6v0rEmDdej
         R/+7NMmi9ZwzfF2So84tRsZqrqdVS2IOs7ljaqjuqxaBgmezTMeTLLaRgGDq5TmuSVBH
         P2YPmk2ilIsU+ZHZOjQZcLNELOq+q8w+xlcy3WWmYydzfkuTEPwqnjbHvHZPMbqXwGXS
         sfPtoMtiaFBbtMxllRg+WCGuqFbsi+snAm0/eezzWgVtgsGr+EDiT7ArD+sZGTPsa7DR
         ElGw==
X-Gm-Message-State: AOJu0YzgOcnAczfIm5r2YuxNxLRnuUwIz+1QR6oL2ymEdzG/DGH1/dmZ
        8AUr7NKCJVB2oZShiG1zwKVh4RQALE2Rx2D/rhFJHw==
X-Google-Smtp-Source: AGHT+IFg3U7cftWS/0vQX0flHuOgkcXFpo2jWtbViNA0ul4QfguTJcha4iJuyGmsmR37PvFNGj3XRQ==
X-Received: by 2002:a05:620a:4726:b0:76e:f7f3:723e with SMTP id bs38-20020a05620a472600b0076ef7f3723emr628206qkb.38.1695065272622;
        Mon, 18 Sep 2023 12:27:52 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id vu2-20020a05620a560200b00767b0c35c15sm3361354qkn.91.2023.09.18.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:27:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: adjust overcommit logic when very close to full
Date:   Mon, 18 Sep 2023 15:27:47 -0400
Message-ID: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 fs/btrfs/space-info.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7e8cd4f140c..7aa53058d893 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -365,6 +365,23 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 	factor = btrfs_bg_type_to_factor(profile);
 	avail = div_u64(avail, factor);
 
+	/*
+	 * Since data allocations immediately use block groups as part of the
+	 * reservation, because we assume that data reservations will == actual
+	 * usage, we could potentially overcommit and then immediately have that
+	 * available space used by a data allocation, which could put us in a
+	 * bind when we get close to filling the file system.
+	 *
+	 * To handle this simply remove 1G (which is our current maximum chunk
+	 * allocation size) from the available space.  If we are relatively
+	 * empty this won't affect our ability to overcommit much, and if we're
+	 * very close to full it'll keep us from getting into a position where
+	 * we've given ourselves very little metadata wiggle room.
+	 */
+	if (avail < SZ_1G)
+		return 0;
+	avail -= SZ_1G;
+
 	/*
 	 * If we aren't flushing all things, let us overcommit up to
 	 * 1/2th of the space. If we can flush, don't let us overcommit
-- 
2.41.0

