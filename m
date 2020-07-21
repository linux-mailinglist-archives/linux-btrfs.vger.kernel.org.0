Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80A2283AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgGUPYc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgGUPYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 11:24:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE09C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 08:24:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so9494714qvb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68a6P7MrdkpPnrwZyjGP4+3gFIMnEa68LKti40qJids=;
        b=rdHo9OBbNPXtzqqsGpnRRpPcKcEJbzq38pFaMftGwRQz808RCXL9qQ+uGTg6r2A/7N
         ssbGY1b/gPJctNcliV9MekiQPHsUBgkbHM/G9Eto/13cOll8iaVjhins3/LZhWnC0Rt4
         Kzag74xj66JxrhNRlkCTKBmWcBK49xd3ja0mCfcAZahBdQrUouriw+/4+uXq2bangt0w
         j40NkBZT64e6cWAeGVGF010l4V09BF6DR3W/aR8bYuL1u8kpcrg9dqzHPlOmWd/217lP
         8yHmk9Dc0g+sHcavZIWPkOYRpZBOSKAc2fkB2dLvbBR4JB79l3F/1kk8d0QuBFwJledM
         FkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68a6P7MrdkpPnrwZyjGP4+3gFIMnEa68LKti40qJids=;
        b=XsRcwEBIvQUAptxbPiOUIgb13JNAU7x7tMsLza5IZ32FKeuLzhWmiXl2xAcqV6Dfnc
         HdIBaEX7/w2ki3fPEPd4oauC8cEqKOc5QrMkrZfaxiGyXxiyP4l5LqUhmqGanACZ5x+4
         eEnvxboeltP96vn+dVQdybh410n7rm59qrCijc1Z+dSJ8iQZlDKP2nqxmuSKE9welrhu
         2pJOTgYTELc91WiGGv8hPW1eI9xr1BJYsOaj4Wf+xDh+dopH96Mzx5Cp3F2wEg3bzdj+
         vz8DSIAIL7NneGK1kmqNQ5cV0Z0niPyjhmMTVBcCjwtsNf3wl9SMh/X2Ytc034bPTri0
         PK+g==
X-Gm-Message-State: AOAM533hEWz33tRVejIbei+fYVCsTxt6N6wuESprkDvkjSKzNEwxvCwV
        bpDO2UFtNCtdwxL9JIfH+VRdOu/HNwByqw==
X-Google-Smtp-Source: ABdhPJwNck35N0G4mxkTCXFVBqT1/sIhHawnyERQmSsGO12zhScituSfY7+ThMRQIqZk5aq8V0BcoQ==
X-Received: by 2002:a0c:c703:: with SMTP id w3mr27554085qvi.102.1595345070893;
        Tue, 21 Jul 2020 08:24:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u21sm2613892qkk.1.2020.07.21.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:24:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: don't WARN_ON() if we abort a transaction with -EROFS
Date:   Tue, 21 Jul 2020 11:24:27 -0400
Message-Id: <20200721152428.9934-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we got some sort of corruption via a read and call
btrfs_handle_fs_error() we'll set BTRFS_FS_STATE_ERROR on the fs and
complain.  If a subsequent trans handle trips over this it'll get -EROFS
and then abort.  However at that point we're not aborting for the
original reason, we're aborting because we've been flipped read only.
We do not need to WARN_ON() here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b70c2024296f..f8ae4849f235 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3279,7 +3279,7 @@ do {								\
 	/* Report first abort since mount */			\
 	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
 			&((trans)->fs_info->fs_state))) {	\
-		if ((errno) != -EIO) {				\
+		if ((errno) != -EIO && (errno) != -EROFS) {	\
 			WARN(1, KERN_DEBUG				\
 			"BTRFS: Transaction aborted (error %d)\n",	\
 			(errno));					\
-- 
2.24.1

