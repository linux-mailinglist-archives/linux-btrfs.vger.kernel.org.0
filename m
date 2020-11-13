Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A372B2055
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKMQYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgKMQYx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:53 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04905C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d28so9257387qka.11
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LhYcpH7noh2f11kkIQoXvgdEaEGJ2D0kJaXSmmVfaRw=;
        b=LQupzT5VeyevnVZFnMbQFEe5ofBrwkgnqLfzf12Hn5jh1eL60XVHK+bacQq1NngV+1
         zuMpPWIbyeFtKeWYShMhXsWi58sFUspa5KlRoWKoYGoW5sGKpVrwwGqSjW3wxhR5Qfz5
         dxG+OqJIJsaxoboqOTqWMuSxYQqoDy9UF3SnC6Z/uTmPrpODmrQXOktBGMZVnr5G9/uS
         enjUGH54c1n7cD9o8RNK24i/M+kOR+t26r0PuskmrXe/CzAGfOdSlgW4+hT5Im18UNke
         CiKyaKZWUAgmyvalsJa+blcUhcu4Col0qEKgsQK7Yn0DXmQArfBN2/GRe6ihBwrZXZe9
         FwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhYcpH7noh2f11kkIQoXvgdEaEGJ2D0kJaXSmmVfaRw=;
        b=IiVJ0KY+xoq5JKzIgkweVR8l4hNZQjUpzsUSuwPF/yi2apc5zzYlSG/IhcINUqqGe2
         PorauZcIIdYCGb7F+jn75PYB99DiGQRL+W+qfwyULiQIeR0a795Xk0YSHzz99h7Kq2FA
         sPbNnmn6jr1N2GjjAZod5WsICpPI6/9wrrlO9VSY+G6Fdf1T8B0IYFvYscKZ1kwUTGDR
         SsXta8zx7tj5xW2ReCm/3yVlzS/b5cV/ZJAsUS97xAE9Ty60yVV7Z5HgykFrja4R7Ub7
         faz0kVw3HrexDy80u+o+upbfjUG8FSIfJFpUz0kdBa+st+bnBcZvcwVa0CRPQBCJT+Pj
         PfKg==
X-Gm-Message-State: AOAM5321rOtHgfuF6DkQjk2UuxpBipmSLMmlCUWqs/bQxJ27WYDYcGG8
        nYQOM4+/CAMPv4NBTXxXqL5/nM1aSvz3Ng==
X-Google-Smtp-Source: ABdhPJyLxsWR/tNj8RVWR3QilD/SAXavHfoI+U3lOTxUQGFAIBMKUPpE3ukroGt9jEAZAeXKie7l9w==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr2732162qkd.170.1605284686854;
        Fri, 13 Nov 2020 08:24:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q3sm7015755qkf.24.2020.11.13.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 39/42] btrfs: cleanup error handling in prepare_to_merge
Date:   Fri, 13 Nov 2020 11:23:29 -0500
Message-Id: <8a4830b21e958f2be8c40a08a8040f098da60c9b.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This probably can't happen even with a corrupt file system, because we
would have failed much earlier on than here.  However there's no reason
we can't just check and bail out as appropriate, so do that and convert
the correctness BUG_ON() to an ASSERT().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 01dbcdc86cf6..9baff1a60ce3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1882,8 +1882,14 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
-		BUG_ON(IS_ERR(root));
-		BUG_ON(root->reloc_root != reloc_root);
+		if (IS_ERR(root)) {
+			list_add(&reloc_root->root_list, &reloc_roots);
+			btrfs_abort_transaction(trans, (int)PTR_ERR(root));
+			if (!err)
+				err = PTR_ERR(root);
+			break;
+		}
+		ASSERT(root->reloc_root == reloc_root);
 
 		/*
 		 * set reference count to 1, so btrfs_recover_relocation
-- 
2.26.2

