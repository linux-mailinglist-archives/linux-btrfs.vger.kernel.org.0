Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7AD2D2F9A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgLHQ0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHQ0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:19 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CBFC0613D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:48 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f14so3768081qto.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJHfHNumCZ2vGouH5r+eUjB1N5c26k5zGROq6O6ca+o=;
        b=aLSIwvcN9TP1R25+ii5rVw7Cn+4gm35cNalOX5TQPssfyJd7DdJe2CXg6K97jcVuau
         zB9o9AybeVkGcV3nMw3Aym9v6x8OkuIa9FF36IvmvE2ll7hdZolmwgMBqllJdxB8/lA8
         YUPUxWaZMLnTLg0s3YY7AMgCrvsJGE367aKwgOPVV0RLGtk0vKGGYtuBb8aVmteAzCMV
         nNyfr3BQHDeBFcNTU87X1g6LCO5AzYEv/G79S9W22iHcYKaFT6OseWBVvJOpHLDPqcU2
         GnkpGI3s7RtTtj628///5MiiLhu92WCfrM87lyD8pEYwDa6xBZgumuzd7wfaMp05IcnN
         brcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJHfHNumCZ2vGouH5r+eUjB1N5c26k5zGROq6O6ca+o=;
        b=R1IHoyEujXvVF8bPz0gUntmqxIZSi8PGbGGym1VR26jjvG9VxhNi7opWjfn3+g4TTN
         YGrSQJ3yQgRDoJoJeEzqs2S8iYgyn+W05x7UFVby/rvQDoQIkdopFjWT5KG0ijHsvZqf
         ps7bWoIF8rWIDkVZmmOrjS/ui9nuS7hLvRg2leA1dWFmI/Ydko24Z91q7h2vhywSbQHq
         oQE44oQKL/Bm1BDwpKC1N/3/vqU4sFrdehcErqr+OEEVacxTw2uv5db0JFm7g/hWH5Cs
         TFsYMC+EnPOCOpKyv9yzmnb18q36JUY+myP2nE3YDO8U1rI+DVDcGg8KwZLOolrzWNHW
         lTQg==
X-Gm-Message-State: AOAM5305iID1sALFgS2uy/PtOT9sCTKONxX3J+CCIy7Plmay+uwYUP7A
        LAdnB1zM741NhhnIjvZm1TzESzh4HtCmXktc
X-Google-Smtp-Source: ABdhPJwmE56W7Hq1DSfKxBx9kh8ym68CfPNF8A1uA0jq/GFqg3/zozbHfgkixZ7mTba8HcK+0RqBKQ==
X-Received: by 2002:ac8:4e0e:: with SMTP id c14mr9788158qtw.71.1607444746925;
        Tue, 08 Dec 2020 08:25:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c13sm758139qtm.37.2020.12.08.08.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 48/52] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Tue,  8 Dec 2020 11:23:55 -0500
Message-Id: <b0a20ed6e05a594e909f3bdc3c903862c7dcc26d.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 066d06575dbc..3ecb09c5d65f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1905,7 +1905,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3440,8 +3440,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3600,7 +3599,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.26.2

