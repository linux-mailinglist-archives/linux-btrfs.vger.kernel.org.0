Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9B2281FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgGUOXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgGUOXO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5061C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so6860741qvk.6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYvFTR2wkUcDKdml4Bzn2R6cx4pTZvSFMrHCayhIgeY=;
        b=WIivlpOhGiiWImYLh8Ibg8592riFP1fqaQuCWyb5ihL8rdEnCwE/3ukUNt0KLGaU5H
         YOTbjhCkeYPgeyStkJorBzmqbvcXxXFAKr6lbFX3nTGbCaT0Lz9Us8de8Io+Lf4fJBzX
         EkTTs1w5a/uB+0O4PYde7wZYgbxF+IQzw7kKW6FLB+5gqqiifyoyxGLIo85XdritWw+f
         r9xCt5qjLoFUuYytD211dP0McLZg0ApvIZxMP2Z9UrqmY4EVAAC2BBmSWQEr+1hIzwuy
         p1ynDtrVSCV19LIx6CJwWsNdxf4uQfcBQIP4sySt2v8ful20NA38S5owGd9WjuxoYu0b
         irOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYvFTR2wkUcDKdml4Bzn2R6cx4pTZvSFMrHCayhIgeY=;
        b=p6YYIyTHusO5LauCETZY7/G46LJdlEspzw3QA65b++/p8X1HX+k1m/bM4uxwQkaPlj
         sELrMhR5MR0T3qHm2MJumia4U9pYKxzm8+SWKbgWvz3QX5WWeNPL/IwXkuUCbBOitJUT
         kT+g5IC9MFrH/c64qt28NB6y964jIGynUv6YKWfNTvMUAszQRDUD8DOVsiK+WB1kG/GT
         1owGAZXF1m2uaiklVtgD0xiJsY1seN2A5lCvEpolizpQ8qwhOFUYd1tqvP/4zt07t5cw
         JmAhVY11djHndvyS5APDEVIytAyPCFQe6ihQmHFjHaEmAWSReKl+8BMqGtZHc4yIcFGb
         aW/Q==
X-Gm-Message-State: AOAM530SoQs9zqejZR+mnNr88NdCZmA3nTf/4FxlvqCHSF+mRwjueISX
        ETaTl2tH/feNsZoRiw+F9hM/QjuMJsETkA==
X-Google-Smtp-Source: ABdhPJxgMVfzIE0iR2h4lSVRKff7j9LgFSLwpWDYJOy20KZ12IFLHQ73fQ5dyc3UcnkIKeucAGNTBg==
X-Received: by 2002:a05:6214:5a3:: with SMTP id by3mr26815651qvb.201.1595341392770;
        Tue, 21 Jul 2020 07:23:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g8sm12680744qtu.65.2020.07.21.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data reservations
Date:   Tue, 21 Jul 2020 10:22:29 -0400
Message-Id: <20200721142234.2680-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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
index 605be9f4fcac..5efb3eb9253d 100644
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

