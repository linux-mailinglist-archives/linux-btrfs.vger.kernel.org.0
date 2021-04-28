Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE74136DE85
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242654AbhD1RlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbhD1Rjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC1CC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d19so28694446qkk.12
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KHZQTqAt9jx85lePUXDJmc1Z5J9qpV+hyISF/8Horhk=;
        b=aYOA6TibqdW0nkvgcwYmFF0NTzoB1l7cgaRFx+5/12FejpMOq9+FqmBcwSW1mD/yV8
         GTf3/nkAakdtdhU9A7qfOHe781qtzyBxsJ7xJ3Ek9uDXUmfSnhUZeik+naE8EPfaSXHg
         Qn1O8b1nl7/RBOIJW4hZmMP/WzZlLMClSSMPuxcJOXm2vWO74Ptj2iurHpEKqV0rGixj
         vS57gXRIg+9Q14fPaUnp0ktwRuroGGJskb4wc7UPVemVtFBNVGxQvbYgVgV+Zp+TcfL1
         2gMPox/dmMnji8NJ0vYGSw1hq8nt4hTdIxJngEMBo61VYJYFG0QT7aX4p+EhgxB8UeT2
         iNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHZQTqAt9jx85lePUXDJmc1Z5J9qpV+hyISF/8Horhk=;
        b=EeS3mwomacBLqzEbk1eTz0PhbajlfPrNnMG4raRiAicFv1VuaKwriZHB27Ocw+Dkt1
         xoUycaD5Jaga651JB5wIKn7U6BH1KG6cQF6IcUyMO05bGD+M61jweTrz1ZSHPQQGh6wN
         fos0bfPFfwia2wgFef66yAF3TRtgEZhob/dR5dZYtpjx13DdR8K0dEw97V+sc+Rpb41/
         6UJ+NGS4aUgKpgXSJnPd8BjcIh/aFEp4VAJIBLu8jrwD6lDS2XluibaLgojfuAYpANDK
         zIp5k+7P4F77gpzOhB7I4Vopr7JEOmyO3g/SLj3EHxgulYl73I1NUxEj1qDSeBayQBsL
         Q6vA==
X-Gm-Message-State: AOAM532nLTCepiIBmkZ+Svzyn4M1rJAkgWDrDoxQ2BYBjEcgUVHQsm8r
        nKnUwF81klNSZD0TgT69m7HuDnhFTGtSnQ==
X-Google-Smtp-Source: ABdhPJxHKNzCKmy6pF6isltWCUYcO5gcxIniNeWfx/Uc5G4fDXXCxcbkiwFfn3w82RODg08fOHTifA==
X-Received: by 2002:a37:b702:: with SMTP id h2mr2972326qkf.88.1619631535435;
        Wed, 28 Apr 2021 10:38:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q10sm304953qke.55.2021.04.28.10.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: use the global rsv size in the preemptive thresh calculation
Date:   Wed, 28 Apr 2021 13:38:45 -0400
Message-Id: <31114026fc63ffebcdc43197fded45da7731ef03.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We calculate the amount of "free" space available for normal
reservations by taking the total space and subtracting out the hard used
space, which is readonly, used, and reserved space.  However we weren't
taking into account the global block rsv, which is essentially hard used
space.  Handle this by subtracting it from the available free space, so
that our threshold more closely mirrors reality.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e341f995a7dd..b0dd9b57d352 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -840,8 +840,10 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 
 	thresh = calc_available_free_space(fs_info, space_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
-	thresh += (space_info->total_bytes - space_info->bytes_used -
-		   space_info->bytes_reserved - space_info->bytes_readonly);
+	used = space_info->bytes_used + space_info->bytes_reserved +
+		space_info->bytes_readonly + global_rsv_size;
+	if (used < space_info->total_bytes)
+		thresh += space_info->total_bytes - used;
 	thresh >>= space_info->clamp;
 
 	used = space_info->bytes_pinned;
-- 
2.26.3

