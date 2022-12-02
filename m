Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC7640A93
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 17:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiLBQZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 11:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiLBQZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 11:25:18 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A686D824E
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 08:23:37 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h16so5830638qtu.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d1ZE6skIP3xg+yGy7Af1MGbhQA/NVcjzisFM/37xAx4=;
        b=VaMab58YqQ5L0AnnYydi4ONmI6PaZ5TgwY1v3jEaZxt5FVj40Eer8K3Q6SkSCU3z4s
         T86XP5qGqdPggGEpmqaC9/2fXFjVfjFGkVThDV9ZHyRycXGGGsxTcFHKPLo2e+udWMNf
         awTYEGGthwE3StuXhEPKx3WsmskmQ5sOyf+IqYhIfMcGu4gfKrNY4Lo6JamLinAph1jh
         KcMd/CoBIx/x6eN8A3ww+CHOCru7DcieofB6V/lCrS0BONKWNXvXfhka/9xwOhugVDFl
         So38APfqb65fZ8A2xM7WmH2t7JXOkJvXdC1INo9EJCaH2iFx5S0KA2BJtjXrbLXYtgU8
         WW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1ZE6skIP3xg+yGy7Af1MGbhQA/NVcjzisFM/37xAx4=;
        b=rghW84GqNdNi5EOW4mzONekpp6mJnTKIxJancKnt3zcpg4YBs+bTgOr0JZ0yWAAEWF
         aqAALmP2JUxjn3iA/O06p3c9TJD08gNCYeg/FI/BPh2FGx+niTMStwIFt1tfvNGJ/3PX
         HAINqvtfEGqXpFWahlqRwTSHkpxkMucROvoKNwNAhpstRuQzKOdp0KR7PRPNByoPoKAn
         t9Yi+qdU98GQ4E+sh8UBRsS/y211eI1ycUh/P412jeP9MLgYlaB58QRzTV7q7GjWmEYZ
         CUdEkAYmRnt+mEHE6Vk1jxIZ9CWf/BCVF+2M6SYXPOWcy00/NspHhpGwp5WNn9fFcnCe
         rI8A==
X-Gm-Message-State: ANoB5pkSJfISy7E7kpj3a+nM9TVvtrIZv15kt80HMhiiruHLe34a5lK8
        Grne2/+19iQpjSYtJ004gm2RXhtu+fZp3sl2
X-Google-Smtp-Source: AA0mqf5/mffObcK35oWvOMDHOV9dkyuHL+zAUhMqTzyVKWTnFd8LWyiLPe8HhJ9yVPFJBpVm7mEeLw==
X-Received: by 2002:ac8:74c5:0:b0:3a5:2bd0:67a4 with SMTP id j5-20020ac874c5000000b003a52bd067a4mr65860309qtr.428.1669998216191;
        Fri, 02 Dec 2022 08:23:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id m19-20020a05620a291300b006fa12a74c53sm5850558qkp.61.2022.12.02.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:23:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 02/10] btrfs-progs: make the find extent buffer helpers take fs_info
Date:   Fri,  2 Dec 2022 11:23:24 -0500
Message-Id: <033c73d93c93b000d29f657c4990855975129f16.1669998153.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669998153.git.josef@toxicpanda.com>
References: <cover.1669998153.git.josef@toxicpanda.com>
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

This is a cleanup patch to make syncing the btrfs kernel code into
btrfs-progs easier.  In btrfs-progs we have an extra cache in the
extent_io_tree that's exclusively used for the extent buffer tracking.
In order to untangle this dependency start passing around the fs_info to
search for extent_buffers, and then have the helpers use the appropriate
structure to find the extent buffer.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 016aa698..41a2822e 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -673,6 +673,7 @@ void free_extent_buffer_nocache(struct extent_buffer *eb)
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize)
 {
+	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
@@ -689,6 +690,7 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start)
 {
+	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
-- 
2.26.3

