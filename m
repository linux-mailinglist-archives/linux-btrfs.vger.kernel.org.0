Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852751412E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAQV0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:51 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34305 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAQV0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so24188845qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZyvR/29E2jaJfcsrXDpaKI230YXqgH46fp1QGEE+fWU=;
        b=P2BnfnP0IP4RxMJ4lOc2iRcsEUl84Eu5ZaGsNpt7sir3P2OZlm7b0tarAfKQuCD1xG
         ysZlKBfQAIDeIZZicxKwBpK1b/ILtYFcEpVNhkh7nXmkYzpyyoedGrwv9VFkVJdBoWZC
         HBten5vXJvaXIB8lReOOS0voW7DZ8fFn0AIdevtDotduZ7Y5fHK6bIHhhGNqtao02TMv
         /jGKxrRPGYpceOoDYYoBOiSQvQ16cCBSV32/fYmXhpvaJHm2ZDjOXB0ofqOTanKLpHbH
         n9+inQBnp+EpiOTrdGlt3zCcmOERMoq8R7vppdJtZV9VPDH3L7yGXNSwPIQh8c1IqHLt
         vmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyvR/29E2jaJfcsrXDpaKI230YXqgH46fp1QGEE+fWU=;
        b=LNcE/zjuzc8s6QvWUix+WNIzp6D1F57bO5d+zAbHWTWqUSsw8ex7P0G96ncL4tjBxT
         Tja/JGDTEiMX+gjl5HeQYW7IiSlGW46DWIvTlOThE7TJ7hXYf7Xz8mB7BQGfAhseF18x
         knZyY4Yffb1uKg3VM5qzLqsn3sIRYv8HRUuAlv2yGrXeOJkmoe6/yi+rki8h6gsk+QuZ
         61LJfoBnvOtfqWDLMAmy7qlU7X3tlUChAZvGJPzez7bQpqu0yCBOSQUGrvb4Xj8+AEjz
         renbn9DzRYj+gdIBa2DSEjSBxCPKdelRCo5sRXHIDxqVQjXIdLXKuDbkAeneIfVzs5sC
         rDgg==
X-Gm-Message-State: APjAAAWSrczI3MIvEDiaV7dq+5Rw7P1I2WGOZqjDVuS90sWi8e5Lh3bI
        7j6dCfc8977l3JnC//mP+4KzyZ86C5ECIA==
X-Google-Smtp-Source: APXvYqyOKDEC7Q8E3hW7PLej2oSR41FlZk8P8a/JZtak/PQHsLyhpBV0RDBrVfZLJ58jFLEUpCdtUw==
X-Received: by 2002:a05:620a:795:: with SMTP id 21mr41221193qka.60.1579296409978;
        Fri, 17 Jan 2020 13:26:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l44sm14094190qtb.48.2020.01.17.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/43] btrfs: hold a ref on the root in find_data_references
Date:   Fri, 17 Jan 2020 16:25:44 -0500
Message-Id: <20200117212602.6737-26-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up the data references for the bytenr in a root, we need
to hold a ref on that root while we're doing that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9b61fdc89af7..0c75ae09a3a8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3708,7 +3708,11 @@ static int find_data_references(struct reloc_control *rc,
 	root = read_fs_root(fs_info, ref_root);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto out_free;
 	}
 
 	key.objectid = ref_objectid;
@@ -3821,6 +3825,8 @@ static int find_data_references(struct reloc_control *rc,
 
 	}
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	return err;
 }
-- 
2.24.1

