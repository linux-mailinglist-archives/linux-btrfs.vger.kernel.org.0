Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7BA450A4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 02:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfFNAeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 20:34:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfFNAeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 20:34:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so265030pfe.11;
        Thu, 13 Jun 2019 17:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/0EbDb07rl0+2nTNpL5MUvCUgcM2dhBTtu5L9LJF/5g=;
        b=fQzf7NTf2AamLhEOekVA/tGq5CXzVixbTzPlZT30QW79+jP48lozuQt7de3C/lUMk6
         7p1A90E3IRJOZrR+B2m+ZrxoFfCgONFripL6/Z6mK2eXDG56V6Zi347mNIXBIr+OhFla
         aAg7SCSH04phUpxuD4oZnN5t/VB1pzQAvjDg+Espr09ucLisQJrJW6+c6rOQiDYNDbH5
         xhdBaUkdvurnAXEPEiRXw/Kv2kk5D/VZ460Vakf2HZFPW/HJJLZOQ0mIDMFTThsckZhX
         0mcILt3PpQqiZ21EFLKp0N0jJor1Tpv04ozuYMNx5aMTFznWeMM5D7UzlFmwCxJl01KW
         1mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/0EbDb07rl0+2nTNpL5MUvCUgcM2dhBTtu5L9LJF/5g=;
        b=uDPLnad4C/EA2D2qXmUkEr+QLoS1ghc1SiYmgM1uXTayEO+a+kZM9oY84WdFD7llAF
         K5HxRmpuJ92qYgEOv0F0HQl5B563OjnlK8GWJt4kjyPq2vNLyUxaOCxjwDjjLYyNw4HB
         KKdiCnaRyQByEzCZRT7QrL6xkSahocJ1neWMg6dN72PIyFpX35ocCRQM1GGoYQqO8I1y
         khx7sccA4gIxk1IvFPxWsrf47uyrXJ6HjOPoFZDZ7rGvnM2ma/QbrywsOt3uLfSKmdsP
         N7zXWtDJlj7uYbdGpkYsN+I73HV3SxqHbrToHqPDcQ/WB3LqxC6a6g5eOg562xGcRNna
         QjIw==
X-Gm-Message-State: APjAAAU4uUcw+6gv1EhpjrFfdgcU18/B2nPotznGLQwWX+mwiUNWUcIH
        /zNR4U+99+7RmxAt/scZ5R3+jmU1
X-Google-Smtp-Source: APXvYqybF/2c2vJJoH/ecmJ28qkRmO4fYSx+6HWKnNfzXIXgZ2gGvs6MVXS9F4ZKN7ITIYYq4h+QuQ==
X-Received: by 2002:a63:e950:: with SMTP id q16mr8093874pgj.270.1560472453741;
        Thu, 13 Jun 2019 17:34:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id p3sm898857pgh.90.2019.06.13.17.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 17:34:13 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] Btrfs: extent_write_locked_range() should attach inode->i_wb
Date:   Thu, 13 Jun 2019 17:33:50 -0700
Message-Id: <20190614003350.1178444-9-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614003350.1178444-1-tj@kernel.org>
References: <20190614003350.1178444-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

extent_write_locked_range() is used when we're falling back to buffered
IO from inside of compression.  It allocates its own wbc and should
associate it with the inode's i_wb to make sure the IO goes down from
the correct cgroup.

Signed-off-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/extent_io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d7b57341ff1a..afb916a69c30 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4180,6 +4180,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		.no_wbc_acct	= 1,
 	};
 
+	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (start <= end) {
 		page = find_get_page(mapping, start >> PAGE_SHIFT);
 		if (clear_page_dirty_for_io(page))
@@ -4194,11 +4195,12 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 	}
 
 	ASSERT(ret <= 0);
-	if (ret < 0) {
+	if (ret == 0)
+		ret = flush_write_bio(&epd);
+	else
 		end_write_bio(&epd, ret);
-		return ret;
-	}
-	ret = flush_write_bio(&epd);
+
+	wbc_detach_inode(&wbc_writepages);
 	return ret;
 }
 
-- 
2.17.1

