Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374B8115377
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLFOqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46254 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id 38so7296937qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Dq5JqmytmL2LRBFHvkJmYCNUIRPTDJAEUEN4BtRVplo=;
        b=jmTufhu8U7hFaQr2GuSaYa1XzJHOEyvD8jxCJreas1j4N6FhLrTYNphXaRaK0otjAL
         7pSagm98FJfT8JRcI3QrIV5smoPtQVJRSLVSU658CjRN0rBHntuk6lNPEWnyugw4U1Cm
         +/OrdUXc7fDMq8/nkvqfuZPURwKxzpn5nF8Seaxx6owkWGw4AWTCWL6mYfrSuWNvU8cY
         35S9IYdHo+nH2jMp44sZBl52aoDpQ64wfBAzK1SPA2Jjuu3xcPSUBmyczZ5ZVnMj9zUn
         b0CQvsC3fb5bFD0Q31hzwH9djHby+nGXnnJzUThVyohn1OW7aFIMYKFxdEsjkaue66Wa
         IJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dq5JqmytmL2LRBFHvkJmYCNUIRPTDJAEUEN4BtRVplo=;
        b=IoGGEp2NIa7Cfu++nWSNj5HRUSF7AlIk4Nmsdu/isYHoH0Mmrq9+YLvUNN6xCYvil3
         GiATSNrH10zhZhCgsRvceX3yZCiJpGJUnuWmHLlppeow5XF0bwjVsvE0NnVnsW9rpcaW
         0ZVPCQ0K8EaEAKyoC1zClcbq1ofMTuLXhwYMHiVs58KX6JV13oTzA8jwExT2pwaJhDla
         j9s5ukO0pTOu9fHu7vAGcD5fsCX+OCm2nfDDCQqmy3PC8Gwxc0bJrJ3bnuC1UdFnmrug
         wAfQVZfopPkEbEf0QMNipGqussh4+UqQBqjWRNVcNk1MKZn0n20L2nEd/Roe/zmMUwYE
         uelw==
X-Gm-Message-State: APjAAAXU8/ooec8QhMJFI/uZ8l4Hpfsk+FaiiTqRpuSXIAdEUFQPsm6M
        SQ0YB7Bthta8DshSAl8hSVJmrEjFMQgdIg==
X-Google-Smtp-Source: APXvYqy33sKF2uNFCt7xGuFDTdiZokFNjHpLcFRmbw8bKRldoPwXtr7hiCf70y525ewoEBLKtzWF9A==
X-Received: by 2002:aed:30c3:: with SMTP id 61mr13112075qtf.251.1575643568115;
        Fri, 06 Dec 2019 06:46:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z6sm5903615qkz.101.2019.12.06.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/44] btrfs: grab a ref on the root in relink_extent_backref
Date:   Fri,  6 Dec 2019 09:45:09 -0500
Message-Id: <20191206144538.168112-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're doing an arbitrary lookup on an fs_root, we need to hold a ref on
that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 88f3d6eace7a..3dc9bc9530e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2711,6 +2711,9 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 		return PTR_ERR(root);
 	}
 
+	if (!btrfs_grab_fs_root(root))
+		return 0;
+
 	if (btrfs_root_readonly(root)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		return 0;
@@ -2722,6 +2725,7 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 	key.offset = 0;
 
 	inode = btrfs_iget(fs_info->sb, &key, root);
+	btrfs_put_fs_root(root);
 	if (IS_ERR(inode)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		return 0;
-- 
2.23.0

