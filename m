Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DEE140B6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgAQNsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:24 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41396 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAQNsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:24 -0500
Received: by mail-qt1-f196.google.com with SMTP id k40so21761498qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HKt/gyH0Knlxys+g/v0pjWvfo/9TSnmMRROcvEGAxbM=;
        b=Ec6q36sJ1C/XEY+KU/b1uTRl+Fif/jPWcz2A7+n9pztO3aJ8KtX7j/gZnl6o/Y+x8y
         1AKEpOIeSb/o4MUFhcATq0SV4bHMH5S+sRiPFuJqBR/w/JLp9upV1hUzCkUh2pePX3f3
         pjcGaI3cxEgyPcbJlX0BcimmCQ5u6fi3L2upXfqbfxliK20OfYdUQfo4PO7SbA/g6Prl
         agnnyN39YuT2sJ/eIeuwldX4xn0qv6R/FxqiLSKoIBcW9QvnWlvvxe/49KTeLMqwnyMj
         3MZFKo9Iq/jSyF+KK62dgwyS/kbhl1cFVQ7JVEZKD8cVSO3ltVFi608XLCaM9i1FFvd/
         YeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKt/gyH0Knlxys+g/v0pjWvfo/9TSnmMRROcvEGAxbM=;
        b=HWvnn2FXp1Rx7FofWwZG+VFmm3gQpRtczCtaEzDL2ifJgM63P1ZEE2YdQ3j2ObSaCE
         BD6pbx8VzwQFah5MTsQOQkRes6lOPBy9w41YUgL2MyjgfCPQzdi1PqUyGAjgZe1n/5Cq
         gJb4boZDW20DS4ss1DYqoZWaitslLYhqIfoqPh4hv6reKfLtFju0poFgSA0t8OlCQYcd
         HotArP4Ibvoss0kd9QWO/QI1/C7frta4t0O5W3fhP+zbjRkt+Vfu3GiRlVEkPiwUlGsS
         i63cBladcJzuWG5CIY5KzMlwk8bt0aWmFTHpJNCwwJ8IZth1XJnEEmIQg6JEOudWWCVe
         XNhQ==
X-Gm-Message-State: APjAAAVm4OpRuYOdolCi1x7hYFuGqlZT/ybH64EDdyNGTh2c1RHX7Uo6
        7Rzqu38Bl3MDA7ZzCwiYyz9J9eXet1o2dg==
X-Google-Smtp-Source: APXvYqx8Ff6gzFptwH8BcuXB6rUpf40azx2mrxDjalaXDoLG11G5G2PH7VUcl0AQhNQIkl4z+9duEg==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr7538935qtu.281.1579268903062;
        Fri, 17 Jan 2020 05:48:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm11811735qkc.65.2020.01.17.05.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/43] btrfs: hold a ref on the root in __btrfs_run_defrag_inode
Date:   Fri, 17 Jan 2020 08:47:28 -0500
Message-Id: <20200117134758.41494-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are looking up an arbitrary inode, we need to hold a ref on the root
while we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 565ae8404e1c..3abc7986052b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,11 +292,16 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
+	if (!btrfs_grab_fs_root(inode_root)) {
+		ret = -ENOENT;
+		goto cleanup;
+	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, inode_root);
+	btrfs_put_fs_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
-- 
2.24.1

