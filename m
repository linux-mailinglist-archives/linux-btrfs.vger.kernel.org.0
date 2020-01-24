Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53602148935
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbgAXOde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41277 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404404AbgAXOdc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id k40so1624967qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kvs2zgeWGFIOEWBcae13gISN2NDUfogrB0w8hZ982w4=;
        b=OKzsQZcczMc1INfUi9onKUg/omr/QjguyQE1l9S36vCnSLzcvq1V7z06K/obFMkS2K
         CLw4am4QE6PH+Da/85ZmhNa4x+MmnOWAW2ZCKNwwL7/nXWcalnCKny7xwixEgN0L/CPS
         IQjRY8TvCAf5XuHsvDyK00lkReKBipnPdQ6OjuKdVC99f7kptOBrDp1oG9RprXsH0dMu
         XERFtAMZDFCeOBjp6Q2oJgkJMx+FcBx2xr/57eM/Fxw67JHlrfj8W2daITnBi1y81Fdq
         NI5TQz7QTirM0/jZrMG8noaWO6V803nLJaUaoq+4NQ3BQr59DwwzoYUWu1RfBqhV5poR
         jIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvs2zgeWGFIOEWBcae13gISN2NDUfogrB0w8hZ982w4=;
        b=EmnDUzw8N+PasFoWBOfkjSf1v9LLRo+NetkKjSknEOfTY2sSvqZFI5Ht/QY45Vu/4V
         RKmvyvXQ9tNds2hHyHtxG5caViuj6GiBDYenZf2Q/Blzqd56xLk4sx0ctd/3ezgwqGT3
         fTdbQszRmrps/6RsEGgkGCj1NzZfLoA06QU9Cq9HW/55qJWIy3w98/wlNlQySfbIWyal
         V0j4TXw856Udx0Jr3auHimIoAp/EA6pe0yndPX7owcr9Ga9tv/0rDr+EM3q1wn0cjcCE
         1e93a7vHlsV9HQHE//EN1ofnfMR2fkt5AIEGeKyq1CCSg3YQMSYls0Zj3Pdrpz5eQXkN
         z4/w==
X-Gm-Message-State: APjAAAXWngxHTgw/C8m9isC5LQSaXcN4BOODUpzDoB2vTv87zTQwWcGf
        2sOPVi8vRFoX+vF+VZXz1dvyfpl3o050LQ==
X-Google-Smtp-Source: APXvYqwZVMSshSoKXvBVi1g0beYgtiMfkrYkyv4myK7JRrZ93XX+TM08apFcTUgf3agBkqr7UWkMKw==
X-Received: by 2002:aed:36e5:: with SMTP id f92mr2430071qtb.354.1579876411764;
        Fri, 24 Jan 2020 06:33:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t29sm2524663qkt.36.2020.01.24.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 17/44] btrfs: hold a ref on the root in btrfs_search_path_in_tree
Date:   Fri, 24 Jan 2020 09:32:34 -0500
Message-Id: <20200124143301.2186319-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

