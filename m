Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3935184B27
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCMPo4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:44:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40629 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgCMPo4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:44:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id n5so7861949qtv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEP3X74B/Kbe2chZ3uoyUKUmNnB75VXRczKvZeHWmAo=;
        b=PkT9IbgfcmZ4OIvqq6HQmn9k4X14NzDXZYSTXxBs+U5UjsAzTMxl2W42l5T0Jc7llm
         kn92qbWdOMbLAyxnXyDqz2oDga5rAp9nw/Z1lq9Cj/dIdEJzHuFDrSZ88jRLWJcV+auj
         xldDmB2QKpjI3B42wu0YjQfp5rFd+IVLt/aiaOyo+g88gXLfX2czKrainD/w4NC0nck+
         DGbMY0U6wv2r/BhxPyQsDZnDEn3j+Pa7DHagK0LmIhCA99HKRPGEY3VY6pgNVpiY/Aje
         VhL6g2nBKqZU9lBmus8aEELeIGJtiD86kxyU53M+zD5KvXMT3dLaXhrwmJ4ngL4qM/Eu
         sAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEP3X74B/Kbe2chZ3uoyUKUmNnB75VXRczKvZeHWmAo=;
        b=kUEELgI9vvmbMlk8dMQ/FMRfsx8uOUnDMw3H4I2QojpIlB2XI0F0ggu3/6d2n6HYlL
         rnots6N2VZ8G6yhtllz3gtf0rZH1SzOPRQxL4SCSHvjjegpoBeNmsp7MNVLrAwel96T5
         zJ7BNVuCkFaMqg6ZYm2RoUH8plGOxs0RfpvOargUMj9ITTl5joILnL+unQPjo3MBXXNX
         SxWUOW0h5+CtJBZPQ6nctQzp7DgmwWS/irG9oeCPZOD34Gw4yivCdW+oL2fAxNYR0yMw
         sOD7pqAwajn3IpkvRPrf4h669MfUmEGQzisAQ+0TNV3OTKlgbpls2CIgxkQkmck97zNg
         8wJw==
X-Gm-Message-State: ANhLgQ1CfNstvGu1tY1BZQ3LISZjtG8qfkD+OOHdfBCD7LrxL8A5y3gY
        0+zlpoYh8ULRpK1c8DhjAjgumFjn6DA=
X-Google-Smtp-Source: ADFU+vtd5MK6T8h6nrZCMtPWKmcB4npRFdGK1Mav2cfMy85mEyH7lovL59+zZHf4XAIOEI2vkQ/tGA==
X-Received: by 2002:ac8:481a:: with SMTP id g26mr13037450qtq.267.1584114295006;
        Fri, 13 Mar 2020 08:44:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm29757524qti.10.2020.03.13.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:44:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 2/8] btrfs: do not init a reloc root if we aren't relocating
Date:   Fri, 13 Mar 2020 11:44:42 -0400
Message-Id: <20200313154448.53461-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313154448.53461-1-josef@toxicpanda.com>
References: <20200313154448.53461-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We previously were checking if the root had a dead root before accessing
root->reloc_root in order to avoid a UAF type bug.  However this
scenario happens after we've unset the reloc control, so we would have
been saved if we'd simply checked for fs_info->reloc_control.  At this
point during relocation we no longer need to be creating new reloc
roots, so simply move this check above the reloc_root checks to avoid
any future races and confusion.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 507361e99316..2141519a9dd0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1527,6 +1527,10 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	int clear_rsv = 0;
 	int ret;
 
+	if (!rc || !rc->create_reloc_tree ||
+	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+		return 0;
+
 	/*
 	 * The subvolume has reloc tree but the swap is finished, no need to
 	 * create/update the dead reloc tree
@@ -1540,10 +1544,6 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 		return 0;
 	}
 
-	if (!rc || !rc->create_reloc_tree ||
-	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
-		return 0;
-
 	if (!trans->reloc_reserved) {
 		rsv = trans->block_rsv;
 		trans->block_rsv = rc->block_rsv;
-- 
2.24.1

