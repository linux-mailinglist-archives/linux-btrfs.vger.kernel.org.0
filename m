Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203B0109473
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfKYTre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:34 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39883 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfKYTrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:33 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so6272345qvq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bWkEItJsrciCUsqYOdkuyqGCVe7sz9XQCB/6ACz1IpE=;
        b=PEJiShX9CiHL8LcMjKdX8ICWwBV5K3UqumL22B4FibO04/DBbFi+IJGLGaLuWyeATv
         P6ftZYR5JUkDP6BQtqg2WRrq2T3Xoe7jliNsHD859/ZCXh2cGVi6dsMHlxSUXVg+FscO
         lBd/og4Mcs5NV3xGNPNDp9FZjD035TfPEm1Egxzl4nREpvZPrzq4vTPH1O61CJ05dhnC
         bEJFlnF2Pr3FLqOZ8xyM4isaDxGWk7nFkKUXo49QfV405dlO2UOYmIddn68Cgpjtq9RU
         g2n/VHo6a6weQdwlEPz47KpSNl8YReGJSI3RTfAXQmAuMk18/+Y6Z0ZGYokc06DvBoL4
         NYog==
X-Gm-Message-State: APjAAAWzvZPCahLQLJQpKwrvONCRDW/q2MelnyxIXtuVbkKMvFRcW1ej
        pQZqTqm5ihmxnQ20MyVhyiA=
X-Google-Smtp-Source: APXvYqw7Lygdp+cR3wdX1ku3Yjk85gBii3Ov/hPddgXuVUty47Z/ntOod3Pb5Xajht5cGcCP2edn+A==
X-Received: by 2002:ad4:4391:: with SMTP id s17mr14806489qvr.232.1574711251669;
        Mon, 25 Nov 2019 11:47:31 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:31 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 22/22] btrfs: make smaller extents more likely to go into bitmaps
Date:   Mon, 25 Nov 2019 14:47:02 -0500
Message-Id: <048ac58fcc4d6147a0025b4a6021f773d736adb5.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's less than ideal for small extents to eat into our extent budget, so
force extents <= 32KB into the bitmaps save for the first handful.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 15667095c50d..9167be1e27bf 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2108,8 +2108,8 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		 * of cache left then go ahead an dadd them, no sense in adding
 		 * the overhead of a bitmap if we don't have to.
 		 */
-		if (info->bytes <= fs_info->sectorsize * 4) {
-			if (ctl->free_extents * 2 <= ctl->extents_thresh)
+		if (info->bytes <= fs_info->sectorsize * 8) {
+			if (ctl->free_extents * 3 <= ctl->extents_thresh)
 				return false;
 		} else {
 			return false;
-- 
2.17.1

