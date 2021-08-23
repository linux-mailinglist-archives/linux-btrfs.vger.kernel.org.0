Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C353F51E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhHWUPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHWUPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:15:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E54C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a10so11734861qka.12
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6J8br5T+/R5thnTvgKORFmCR7B/pEUhJ1PfQi2Zo/k=;
        b=HRWQCFhFvo/BuymJn6XXbl1RaKtedlmXKn59b0SS7ikmOqpPTi5Lpvl2kJgL8rFNjC
         h2ra3853i4wHaK/euoqvCDupHFzHKvoEgpyYbDATQ53fzBYUrS8yQTi8QsKyEqvL5jh4
         yAHT42cBTmun7oKsOpJ6UegFJh2EcbWZmmJLNoGztalBntyGlX3MaHi7RKhqPqarbS+Z
         vYKQ9FN9O7mlFM1XeOW78KDvAyH37jSzoPehsDpRgpDmGswZIuW5ye2K0lGQPwB2/oYA
         0uNJmPUkFyxdXfHw8gagJaZFvg3NLf95MKTgV2PkiDUHfPc29CGRt7z3EBFOmHMAHger
         B+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6J8br5T+/R5thnTvgKORFmCR7B/pEUhJ1PfQi2Zo/k=;
        b=cnZNqGA/7xeW1lcWCOtDEbozc2fMmAzCPKDOgw/1VSr1aE+Za61YJW4eD4CAyNaBh7
         SFI25m/g90AYbGDLDF5qopWLnwF5Jbea7S5eyPLx4VN6Jq46+uMD4JQijoqW0FXiYUlO
         vJED2HONM0v8sji9Tsf9EObi5XbJvEfWTAlZfZ6NcjAjJQ7Nh8KMW9LtuEyXXFpJdWWC
         UmIDqgrJekwnW7QIpVeNUefRibenaAq3ym1coQthB6c11DxdXPfPilaXJgGaKlULfqS/
         DYL+U7QBrzTuJkzT8uIBCyfMwYxmcEsa8P2GFCZcVoebFyY9jCtTjR0oOlsk+wWw6lv6
         4kog==
X-Gm-Message-State: AOAM530/FYHzM7GFI7wkstklja9mACA9MGwXRQ1whR3+Qtps6x9Ea9Bw
        9yYAWgPe2xd9KYw/QtcyG2FN8skxAJfocQ==
X-Google-Smtp-Source: ABdhPJwodLyc7PR22aT9nEl4vZS9Di47tP9Zs9FvslFgGa0M1yCZksU/PjPr7ly4UONOZvGB+my6Tg==
X-Received: by 2002:a05:620a:b10:: with SMTP id t16mr23346715qkg.158.1629749703205;
        Mon, 23 Aug 2021 13:15:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q14sm9086253qkl.44.2021.08.23.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 13:15:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 04/10] btrfs-progs: mkfs: set nritems based on root items written
Date:   Mon, 23 Aug 2021 16:14:49 -0400
Message-Id: <cacd5e1916dfdcad22033fe5b9c78f11e7802aae.1629749291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629749291.git.josef@toxicpanda.com>
References: <cover.1629749291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the root tree we were just hard setting the nritems to 4, which will
change when we move to extent tree v2.  Instead set the nritems after
we've added all the root items we need to the root tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 8718969d..339c5556 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -106,6 +106,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 		itemoff -= sizeof(root_item);
 	}
 
+	btrfs_set_header_nritems(buf, nritems);
+
 	/* generate checksum */
 	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
@@ -233,7 +235,6 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data, 0, cfg->nodesize);
 	buf->len = cfg->nodesize;
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_ROOT_TREE]);
-	btrfs_set_header_nritems(buf, 4);
 	btrfs_set_header_generation(buf, 1);
 	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
 	btrfs_set_header_owner(buf, BTRFS_ROOT_TREE_OBJECTID);
-- 
2.26.3

