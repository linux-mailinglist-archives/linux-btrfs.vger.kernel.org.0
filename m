Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC82282A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgGUOsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:48:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E4C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:48:53 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so9402848qvb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JqyA/31uZ8QMKqdm3UQa9LoI8CaMWm65htMQcK0Yv6c=;
        b=lQKG9lENNevobUKF489V0U4CqmEgg2p/BxGu1jQ+p3FLp/ozopF8QGwWG6SPcXXVZ6
         g2eHcE8m0Yk8d8Q/NqPCW3uj5iL149VnV9mlKYmj7e8exs4Xti+Y95TAjSVP+SzIw8K0
         k4e1mDXop7V9gzDbp2iG13TTdpr1/PomlOpI9HdTfvTpUWA3uZIKItLu/O9ebPbLv4rw
         isV5DuMrqEZh9UGgT5hupVv5OeET+bOIIIl/DvGnYCaC/WUAJKR2gw1aNVdnPb+V9Tsf
         fRvJ09BS4XDMEx/YHq2leOl9zYBeDGta+2zq40OWERr//h00gUXlJr2sUSI5fYrCY1KR
         KpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqyA/31uZ8QMKqdm3UQa9LoI8CaMWm65htMQcK0Yv6c=;
        b=g2nEcpNhL4wOx+CSJF/GFsfAuQa802nzD4IJkb5XtCAlWW5D+eCCWtK78jAGpgJ2IF
         j2H4GLkHfTYp8qqVtj6S3ADARUGyNsdugIPmsJ5Be3Uj268h1bBvaoh7FU+KJL+2IbCb
         gakrcN0wwZ1xvfOrpUbAHWz2MkRUNeWyDozxtk14hb/MsdkwafCC/vZ2OB9IhHJgLBA4
         teEv4ioF9yESlA7OXMSNYvC5RxSl1rMrBPQMp6cxCe1+DhD4dgB/iz3wi7D+gj+T/nLC
         FjdkQ4QYigA0VJVPmUfjhqNF3l5T2Ioq91Gyg4UWtrE8CluEYIPrXZP9PIiyJNAw1O8u
         jy/Q==
X-Gm-Message-State: AOAM533DZlmIBA++Ee4hNdX6/XKQgIGTLDDaUp0+kwaFwzftwu2POdG8
        6AGGT8NEsIny40wb9onK/X4G2Sc3ra78QQ==
X-Google-Smtp-Source: ABdhPJyj2eDOgYj6NZgDf4IqwXpP+ReHs9Co6KOdhLj/qn3Tg2KpFS+EVhdrm/32Zh+Wt+V7El9yNg==
X-Received: by 2002:a0c:f105:: with SMTP id i5mr27926899qvl.120.1595342932311;
        Tue, 21 Jul 2020 07:48:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 20sm2649506qkh.110.2020.07.21.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:48:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: if we're restriping, use the target restripe profile
Date:   Tue, 21 Jul 2020 10:48:46 -0400
Message-Id: <20200721144846.4511-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721144846.4511-1-josef@toxicpanda.com>
References: <20200721144846.4511-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we depended on some weird behavior in our chunk allocator to
force the allocation of new stripes, so by the time we got to doing the
reduce we would usually already have a chunk with the proper target.

However that behavior causes other problems and needs to be removed.
First however we need to remove this check to only restripe if we
already have those available profiles, because if we're allocating our
first chunk it obviously will not be available.  Simply use the target
as specified, and if that fails it'll be because we're out of space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 652b35d5a773..613920c17ac1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -65,11 +65,8 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	spin_lock(&fs_info->balance_lock);
 	target = get_restripe_target(fs_info, flags);
 	if (target) {
-		/* Pick target profile only if it's already available */
-		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
-			spin_unlock(&fs_info->balance_lock);
-			return extended_to_chunk(target);
-		}
+		spin_unlock(&fs_info->balance_lock);
+		return extended_to_chunk(target);
 	}
 	spin_unlock(&fs_info->balance_lock);
 
-- 
2.24.1

