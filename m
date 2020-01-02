Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43012EB58
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgABV1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:27:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41875 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgABV1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:27:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so32369879qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xyz6+GMhRCzeJCqoQJA7vjXCjroTr2fE+vSm9V53CEE=;
        b=NmNwFCjl+J8h54y3TGY74p8XNPgaUTwX8K/cEn2+alE7hghQnWe58UevshAfD3XvJg
         Wa1ZlIrG2+dqYVt/AyK42Fktc4wjIXTj2tijrGBaGCYMOK/GtS8MlSqzP3qgNzzRINZG
         PMnkZzRLDxbKssg4aJuFYezZfgvBA4ljgYID+ftUb+s6kmrS/EQFn+aHlxbKFIqJYyoD
         y7YEQQjOrcU+1/885xOJafh/Ct2cIzbbRXpiQRRp0NeByKsCwZxUB3D2PvKjg7hz6gs/
         34KhnE5IKgdaArFNTtu3VEt7FQvz/GzY7WRjnhlk/FqIMY0qa87T9j1Xi9Fxhepc8sCc
         Bgkw==
X-Gm-Message-State: APjAAAUiH8oYxow56OlTo0yDAZpd3lxtxLyO5WOH+agK+II6rYxsBYw7
        v1OyB9s26cedxO7aB9wUDqI=
X-Google-Smtp-Source: APXvYqwMW0L8wmy9U0B+dHW9TU6bS8RSZZ4mvR2KB0f0NaMZL4VdM5oJfLLhkR+IcguuyZCjk0Hesw==
X-Received: by 2002:ae9:d887:: with SMTP id u129mr63161411qkf.357.1578000424444;
        Thu, 02 Jan 2020 13:27:04 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:27:03 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/12] btrfs: add correction to handle -1 edge case in async discard
Date:   Thu,  2 Jan 2020 16:26:46 -0500
Message-Id: <f00ffdb40462c1dd9b611ee06cf19b2d495e398b.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From Dave's testing, it's possible to drive a file system to have -1
discardable_extents and a corresponding negative discardable_bytes. As
btrfs_discard_calc_delay() is the only user of discardable_extents, we
can correct here for any negative discardable_extents/discardable_bytes.

Reported-by: David Sterba <dsterba@suse.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/discard.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index d5a89e3755ed..d2c7851e31de 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -518,14 +518,32 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 {
 	s32 discardable_extents =
 		atomic_read(&discard_ctl->discardable_extents);
+	s64 discardable_bytes = atomic64_read(&discard_ctl->discardable_bytes);
 	unsigned iops_limit;
 	unsigned long delay, lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
 
-	if (!discardable_extents)
-		return;
-
 	spin_lock(&discard_ctl->lock);
 
+	/*
+	 * The following is to fix a potential -1 discrepenancy that I'm not
+	 * sure how to reproduce.  But given that this is the only place that
+	 * utilizes these numbers and this is only called by from
+	 * btrfs_finish_extent_commit() which is synchronized, we can correct
+	 * here.
+	 */
+	if (discardable_extents < 0)
+		atomic_add(-discardable_extents,
+			   &discard_ctl->discardable_extents);
+
+	if (discardable_bytes < 0)
+		atomic64_add(-discardable_bytes,
+			     &discard_ctl->discardable_bytes);
+
+	if (discardable_extents <= 0) {
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
+
 	iops_limit = READ_ONCE(discard_ctl->iops_limit);
 	if (iops_limit)
 		lower_limit = max_t(unsigned long, lower_limit,
-- 
2.17.1

