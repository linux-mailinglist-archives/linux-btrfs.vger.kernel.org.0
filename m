Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DD6F2638
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjD2UHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjD2UHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:48 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF642D76
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:42 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-559e53d1195so9484367b3.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798861; x=1685390861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqjrnZ1dA3CANgG328lrX4wRimOWh+0WQMQv3a3TsXI=;
        b=4LKhIwJ12223z4avC4n/G8RbAHPuewdr0jPPewFABpvv9A7p3IpNxA/TAK5CJjHTyZ
         sroLlCjWU9sS0OWNPpbPSORzHpfKUetFjEdmLJsuGIuU1Scy2KZb4+kJ0kF4n2xB/W2a
         FNwEdC4Wg85Wdml18Nj0CIUs+5ME90+WhaXclIeuxk27/hlZt3HRPCIM7FoZoW1CLhRw
         byOJAsHTifYHlrBGUD8rLjk0l9HPCMRMr4yldNnWmVD03KaN6jijnJiNe0WuUBiULnkC
         i9ilUuCOhvi8c5Sl4EgPOFTeAK5oWmIEY5fQWWTyCQXcq09RQWai7YYWHhX/XI2WjVI5
         6l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798861; x=1685390861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqjrnZ1dA3CANgG328lrX4wRimOWh+0WQMQv3a3TsXI=;
        b=fXwCuK+TafNCGKCh6dfQ6B24ThzN7ft2NrsLADmhLqzl/3dflWY32qqPqWWDEkd9Kb
         If1qYDccpU/CZC2ugLDn7tyDMWLqENJ+dSxKJWVI1PeNgEJ5p3N2fXxtuvpO75Im0v+t
         gfwV7h8k7DkC8nz0bXXourrEY9wFP/CagxXrgPCFhqSA4T40r5aljIkpZ/4cJSFN6JGE
         xRGDR1PPtNhHx4Aau+mvW/44QSxinphzBb3muDALyt9z+UJjBd61KbwtUHRkMsEtT2mP
         GydVcNLn1ZxOE6AjInNzUIsd2iOVUEjPgBe0h0khR7EDljCe5urimFA2F011isQQWc+y
         PMyA==
X-Gm-Message-State: AC+VfDy1fW4p4uEzCrM0PVTxGqq8rqodu5Ad/ISD0TUaatyww3wap7N9
        rA3v3UH9XrXqQGMU6lvZRC35IKwrehP4q2s3/HoG7g==
X-Google-Smtp-Source: ACHHUZ4NpzoGEeYuzr1pJmqZXWEV7YcZR07mnsT3Oo25AMahh4vZ2AP1zJlPTfVRXBbR1wszYjlOyQ==
X-Received: by 2002:a81:6543:0:b0:55a:c62:3a92 with SMTP id z64-20020a816543000000b0055a0c623a92mr567549ywb.29.1682798861520;
        Sat, 29 Apr 2023 13:07:41 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b00545a08184e9sm6259623ywc.121.2023.04.29.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/12] btrfs: add __KERNEL__ check for btrfs_no_printk
Date:   Sat, 29 Apr 2023 16:07:19 -0400
Message-Id: <284c95473545a5e08904a691b5a7de55a3c5263f.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to override this in btrfs-progs, so wrap this in the __KERNEL__
check so we can easily sync this to btrfs-progs and have our local
version of btrfs_no_printk do the work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/messages.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index ac2d1982ba3d..99143bbf78a5 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -7,11 +7,18 @@
 
 struct btrfs_fs_info;
 
+/*
+ * We want to be able to override this in btrfs-progs.
+ */
+#ifdef __KERNEL__
+
 static inline __printf(2, 3) __cold
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
 }
 
+#endif
+
 #ifdef CONFIG_PRINTK
 
 #define btrfs_printk(fs_info, fmt, args...)				\
-- 
2.40.0

