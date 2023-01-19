Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC046745A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjASWO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjASWNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:46 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1977AA733E
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:34 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x7so2704330qtv.13
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W1ynQebnKH4VSeXjmhH7rt8v41FiS+6N7Vz+CoRsSg=;
        b=R50aPaxZQm0D9XCcFB454K2yEV1d5E5UclzOL1wXK1JEUGGvvgTsFDaVKLSPSPi/wT
         xmB4D/+UzirdTxOyNhrS5soMtGzabq02rf271TaqUp7ApDY+NJP06s5W0pdsntQ5oSLU
         6aX72Ggo5fG9p/pIc2IX9COzMjZGv9Hbp+2UWFYEgmNM9RylR70AiTii0Tz+KUlTm+E3
         YMJKity8iGFc0bajy1P2r+bQpMbgG8zsXzBh01fSo1/gQ4pOgwvopIewxL7qIq3cdFVy
         rf72EopOiYrRXZ9X9UVwgjgTfAYwa1f6VYttRxa5qw/ndUI/2pnx1nVQDDzabBB0zemZ
         Q3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W1ynQebnKH4VSeXjmhH7rt8v41FiS+6N7Vz+CoRsSg=;
        b=RsShPYJ7m7wSqYM4z/YhmCIeryjMDfrgFNYVx0a35s9Sao19dmvD3hZb0e30bIqtaW
         /+dSSn+0PuROZGRAWSC1W1uK5VUPX9bQEkFso2JOBBSKyJs97u5j24Zl2MbQZpncRv07
         Hgo3SSVzoAcC4Bke/TULHkqI5rjXEuphrPpMT42aDNsJDHrVVMjaaV2d18YavQKwRpib
         cqxN7fqEDSwUsqSjzYDuK8MddaJehXYz63VmC9XvHKq3WGfYgwqGOTiSsTr64WcsIhAH
         M4w3tvIRytHK4ytTQJkSHMTmIZa1MhyLSsb7SSt6SOL3x3zdnTo70QbjB2YlnCdrUf6u
         IJSA==
X-Gm-Message-State: AFqh2krZvcbTD+zmxN71qPCh6JegpArx5zVd64u+hCbb1PKZeLJk/P99
        hXjN4H+AimzJfSiIxGaFHWXsYpooxfx1mahWd6A=
X-Google-Smtp-Source: AMrXdXvAkB+QK+vVQmFrOGSVS8bATpZeAKb358BDVCXjm+8mvRdFtqDRrg6DafhY/6X1OuWz81y8ZQ==
X-Received: by 2002:ac8:748e:0:b0:3b6:2e37:3394 with SMTP id v14-20020ac8748e000000b003b62e373394mr14509074qtq.27.1674165212857;
        Thu, 19 Jan 2023 13:53:32 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bm16-20020a05620a199000b006e16dcf99c8sm24972118qkb.71.2023.01.19.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/9] btrfs: do not set the header generation before btrfs_clean_tree_block
Date:   Thu, 19 Jan 2023 16:53:20 -0500
Message-Id: <0f34253ba98170618a777e227e467e3a549afd4e.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were doing this before to deal with possible uninitialized pages
which was reported by syzbot.  Now that btrfs_clean_tree_block no longer
checks the header generation simply remove this extra init.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c85af644e353..971b1de50d9e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4897,9 +4897,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	    !test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
 		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
 
-	/* btrfs_clean_tree_block() accesses generation field. */
-	btrfs_set_header_generation(buf, trans->transid);
-
 	/*
 	 * This needs to stay, because we could allocate a freed block from an
 	 * old tree into a new tree, so we need to make sure this new block is
-- 
2.26.3

