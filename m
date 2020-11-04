Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A82A60E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgKDJtL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 04:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDJtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 04:49:09 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F0C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 01:49:09 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p22so1719985wmg.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dpDzE2UyGfIguEs3GGU0K39vcuPe/uRjpnfE0e+NLNE=;
        b=hWzZtVHtC2R+1k6U/MDX70yiuF/g8wZO3wMwJswgV9io0RImWBMKVw2gDzlDXd7M9s
         Zu6afGQCJeOOjLTPCKUxBY2LQej6B1wNDZrMWlJIHf/W3KKMFFRth6+1/1WIZrfNbF2J
         m8H6BauKQ+TpvHOVXSemePAXyQRiLhJywqAAMuA05zAQq3FQkBEGSqmr+VrjN4S0YDY/
         jQqUVFm90ByWWTfvgNOykDErEwm9iMCC0xl7zVitK8znCkNB5fACsSc1n4fBo4SuJWTZ
         inmGkFDWJenvdVbMy55t1b/Z5EIMUgGJlEuCj+lcNEq46PTBH6SdhM4cFU+YhTA7/O+R
         LgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dpDzE2UyGfIguEs3GGU0K39vcuPe/uRjpnfE0e+NLNE=;
        b=QUfueNmnEnxY5whq3LIjWFzjCSbjBXPoptJCu7o0Uoc8QOwHXDnhS8IHXnEFmZ1l2x
         booEHPm/cldP5oxzbKQTkUzUEWaRqlm2bto8MmBs1vKdUDEYDDpZcqOOYifQm0cPdhyx
         GfR/Ges8LF2i9hMKJ8nsYTIQl6tvXp3znC83uTNLkVZDY2SIevQB465UtPBWIOt9tkNm
         vo/uw9Y9eiaMdr6clLUJuILON5HwzHHtuMHT7YEc2MtkmUG+VM88hKmZXfE+tTFzFwtg
         /JpbXhq5O13DimWceBZ7pZwV8GBViHIbGj8+gevFFPUx+/dQHd+0tFO0gB91bx8R93cS
         a0Eg==
X-Gm-Message-State: AOAM533KZLSp4QIFuMMx20B9T2BFZb6b4aH+YkXm1fMb1mqeiifmVqgb
        6oKlkxMiYenpfQGKNo8Ulr9ym5G1DwUWPw==
X-Google-Smtp-Source: ABdhPJz9rI25H1azGMRvCsacin2WjRIAZ8zdxa2SWXRPBUf7BhOPEmetJElJEl+07kH50HlL+2wM8w==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr3631150wmd.48.1604483347872;
        Wed, 04 Nov 2020 01:49:07 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-228.range109-152.btcentralplus.com. [109.152.100.228])
        by smtp.gmail.com with ESMTPSA id 3sm1478081wmd.19.2020.11.04.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:49:07 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
Date:   Wed,  4 Nov 2020 09:45:51 +0000
Message-Id: <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1604444952.git.asml.silence@gmail.com>
References: <cover.1604444952.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of using iops_limit only for cutting off extremes, calculate the
discard delay directly from it, so it closely follows iops_limit and
doesn't under-discarding even though quotas are not saturated.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/btrfs/discard.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 741c7e19c32f..76796a90e88d 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -519,7 +519,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	s64 discardable_bytes;
 	u32 iops_limit;
 	unsigned long delay;
-	unsigned long lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
 
 	discardable_extents = atomic_read(&discard_ctl->discardable_extents);
 	if (!discardable_extents)
@@ -550,11 +549,12 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 
 	iops_limit = READ_ONCE(discard_ctl->iops_limit);
 	if (iops_limit)
-		lower_limit = max_t(unsigned long, lower_limit,
-				    MSEC_PER_SEC / iops_limit);
+		delay = MSEC_PER_SEC / iops_limit;
+	else
+		delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
 
-	delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
-	delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
+	delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
+		      BTRFS_DISCARD_MAX_DELAY_MSEC);
 	discard_ctl->delay = msecs_to_jiffies(delay);
 
 	spin_unlock(&discard_ctl->lock);
-- 
2.24.0

