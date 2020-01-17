Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B717C140B6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAQNs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:29 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45387 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAQNs3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:29 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so10696507qvu.12
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UcvWdvkB+kuoKVdsm56WFQ+OEF9OJP2c6Pzz38qJFgg=;
        b=vz4KrYY+GfQzNPWYi6H2dK7EONAMszhg+Vp80TD66j9TIpL6k9u3ToptklhUjyPU5X
         ilXPoycF1hxdk4tvYn69JlMPmSYSuuWuGX+uxxbonLCglZQosFW7PQZNyyegVYcT7SA3
         yYwExQ5FPqYpnqIfGACvLLR94RTveaQn9q3OvxMjYBqns6Gu3gyFMSJ/mdqpSHOxgqMn
         u0qKO4SL+/Owi3kdYYP5v7QvpwM9X6UDtsPxrtF707LlNjxe9koynosqvZAFQXOmUMR4
         /tln5RS2tdbraEjlkjsJ3hNBMhnamFFgMGV82KsQRTHjr/TJRAu0I6EU3MKcbSDYyB+Q
         /eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcvWdvkB+kuoKVdsm56WFQ+OEF9OJP2c6Pzz38qJFgg=;
        b=BFAv9oXSChbS4eIoo4TW5Ne8zyb9tea0fAOrYQCWv0uvRZvRHyAuKnS/QNGgAG++4U
         iQo2fxo5rC7VZ01zyiTdB/ejTOrGEeP++Hd8aERt07bYN6DkDeNaHTNRM3Stb2Mx2doe
         +NHjFCGZwhgc5gBb8yp2/nSZAMo9RwcTGUWNZGWZqw+5yPa0IOWfuJGXUXory2PMULlr
         xNmz7jWHLB7smxh9sksR0+BtQMCHCXlIGtfQi34sYCgTDbgidUetGZamUDSevB1JotYT
         3JTrOeZAj3rZE4GWVEAaV7aF873oQensAzvAiuOmWcIX9MJODMupeXAstdIUiR8Qsc19
         QTHg==
X-Gm-Message-State: APjAAAUdAUGx0q6+N6g7TGPsMv4C5VBqglI0S9epONeP9Qh4yoTz2OQK
        Nmd1NL5C3U3CVhbEJiD9VLudMOYIJg8IfQ==
X-Google-Smtp-Source: APXvYqxEW+vlsjOFfm33Ge2VnV1AThP94CPt57qoH4ac4BS24IpzpEiJk+Ko4W86gQHhiWAbcLsGpg==
X-Received: by 2002:ad4:4389:: with SMTP id s9mr7490946qvr.99.1579268907972;
        Fri, 17 Jan 2020 05:48:27 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a14sm11754610qko.92.2020.01.17.05.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/43] btrfs: hold a ref on the root in search_ioctl
Date:   Fri, 17 Jan 2020 08:47:31 -0500
Message-Id: <20200117134758.41494-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup a arbitrary fs root, we need to hold a ref on that root.  If
we're using our own inodes root then grab a ref on that as well to make
the cleanup easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b1d74cb09cb4..62dd06b65686 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2180,7 +2180,7 @@ static noinline int search_ioctl(struct inode *inode,
 
 	if (sk->tree_id == 0) {
 		/* search the root of the inode that was passed */
-		root = BTRFS_I(inode)->root;
+		root = btrfs_grab_fs_root(BTRFS_I(inode)->root);
 	} else {
 		key.objectid = sk->tree_id;
 		key.type = BTRFS_ROOT_ITEM_KEY;
@@ -2190,6 +2190,10 @@ static noinline int search_ioctl(struct inode *inode,
 			btrfs_free_path(path);
 			return PTR_ERR(root);
 		}
+		if (!btrfs_grab_fs_root(root)) {
+			btrfs_free_path(path);
+			return -ENOENT;
+		}
 	}
 
 	key.objectid = sk->min_objectid;
@@ -2214,6 +2218,7 @@ static noinline int search_ioctl(struct inode *inode,
 		ret = 0;
 err:
 	sk->nr_items = num_found;
+	btrfs_put_fs_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.24.1

