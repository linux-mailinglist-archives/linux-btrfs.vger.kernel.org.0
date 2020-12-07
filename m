Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9D2D12BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgLGN7O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGN7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:14 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4AC061A4F
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:57:58 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h19so7129188qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJCA1WFu34YlfNRq8jOTmY3WvoNsmIlp/39i55U+He4=;
        b=yuQEdqVq2L5wrmbrmfpTPqDVYS62WxO2GCZbW8j6bxQnJswq1RVI7IuZJPA5YYwpz1
         gG5Iq79yaApW4GJNNvAtM86wAhq29JXOXc9dJDFeWwFilGSNjipZ3YciQzMEYDNP3g1V
         RIIcYzIqM4EIBQEMTd1j4Rf1h8X4xE0qvBAnWeBUyGM+dkx1XIVchqKKo0yTwn8DC1JO
         nAjH6J9p2ccDM9HOVoKwbJOnGjIO+uNXiELpM6u0oNmWOjlGPHQGwb+877ZVhK2tIp3Y
         xh4Pj76fZduBwiTZo2zDCdJCnA11qOQ561ebBBIZ+riGekeLEgoXXv01Ytef8dm+Jyrd
         sB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJCA1WFu34YlfNRq8jOTmY3WvoNsmIlp/39i55U+He4=;
        b=k4BfDa4iNoIaoDKuZQsEQ1dFNsz8N8g8z1gVjk4RNd/nHRA7eyIFMRd28pmnG+/09w
         rsbsXivNgUTso3jEdQWQZqoJkthV2RxZ3FPS0/jR6Cq2HavSjdeKKmXq1Kt5YXjaZmD2
         yZgBfdGI0LnLPYQUsLblCASrH5tZZHi7sqkqBHyYb44PGHUqy5nyox7FuE/WAZidX788
         10SBUgc6tisz3qsa0pmWuEljwzXprBjsZsCxJkl0kAPi4mN6ZPgEGCE1Xyi7MKv98PfW
         iH5D4IA7cpjDlha4Ox3WbBk8+GA61DeWd7zXn9+lyPGOtx9BrwRuKQ2DSf5U2f2zZxEt
         RJAg==
X-Gm-Message-State: AOAM533gVOY1DdQIJzni7SdyvwuYGWAimQh36VvoY9VxOi9Eo4D0FpTD
        mxTDch7hmGIeIlqVih5CMIeBDyyO7xqWyZTj
X-Google-Smtp-Source: ABdhPJxEMjMqxIxQAvPURqGH56LkgRs18E1ic5CgFO82HC9HIlylH2MC5cLt840dIGs96aVt2tjzUA==
X-Received: by 2002:ac8:36a3:: with SMTP id a32mr25319450qtc.90.1607349477108;
        Mon, 07 Dec 2020 05:57:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y35sm13126441qty.58.2020.12.07.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:57:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 05/52] btrfs: noinline btrfs_should_cancel_balance
Date:   Mon,  7 Dec 2020 08:56:57 -0500
Message-Id: <a7c567e199a87e15d03b83cae711d3e18413ed92.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

