Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F231794DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbgCDQSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40558 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id m2so2164189qka.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n0y5JizAt/b6Axu+Sx+7mJul6hajBxGZXBIZfNOq4aQ=;
        b=dKG1VhG1RH5Iu3TJToRAK1H6kNoa6W1nIoUNkulE6LLFlU5QLOm11wqe9plOOiISCl
         0Wqyf+PfN7ML0UTAinNSEHjaBtX/B8zhc5339Eb0FrLC9njAdPnmvL+9h5gmIQo5mGeL
         Viv49Dqbzk//23uigM3nEywG+NWerAFc19/jUTw+66C5tuPOhkUS+7n9BgTXMyDTFGn6
         jagXDVJYEOfuwcrbuH5SNbfWJ7V41Y3Zkn3QU57cRz032CKqkqcxnsnTgMwT1QMl5ym+
         FvsnbV9+pSPt8G3F0jsyalHoIFeOoEyxPY30mLPl+C7j4Lt37B8VoTOlIiXFP77+hMhN
         jULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0y5JizAt/b6Axu+Sx+7mJul6hajBxGZXBIZfNOq4aQ=;
        b=JON5IMr5ogPEBvCZoUX7EieweHSDn6L8oq9f3XZfKB0xWd7TqWesgvKfCAmDCbVZEd
         g4bIyP3izB1119lPQtWbGJREdUYm0LpIATlb2ftT4XzNpLx4+yo25oVVEu56/IsZMM2E
         4UJfXEU9JpLOBFy2Uxao7nBY8G/wBl7bscj8g+7FxV429z64JCjVkjgTuLPkaZnP0Zlv
         gw3f3n8andS/qta/E5H0MctaLyl8MYMigxPtCk7qxqt9ACICp7JxqUpcP68BnHK6kl2Z
         QsrlKYbyL3A12vofSoMdUl2TLO7bzxVM37mbrtjVvORhl313eF8bsPtsWC7eDlmnR05+
         y8ZA==
X-Gm-Message-State: ANhLgQ3ht0uynXRHxuOYkbGtkNQEGUkQDjbvH2w1kQGJ8Rbem1TSj+/m
        G3bd+fkyyJnTTTHm4f6+r/WScmXh4E4=
X-Google-Smtp-Source: ADFU+vu4EIAja6fwi4WW6PNEuHj1Q5bCwU4M3WpF+QKUoy6Yb/p17OkxEOmrqijShBS++WUhcHAFHw==
X-Received: by 2002:a37:b48:: with SMTP id 69mr3577405qkl.362.1583338716305;
        Wed, 04 Mar 2020 08:18:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t3sm12513766qkt.114.2020.03.04.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: do not init a reloc root if we aren't relocating
Date:   Wed,  4 Mar 2020 11:18:24 -0500
Message-Id: <20200304161830.2360-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We previously were checking if the root had a dead root before accessing
root->reloc_root in order to avoid a UAF type bug.  However this
scenario happens after we've unset the reloc control, so we would have
been saved if we'd simply checked for fs_info->reloc_control.  At this
point during relocation we no longer need to be creating new reloc
roots, so simply move this check above the reloc_root checks to avoid
any future races and confusion.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 507361e99316..2141519a9dd0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1527,6 +1527,10 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	int clear_rsv = 0;
 	int ret;
 
+	if (!rc || !rc->create_reloc_tree ||
+	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+		return 0;
+
 	/*
 	 * The subvolume has reloc tree but the swap is finished, no need to
 	 * create/update the dead reloc tree
@@ -1540,10 +1544,6 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
-	if (!rc || !rc->create_reloc_tree ||
-	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
-		return 0;
-
 	if (!trans->reloc_reserved) {
 		rsv = trans->block_rsv;
 		trans->block_rsv = rc->block_rsv;
-- 
2.24.1

