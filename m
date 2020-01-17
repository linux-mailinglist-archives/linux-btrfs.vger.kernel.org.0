Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390C1140B81
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAQNtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:49:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41444 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgAQNs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so22668736qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pM6Baxg4dx7swLymggU9GXTkL1FxfAoUeQLO3SfFwWk=;
        b=t+A80fSoF9K1bkm/Eo59BLv7wvIkyouJoUviDTaZUJS+jNT6LJZCCCaNMPPYxREo+P
         6rmxttNpW0/+bkjXXBhUqXaSVfCMrD6tLm7oSSQNo10UafsAkAhqz3BHPfW/ykc0F+q+
         GUa1ZFxe3ppndHIrFr6B7Jv51dSqBEA+Tes1NIDIkS6FAzrM6MLDE2XHwgx9GSSl/WZ5
         69l+2Im3xA7AMgA2ISHtLufVzz3e7BCZ/70ShSkEwjVj41xMmmBTfS6ysWu4VimeNqtt
         YTINsD0Sw0C9J8vg0O3hwtb3HcIq8WhwnSuNSugvgk4B3VV64/dR+zenJBUVwwbXKWwB
         xUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pM6Baxg4dx7swLymggU9GXTkL1FxfAoUeQLO3SfFwWk=;
        b=CwsJIrTfSiH+zN1ytL8Gf7Tw2aC4dO+Z2Grbnm/aG2iKdpxwuQUT+DTT6TS6PZXQNF
         uQzTBfZAf80Q4YNscJxspMU6Gbr61z3wMWqvA0nXsfGzSBqQlKmwOlW/cKVaenO6AzVA
         Vcx/bCd/UEAFgPDB8ysCZBP5okngfWFy3q6Z7M1Cpa1FtUpRiW6UHDTwT8KFF9R/uBq+
         kUqGBr+gtGZM3Y54h3hLcbJpdUZ0tcBAFnSGuLgATigOEr1WuCkdNrciMeVb0vPjh151
         XalUYzZ5lygHau3X6tnfGyta08did/TlKwjAr491dQXtUIrcY5bCWSuDrLPRiiphSP1s
         lMzg==
X-Gm-Message-State: APjAAAWihaD8YiF5zYp0mhhgu0Mvgmq9x8+yJEFu/Od4fcARKbsW8rhR
        AA7n/fnEc+xbzXzfXii0J1gienB/YmGgIw==
X-Google-Smtp-Source: APXvYqwze7xIhSzoL0KAfc1U1dOnDRsoMW43SEMAIpTN+lqxF+hnvzOZFcaR5OFPKYv1kEYUFd0gbQ==
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr2856535qka.169.1579268938550;
        Fri, 17 Jan 2020 05:48:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 68sm11971373qkj.102.2020.01.17.05.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 34/43] btrfs: hold a ref on the root in btrfs_recover_log_trees
Date:   Fri, 17 Jan 2020 08:47:49 -0500
Message-Id: <20200117134758.41494-35-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We replay the log into arbitrary fs roots, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index db803765b500..5b05419a0f4c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6114,6 +6114,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
+		if (!IS_ERR(wc.replay_dest)) {
+			if (!btrfs_grab_fs_root(wc.replay_dest))
+				wc.replay_dest = ERR_PTR(-ENOENT);
+		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
@@ -6170,6 +6174,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = NULL;
+		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
 		kfree(log);
-- 
2.24.1

