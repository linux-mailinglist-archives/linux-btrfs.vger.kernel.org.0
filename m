Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEB74A196
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjGFPyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGFPyG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 11:54:06 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915FCE
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 08:54:05 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-570877f7838so11125197b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688658844; x=1691250844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTw1TFoUQEHXrahHk9vtaBnSr8uzXunGjbxtmL4QSZA=;
        b=CT14FvSgCqguUrVB8KtUs2zkwF5cuk25Ahtmpb2Jl62wrsZpx2z0v7gmMBlN1ajQqN
         P+KB4wpbXkU82iw7etcr08hnl8MLnh/bFlIBW7ePDafPFD78E6MfTWlrY25xr6hf2tGk
         rvfes9mMH12pikgzcpp0GJSRqpgC0efllbuFWUIiC+ziXay3XxdYDJE6og8LiNslLzx+
         gFGmD+6reYSwL71uhWijjRZxitwEGkVtpJzii8Lc3LWNcoQWKcA5/39F3MAUbQnr3DPC
         H+a7hB2rHFF2pnEjiFvyAE/2+R8FPF+ku2Lm42iwfgBL2TKv4NNMaj3SSVOfRdYdsa5b
         pKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658844; x=1691250844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTw1TFoUQEHXrahHk9vtaBnSr8uzXunGjbxtmL4QSZA=;
        b=jGlB7aKhk42wCeci4jpIItlfMu/IHx2hTT1iLx8MZqODJ2c643Cx6GEPqZIxL4TCBX
         U3sXuGjrN3MQNhuLGc/dMkTQow2XS5389sShV2+c5OXiI8pTJF0AzFMi4NEjWcoOYrRr
         Z/vrUKLiG0psjeqm61b3nCOVu4PtSpX7itQl68oeKJUl/LjAMBS5hJ8v/bDYdai7cC5+
         8RcXNlt7wXNHyDW4qi1NyI95Hp3KuoIqFFzDnnCmqKUY2VPUfKW/HYCKoqn9EjsiCJKP
         pWGPlMkSy+BavRs0GcOnF8qHzrfzkpOXuQDz5+jFmtO4ZAPQmh+ZURO7Ty5aI3fHlTzT
         fMtg==
X-Gm-Message-State: ABy/qLZeVDX6ArIJ6XqCkqzz1OG4WKrXPJwQwgiqbPL/H+4kpvPtCfee
        4abRmRFCXT8GtYYNQEA3P9vhHvr36Fiyq/H0KHhCPA==
X-Google-Smtp-Source: APBJJlHOVkcuBjz9qdUnY+n3sSwAdOZQSY6yYuxC6WlKPIhBc62RIGr686iVvrzrk9XAVP70APnQWw==
X-Received: by 2002:a81:4944:0:b0:577:4975:c114 with SMTP id w65-20020a814944000000b005774975c114mr2615196ywa.0.1688658844420;
        Thu, 06 Jul 2023 08:54:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u184-20020a8160c1000000b005612fc707bfsm417114ywb.120.2023.07.06.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 08:54:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] btrfs-progs: some zoned mkfs fixups
Date:   Thu,  6 Jul 2023 11:53:58 -0400
Message-ID: <cover.1688658745.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

v1->v2:
- extracted the minimum calculation into a helper as per Christoph's suggestion.

Hello,

I'm trying to get the zoned block device tests running and I ran into an issue
of a long running test because scratch_mkfs_sized failed and we tried to fill up
a giant fs.  Fix up the error message and the math so this is correct.  Thanks,

Josef

Josef Bacik (2):
  btrfs-progs: print out the correct minimum size for zoned file systems
  btrfs-progs: set the proper minimum size for a zoned file system

 mkfs/main.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

-- 
2.41.0

