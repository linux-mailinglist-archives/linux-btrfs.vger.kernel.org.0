Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22292281F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGUOWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF09C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:48 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so3509301qkk.7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNbN8KMVo5bDXJEMK3qzoB8OXC6pwWVBEBIb751xZOI=;
        b=ZVN7TBL74JT8zs7zSHjchXD2w2SmoE4ZuTwhlMwoTudhRn0VCb+13r5KTbs+ogoqM4
         oaVywgD+NYjb0prsa6xxgFkHgqXjFSoi4/cIssvu+WTBEY6SyTTO6FpL3jYJbX1Zviuk
         /YdieS0kR8UdYe+BAVxwnWgNXQ0F09g8EStOgRoo2BkHSIA0P+UdPq/XvPEFrWchVU3i
         881pcizzBm9JCHwGN5PA5fyzHx4UvW7sjZkKDkIyiiUCviCdkabYigjVuqTyHM97mGy+
         fJ036HgaEYjl+2usavG5v9rSfOH8c9jSf9ZpUeIGTsHZLzgMFcr6D01kIB+aaj0M57Wr
         /e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNbN8KMVo5bDXJEMK3qzoB8OXC6pwWVBEBIb751xZOI=;
        b=R2nYGFJb95RwXwu6KH5hfHzmUKFicvo6PCbkRglDKPD+u/eQ6byL3eE6R6zei1+bgT
         1XozJzQiAhYIC5RmeWpvmS+XKBcFaVjuJFJ1tCVNGpsMcNLVC02sJfrrhr1D9jCkcVxW
         lSHX771IBphGuOlv12/f4gAl594IPmTwyUu3Zlxu1VAhcDOHMb/36yi9Qys2rn+qHYVC
         NakkAODRStZiAb/YQdhD1Cfw2qezeOSfYc4X7yXjST037LO0aYpSa0GGM9mLixcV8/f2
         GinllouoYYzg9ldUuLsP0RXgm6RyPB/rbANfXn5nJgiEOp6QrAR92Iww4him1+3FblUd
         fiiQ==
X-Gm-Message-State: AOAM530HIc5gFRKeon20I7SWEN+CGDsUG0suup8dkN15Sr18YCmDCty7
        k4TdkcAgeAS8Hd0It5BSVF5DVii25mjISw==
X-Google-Smtp-Source: ABdhPJwkULvkQ0lymLZg/yqKCZG8F7hzXtLjCqq2go4yARZUtygbOgst/nwlsb8j13tST1W58RDEhQ==
X-Received: by 2002:a05:620a:1478:: with SMTP id j24mr10299574qkl.347.1595341367616;
        Tue, 21 Jul 2020 07:22:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d14sm22489318qti.41.2020.07.21.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Tue, 21 Jul 2020 10:22:16 -0400
Message-Id: <20200721142234.2680-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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

