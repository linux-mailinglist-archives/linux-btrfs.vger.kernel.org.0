Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0A12EB56
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgABV1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:27:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35338 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgABV1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:27:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so32734142qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=djSD4JkyKqBZ5ReN6k+RMgEaj9MxjSa/MHjRi+dngUY=;
        b=XBLjhCv7tCM373y6ImR+RYjxLtCiuXNzz0wb+rZu0kqqBFwu9/cW55BwpU4VV90syr
         hx7nEj3AxkOCsTifVscMtAPn8y67a7XC/VrJNwxv02ZZs2RfM1ccG9QZyLewqZ5J8Kss
         rFuuUogRKZLoanjK+UziW2lLFSIls8Y7o4oG/BQhReC7VTBSTFkm6loKvQKAhXNy88WA
         TaZrX3IrgHx9zbacyjwcEhGSyxHlW2fJXCKQ1O0+tku46ITN3z2xYkYqQVI2vSkM7MCe
         PJF9OILfI3tu0cgN9/oODsxrEwNXzfu8A5ndCWsY2jU7dtEa54SzMzr4locF57+prisx
         by9w==
X-Gm-Message-State: APjAAAW1OZOPaeYqo5WQyptp7bjvZrCS7dKO/UPsvZ1tPEXQl4MwkUH8
        2yo/pnTpqEnojg7mMpxJY+0=
X-Google-Smtp-Source: APXvYqwEiBldsfOlOXLWg3MFq+iiRL7J/RNsAOCbqGhGcszCLXbTxkZsPysOGkZqsObVzO3DwJ0u2Q==
X-Received: by 2002:a37:bf82:: with SMTP id p124mr69374658qkf.337.1578000422347;
        Thu, 02 Jan 2020 13:27:02 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:27:01 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 10/12] btrfs: make smaller extents more likely to go into bitmaps
Date:   Thu,  2 Jan 2020 16:26:44 -0500
Message-Id: <075b6ea5fdbd3c113cf08963f430ec148fa53a78.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's less than ideal for small extents to eat into our extent budget, so
force extents <= 32KB into the bitmaps save for the first handful.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 665f6eb6c828..6d74d96a1d13 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2107,8 +2107,8 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
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

