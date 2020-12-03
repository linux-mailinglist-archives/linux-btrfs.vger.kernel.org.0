Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBCA2CDD51
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgLCSXt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgLCSXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:23:46 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D063FC061A51
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:05 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so3020777qkq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVF29zjIMzK8Aj5Dvh77oVxPiV6X9DMRXLxv8SQexm0=;
        b=jnU5rLDL9/Ii/0EPYIy4bAFsjL8gtfJx5C3Gwdw9CenVglYu3ffeZYPQm12KdhMhpj
         VhKWTRvA7dMtnkhwHw4KVA8gm6DIFiF9emh4bA/UCpkJApxJ6URLisWQU2yWMeQUwnuz
         xeWXstlnWAwxcAQt4cdHJy4q2fn6pqnzvWFfjdpGFwvFDH9rzWLjlytZ2a/DO2DqZFx2
         4gMaGi/tCy+WS4mWOVS9OMZkhe5Fkmk6EJ0329hqRBWd6gOP/L4kbRlCDx3yUCR0ywMJ
         6ci2gKz8u5hYx8kH0DHvTgDNlKqDrBrSc8DR1WrOb3nAV1CDP7OBoyGnlYTpQyKhQbdV
         VhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVF29zjIMzK8Aj5Dvh77oVxPiV6X9DMRXLxv8SQexm0=;
        b=f0NyXzxBCRI1BxG95Clmz4bToHcAOOWXgt9i7HAw+Zh727iZXrHJMaDAoYXnNFTx+D
         tOfHKtcp7mZq9mdgiA+jglqw54qsjX+vOxWoLJS7kSGLg1zQn3K5yderQtno0FneMu+u
         X2kta7gBvHKEKJRROS+cSb5ZwwKrS4h4kNWjqi8jzWWBF/IsMoDp1P8QkwlQmlBBhTd4
         SD5WZ270alNWOUZniWBaakOfTNe3snOKIRhbO8VQjAKq7bn1wvbCrFfYfKm/FaU0RaL9
         5HhePtYkBfY0vAesbdwE9kW2u+HhP8x3C3ULmSu4aNctU4R+k3/B7oR+Hs1ib8Vke9y7
         mtyQ==
X-Gm-Message-State: AOAM530YWNbev79kqeym+N3t+tu0GuOpxzRnAh8y7oHtEub517g284i+
        m6APHYWTeAQ9Nbz1ME6cPf3B3CMX4BaoPI6Y
X-Google-Smtp-Source: ABdhPJzoY3G5mYgW3WddSZAgvRlrCDLI8T47AUO6sVqMoZr0eG9ofj69Kv9jfT9+I04hu7twyIYuSQ==
X-Received: by 2002:a37:a2c5:: with SMTP id l188mr4248079qke.250.1607019784775;
        Thu, 03 Dec 2020 10:23:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y192sm2350719qkb.12.2020.12.03.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 02/53] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Thu,  3 Dec 2020 13:22:08 -0500
Message-Id: <ab9a08635a0e3a8843b96ae2b57e1c44f5110f8f.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e5a0941c4bde..f40d3a2590a5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2800,6 +2801,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

