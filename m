Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E894469F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhKEUsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhKEUsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4DC061208
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:45:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p17so8786380qkj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UmDPx42Lh0e/mAEfjAlWcp+fHjd7jEd5+SgYFfM0DRc=;
        b=ec3VP9Udyqu6EiY/sx0tpRZy2EadoZcZijduf1M0euEFc3T1wVX+m5GJmwgQhptvH8
         UsZhW23PG4p+Uwdad8noD/8oJ5+ANTMmRvdG8sAQJNlYzm0fGFlRAV+XOhslIkVtksIr
         WKA+3Us33aU1M+e/taPtV7++uBsaL7MXlo1f9xI0dXr+w1Mi0b+Fn8RIR9iF7Mh764h2
         3WBWdHGZ2Qz9NBt39mJe/SOODUQDjixJhHjPsrXDIqOo/fA2BYMh0plNDosSZfToLrwF
         vnigmVL/Jn9W+cEhG7relR+4GkSICPz+/NlMy1yI3XOLJMDTWxY9llO1tNTzSxXu45tl
         cB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmDPx42Lh0e/mAEfjAlWcp+fHjd7jEd5+SgYFfM0DRc=;
        b=zzTZo10u0pO8ngqQZVMEmr3dJWhBbrFz/dmi7hv8Eeyp3Ucbs4wgZ7BywPNM4DnU/U
         Y6Jv/9F2y7LmUweT+IyBuL479rOYhKN1Ht7MdKGyNOyFH2sThLZq9hDPDlHXxdvVrTSq
         Cx1X+FFWG644i0fura+zspUmfm/+oxvif/wN+dcrzsIuxZdWPxkGkJ1/zEz0XqYVBHcJ
         OPQBIlCM2Cxl0qHmC7OQP7MikEFHqSimAwzuVb/7O9v6Dvm4i+JeF61/yBPpGOK20nJK
         snpxRc5xDWZ+T1Dd67P+y0lADqIaUyB6lmb+yrcr4qbmQNj2eKbpAQ8jLyl1Tzi/ZdtM
         KdLw==
X-Gm-Message-State: AOAM533l9awvuH7ly0rGTyhPMjOxQoQY9AMfx/mnngtbMSdB6yRp4DUR
        t3ECwBdCjq/K0pmIy37c6SGEVA8mgJu6Aw==
X-Google-Smtp-Source: ABdhPJy8jWFWVZlcYqHBMD3FYdM2Cha2+r/jf/8oTLoJf9+PEI2c2ETdG6QcWMiwtWJflnWRN/7mbg==
X-Received: by 2002:a05:620a:458c:: with SMTP id bp12mr5462265qkb.409.1636145154185;
        Fri, 05 Nov 2021 13:45:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o6sm6733519qta.2.2021.11.05.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:45:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/25] btrfs: kill BTRFS_FS_BARRIER
Date:   Fri,  5 Nov 2021 16:45:27 -0400
Message-Id: <5ce10de7df0ace8ee6d03d2bd6d8f89d7f2bba11.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is no longer used, it's a relic from when we had -o nobarrier.
Remove the flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 1 -
 fs/btrfs/disk-io.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 01f6a40ba2dd..ce48ff69c77f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -548,7 +548,6 @@ struct btrfs_swapfile_pin {
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 
 enum {
-	BTRFS_FS_BARRIER,
 	BTRFS_FS_CLOSING_START,
 	BTRFS_FS_CLOSING_DONE,
 	BTRFS_FS_LOG_RECOVERING,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5be0ae67ceb7..8d36950800f4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2949,7 +2949,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	extent_io_tree_init(fs_info, &fs_info->excluded_extents,
 			    IO_TREE_FS_EXCLUDED_EXTENTS, NULL);
-	set_bit(BTRFS_FS_BARRIER, &fs_info->flags);
 
 	mutex_init(&fs_info->ordered_operations_mutex);
 	mutex_init(&fs_info->tree_log_mutex);
-- 
2.26.3

