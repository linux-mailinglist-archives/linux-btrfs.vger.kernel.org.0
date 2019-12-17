Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4912308A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfLQPhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34036 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so9056498qtz.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HVdhY+4MBd3q4kmJauYMe/pxqfd41KkKzQ6A+3l8tLk=;
        b=QDDiAm42yjK8grrpvHXAKMBodxyRjv+uWHHlTYVvLG3+gBSCYPvq7oNBxOZYgynlaZ
         zR6hdeMqojpu6sifMWTvaCYKvx6ULrU2cDnEwn3USKXkRymZIffE+aaTdVvgqy56sszO
         1TL2TTz4O/01pJhZxfZ2T1Ow7EyZxPyjoRIqMGTlCrIVE+Owmchh4MWdUcRskMgbnJcK
         pCRg8c6UGQCyI0rHixVl7DmixOCnDYF9++GYnYfd+qyG/Ua3gHtfkskQiHRCN7RB0J6v
         CRCr/qkovUuSZQTqo7N02tmPW1Xlx/kW5wKFJ7jNO1QTkFWYyQnG5Q+ORlV7oBvE/ypy
         YBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVdhY+4MBd3q4kmJauYMe/pxqfd41KkKzQ6A+3l8tLk=;
        b=qnlgB1tsjP/udl6Yzlm+74F7VGozp0caUhOQpI4O7Pnv4UWloZJEYCiNoBQCK1T7dY
         V6t8TIgNP0Me9+YseA9PPxnITAVEJAhoJ+oAHiZyZT4BxzUipMmo+C/W7bTHfFDmAs2C
         Y4W2/w1K0pirMLAhjv17BitVDysR+ZyJe1JD/5vOYD+QEsVK/ftiMz7yQ5E72gF+zVL3
         K2ZC8A/nglL5aRCwuVsQg0t5sUokqH48SVkweoXMj58B6n0qNoIvc3RvLq9UyC7NUs2l
         HIDVQpM+dTNAue34oozFVTh6iQBccq1M3X7qJ4FSgG2OiVa0P8tC/dZYwz2IbI6UD+E3
         vhQg==
X-Gm-Message-State: APjAAAWMw6PfMMrRYjWQkuQs3FyWHxMxUle376RApvNjLBzodnNLJL/D
        /qcptaqexTCmlCgRVoKGyrUUQzzQpWUCSQ==
X-Google-Smtp-Source: APXvYqy4uertEatya4ayH29fkmyJniEI8vamzo5Vkmt2vZRPtqqf4Im9mFoiXQUARakfuwte0/xCUA==
X-Received: by 2002:ac8:2c77:: with SMTP id e52mr4832507qta.312.1576597043628;
        Tue, 17 Dec 2019 07:37:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n4sm5388594qti.55.2019.12.17.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/45] btrfs: hold a ref on the root in merge_reloc_roots
Date:   Tue, 17 Dec 2019 10:36:15 -0500
Message-Id: <20191217153635.44733-26-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the corresponding root for the reloc root, we need to hold a
ref while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19d69ce41f06..dfd3d9053301 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2505,10 +2505,13 @@ void merge_reloc_roots(struct reloc_control *rc)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			root = read_fs_root(fs_info,
 					    reloc_root->root_key.offset);
+			if (!btrfs_grab_fs_root(root))
+				BUG();
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 
 			ret = merge_reloc_root(rc, root);
+			btrfs_put_fs_root(root);
 			if (ret) {
 				if (list_empty(&reloc_root->root_list))
 					list_add_tail(&reloc_root->root_list,
-- 
2.23.0

