Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9F140BEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAQOCb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:02:31 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40573 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:31 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so10723273qvb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NjeKhz45N0WY9hyr3DplHzY04Sd1b9JJpZwkMLAD/BI=;
        b=fv0VrOnHVXD1qHklGuC/vdNIPloKysANOUrbPXrZkDNOssXb/1a138Q5awNFT2furo
         NC+n4K3JDnJVlt8w9IIKWhbg8zaZDZsgRNn7vqYkITJM8t9QCi8UpBgcE+d50Ts/E5GR
         j6RAl6mtFTeOmoxcfrp5zSgAPxIrvENbXeulIw5RbepzwrPi1ONOXiTCqaUUfBV5FC24
         hkrJUVTlTLKoc962zELfg3ntwfz+9ozh5gVGK8Sw/DJ3VTLSkjMzEivcmupiWfaDNzmw
         2kI6On4nV+C8aBe1oevW6LTsByqToPmH1eaaD7x7WGwzLBgheR0hGTOOri3c8bPRdcNT
         5lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjeKhz45N0WY9hyr3DplHzY04Sd1b9JJpZwkMLAD/BI=;
        b=VHCR1MGV72bH82kT+ArRusBcr3HMoGf8OcQw5TKQy4tpa/2l21bcXPTHCacg2aZt0E
         0lbe9nYsdLDaAfiej0mq+KCPU0I4k7m2tgL5Ghketj/gwqQY8aAgrTGvF8QCtvtIyttT
         0z5ZHSEOMtspw29BUzuk7GdGenS8tdD9tEjUcDTQkyTsp9spNuEW/cSSe6nmsXYpUPZd
         AItGgEvUwnh49qRFVrvZVAxEo6EhdfzKgMSs0Y2q9yH1aYuBix2eWP8D6kw4qrZXAHzd
         FBcxr1+6lY3N2xK4yiAuZDMp5F7Z7l8AGzneKJNPAgbmfocYsTupRwOlvLgaBRxDzCkQ
         zZLA==
X-Gm-Message-State: APjAAAXiBvoaXt/pbatYjolIzHXG0bkJbiR9Vv/MUBAHyC44XqgaUm/n
        Im1HPDD7GBuGIaq7NSLzDeA9WsIsnyhUmw==
X-Google-Smtp-Source: APXvYqxD+CcKtb4y2YzCkekuJA4pVmC1ylXZ0kdJ/iBBe9Y6anTSBlFREa/RJ/vAVOOSi0B8ITDgRg==
X-Received: by 2002:ad4:4f45:: with SMTP id eu5mr7958108qvb.235.1579269750472;
        Fri, 17 Jan 2020 06:02:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k14sm11712738qki.66.2020.01.17.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:02:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/6] btrfs: don't use path->leave_spinning for truncate
Date:   Fri, 17 Jan 2020 09:02:20 -0500
Message-Id: <20200117140224.42495-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140224.42495-1-josef@toxicpanda.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The only time we actually leave the path spinning is if we're truncating
a small amount and don't actually free an extent, which is not a common
occurrence.  We have to set the path blocking in order to add the
delayed ref anyway, so the first extent we find we set the path to
blocking and stay blocking for the duration of the operation.  With the
upcoming file extent map stuff there will be another case that we have
to have the path blocking, so just swap to blocking always.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 10087e1a5946..4bdd412182ae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4066,7 +4066,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	path->leave_spinning = 1;
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret < 0)
 		goto out;
@@ -4218,7 +4217,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		     root == fs_info->tree_root)) {
 			struct btrfs_ref ref = { 0 };
 
-			btrfs_set_path_blocking(path);
 			bytes_deleted += extent_num_bytes;
 
 			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
-- 
2.24.1

