Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813B0BDF1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406636AbfIYNhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406615AbfIYNhp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:37:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF694B626;
        Wed, 25 Sep 2019 13:37:43 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 4/7] btrfs-progs: also print checksum type when running mkfs
Date:   Wed, 25 Sep 2019 15:37:25 +0200
Message-Id: <20190925133728.18027-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190925133728.18027-1-jthumshirn@suse.de>
References: <20190925133728.18027-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As mkfs will grow new checksums, print the used checksum in it's versbose
output.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 mkfs/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 61184c8e7525..04509e788a52 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1380,7 +1380,9 @@ raid_groups:
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
 		btrfs_parse_features_to_string(features_buf, features);
-		printf("Incompat features:  %s", features_buf);
+		printf("Incompat features:  %s\n", features_buf);
+		printf("Checksum:           %s",
+		       btrfs_super_csum_name(mkfs_cfg.csum_type));
 		printf("\n");
 
 		list_all_devices(root);
-- 
2.16.4

