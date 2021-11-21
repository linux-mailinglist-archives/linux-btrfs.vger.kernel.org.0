Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4500C458274
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Nov 2021 08:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhKUHuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Nov 2021 02:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhKUHuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Nov 2021 02:50:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36769C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Nov 2021 23:47:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so11416019pjj.0
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Nov 2021 23:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYhSdpqvrhaWDvVz9YXXw8gc7MlgDdV83FHokTyO5nM=;
        b=gq/ZTIRj0879DS20rhxzUzO+DJ2CwDdkJzgXDJbS78JAkCyqsvNKbL21f7ElK37IzY
         LPoVDKwlPV9pSpwenaXhy/6ZSiP9vfFMvupCmo+eTyMK7qzS1dJ5yBXGxJlcJBqs3lB8
         UQDqf3zaS+/7gO/zKyeoIJPnf4gxGAUjwvcTRXAHWWePLgPeOmbcc1qQGcrZa8bNuZ83
         84FoJJqczwqrQWLKnDkzL1TVn+bbiUg0is06BUXshRuhqhBiyBfNS4RePo+dry5pZ72B
         KhHkBzYe6K/PAxnuo2ltIyr9NkjPnhhkdxKlsflY0mEgfvfYayJ1WlNy52ZLEhXx1Eg1
         vIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYhSdpqvrhaWDvVz9YXXw8gc7MlgDdV83FHokTyO5nM=;
        b=2hGGa5xtEOwJQyJcejcewQ6sC3F9BtW+zXMdkBdPdmGWil71IySojngRzzzUFQizvZ
         6RUuaa0joheGWohF2/Ng3Wxaepbwu8c5vAXo4RcEStZJn3D5nyXETdNoQTWgLKdiMQB0
         WVGAmEW7kf/LADAcDiCxktLwL8q3Kp0FqODEIa00x4gPCN4EsBBInEtAH0rJXMaM4RDO
         7zbcJBJ4D2NHn/L3YGsL1RoOMxXN2Leqgv9PGhgOLfXFuySvIW7Unr0m3kHCV97JfU0p
         oXgHftz4YCR7Yc0S8ofGKo0C7IyPDzXz2xgVUAAJwcuS2BApIMThEvT4FLiQTPaZbq8s
         qirg==
X-Gm-Message-State: AOAM533wIPGYKZsTFeTz1lGbTrS78UiFpxjSAIuku8cXV1r74NpjCXtc
        ZZUfGvfI1wE9Mlx9BjJiEtnZZNw5w55Sbg==
X-Google-Smtp-Source: ABdhPJyheXnrYq90r23TlRQtvpOAbHewQea8Y5qdGhkDc9y9j+70P4qv8c07URiPl/MhvMpH0gs0lQ==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr18316855pjt.168.1637480838374;
        Sat, 20 Nov 2021 23:47:18 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id ng9sm17141640pjb.4.2021.11.20.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 23:47:18 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [RFC PATCH] btrfs-progs: filesystem: du: skip file that permission denied
Date:   Sun, 21 Nov 2021 07:47:05 +0000
Message-Id: <20211121074705.8615-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch handles issue #421. Filesystem du command fails and exit
when it access file that has permission denied. But it can continue the
command except the files. This patch recovers ret value when permission
denied.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem-du.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 5865335d..64a1f7f5 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -406,6 +406,9 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
 				if (ret == -ENOTTY) {
 					ret = 0;
 					continue;
+				} else if (ret == -EACCES) {
+					ret = 0;
+					continue;
 				} else if (ret) {
 					errno = -ret;
 					fprintf(stderr,
-- 
2.25.1

