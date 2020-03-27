Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7807194E36
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 01:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgC0AzR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 20:55:17 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:33334 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgC0AzR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 20:55:17 -0400
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jHdHE-0004x4-Cx; Fri, 27 Mar 2020 01:55:14 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.93)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1jHdHD-000Wvd-VB; Fri, 27 Mar 2020 01:55:11 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Fri, 27 Mar 2020 01:55:05 +0100
Message-Id: <20200327005505.126534-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en da
Subject: [PATCH] btrfs-progs: check: typo in an error message: "boudnary"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 4115049a..484b0729 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8640,7 +8640,7 @@ static int check_dev_extents(struct btrfs_fs_info *fs_info)
 		}
 		if (physical_offset + physical_len > dev->total_bytes) {
 			error(
-"dev extent devid %llu physical offset %llu len %llu is beyond device boudnary %llu",
+"dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
 			      devid, physical_offset, physical_len,
 			      dev->total_bytes);
 			ret = -EUCLEAN;
-- 
2.26.0

