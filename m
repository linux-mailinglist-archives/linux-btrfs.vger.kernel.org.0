Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA614893D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404404AbgAXOdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36559 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404547AbgAXOdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so1233975qto.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3pyxPNY94oOXrEeZK2hUi64+WTr11ylLgHcJGK8aNDE=;
        b=Z7hImNwUK/4FaxbLR2CvrLfaN1Il2rKZRnwcOzAE5+iRLA6Vp1+wvzL9GM+hTbD2LE
         v/3gpZvh2oSwttW3VmYYwyiwsFX+1qJ9VsBL+CqGp0PVoBhRiFCe9owW6/iV+HtMJyKn
         jtv4IVBbOMh0amtKcYyVEjh+RedMujv4ay9KIwBOAzuJl5KAk4JzxEGso/l0ROl/iaLG
         JVRmlDIg53V+/v79va9s3ZDidtmoqDG9IqQFb67Ghll0szP2nufQK3eS1HQKsxjNYGrP
         jMiHrN1Znoc6GO4/xNyoEtI4pg+RWCluq7jIQjs7zo8eb9/0CmqQ7Wh1oh2M9j0wbEUf
         Dp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pyxPNY94oOXrEeZK2hUi64+WTr11ylLgHcJGK8aNDE=;
        b=lR4qtYTl66XLhpaHgn4EXWuR1LE89sVn0l1FY5Ras1YBQH8SrEx29joqXmX0aieG3Z
         uGIK+jo3ItlGgQZkX6WKLi/gwQVj8njKxNEyIuA7ibACocPciJ8SQAJ/PecVK8YXvfIk
         vW8D5vXnwKsHDlAAb5dDFJFND+F9QNLTSKJ8dHeqLqJF8OSRiHxCBdaIOiPtnekd3xgx
         8GJIi9EoXWi7ze+z1W0yRx0LcYEMwNk/wsIze/LTgjRQIj16v817hbwhinRToWNF5Y4W
         S4p+hZ0P11mnlyvdtT866EQZl7cpIw4zNPG4upnHjja75cjcDs48rYea+ioDD31eHgoC
         WKIA==
X-Gm-Message-State: APjAAAVa0vTAqypNWp2qkuwo01cMkE4LXGz/zJ4Aoqd2wNOglfKe3J30
        Ffh3+VuOWXuy/d/jmnNg6U6Jrw==
X-Google-Smtp-Source: APXvYqwSkKoIZOC7wuy5NLmuoNKeEP96bcv4eoin5FMJ613LlFq9Md/0qNLf82/sroFUAOZlQj9mAg==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr2448490qtn.375.1579876421456;
        Fri, 24 Jan 2020 06:33:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l17sm3092912qkk.22.2020.01.24.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 23/44] btrfs: hold a ref on the root in merge_reloc_roots
Date:   Fri, 24 Jan 2020 09:32:40 -0500
Message-Id: <20200124143301.2186319-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the corresponding root for the reloc root, we need to hold a
ref while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 53df57b59bc3..79430a4245b5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2546,10 +2546,13 @@ void merge_reloc_roots(struct reloc_control *rc)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			root = read_fs_root(fs_info,
 					    reloc_root->root_key.offset);
+			if (!btrfs_grab_fs_root(root))
+				BUG();
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 
 			ret = merge_reloc_root(rc, root);
+			btrfs_put_fs_root(root);
 			if (ret) {
 				if (list_empty(&reloc_root->root_list))
 					list_add_tail(&reloc_root->root_list,
-- 
2.24.1

