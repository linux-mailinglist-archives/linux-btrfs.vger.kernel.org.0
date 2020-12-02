Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5902CC71C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbgLBTxD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbgLBTxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:02 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E5C08C5F2
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:54 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id b9so1534862qtr.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cpRFpbJwjc1VtrsNDL89Je3YD+oxRs/o4NDDyn/8Hzs=;
        b=RlQ7oc8AkemX9ab8J/cbnpaSbU7kykMRdbWWcueC8CfTfMpbemuU3DVzV4fN/o0JLz
         ry2q99UHibDJu3JkdWH4ijk5FAOkqfxvUHQJ4gdLeINUmieMyVvlrwbd68J6gF7Ar9jm
         fgaJ6XYtH6FKbhhNccdLutDVDqkN7Oy776Irc6pEBNqwCVFQrcqOw5Pl4OIWafY2tuBc
         nPPSQIBdDGicPrccfRlsFxrreWtZesA76xsBoh6Dl0/eu5fMtes6iqSkNRuumTOnHEC9
         KMiNpZY9fd4C5H5Hc2DvjA+UZ9S80FuiPQKr3PwUO+3Hva0c3EpVkwehVzxsD+L17swW
         zuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpRFpbJwjc1VtrsNDL89Je3YD+oxRs/o4NDDyn/8Hzs=;
        b=aAvd8EPhnqV9YQ9VPhA33LEMJMCfHLYn3dQh9RvQ8g2z/9ZB3yMVAiJ1aCjsrcPKYT
         BwntxfeoYQEKH6CffnZoArxfBQSEHrMSrbh+kHJyoZa1o0vlZYGOUzyoKurbFEWB3esu
         8QIS9mids7inebVO7KYySULNrxPoDraM3iOGO6kr3qmIVFQM8Lgdo1cvfrRtl46Fh0kW
         EKnKYv71wDXY3gmtdlxJ3rlLgHRHsxDcuQBawb02LnzOZ05oEPEkYyVn5qXmszdocaxH
         7cowrS7pnI0isAW95LvQFfdwHLVFkNZi/Fj1MR/yUL54ywpfXKCOIe/FtGg9y45dMr4d
         T1jQ==
X-Gm-Message-State: AOAM532O5SdLueUfPRdYA54xBe+iqkepDVp0jqrypUO81v7Waw5t/djG
        tq90nlIwQybkwvDlc4Lk/YGJ2JnTkFd/BQ==
X-Google-Smtp-Source: ABdhPJwJFVoeAOFTkkWBbZvpRrtpP6hvvI/9C+uiKrKgEMn9orjfO63DU2aY59M7KShINGR+PkLZ4w==
X-Received: by 2002:ac8:548e:: with SMTP id h14mr4370466qtq.326.1606938712976;
        Wed, 02 Dec 2020 11:51:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s23sm2982555qke.11.2020.12.02.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 21/54] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Wed,  2 Dec 2020 14:50:39 -0500
Message-Id: <8da8919da73bdaf0e652f03d59391e7710da6e5c.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 703212ff50a5..ad50e654ee64 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -714,7 +714,11 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
 	btrfs_put_root(new_root);
-- 
2.26.2

