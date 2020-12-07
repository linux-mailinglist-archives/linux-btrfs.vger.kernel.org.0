Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0C2D12EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgLGOAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgLGOAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:05 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D97C094240
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:30 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id u21so9344027qtw.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IURlmIE58ARQOAEaOHeShyPcEluY8RP7eeBOsM9Ef/s=;
        b=oTVlsJ6If67RdCXsicIbeV4gUQdDEWhQM2u3i2pRHT4+qJyu6cPVBDi7VQ0vdLmVtn
         BWNJ0euH9vs/Vyj/fm96qp13DexYAxUAAX6B+27rZLAnows18JwhBFITtbMsOsHROmqJ
         YtEm5NOFC9BIeDv2VgQWPDoOhCJws83Li3qlmcJGgLPEqKK2VdoAV6S74pvbS3R8DYTJ
         SejTsOzPjNh+l3R2XrolKrgTqVA2+8w/RRXQbhp1Lkr+1bZ0YNF2pIz2aOOMu0kgCaU/
         gxhfP01rFCfHB168m4pn9OKgzmiZQ6bLnFt0SPDHYS3joP/ShR9hPDg5qmzV0xLmAAhf
         PvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IURlmIE58ARQOAEaOHeShyPcEluY8RP7eeBOsM9Ef/s=;
        b=MeK2vV2dUY3294kN3XAjcLE9lKDoGaxcg5WENwYBoIoRRFQYZkGHobvSY1eHf3tSoi
         8rpaasiKxrdpEH4JulmGE9ovEJthOLRt6cgOIkbPP0wHR7uhrPrlJKyKxu/iEryK2zU/
         EdnWrWsIe+3xIV3FrkzXwvtE1jK5egZVo3Gk79CSwAqJi8nkWSliLPVDpe4Dyd4WIpnd
         xzzQKkSGCoW+z5GKowJ21bLoEzLoG/dfrB1UrgiSxVccbZrEthriVyMXaW6IgGcRbAO9
         LfmxE4jqbfiAITUxvN4sJGTRakb2m1zw3XiDHK5IRgODGATn7yM6rn8sUQl08dZzFD42
         5/Mw==
X-Gm-Message-State: AOAM532E3o/AmkCU8FbPw+2sI7GLfHQ7WwwQ2peZPazqMPuGJYUoUTe5
        uzlrbaNsA14c4g3lzocuzJtoiFUTBCMeUw/p
X-Google-Smtp-Source: ABdhPJwKLwVFwbigOnPhXCd9JUiX1UFtojn4QE2aFtA0zV42kXU0GxPPTV+jIlU2jscPFlJKz2n19w==
X-Received: by 2002:ac8:4cdd:: with SMTP id l29mr2907061qtv.216.1607349509596;
        Mon, 07 Dec 2020 05:58:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm11679093qkk.57.2020.12.07.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 22/52] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Mon,  7 Dec 2020 08:57:14 -0500
Message-Id: <2fbbdeaa75f64f4dde291e8205f444f554f53f91.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 90a0a8500a83..4356af112025 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2552,7 +2552,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				ret = -EUCLEAN;
 				goto out;
 			}
-			btrfs_record_root_in_trans(trans, root);
+			ret = btrfs_record_root_in_trans(trans, root);
+			if (ret)
+				goto out;
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

