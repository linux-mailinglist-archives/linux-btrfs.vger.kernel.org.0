Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F32A9F15
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgKFV1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgKFV1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:54 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB03C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:54 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id n63so1830091qte.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OJO6SFTTfo2kgWAfwGVLuYK5RZu6WGsjbnhNGtEilL4=;
        b=ITN4fiM3os9d/Y2HqIEj8a3UNWe3dTUq11JIQuq6rKP0lxJruOf8x595a9Y4oeOf2Q
         Scc1AIM5l3Yup8KFN0genAqslMxR84SgtH6UrNqeyYNWeqEJloTeeTzRaklFjG6qaYlV
         VaHb34i2AMIqoWZLIpxNhXtsRDYRjy4R9Cx9q6hPB/Lihc+9GsVoVXSU7rOY7gbEcSMa
         fYjbKPOhNgGRE/VMrDwRisAKWNcHN+qtIpO1qDVEjTq/s0xP5xeMXA7n+9JB3/15mYR5
         jZ3VzZiwD7UgazMgcwJFbb9udeMu+/7qR5uBUgBEYyRLH5qtyx7GaDt48n8Hmhi9cL37
         lh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJO6SFTTfo2kgWAfwGVLuYK5RZu6WGsjbnhNGtEilL4=;
        b=b3bFCn3FQ2WOaWubpvYKvyzYISdyySNko4uiGz1+8McexggNtQ7ErC5N2JTNff9aoC
         dWVDEKZgUZDTENQLMtVyqfIegg1DZPGGrfdJeqzkP9W4Lk29BZPfs9kXHiYDqkMmMvRZ
         4li77D5dW4ORmRLOhMXsXLyaRVpBsBrb/UvVewIXxv+wKQVEAsQaWWYLgCmvf0bHEkiG
         05/6mcFD4/xa5PUbb7JajS8MGuL190vFvLUqg3+IIgUjj4U65x8BTN9uxm7kgjevjpDE
         zm2UqpviajfRXsn253eWKyDI8LKJMHycwON2qERZIco/2h27hc4/b7hnaj5vnKYzJXbA
         ZNdw==
X-Gm-Message-State: AOAM532yufJSFuLdXTFFM9ehpK+B3hDX0LZK+JuQj4rbfmchu8eJWKic
        GGZYpByFtADuJGwqo9hIdMP8r4/U8rvXQdvm
X-Google-Smtp-Source: ABdhPJyYcAGdwRhH7gk5Fzso4Gfg75pa2pt9njIypRVeIZrKHcFplm/bYZN4f00z/OQMKzWQOb23vg==
X-Received: by 2002:ac8:2af0:: with SMTP id c45mr3594324qta.4.1604698072962;
        Fri, 06 Nov 2020 13:27:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v16sm1426590qka.72.2020.11.06.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: remove ->recursed from extent_buffer
Date:   Fri,  6 Nov 2020 16:27:36 -0500
Message-Id: <da026377e9de7867dd377005cb9ddd6121651348.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is unused everywhere now, it can be removed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 1 -
 fs/btrfs/extent_io.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 119ced4a501b..32c2000a2269 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4955,7 +4955,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->fs_info = fs_info;
 	eb->bflags = 0;
 	init_rwsem(&eb->lock);
-	eb->lock_recursed = false;
 
 	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
 			     &fs_info->allocated_ebs);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 3c2bf21c54eb..b0bf7f75b113 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -87,7 +87,6 @@ struct extent_buffer {
 	int read_mirror;
 	struct rcu_head rcu_head;
 	pid_t lock_owner;
-	bool lock_recursed;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
 
-- 
2.26.2

