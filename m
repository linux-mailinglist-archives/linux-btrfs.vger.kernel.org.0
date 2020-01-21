Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CF14427C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAUQvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 11:51:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36832 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAUQvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 11:51:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so3394180qkc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a15u4fbovBx8YwGKQ0R5JzXbLpyL4RmWglcn/MdMZCw=;
        b=syP9KHjcfffDbCaRVg1GS3vG1A5yx28i4KA3hBVaR5pLD/Cc+hqLUVmAz02Nq0XnpD
         Q9ud50msJfgyB0wihDD2OBJ3wpaKNyvHj8acYt8/gao2SGgOKH3ECsKSM3V35l3kuyEO
         U/5q/DBC4yJZx0BYODyM3YZkLvSwFrcs/iyn5NY9o6rQS32FDbh0SJJGSJsBryZKEFsn
         jnsZNKszOdS8U1/6DTlq82XWdXcxJujIzT7iXR+vsZUOmv7sR1Llwi66EyzZ0r5i2crF
         rrU7AywhahEena+55jmrkZ1eyfrtzXPCbD5fP1OM0aSTtJPOUE/fCX1r9OGCeEzt1Qo7
         xzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a15u4fbovBx8YwGKQ0R5JzXbLpyL4RmWglcn/MdMZCw=;
        b=IQgrPuBEr/nMqXf/8UOq6pmJ0XcHDDTjhjwpvpnhxBiNiTsTo5LbSwQdxX31OBC5iH
         d7Dv0fs/zr7ZeMkka68JDyNhLvpzfdZtD0NTk62ySnH6l1sbKj6rSUxWMLOIBpww7ja7
         vaA0rmAgZE9WgVZw0JSWZSsWnCC2d1yUyo6qJ0OmESFy5Y3Kk4W+EU+Anwkomgw3ZnlQ
         85ojjyC4KFVrm4xyMp9rONJjjkR7PRF15djmSjf8uU+NXtRJIMlDCp1fNydGI5nAm/Hz
         KGylx9r9gbrBrYR0AxUrNqGo4GU+ArKkE8T/Erv5QjrescPtLEwxu97mNb1JhnT0pJiO
         v3sw==
X-Gm-Message-State: APjAAAVu0eqv4tDZE+g5mQ9QCN/6h2RkUQ5+MsHS0BPxmubENOXhKJlR
        EQb6GYOkT2DePI6Bd3TyE4yLqI7iwacWHw==
X-Google-Smtp-Source: APXvYqzbtxOrvpzoEfEhiYySC1cprgMrKRSTKv8GxcUw/Fk1FEP+l57ZM2ZD4RWNNAL33WJ9uPDtRg==
X-Received: by 2002:a37:4b93:: with SMTP id y141mr5611940qka.205.1579625511279;
        Tue, 21 Jan 2020 08:51:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v7sm19993688qtk.89.2020.01.21.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:51:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: drop the -EBUSY case in __extent_writepage_io
Date:   Tue, 21 Jan 2020 11:51:43 -0500
Message-Id: <20200121165144.2174309-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121165144.2174309-1-josef@toxicpanda.com>
References: <20200121165144.2174309-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we only return 0 or -EAGAIN from btrfs_writepage_cow_fixup, we
do not need this -EBUSY case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9b223d827b3..0b5513f98a67 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3457,11 +3457,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 	ret = btrfs_writepage_cow_fixup(page, start, page_end);
 	if (ret) {
 		/* Fixup worker will requeue */
-		if (ret == -EBUSY)
-			wbc->pages_skipped++;
-		else
-			redirty_page_for_writepage(wbc, page);
-
+		redirty_page_for_writepage(wbc, page);
 		update_nr_written(wbc, nr_written);
 		unlock_page(page);
 		return 1;
-- 
2.24.1

