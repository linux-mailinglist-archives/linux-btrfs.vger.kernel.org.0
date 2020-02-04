Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67CE151E2E
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgBDQUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:25 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39206 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgBDQUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:25 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so8816818qvk.6
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2q8eZiUq4O2k7odBc2y5JAi66I33AH7/fBW1RPBDTk=;
        b=WfGr1pjE2pAk42kLLTnOgFyjY8wtCQ6HTrPHcwyENtsfKucRjRO8E1x2Tj4R8VD1O3
         B59ckiDM8yK6p1u7eR+B3cQdtF9+CAxDqTHL6QQuZpWoey9Pc+Z9kt2FNCpXQLzbG3r3
         /oVISSe4e85krYWaiX3kaSucre8XCJLB2Ba5CJeQ9ynmnqLf5r0WEGUa/xrfgl0f0Awa
         e0RKzwFQvpcsWXdUYtmORIkhw3P1x5iNk2Jy+sSPIcQ8xNl6Roh8G3MWhyciDSQp5Tuq
         BE0An4V+zdOUNUByJafEBnhKq/3zVBjcwIRCq5AmYPQNeo7AN9eRMA1tco4OPFILHhDB
         5sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2q8eZiUq4O2k7odBc2y5JAi66I33AH7/fBW1RPBDTk=;
        b=kaj8PPeS/7zc3wrrZrV2cqk4yro4BJEPLizAOtpQJR4yrAgR2BbjRxZYBfdAS1onHm
         cYjOZ0snkBldtVXSYI9tSpDG6sPyJNTBprmrXLou1zBkQfwd9XCD/rd7uC0R/1pVs+or
         do6pSXLTRhNTXIxIxCNFzw35/ktk52WH09DNHXxy98AdU3EXVkfjP4Ei1GIfWiZGMJPI
         KCReIc17gwJQ/ki8It+tERALd7a5EHhlAQWIHKEtSfsepObTXQcDtjUZbZ2TWlqJ7San
         IDHfGYSyVX3HagVjP0kEWAuTLZIffg4klo7jkfsNTOD3ff4nwbvKQEB+LLRS92j7bL+4
         kufw==
X-Gm-Message-State: APjAAAWhGqRYuvcTRmSQIOMPpdPPf6vE+fHiim3n5YvvXYnGlEXf3116
        5vBW4uMVA0J8A9/8J/FE4hLMUhCEYVzzww==
X-Google-Smtp-Source: APXvYqzdWwghprjT4hgWuxlYw2jG9eO/b+2gC/X9c2OQhSagGLkHSkTaPOxoKCxc/PUOhff1s1V0kQ==
X-Received: by 2002:a0c:ab8f:: with SMTP id j15mr28347711qvb.223.1580833223889;
        Tue, 04 Feb 2020 08:20:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j1sm11184494qkl.86.2020.02.04.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 18/23] btrfs: drop the commit_cycles stuff for data reservations
Date:   Tue,  4 Feb 2020 11:19:46 -0500
Message-Id: <20200204161951.764935-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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
index 225f7f8a0503..8c5543328ec4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -859,7 +859,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					int states_nr)
 {
 	int flush_state = 0;
-	int commit_cycles = 2;
 
 	while (!space_info->full) {
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
@@ -870,21 +869,9 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
@@ -893,11 +880,6 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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

