Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8478A2D12C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgLGN7Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGN7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:15 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B89BC061A54
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:06 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id l7so1139034qvt.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pg4Rs440j7qytVG8dQXueQyKh7OJmkNUbqs81SrLs48=;
        b=1cl6creHvojGPYBRQ1SvGBox7sSREnshDzFOy6O0Axpa2FmbLi125OnjRPGrgmNcyM
         3G7MJw6655y7upbm8+DUqnWyTNdPVIxQw1YQincSVXxiuboQ1b5jtiUGuoEw7Ojvgy2L
         RVhQjTL4FymfALfmipKNNgaL9LyBGc/kYhYyNMaoY12p0cg6misbzNUS1fInjNZBmA2W
         bIYC2eM/eUebuzUPWyj45hADIBfR25t/7gN0UfwVu3tnQgJFoCwyifagqETVJNkc2UW7
         ZJ7xTec8GRC2rPZAv6dgZAKToQLl6FKT7dM+jowoXsQAmxbcTo02wfc3nOaFK1kquWC+
         Gi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pg4Rs440j7qytVG8dQXueQyKh7OJmkNUbqs81SrLs48=;
        b=OFxLmfCdali3JL21QWmvsN1H1LM0AOUqflOqFcIUBqMkghHTdJjGsOxzVf1R6wmpTm
         03Zil0kMXNTod/83edoTHRLUU9Jn/ngpUthA8+0wkA+lwl4CykKOwYqy0VpLuyHMvD1W
         /5uafOqwijnOLStwYsdmdOwxzZ8s4XZJTgjBWdX3jp2Rf2mx6Jap5uP3JN86re0IPCyJ
         59TlSNGRu4QKFKjHN1FZlzxti64Ap8w2bbBF/yHGsY8sHUZ8fhQtnltfqEfUYHodLvAk
         BKjkazWI0/nv6xQRVipI3+jOJWnhpj99gfpq6A/dJ0sxqVIlxCkpuLj0qALE084XVC2p
         vuog==
X-Gm-Message-State: AOAM5312YHRIVFzl5+DoLc5W8SSpJdMT48/LoE27MJJTqWAEc7LDZUbh
        /xD2tVauy5yLZgB/QNvxdTE+Pdu5gNe7eAE9
X-Google-Smtp-Source: ABdhPJxHyoVAweLsqzmABkEr3+19ijKJPYvgpTDCvoDliw88YcNGZPHMeS/7kuQuWaRlyduJw7JL1w==
X-Received: by 2002:a0c:e6c6:: with SMTP id l6mr16476343qvn.2.1607349485312;
        Mon, 07 Dec 2020 05:58:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j63sm11405478qke.67.2020.12.07.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 09/52] btrfs: don't clear ret in btrfs_start_dirty_block_groups
Date:   Mon,  7 Dec 2020 08:57:01 -0500
Message-Id: <2b3113fc760d2d94def6617e845e7ead64b32ede.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fail to update a block group item in the loop we'll break, however
we'll do btrfs_run_delayed_refs and lose our error value in ret, and
thus not clean up properly.  Fix this by only running the delayed refs
if there was no failure.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52f2198d44c9..0886e81e5540 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2669,7 +2669,8 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 	 * Go through delayed refs for all the stuff we've just kicked off
 	 * and then loop back (just once)
 	 */
-	ret = btrfs_run_delayed_refs(trans, 0);
+	if (!ret)
+		ret = btrfs_run_delayed_refs(trans, 0);
 	if (!ret && loops == 0) {
 		loops++;
 		spin_lock(&cur_trans->dirty_bgs_lock);
-- 
2.26.2

