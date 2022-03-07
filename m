Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484614D0AE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiCGWSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbiCGWSu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:50 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84B36152
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:17:55 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v189so4307167qkd.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mE7h6t+tm2kmibFst366o91JrFPSGHuGEtXgpi3M0/I=;
        b=MFu5p00/vO5pb+ca6wAyaJDg1PZcsgF/E3p7Qe5FIhsw13rzOHKced/UJGeBbY9pSG
         k9hXpuE7sO3uaGXvXtu3fW+IByN48cRam41/cFz141FlfCDtPs7NASdPU5SkVS8o7IUL
         sGgoKbVIVgB3RFMCcsH2TUJUVTEgOxsHUFPUuzZJFdNFhdMSjbb0anrarxoD3JfSKa7M
         yO/4mPMcN+qnYMqyq99gugIedwHEtETwmSwiSTOz278McI+Yh9fyT1xnB2l6k1INkhwD
         PqY0/BfrbNRj2pnGbD+EUHbtWqkIJNhWCEkw8nANdpS2M2p1CovmcavZ5tO9q330Yw54
         2JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mE7h6t+tm2kmibFst366o91JrFPSGHuGEtXgpi3M0/I=;
        b=tmWivTJlw/BCr/4sYUBOo91mGejDbmENPQMMbGyD0HtHAdeqkVvedaqotf00WVy41x
         GVYH8fKJf76zS6Pdz8f9636O/xk/QgalzZzsq22gDusctN14bQa5/N8Z36+YGMFORynk
         PMkac2RkalQIAJI2AKF2EviKbiJe+7T3oqBDtUFdnrj3WSlA8vmqNjIDZ/u7DHdCaDGc
         nd/aS8PHpVTliT/72v6Y3mKiKWMawwXy6rHw35u1PC2GTV8G6rQHVm/03/+HQAgB+jUQ
         l9FMaah+I09knUBh4p5EmZLmUndeLF5bqV4oi/wFaM0j4j9Fx6i+Ahfz22xAO0XOI7Zy
         fFyQ==
X-Gm-Message-State: AOAM531Up2xVHeGJQKwAs/TE+tIJHfkfCyMwmnLgREV5PFFWF+PrzXiW
        BaINzlIacjlDT4zZZ7IA55g15TEV/v/CVwIO
X-Google-Smtp-Source: ABdhPJzi6JTCR8n0tIieEuVQZ3KVVRSTKSag5kroD6JAkOSGJk9NFKE3wheWOVVFVd1kRnVQzsdb1Q==
X-Received: by 2002:a05:620a:12ba:b0:663:6779:beeb with SMTP id x26-20020a05620a12ba00b006636779beebmr8160345qki.227.1646691473815;
        Mon, 07 Mar 2022 14:17:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p17-20020a37a611000000b0067b2b2c41fasm2055262qke.81.2022.03.07.14.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/15] btrfs-progs: use item/node helpers instead of offsetof in ctree.c
Date:   Mon,  7 Mar 2022 17:17:36 -0500
Message-Id: <4b80e8a3e4abf81e291bf37ed0c5af29d45661b4.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_bin_search we use offsetof(struct btrfs_*, items/ptrs) to tell
where to start searching for our keys.  Instead use the appropriate
offset helpers to get this information.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 758a3882..8846836b 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -858,13 +858,13 @@ int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 {
 	if (btrfs_header_level(eb) == 0)
 		return generic_bin_search(eb,
-					  offsetof(struct btrfs_leaf, items),
+					  btrfs_item_nr_offset(eb, 0),
 					  sizeof(struct btrfs_item),
 					  key, btrfs_header_nritems(eb),
 					  slot);
 	else
 		return generic_bin_search(eb,
-					  offsetof(struct btrfs_node, ptrs),
+					  btrfs_node_key_ptr_offset(eb, 0),
 					  sizeof(struct btrfs_key_ptr),
 					  key, btrfs_header_nritems(eb),
 					  slot);
-- 
2.26.3

