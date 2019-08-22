Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE399FB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbfHVTTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:19:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39470 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:19:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id 125so6158154qkl.6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJex6zvA+bgVAiBQ5FAdnkxekTPugn+ezm0BsuIlrbA=;
        b=1rLLcqNdC0Zr2nT9fl0DcUYui0Hpe4Erp733dmR/wEuAyT6ynNpUryyPlLErsJ5+ZG
         GkzP/pYWthbPThFC8MMFOSoYjjIcnyQ2zJUdznVGlTBRxjbw4fLaJM0QIzDuVR9OtsSy
         6Bmg3jNxz2X0KW4nOKSZuBIK45hbGiyuDNrDN6FmVEKHAxAujhqYf4OTArmy+nxT1doG
         aIjHl8J9u57dbwzPaVpYuYZEd8C0F6x3Grym01oR2BhIvB4eYdf+wRXd4nj3N7U8hNQC
         4+Cc1LGIpfIlVKwqtrJujxqBheN0qaJawL99+/2ugDnl2Ym+r+bsKP4zDboTl3VKAs8S
         e74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJex6zvA+bgVAiBQ5FAdnkxekTPugn+ezm0BsuIlrbA=;
        b=awtmU1QH8T24ta7p+zKAJI1x9FiRHDb+X5AFVb69SsRJXEJnC1PHTnv1KJZCWMObal
         2+pQ7sBrH1hfuEKja+1InzPwWyqmYQ7dhNsl4KSu1iPkeTZdBeRVRw7ke0ujbTgBXx/l
         +3Jcpqfp4jjk+XChD7JGYW9O8l3PObL4gXAdX6Ni80WeSl8ZG3g2vISmLCy6SGyYrBvn
         yhHWi8kGLJDRgHIyXf9yURt1lmseF2+96WcsFl5hwQrZxX2JrHuCl1vd5V8Fa8wkdS1f
         8GgZBA2n4gotQvZdsUSMdXX3oBTBpYdUzVTkIjUQqvCszUK9v1y6mMO8bSSpBSmmJFf6
         AMMw==
X-Gm-Message-State: APjAAAWj0snO8hbEqWvuqiA7U+4FGb3oqkE05KDLcZJRdWz0L6Jf574g
        UOV1n7XHE+xSLLKlOru0rMZUKg==
X-Google-Smtp-Source: APXvYqx56KrV7JR9tYMuTYJPfigLj3K+9mFovkcy4TLuMl5l5UvQmJWDO0sRx/5WyUtot39VDVJ2wg==
X-Received: by 2002:a37:8844:: with SMTP id k65mr545773qkd.77.1566501551676;
        Thu, 22 Aug 2019 12:19:11 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b13sm232557qtk.55.2019.08.22.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:19:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/5] btrfs: use btrfs_try_granting_tickets in update_global_rsv
Date:   Thu, 22 Aug 2019 15:19:02 -0400
Message-Id: <20190822191904.13939-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191904.13939-1-josef@toxicpanda.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have some annoying xfstests tests that will create a very small fs,
fill it up, delete it, and repeat to make sure everything works right.
This trips btrfs up sometimes because we may commit a transaction to
free space, but most of the free metadata space was being reserved by
the global reserve.  So we commit and update the global reserve, but the
space is simply added to bytes_may_use directly, instead of trying to
add it to existing tickets.  This results in ENOSPC when we really did
have space.  Fix this by calling btrfs_try_granting_tickets once we add
back our excess space to wake any pending tickets.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-rsv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 67071bb8e433..a292866221b0 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -305,6 +305,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
 						      -num_bytes);
 		block_rsv->reserved = block_rsv->size;
+		btrfs_try_granting_tickets(fs_info, sinfo);
 	}
 
 	if (block_rsv->reserved == block_rsv->size)
-- 
2.21.0

