Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1F2281F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgGUOWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgGUOWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:50 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F4C0619DA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:50 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so9379470qvl.4
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ7lo/YjPXPkf8WRe8W+IM0Yjaw2kJBnqKt0TZMFFFk=;
        b=uesFhMFReD9NiWgCn6EmSL+Q0LAmdah0w+vLyuu1Vsbxs0qqe01q5GYXTIQUGmseVL
         P+uhO2j6nc7F0fqugMP0UcKzLcyZfTtAFbCs39wGJC1zBnM5tgkaZkSSUo1Vm5imfEVN
         bS5uJEMrfW/YpKWho0lmxdwD3GYeBt6wzdLVKt6djui3qDuHHd2ZKJGTZyDO3pPJC2F1
         7hTfAPgEcuqGB7YzZR4l4OyoVT0l7OVc6xvqCAZppgYscLF4BwYKWKrgq7I1VEnOVRI5
         +v1Yl72OjX3TA3q+GpWFWvk0mLtRbGSSZGWd7KpySGVB29XgXeceiyPFKy2T5tDMIfmI
         IkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ7lo/YjPXPkf8WRe8W+IM0Yjaw2kJBnqKt0TZMFFFk=;
        b=fFtNOu8wia/ghfGCvnBn4PCLCsFCLafpR13OPA8E5K1M7HEaOYp4nXzJM/LX5Kj+du
         VF3v9mFGsk8PkNa/pG6HhNYqgE8VEhFypL9Wm12HtR24YaOdOJMsTLzmFw7qKbhViLcR
         qWswt6nX8VvOtfXh0fEwQGGyMrE/hEoHy0DMuhhmdSG2I2N2VR09EDzd3HLrnqgOYVgz
         gLgZPcrcQ3jamkJLyoa+KtuEEQicDcjP9hKEK7zOaTY928wFeOCLodhKlmgE0Wmh6OX+
         Plg3oOelpvjo9eXBhvdZLmaFeyPemENHVbUhj+ahgKTqvqT7w9gzROoOyFa2W0dyWw9t
         9dyQ==
X-Gm-Message-State: AOAM533/DNqF+NxaBdRwTmwxzKAGT4t6btZkpukc43jMpkcMoYPKnDPz
        VVxKnPtiaMQ48ItZw35/Iacfrrex0j1thw==
X-Google-Smtp-Source: ABdhPJxcFeJfEX6Qaj2clP4Lu4ZwszhI8NzXpsBqL00r1t801q/WodnS0z3adQRddmPcHFNAvIxmlw==
X-Received: by 2002:a05:6214:13c6:: with SMTP id cg6mr27150854qvb.160.1595341369590;
        Tue, 21 Jul 2020 07:22:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h144sm2050507qke.83.2020.07.21.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/23] btrfs: call btrfs_try_granting_tickets when freeing reserved bytes
Date:   Tue, 21 Jul 2020 10:22:17 -0400
Message-Id: <20200721142234.2680-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were missing a call to btrfs_try_granting_tickets in
btrfs_free_reserved_bytes, so add it to handle the case where we're able
to satisfy an allocation because we've freed a pending reservation.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 884de28a41e4..725bf0f5dbe7 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3043,6 +3043,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	if (delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
+
+	btrfs_try_granting_tickets(cache->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
 
-- 
2.24.1

