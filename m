Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F407140B64
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgAQNsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:11 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34732 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:10 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so10714594qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M3LkiDIKKCvPn6ztuTVPBW2ShU9Zg/epWtM2vuFkQSE=;
        b=N3kZfs0RuV5XcTmx1GmsFy3IMb2HjHQdQHSoxDNi6P8N1mh94XmaCfotvPo2735qgs
         04gIPPQFZLH9kURK2QXKCRm5oqBVntRmKpNT7yIS46rxu6h7rhj/fEvVMnMPA2svLLwB
         FCs5sC4Wy8FzVPm7WxxIdEwew61qogu1dTi+2iCT7tvx14QRYsCRsdIYhp+das70VjnX
         gfuMjQaXN+e6ZTLOezxbA/35mzjPtsMLqv2EPw6YoHQ9pXPohNcQFwFMKZDSbXGCvpSt
         G45y7f8udBQVWeGrqh7bSOovzhTombKnyhYDSznzMfidVRKyu1g99B8pvReUIqSPDD8G
         xEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3LkiDIKKCvPn6ztuTVPBW2ShU9Zg/epWtM2vuFkQSE=;
        b=gcRAePEhu9Nj0nslYnOp7WbQHNlDuP5O12l6b7Uo7Hm2O+sm/1usHxjAmFmOIh+yEu
         m8BTSkpBU01k0eL+n14F51xZFBWLkQeyqJOK8twYidhiMc3mP9gnMIIT4gtlhLCpqOcH
         pmB8qFAuNsOecJT8wGuW5K4v759dBIWJmv4y8cDeoibXAx9I9qoIAhMHP8Pcxzz2+jKN
         0TAw0I6rljM/UWRoppo2zcQQTpn6KM/Z4f+d3YR5kFpvVQH6+8u15uYUH3Hr8qWhSDnb
         bVyDnyAf/Sj+9svVMphJK1mUQeRCNVVsaegv3rSUjoltJ5OdK8uvVfRC5ZgiQqCKBmUV
         MedQ==
X-Gm-Message-State: APjAAAURLGDzePlPO2gRL0zVi0U6pjWCuy832vGSrA/TUFgTQyw8REX5
        Zr5WCDZjfmpV+E/J3LPaubaYBdVKJFmsng==
X-Google-Smtp-Source: APXvYqwSJzT/8z5ImZ4Vu4aAlAF4zPRCxlP4HZscweAi1vhBNbipaqrE/OpnFEz24kcrGSX45a1aPg==
X-Received: by 2002:a05:6214:1933:: with SMTP id es19mr7770710qvb.14.1579268889214;
        Fri, 17 Jan 2020 05:48:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k22sm11897827qkg.80.2020.01.17.05.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/43] btrfs: make relocation use btrfs_read_tree_root()
Date:   Fri, 17 Jan 2020 08:47:20 -0500
Message-Id: <20200117134758.41494-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation has it's special roots, we don't want to save these in the
root cache either, so swap it to use btrfs_read_tree_roo().  However the
reloc root does need REF_COWS set, so make sure we set it everywhere we
use this helper, as it no longer does the REF_COWS setting.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 995d4b8b1cfd..aa3aa8e0c0ea 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1447,8 +1447,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	BUG_ON(ret);
 	kfree(root_item);
 
-	reloc_root = btrfs_read_fs_root(fs_info->tree_root, &root_key);
+	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
 	BUG_ON(IS_ERR(reloc_root));
+	set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
 }
@@ -4537,12 +4538,13 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		    key.type != BTRFS_ROOT_ITEM_KEY)
 			break;
 
-		reloc_root = btrfs_read_fs_root(root, &key);
+		reloc_root = btrfs_read_tree_root(root, &key);
 		if (IS_ERR(reloc_root)) {
 			err = PTR_ERR(reloc_root);
 			goto out;
 		}
 
+		set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 		list_add(&reloc_root->root_list, &reloc_roots);
 
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-- 
2.24.1

