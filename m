Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D3602C33
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJRMyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJRMyC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 08:54:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C3C4C30
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 05:54:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8AD9B33E8D;
        Tue, 18 Oct 2022 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666097639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2Zc8gIcKNvJtk/NXi9M9U8pNhxkaq20E2QHikUryo+4=;
        b=OZqWljIdNoaMlh8zpaAo+hpDuDUdtNmGSU8T7/XlWukXqGcUcljHnR4+Ul8074TVmXe6/7
        Jgn3rE09Zhl7iV1k+KomxKuTybJyuxmLiv5+clCzQQelUsItC1dHZQKJEXlnE55P8xsfwr
        hA3GQLp3otLqiJTgzw+GqLuClFcvNdI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 81DFA2C141;
        Tue, 18 Oct 2022 12:53:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B46FDA79D; Tue, 18 Oct 2022 14:53:50 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: sysfs: convert remaining scnprintf to sysfs_emit
Date:   Tue, 18 Oct 2022 14:53:49 +0200
Message-Id: <20221018125349.31879-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The sysfs_emit is the safe API for writing to the sysfs files,
previously converted from scnprintf, there's one left to do in
btrfs_read_policy_show.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 699b54b3acaa..20ba663bc4c1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1160,16 +1160,16 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
 		if (fs_devices->read_policy == i)
-			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
+			ret += sysfs_emit_at(buf, ret, "%s[%s]",
 					 (ret == 0 ? "" : " "),
 					 btrfs_read_policy_name[i]);
 		else
-			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+			ret += sysfs_emit_at(buf, ret, "%s%s",
 					 (ret == 0 ? "" : " "),
 					 btrfs_read_policy_name[i]);
 	}
 
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += sysfs_emit_at(buf, ret, "\n");
 
 	return ret;
 }
-- 
2.37.3

