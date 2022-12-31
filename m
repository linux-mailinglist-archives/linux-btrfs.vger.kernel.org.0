Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3B965A53D
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Dec 2022 16:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiLaPGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 10:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiLaPGK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 10:06:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC2633D;
        Sat, 31 Dec 2022 07:06:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so57303819ejb.6;
        Sat, 31 Dec 2022 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzYjYdq3xhU62h8W3pOQxyN7ezBIV3BgXZrEWlF2bCg=;
        b=GfB8ursNzsjfWnx4xvs9KHA3kXC8jlEJ2KnWNC1cRFH8U65NUwEc7VZafWB5Jwaprw
         bM3sgTMddtKM5nVzSIzdGFA40NYgtkWmSAnD48YuwdesfX+/gnEf8ogWTTb9Mk0lmH62
         vmmVE0xDQan39jpJ5kJ0K9TnpFYQlc08h5lc70C8391C/9JSV1jb8w7dd5T6H8dEXQDC
         KamdEW0fP1eCWg2GyBoa1ZvqpVYPpAOAwUFVMOz1We4cuE8+kLm4nrEW4tkZegr0ylDk
         uvh4ZHnE49EEg6GZ+ymT7ErbcOyKTja6cc5EUhtBmOOkUqnv03Janj/NbM4K2pnHhT+g
         hPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzYjYdq3xhU62h8W3pOQxyN7ezBIV3BgXZrEWlF2bCg=;
        b=GRfJfMYIPCuDiZ68BLQ6n7V/KExaEXvulHHd/BFkamwzy3Xj3luugtexpi3BZN60gX
         u0yZyNkqQBSYT7kyS59NVeSYK7wp9odA+ElEYGB1Pw+kyGIztDpFSw0uSwqrtpw3KM9e
         kk+2pxVmq4nV5UhV8q2LOQENaZspFHML4qYXotpM0A2fuMMxAp9VN3n2IC4KOqA2Szz6
         RvjaGzKiY/5xI3uAbfNSH0dVf4HrvBcPQY4rDX5YcNJY3viB0UEZHd4AGSjxrN5SzoSj
         Bulycu8wNq8cP7uXCWxqBfYAWJmnHv0hEVg8yBx2Kx5TGGSC1mM2jnw8aFjL3+761iA3
         c0RQ==
X-Gm-Message-State: AFqh2krNrqtwcdfAD6JNKYI2vGgeLgLG9S7i5ifepXvhEQQSsYM/SNFe
        plW+qtwVrJq6+l821mmOWfs=
X-Google-Smtp-Source: AMrXdXvnaYtFzmsRpzx5SCdvWGNhmpoITkEaXaOCK0nNZx15cdCF9cNxCU9OflwQyNeQdIEu+m7CSQ==
X-Received: by 2002:a17:906:fb18:b0:82d:1d5f:2617 with SMTP id lz24-20020a170906fb1800b0082d1d5f2617mr31713646ejb.69.1672499165142;
        Sat, 31 Dec 2022 07:06:05 -0800 (PST)
Received: from Tanmay.. (ip5f5ad5e4.dynamic.kabel-deutschland.de. [95.90.213.228])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906292900b0073dd8e5a39fsm10798278ejd.156.2022.12.31.07.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 07:06:04 -0800 (PST)
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tanmay Bhushan <007047221b@gmail.com>
Subject: [PATCH] btrfs: Fix ASSERT of em->len when getting extent
Date:   Sat, 31 Dec 2022 16:05:01 +0100
Message-Id: <20221231150501.123205-1-007047221b@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

em->len is incorrectly asserted which is leading to it's
assignment to sectorsize instead of being check for it.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bcad9940154..e49358048a98 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7092,7 +7092,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		 * Other members are not utilized for inline extents.
 		 */
 		ASSERT(em->block_start == EXTENT_MAP_INLINE);
-		ASSERT(em->len = fs_info->sectorsize);
+		ASSERT(em->len == fs_info->sectorsize);
 
 		ret = read_inline_extent(inode, path, page);
 		if (ret < 0)
-- 
2.34.1

