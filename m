Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9974921581A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgGFNOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGFNOS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:14:18 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AB4C061794
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:14:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so28859725qts.5
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RgOu5i6wGOxIEKuV8TZWWkzzQVwOdSNcIPGU9mWFi4=;
        b=GLJV4LWcHTa3Tdd2jHz4MqUTRUn7QN43IQI6bjTwAhnJNCGo52YjCCrGIVSuOEJ0w7
         aLpQcjfSVVfPG+rM//6RTEAvRg1pgP9oJ8Gulwu9NgseIyJZwrF5aVMJUOgYxuQoF8Qp
         w72Bhf4qgMKe61P/yNcEdWAe3lPGE6s1bsH9nKdD+XftgmqFI2KfEiNmtv2LWgLvftwA
         ggHt0mF76qR3SSdWA3ma4Tkr3CCUownNSYWYu3cysldUKrhsbOmgWpWpD5Dce4bxsfE+
         QQQ43CGDoxKpXf+wBBxCiOmLVaOSFZjmVo4kfMN2WvixyU5BJSc2cJNSHYPoMkW8dmfq
         N80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RgOu5i6wGOxIEKuV8TZWWkzzQVwOdSNcIPGU9mWFi4=;
        b=dEcnnTKReWZCrr3q60PmxMfgP/W7aytFyi9TzIe+RZVSM81EMmIKLFSRcBjWY9wa7v
         0eJVPvLEU4+C9rAS/Hk3KwO4Ep1WpRzhtNjX6sevMUCcEzfsPcpLmZWOdxWo9n4m5QfP
         mytAv+oAPS2FdMispIc87OALW8ol1TM/ILiKBnkQZX6HnbyXwYDA5MuuqaLCX4AIJZlk
         w6OhiY0uT1rz++TjkR+suECfKmWBn4x7j151a/WJTNRhIKgUB1H8yvjuxTCN6wyWNnwB
         FtoVeBQmCDk3WFWgRlOe+D3Lk3jRT7vtcfYYistHb1CnnCnp8qOTUiFGwOIyyBf6z/HV
         r5EQ==
X-Gm-Message-State: AOAM532yUMWwna44sJhqQvDfYjy/ZHVYicX8onE5YRvgU35ajgz8kevB
        1K8L8g0yMIbOw/GssRnZpTjTy6OO/yL6bQ==
X-Google-Smtp-Source: ABdhPJzK32rKlOyaYtfUzDAfi3uPfRC6AlzvfVRxlDPHsq2B6IpDY8zROYCLqMKZRXTAk3vyV1CSVg==
X-Received: by 2002:ac8:24d:: with SMTP id o13mr20800686qtg.154.1594041257093;
        Mon, 06 Jul 2020 06:14:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a20sm6401335qtw.54.2020.07.06.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:14:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs: fix block group UAF bug with nocow
Date:   Mon,  6 Jul 2020 09:14:12 -0400
Message-Id: <20200706131412.28870-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200706131412.28870-1-josef@toxicpanda.com>
References: <20200706131412.28870-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging a patch that I wrote I was hitting UAF panics when
accessing block groups on unmount.  This turned out to be because in the
nocow case if we bail out of doing the nocow for whatever reason we need
to call btrfs_dec_nocow_writers() if we called the inc.  This puts our
block group, but a few error cases does

if (nocow) {
    btrfs_dec_nocow_writers();
    goto error;
}

unfortunately, error is

error:
	if (nocow)
		btrfs_dec_nocow_writers();

so we get a double put on our block group.  Fix this by dropping the
error cases calling of btrfs_dec_nocow_writers(), as it's handled at the
error label now.

Fixes: 762bf09893b4 ("btrfs: improve error handling in run_delalloc_nocow")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d894d9e41aad..7c03b402529e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1688,12 +1688,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			ret = fallback_to_cow(inode, locked_page,
 					      cow_start, found_key.offset - 1,
 					      page_started, nr_written);
-			if (ret) {
-				if (nocow)
-					btrfs_dec_nocow_writers(fs_info,
-								disk_bytenr);
+			if (ret)
 				goto error;
-			}
 			cow_start = (u64)-1;
 		}
 
@@ -1709,9 +1705,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
-				if (nocow)
-					btrfs_dec_nocow_writers(fs_info,
-								disk_bytenr);
 				ret = PTR_ERR(em);
 				goto error;
 			}
-- 
2.24.1

