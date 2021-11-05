Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D0446A0C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhKEUtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhKEUtH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:49:07 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC8C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:27 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b11so8067711qvm.7
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vPq/UKcbHvK4vXnAq91ap2B3tAcpVn3xBp559m5Fwss=;
        b=RBzsNdvT/1AFgGjybsFVQvZ31/k0TmJ/UCiF41jYrdPG0RzKQoHg38WdTusi0SzY6j
         aeCM9a5v4xrjnZ31YtWJMD2DLBU+XGU9/ehTBZVtDH5naW4wgNPBhp3IiHLDgPQ52sI8
         FecWUXQRZ20N2Fr/OOfbhN7AV3v4+o/ctNRteLbS3AQS3F6zlkYyHAQFPnsKC8PF3mHL
         I/h7d6rzcRi8cFSaprsgVah0TOMlC3CbFnJuFDojT/4pMPQ/rYKvyHC9ndVwpykalEAI
         0oJJ4qjnH8iFbOnpcOlcP0MRLbwK5PzZig7sndNyNfy7cAwdYG97JfbPtI/iTGQK2/Al
         HpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPq/UKcbHvK4vXnAq91ap2B3tAcpVn3xBp559m5Fwss=;
        b=GE3PdlIHZcCebb+QVcQWGRbEdekEt0dsHwigf6s3siQjhMcroGSFShqdiQAIdVO57T
         mrQDKg4z8K7eyFnxWXKRfmBmorghsgqFafyxjlzku8Eh+/vS/m5F9ja7tlnlm7EZi/q0
         /WCI2PQBBaZbuvYa9bLtIk00/kdtbj5lwM/YQfWK6KGpY5rcNLEx9TFWElsqPPYH29Nb
         VD3I1/ZfKAg8pU5d12779Qa744HLt9R77rLJqrqBt6HwDlTbMtkDOuBATYooc1kiR0Wh
         3+BShm40A7SCAOWr6xNcQT9pXEiiEFaWJNvVWfwQdG12qTzf6y2Cg5qCbYBZzGh4A9h2
         Xm/Q==
X-Gm-Message-State: AOAM530r4/lziov7nYogKDk3SUpMhVL1iGhePNfNtSPokAwzVjaixOSD
        lS6Z/S1CUODG9J0fs3j1Ni2VSyGRa4My5Q==
X-Google-Smtp-Source: ABdhPJx+z0EQcWt/mmwe0ZTzcQ+1uQZ50ETTDIrtid2gXQ3DFAUC10xxF94nX13TbYPgcXrBRk9+XQ==
X-Received: by 2002:a05:6214:5002:: with SMTP id jo2mr1501723qvb.27.1636145186382;
        Fri, 05 Nov 2021 13:46:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm6950938qta.58.2021.11.05.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/25] btrfs: remove useless WARN_ON in record_root_in_trans
Date:   Fri,  5 Nov 2021 16:45:50 -0400
Message-Id: <3a1c2fbb7b5888617fc84527b35b87488659691b.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't set SHAREABLE on the extent root, we don't need to have this
safety check here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f51edfe3681d..ba8dd90ac3ce 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -413,7 +413,6 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
-		WARN_ON(root == fs_info->_extent_root);
 		WARN_ON(!force && root->commit_root != root->node);
 
 		/*
-- 
2.26.3

