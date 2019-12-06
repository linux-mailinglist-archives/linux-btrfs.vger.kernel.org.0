Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D5115388
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLFOqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33787 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLFOqi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:38 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so7380637qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8+BtdMJI5uKLStglB8bT7gvqEGLI3R/yUBUc0OKAnGo=;
        b=tIn60bQQJw5kIKE3Pdhz2DLz5rKggOsOKybBs5lDou/hKx2XJ5RB5oLdhPKGTgHat4
         Lt4Bw9JOAM5x1j51BaOFfL4u0VgFoW2d42f/QM25wyBZI++EbGw4/JE/ilmgnN0V5jPi
         K38OriBlXN87+zkGoE75E/nPS3aftyNydIP03+x/oXgLLVFhCSBXVdEwfvTqcA698Uos
         BfTXBZuOqpmDvITdTPxKK6cc6LoUmH1o2YaZGJS5tvjOPKkX4iWGYrcNf7WvUENa7HPe
         2qybamqWDzqVuoiQ03g7gWOTzqZk4PppUO1yfI8eKo0LMaKB5956Y+Kfu42vVE015qjN
         lltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+BtdMJI5uKLStglB8bT7gvqEGLI3R/yUBUc0OKAnGo=;
        b=ZkEvD3YyyGueR4NJd0cYOz7H7e86tcYXUj1jDdb3vhe3ZrTQ8/1GRaFPXpqGhKaPp5
         DLkWjeMr2gp+duaMgMQhmJpOg5p8GkuTCQQxHj4b+R0WweYvO12i4Ce1ZTKXoH9mwzT6
         yrIh5QDzzF11ObUizIUKYS7P8qeG1z0pvdJLAA7DXPNQb0WMX+MnBG8civ+Zm/Msj6gS
         mN0hNC4ZYz/J3mqp/Y5vUTwFRxkbEG9VEiKoXVKloIARI7/T8t3I4PjxHXa3nipZV/aO
         MgjgGiK19TECyPDev8nw++MB8C4CTqw6+NDlRaMLHssibECgjxfEuBEjZ0GBjfO/Jnhe
         i+WQ==
X-Gm-Message-State: APjAAAW53k4HLUjC44u//G03oIH1cZCpasgIu93nExZei8McSAu1k2AE
        kwzFEC+tucUfkl/xvW+wYdW05O71YLFjLQ==
X-Google-Smtp-Source: APXvYqxmB3tELMOopdncnZ7r6euRcAOHzq74Xr1h7MPnLavXKEdBvw8Vwiw5oQllfrFu9oAs8Fi29A==
X-Received: by 2002:ac8:7158:: with SMTP id h24mr12728317qtp.63.1575643596846;
        Fri, 06 Dec 2019 06:46:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm6552005qti.10.2019.12.06.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 32/44] btrfs: hold a ref on the root in scrub_print_warning_inode
Date:   Fri,  6 Dec 2019 09:45:26 -0500
Message-Id: <20191206144538.168112-33-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the root for the bytenr that is failing, so we need to hold a
ref on the root for that operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index eed3a8492092..904e860c509c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -657,6 +657,10 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 		ret = PTR_ERR(local_root);
 		goto err;
 	}
+	if (!btrfs_grab_fs_root(local_root)) {
+		ret = -ENOENT;
+		goto err;
+	}
 
 	/*
 	 * this makes the path point to (inum INODE_ITEM ioff)
@@ -667,6 +671,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 
 	ret = btrfs_search_slot(NULL, local_root, &key, swarn->path, 0, 0);
 	if (ret) {
+		btrfs_put_fs_root(local_root);
 		btrfs_release_path(swarn->path);
 		goto err;
 	}
@@ -687,6 +692,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	ipath = init_ipath(4096, local_root, swarn->path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(ipath)) {
+		btrfs_put_fs_root(local_root);
 		ret = PTR_ERR(ipath);
 		ipath = NULL;
 		goto err;
@@ -710,6 +716,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 				  min(isize - offset, (u64)PAGE_SIZE), nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
+	btrfs_put_fs_root(local_root);
 	free_ipath(ipath);
 	return 0;
 
-- 
2.23.0

