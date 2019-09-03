Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C94A5FA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfICDa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 23:30:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43613 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfICDaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Sep 2019 23:30:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id d15so380860pfo.10;
        Mon, 02 Sep 2019 20:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=qLqPgNPPOtAuqly/y/WrIiw3//xdfCK2UaIc05HwaDc=;
        b=i9zMLnEndimQEPM23G3jZaulRBWHxJMHfHVyLq3l+6EK7LTME1+lgichvWRKS4c+Bx
         XisUTod0mLsoEzFl5kHiXekdasvsKpWIeEyLaXCnO4HLWITBfavtVB8A/BeHqGgjlL0z
         Fl2y0TAlmtIFP0GuMm60GwcepRgOzVr4qwUZOT6+NVw8evZmP93AlCxNmc34P3aRQd+g
         mv2v4rF7iz+mFe57PygbK7olDzYGBz4aPKWPnYIlsazIh02bmSQZQbu6hYR+Bbli/AH/
         s9nijMNOSvZPmA+Cc69q9JQMfdlg2qKEndhgLu85FuuuGkUbKUD54ATMw9/MCCuap7ev
         JSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=qLqPgNPPOtAuqly/y/WrIiw3//xdfCK2UaIc05HwaDc=;
        b=ndDkP2sd2Bt29gXqmMzfpaTCbveNdEu+X1rEtNcYdwGLNiHN1gLjV+rFQg3cLoJ2up
         MkSDIL0sf6wmt102TQZIrjoAnE8QHQr+jyWMPD9VVBs74I2BlowlKoABYR5UjgaoSWg/
         AvKah82CtD1SBq1Acp9DMO3ukXIJbw8T5ZRvjBCqXal1DncwpRpvAa46UXXEvblLKpgh
         pYpe7r1sd7DZfuHEZGbAidQfDOYlhR1H769QEHPieKS5MNAaBF1fy2Xee4vjDdjIQaRl
         8TorpPWRsE7Xq/bD4KPOq/NcRMICeosuvRCaWFuqfD/6xJH+i8/aAJoDjHIKFftldF4P
         LRuQ==
X-Gm-Message-State: APjAAAUoWqidT9zrYeP2wG/0CsYVDyQTCuJVFQJqf7FXl0fj+146J1Io
        YWpF8S3AGXkBDcvyO1yGH9Y=
X-Google-Smtp-Source: APXvYqxsLgSdmhCiUYEXvMIOSWHbXYJGJ1fy+gfGMw3fPBeAYf2G2r9dHLJ2wFbBeajOcDDx7/Bb2g==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr27826429pgc.303.1567481424024;
        Mon, 02 Sep 2019 20:30:24 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id l123sm21092519pfl.9.2019.09.02.20.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 20:30:23 -0700 (PDT)
Date:   Tue, 3 Sep 2019 12:30:19 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com
Subject: [PATCH] btrfs: fix Wmaybe-uninitialized warning
Message-ID: <20190903033019.GA149622@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

gcc throws warning message as below:

‘clone_src_i_size’ may be used uninitialized in this function
[-Wmaybe-uninitialized]
 #define IS_ALIGNED(x, a)  (((x) & ((typeof(x))(a) - 1)) == 0)
                       ^
fs/btrfs/send.c:5088:6: note: ‘clone_src_i_size’ was declared here
 u64 clone_src_i_size;
   ^
The clone_src_i_size is only used as call-by-reference
in a call to get_inode_info().

Silence the warning by initializing clone_src_i_size to 0.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f856d6c..197536b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5085,7 +5085,7 @@ static int clone_range(struct send_ctx *sctx,
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	int ret;
-	u64 clone_src_i_size;
+	u64 clone_src_i_size = 0;
 
 	/*
 	 * Prevent cloning from a zero offset with a length matching the sector
-- 
2.6.2

