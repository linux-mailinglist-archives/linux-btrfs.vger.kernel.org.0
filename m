Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E34C7DD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 23:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiB1Wys (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 17:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiB1Wyp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 17:54:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243D15A20;
        Mon, 28 Feb 2022 14:54:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so27854704ejc.8;
        Mon, 28 Feb 2022 14:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsxpUBdbWqhwvtlxJIKUlO0M2+Pr5nAVEC771c3QJ/k=;
        b=qchEkZ+1MqfOevkqUl4bSWLuZ7qjRLt9ku6OqIaZEEvQ1Qk7/DLqfnsHlKbEjJ10us
         LBhkjSIMZFSgCJvtojYCJpCHh8YzxsTVbhucBhA3VsJ7C2TAf3Lwqgr+BzzmjPD/0yBs
         UPo3BEBR0JiOfO+4v6eAy2FQqGoH8T+gF8QsSywoL7HNpkTyUPBGPPXBrUD9j3OCBk+l
         a5MnWFXFk1Dh2LVWDtF8lL7/kc1gLTmo5cRoTBoQVJ4CG+tmbr2WsDPYw2OiPBTnmV0t
         /g37eAyk1nRwEr1HkAsix34OpgNgU2BJczZO3qlGo0gA8biAcALfGZ0VoP8EEnvquJUA
         Nsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsxpUBdbWqhwvtlxJIKUlO0M2+Pr5nAVEC771c3QJ/k=;
        b=5dLqgCPEbvaoyZBCbFSH2f0YwVrW5APitT35avcmRtd1cN3ad7pLsnSceia6NZgS+l
         czASbRKUYb0NeYIs87BDoLdhgocXwel/2U15IWEgvlg6RR6SnkrstLu3p54WD2FthRKu
         V7g6/FliUmqLXDjzTyfZJ+emOkLFiTSb/2jyXDstkJ66EMC8O/RrY7OhtkEDaVlcf3im
         ln2CY7ZoWPK18BpFZbnFf3jS4i+om+a4LNQwVDVPCLLrwX3TEpabqP0S9Rk78aVXjVM1
         nRZydnR9kfOw5lMBBt7gks/Hs6cC4lBjS55TOqoxO6FXWQ3bmgxp6JyFaOrhR1glU//N
         e3Tg==
X-Gm-Message-State: AOAM5329SM5X//iobKfIrm/ep+0jrLhgHTcWKUGksnOVsumCLL0W+PaG
        NVJC6xeJysa4tELCUwMXeD4R/FwZfMpedA==
X-Google-Smtp-Source: ABdhPJyur+cHELdmew+tmID4EL9f/bRsLWeA8a6eqRSDwNoW6BmeK9qZpctr7JW7zqp7OBQXQFCesA==
X-Received: by 2002:a17:906:814f:b0:6a8:49fa:a3f5 with SMTP id z15-20020a170906814f00b006a849faa3f5mr7020486ejw.421.1646088842504;
        Mon, 28 Feb 2022 14:54:02 -0800 (PST)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm4736885ejn.169.2022.02.28.14.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:53:22 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Niels Dossche <dossche.niels@gmail.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: add lockdep_assert_held to need_preemptive_reclaim
Date:   Mon, 28 Feb 2022 23:52:16 +0100
Message-Id: <20220228225215.16552-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a previous patch I extended the locking for member accesses of
space_info. It was then suggested to also add a lockdep assertion for
space_info->lock to need_preemptive_reclaim.

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 fs/btrfs/space-info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 294242c194d8..5464bd168d5b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -734,9 +734,13 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 {
 	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
 	u64 ordered, delalloc;
-	u64 thresh = div_factor_fine(space_info->total_bytes, 90);
+	u64 thresh;
 	u64 used;
 
+	lockdep_assert_held(&space_info->lock);
+
+	thresh = div_factor_fine(space_info->total_bytes, 90);
+
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved +
 	     global_rsv_size) >= thresh)
-- 
2.35.1

