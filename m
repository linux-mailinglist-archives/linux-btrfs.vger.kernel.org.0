Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506361412D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAQV02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34260 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV02 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so24187839qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IID+TNjtvNq2y6b27Gs67SLa1Kba2OW0SQsgqv4ynLA=;
        b=xu0UPzrhHQrB/XECAt/kegodtKQmG6m7NK30DcOjyL8Fnqfz40IaAgDVCv9YI6agQo
         Q/R00wRs46m3vIgtOJ7lvJA3Q/E4crNuw5DY/LZtv3fWc53QLQAZEWQJOpQOdRijhzlX
         Q8mBl8uslMoKq9wWsdqD9QHg7KH7PxSTcRAsbkUFB3HzUgrM5CMOEeUWI9r4H2jPhs2Y
         tli5NVsgjlEzDK7/mSi/MpMgJfKClq1sdeUEtdxx5LygaBs6ZWdFvHcIY+cxK0lmSP65
         fuCPMOYtkWnWe8RbrOzE00Jzb6HafHaLdlN/2E3ENd/DOoomRYsGQ2CEaKK3Vauzqt5+
         0vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IID+TNjtvNq2y6b27Gs67SLa1Kba2OW0SQsgqv4ynLA=;
        b=t6gG9kZTvvFSaVezevCXi5ZKXddiDa7pmaxHAUB8dqd9DmAh6ra1bl3i2VEZVFTJ/B
         EN+wrJPfWXYdjDGVYRjZ5951c+lOSejZ6k0p5TJbLgkPkKJAyubTUWx5TcAb8LCbVbWU
         AQFzCNC4mGWCIo1aS9WhVOG/8jxVimlfIluPoUsrVLaVq96hIZ8/+nqKAfrd/b1zaeiq
         QH3PjywO4iCM+LubPdI2GDJyNpYnyX2tIcJvVitg2vaXTCBynlwHMdf5j0OLGQqga78+
         JdCaA1PfuvMZS6HmKuVSTAKfSvTuul6hxyeQHMRvOSE/LYJ0aEdMZaoJQqDNK4rLMwsp
         ssnw==
X-Gm-Message-State: APjAAAVaaJrXGpWAQLJGr6lT7WEuBP6wCihr/4P1KEQlJdfVEbFJu5s1
        i7K40B9k16YlCcCOaEIXtGSXwGVyL1tTsw==
X-Google-Smtp-Source: APXvYqzYcxtIdUZaxGqlEc7irNZUgYkdFD5Z2pX73fLdIE08Hj6/z7S9cC2u/cnFutnXW7xagtaVbw==
X-Received: by 2002:a37:f518:: with SMTP id l24mr34233116qkk.441.1579296386637;
        Fri, 17 Jan 2020 13:26:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w60sm13452973qte.39.2020.01.17.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/43] btrfs: hold a ref on the root in resolve_indirect_ref
Date:   Fri, 17 Jan 2020 16:25:30 -0500
Message-Id: <20200117212602.6737-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up a random root, we need to hold a ref on it while we're
using it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d85311d5d5..193747b6e1f9 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -524,7 +524,13 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(root)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+
+	if (!btrfs_grab_fs_root(root)) {
+		srcu_read_unlock(&fs_info->subvol_srcu, index);
+		ret = -ENOENT;
+		goto out_free;
 	}
 
 	if (btrfs_is_testing(fs_info)) {
@@ -577,6 +583,8 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	ret = add_all_parents(root, path, parents, ref, level, time_seq,
 			      extent_item_pos, total_refs, ignore_offset);
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
 	return ret;
-- 
2.24.1

