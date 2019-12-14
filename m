Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10F11EF30
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLNAXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:23:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39731 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfLNAXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:23:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id z3so381424plk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F14OZFzQXvrrV4g8hdVBekK/FaE5I6IU2gcfkyyyj9M=;
        b=SPlYG+Bgp/2dIzEztlBNE/bbdxVJj6ZGqQfD5XpsqGNW1+NR/pd52d9Dm0t18O6iMe
         dr7N/fHrpKw4gP8UEYcaDcTmAd2oZWI0JS8eFAEuGK9dJfBlK+WU86e55cYhyMngVJ+R
         09Ab3qo3cCvmHGH7FHVYFJZaj5oT3q2ZlyDd/6b4cs+6ZDEarjHBY9G5pS4fYvgGpSat
         DlGXvKcy4+QiQwj0KnRxS4sg8dl+JCuPD9w5BVp4IF3oWTEYPIME25hdh9/gmR6eEIDb
         OMwvsSDGBIlJ57UtLPzhkKMQVDqHSgR0PnnOalxjyQTHVVo42Vqm2q3oh+TKLpe83TbG
         bYFw==
X-Gm-Message-State: APjAAAU+/uXGImcNh5kcaMtIYYVSAm+26i7+sUlDdNyG7KHP0TtVo1YM
        Q44iPP93wwOj3Z8RpvP66sU=
X-Google-Smtp-Source: APXvYqzDMtXLte/dKDe/V/NMzALcKD7P7P8VXnD6NH/F6p73whhF6fpx79NhVbQ9ujKZMdpSjNp64w==
X-Received: by 2002:a17:90a:e64b:: with SMTP id ep11mr2714200pjb.58.1576282982979;
        Fri, 13 Dec 2019 16:23:02 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:23:02 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 22/22] btrfs: make smaller extents more likely to go into bitmaps
Date:   Fri, 13 Dec 2019 16:22:31 -0800
Message-Id: <cf490c1c06fca244b301bb6e9b009aabc452a1da.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
index 6a313946a8da..42db751aa896 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2108,8 +2108,8 @@ static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
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

