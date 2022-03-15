Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5B4D9216
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbiCOBN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbiCOBN4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 21:13:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D544744
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:12:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u17so14834061pfk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhYCjceedkOhfLVvIPgzqFAc5vdpdd3baVoscD/gnes=;
        b=MkaRA0K5Qe3GhXhTIOHYNHxUTI/XIoWQROQ34so+yHydrpp4R8Cc91p248nljyPgJe
         seRswG3xJffJm/5dDbco0djjMuHjSb6B22KxHvFCQFNcWro0ScNyVh1P/BjKu/7OJyJ5
         sgglFHXq3bhgsHFRQ88w0Y8Id82/CXwRxkddEuFp4L+zi0D1ey35mCyrwUQtsb48CdS4
         pHBqonMb0HSwA4dkNA+2rwOX1O7XDLHXnsI+KWen9/lui8FlWnSNzFi9HyB8IA9ZBpMz
         /YiT/cZxZvHLn6KdiLlDtviSttEyhGVrmF1z1t4qgjjpL4xo8s9+SF2oaTt34p04Uluf
         TEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JhYCjceedkOhfLVvIPgzqFAc5vdpdd3baVoscD/gnes=;
        b=EJpWzwbChhzGJALeis0j7e7U7mtEbSsc8CXfMBrBO6uk4iFHmxkXpCphmXoH7c4sAx
         GrsmQqRB+W9LJ4WRRAxPECB2yb/rdle285nvZC64HPnCriDr9qQdNnQk7WLiifQ9DpXX
         XNTpNHced6GGnwFY/r/ube3RsvIh10e5HQU1Afz0E5kPNrkRQhI3TZP8FLHFiefU8inj
         46cPzqDUqOuwHdlBytfeHVloXR1nbIyho/wL6iQb05+fPSwYU2e+GEmiYegD1wWZUA2p
         u7vrAqQKARSF+3s/LYdxhJXaD6Wop/WdcNINOWHmbF7PUuLLN0jON7dTO9QKoMURL4K8
         7fdg==
X-Gm-Message-State: AOAM533eoDLjT7q0bNiSYqRYfnmuW88ERpCCcIhxEspIJFG3+OizIKj2
        fOjXMF67jX6d+GpYsUpixDDf2lL4Dl6SsQ==
X-Google-Smtp-Source: ABdhPJz0RES5oBzJNm81vPbZcqgKABFEss35D5vmx4xaNkDY4U+cABYvYsgNJJqFzWq4y6CkcJsfHg==
X-Received: by 2002:a63:7c5c:0:b0:380:7412:341b with SMTP id l28-20020a637c5c000000b003807412341bmr22146048pgn.38.1647306762894;
        Mon, 14 Mar 2022 18:12:42 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm724609pjb.52.2022.03.14.18.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:12:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v4 0/4] btrfs: inode creation cleanups and fixes
Date:   Mon, 14 Mar 2022 18:12:31 -0700
Message-Id: <cover.1647306546.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
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

From: Omar Sandoval <osandov@fb.com>

This series contains minor updates of the final four patches of my
previous series [1].

Based on misc-next with the previous version of "btrfs: allocate inode
outside of btrfs_new_inode()" removed.

Changes since v3 [2]:

- Fixed a struct btrfs_root leak [3] in patch 1 which was fixed later in
  the same series by patch 3 for the sake of git bisect.

Changes since v2:

- Mentioned reason for removal of btrfs_lookup_dentry() call in
  create_subvol() in commit message of patch 1.
- Made btrfs_init_inode_security() also take btrfs_new_inode_args in
  patch 2.

Thanks!

1: https://lore.kernel.org/linux-btrfs/cover.1646875648.git.osandov@fb.com/
2: https://lore.kernel.org/linux-btrfs/cover.1647288019.git.osandov@fb.com/
3: https://lore.kernel.org/linux-btrfs/CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com/

Omar Sandoval (4):
  btrfs: allocate inode outside of btrfs_new_inode()
  btrfs: factor out common part of btrfs_{mknod,create,mkdir}()
  btrfs: reserve correct number of items for inode creation
  btrfs: move common inode creation code into btrfs_create_new_inode()

 fs/btrfs/acl.c   |  36 +--
 fs/btrfs/ctree.h |  37 ++-
 fs/btrfs/inode.c | 800 +++++++++++++++++++++++------------------------
 fs/btrfs/ioctl.c | 140 +++++----
 fs/btrfs/props.c |  40 +--
 fs/btrfs/props.h |   4 -
 6 files changed, 489 insertions(+), 568 deletions(-)

-- 
2.35.1

