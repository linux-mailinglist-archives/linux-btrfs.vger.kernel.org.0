Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FC23D6D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Aug 2020 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgHFGbx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Aug 2020 02:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHFGbw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Aug 2020 02:31:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82CC061574
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Aug 2020 23:31:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v11so52359638ybm.22
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Aug 2020 23:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=sdm2DSoAV0iNGUec+K0quGalkY3uq/+dJP/WtuwvHz4=;
        b=Dz/HdjvkoUUWo9ktp4AN+8Eu5BBpr4a/EmllrflWKwjXwXrg0SKoSpKcs7yMxnjyR/
         Bp9zaS6g+08y+ewsZRlkswMfKKAL5U6qzUmTYGJr3SOliPJc6IQ/1zHQKiV48LRvN/pW
         wLk9sqv4AaiMrLojE+9TACqI/qtdP8ASRtNjwWnRpimbaSgBQKqMf/jkXy4gDEcJze1U
         wrR1YmFdv+uefZYS01Ux3xC3I+0bvqali35qN+VjCsh6C+4yjxTKm9mNlTMDbSgbnao6
         rDQ9QM/aiDmKiJJDGRfO3K2IRhPXJ444un4PAvWq8rZ0IHtpGNud6cOs8miDAsCL/YLB
         6hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=sdm2DSoAV0iNGUec+K0quGalkY3uq/+dJP/WtuwvHz4=;
        b=tthfGB/xfDYxbULKbzOgErT5xlv1qe96x1DE2wMRFnIEPoukg7Gt71298KmajILIA3
         Pr+dR03TcllXwq5Velb6UIadMpejczQvoySO2ykxn3tu3wOlrD2sMjG8tAninAExXuKb
         a1Q5gyzMIzAnVr7vZKz5glVchql033jexERUx3EfuHpakEkDJMcKNVP9mfZd2l3q/Tnf
         UH67+KbBLtnT+Luz163GgaPPy3NZK6tvMsgCN5J5E6K3983RNdEYHKBv7Jq9uVfBTBVx
         gVgD8pS4mlKF/ilyGlLWJ5FftgKJbMRKGDPXKq0hchtanKBBLSq2vxjN4EceK0oxcdQN
         BwTA==
X-Gm-Message-State: AOAM530kXiqOR60+t3l0cMeUBJcG+ckrL1Ie7PD/J6MQMw1+I3GMjaEI
        gKWT3QBxWnMcQIKQcaE9p/02u+YfwNpokQ==
X-Google-Smtp-Source: ABdhPJxGaII+/qbjF7Uvyf5gZlZqH56A+HG7xenfRX9BwK2d3d5JfoTv/2mkn5I/qz1+imvJ4rnrUOxEi0womg==
X-Received: by 2002:a25:aa14:: with SMTP id s20mr10163258ybi.292.1596695510923;
 Wed, 05 Aug 2020 23:31:50 -0700 (PDT)
Date:   Thu,  6 Aug 2020 15:31:44 +0900
Message-Id: <20200806063144.2119712-1-boleynsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] btrfs: backref: this patch fixes a null pointer dereference bug.
From:   Boleyn Su <boleynsu@google.com>
Cc:     Boleyn Su <boleynsu@google.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Boleyn Su <boleyn.su@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The `if (!ret)` check will always be false and it may result in ret->path
being dereferenced while it is a null pointer.

Fixes: a37f232b7b65 ("btrfs: backref: introduce the skeleton of btrfs_backref_iter")
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Boleyn Su <boleyn.su@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Boleyn Su <boleynsu@google.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ea10f7bc9..ea1c28ccb 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2303,7 +2303,7 @@ struct btrfs_backref_iter *btrfs_backref_iter_alloc(
 		return NULL;
 
 	ret->path = btrfs_alloc_path();
-	if (!ret) {
+	if (!ret->path) {
 		kfree(ret);
 		return NULL;
 	}
-- 
2.28.0.163.g6104cc2f0b6-goog

