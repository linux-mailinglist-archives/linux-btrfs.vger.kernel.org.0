Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A860A68DE58
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBGQ5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBGQ5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:37 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BB43BDAB
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:36 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id m12so17453536qth.4
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK+Ex40ZiEXKMIyDURmGZHb8DUO5Bzdj8gJ1yfSnltQ=;
        b=Gr4FYeR7Z6bki4yFRL5TJAQf7MyXG4L33sY42DYeDjnGESJ3+O57DBZalOnDy802lx
         nZ0NrC5McvJ4cfPyLY2hy1iI/a0QBz7EKKG0GsgKZ0eZz/ssKEeeWPO+fvm5iELuL5EZ
         +Uw0SUctRE/Btq72anJwWW0HH97sQJ0g6yTFG6AmVFXRUQUCk4fVWoBM83PGgjxJR/qM
         xUzjuwkWuWdZ0eZ7nXfkRlUtKV+wpcH8mVirPI9Y61EpzQz2zB3RcCboRR7X8oAQJ9Lw
         1fC0OmiUE+MaeqSBVJzIVFg6RCgmZ+NYNBQdkNeGWuNUmMmZcGYr1VFiRsnC9z1I3Qb6
         aplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK+Ex40ZiEXKMIyDURmGZHb8DUO5Bzdj8gJ1yfSnltQ=;
        b=vkijrCnaehRWH4cRKFjt+oyMxkkzFwox0V6xcuxtNpfZJf5nP4i7kBPsp1RGnCzg2p
         7ToadKIQu8htaUr8vi246N7BqgCILqSbI5n+mGgxFbJefe0xmhSULoHgh2Zu4Pq5Vy0F
         BC2G/9/H1u8Ak8EjoPy2viKWz7i+hhzygbLtOHwDFWu8dZghBymPRRoVwLLVs5zTrun5
         g4GIw8O+wdBGSvCWq1NNBWaKaTheak7fSx9R97DkKIBarCl8LFEUjE0unfp3gYw9RZTu
         dIeCXE/gGAtKcQmjQDg8m4k+ZWItOqxnSL9/1JQhDghFsKDFnGEu2LbqA/Rdun/zInjw
         vCgw==
X-Gm-Message-State: AO0yUKXLrhMSGMroCTlpGISL/q5Tj2BaehBQr/vDDYj/fJqbEcVB3t8A
        6qgNmhf8ELTJiV2am2oses8R8t5HrsJi5yWUk0Q=
X-Google-Smtp-Source: AK7set94BQ3QGRBabriPKMoZQD1nGNwzY0UevKBXZRyhVdvc9wZn7NEGBxAtIoWf4IBpAiPTFZBmmw==
X-Received: by 2002:ac8:5b4d:0:b0:3b5:87db:f99e with SMTP id n13-20020ac85b4d000000b003b587dbf99emr7324650qtw.39.1675789054710;
        Tue, 07 Feb 2023 08:57:34 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d136-20020a37688e000000b006fa4ac86bfbsm9869962qkc.55.2023.02.07.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/7] btrfs: drop root refs properly when orphan cleanup fails
Date:   Tue,  7 Feb 2023 11:57:23 -0500
Message-Id: <b9dd48e9449bc86abe3d05d3edde41636dd61106.1675787102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we mount the file system we do something like this

while (1) {
	lookup fs roots;

	for (i = 0; i < num_roots; i++) {
		ret = btrfs_orphan_cleanup(roots[i]);
		if (ret)
			break;
		btrfs_put_root(roots[i]);
	}
}

for (; i < num_roots; i++)
	btrfs_put_root(roots[i]);

As you can see if we break in that inner loop we just go back to the
outer loop and lose the fact that we have to drop references on the
remaining roots we looked up.  Fix this by making an out label and
jumping to that on error so we don't leak a reference to the roots we
looked up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b9a02163a891..c828bd987c23 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4380,12 +4380,12 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			root_objectid = gang[i]->root_key.objectid;
 			err = btrfs_orphan_cleanup(gang[i]);
 			if (err)
-				break;
+				goto out;
 			btrfs_put_root(gang[i]);
 		}
 		root_objectid++;
 	}
-
+out:
 	/* release the uncleaned roots due to error */
 	for (; i < ret; i++) {
 		if (gang[i])
-- 
2.26.3

