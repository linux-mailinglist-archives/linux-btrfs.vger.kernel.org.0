Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1A113655
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 21:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfLDUTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 15:19:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46014 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUTS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 15:19:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so175241plz.12;
        Wed, 04 Dec 2019 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IdpmGu8iGR4pu9wN40g1Va4Rxg/xN1WVWM43oFtOZuc=;
        b=GZ4USlEMGXv34THmiUPdaunV9mU1mXLwjquzOhYT1UTMPxHQXdwfl8TSoecTFZNaLm
         4gM1RC87AWfGad075jZwJvO8b9Yfm2KDvrnt5mqrmxh4cziVMfaEQBKEZ/0AybZ/xXoz
         YS2Mfgigc4PcZCQvBCgFFDbxnIj2X2wAh/xCfEH1gdYUlsK+LB1CCoofz+d/jHqQJapf
         PSpmyHGUncjfB2tcWDiMGG4OP0iI818+PbMGW2MxVg4MIOnTEdaTSctO7ri2XtS2L3JH
         CHxnyvqr5Q67K1kOmvFRw4AFYG4Y8KSa7KzryXc0iaO7CoEPJC06vXsOsV6+cF/Vys/6
         0HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IdpmGu8iGR4pu9wN40g1Va4Rxg/xN1WVWM43oFtOZuc=;
        b=JooPbHXhDENfcvMgteyWBITjg5yWSgxtAcnD6jtkfrvUadnrBaSwJA3rZEpTLeGep1
         u6nCPtByooDHRB3eW4QZ6HozKDBSZWIZ1+z+FGpMekppWuWg57p6j1LnBzw5UWRAF1O1
         fiiQRFxR4QiNZwWgAcXk2yEunWNvsn16YD8lR2FdOq4oVH5TPKyIQZYF2if+NyrwsHqZ
         7CgA0ZX42WdAcb8jj1oLIFDTp97lPGmtXeffGDIymMZXLobhaeqHiJoQcwJE1En4D7DY
         6U0E5P7TBcRVkq/uD30Gp1gmdSSaE5nZukz7XmhTMff93Yge+QNNEYxJVv+2UzTZo1Ia
         wB0g==
X-Gm-Message-State: APjAAAUeLkUNhvCgJcwD/9762IbJ62P45qsOiv81ogtGSeVyBSTkWDRT
        rs8sP1OXFEOav79MrYlf4yk=
X-Google-Smtp-Source: APXvYqyym3aLJWp4bkO/UDgkjJGP80l8ErW34GumqKw5caVpvJNp1FIFrFHrA4GfR/q8GtM7lsaqFg==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr5388240pjc.16.1575490756959;
        Wed, 04 Dec 2019 12:19:16 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cdb:9473:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id c2sm8882170pfn.55.2019.12.04.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 12:19:16 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     clm@fb.com, josef@toxicpanda.com, paulmck@kernel.org,
        joel@joelfernandes.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] fs: btrfs: volumes.h: Annotate rcu_string with __rcu
Date:   Thu,  5 Dec 2019 01:49:01 +0530
Message-Id: <20191204201901.22466-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following sparse errors in
fs/btrfs/super.c in function btrfs_show_devname()

fs/btrfs/super.c: error: incompatible types in comparison expression (different address spaces):
fs/btrfs/super.c:    struct rcu_string [noderef] <asn:4> *
fs/btrfs/super.c:    struct rcu_string *

The error was because of the following line in function btrfs_show_devname():

if (first_dev)
       seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");

rcu_str_deref is defined in fs/btrfs/rcu-string.h

And first_dev is of type struct btrfs_device.

struct btrfs_device is defined in fs/btrfs/volumes.h

Annotating the member  "struct rcu_string *name "  of struct btrfs_device
with __rcu fixes the sparse error.

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 fs/btrfs/volumes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a7da1f3e3627..de7131ee604d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -64,7 +64,7 @@ struct btrfs_device {
 	struct btrfs_fs_devices *fs_devices;
 	struct btrfs_fs_info *fs_info;
 
-	struct rcu_string *name;
+	struct rcu_string __rcu *name;
 
 	u64 generation;
 
-- 
2.17.1

