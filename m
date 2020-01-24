Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AEA148948
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbgAXOeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41320 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404591AbgAXOeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:34:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so1626277qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P8XNEd0C6kBDH9BTgE6tDYjoHWT0SVgdH+Usr5cP7to=;
        b=0g/gx1dgwNHzqi4wwSS26fAO0jw77NAiVOHl+LOEnWlG5P1SsLsrPlY63EMY7kndEb
         BHdpeVX1hQmmyRreur3N8STsTSGmlwDg827Sc/fVn8N9oGTmT4uU+xHbQ6Q9QaaSLIl/
         McjQFa6nJdLZDe8g62Ua4AFt853NDno/2RbMqgNsdCcwjg2LC73oDc/+VmsL4R5Uq7qH
         Cu/gTW5xk+Rft0TjGE70qMpGaDv+NAbrPN5VbFmGOZPcHKsoS3ZZzOfWaPHcfKaS0OF9
         rjZhMZ46dMSrPl6fydTbC/Nx7auZrWg1kaURfT6stcNOJsawzeSENfnmcDDLjdYHILMg
         DVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8XNEd0C6kBDH9BTgE6tDYjoHWT0SVgdH+Usr5cP7to=;
        b=Pe8jgw8eHetCA1J69tU1todrRimwH7YoNrbmVXrJGj5baPXN7Ri0gV4vD/3A10zoMg
         s2gust/WkNrSqFCra5nNCVM+/2BW82s0Ss1TNRNaNGKjfkriaTNpMNjnFiYBy4kLBHOC
         3RyiwkzL1DjjUyaK/FhwAmb+z2CAubei41IZVpxB/C8h13Rr5kqdGxjV3K1vPXQAxP01
         Ytvk4sMp0dVBezHssH6Ymh1nPN8Kko6OUIxcQkg0f3uP6AKQTO14B75GMVzoANygKX0X
         eftbNZalfqA3Nn69EMijL/0CyzWWh7IpipYsKfJdL5fEut6Y6SaKtgf+iTijDS1G8un3
         qSfw==
X-Gm-Message-State: APjAAAUj4doNA2m43OITRgj9O8NppiVwnyWrir2VDU0MIiD2Ir1ZcnpP
        SnMi5o4tbG4q0i2mUX+3dm+usNxh7/qEOg==
X-Google-Smtp-Source: APXvYqwMd+KVSXEQUvJRXBccI5KiegcjSKmTcOn0UDlNeeQkzw3bYvfNA7nqkCykatKlFeWoGWDatw==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr2435703qtq.68.1579876442929;
        Fri, 24 Jan 2020 06:34:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k17sm3080360qkj.71.2020.01.24.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:34:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 33/44] btrfs: hold a ref on the root in create_pending_snapshot
Date:   Fri, 24 Jan 2020 09:32:50 -0500
Message-Id: <20200124143301.2186319-34-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We create the snapshot and then use it for a bunch of things, we need to
hold a ref on it while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c       | 1 +
 fs/btrfs/transaction.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69c39b3d15a5..47953d022328 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -875,6 +875,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	d_instantiate(dentry, inode);
 	ret = 0;
 fail:
+	btrfs_put_fs_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
 	if (snapshot_force_cow)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e194d3e4e3a9..7008def3391b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,6 +1637,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(pending->snap)) {
+		ret = -ENOENT;
+		pending->snap = NULL;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_reloc_post_snapshot(trans, pending);
 	if (ret) {
-- 
2.24.1

