Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93F2339839
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhCLU0L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbhCLUZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:48 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC62C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:48 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id cx5so4891015qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOSBjmx/iKdLdD/beCE3Hry8uoKx5iaBLMEn1MI4k+g=;
        b=yCsvx9Qr4jG9qzN4oSSbVrbwi5jO41dnJvEC0kMnrF2YV74EvC0Odp7CW9HfwGH4aB
         i/Qni1nRdLqwO0WjDe+YnEu6rZsSajrrKUdv7rp9A4FEVdWp9NEpgw/flm18wzsYOvKy
         huzYlmLBQDObzBn/3T4iSVq7KSLrdpJMaYuo1kZ9gcKJw/LaOWPp86UJRzWIgojGck+8
         pO39FWSouGGtw4cLaPWGg86WnIt7U+kYjJkevMnNyAUoQTG3x7hS0HgMYH3kPr6FSczP
         PYcvwMwT0Y6ns9Kthh9cSbW9O9+okNYwI5pfbliKfuIZ9lPHYq/MYNRZf2prx1kA6h9w
         vKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOSBjmx/iKdLdD/beCE3Hry8uoKx5iaBLMEn1MI4k+g=;
        b=LrSu48pVKaSPCXBRQhjIcNNzSYUIXen9mm9yR1BnKocaW1+7D/cv3dtKyXEAhgKbTV
         H4d3AEcz5+0jQUSjgTehKQC8M0toyYJKgWRJNyOKMunkgBMhl6I+8ZBqcbOTJ4mRU2pO
         2sYyycimbP2lCtGb99paaFAW3kknPtl+awdctkwroGOImylEFzJdmu//cd/69VgB6Z6c
         eaTbnJOGgWXAfoth8gzmOE6f2sOUVv4+umjbXBRns8rvOWTAFLqfGt4slJAcPIQvo7Nq
         +IPY2FJmR0z00oFDvOJieUDDyRCk/QQH7219CaJEMG97BjZYjDu1MIBhwjyCzGi6H4Ep
         8ceg==
X-Gm-Message-State: AOAM530KHnlXZU7gSBzRPWNpvpscGlBfqZoYiRIiu0Y5/tcN+1Oyri1U
        G6RTeI5LLHRnlUMp4sSZMCBQ6rW4wml9JKxr
X-Google-Smtp-Source: ABdhPJwb9yaJysoR6tCI6CJabJUkwN40770mm84kXP/f5ibgy3HKg3A7kv95hgqDTpXnc0Mf3a7Zbg==
X-Received: by 2002:ad4:410d:: with SMTP id i13mr2056qvp.44.1615580747207;
        Fri, 12 Mar 2021 12:25:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 75sm5264974qkd.114.2021.03.12.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 07/39] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Fri, 12 Mar 2021 15:25:02 -0500
Message-Id: <5c2b128df19473f7d252bcbd9e1d60b763d7a3c0.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 52dc5f52ea58..a9fde9a22fff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9102,8 +9102,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2

