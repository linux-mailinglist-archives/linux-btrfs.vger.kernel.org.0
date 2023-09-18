Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387187A51D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 20:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjIRSPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIRSPo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 14:15:44 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 11:15:38 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57355a16941so3142055eaf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695060938; x=1695665738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6MSWQI+MIkF1w+Z078q3MXLVVJ4Lm0KEGpGyEzNQDY=;
        b=lxGR+hG4LV9oVVqj38pTvVmg7pvmgiD1++DnCJ2cjSlpeZzyYJen12Jx1Sw9e6J5L6
         nkSAijJiAv331o5GCJd3iCd1ewpD8N/Cmd8LxbW6/EqaRakvQrs+Q61NYE/WQ78/rM3v
         zDCgATF7zIlzJGY/Xi3WwbxDicraKDxNG8j9GEllTNv8FHcPPKbELGBpqrAGQs5QbKKx
         96Unf3cYHSdGDjpsSLsE+FfQz7Ej65nc4WOufQCisSybIZOlcCi6xmky2lPf9buRYeCE
         XNlKdZvIEkP+Ox2lEh291K5GlJxuFOAEx10A6RyExl8UeDwPaTq5WPZ82ukXX3jA5Rbo
         caSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060938; x=1695665738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6MSWQI+MIkF1w+Z078q3MXLVVJ4Lm0KEGpGyEzNQDY=;
        b=cjGfSaZkisPhcIUp7tepZ5C311XotValP5m9DyldDWzhZuVwqReavBJERT/t1Wq4Je
         jWYpwCExtO5XLv5myw/CsM2Q2MFsIYCoshD3YCJiESLtuvV6N8dRV9OnMTUw4QBIAKuL
         brMZsaDPzfPkRrSs/V3swjwDsVu6sWCk2PNQrkEK1A25g8p4iUB72QUQRyphUCMdVyPK
         aLTmf2Si/T5Yzj8/7VuiHexyOvD3bJwG56NuZi3AvhG90IuX0jJO92oXefiFCPx5QWD3
         MN17LwWXwco0hZO6LADyaR21S9WGxMZmggORecT18e+CrKE+Rea2hV0IcCtvnJ6SojVS
         XU7Q==
X-Gm-Message-State: AOJu0Ywc5WhZlmlKKEmu6zqbbouchgN/ViC9lP5L4ei0MZqwB0QKj+uq
        iJn8UNi6TTDzArseGv1TPqSybBv+9nTtg9N+BtNu4w==
X-Google-Smtp-Source: AGHT+IEt93HaLWu8/xO9CFbAL7z7c7Go5OTBCT9M6zkHYF5Gam5WaG0o6UHSAFdRwyQMVXytM1jQqg==
X-Received: by 2002:a05:6358:2616:b0:140:f55a:ad41 with SMTP id l22-20020a056358261600b00140f55aad41mr14177611rwc.22.1695060937847;
        Mon, 18 Sep 2023 11:15:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b00767dba7a4d3sm3327185qkk.109.2023.09.18.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:15:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: don't arbitrarily slow down delalloc if we're committing
Date:   Mon, 18 Sep 2023 14:15:33 -0400
Message-ID: <801c5d3726d8370a7889118b5ecf15f30fb6b9bb.1695060918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

We have a random schedule_timeout() if the current transaction is
committing, which seems to be a holdover from the original delalloc
reservation code.

Remove this, we have the proper flushing stuff, we shouldn't be hoping
for random timing things to make everything work.  This just induces
latency for no reason.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 427abaf608b8..0d105ed1b8de 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -322,9 +322,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	} else {
 		if (current->journal_info)
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
-
-		if (btrfs_transaction_in_commit(fs_info))
-			schedule_timeout(1);
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
-- 
2.41.0

