Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A020542E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgFWOKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 10:10:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40869 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbgFWOKu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 10:10:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id f139so1958098wmf.5
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 07:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8HQtq6/PsEMVkFh06uQcpZoI2BZq3AK+tD+s3Fzskfs=;
        b=HMQEIYV52Jpsxu19xq+vlFy0/x62KeOS/HEfbl9wN+ytyrFf8Kna7ow79znqxjpG8B
         q+UrPJIE+w3TUwilQW/FoSyvTFtk49Pt0AQc6WEQAi02Fm0/WPfpw5WW46tsUrBzrSwh
         0MHf8vY47Kx1F1HgRgxgd+CYcqsIg4a5lutpmtfiOX+6od3V9lJ3m9kjS46crrqu4mRU
         pvMMBc6PqSgMsUQ242c5khw8zptbnWfHy/8THlQ8+efcEQPCFny7Drw0SVGve5lNf1OE
         8yw/iVkb9sV57N6bvamrEoJiv8ei8aV9O6Ctb8COPwf+WCdUQcqB3nBOVhXysGWmff1G
         I0fw==
X-Gm-Message-State: AOAM530NhepsA4GOsz6BI1WbuJgCg+E4kRGzysABrRMZCBQNDiAUGMYA
        XE3DdONmFRKl2shgR9wIeIo=
X-Google-Smtp-Source: ABdhPJy768BpjQy9p0nAhjCH1VWZX4Hts+sFMDKaJLEP6bYG974hp0SbhFot7fuDjrYdA9QkcnL8kQ==
X-Received: by 2002:a1c:449:: with SMTP id 70mr22591932wme.149.1592921448368;
        Tue, 23 Jun 2020 07:10:48 -0700 (PDT)
Received: from NUC.fritz.box ([2001:a62:1515:bd01:f64d:30ff:fe6c:acb5])
        by smtp.gmail.com with ESMTPSA id n1sm22529497wrp.10.2020.06.23.07.10.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:10:47 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/4] btrfs-progs: remove btrfs_raid_profile_table
Date:   Tue, 23 Jun 2020 16:10:19 +0200
Message-Id: <20200623141019.23991-5-jth@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623141019.23991-1-jth@kernel.org>
References: <20200623141019.23991-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

For SINGLE and DUP RAID profiles we can get the num_stripes values from
btrfs_raid_attr::dev:stripes. For all other RAID profiles the value is
calculated anyways.

As this was the last remaining member of the btrfs_raid_profile_table we
can remove it as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/volumes.c b/volumes.c
index 71c3735d..e8b4aad8 100644
--- a/volumes.c
+++ b/volumes.c
@@ -998,44 +998,12 @@ error:
 				- 2 * sizeof(struct btrfs_chunk))	\
 				/ sizeof(struct btrfs_stripe) + 1)
 
-static const struct btrfs_raid_profile {
-	int	num_stripes;
-} btrfs_raid_profile_table[BTRFS_NR_RAID_TYPES] = {
-	[BTRFS_RAID_RAID10] = {
-		.num_stripes = 0,
-	},
-	[BTRFS_RAID_RAID1] = {
-		.num_stripes = 0,
-	},
-	[BTRFS_RAID_RAID1C3] = {
-		.num_stripes = 0,
-	},
-	[BTRFS_RAID_RAID1C4] = {
-		.num_stripes = 0,
-	},
-	[BTRFS_RAID_DUP] = {
-		.num_stripes = 2,
-	},
-	[BTRFS_RAID_RAID0] = {
-		.num_stripes = 0,
-	},
-	[BTRFS_RAID_SINGLE] = {
-		.num_stripes = 1,
-	},
-	[BTRFS_RAID_RAID5] = {
-		.num_stripes = 0,
-	},
-	[BTRFS_RAID_RAID6] = {
-		.num_stripes = 0,
-	},
-};
-
 static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 				 struct alloc_chunk_ctl *ctl)
 {
 	int type = ctl->type;
 
-	ctl->num_stripes = btrfs_raid_profile_table[type].num_stripes;
+	ctl->num_stripes = btrfs_raid_array[type].dev_stripes;
 	ctl->min_stripes = btrfs_raid_array[type].devs_min;
 	ctl->sub_stripes = btrfs_raid_array[type].sub_stripes;
 	ctl->stripe_len = BTRFS_STRIPE_LEN;
-- 
2.26.2

