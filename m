Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F120542D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbgFWOKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 10:10:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45651 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbgFWOKs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 10:10:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id s10so731913wrw.12
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 07:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vf7rEy4zYlydqb4wnH629EGqC3tPkspLxmVn6rlL6DY=;
        b=bnDr08948IZWBnpr57hSNpwre7CtOLMFAdTitHOCCLAQuHjbd0jcltAfwAtjfvhm2V
         QwwPBCUqleJ6iUZXWRnkQ00+ciRiYaFgLCtQH2SMtit4AhPi2iHv6OtC1TbQznB3KS4t
         zHkk8o1B2wmvbKICMsGnjYra+xwj6s5KQq0dKWPZxiriFXM1nQSWC+sgVLkTD74ZyOs7
         e/DHT9l36gW5UgozNzGe0/SJDTL2VpR4zolFbynQINZGC9VZ98aZePxzCBRimuzcNLf9
         tl8piEyLaoklzzYc1ooYoYRmMGE5UNfLwGZ0hVq6PWENcqVPazfJN+VZqXpF3ZxX36t0
         zHOQ==
X-Gm-Message-State: AOAM533vKi92mqD2eQBArJ7AtNGJYoXn0XH0mMeVYHm5HwPOrdtGg4zs
        lyvoG734o+ETbNbyoqjYaN0=
X-Google-Smtp-Source: ABdhPJxHgt+q5G3FnDP5j9WGPbPt5sW7/AljfSH9+Pfs6ElB0xtrnqCZAKsI1epFpTNdchNE5Mhd6w==
X-Received: by 2002:adf:e908:: with SMTP id f8mr2337862wrm.3.1592921447564;
        Tue, 23 Jun 2020 07:10:47 -0700 (PDT)
Received: from NUC.fritz.box ([2001:a62:1515:bd01:f64d:30ff:fe6c:acb5])
        by smtp.gmail.com with ESMTPSA id n1sm22529497wrp.10.2020.06.23.07.10.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:10:46 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/4] btrfs-progs: remove unused btrfs_raid_profile::max_stripes
Date:   Tue, 23 Jun 2020 16:10:18 +0200
Message-Id: <20200623141019.23991-4-jth@kernel.org>
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

The max_stripes value of btrfs_raid_profile_table is unused, so we can
just remove it as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 volumes.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/volumes.c b/volumes.c
index 82d7a872..71c3735d 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1000,43 +1000,33 @@ error:
 
 static const struct btrfs_raid_profile {
 	int	num_stripes;
-	int	max_stripes;
 } btrfs_raid_profile_table[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_RAID1] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_RAID1C3] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_RAID1C4] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_DUP] = {
 		.num_stripes = 2,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_RAID0] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_SINGLE] = {
 		.num_stripes = 1,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_RAID5] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 	[BTRFS_RAID_RAID6] = {
 		.num_stripes = 0,
-		.max_stripes = 0,
 	},
 };
 
-- 
2.26.2

