Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4720F689
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbgF3N7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbgF3N7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C79C03E979
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so15603965qtf.6
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSf+3a72PAiNlMwNS/uTdBTwmHFW8V8FvMYLaHzUIks=;
        b=WtYv4Ogn4jd+Z2/PNE+xaT2B3WGNckkYHtyF7qat9AVCRaF9vqpDGPdZf2UR2CMh6y
         A+CdXANY5WkxL1V5rClke4oTw6C3HzTIKquMGhOfyr3xujUe0wI7D82HDOJ5VVyD0aFH
         vhDcIEtbvo9IuDi0kxdeoDySX1i7CdZZXPzOgD6LfRA7qNw6wx1X7Z1wF/B138xTExT6
         /Ps4+b/tt9lgAoQeSRrtHakXInSaoNtyHGOcFvIPj9246ldH8eZUzxBFLKXwdhgEKm4G
         hRwgevzIikXc10tLtZYp1zruhdx6fKIWzcK4GHbAkjiRp/tih6Cpexsdi9sicZHAOcB3
         OrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSf+3a72PAiNlMwNS/uTdBTwmHFW8V8FvMYLaHzUIks=;
        b=b/BrQdFV+YSONKvHo2++wMRBQRoKW2Qj5SdOIAutzPSzgr7CJh8b2myo/lQYWzPAes
         AcrKOlRC/MLPK5qHfDUdZaEk7WTSvXQIzTp3xx+TEwkW73xNtoovp50Vr6rE12Q5o4Rs
         ghssUMkxOskzKE2eb23sTmAvuIYXAeMRFMtnHtqw/ZfPzOGS4avmdd1bKZJnBsmEVRjz
         KhaZGK5kGkyZFfLnHLdjrlRcmknskPyzwcHS1F4bCF0XUx4CjaOsqUJdFojdsvZyF/NO
         dh724xk2fseTiNRI2d1Q2o5VLrnIe5RJRtQY8EBoDbqYjLv8hF6bH/gL5nsg7OYHwKbP
         yFng==
X-Gm-Message-State: AOAM533ZzVSnpEQet1ItsJU8ysH9NEjdLKDuRfOjyx0zwSIqnDHpNNhF
        0CqsBKUf6QSjnZYPePaHXlz7pZmPo/80Rg==
X-Google-Smtp-Source: ABdhPJySIfTJX3Wym0yI1pCrObonSdfW4g0rBob8+EowYx3DmIjS33cguU5ctdOCqzAljuJhZ8nPDQ==
X-Received: by 2002:ac8:7b57:: with SMTP id m23mr389835qtu.379.1593525581520;
        Tue, 30 Jun 2020 06:59:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v10sm3243494qtk.14.2020.06.30.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Tue, 30 Jun 2020 09:59:06 -0400
Message-Id: <20200630135921.745612-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index 7b04cf4eeff3..df0ae5ab49bb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3057,6 +3057,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
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

