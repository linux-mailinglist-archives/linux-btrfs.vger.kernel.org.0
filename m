Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202EF2D12DF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgLGN76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgLGN76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:58 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718FC094251
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:01 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 19so4926012qkm.8
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUDtQkFoKJzUDp/KbFsXFW9qPpciC82EJzYszvfdmFA=;
        b=0kgNdUY6QvqwJh+iLEHCWYbMlipOECTwSwlVMI8NnCRmEYfvHzOZ9v97EzD+vhNFvn
         uFMu+uOY4ISAEtvWzuhqA6ym2YuDzTMlklGHtbEfV6nRGae0lGF+rxLEFS7sM5TMRAW3
         o7+rzc4JWIx7PsrP9K3hbnngtgD5dJQqNu3vTTrSn3JtLCg/TEesKgETzZg4khrF8lBF
         +03982dc2kXhfDrZbvoZDoVL5kt5lWDofUfy6m6KATkHMBiX0/jgIy9LkKC3bugtb98P
         qJzKg9EIy00WendM+e7qeFiUXP4SDwYGqCYASUXPOvyPPwq+vJ6tSM9PiXkYVBt+TWWr
         jUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUDtQkFoKJzUDp/KbFsXFW9qPpciC82EJzYszvfdmFA=;
        b=sRgxOq76+Ma/E40TEEX8pMNzX8bh8pvoIZOOW88DtEup3uIatK/RBWVDKLz4mZZHqb
         vdfLsmwLNAfybbUsdhkJgEhlIWPB7P9aMznYL+2TMPTffw4iUuOx0xE7EJrXKd3xDKqS
         fA+FFckvSRDHAM1q6DSJ92lvzF65AH5upBAR2kf/C7TxzB07H3bVdOT0+wIQ9YHc1llu
         ylvcgRApRVzKCWVrxaAfs/AfGfTprWR35fHWd6DmbSiiHNdc3wl78forgu/FIIIBqLyP
         Trsfek4ge4mYiLO1EiDcBIuRNS3J/I4i8RAeiyT3DKvmYnlR2Pw47i3rXXO/OK0czx78
         HZSQ==
X-Gm-Message-State: AOAM531bwfYXCG+6FCzHwnQqiL1utgrgCqAzkSsCFLVcmQM/PiC78y+d
        G9IsrA1FMEZDBbPT1U4hABWFezpPpGk4igA+
X-Google-Smtp-Source: ABdhPJyAV0NDgbSYQGtuRJa3UhFmuFjI0av25KCwUmMu/VBcPymQ7GXQViRHYPux/hChhbM5zjVoNg==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr7991825qke.441.1607349540550;
        Mon, 07 Dec 2020 05:59:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z186sm11710143qke.100.2020.12.07.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 38/52] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Mon,  7 Dec 2020 08:57:30 -0500
Message-Id: <1f21ece28497f218f6548c77dfe39dc722656b59.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5a654037795b..6ce46977ec05 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1314,7 +1314,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

