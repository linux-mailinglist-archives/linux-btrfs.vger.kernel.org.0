Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87020FB8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 20:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbgF3SR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgF3SR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 14:17:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698AEC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 11:17:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u12so16315617qth.12
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j6twcMPKF3S7yLpPI6aRw5mxx8N3ruXhVguLNkQ6cJI=;
        b=zTtnjAlwfeKAy6v5Psp9a7zAO/OS48Dn8aX1mZycTvduXTPAeb8g62nGCJrbbITUZ8
         LxRQH4YcGR6obfj0uNFC+WDbvwGQe1bB88yos8FBgG3IvzbO0toetspTiG8MD2VS+rZx
         EnpTEhg43Dd7ECtI+kibTJs9RmQDpe1ybCT7FETE5aHZDsKz8FW5c3ESjGK7qrMJIQim
         L9sPyB1us1XN/h72pLJeZwECYKaKQPQfENtUTbPiBUA8dLMTgoOoHTwJv1ULcuEUX0KB
         6OUUnkfU4HFRNsI1NAkzC7yTOMRnLBnTa8wZDphuMSHZ9S/l49Kzf2Rzt/6mIVGV7b9L
         kTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6twcMPKF3S7yLpPI6aRw5mxx8N3ruXhVguLNkQ6cJI=;
        b=hR3hAlCyCJTfb9sLRVxT3haSEnpBKkB4m9RMO0QuWBMLpNMD1+EGlhFgrqxYKxjvrt
         Roi7eHk0vtgjczGdYyFmaxi5Y1UR/25GHffCjnjqwkYBPi4a3ilp3Ky3NU0U03P1XXJW
         PBkO1aOo1krco+K+OdQxujDovrLdDozNTiNfmfwuBsPiH2Vdq9H0tyKU6bS/fJAi5jU4
         obNEQsVCtE5WR7CIVeBdv9AaIhpSSMDhzl10t+HIhXreI59KUcvBv5bi2PZyltNrs9zQ
         zNWeUhw1oURFkx7WL26Osy7U85V00gQOLh0RbmM1FOB8Nm6Ea/zuAq4w6eHUpNPEhWIn
         Gvfg==
X-Gm-Message-State: AOAM532bMUM2hE9pTreGUkpl+aDA+hnR0hJ9LqI/G/Ymw+zk/QInA4cT
        ZxigAuAQVdKiP7IdsgrjQzraEgYXvcXWOw==
X-Google-Smtp-Source: ABdhPJy7K0KIlnmOE/Z4Dcpn32RfF8kKBIQSxwKGkdLLN6a0oOL+6dTM7hHLocwskqnUqEEny4HUxA==
X-Received: by 2002:ac8:31a6:: with SMTP id h35mr22200446qte.323.1593541046182;
        Tue, 30 Jun 2020 11:17:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r188sm3426977qkf.128.2020.06.30.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:17:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        holger@applied-asynchrony.com
Subject: [PATCH 2/2] btrfs: if we're restriping, use the target restripe profile
Date:   Tue, 30 Jun 2020 14:17:19 -0400
Message-Id: <20200630181719.3190860-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630181719.3190860-1-josef@toxicpanda.com>
References: <20200630181719.3190860-1-josef@toxicpanda.com>
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
index b111885482e5..1907ab9a093a 100644
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

