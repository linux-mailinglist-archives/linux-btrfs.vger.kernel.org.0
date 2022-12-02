Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6143640A9C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiLBQZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiLBQZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 11:25:19 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9ED8251
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 08:23:39 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so5830791qts.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zR+wcIjVpZsnKiifwbYF/BqeZOXhy2t5lXkSBcTHWb8=;
        b=i6On12NHooVLxoK4a5pACO1T2jUx51cPwDmyAsuIaxotfrprQY0/mld00pOxnTGiZY
         DaSSImdgYKPxWqieuQcyGAbQwzyxcLO/41YgymXzw9xgfmJrCtGR70VcqgkcxRd+ejMY
         uPbRi6pFdW2UaZy4EEYs3EJr84BXMIhLnrMZZCxfTPAemSEwh60qMAhoXnigeNj8MFFn
         rA8L5nF3/z/wNIJTK7QCyOFeM36cZPHfdqAw0+2nLT4v0Tsr+AX3gsekom8Mm5loQRTf
         8hKJK/Db0YHAnnVV2NMHQWoOyFES03z/trW1TzfQ7Fso1LIqZJbyV/sH1W0g9n15HFZC
         qvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR+wcIjVpZsnKiifwbYF/BqeZOXhy2t5lXkSBcTHWb8=;
        b=k15Kqr0/OEBZuL+rhPX3MPJoTGLbdISi0QCgai770t1z8N5FpToxHrSFjz37AGYuBm
         3+fifAcU4Gx/ktr4Ca9j2i2sGC+yQ+3akN7gPGdEDhWxGXPnPizf/UeTdcDRNHhTwMoX
         sAtxBUBlVEz5aRrlqvL2jfweUOoji1O8mDFh3dZb/Jg66u/Y3GOFMq60G4GDGB/X0Lhm
         QolD3IK9Eko4/hD9dbWVmLLWoTAMpZKC0wMrw4Lb9Ir0MAFJOqQf3X63MNTS5+Buiydq
         L5tzVP1tDe54ObZQrLq36NT4Rb6BgkG3s4mzQ/iGe8LTPnuEJI8Gl9TaoudVxg3+o6uO
         EKCA==
X-Gm-Message-State: ANoB5pkBK3UmM1MthB5DP+kXNyRmUfAgT8r1jak9Y9x+QeWDzVHNsKpv
        sOBgISxzG7hlOaPi5c9ISEE61cSH/AeWKkBi
X-Google-Smtp-Source: AA0mqf4GCCzKCviUCDgAR/dWkYGlsAMTArpC30pl/mQpgJN8EJxfM9K4M5dmHwhyBh2R1mjEYJdsRw==
X-Received: by 2002:a05:622a:6002:b0:3a5:8c9a:638f with SMTP id he2-20020a05622a600200b003a58c9a638fmr67776590qtb.350.1669998217588;
        Fri, 02 Dec 2022 08:23:37 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05622a22a800b003a57a317c17sm4336147qtb.74.2022.12.02.08.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:23:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 03/10] btrfs-progs: move extent cache code directly into btrfs_fs_info
Date:   Fri,  2 Dec 2022 11:23:25 -0500
Message-Id: <322034b1f62644fa4f357a47cb81a036239e366e.1669998153.git.josef@toxicpanda.com>
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

We have some extra features in the btrfs-progs copy of the
extent_io_tree that don't exist in the kernel.  In order to make syncing
easier simply move this functionality into btrfs_fs_info, that way we
can sync in the new extent_io_tree code and not have to worry about
breaking anything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 41a2822e..016aa698 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -673,7 +673,6 @@ void free_extent_buffer_nocache(struct extent_buffer *eb)
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize)
 {
-	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
@@ -690,7 +689,6 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start)
 {
-	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
-- 
2.26.3

