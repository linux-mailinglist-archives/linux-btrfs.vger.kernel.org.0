Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291F32189A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGHOAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5807DC061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so34490509qth.12
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YK9+ywm77Te+pOZHuYGGFVXJb/D8KOylDb/tS2FRu/g=;
        b=ONHtMbPXgkJLdG+/lcpjGSQPz27nHoR8UM9UtiQJf8kiWTDLs6GJdDXfYegk8+ZqN7
         5wSj0XITBkax4DO2XB/c+ho7XjbrNNH8hS1chmx3sLYumjDc3A6Ve0mFLrGFJm3kC95+
         PL7dZeUu6sauh6Iy/csRgePJs/aoha9KozGqsmOMZKIY3lwYiEiIR2ORAJxQYefbrJQC
         aMkZFQTASGRThm2JoXbfULR526/cDKKmgvcZiOHN3PpsUnhKBGJ04RatwJ4NieYRU8+l
         mFYGrW6Ws+y4zRALh5uf9ps+Ou3GZawHfm1RCYmtk14KEiHmdBKTWMQBV/Y1TsfOBQhD
         g9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YK9+ywm77Te+pOZHuYGGFVXJb/D8KOylDb/tS2FRu/g=;
        b=Dm+pVrLrsahoOfN/3ytdTCtfejCIbwR6UGHHJfkBvekzVXnQKNWz/JlCfpax7aryml
         fDMO9Rw1l5i2+oMo9Zf0O/ua21R1NtOyqypmufVmRA6W+/BzVNRoUWBRHOdEie0Wml16
         +XDQBa7Iq6rlJYXejMLcgh+DCJH2TG/6nvVIt4p8youfdkP4GWqxYEv7hgxeFvRVwOJI
         QRXDwutu5obicCGMgrpHjQx5FFzDzIH4VAknXI8xJYjKx+hm3GctQyaoceZtrTq4J+z5
         CsiTVToMX81QRvQ4MovC/OgAUOak/VEak61c2vp6BG8ktdJ3VhM6ZwCfSz/LwADZX46s
         PFIg==
X-Gm-Message-State: AOAM531LJhuuZRjuX/tS3FpEIn99PiFT/+wW04AwJHELtllhffUtvzI1
        aoZ5m5tntzZZqfpXG4pk9D2JmzaajYUOAA==
X-Google-Smtp-Source: ABdhPJxvYNnksohRteOA4NFZVK3KHNL1KpOytIxdYxd4Nj+sOsVnYvKKxKzuiGlE/JiNeRPJBO0hCA==
X-Received: by 2002:ac8:1305:: with SMTP id e5mr60425904qtj.78.1594216835258;
        Wed, 08 Jul 2020 07:00:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b53sm31248752qtc.65.2020.07.08.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Wed,  8 Jul 2020 09:59:58 -0400
Message-Id: <20200708140013.56994-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have compression on we could free up more space than we reserved,
and thus be able to make a space reservation.  Add the call for this
scenario.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index daf88891a40a..c7097cb4fc7d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3058,6 +3058,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 						      space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
+
+		/*
+		 * Compression can use less space than we reserved, so wake
+		 * tickets if that happens.
+		 */
+		if (num_bytes < ram_bytes)
+			btrfs_try_granting_tickets(cache->fs_info, space_info);
 	}
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
-- 
2.24.1

