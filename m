Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A564C148944
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404581AbgAXOd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38922 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390591AbgAXOd4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so1634124qtm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ckTN1AcxkeHORRhsqXj7YNF2NgUrl9S+/nMmxj1pRCE=;
        b=iOEQAvBnyn+aYUc//5ejiB9XspOYTof7iP54CxzeGwdsbnizPlPz2vVOC5SDpXNOrr
         urxDGrOYcv3zaMxeiaDD5QP5pppGgI71YsVzlPFCAT9r4pLS21eVrIz4ZMJZhUNE1MID
         RqW9xhESbkJekmgt4J2AmRgpIsUJ+w2J851OltMgXkfpe0+ivCjUJUQwABItoBTN5Cfc
         nZIcHGvmbZaH2bZQfrHNv7zkIy6OAnszvbKSDLNA/SGtF42HDXMQrH77k7/oH2a9iYDk
         BAZEDwbilc4EyTDgKqOrviIIC1ZltHW5KQTGnae9xD7ATrTpojkma/VhIoruA7gwBiT0
         hefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckTN1AcxkeHORRhsqXj7YNF2NgUrl9S+/nMmxj1pRCE=;
        b=DI+bC8IckjK469bKXza70YWyEqecm1MIAMyLqgCxFapwQ9hB5ZqORKsbjvxnVySPZu
         mAJPjgJiuTN2gsopVjblmn8hoqWAJ15LJiqN6TzapqMoDe2gBtWnKdDCiu73AiYqYYxH
         BfXMA920hcxxXJf4N8XaSepc5OtwyiLhwkqhV0QgaGmhIPljlZowMiV1ukO/meES0pNk
         Xy6CencAlexfi9Px71PhXwKuZ6OkNz6h9C6mqRMmQPIRg5LmjeyEsB+qkz6ZmGJZUgk9
         sJqAUnbnmEqGRKB6oIUIXzblJlP2+vpVE7erf8NzmG6u8tHEawc5/UDGXOZBAP/K1Ch2
         bJLw==
X-Gm-Message-State: APjAAAXlx1kB0khJbUfePrDzjeW4Ib2VgS1pjSqLwdpd3ub5i468BLFU
        QJX7YXjKicq4QbJDgVdQll6bJw==
X-Google-Smtp-Source: APXvYqw4g1iiFbL0xYHyAU2Ka6xuVYHwwxNHMxjzq8vflMSVKknh9TNgRze1Fz3mtNoF7NfSd8Yjhw==
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr2417628qtd.115.1579876434961;
        Fri, 24 Jan 2020 06:33:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v24sm3312374qtq.14.2020.01.24.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 29/44] btrfs: hold a ref for the root in btrfs_find_orphan_roots
Date:   Fri, 24 Jan 2020 09:32:46 -0500
Message-Id: <20200124143301.2186319-30-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup roots for every orphan item we have, we need to hold a ref on
the root while we're doing this work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 094a71c54fa1..25842527fd42 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,6 +257,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
+		if (!err && !btrfs_grab_fs_root(root))
+			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
@@ -288,6 +290,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
 		}
+		btrfs_put_fs_root(root);
 	}
 
 	btrfs_free_path(path);
-- 
2.24.1

