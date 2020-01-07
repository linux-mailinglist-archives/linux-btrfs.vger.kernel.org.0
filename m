Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06810132C4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgAGQz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:55:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgAGQz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 11:55:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so335692qtk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 08:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qlZCxBvnUUAjdtWIZdVAdDAL1tqiSSvBhzh47uiwmCc=;
        b=m0omdZf2gZOoaH2jWMdI6yGukE2XEaHzuAl5bDlNFAPUOxG6/kx8clfcuh+UTVSSEC
         7TPfkZ66xh+SCvZM37m0dvlzW4qBf6nzKBSKByH2fokdA9SjnR50uQbfhxfD72Kr40Px
         UKhIjbINpeHuD5qCaaRtAGdrX9edsh63L1Np2FUe2q1QzcLmPHP2bBjiNo2BrPGNK5sx
         izEMlSGmDVnQcqSpD5rX+LGeNcrLFxEXHt7+DpfN+pBJc+A8ZzvvK1SWs/zYD3gbLh4p
         o4hXBNCSp0O2TV0sREZhHdy5jTwwCEeRG9CNvn4JngJsT2zrq47on4kRTnc/QIL+nA4Z
         DSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlZCxBvnUUAjdtWIZdVAdDAL1tqiSSvBhzh47uiwmCc=;
        b=dwDqrVbuHtKZGWGvLME+Javoe5xZ53Omip4Uv3gkGL1esw/YB7JClTTOMdqV+yyxSq
         tJTuipMdG5GXRW6eO29gL5cRi/oVvKXzMG7LYkySGX8UhUfR23jZy1z+UscFap5i8Io4
         oLAm1NEW6aLOQm7+Ys8CkbE5NbMaFyYmTGQgzzPFq1+Q4/4b9omGrpTSZmCTGntcNeUj
         5eNOdRmCOMf25Mx9gBUZ44aOHw9wbZGA/0sRSSLJp1GoW0sDI1/4503rfnsQz6kJJSYQ
         33pz8pj6XDxSibZ+8ZEBS389weWzkTdqVFTaZFQpLl6oe3a8a01a88T9koSgb1iw57q5
         2ksg==
X-Gm-Message-State: APjAAAUmPuDcEksyTlGaV4MtXJZpaYAmxGSD7mzecHbgZqtSrDS7w3MT
        EnOfm+amnHUX7eRUXcjoMOIwqA==
X-Google-Smtp-Source: APXvYqylD6CKxQf79S5PaxMlP5DWYoWsX1dOmP5XuaMtzb6C7t/xqNqVxGhLhcAtWWU24adtses28g==
X-Received: by 2002:ac8:7155:: with SMTP id h21mr75689670qtp.95.1578416154907;
        Tue, 07 Jan 2020 08:55:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g81sm65834qkb.70.2020.01.07.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:55:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] ltp/fsx: drop caches if we're doing closeopen
Date:   Tue,  7 Jan 2020 11:55:41 -0500
Message-Id: <20200107165542.70108-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107165542.70108-1-josef@toxicpanda.com>
References: <20200107165542.70108-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fsx has a closeopen option where it will close and then re-open the
file.  This is handy, but what is really more useful is to drop the file
from cache completely, so add a drop_caches into this operation so that
the file is read back completely from disk to be really evil.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 ltp/fsx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index c74b13c2..e519367b 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1778,6 +1778,10 @@ docloseopen(void)
 		prterr("docloseopen: close");
 		report_failure(180);
 	}
+	if (system("echo 3 > /proc/sys/vm/drop_caches")) {
+		prterr("docloseopen: drop_caches");
+		report_failure(213);
+	}
 	fd = open(fname, O_RDWR|o_direct, 0);
 	if (fd < 0) {
 		prterr("docloseopen: open");
-- 
2.23.0

