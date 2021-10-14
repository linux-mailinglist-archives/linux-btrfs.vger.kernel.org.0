Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4242DFF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhJNRNJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 13:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNRNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 13:13:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D280C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:11:04 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a16so4147939qvm.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5nO8dsm4p8bHfLt9CZyMnAJeAOiQhqybMWtP5eMOXY=;
        b=VnyG4c3Bfx9lFX3Kl2bffSTn5TjXfkzKukrNOQSUn1V0h4f7nM228izzs6Rx2Yy7tE
         lL+ghYLHwv4iPcauxoyP/ut6YSKgaCCYUjUVUOHquCJb445RvQrgZoGsqriC/QXI1KTF
         2LQU7/tQ9zF0VcAdjNlax3P4NQPK7UGFTcULPOKp9fk3OEcxP3/9EP/7eJViFdfvdXmZ
         brE+knKNvb/Mz6dMw2xbTtcGQakOdyPdWB9e+AT6Rx1YaqrOsCasidETZS+BY4IJn8P4
         NwtYzoirOKPz7ItALynnJ0uyCktwHoShFM1HEOlwsJkBa8i4U0I5z6GXlq5E1WcYqsaw
         UtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5nO8dsm4p8bHfLt9CZyMnAJeAOiQhqybMWtP5eMOXY=;
        b=k8NrmsuftJeOWHo/g2g0gDoXHBy+NE6qOJYlO+2tLK/vopB371qcm1MImr8oLtZ3w/
         MakpH99Uut2DXbMmx/HdDXSuVi5tcHrTP0y9C6Ey/7yp21vbRXNhsIygQBZZIZZXmKPk
         q2o9CAKuAYdrdIKUd0ecYWD9jL5Am87RkuDIDfR7+PPXDf7QSq7p7g4plMIq6IQIpaBT
         /BWF0fGigndnAIAW49iec3J8rCZOQQKUMz40+D6luPRYJhWGQjwI1ttkXBK+iW9NHMgI
         CvpqHFTeZedXb0z7I2MfSFcWetBvivlwfLwcRjCQBDZ2kMsc0PknczR7fl0EC7G2B8S1
         ixJQ==
X-Gm-Message-State: AOAM531JnD5/SMEM0NesbccgEVEJVO+Kjddw+Pqs/AzZSeCcZuElRdl6
        SB85FXbl4q/fR67ngUefFMSoTg==
X-Google-Smtp-Source: ABdhPJxDI7cybnbGenSWKmh9B7qwqID7QzvtLUATx8TbGGm5cf2IAl0xMFjTaZTlnWSoRk6SYuE8qw==
X-Received: by 2002:a05:6214:1349:: with SMTP id b9mr6485239qvw.47.1634231463087;
        Thu, 14 Oct 2021 10:11:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b14sm1761533qtk.64.2021.10.14.10.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:11:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] Update device mod time fixes
Date:   Thu, 14 Oct 2021 13:10:59 -0400
Message-Id: <cover.1634231213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Christoph noticed that my original fix to stop calling filp_open() when we
remove devices was wrong because ->bd_inode isn't the inode we need to be
update, it needs to be the inode that is associated with the path to the device
node.

In order to do this I need to do a kern_path() to lookup the path to that inode,
and then I need to update the time for that inode.  generic_update_time() isn't
appropriate here as it should be used by ->update_time() if at all.  Instead
export a inode_update_time() helper to do the correct thing, and use that.

This allows us to update the time properly for libblkid, and makes sure we still
have the lockdep fix that was the motivation of the original fix.  Thanks,


Josef Bacik (2):
  fs: export an inode_update_time helper
  btrfs: update device path inode time instead of bd_inode

 fs/btrfs/volumes.c | 21 +++++++++++++--------
 fs/inode.c         |  7 ++++---
 include/linux/fs.h |  2 ++
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.26.3

