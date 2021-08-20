Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6D3F345A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhHTTMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbhHTTMn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5EC061575
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e14so11922952qkg.3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EQ9phSBoNiJTKgjmA81CykTI9e0lYcrrwMLdf2t2hG4=;
        b=hKDkoT5vUeaseKiqmZl5X/r9vBGy2TEKTroaF9+wWSAbybuHiohuDTAKAJcsqVdO2n
         jz/Xl7H5ODWwICbP0rwsNA9auy5B/aax/+mIk2in3CiKdXeq8OWY2neqHOCGlV2TtA9x
         yjCdUQI5NKbmaLaj6JjkIm4UEGGuEwIlfkRWLXVQodUoKNANT9BgWBljcYZR9GXfSVhV
         Rw/6KcL8Fo3x1g2FAq8RYVzvYAh1WkNJDg5grUokfF/1tSzh78kwuyhp7qMGAYfueFAE
         6M3ETUEnKJKLsl2IUx+2ZIXConF2RbZZ/v9DHO7CGzdk8BAKyt5YJxomhWd8A2NZ99ld
         Kk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQ9phSBoNiJTKgjmA81CykTI9e0lYcrrwMLdf2t2hG4=;
        b=OTqkKMcogZ9Vfz9kLM19STUogbM1w2ypYNckFsDElKJaVS7gLAIPgpkWfHkYxxT9CT
         vKVGtzmwWYDHSJlArsE8AsSYXeSRgC0XGcaPWUmdFkbKCeDVRH0eMPPUTv3i53dq1Qiq
         eGKCd8vFiSTvpmHAxiBnTinARM+WiItDolvLvLqMj+DwqUq/mn0pKmNQqp/fNZSEqow0
         idfccY0m/yUwsOHp8etabqDqVYW+5pcqXfI7SvpFeY124LMn61l6aKXAxVbAndkSJtzF
         9jVsIQeJ/3BgPcHk5qabQ6NPcNqGXXeR9qOl5bUZznRzZ2oMXwgr9dDZp/sbN0mmKnSL
         RTxw==
X-Gm-Message-State: AOAM530P2ZZ8jwnI78BPOkDV+V4cztNSHxFAzKTxex1dewZ7KYQBvUeN
        oEEy8rO/dlMyDehywjtTXko7emhS534Qig==
X-Google-Smtp-Source: ABdhPJwU6us0YQlCFISlu+grq03AiRZfnY50t0RWPDjTCNHAnu/inGGESTksucrRxRsGL66ZBXq9zw==
X-Received: by 2002:a37:506:: with SMTP id 6mr10341603qkf.15.1629486724671;
        Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l14sm2939833qtj.26.2021.08.20.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs-progs: set nritems based on root items written
Date:   Fri, 20 Aug 2021 15:11:52 -0400
Message-Id: <82a9fe493d3f785f30aecff22067d88eb08d4dc0.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the root tree we were just hard setting the nritems to 4, which will
change when we move to extent tree v2.  Instead set the nritems after
we've added all the root items we need to the root tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 0e747301..29fc8f12 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -107,6 +107,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 		itemoff -= sizeof(root_item);
 	}
 
+	btrfs_set_header_nritems(buf, nritems);
+
 	/* generate checksum */
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
@@ -238,7 +240,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data, 0, cfg->nodesize);
 	buf->len = cfg->nodesize;
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_ROOT_TREE]);
-	btrfs_set_header_nritems(buf, 4);
 	btrfs_set_header_generation(buf, 1);
 	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
 	btrfs_set_header_owner(buf, BTRFS_ROOT_TREE_OBJECTID);
-- 
2.26.3

