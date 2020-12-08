Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482592D2F7F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgLHQZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgLHQZp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:45 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F89C06179C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z3so12284334qtw.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RU1H8MQ+4NOfYfTiKPHWw/9l/yKpcFXfnObQ5jomNVc=;
        b=fsY1JJw+3Y0QbN3Bp0UekzCaoulXnQ1bX7pd3FqguTL2hZOD9jFsZ9TUDLPp1zqm8y
         mTtZnHT1l+ZRkB0iv3wNyWQb3zpPETNl1gfJNkMzccNb4/PhJ8LzmP0E0cAJgfHs01Td
         etHeroSLbC1N7b81EQoDuhHNk405G0K0Hw11q2SHq+eI5SoVajNBM4WMYARM7QVIZlH4
         PatgLGnlm1s2HukjGL5imzr2Qwpu9O/EsDpDRodt449fBo5yeRCWgv/QnQtKzIisW2KS
         n8cAPg0flgCcPWOSBCLS6dB/990MvqUdYPuiy2l+wrkLJpsAywRKItLHiB61a7KDtzuQ
         b6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RU1H8MQ+4NOfYfTiKPHWw/9l/yKpcFXfnObQ5jomNVc=;
        b=TiNuvY3LIK49j84fAPyd5FfTRbLfsNaQor6z+fLRx6pPG7bMqanlFywSXGA6TxY7f2
         /dH+BwirAOlhSBe6YoE0LB7Sv8KJS+jhCC8IYj0oF6VEYuMqMQeRXIZtZqy0waJHaywH
         2Wl+9yVaudviCCOgJfuhkMSMnH9SQjSbE8WwF51J/eEM+sqlnXZM2uyw3KY7d6xawPxs
         eB9nkIggswB0EWKoGOhvhGlCqugIiE+J/HF/5891Mw8sG7WvzSOXBMEXGS1ks+UOD+in
         ST/e/hns6HSOgCT8QFSPR4u61cqKcKHGyNcb+Nt97uuJzt0gG+snypyqi7fj8fFljJXj
         nVIg==
X-Gm-Message-State: AOAM530s1GC1YzHh9R5DcafX3aQeG4BqJHTNw5aRCjljmMSgUuujAzBJ
        IMg/F5GdeIN5UJOb09uC6KCYLPKNOzHUpZM4
X-Google-Smtp-Source: ABdhPJxz4lf6CaXy1EgcJ4dpMJOWSDXyBq6vmPdYZxBNmMgWBIjdZVVQ4zQKQoGt2n4s452QDmLCIg==
X-Received: by 2002:ac8:6651:: with SMTP id j17mr31110744qtp.176.1607444693224;
        Tue, 08 Dec 2020 08:24:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 70sm4013173qkk.10.2020.12.08.08.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 23/52] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Tue,  8 Dec 2020 11:23:30 -0500
Message-Id: <90766a86c5e5ac96c9494d2f3e8a149fd4719dc4.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5cc368fede19..df9b9c1a8831 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -734,7 +734,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2

