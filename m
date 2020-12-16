Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D92DC3E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLPQT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLPQTg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:19:36 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41E2C0617B0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:55 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z9so17582620qtn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/epMTmpdkMCpCQj/9Hb7LTUOkFfN6P7ezJatSHYMpU=;
        b=s7RSMU2UgIKhqNEdWLnxdWkcn5Gs6YEYJrrNqcbkQZyO13hixyfVzAO3lNxQxYP7i6
         Ixsi/N12Nx1Xp8q+/gRYMsVBHjsa8q2Opa2aWKRfVoFwzWRat1GK5T9EUALW8whLNTzl
         lTAtVQWgO2T2jR3jJ+ZRAztogTYUbCRhmUvLFpvUJfV+yVop64vpxbwUTWru2xJ+r+lo
         6rQDM3UbqytbLUPNAKG5NWx2fp8nchP4zy3edIEQ8x9OYrygirfEfJAmfSp6tUru5QdA
         knCfctOBnRTTVJWkJXTS6SrpbtKHGtZzFkVmszerLiTe43Y/DNHtz6pWWXBv/N5lYoBo
         eBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/epMTmpdkMCpCQj/9Hb7LTUOkFfN6P7ezJatSHYMpU=;
        b=h3njgx9tVpZpXHcXABmgTbd2ELm3Y6InRGza65vQLLYogEHI7OVqRayu5EtrjWR1UR
         NeGJcLThs7ddPrs9f8DSsdfJi5OCP6g/xDJJZjzJHw5k49RHTPWGaHyJhHVtyBfoH5W1
         eV0YcPbtT5e2Kwdo0Vu5u91WAklalsxDj95Ck0SPev1qK1CsvyrSjEqvoHpJOvG0Fxx7
         xomGAcUwTtTMWEILy3VVn/rjox3me6uJY1kEU/InusKuqfqGx3FhH7DRm3y15bseAOoe
         /4RIEIFrRI01D/SqJvcgfbJnfsJJ+3LAe4ZD2nvkLSzichM6KPH5M78Yl9pF61gwOZNk
         9AHA==
X-Gm-Message-State: AOAM530LuvmsnlSzSxRY1hDJlUmVW1u9QDJxuTdYqZ7e4K8XhNYGy+ut
        9ya7j/bEmcvWOm8J4XP3RQMz/5ftOZv6+m1I
X-Google-Smtp-Source: ABdhPJzbrChKcw/0f8GPnnqMPT3dA6T864WJT9IIzPMc74NH+zGbsRuRCV48nNjyJbrNwp9W5t4gNg==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr43683912qtp.296.1608135534740;
        Wed, 16 Dec 2020 08:18:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p75sm1394324qka.72.2020.12.16.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:18:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/5] btrfs: noinline btrfs_should_cancel_balance
Date:   Wed, 16 Dec 2020 11:18:45 -0500
Message-Id: <1533925fbaa996ed35ceab4a515476e1f503b625.1608135381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135381.git.josef@toxicpanda.com>
References: <cover.1608135381.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was attempting to reproduce a problem that Zygo hit, but my error
injection wasn't firing for a few of the common calls to
btrfs_should_cancel_balance.  This is because the compiler decided to
inline it at these spots.  Keep this from happening by explicitly
noinline'ing the function so that error injection will always work.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..f9500262106e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2615,7 +2615,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 /*
  * Allow error injection to test balance cancellation
  */
-int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
+noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
 {
 	return atomic_read(&fs_info->balance_cancel_req) ||
 		fatal_signal_pending(current);
-- 
2.26.2

