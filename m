Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A57785A97
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbjHWOd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjHWOdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CBE6A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:11 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58df8cab1f2so60460987b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801191; x=1693405991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3WjlWJTqtg9G6UZScCYtaSBsl+hxchuVIWEshBORPw=;
        b=ZUUjIUNo6VQNgpq1MiepagRrEbi4xdBUhHftd1wD6aOaKmUbE6RWZHZsxkZd6MJM5E
         hvUFY2wiWS96C8273HLxfs59X1MnoVEGi2YPyVsLc/f1Hgp8JDLyYYkrku7TD9H/u0EK
         IzPy1StIa+a8+DzQzkc1hE1G01dDyjANU98rSLSVfPm6YxiVFmqUyfZ7I3sryCAhpJCi
         AVQQBOQ2IwOq96xQ9tJrWHOAERhYeYvoBmCq9Q1EApyLXogfbp7OLrRoWIvYjTXAO7Z7
         ZlFExdcygPBME+iVYfc24GgiP4xizq2SlIC90Gh4oK5IcnUQT/LuvkdIbGtYFli3wkbQ
         dzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801191; x=1693405991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3WjlWJTqtg9G6UZScCYtaSBsl+hxchuVIWEshBORPw=;
        b=YvpeE4EzW2jgqivZ9Bk2nTAJM4V5yk137nWMi8piv/MXv/kFSnFfS71vMskLihokVS
         JluyRRxVdQuTA/Zr0ph3fbMqSPmzJH0WCDmn7Sz4zQouvQXltIto5kSFsHAduqLQrid4
         Zc35dsAqvlea1natw/7Cahfpjquh4Sid7YBzYNSO7Ay6Mbk3ZHw4g3mBO/aCReizco1f
         XnjrENAH6L20u5C7FhuYXsXrpbboMZpe/OsQIeh/JE5FqSe07PVrTTXJwvhgr/SW3X4k
         L5l2F9AFZOZOv5Rg2w2VLWBHTut1vpDREqI7LbpDb8hYmBDLgRVhWaAa3KCnpa2eyA89
         4G8w==
X-Gm-Message-State: AOJu0Yz0JxWizbP5yIZ6bErtkR9CNtD+xsG/dLIojZDP9bfZMf49uoSN
        PGDTMMpraHEXrxSSq4CQOXHZYe3N99WEfE4/9m0=
X-Google-Smtp-Source: AGHT+IGmGz90btFb+LEpiZ6jDn9kI7wemxx8EictlhNzW+anINsrTJLlCCJRaLnah2WeOMR31PmdBw==
X-Received: by 2002:a81:478b:0:b0:589:d617:e7c4 with SMTP id u133-20020a81478b000000b00589d617e7c4mr12314788ywa.16.1692801190834;
        Wed, 23 Aug 2023 07:33:10 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k125-20020a819383000000b0057a8de72338sm3339966ywg.68.2023.08.23.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/38] btrfs-progs: remove useless add_root_to_dirty_list call in mkfs
Date:   Wed, 23 Aug 2023 10:32:28 -0400
Message-ID: <34ac8f222d475d692faa8d325cf63b5196912644.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are calling this when creating the UUID tree, however when we create
the tree it inserts the root item into the tree_root, so this call is
superfluous.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 1c5d668e..1b917f55 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -789,7 +789,6 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	add_root_to_dirty_list(root);
 	fs_info->uuid_root = root;
 	ret = btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
 				  BTRFS_UUID_KEY_SUBVOL,
-- 
2.41.0

