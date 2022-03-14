Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE24D8DC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 21:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbiCNUGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 16:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244695AbiCNUGf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 16:06:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631E3FD8F
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:05:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso340592pjb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1x4ShUOAJ/19u0pEosrzYin5xOZdalPSNo3lp2Mgq+8=;
        b=ygt2uzHu99ry65oVjdaz5awEX2KLcFUUOztletLYQ3A3daVTdfrGmEYlhoXk4F2BRp
         wpe62I+3LAy6nICvPQlQ0ZcpBd5EX2qAIl/Aut3mx860rz6grTNGpzO7b6MUv5aHQtRS
         WU0YtqJn2bEsoX3OxUZV7TnNSVmdihVLbPbjnTTTdLqDhyMpJDNjLp8G6anL3bgCU8GX
         B4IOCOjValQwSWaUbxVhahZzAMQmBoDwXCQvOM6I2f3snx0VkG8yFPAb19x8BG3Dc5jf
         47aLEtRbufRSJP5JZfTMeITvOeAXM+IrtUWLaCn5Jg+kCr53NkPDDO+d4nu9nwP5uivS
         Di/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1x4ShUOAJ/19u0pEosrzYin5xOZdalPSNo3lp2Mgq+8=;
        b=22T6kKq47M7XBpw5lvffxKt92zeCLXXyB3HWorihElJ4SKDXXu3vX3ZuS1ZkXTtv4d
         YajVXilmck3glnqYVNj09eYQ7RURIkcDg0+vQaw+U2I5iYYdluR/4Efdr6+5Yl+c130z
         1lMJWSu/7C799QpdiaygkQ4s4hnPoQpMc7RniPLUDeNulxXq2g34+xFe9Rk+Z/keWKSd
         xP25wgSs8Dz5Qluez9BbI0G2yko3ms7FiQteJ4/UZiDmAA/sC2s5I341A86lqHP/Lns9
         s5FwqPnV3CxbUVPe2KUwSSDyBvCl2t/pwxz7gMH8GjxCDxkjaAsfsUtrahduBPhprEHC
         H59w==
X-Gm-Message-State: AOAM532PiEwL7zwxvrw2+PyrXma2AjwAeCI1z4jI1yomsk1hoL9S0k0F
        tYA3xtHAm2WAjqaKR9/DbvN7lGx4y0EJNA==
X-Google-Smtp-Source: ABdhPJzfiYaCEoTkCCuwEktp7pIPmq7itDnPl8peDa3wb19//eFE9y8+w+ih7DXv5iZ/+bi0CUrxwg==
X-Received: by 2002:a17:903:2303:b0:151:d02f:44c with SMTP id d3-20020a170903230300b00151d02f044cmr24979570plh.139.1647288324885;
        Mon, 14 Mar 2022 13:05:24 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id mi13-20020a17090b4b4d00b001c6320d40c6sm187321pjb.45.2022.03.14.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:05:24 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v3 0/4] btrfs: inode creation cleanups and fixes
Date:   Mon, 14 Mar 2022 13:05:15 -0700
Message-Id: <cover.1647288019.git.osandov@fb.com>
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

Changes since v2:

- Mentioned reason for removal of btrfs_lookup_dentry() call in
  create_subvol() in commit message of patch 1.
- Made btrfs_init_inode_security() also take btrfs_new_inode_args in
  patch 2.

Thanks!

1: https://lore.kernel.org/linux-btrfs/cover.1646875648.git.osandov@fb.com/

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

