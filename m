Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893C2189A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgGHOA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOA2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:28 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38314C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so39064693qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNbN8KMVo5bDXJEMK3qzoB8OXC6pwWVBEBIb751xZOI=;
        b=IA537qQ8wthXj8g2awpJT0dhFUL5ItvTPhENcIqnusr9jr3ROVoctOOFdzNQw3T1ve
         UA+clttSTBhM04566doF9om4eGskRFNA/V1SMXsMp5xB/ca1lmezcdg20n+Ub1rM4Kt7
         oJX3MG95y55cu/COYdFtYYBa27jd0gjZ1yzE73xoXD9yXZzQfZZ/dXDybsgkwoB3tQZI
         sbjyj6u+yufG3YvE9PEdBHDQzfyWnZRum4bLtiX40mVXSZG5iMWBJKC9MeHul3WaT6lg
         9SQMpOe48Puo5VmoFhas7l5Fy0LKiM/xyxcd0ZnfY1236TYNY5PHGj1sZpSqErCCOFug
         rEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNbN8KMVo5bDXJEMK3qzoB8OXC6pwWVBEBIb751xZOI=;
        b=jrcypScp4YB/udgoIcvXiBDkONGMyvwRHGonIoTfEa5XNfOeB1muIJFEQrVcOZx36I
         vwhN/ZYVbwxgTShSyZHb6RqE8ZkWhU46kDg6ep28NjOZy2oKr3Pmo5y0+zo2tRtL2p/h
         uFOadI/GFQrOynewvezoG8HZdAA9pMw/6NGTz64NwZuoPTe203Ci0U+6YSEJPdqvaIGI
         Kih5lsYP4ByouDgC2e1S4pUiZ2Gh/GA1mQ4N/l95igl9bQWuanZ2hIWZa0s9wjONdArn
         luofHFoKZmYN/cdXMsCPmshgLtHqGJQwv9TbYzLJqO3gPXHcgyV6I+ZXQ3MyxwKiXWFd
         qAkQ==
X-Gm-Message-State: AOAM533OB6aFCyWLiynMiUb2XYtg5pC2teT7g1SQUd2uXR4j2pvQpdQO
        SRBzxJyyCdw4A6pEPx8znGm+wvwcUDSprA==
X-Google-Smtp-Source: ABdhPJzgk1ahwuIb5F4sQVaA2Rc5antjYJpoqpRRIFnHt7XYlgB10aRjlJwhizWcv9bVN1s/DH2l2w==
X-Received: by 2002:a05:620a:15ab:: with SMTP id f11mr46332871qkk.199.1594216827066;
        Wed, 08 Jul 2020 07:00:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m7sm29263827qti.6.2020.07.08.07.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Wed,  8 Jul 2020 09:59:55 -0400
Message-Id: <20200708140013.56994-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have traditionally used flush_space() to flush metadata space, so
we've been unconditionally using btrfs_metadata_alloc_profile() for our
profile to allocate a chunk.  However if we're going to use this for
data we need to use btrfs_get_alloc_profile() on the space_info we pass
in.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1bf40328b0ee..8450864c5b77 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -777,7 +777,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
+				btrfs_get_alloc_profile(fs_info,
+							space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
-- 
2.24.1

