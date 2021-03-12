Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FC33984C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhCLU0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhCLU0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:10 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803EBC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:10 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id n79so25708170qke.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fMSXLqXt5M2Fuy9Ykuox+cLE2nnWXMCStFHkmXXP6aE=;
        b=CTHYOiyH7tJXNAVJMzlJxAOgpI/atRtU8/ugcLRLD06sE0TZBilHLdu8+tlT5pGCYy
         +EMnQeLGIR9ahLl5tGgR04J02LgbvxfqUgvI7CQ0QSRixA2Zq+2XXHr+NDjTR2LebeWb
         CWL6ATtydEP+WlwBHG1Cvw7HZEjz8smFjbcXZT3HgsTetOitwaC1q3WzRnVH4caoHZKR
         Cq1vrynH13uVmsrf9JQcM5HUdVxvU+ynzDmmNR0q2qah19efSTdRC5k87kb3k9QtMR+N
         QATnF66VC4v66OdHA63h4ONu/BRENB3AupkzCdz6fmdknMSx5I0iAGtL1HsQypjGS73q
         D5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fMSXLqXt5M2Fuy9Ykuox+cLE2nnWXMCStFHkmXXP6aE=;
        b=gKsrjP8GavVNMMMTNk7SvRCCYfjWX9Y2U6jH0SrYCDXAh+3oRji0dIBZggguqzXNzI
         zoQJYnK8Bq4Oyi9rYALwYZsR/jybrGJPzSycPjWct7Cpn+LE/cq0qINs+YTdHJPpLMsH
         VnAOJC8bBYWn/0SbXhFaNjl0JtvG7c3FSASDWTLIeVe3bNLSjHlxIME+ljoQAldp/MDL
         HpYpuMw/z1YlhxZJIRoGVOItkkAIL4OnD9d+OY3pq4fs59xp0Yk0+tLOQbr+r2ZuoMJq
         h5An5wxX7Lxx0qyGoDxUs/zzgRl9D5ovR9BQjr3FYIk5T/2F2QoWmbt39nMmWX/TSG42
         d5uA==
X-Gm-Message-State: AOAM530+/kHNVbm3PMEV7LfxVvh+G3TohEooslGfPXaLq/dza1bUT+Jq
        hm08GlYaW7HceIEuuHFNmZDcrzONXUyM6GSn
X-Google-Smtp-Source: ABdhPJxiDLYI/X1G82Yy5O1H7965RI5b2KqfeAk38c/HYeRBBQAwYhymHsHk8s5vcC8bKEBkW4s7aw==
X-Received: by 2002:a05:620a:2a02:: with SMTP id o2mr14373369qkp.492.1615580769365;
        Fri, 12 Mar 2021 12:26:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k24sm4727403qtu.35.2021.03.12.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 21/39] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Fri, 12 Mar 2021 15:25:16 -0500
Message-Id: <12d91efec7891c92dce4d8fdebe98327968811a4.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in commit_fs_roots.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c24ffbf0fb74..9dbbc354e5ad 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1353,7 +1353,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			ret2 = btrfs_update_reloc_root(trans, root);
+			if (ret2)
+				return ret2;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-- 
2.26.2

