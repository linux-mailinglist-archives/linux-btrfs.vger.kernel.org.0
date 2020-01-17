Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC353140B82
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAQNtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:49:03 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41270 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgAQNtB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:49:01 -0500
Received: by mail-qv1-f66.google.com with SMTP id x1so10719503qvr.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7dXPcLtcCSCDRGETr4vm+QgKm0KbD9S2RIf4ehLy/AM=;
        b=SFazhMZf7X3TV993wk9WSR8gA+6c7psqbxXlK9XzjhpHn5XQsMeX0jtf3+s/SGzKfM
         lMMFLchJvAXgDy943vu1voG1IfZvc6rH1c3hpLy2IYPSV0QN1GhTm6FRvuhNiBuSmuwO
         vcapNLIjuWrtfwACKrSqEFVOYJheI/oEA0QQoFH2jQCOCtgsR6yXAlizgfINr037CywG
         JZsbxqHqJNo4ZlKoNuKKrOC9O+jASDf05DdKOWc6LnbLZKqOohPTdNlD4RVAr5ypsmR+
         yXvszwKxqSQDuneyYG6Po4solUxFWQUReU3+dAgkD6ivUzWwQIZ1FEWcayecznACfVup
         0L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dXPcLtcCSCDRGETr4vm+QgKm0KbD9S2RIf4ehLy/AM=;
        b=i3awGlc79RwMISDQPurOb9H3jvuzZ0PxkJUB2uoqVkMfNkTls0WrmfpNBk3H4h0LyQ
         ytuO6A6xSZQEsxegvHagLxk674DQmLmGBOFy4O2Diu0EuVyumNHGYaFbo/dUxfiQWcRg
         QtjRY0GvCWqnN8LGuEKx7wCFNsL5KWhl4WF3ye8+oaA/+yfzBnE8wAyYWmePn/xDHxjO
         Du7YFJ2Yhvqip3Jlv0+AH4TTTurCid+9xbB7ryHhzAN73lVZqfWTHye8er1HarZCqx0J
         V3tVVe7n9aCPcaLSQF5sQkSor64Da6HoDtPkvY4utffekT/ROziELzg0j2kgTB/Zc6l3
         ZH8w==
X-Gm-Message-State: APjAAAUREhAJeBLHZ4JI/f56AftRNLatW6DK6wGPD/hlYTE+GJgH8IRy
        5jLRfwtSfhp6n5IYM7Pu0RmRnjcrkDe11A==
X-Google-Smtp-Source: APXvYqy4fsYDdx0XkLA43Zb9tD4v/k+wlmu2m/Msq+NxVN16Xnonf2lYUG3d9TXMNOohuca8WdPIbA==
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr8004450qvp.68.1579268940303;
        Fri, 17 Jan 2020 05:49:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o6sm11543944qkk.53.2020.01.17.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 35/43] btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry
Date:   Fri, 17 Jan 2020 08:47:50 -0500
Message-Id: <20200117134758.41494-36-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the uuid of arbitrary subvolumes, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ce3eff93c366..527b0b41ebdc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4382,6 +4382,10 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(subvol_root)) {
+		ret = 1;
+		goto out;
+	}
 
 	switch (type) {
 	case BTRFS_UUID_KEY_SUBVOL:
@@ -4394,7 +4398,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		break;
 	}
-
+	btrfs_put_fs_root(subvol_root);
 out:
 	return ret;
 }
-- 
2.24.1

