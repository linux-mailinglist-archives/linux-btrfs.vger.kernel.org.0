Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C117140B76
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAQNsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36406 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so22715894qkc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9OAAcqaMbjW7cScBeTX32CHFR/qm1W6bsfb1LGm7VzM=;
        b=h7pOWd/cbdC3dRYkkuCJAMgxjy5xeu1pFV7dr4BuUQ0fl1Uc7mhz5SKdRqLCQY6RUK
         19tj+NQAIiE1oACvHkAvNUxwLpibOrMTX9jQH86Bq46UKmJNaGI/U0pOZ35INrF9UbZm
         fCjNPlKu5KQvMDXXtaH+BIFKgvSMhXA7R7/cTMgZl2WZd4Z9piX5Ed9WK7kGZytf49PM
         Hv3KCVEycL60CsZAXg+jkf9As93+p+HrJuXta4GyiIjuQlKGr7kqCLLpZ5tR7b//Z6DO
         i0OvkNZEpclIlFh69Nazjww+u2t+KgrBTQd/KH7Yx5Z0FsOMtRvo5qEC1ScHMh4UDokC
         hIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OAAcqaMbjW7cScBeTX32CHFR/qm1W6bsfb1LGm7VzM=;
        b=KMGA3+BWkl1z7HHUDMrURCU5K1MM7Gwfn9jY0urFamLA4VrP1Y7RChUkAxq3uxjE6k
         8OYlX8WF8waz+gRbNcMXkF8jkFInWg2HMjT90//DTiXj/8TO9oJwjLtQoSCkpSy+pC4u
         MKekSs63my6CoB/qR3qE0rfIfJANpLxQcwRxUpSIhLf52ybHeyJzMlpuUpZXPMUGhDSx
         1S8p7UiQK2kKpu4HLsXovL5mgfVh6Hv6VAzZ6ZlMzxK33xxuJoAbvFjktrCTmnXTra2c
         1w1dAOyHw/TgkM3rUkzlBs+V/VCJxf3iPbsjb+0GCxW6digUb2l7mR0xTXEsBZjClYcS
         Wrww==
X-Gm-Message-State: APjAAAVzEHx9TM5mVvwqu7kySoxwFtxKohbuki9nQazCkZpcJPuI0Vpw
        XELu/0HvUGQr3v++M5AZK9ryfJVzrghW5Q==
X-Google-Smtp-Source: APXvYqzheaPsboaO3DSaJcPCga+3uzoxjl1E63A8h62yAi+xCrm9wGGGKnVhTV2eShnJMgyTaFyY3w==
X-Received: by 2002:a37:ba03:: with SMTP id k3mr37479118qkf.127.1579268919732;
        Fri, 17 Jan 2020 05:48:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g52sm13669381qta.58.2020.01.17.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/43] btrfs: hold a ref on the root in merge_reloc_roots
Date:   Fri, 17 Jan 2020 08:47:38 -0500
Message-Id: <20200117134758.41494-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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
index 0068b7b940f8..953978ba46a4 100644
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

