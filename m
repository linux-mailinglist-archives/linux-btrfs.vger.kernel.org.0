Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D418788FB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjHYUUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHYUTk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D195171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:38 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-410a2925972so7209311cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994777; x=1693599577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=htraD9ANz+C0wh7ZMyaX+vtTHBgZrivxk7LG4P1ZeNU=;
        b=WxdSQbkLSACBMlXd6LnbhgUbFG/kV7OeTA8BZHfBKQ/UCyHGBjGtAlDF1b4y5vKs2B
         VuXga/hdfJptaquI2RshljkYCjP4r3HlYopohB2361jcyXeHXlgIDa533LO8Qn7lCDKL
         nWIHcehh5YqQq5tucBGDil+CGpVfhvI1E7lMnEdIyXE49dtDvbD3e0dR/j7FO8NsMCNS
         +QI9BQKiqPZA/YMYX+IiZwDUEjnVdJriwDnLMcaa4Hyxwc63xsLWWl+5b57WK9h1W1gX
         g1CDSMApkn97pqj1V/pwTGv+5K395vXyMnAZcF9Jo+vZf1oXtxAx8e6t9hoWBn7mgfpt
         GWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994777; x=1693599577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htraD9ANz+C0wh7ZMyaX+vtTHBgZrivxk7LG4P1ZeNU=;
        b=Gf3PjRqdwK1H5fL8hGdOXyixlPHuP/wxiQb42Qlsb67jt7auaP7oCQkwJWgoAilcpB
         r2wvtLKjoTu0uqHF0GDI4Q2mY7aSQMiuca1ONFB1Ilb4mlqjRkVvsM1Vza99MkPzVSoM
         RFnLpdhqVIDuKwKn1TyxwOszieK/Ltwclt0+avmZzm1wecgiPOPOPrCVDCrin21Qud6o
         qUVwwI7z0AH4YMpx7DAa2uQCAbv5fZNgDBmttps2ba+SseM03uzqIYs7S3lNmBkwgVOV
         vPRi0lkbU6ZZFNisulZZaJqxWoIqN87HxceVvErAwqx/AXZmq7lT6QF/m/VPODqWQ62A
         zZIg==
X-Gm-Message-State: AOJu0Ywn7mfVek88vewZuBvJ4nqIwyj+EZjN165wkKIO6DKK06bdQx0M
        FK0UgjbN/i7a3wcy5PSTxiDPfbUBCuN3UcWv3Zk=
X-Google-Smtp-Source: AGHT+IH1eem7FDjVjpd4l3lgbt65bYUk7iyuiNjEJARwSMQM55INKenS3SVoBlnFzMNCJAdD5YmANw==
X-Received: by 2002:a05:622a:1993:b0:40f:c5ac:8e1d with SMTP id u19-20020a05622a199300b0040fc5ac8e1dmr21585358qtc.55.1692994776915;
        Fri, 25 Aug 2023 13:19:36 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id kf6-20020a05622a2a8600b0040ff234b9c4sm732553qtb.25.2023.08.25.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/12] btrfs: ctree.[ch] cleanups
Date:   Fri, 25 Aug 2023 16:19:18 -0400
Message-ID: <cover.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

v1->v2:
- added "btrfs: include linux/security.h in super.c" to deal with a compile
  error after removing it from ctree.h in certain configs.

--- Original email ---
Hello,

While refreshing my ctree sync patches for btrfs-progs I ran into some oddness
around our crc32c related helpers that made the sync awkward.  This moves those
helpers around to other locations to make it easier to sync ctree.c into
btrfs-progs.

I also got a little distracted by the massive amount of includes we have in
ctree.h, so I moved code around to trim this down to the bare minimum we need
currently.

There's no functional change here, just moving things about and renaming things.
Thanks,

Josef


Josef Bacik (12):
  btrfs: move btrfs_crc32c_final into free-space-cache.c
  btrfs: remove btrfs_crc32c wrapper
  btrfs: move btrfs_extref_hash into inode-item.h
  btrfs: move btrfs_name_hash to dir-item.h
  btrfs: include asm/unaligned.h in accessors.h
  btrfs: include linux/crc32c in dir-item and inode-item
  btrfs: include linux/iomap.h in file.c
  btrfs: add fscrypt related dependencies to respective headers
  btrfs: add btrfs_delayed_ref_head declaration to extent-tree.h
  btrfs: include trace header in where necessary
  btrfs: include linux/security.h in super.c
  btrfs: remove extraneous includes from ctree.h

 fs/btrfs/accessors.h        |  1 +
 fs/btrfs/async-thread.c     |  1 +
 fs/btrfs/btrfs_inode.h      |  2 ++
 fs/btrfs/ctree.h            | 52 -------------------------------------
 fs/btrfs/dir-item.h         |  9 +++++++
 fs/btrfs/extent-tree.c      |  6 ++---
 fs/btrfs/extent-tree.h      |  1 +
 fs/btrfs/file.c             |  1 +
 fs/btrfs/free-space-cache.c |  9 +++++--
 fs/btrfs/inode-item.h       | 11 ++++++++
 fs/btrfs/locking.c          |  1 +
 fs/btrfs/props.c            |  1 +
 fs/btrfs/root-tree.h        |  2 ++
 fs/btrfs/send.c             |  6 ++---
 fs/btrfs/space-info.h       |  1 +
 fs/btrfs/super.c            |  1 +
 fs/btrfs/tree-checker.c     |  1 +
 17 files changed, 46 insertions(+), 60 deletions(-)

-- 
2.41.0

