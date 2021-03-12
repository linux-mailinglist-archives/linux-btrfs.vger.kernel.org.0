Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEDC339857
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhCLU0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhCLU0X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:23 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BB2C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id j17so4903571qvo.13
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sn4OcrDan8zF8s42MF9N+ux5UFalwxVMfpouWmmTaKY=;
        b=hX2hyNIWv5cnjqSfiFyXeDaazrJIlf46voTE46B86bshWwMH6Epkh3pmkt4U1e6Z37
         aMyLbHhrWGxzO/d64kjtJqyZ7kaW0Mnr2pp/nj2WoKIxbUmbZ2B8bEO7Q+zn57GLpO5y
         SwFLWgghwy8dnaOe3TjEjFaPLWME5x3nE6BffirfKfWN1AuCfsfJki2mq8yhLnzwGPE0
         J86HjzH8fkgWbkAUkzMOhdX4ALwYmMjc4+sVUc/8xDKWVoLwXSDPyIE9v0vMeagyavkt
         UhRTl37Y4vPnsRhLqjDXhRRpcNO8ovX7LqTgTklxrxwWwQVEmXw1GjM0sqTrbBTPUpUj
         obrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sn4OcrDan8zF8s42MF9N+ux5UFalwxVMfpouWmmTaKY=;
        b=ZkJhBI3DCioP5feOWnKfMZhNLutCSp1ukAX6Zgc0PMxJiKYGKr82A6TmVJFY/g7m7Z
         s94wMQC3bIUJ8Y8PSrHNAsYrSn2Nb38wn98dnuKYIkWNw7PAbceXfIYO82EhSvePfRqy
         PtwfWUCYzl6inyUbPI3uKJcPTemqPDir4ssC4HwfDHXpUiv5wdY74sfIirKEKCRZyDA+
         V1oQcj5Q/LR8cZD4qlJFJiFGYt1m8dcGuVRX95JLBWW/tZQi0pojfIhyGdIWft43qB+d
         TkZ2MozZmYU+z3h2r2RvwBSEsBagT5nnF2rGcOkdrOQoek77Z+apIF4FJ57yPNtDyhPR
         /0yQ==
X-Gm-Message-State: AOAM533r9bqc8Tx4BcH4UcVta0u3YH4MgziCuEEKVJiDL//QSQ9x4Rt/
        Frkk7m7qMY3dShe2P9z1Hr7+ukHg5iZ7mPqT
X-Google-Smtp-Source: ABdhPJy1zSawBaJB97TYoL/HMdRB2Ho0WuqsCkeGHNfYpr2vAbOUtFcMDNvou3+iW7FBQgCmvlp3Hg==
X-Received: by 2002:a0c:c68f:: with SMTP id d15mr24376qvj.20.1615580782614;
        Fri, 12 Mar 2021 12:26:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t128sm5312242qka.46.2021.03.12.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 30/39] btrfs: handle extent reference errors in do_relocation
Date:   Fri, 12 Mar 2021 15:25:25 -0500
Message-Id: <1f31bf3a150a7ca530e91faa03cc12aa5058d2e4.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can already deal with errors appropriately from do_relocation, simply
handle any errors that come from changing the refs at this point
cleanly.  We have to abort the transaction if we fail here as we've
modified metadata at this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1a0e07507796..71a3db66c1ab 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2432,10 +2432,11 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			btrfs_init_tree_ref(&ref, node->level,
 					    btrfs_header_owner(upper->eb));
 			ret = btrfs_inc_extent_ref(trans, &ref);
-			BUG_ON(ret);
-
-			ret = btrfs_drop_subtree(trans, root, eb, upper->eb);
-			BUG_ON(ret);
+			if (!ret)
+				ret = btrfs_drop_subtree(trans, root, eb,
+							 upper->eb);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 next:
 		if (!upper->pending)
-- 
2.26.2

