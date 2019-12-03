Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C357B10F48C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLCBek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:34:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35552 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLCBej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:34:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so898974pfo.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 17:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hJ94Hx3xilzbtIBQ65ljDvh6IjEBRdC/DhWOmD8T7M=;
        b=Q8UfocYzyqKVA1Cx/dc41tlTPP/J3/DZoVld0lwroRly2Hc7W92P/8aZ/4t0zP87Lz
         sfopkldmGwXe5ZDqqc0/NnIFOeHxY5obcriJHNe73KvMjeF1VWm61JtdQvSGUuxE2HAK
         Sdt85w2GL+CclXuweN6HE3rhdOKDVGPkKV4rd5oh6TLFH3q+s2rqmJxdotFcnifTA6O+
         6oMQf/riUsz9W5ucD94dBJKuRp8lk2zgwnCkYdiv+o4fEBU4m5IUdR86Or8OnB3gdTEc
         F70IpNTAptjxL2/uGWwC7h3SmXxY5lvu/Fe6HX/29PQwEG/MvlPv2nxMECjBway39GXz
         +tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hJ94Hx3xilzbtIBQ65ljDvh6IjEBRdC/DhWOmD8T7M=;
        b=MbnxGgSgezjaJ9SSLBsL+H8k1YCkTJ1SvL0Cy5gzmv23Bde5vQMBC8zjiGMUw+6X/u
         d5bRlMGLwMvleo1yi7a0ct+G6KsbdXQYoVqLtvSx25GMUEgzwnc9cuHq09cAa/N4BQXl
         v62JgsIJMZf+MJmKxlDwBcwnSV2Eey3OvZ2TNOYK/Qt7OxIFGr9CAAiYQb3okOYUCJYi
         gb5vHdEmzQ106E17YNRJDBwg6K86lbld8RRBNCwOTcKgrqHx8jyLSgzsmv+FUPPDKCrj
         X6xz3GAQp/bwSkFhaR5Z6sGgQD4xiKzC+OgJxmrRkp2MAlPAWLZ+fayvryamK6n7L93e
         qOBw==
X-Gm-Message-State: APjAAAU70qXoXS/d9kTqzO2wIUuUOyPoISoJ252FGe6vni+p1hXusOt3
        UvHLUGP8wM0wnGQENlkH34y9vCWvG3Bg6A==
X-Google-Smtp-Source: APXvYqx1Ix2Q/rv+CvpEI67E7kGyE8vc38slFX+Qy5vSbyIHinrlVkn/yCRUXeGZ9XxY8TA0qi/2/g==
X-Received: by 2002:aa7:8256:: with SMTP id e22mr1996904pfn.247.1575336878763;
        Mon, 02 Dec 2019 17:34:38 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::6ddc])
        by smtp.gmail.com with ESMTPSA id u65sm800242pfb.35.2019.12.02.17.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:34:38 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: remove trivial goto label in __extent_writepage()
Date:   Mon,  2 Dec 2019 17:34:21 -0800
Message-Id: <81ea4a6b327f26506041e2e43adc9dfccc7a86fe.1575336816.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575336815.git.osandov@fb.com>
References: <cover.1575336815.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Since 40f765805f08 ("Btrfs: split up __extent_writepage to lower stack
usage"), done_unlocked is simply a return 0. Get rid of it.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dad6b06d0a8e..8622282db31e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3596,7 +3596,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	if (!epd->extent_locked) {
 		ret = writepage_delalloc(inode, page, wbc, start, &nr_written);
 		if (ret == 1)
-			goto done_unlocked;
+			return 0;
 		if (ret)
 			goto done;
 	}
@@ -3604,7 +3604,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	ret = __extent_writepage_io(inode, page, wbc, epd,
 				    i_size, nr_written, &nr);
 	if (ret == 1)
-		goto done_unlocked;
+		return 0;
 
 done:
 	if (nr == 0) {
@@ -3619,9 +3619,6 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
-
-done_unlocked:
-	return 0;
 }
 
 void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
-- 
2.24.0

