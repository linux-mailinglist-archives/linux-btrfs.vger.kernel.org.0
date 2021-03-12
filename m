Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78757339841
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhCLU0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbhCLUZ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:57 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED21C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:57 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h13so4900541qvu.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bj3zOBKirXBULd++EZGtXaDPZZNpxfqcEWV8wJZmz1Y=;
        b=VoXRS5X+ZhVfnHtrqhG1zBb/Q+hyItvfXonVN9cNezbHk2WDK+KZBPhuf/9v70smQ4
         evkZl5xqr6WYh+8L9o5PaBMbEqQHuWGIJ9/Gz8+W//VVbcGMdFmky/CQkYYwR1x+s/Ki
         NCrc/wMqlUptAzMQXLgHIGSPTwBrBi+8QsbwMRWQO6Mal2aa8nYb7uC577DXLPc8vvvT
         pzqkxoqi1c9QjtYZ3DoasK79sfEohnNtz2ZYm1wT2XQM8St5cnw8PijxHfKSDmGQ3dRv
         2PD3dR3L6BKLXGFvSwunKCUd1wTNHzCiGDCUuoA8779Cvi/tJohctZE4uNl+aY8NuaJk
         JnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bj3zOBKirXBULd++EZGtXaDPZZNpxfqcEWV8wJZmz1Y=;
        b=elfAqUiPtQGRpxP/9f/VHQPj/Un6ATtb1ebfFqRkQZA8LEPTFrWHHWh56MF0OSmfZ1
         CBh+WuRW5e82IuLsWerxZPKg7Ap1WJQvkRFSxNs6RjpcIPmfIvlDzJxE9KG4wYKD6+EG
         0/qwh4g1MAy+pMi4JKs9a8Ad+pkPwMXiTCgDNr+fH9rf+VhNmsGRbUk20mOeu7YMZeZV
         WyGEDspw6TT/vad3NReeUBK/FQ1UoG366uRh+vcmEP9yr/l6SaGJn5h4YCLe1k47k2t/
         wiQY1lh9A+V44+favYUCAUezYnKfjob08H3NAR45cep4R9AQi2zaf7VYwogS79pJq8s+
         6mBg==
X-Gm-Message-State: AOAM531NyuPoKjX2qFxvOMrVLe1c/jhRkNaBTaaoGp/VpxRpp7yWYyWj
        IAG3uOIvY+h65+woTVrMci4fOFjKEYFtFtEa
X-Google-Smtp-Source: ABdhPJxDx6XcS5Npy+svWtuyYy4L+liZx0Kqii0H5jcswvniGib9+JezElVuXCWS/RIFymIsewK46g==
X-Received: by 2002:a0c:f541:: with SMTP id p1mr24901qvm.14.1615580756306;
        Fri, 12 Mar 2021 12:25:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d70sm5311855qkg.30.2021.03.12.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 13/39] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Fri, 12 Mar 2021 15:25:08 -0500
Message-Id: <3e39257bf659d40433b6d348d621d8612cdad1a6.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index acff6bb49a97..3a3a582063b4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -741,7 +741,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
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

