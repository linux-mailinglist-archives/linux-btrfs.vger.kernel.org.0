Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417542281F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgGUOWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95EC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u64so6171078qka.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8z1VPJu30VF91y5LtCzV2CdI+rElQiqPgvVuMox8Y1M=;
        b=Kld3mvwo6BrPwo9Ingybrk8swLZerSV+EhTzrS9KwD+pHv8KFxi/nIUCX27IIgJykT
         seg8+jaXakjFpTr8TyG7G9d+vlI66x2fH1rBFEI9Mpku6uV2m3sElre8+dLYV0rg8Z8R
         JT496EdbfBMJ/VNEDMjSMnq+owB1KOD60fzJ/Q09GVAXixPZytllAHMv9GwSs6tMDimu
         nNojJC5tJpUybRLJKpZ7PmI3tIyzXhd9wTozBO1/SUwzWl71eoFUQTbPr/TuQgpnHu3c
         3ctGG3fhqe13siktv4ddqgOYAh+Knn2Duau74iynUqcRqF6puLdXxxcfyPpTTgLornYy
         W85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8z1VPJu30VF91y5LtCzV2CdI+rElQiqPgvVuMox8Y1M=;
        b=KBoHejEUXUZJXM/xrgs+5VgzeBZU/xY9affvdhQnYVmrfYQx7RwrRO3Z/TsCPqKDKO
         VRgkzFAw3JAWGz1UXZiwnf2ux0lCIF1Uz8bQyIY+/JMZTngTLGnVWdtSM526rCrWbQRu
         2fSsadTW5tqGjzHopq50KosGhPk0yOXmiAIO9JFj2wpkY/oHOM2YVT5oJBbHMjrk5pIj
         qRr0+JxDmsGoZ2Ovd+iV0mlo9iaW1+Wed1XP3Wy3k73+fUSzqXCp67eyefUFh2VKsRDa
         0/AQqaEdgMGQZ19OtSWjiQCLi8u3Y8etBAX6+fkcIezf2bgQtnNfVgG+IpCoL4D75I2U
         CwrQ==
X-Gm-Message-State: AOAM5319nAwqWsHA0usEbWYbDHyx3gRhr+3qRnfDzOrvhEYjUmtHp56g
        vxZqq/gqthx+Xc5VUE8yydnTgoZhuIIA0A==
X-Google-Smtp-Source: ABdhPJwRYcAJaI3MYG4NYqDHxvr4da67k9cP3xrPzn4jg6fBGUOK3j2f22lXlWeRQ4FdjQRj9j5G0g==
X-Received: by 2002:a37:5256:: with SMTP id g83mr12209198qkb.95.1595341373101;
        Tue, 21 Jul 2020 07:22:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d16sm2398823qkk.106.2020.07.21.07.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Tue, 21 Jul 2020 10:22:19 -0400
Message-Id: <20200721142234.2680-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index 725bf0f5dbe7..9a8de5703edc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3010,6 +3010,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
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

