Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED807E2F7D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjKFWIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKFWIq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:46 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0710C1
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:44 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4ac28cab4efso881404e0c.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308523; x=1699913323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn4wfDb6jDre0GFiLqI3t3dfv/iDXvlKvBWKVyZYNgA=;
        b=ysTkbHTU8iID+jD5wYajxXB1YHDYloGiFBgfOiB7r0byuSyXPAzdEfi/oUDV8UyB5S
         3SgqrJXiNJ5VkAY/LC8eFo9E7/33+Qd3zAeZXrw23NpK20WUNT5Q9+qNVB11iGcpGkOB
         FtP02TbLWojHGW8cRdlgENI+2q32QA6ZlxjtQEPJOe6m5wxjzv0sBubS3jFub8Vjpbm2
         aGdTu9HuDSycDvERVVzkCRNVuGefZtQfY7sC+bNz/3pzIxjHEFKlivmCBpcmZscN6bIQ
         bmP8BXLgNlicVA2+WS6x0mbmR6F1XQcQZmlwe2ojELzTdGZvg77Fb1nqvZYnp569kE9X
         aDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308523; x=1699913323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qn4wfDb6jDre0GFiLqI3t3dfv/iDXvlKvBWKVyZYNgA=;
        b=MIqAL7UyAvE057cBlDKPs195CCNV3+oNSbzdE5ZXzv9ZwatSfBK16ppV84PxRyqU+u
         qVl8ZsRVIEeZHD3Yp6cSy4+2/37U+3xy6mqipRJJSiWzDL2Kj9cHWJ+XrNywLViES2qH
         uLeDNJBjGtPG18FaL3vpIduGIUZ9r+cnA8OhbuGpW24QW8f8TeWNBrg2bc6g5RB3Vwgk
         q91gTgjelsjZAMF8kE+PT8w9mIDDPyuXckfK3dYGAB4fwT1mSjA8lanIg/nanv6IDiXs
         aEgPuODfTJ7FGqV1WKzCEjcMuJ67cL6nXdfEmzBeJfJUNH2JyF3vITJWzI6GbCLH366d
         aUTQ==
X-Gm-Message-State: AOJu0YzOu9VnAUivHQ3KxGPHjUx5qSkY71cbDODhTpn25GGXMhFapN4Q
        R+GNjgE+kiccw8pzfvopGHHp2/PB4RUCRHmlphR/pw==
X-Google-Smtp-Source: AGHT+IGzjDwWUkB8LX7DQ7zorH80M40pkRDuP9BnGAXmsOru2oCKSePCo909yhMYibpvOivXGd/7UQ==
X-Received: by 2002:a1f:2c15:0:b0:49e:2145:1651 with SMTP id s21-20020a1f2c15000000b0049e21451651mr26913118vks.6.1699308523102;
        Mon, 06 Nov 2023 14:08:43 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id df1-20020a05622a0ec100b00403cce833eesm3744457qtb.27.2023.11.06.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 07/18] btrfs: add a NOSPACECACHE mount option flag
Date:   Mon,  6 Nov 2023 17:08:15 -0500
Message-ID: <7723acf40642ab84b48f25f31e2894120d035b5d.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the old mount API we'd pre-populate the mount options with the
space cache settings of the file system, and then the user toggled them
on or off with the mount options.  When we switch to the new mount API
the mount options will be set before we get into opening the file
system, so we need a flag to indicate that the user explicitly asked for
-o nospace_cache so we can make the appropriate changes after the fact.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/fs.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 072c45811c41..c70e507a28d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2938,6 +2938,7 @@ void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info)
 {
 	btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
 	btrfs_clear_opt(fs_info->mount_opt, CLEAR_CACHE);
+	btrfs_clear_opt(fs_info->mount_opt, NOSPACECACHE);
 }
 
 /*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 318df6f9d9cb..ecfa13a9c2cf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -188,6 +188,7 @@ enum {
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 27),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
+	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
 };
 
 /*
-- 
2.41.0

