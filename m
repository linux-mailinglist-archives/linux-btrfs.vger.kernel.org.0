Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5FB184B53
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCMPpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:45:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37886 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCMPpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id z25so8342251qkj.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gd+Y9n7g/izMwHOhUhGhejD80gYG0EI0lQyPcUpWVoU=;
        b=DjVyvdI63czycwj50bO5NaNC1KcMCvNq8F2IZG8BdGCJv5eyAPICWI2SqwE7VTUJoA
         jacA7C6vv5guxckuW6lNkj9DTv3CAVac0sX/o38VYPlEKImZchP6fLkKutUX10tRAJpf
         ka+JKju4nLNuGVZe6qoqovf80VH2No7Eqvj77oxL/3HhNi1M6KONajQAGAFCg4NrYurl
         3+KBal/gUtY3EkdRLKW2fXxX1ieS/IqD6nEcPDodR4A3RH5fwwIfUXfuDYiTEgZai4QM
         WWo9FDHqYEatRKwsxcYDcgqN7NZ6wXKKENAP26B/l36sUNro4OC4UT7EY8QWJrVdc4Sj
         O42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gd+Y9n7g/izMwHOhUhGhejD80gYG0EI0lQyPcUpWVoU=;
        b=celd+b10l0Rnsgib87AND+eRI3jDKNe7ASsGiRuLuqIY27rup/hgTDY+Odjur6AHxJ
         wdQSfqQKUfvkqc/PS0mPdZVnU/k877XdwB9tGVCyEYkRYGwHzfqa3VVD4JRYBS0ga7p1
         9I/jYnQoVg8agkSc/DAxZGi38FLl3KOt44wdtnBP4afdauYBreA7ebHGhxdnSxVAFFko
         mycnzw23yGZXolkjZp02PawVRwJuRAo+qBZb64ZOEmrnK3TA9Oqt0G5NTsdNdFQa00fH
         o0eeYlKF5wXc4XJuwyj2OdIf5bpckeWHCC0Zd9oZCcgHTv6kPdcXFydLA9jab2yiwMqV
         qKWg==
X-Gm-Message-State: ANhLgQ0sxfk7xmxL7UV+/VEhzLal0pmXrW4/IComAiLiBCHyG1eBVOpl
        xjw1Dozgl6Bj1te6I9fJF0GP71aU0hE=
X-Google-Smtp-Source: ADFU+vv6uCeSRa5ji26Z5a+b3yQDwsjoBjRzieOCo2NRlrRlIpn507RZvbpJf1yIH/K2F1niZvyyhg==
X-Received: by 2002:ae9:dc04:: with SMTP id q4mr13836054qkf.216.1584114302226;
        Fri, 13 Mar 2020 08:45:02 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h47sm11537453qtb.75.2020.03.13.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:45:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before dropping the reloc root
Date:   Fri, 13 Mar 2020 11:44:46 -0400
Message-Id: <20200313154448.53461-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu put this in place in order to avoid a use after free in
init_reloc_root.  However a previous patch in this series makes the use
after free impossible because at this point we no longer have a
reloc_control set on the fs_info.

So move this to be coupled with clearing the root->reloc_root so we're
consistent with all other operations of the reloc root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9c8a4a4b2bde..5bbed0ea26e1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2291,18 +2291,19 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 
 			list_del_init(&root->reloc_dirty_list);
 			root->reloc_root = NULL;
-			if (reloc_root) {
-
-				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
-				if (ret2 < 0 && !ret)
-					ret = ret2;
-			}
 			/*
 			 * Need barrier to ensure clear_bit() only happens after
 			 * root->reloc_root = NULL. Pairs with have_reloc_root.
 			 */
 			smp_wmb();
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+
+			if (reloc_root) {
+
+				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
+				if (ret2 < 0 && !ret)
+					ret = ret2;
+			}
 			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
-- 
2.24.1

