Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50C5E7DB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiIWO4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiIWO42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99EF1912
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:56:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so380893wrx.8
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Sep 2022 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=yE5MCyZO5HfZG7CkUZ/fFRlgORbdgDYbt+amiHu74yg=;
        b=gacRrwF0QZmyGgEfdhUU4wOTthELMf0B7zcab/zxmmjJX36RW/XaaAbi6wT4akv0Gf
         PE4xPX1lDQaKPfvE+OxryohVCznFERvIzYUfYYOw6zVZtsjDPCY4t6I14rfRfpcAtpw+
         YkBiQoMS0Lmh32XXEqlgolhTAIP4fAvsEhElOL5c4s782kq8nN0h++T+tm60olcJPx/K
         JBwGMbpA/mg9iFkXRK5tuZw7nR7rqff2uuxsX6tn2F7YECsCKCiatpc6fM6cMVejd9ua
         SV/+9NYgGnXXYX6dTZL7k7Y0WDzShlhfRC7+cctQOd1PlRQUSS+uJ1qC1mNZbxcHlRat
         meYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yE5MCyZO5HfZG7CkUZ/fFRlgORbdgDYbt+amiHu74yg=;
        b=1nmiKv51Z586Ivn/u3PGKxIwqX1qyAewCdHmnivUG8FAMj/n62HAJ6DRS8CJGF8AIn
         5AkygE6uZ6eb/lSQveKQNmrxLB4qiRoJRdZz14sD8wfMEncnywqoZa0D+m+d7ON6Qt2z
         krmqdp4wbTYEnGQerfp3/dd/Mvgc1ysGjCfhHRoDZyCaQZiE07xYUDWW+l+opGOGi4Go
         +1yIejrUs9rr7v0XSPejQnxw5S+Y+EOEtwwIHkNQ0IkQUpKd9Ad0KwhIWRGCkUluyZHi
         bnDpwDFonMHU6c/Lz3JtKcmUXh7PZPoi5T1zEhUpIOg4/e8b4XBsKeSw1xXFiebW+5GW
         dZBw==
X-Gm-Message-State: ACrzQf2GyfjcRg/+o7cyJ82odHmDPIAlmWKtv2pHV4KIbCWCM8DoLrEU
        5vcwva+V4pLpAguIfkXKa9Km8PMwbmth7wY1FQLgwhWqOL7SQQ==
X-Google-Smtp-Source: AMsMyM4MJibP6GrHnVz6sHJuv8X5/0GDmvfG9rTr3flrhNc5wGjWJnEd1RoqdU0f1QgnkrAez0vLk4pD92HcldcR6oQ=
X-Received: by 2002:a5d:59a7:0:b0:22a:47e3:a1b with SMTP id
 p7-20020a5d59a7000000b0022a47e30a1bmr5388999wrr.319.1663944984025; Fri, 23
 Sep 2022 07:56:24 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Fri, 23 Sep 2022 22:56:12 +0800
Message-ID: <CAPm50a+6tGRCkB7=QiA+y5EEPm_40N6d-KChPxnT+40Q=5EUQw@mail.gmail.com>
Subject: [PATCH] btrfs: remove redundant code
To:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Peng Hao <flyingpeng@tencent.com>

Since leaf is already NULL, and no other branch will go fail_unlock,
the fail_unlock branch is useless.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/btrfs/disk-io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4c3166f3c725..f39165aec175 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1284,7 +1284,7 @@ struct btrfs_root *btrfs_create_tree(struct
btrfs_trans_handle *trans,
        if (IS_ERR(leaf)) {
                ret = PTR_ERR(leaf);
                leaf = NULL;
-               goto fail_unlock;
+               goto fail;
        }

        root->node = leaf;
@@ -1319,9 +1319,6 @@ struct btrfs_root *btrfs_create_tree(struct
btrfs_trans_handle *trans,

        return root;

-fail_unlock:
-       if (leaf)
-               btrfs_tree_unlock(leaf);
 fail:
        btrfs_put_root(root);

--
2.27.0
