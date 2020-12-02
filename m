Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3515C2CC711
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbgLBTwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbgLBTwn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A81C061A4E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:37 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y18so2450862qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ObcviAAK3dYX8QWWRG3QvxeMSLutw7LwvFpMxSbAhq4=;
        b=KNi5UxtuUsJ4j0dzgNvfvqpbGSVo2v0h/15a0JIwOP/xIvTKABLerMxDaLbfoo4iqG
         Rdm1EdNeWuv0LKo07jgx9D0XQfY93hoSXmAWE5Wxd8Ew6oAU2JMBom8wxLTK28pb4AGl
         tPXhmW6WJl80MOx/rfEb7Eqmr1YXXGPtTKZAV2wyGoKwPL5nx0OFuPbWkk6NUthlIcRZ
         drtOOaPz6UyeVuOL5+Bv4ldU54YT1F+7Zd9d/CxjhS/D4WG4uOeHSQODP2m3OgT2M9sO
         Gpnorzm93+wmK4hMkz0VeeFmCQU5WWHQVjwT+ZRuR31SLlPThJzGBs+vkVP3lhNvuk5L
         IA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObcviAAK3dYX8QWWRG3QvxeMSLutw7LwvFpMxSbAhq4=;
        b=Gfd7qQJwSs8gjfbujUKHi6R3/ZxsPuAjYE/EKNI/H/7WMABzCI7pVk0f3ytQWQQlGK
         ZJY04EXCHoZ5MJlhUq+ybZUTzkCgqWbhNhQi96sqp/vYfK2uXdQrlDH3kV1+Inzd4pG1
         rsvRlpPVtu2dopEfqvIh24At/sFRDBJtiD7zjyKSlG8v5cfI++L0HaxtBy37c2vh/W4Q
         s255DXgFB0l079viLfEaqRZ9Ufyh7X+W0mUbtu+rRK8kaAPrZG1qY4JumkQ6lV/YVt2k
         HwIyWtbe6V4etosBA6bLUZ3MitWlgDY7eneV+8BpNdyTBJvEwXl+y/Ggym54NxavVU3h
         8Ghg==
X-Gm-Message-State: AOAM531N6jRF+8qru3msEjCFI/pTj62VdUQD3A34wl7NGIwjIPH6OxOh
        fUGYha7TAISWVYDojoUUU4L1aQGSsEc58Q==
X-Google-Smtp-Source: ABdhPJygjl6K+EiEqG3dwvc75Xxrbbqz+O/b7/pxjKmuI+ivrScMQAA7+iwRbOuNkDeYSbIoXVYxow==
X-Received: by 2002:a37:946:: with SMTP id 67mr4273687qkj.304.1606938696510;
        Wed, 02 Dec 2020 11:51:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 7sm2806754qkv.55.2020.12.02.11.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 13/54] btrfs: handle errors from select_reloc_root()
Date:   Wed,  2 Dec 2020 14:50:31 -0500
Message-Id: <871fea9cea530b626f0f253c00d53a3e7a1ea531.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently select_reloc_root() doesn't return an error, but followup
patches will make it possible for it to return an error.  We do have
proper error recovery in do_relocation however, so handle the
possibility of select_reloc_root() having an error properly instead of
BUG_ON(!root).  I've also adjusted select_reloc_root() to return
ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
error case easier to deal with.  I've replaced the BUG_ON(!root) with an
ASSERT(ret != -ENOENT), as this indicates we messed up the backref
walking code, but could indicate corruption so we do not want to have a
BUG_ON() here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4333ee329290..66515ccc04fe 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2027,7 +2027,7 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 			break;
 	}
 	if (!root)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
@@ -2198,7 +2198,18 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 
 		upper = edge->node[UPPER];
 		root = select_reloc_root(trans, rc, upper, edges);
-		BUG_ON(!root);
+		if (IS_ERR(root)) {
+			ret = PTR_ERR(root);
+
+			/*
+			 * This can happen if there's fs corruption, but if we
+			 * have ASSERT()'s on then we're developers and we
+			 * likely made a logic mistake in the backref code, so
+			 * check for this error condition.
+			 */
+			ASSERT(ret != -ENOENT);
+			goto next;
+		}
 
 		if (upper->eb && !upper->locked) {
 			if (!lowest) {
-- 
2.26.2

