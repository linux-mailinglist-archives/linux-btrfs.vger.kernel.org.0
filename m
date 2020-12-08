Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A58B2D2F83
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgLHQZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgLHQZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:49 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC4C0619D9
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:10 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b144so16362702qkc.13
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFR7IwzsHyxbv/o7Xs8uDIZ/0NitB4dQ6UU0EzUVYVc=;
        b=MCoTk0lUO5a5aUO/uD+6QKg1OSTs5CFamVrUx2/I/wEEq3hGMkV/OEhf1c9tDFRfTV
         M1ngKSmuOqHFt5VBpYMJzuNwuoU1SiY+eVvblHiEAbkLM5bOToWFAmCG6iBosF+qyeMM
         wRMaDiNcgqt7EA6CZVOpzxfiMJffHmLOVIcvcDnpRRjzRwUBsZ5DsTK6ImnnO8/cZiUp
         9aLSqP3BhsNGzvw95zJEOnHgAxe3RImS1tgQzlKPrjMx0sE/kF3KmBzkF/18cM+g7XKr
         eb109gBBs2/uPXQGj9F8xuaz7FfPs98JVa2Fb3oGU1QZQa03LfPgyMngPpO/jRJ/xxgK
         A5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFR7IwzsHyxbv/o7Xs8uDIZ/0NitB4dQ6UU0EzUVYVc=;
        b=Qzk/L+hOEPcgMlPiGmQR5YpHLE6Sr1KkPr+OdobEsPUiTHEpcJ5hNXkj7Y28UnZIea
         xTLTOKnpm+MfsfFglD/tZmav4RVsBqB1eWAj3jZELTrFHftKIbzUmDvxMui5x2EeGKgp
         roM2j5H15KbCsDGKbYGJdyCfI4UKB0ABVFOMsgk/mFJ7sshJK4gBRlZJFumjZuolytNL
         F7v024eTPM4JMm71t/ToPW8KlOKW05CuNVQvI3b8xGokPT3f8bg6YBLFcQmUWIN1SGhO
         fAOMx/usgnKiFCBn/uGC4asnvJ3w+N0gbtfKo/wZPRFmEylkLLjfl1EEDxwNi/SViT4g
         i4AQ==
X-Gm-Message-State: AOAM530L7S7Is146Qfz7LJuZCrSaMji66EMjNAAvQv+20Au5IksOhNTI
        h+0WzWVb3JeURrsxHz530UxNW/nOQw+j2Rot
X-Google-Smtp-Source: ABdhPJwBSGaczYBYvRDUJITFNi+ARBp3CdpbyngPp7JoqqQ65OOpI6xT8s/w6o7vekhzfu5EKea66w==
X-Received: by 2002:a37:4c05:: with SMTP id z5mr31654108qka.245.1607444709788;
        Tue, 08 Dec 2020 08:25:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h24sm13938504qkj.85.2020.12.08.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 31/52] btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
Date:   Tue,  8 Dec 2020 11:23:38 -0500
Message-Id: <dbe2c5c34223e1cfa9fb8b538930b893cba6d825.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 375aa2bed36d..dd60590685c0 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1343,7 +1343,9 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
-			btrfs_update_reloc_root(trans, root);
+			err = btrfs_update_reloc_root(trans, root);
+			if (err)
+				return err;
 
 			/* see comments in should_cow_block() */
 			clear_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-- 
2.26.2

