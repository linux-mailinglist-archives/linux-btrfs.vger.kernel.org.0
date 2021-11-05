Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2E14469FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhKEUsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhKEUsp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31EC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bj27so8225450qkb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f0HqbDC5KkXztO3gbBUEK9ah3Vq667HdnflXe5N1lqA=;
        b=O+xsYroj7UdGg87xsSoz1ySaNFrnyc6oFu9yIUhqTUpz4ob3SE53H8q4qXoBt/lvW5
         bGy/9LdXlhIdcpdyFAnrw58g43wRO7SAJ8c3qPHIW9ZGnKA5IVQ5ZxhSIVVGFNZGXujs
         FX26BlUJJUEGO3xZskEA9IuoUvV8AOP5rge/Eamiso8lSeMy+OXEtFHGqKrv6r++TdUT
         nH8BWukjNUmMsFs/1CdpFd0FMIxp1zlvNIHpaMYcBYtXargsnXdouM20Z9xSRBzGeI43
         LCtN3h3pK+Dn66OXmVt1vftMU4F24gxkae+RQEl25i5AQvgK804F56NOy0xioLDmeDyb
         UGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0HqbDC5KkXztO3gbBUEK9ah3Vq667HdnflXe5N1lqA=;
        b=Qz+EYkdHAsmojqpxbEZ3gN0GonYbQiQ2/hETXvrkOlyvkFxBMevGlf3dNba4OFL7hS
         SRdme4gq4k5j55OHloTWds0wfx2lvE0dqOKtiS0Dkit5NSSEGUKQMm6w1tYgXoaoYDfv
         K7gHfhazQcE8Zv1BvxVJ6/Wx3CiLAu88cVwLYeQ/eXcafEY6uSSLTVHdFWl/jYvAVtcG
         Tu8znX7FvWpW64ieRnsRTxvCCpFPO40Yik+NQeTe/MAF6/sRIXfmj/PWcQgeTQLh8SIf
         jMUTHVYvgKAcx7Wk42NOPB1BIUzFtjfF8AylDiNiifTZJZ40lreG9jD2HoWeM/C7I7mX
         QL2g==
X-Gm-Message-State: AOAM531OSN2HrslZ0vDIpy2oVrftt42ipcHjAZCBSvdCrOqhx/ICrDDU
        SSGW8QumDIXC9ucgRvws7ngJkbdxR9bZ9g==
X-Google-Smtp-Source: ABdhPJz5ZntxW5HVz4/+M/ZV2mWBm1Tw0zEK6CzdSBvcz729s4HZ4qmn1Jli1OlbyS7G8IGOvFTcFQ==
X-Received: by 2002:a05:620a:280a:: with SMTP id f10mr48915060qkp.118.1636145164397;
        Fri, 05 Nov 2021 13:46:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bq30sm6230673qkb.6.2021.11.05.13.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/25] btrfs: remove BUG_ON() in find_parent_nodes()
Date:   Fri,  5 Nov 2021 16:45:34 -0400
Message-Id: <be1a91360aa5e5eaae56cb09a90333f7da07b3a6.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We search for an extent entry with .offset = -1, which shouldn't be a
thing, but corruption happens.  Add an ASSERT() for the developers,
return -EUCLEAN for mortals.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 12276ff08dd4..7d942f5d6443 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1210,7 +1210,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret == 0);
+	if (ret == 0) {
+		/* This shouldn't happen, indicates a bug or fs corruption. */
+		ASSERT(ret != 0);
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 	if (trans && likely(trans->type != __TRANS_DUMMY) &&
 	    time_seq != BTRFS_SEQ_LAST) {
-- 
2.26.3

