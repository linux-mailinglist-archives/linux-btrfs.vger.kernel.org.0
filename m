Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E20D44B01C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhKIPPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhKIPPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:15:00 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8EDC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:14 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id de30so4938383qkb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9w7/+PEuqqwnAwz9UNZSbysRdIjE5uCBFXWYa+CI92c=;
        b=3wS965n33S6q8OhEGIPv71wBbQSYaZ2ecBUXRrvq1oR8ZsJBZzCtO58TdhAy/+d2E/
         1ICbVjWVtVTCZPGKkNaiWjKmnq0+rqcYrlRh58qQBOJ9Btp1bUhim70ab4T9HGHhdUcC
         czU1iWWBNrR6NqJUySoe+0CJm2fxBSbE0j0SzBcRrv1ovqemb1cMZfUMWzvS3Qe26/DZ
         0G76TVRdGIefVK96rwoPAh78m7pMs/sDJdVXos/7JsgRs1peqp8RmtGO2G/sQ9WV0TLV
         taSDsEjwPhgn3BJL/taaDvdUw82ZE+dCy2ik7gbth1GgtfegoUG/qrMQi+av4DTXN9E8
         UScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9w7/+PEuqqwnAwz9UNZSbysRdIjE5uCBFXWYa+CI92c=;
        b=OfAgTOeNtrKzmOJtZ0JIUJGkP7P4oyoxdncB72XoAtgmV9WHWCYyxHo40VoMCg/pgc
         Pwo2yaxmHM7j841MfY2nano1EMHyVXLplqhTSU5UrZIZuR/R+oJWA5nX7+FdqwXSDU+E
         4Etaw2yRRIdntnVcpvxZOvPsWEydI9jERWni/Xem6S9Z0XLxNHpRsDnp1NSpnRoOgXAs
         QyesM0d6movmhNWKCMF0rfYt9SMwC2NCmfvSNq4I7CDrQTnIxRs7QI3Wq9Gq0xucQmm3
         drBlmsE/M6zvs25rTy1vgRiZH4ZYc4ZHLIpF8jfwEUPto+llM6I0NgHSOI31LZCtEEj2
         4DfA==
X-Gm-Message-State: AOAM531DehcM9wDS6iC9r1pP03i2TzOPafVFnXIXnZPiAQpomw95RF9B
        aT8IaadyKFZWrAYtrIjZHCpv5VUhX+yr/A==
X-Google-Smtp-Source: ABdhPJzYAzR5R2v7nHyt31h7cykRBDNU4RhLfytlLKFw0y5A0pvHpAjr+I0+vV6/zMy8H6kbQ3ewWA==
X-Received: by 2002:a05:620a:4044:: with SMTP id i4mr6320831qko.319.1636470733227;
        Tue, 09 Nov 2021 07:12:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13sm7306477qtw.33.2021.11.09.07.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/7] btrfs: check ticket->steal in steal_from_global_block_rsv
Date:   Tue,  9 Nov 2021 10:12:03 -0500
Message-Id: <ac8ed2e738287a01338f8c0d502bfb46c18cc888.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to use this helper in the priority flushing loop, move this
check into the helper to simplify the logic.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9a362f3a6df4..6498e79d4c9b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -844,6 +844,9 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 min_bytes;
 
+	if (!ticket->steal)
+		return false;
+
 	if (global_rsv->space_info != space_info)
 		return false;
 
@@ -899,8 +902,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
-		if (!aborted && ticket->steal &&
-		    steal_from_global_rsv(fs_info, space_info, ticket))
+		if (!aborted && steal_from_global_rsv(fs_info, space_info,
+						      ticket))
 			return true;
 
 		if (!aborted && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-- 
2.26.3

