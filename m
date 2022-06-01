Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23FA53A9D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355181AbiFAPQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354999AbiFAPQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 11:16:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E339159B
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 08:16:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id p123so1537897qke.5
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4nLfhtVjThLJOBWzaURdvTe4KZz4vjOxdl8B1WrSqw=;
        b=zRWp3MkdE4gSQ9AkLwt/nagne6DXwUXSvhXM6l3dXHCS6yhkHCznQq5A4t4O5SYCdc
         3pWjzQmHxEBOeiTNGBrW02LjJKmPxg2K9esmcDgGpdfWuZa4g5OAUdakBB2EBSsuNXjB
         v7NN2NqZIN9EeUJZQGdMyLlog7KFE6IqpEyg00/YI6gJp+lmBIE7C0rQ/s3GLzCXwGRt
         wNSbU2MP0UuG7o/QytUxtY0ZdgE3Kvhup2VEJhB314wnGfOjulSNHu33RdjecT5wQ5PN
         /uYvxDqEgY5gdJ6RN8EYIELBGYXVTRqFCKhsVDfEJ09lb90vOe/KlVJGCbYd330LRUIt
         UrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4nLfhtVjThLJOBWzaURdvTe4KZz4vjOxdl8B1WrSqw=;
        b=roNt9Y2xIp9nvwI+DrE8NNF8BZGvMropbJMjB9k/8pLiG67E5cgyB+j1NLI3c527Si
         TkeIDamonK8s+D4zcjENtqaaXnj8VH+1jr5U6YER1UAqbHmVCLD2qklA5Je1Vqf8Ey3j
         5oZOdrlJdgjjS4qFxfaHKaPEE8WlcxIWstL2naagSnj6cagbumd2uPpwP2bSl9ilJuKR
         T6vE1WpjOO65SsPoBPiTyGWDVF/zGtq9vEZv48vFGSfaTq5MBuGhjv+1Bk/4S6EkkrmA
         Fg0IJWZ0/Ud+MN7LiVKcteS4DeNtlfON5fbSeo9VPYehggLYEThPXMZ5nDfacp6Xo85t
         /NVQ==
X-Gm-Message-State: AOAM532j1YtiR24P1Sd3I1iYXpsVOW3eXdJ445juJB73i1Dutva2/5FA
        EIJWaD0XyV2ofrJ9kXRwKaykNzZr29SWfA==
X-Google-Smtp-Source: ABdhPJyaTy+XysSKlxLGJ63xKn9DKq5A6wmk8jcAL4dOsFrzuKuBRfG0ED18CQkaWZGoMz6G2AT5Jg==
X-Received: by 2002:a05:620a:c52:b0:6a6:6b8f:eac2 with SMTP id u18-20020a05620a0c5200b006a66b8feac2mr414179qki.643.1654096586875;
        Wed, 01 Jun 2022 08:16:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a22c100b0069fcdbabdb4sm1357756qki.69.2022.06.01.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:16:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: fix deadlock with fsync and full sync
Date:   Wed,  1 Jun 2022 11:16:23 -0400
Message-Id: <cover.1654096526.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

We've hit a pretty convoluted deadlock in production that Omar tracked down with
drgn.  I've described the deadlock in the second patch, but generally it's a
lock inversion where we have an existing dependency of extent lock ->
transaction, but in fsync in a few cases we can end up with transaction ->
extent lock, and the expected hilarity ensues.  Thanks,

Josef

Josef Bacik (2):
  btrfs: make the return value for log syncing consistent
  btrfs: fix deadlock with fsync+fiemap+full sync

 fs/btrfs/file.c     | 67 +++++++++++++++++++++++++++++++++++----------
 fs/btrfs/tree-log.c | 18 ++++++------
 fs/btrfs/tree-log.h |  3 ++
 3 files changed, 64 insertions(+), 24 deletions(-)

-- 
2.26.3

