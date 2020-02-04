Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88E3151E30
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBDQU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:28 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36370 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbgBDQU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:28 -0500
Received: by mail-qv1-f68.google.com with SMTP id db9so8821429qvb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T16D4KpUfD+VeKmMCnNZrQTe6CgUn2Z9IXHSJ0DsJmg=;
        b=garsFwMSzqDGuoblilWp8Wai02TMCt5PfLB44RPsIPZRXm4Wi3WcjIkuS+xqccM0qc
         +QAaGmDT2IaEoqWzZN/BBbOTPyCUzaD6CzPXDl+2yjB8DZAN1qa+kH15SUqYbJLfcGxQ
         qQmM1EDLTsvvNgOxqT05gBC+WxhvI6VbyLbwwMnvbM68aHAz+tx0uIVUCPVWALPhTZJr
         RqYAj2DQKle1Yc1zsC9J3TqWiXIUkJokBOw7wF9zWHf4CUT+hH1izgLDny/keI5mNvO5
         SoQgUDcYka8JyRsf+36zT+oL+bJ3dBlGVLFiG9lfnEU2+agSiNxme38OAVR+DIggiDpe
         rIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T16D4KpUfD+VeKmMCnNZrQTe6CgUn2Z9IXHSJ0DsJmg=;
        b=S9wpXdvgx8mriDqJPGGHFMyzsT1BWnD5/usSAlR66mgC9w1wD9Rjc2Vg7TslRKznhn
         XYA5ihmV0zLQD7pAFPwOy31CbhgsKDjkoAOrsG64ZIv7+sb+R+8gqmE/FbCJiylDkRB+
         hvjlZJ9LsSyAAWqxT3B7B3KAPNTt0t0VlbU14DoShaZWPHdF5/ERh2lukaQdqRPnNx6n
         Caz5k2WOZE8rNEPrZq9+CGmzuHyEmAfo+1NEN4TqZk+17Ytt7PemH7e0Wav5wi0V5teF
         +oGsJTSLrwfrDx8YvJ4cmGa9SzctvM2Wu2fCANLU+cDrEJp0UiwIrYyxdMRmWbrhFKna
         b1Ag==
X-Gm-Message-State: APjAAAWfFrcBTvYmgHMrBv2tNMwR+zvSKwwNlya8oqRVRL1dkPpq3ep3
        3rMClKOPg1J9p3/yeRkT3MBLU0UJKzeoSg==
X-Google-Smtp-Source: APXvYqwSiY6o2EaKT/98y2YxPEjjVtpJA9E2tRQa4Hweo1NV0M1pU8TGKF39S0erkH01N9RHrrcYMA==
X-Received: by 2002:ad4:4aaa:: with SMTP id i10mr28821083qvx.27.1580833226980;
        Tue, 04 Feb 2020 08:20:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v125sm2211738qkb.52.2020.02.04.08.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 20/23] btrfs: run delayed iputs before committing the transaction for data
Date:   Tue,  4 Feb 2020 11:19:48 -0500
Message-Id: <20200204161951.764935-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before we were waiting on iputs after we committed the transaction, but
this doesn't really make much sense.  We want to reclaim any space we
may have in order to be more likely to commit the transaction, due to
pinned space being added by running the delayed iputs.  Fix this by
making delayed iputs run before committing the transaction.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index abd6f35d8fd0..d9085322bacd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -804,8 +804,8 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
-	COMMIT_TRANS,
 	RUN_DELAYED_IPUTS,
+	COMMIT_TRANS,
 };
 
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-- 
2.24.1

