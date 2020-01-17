Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31C81412D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAQV0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:38 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36990 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so22896698qtk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kvs2zgeWGFIOEWBcae13gISN2NDUfogrB0w8hZ982w4=;
        b=ibhh4p4QUkYpGPioB5lapUM+YRYdlZ+wC7O3Jvo7W2QQrBU47HjujzTmFf18cTxqDi
         Hh30WGxDsk0zw5C9h+veqt0np8nhFmHb6cTqdXjqVBPeVpM476UtVKSEgOfxqwEmElZR
         JaOopIdBiyIFf7ONqpnKLyeux2nKaaC9rkFJ9sr8l6khLX0+/D36EWHZg0Z6TYz2XXBW
         DZe9if4VerG2Seu8lMK3OMretWoorvdps4YvYgHs8nR7GFl9JzeF7gb9u/8dgtsaEpkg
         86MMtjUStD2E+H+M6l/NdBT4EiPzmsWZpdFWwjOCvSd2RWIL32GuqE2VxcPSwESlEveo
         Rlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvs2zgeWGFIOEWBcae13gISN2NDUfogrB0w8hZ982w4=;
        b=Bt5VrnRzFvqVyuX3e15pTe0E4plNncFVLGjJ89LOd1ID4goRDk+FRVZaH4gqWZak9Z
         JXCzzisq+/ycYbED/AJMDEp70ZKLpRklHMkSnSdA++N8Ca4/xnLp/PgZ9a/Wag45HwNT
         ZvBQTfhC9hBNYjt8qW9wYomFTU74X6Sq+TmuIh4cwoQl5CR73piha3bKptAHTFT4AtQ+
         ZQBGK1dpXu3/IORHsn2asFTH2uWVgJfDts0cRMABPh7C9TL4I/lvN9XczxVFKnpySXQ6
         uunT+8r3yE4lo5ycSCvNLYFWbkw5qpqhYTkNJoMSTTW+6XgT0MyKazwy5vObDnWk2qZm
         yl9A==
X-Gm-Message-State: APjAAAVU6Py2Tiw9LIPJdCP+E9GupoeS44AC349rmGP9xMrAgVMEs9cf
        rFhRf73H4i5Am9qvnc0NIAzBXz1pp6jj7w==
X-Google-Smtp-Source: APXvYqw1zACsCizomU+KbQg/7D790ZOzWMOB9esb9/HD86SfNL0oGWnMIarrOshjnkH370Aqj8C3sA==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr9616726qtq.149.1579296396653;
        Fri, 17 Jan 2020 13:26:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l17sm12490857qkk.22.2020.01.17.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/43] btrfs: hold a ref on the root in btrfs_search_path_in_tree
Date:   Fri, 17 Jan 2020 16:25:36 -0500
Message-Id: <20200117212602.6737-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up an arbitrary fs root, we need to hold a ref on it while we're
doing our search.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 62dd06b65686..c721b4fce1c0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2328,6 +2328,12 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	root = btrfs_get_fs_root(info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
+		root = NULL;
+		goto out;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		ret = -ENOENT;
+		root = NULL;
 		goto out;
 	}
 
@@ -2378,6 +2384,8 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	name[total_len] = '\0';
 	ret = 0;
 out:
+	if (root)
+		btrfs_put_fs_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.24.1

