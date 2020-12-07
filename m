Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917F12D12D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgLGN7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgLGN7k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:40 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926AAC094241
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:32 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id w79so1460844qkb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlb9YVtmht+31htgKs19UPJsESfebdEWDybZUIVc2fU=;
        b=TNhZazmR3ZZCKpNkjOQ8rRgqwyw0ChHUmDW3H6xhrLebYk8DC/lpIKEnZbl8SmmtcK
         yDEv8QE/XdTTqQ0bFegICkb8RZqRIYwwuZl1y+sud/dpuO3YoxbE+8E+gys7Xdazc6/t
         gPSG8eQdGLPi6bCiI3CKB7Glo/pdzNTOxdqrKNfdJXZZUwQGNYe4H9FmPMjAZktgltHS
         ISl488GdJVfiReIf8CFuykMpNGyGr3dq7MmOaqNRx+zkvEqii93BDukQp2AQzTRCbUub
         9xmJqJSZ87chaTw780FrnJzhe8MRAjswu3h6AQ7BRckrVavH+JjjYyTftX4rJcV7LzVs
         su5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mlb9YVtmht+31htgKs19UPJsESfebdEWDybZUIVc2fU=;
        b=svlwaB422Q/l/NpTdBeTmDXU/0wOD85C2/XgEH1il9Q+jGtJcuMd41RHmDBooy38JY
         qfeKFaZqMiNYeC3rxIfDMri2f9PTtGd988toqQp/Qqe+rqg4rzmB5JRDpF0A5+C7R56k
         3cRMY0sL0dDKHipGRlnvWFk0caXXvgY1bPr+p+OkI9PlDVt4OrLXm/P4AZv85ebgVxHG
         BuSYfKt3Le8OFoD7QbhHgaqLmp95uqI41o1D0XZTUbD8h1LySDi7a/7MCWs2wa+er0Dp
         wPVw90vR8ZeZNRnFa9cd8d0RUWU+NQHsHo4LTnQJP8t6aE0a8Ob3D6h+COqKcPgoS/N5
         WePA==
X-Gm-Message-State: AOAM532A5gmvSkSn7x4fHVVSYHQc213Kn705DAXbINmqDIy0J2u13LBB
        s7Uu6m5lm+QJ6ltUf5iO0AAvBiWvRugwimYK
X-Google-Smtp-Source: ABdhPJwMdvsteo0SwUWCwUjoZkx4FTywTQ5zlaaplXppL2026SQmU02kV1enh03yAYywGKMTtMccpg==
X-Received: by 2002:a37:81c3:: with SMTP id c186mr6291962qkd.496.1607349511295;
        Mon, 07 Dec 2020 05:58:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p58sm3831035qte.38.2020.12.07.05.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 23/52] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Mon,  7 Dec 2020 08:57:15 -0500
Message-Id: <5e14608d52c42dbaf2d57b0fc9a2cc9c91cfac15.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 28e7a7464b60..c17ab5194f5a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -734,7 +734,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2

