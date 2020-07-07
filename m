Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B982172BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgGGPn0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPnZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC8C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so38546261qko.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XLMhupLEmPrkQFbBbB2TlTxqawyDNYaqNQAW9M6vys=;
        b=UGJONAHve+yR7qhKhBo7y3IrcELz8R362igmAVCqccaXexRx9i+cR4eTfVjGDIoMKd
         0PBiAI+Y7Kc65wr8NfLWeuAF4YuQiiceAH0UXiJVVV2Sj00xNVVPctnELmwQdS25cjxK
         ygjaOkiFhnj41mc5g/bvCc2ai0OLmDU4RJGqO6l2GdDl+2JnlklhZpVwtvaXLhy84mHM
         z63K8XFNDDgbqF3CCpmEoFKpAgL2COmosVQYUqBQG1fWM+LUyyoHH5I+ZKAodtDM7vmG
         FXyO4wps7mrVn16s59wiZZ/H5iNADwUVXPKs53sGV2gJeiirnVRZZYT9j8mp62TlXBDz
         K4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XLMhupLEmPrkQFbBbB2TlTxqawyDNYaqNQAW9M6vys=;
        b=OuGI1puQTdEWwOSo33ituHXaYK6MxvSZeQNdHi6oZirKCifJpTEzxoHC2lihl2Tp+X
         C7xVdL837i04owLR+yntgHO39BM4JFoznDsBBHBRG3prfC79nGG3gLOXwqt/5NK+owd8
         NCVAJ5W0mmVyekBfspKpe5gwJpUQz+byXi+/bNvtM1IoG2xGP5f5Uhi2TcKbJziY8DAI
         5NovuNCfW+Tpt7Iux2goWvIoiab41QI1bsIp+MyEqqMHFIoDi6q0uAu31kVV0tcl465I
         jvQVi/us10QBGRYP8TnDM7zVQBt4dVlSyPECsb7M/3b7yFYnudFxCU2zuZKzgNSKastV
         PCvQ==
X-Gm-Message-State: AOAM533OAmq7A38EBsm4XAzxlpV6kGDEAYnJPE3NzOxpo4vCQN1zusMs
        CsaxbQbEFRVYj/6IxeF4LQjkyzSgVfMT1g==
X-Google-Smtp-Source: ABdhPJwt/cvBnRoBHWR1oAEMXzaGHfsD2JM7JXIbu+nCQISkY86YlbjWCLb0Llo6qUIfN+AjSaFHxA==
X-Received: by 2002:ae9:e519:: with SMTP id w25mr52923258qkf.327.1594136604436;
        Tue, 07 Jul 2020 08:43:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j24sm22617309qkl.79.2020.07.07.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data reservations
Date:   Tue,  7 Jul 2020 11:42:41 -0400
Message-Id: <20200707154246.52844-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was an old wart left over from how we previously did data
reservations.  Before we could have people race in and take a
reservation while we were flushing space, so we needed to make sure we
looped a few times before giving up.  Now that we're using the ticketing
infrastructure we don't have to worry about this and can drop the logic
altogether.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1e070cd485bc..59d0ad1736e8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1077,7 +1077,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					int states_nr)
 {
 	int flush_state = 0;
-	int commit_cycles = 2;
 
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
@@ -1088,21 +1087,9 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		}
 		spin_unlock(&space_info->lock);
 	}
-again:
-	while (flush_state < states_nr) {
-		u64 flush_bytes = U64_MAX;
-
-		if (!commit_cycles) {
-			if (states[flush_state] == FLUSH_DELALLOC_WAIT) {
-				flush_state++;
-				continue;
-			}
-			if (states[flush_state] == COMMIT_TRANS)
-				flush_bytes = ticket->bytes;
-		}
 
-		flush_space(fs_info, space_info, flush_bytes,
-			    states[flush_state]);
+	while (flush_state < states_nr) {
+		flush_space(fs_info, space_info, U64_MAX, states[flush_state]);
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
@@ -1111,11 +1098,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 		spin_unlock(&space_info->lock);
 		flush_state++;
 	}
-	if (commit_cycles) {
-		commit_cycles--;
-		flush_state = 0;
-		goto again;
-	}
 }
 
 static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
-- 
2.24.1

