Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF57471A0
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFOSZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36373 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfFOSZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so3827338qkl.3;
        Sat, 15 Jun 2019 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LIH/ZSr79Tn55qxPBQsZoWtTcM5IaydfNkQSRyHlb9Q=;
        b=CurpXwQSCE0pNhvm+GLfAqWmICgukKsaE/IpRpfQXwEsw160H63N5DXWHoUsoljImq
         su0WKV6unNlBZ5LtyEhB0oDAMkxIiXExCCGVbw3UQOXZSnO5Y2h3sKKg0lT26lesjYvH
         EXcAnnwWa21/To7Jzgz5zetr/GDjvVEjGFWD4jRzK0J9jJI8m17nmxvOXJSa4LcGBAus
         sYE0om7+0urC7gOqTtfhLvzSJ1xpUJu2R0tdoAKSZT5Gx/D7o0ovnkmDl2ZMx6czrrHJ
         V6isIKBAfeL4FSui+fw3Yv0Eo6MLXIY/GIFY7MK0Sea9+Iv+9vkcR0gg1xy44IUYqwqe
         pZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=LIH/ZSr79Tn55qxPBQsZoWtTcM5IaydfNkQSRyHlb9Q=;
        b=Ln8LIcqbSXe4SS3vhSr8vd8Gv6fAUf347j2tfjggRU+68IL3rh35wnZUcBs9/dWogN
         miMLPK0wGqtYjnQaJ2eGK3iJs1BusOTU9x7O/DOCUM7UAmTo7DYO/gNYx0THoZVQ3moq
         4rGQuwE0dx1EEXxr5CK24Qv1lIW89CKzXDn/n8ldqUrOLGyZx/Rt5mY47c2ZwCW6g9LJ
         Or1vdCIm8bP0NaUizUwwZ//FP/9u8OzQEkfygVfG7Ira52NiKNG2BoIYLjkQigq0QNXC
         nABMMEgFPvsicyjcugCgxCVchFp5G3JLvxwie/DjHWKcK52UjKe4U1IhMPK5Z3wJmoEt
         AvxA==
X-Gm-Message-State: APjAAAVNkHyyScobBW/NM1THY6FNcxLoj+Di3trmx5+F1abcczfev4+g
        vTAN23ldfCLkql49TcVgKPg=
X-Google-Smtp-Source: APXvYqyR8G50+n7mA4iZ9L0MB6ZIAZ2h2QTc2eTMh3NaZzH0rWhmETS5t5glFSzSuFEM2/UgoEmwBA==
X-Received: by 2002:a37:4bc5:: with SMTP id y188mr12989076qka.13.1560623128770;
        Sat, 15 Jun 2019 11:25:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id f68sm3715819qtb.83.2019.06.15.11.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:28 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] Btrfs: extent_write_locked_range() should attach inode->i_wb
Date:   Sat, 15 Jun 2019 11:24:53 -0700
Message-Id: <20190615182453.843275-10-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

