Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D964F23D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiLPUQO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiLPUQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:10 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC114F64F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:09 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id l17so1657004vkk.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi7yDEePu3S4Igbj5SApT40uXZ+IL2v9Cf3SK7Kgwvg=;
        b=QlNDdU8S7jArd5G5DqbN7PmUdIFSjigAcUEsij0BjRIntD5TvsMRVM0UylOCm8OXZf
         EqXCXrimCrkVzfMtDs4Y2SnYAoTCVgfxpigDfpDzGX1QlRlS+lzjmdZQxzgDRk/jikkp
         bBLq+1jHgJlkxAD5RMIRLyeuBTrKIbtcXqPNurIYKoATw9BQmAItwT7H5lGBYIHy3TT0
         E2sKFqSBxQHXcr0Iy6kl5bpUjExhTtdsdyx8AgxHTwewPdiX2cLAZU1cCAIzvc6/VeX+
         Pe8Dj9dAUJdQXmWgzjZG3giKzoHaWVE8VCgkQZnZIx4+sEyFxvRw263WZgIcC5WmwJS1
         HSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi7yDEePu3S4Igbj5SApT40uXZ+IL2v9Cf3SK7Kgwvg=;
        b=nvDmN5wf9jjqqBhPuSslyCt6erl+joMZKJJ5bHanREuVce4CHoV2Q/fcTa9JAsMQP7
         r2j6i0zGqAuaTrgxMiqgS6NBRbKx3EQ156VuihGw4ajVfoedrRGKlRu2YUuD807C2lRm
         fDwqmFTRHhWMQbA+Qv5unNciQNrzRFUFOOP2nA6f9YPOo/tPgmBoGbRndrmLqCD+huoq
         uRYMhwcI/dJr19uJ4ubmnX9+fK81xjgySWlXxHrMLhOxLZq3etvUoFwX/BzinW++SyjX
         G5t/dwIPh5+/kPvyBI+1aoq3JTpk/cCrYPGHUABSCdasZ7ZySv1Szl+Vqoo++ffqVuel
         OcPQ==
X-Gm-Message-State: ANoB5pkBlOcFMYhYZ918wwvsGWzHF3yBiKkYJ+pt1/n8BnUp7PeV3b5V
        ktcEZG61S8owHHEakYsZLUkvG1tO9mJP2MSihsw=
X-Google-Smtp-Source: AA0mqf57VYKW9J8/QmbI8tpx4/8zAMvAJ0IyqJU6Vla2+H2T5hyRvMz493SIb4N5gnKFtrdIrkuRRQ==
X-Received: by 2002:a1f:9b87:0:b0:3bc:a30d:9248 with SMTP id d129-20020a1f9b87000000b003bca30d9248mr19517101vke.9.1671221767914;
        Fri, 16 Dec 2022 12:16:07 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a449400b006eef13ef4c8sm2205997qkp.94.2022.12.16.12.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: fix uninit warning in __set_extent_bit and convert_extent_bit
Date:   Fri, 16 Dec 2022 15:15:55 -0500
Message-Id: <02a60dacc01beb1ab14845f2b579e4b6f56c6359.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
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

We will pass in the parent and p pointer into our tree_search function
to avoid doing a second search when inserting a new extent state into
the tree.  However because this is conditional upon passing in these
pointers the compiler seems to think these values can be uninitialized
if we're using -Wmaybe-uninitialized.  Fix this by initializing these
values.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 9ae9cd1e7035..9e1f18706a02 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -972,8 +972,8 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node **p;
-	struct rb_node *parent;
+	struct rb_node **p = NULL;
+	struct rb_node *parent = NULL;
 	int err = 0;
 	u64 last_start;
 	u64 last_end;
@@ -1218,8 +1218,8 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 {
 	struct extent_state *state;
 	struct extent_state *prealloc = NULL;
-	struct rb_node **p;
-	struct rb_node *parent;
+	struct rb_node **p = NULL;
+	struct rb_node *parent = NULL;
 	int err = 0;
 	u64 last_start;
 	u64 last_end;
-- 
2.26.3

