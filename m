Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5E2D2F7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgLHQZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbgLHQZb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:31 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E16C0617A6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:12 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z188so16421921qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJCA1WFu34YlfNRq8jOTmY3WvoNsmIlp/39i55U+He4=;
        b=dST9IEESIEc0UI0UcbwlbIFykKlMlbnyVnEXtSq97swEjyoSPxqQltk4q6+Cr6DWu9
         CFdcOhPYf+7zw0Sa24PlJQ+n8B2ecufMeC95mBlNNVDa43wHYMBGNbIVuhI8ojTDzXzr
         hJ+nDmSOvPaQguejKFtFb4QS8UepEzN085VRTJH2lPpriSkAcdUFNHv9tYvQlR93TCVk
         flgLY1+o+EMoemTZlMCn0DpLKixHeQ8yAxJ3BOUnYvoKZgfmcQIzXLeRgKliWm67hsNz
         0ns4ypJfKJ0Zp6Do8gmHByks46WeU8jq78vxbh1AvwdZlAdKX0oIbZwYEy71qp+LQbsq
         ykNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJCA1WFu34YlfNRq8jOTmY3WvoNsmIlp/39i55U+He4=;
        b=ePa2Qv+EdEuLeDQKS5CpR4FcxvJaRGcTszb0K442BlDk//ux7eFu1Sc3BoGIsF3EFl
         +f9W8VowBeXxpE9TjIJdFj1DkkWhV9d7Ni1GecM6AMCIS1WBqkNnpRnkspP8lTD60YFK
         yEyJDwotCx2NvXLOkdIvmBg2vQTk5expqcCcVY3zpUwE+go96U7dBWlwRWO/EQAQJpuy
         cuDthVU2APpwRmEjIDPTezodgGv1GtY6afOExX7YofgKfLh5kaHCe1Be43lT+AjykJuA
         LChhUGWcYStBFWyc6mevZvyKjfuvyyBZROhaWMSHPBcp4llOnRcNalRHDMFcUCeb1uyM
         NmsQ==
X-Gm-Message-State: AOAM530G3/FfySknykb6/7KiHWQz4WXQaL/oFQK0GX3TwfPA2y0060Ma
        HSusLMZS2lQOpbzHiVl+VpV3taMRPHKQpLL/
X-Google-Smtp-Source: ABdhPJxpSW6Tng9OpztK+BxRWhKe7lZGj0OLNjRnlvUzVwFlsI/dKGC2wp7b1ip1CMTSry2ild8Rbg==
X-Received: by 2002:a37:498b:: with SMTP id w133mr23157812qka.383.1607444651796;
        Tue, 08 Dec 2020 08:24:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y9sm995825qtm.96.2020.12.08.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 05/52] btrfs: noinline btrfs_should_cancel_balance
Date:   Tue,  8 Dec 2020 11:23:12 -0500
Message-Id: <d32992602a82698709bc24a75218e60602a8c10f.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index 2b30e39e922a..ce935139d87b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2617,7 +2617,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
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

