Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF743F51DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhHWUPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHWUPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5264C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id e14so20607509qkg.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5V+LAn/KXmEOAmsXEneXBpak+MuAs9x8XxDh5+4wpvU=;
        b=zrCPwUXTkl4prIIFL7MMUK7cowzpp2j6BjedVG8PRTIJ741vv5l6/KFkaUkbtaIQ4O
         6QVKqNQ9aBgr0WXk0HtJGCSulLFF6q0KB9Zjh0i7Fk8E44+d8KUvcLuapoZRRfy3MFAj
         6Q6r4Q7sDq9SQgv+zIGF/bskXZAm9TE09MIN0kNKWwqhMfz7+M2wxb5syFW1WIi0KxGE
         OFpcoGyf/zTvdxNQ2zCfNLgacZD8JHSQXZRLg87T1bM6cDcpVExcO7/rcERkL9cE26jW
         3qOk1LCW5LfsP2AGmvL/EThXA9jwiavzGt+VmX+hJhQYidtNz3aTc3X1FkZoSSjKFSl0
         OtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5V+LAn/KXmEOAmsXEneXBpak+MuAs9x8XxDh5+4wpvU=;
        b=L2aegqs6cf7/dDxcWKEZ5DzplY2M5sF9rrrXXjWsqsY9dwlqIXh8j/JBpkFX7ziIDz
         Sw5RpsEfgU9dEA59WQvDCVMPZ1RKD63TtMd25Dnerz3AJpSGP0ST3S2JCJWFPpfS3SXh
         kPzlVNjHF699viRi3PAaB0Hsia/CmlrpYddPL+3Q1kt99I0cVrWt46H0qCqWm39mA3cT
         Jyvm1ioKtWTUvPfuI9ytnXqW639agQx/HcEfadddq+3aDCDdiq7H6E7mxhAuJVLSRpJN
         1OKKRTRxMyvXwt2JBU2kAZ/1ECSWJPp274qmFH85G8QYIRHXolHmRehCCTkiI98agndb
         eXKA==
X-Gm-Message-State: AOAM531QvweE+61tDg6TNg0Ow43GApKPTIe6Igd7IwJngC2G2T/7Dx7K
        4o2gZFYfZwidqnF3aZNHgd9lZO07XY/huQ==
X-Google-Smtp-Source: ABdhPJzJP4FWzXVnVF/81n9KKK3wGJQ7GLsHZvsPXJmLxcm4ZynnIJKt4i3GeiINJdLKS/nOw+pgxw==
X-Received: by 2002:a37:809:: with SMTP id 9mr23004940qki.318.1629749701695;
        Mon, 23 Aug 2021 13:15:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a24sm7561166qtj.43.2021.08.23.13.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 03/10] btrfs-progs: mkfs: use blocks_nr to determine the super used bytes
Date:   Mon, 23 Aug 2021 16:14:48 -0400
Message-Id: <09b49b7d3c976f7aa34e3ff91f1b767c45e90812.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were setting the superblock's used bytes to a static number.  However
the number of blocks we have to write has the correct used size, so just
add up the total number of blocks we're allocating as we determine their
offsets.  This value will be used later which is why I'm calculating it
this way instead of doing the math to set the bytes_super specifically.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index ee9ad390..8718969d 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -161,6 +161,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	u64 ref_root;
 	u32 array_size;
 	u32 item_size;
+	u64 total_used = 0;
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
@@ -203,6 +204,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
 		cfg->blocks[blk] = system_group_offset + cfg->nodesize * i;
+		total_used += cfg->nodesize;
 	}
 
 	btrfs_set_super_bytenr(&super, BTRFS_SUPER_INFO_OFFSET);
@@ -212,7 +214,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_root(&super, cfg->blocks[MKFS_ROOT_TREE]);
 	btrfs_set_super_chunk_root(&super, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_super_total_bytes(&super, num_bytes);
-	btrfs_set_super_bytes_used(&super, 6 * cfg->nodesize);
+	btrfs_set_super_bytes_used(&super, total_used);
 	btrfs_set_super_sectorsize(&super, cfg->sectorsize);
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
-- 
2.26.3

