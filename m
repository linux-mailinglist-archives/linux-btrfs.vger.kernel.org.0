Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10E176327
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgCBSsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45696 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgCBSsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id a4so737391qto.12
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qmaK7TBMVnh3Y4VaxRl3kWjsYc06fGjS4kb38E9wuzw=;
        b=fOWqcLWHqXgGuhsBzhpAeUuZWrx9dv9z97fJIePz8ncIcP8/7RRtDPzuK/TWKGSY/S
         Low17tHjJjVU/AkuLjFLWOddvNW2ySmDf9/IiXS9EA97ncaB+o29u5h9VmL64B5ZzZe1
         yIEeddUYWCOu+xI0ClfPEs5uhzDQQCYC/o0xmTtllQE2K7vv9Y4uzT9zPWfIYWKFkAdL
         FZFbQyc3zyyg1LSpKc+EoMS2eJU4XoPwRxh5ttUiLjuIuy90Dna+1y1z5Yikgkw9Cx3n
         PQABUHQcaDkygOaxbM1728ToBbd2I8CzOdgg/2BwKU49z0lB5G8g8tG6ApmbnO7RvMLE
         pYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmaK7TBMVnh3Y4VaxRl3kWjsYc06fGjS4kb38E9wuzw=;
        b=B2Fo8q3sxwvFci0tf6yCWSh6kc6zabBiSh0A1Ln4W8wCKBc8HuIoT1tmsXdwdqkLbo
         gvT+dgj7TmFJSyClsNCUYyOjVPpr6k+ZXEd2z0VGNldDs66VW++bVmt5SN8Gu3CaDVEw
         nIrRW+lxIzETzDHKPU58fW5i6OBl1V8riwSRSey+23YhWZCrLwcRkmopNqzrTyY7uAHx
         vrIv9J2U5U1agkoXwdvSQg/RVQ8sBkmBphm9CgbAg6p6wd0zMRZkPNtKhAqBkVf22jho
         5OcUvQfUyGQmS7hbcaXIkT7ntP47uRlJIWLzk9PWgXOZ5DuzEhlfihzWlYXnJNdOPDT6
         Df+g==
X-Gm-Message-State: ANhLgQ3MC8DHWDj8x8pguoh7UFLcFGNpkyRMOGnFsv0mEUiqWmIAC9ev
        y7annq0dtmWcH4EdqQGF19Gla6MxF4w=
X-Google-Smtp-Source: ADFU+vv+6liQbDj6F9m/5Nk7wS3xobupAmC+wtACcDNSFqFEahDdQjhD9DEnhqqEKGyFOadk8MCezw==
X-Received: by 2002:ac8:2618:: with SMTP id u24mr1050448qtu.297.1583174886998;
        Mon, 02 Mar 2020 10:48:06 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f128sm10602296qke.54.2020.03.02.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: run clean_dirty_subvols if we fail to start a trans
Date:   Mon,  2 Mar 2020 13:47:54 -0500
Message-Id: <20200302184757.44176-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do merge_reloc_roots() we could insert a few roots onto the dirty
subvol roots list, where we hold a ref on them.  If we fail to start the
transaction we need to run clean_dirty_subvols() in order to cleanup the
refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f42589cb351c..e60450c44406 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4275,6 +4275,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	/* get rid of pinned extents */
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
+		clean_dirty_subvols(rc);
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
@@ -4701,6 +4702,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
+		clean_dirty_subvols(rc);
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-- 
2.24.1

