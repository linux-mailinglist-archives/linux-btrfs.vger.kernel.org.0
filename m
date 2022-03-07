Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19DA4D0B21
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbiCGWef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiCGWeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:31 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852A2981A
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:33 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a1so14592577qta.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fi/j1US8JDMyNKb5XHHS5X6gDxRDF/uV+eM2EuPsV/k=;
        b=c3VzyezMJEpQh1ohU4HSDMB3IjOz/cRF/4H9q0qH+4u6EU1wKFGUj2b8FtarcAulq0
         DhlH52HQxNO5Kjv0u4q8GqEiBM2xGjUWA+YP/cgrhESy3vfe17QGfp7A/ZywCwK/zrEO
         C0eEa4rVpD0NECBrANwb3HQTm846XwaVTb0PvGc8XsmLHKlSirKkP+lRX55ErM1a/2yW
         HkiKxYexmHujRql+y2oQ+M1HaptY//1EpWTWbutunEOlU2YS/o+kN+Vdw0P9C0f+uY2F
         /77YhrljB+frPWdp+7/pZl+HWZYbJgrdwBQbyT/8vN0vn7dGabpvKve579qUj2DTV1kp
         pptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fi/j1US8JDMyNKb5XHHS5X6gDxRDF/uV+eM2EuPsV/k=;
        b=saiIYuBxduaEmI0vWBjyKulUzRRdr1hV6ceR5rlf8P4MwlduYYEBLmlwyCzYkfDBi1
         vVOfqHLTEBdfkc59kykgTGR98RamtQhhw2miDd0MjI3TIVRUKD8xKxx6JSTFOxHB/YCX
         eHEqJ1a2e2EYUW1qDtzS181FTVfBrGvOmqgnZXQJzjoAScpeUx8Nt4X4fCLgnEggojBX
         BzwvYESPn6rnU2ALHG9cYekbFkQscxPa+jhywaPLeFroYBnE8VFe/gz7Xh0KrliKmZCh
         uqitl+hypLAyanFmoEyKGuFkDS0V0LJempR+FtYgTDy8YHimKQA1bz1Doff6+I2+tIdM
         QpPQ==
X-Gm-Message-State: AOAM531EkEOEXfITi2jHrhg35GENm4nDA6ML5k3W+OgBBTPcUd4Y+Npc
        RTmVjb1euzU/ckA8+GG/8srW/wQ7wKWeVq29
X-Google-Smtp-Source: ABdhPJwMJqjL+ATjSFCl/UeAXWtQI+4RQyt4HpYAknbBpOHY6zfTPD5XpNmOMbhE5aQwEGfLmq292w==
X-Received: by 2002:ac8:5853:0:b0:2d6:8a16:753c with SMTP id h19-20020ac85853000000b002d68a16753cmr11283503qth.401.1646692412756;
        Mon, 07 Mar 2022 14:33:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b002de935a94c9sm9551655qtk.8.2022.03.07.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/12] btrfs: item helper prep work for snapshot_id
Date:   Mon,  7 Mar 2022 17:33:19 -0500
Message-Id: <cover.1646692306.git.josef@toxicpanda.com>
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

I sent a bunch of patches previously to rework a lot of our helpers in
preparation of adding the snapshot_id to the btrfs_header.  I missed a few
important areas with those patches, so here's the remaining work to make it
easier to expand the size of the btrfs_header.  These are general fixups and
cleanups that don't rely on the extent tree v2 work.  Thanks,

Josef

Josef Bacik (12):
  btrfs: move btrfs_node_key into ctree.h
  btrfs: add a btrfs_node_key_ptr helper, convert the users
  btrfs: introduce *_leaf_data helpers
  btrfs: make BTRFS_LEAF_DATA_OFFSET take an eb arg
  btrfs: pass eb to the node_key_ptr helpers
  btrfs: pass eb to the item_nr_offset helper
  btrfs: add snapshot_id to the btrfs_header and related defs
  btrfs: move the header SETGET funcs
  btrfs: move the super SETGET funcs
  btrfs: move BTRFS_LEAF related definitions below super SETGET funcs
  btrfs: const-ify fs_info for the compat flag handlers
  btrfs: use _offset helpers instead of offsetof in generic_bin_search

 fs/btrfs/ctree.c                | 151 ++++++------
 fs/btrfs/ctree.h                | 411 +++++++++++++++++---------------
 fs/btrfs/extent_io.c            |   6 +-
 fs/btrfs/struct-funcs.c         |   8 -
 fs/btrfs/tree-checker.c         |   4 +-
 fs/btrfs/tree-mod-log.c         |   4 +-
 include/uapi/linux/btrfs_tree.h |   1 +
 7 files changed, 303 insertions(+), 282 deletions(-)

-- 
2.26.3

