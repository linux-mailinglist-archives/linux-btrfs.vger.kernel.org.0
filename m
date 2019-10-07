Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA919CED55
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfJGUSQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44200 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbfJGUSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id u22so13901889qkk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9i4eW4XHtLg4mQvpj1SRlQ9LMSYlft0dZrZiKgc7lNc=;
        b=d4JFZJaoUEuZFSEwX2x3zFY93nXob2rAKGwG07wslsGqWeOXcp9+csQDNv3T5q8JmK
         L4m/skMvXpYL3R4Fm7PlZ78vlqXOTi9RncJEPUWW/V4FzdXuX57yw3cvDTDUu1OC8mAJ
         2GxAnBF/94qqlHCsxhc62YaaXL4GktBPWDCnIAkSkZ9guV0C3CgEHPxhYcAqaT7Z2gNi
         XIh+bs5PTKSb3YsrpdWAXZlX9p15rn6nESYQxb/bt8hzrqzyKrO+cWLqFjnXNC1KqExp
         OK428A9o0Rywla1UBvHnySsSzaVK7cBoDjIWbkXKpSCOVQeGaLRvrYpdf4KRMiwQtxUR
         5KHQ==
X-Gm-Message-State: APjAAAXR4pQQ6HeXgOZM22/5CMkE5kbawzmZnQa6IZz67AYl4ueh4YYd
        Uk07AbTMptMqIJ9mvBUvLOs=
X-Google-Smtp-Source: APXvYqxa6ZJabEo8SK6alGiljEjYMvyjmKcA+CPcqErjSlCsaD9LsyCvqX4XcXSXZbsE3QImy2Civw==
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr2919131qkf.436.1570479494699;
        Mon, 07 Oct 2019 13:18:14 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:14 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 19/19] btrfs: make smaller extents more likely to go into bitmaps
Date:   Mon,  7 Oct 2019 16:17:50 -0400
Message-Id: <03e95dd7b652034541d964d8b9617ec029765575.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's less than ideal for small extents to eat into our extent budget, so
force extents <= 32KB into the bitmaps save for the first handful.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/free-space-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index a0941d281a63..505091940580 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2094,8 +2094,8 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
 		 * of cache left then go ahead an dadd them, no sense in adding
 		 * the overhead of a bitmap if we don't have to.
 		 */
-		if (info->bytes <= fs_info->sectorsize * 4) {
-			if (ctl->free_extents * 2 <= ctl->extents_thresh)
+		if (info->bytes <= fs_info->sectorsize * 8) {
+			if (ctl->free_extents * 3 <= ctl->extents_thresh)
 				return false;
 		} else {
 			return false;
-- 
2.17.1

