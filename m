Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE272CDD6B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501977AbgLCSYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501872AbgLCSYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:44 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37905C094241
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:34 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so3022301qkq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5vSOS93iKVwVV3ZIjr9t6hOh6M/56M/0Y08asFy1x4=;
        b=px8Q/x2Ac1Fs0XW8KCd4dz9TrICGhWCnBtEUFYuL9xjBGjM8JeDa1AoI0q6nuxlkTG
         sL1bPfpTTCkZMpJTte314Sq7QuilMKwH6vtAf4ZMI4fA43lG0IxnE1Oyfm9bJwcc+m0A
         /gTVuGcx7xfBgtMoHNOtTPEYJahDyN5hgAkbb3lNsyV024s2/i3q9OVFHoNd4PPddBGs
         ioXF9nRUuFl3UOqVuermjIN29OKhQwMdU0uPtfEf0uxSxItkJ1SHBSyfhwzuiIEvC9JO
         QDxssFwXnihkl/ZtiZjQJxHM4yiOwUI4KXCS+tJbPB2XA3RT13zIQNfn/1CN34Z06jAE
         HrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5vSOS93iKVwVV3ZIjr9t6hOh6M/56M/0Y08asFy1x4=;
        b=nvFRiF/16O/e6dDJnRY2L0zRWBMR6AmcCiyPO6FUCCjCU1QoOQQtweXzsfJRliD4uE
         LI+Lv3J5eWkoLH0lWkTvIlkqqncKYZy50oKSMbnAtapC/JyFlDHXM20ZZbbiuC8kml/o
         VL8WmufKF7KqPE1nkGdoquJZqerXZ5/E36Eo4FVFevbj4n3Y33TdFpWhmTR1Fx4tOVhQ
         tLZrg0Hr8dDY6cR4tuNA2T3gzVzFmH/E2y6ZF6uG3tza+x3Ae3wYD7iCxKFm2IrUzj9t
         6o41OBXcdLFRls6fXCbsGnYWOCCxaY5fIsQK+3MV1HN3PLUnIbfNkcwLyuT03LPwvL2z
         xo4Q==
X-Gm-Message-State: AOAM532ylr5zPQig0lmBoG7Q7pBSsZk4CTOp03SR4JdV5T9a08groXpa
        V0zer/c/Bjd3uPhC/9Cbuev2GgqVxMarZaZT
X-Google-Smtp-Source: ABdhPJwLGqavZFSftVOh2i34ODBRuI7iw64/GpFWkltoabxyYMUJO/0yWsRyIxlw2XOCWH8q4lHOJw==
X-Received: by 2002:a05:620a:1531:: with SMTP id n17mr4271581qkk.474.1607019813201;
        Thu, 03 Dec 2020 10:23:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e19sm1985175qtp.83.2020.12.03.10.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 18/53] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Thu,  3 Dec 2020 13:22:24 -0500
Message-Id: <a8af5dfbb1a3ece0d5743c4d5f31923406b8bd2e.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ce42d52d53e..d34cba37a08f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8878,8 +8878,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2

