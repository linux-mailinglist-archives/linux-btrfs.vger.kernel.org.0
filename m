Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1601211762F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLITqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36993 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfLITqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so936370plz.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F14OZFzQXvrrV4g8hdVBekK/FaE5I6IU2gcfkyyyj9M=;
        b=dWjoevsSR6SM9mpaRkp4NV7X6wzFiL9ad77Ov5IDpD2gZtT/za3r5kEi8FkUeMRNmj
         mgU339e9IABv8XFaRJalTtGWmiMwHv8dMD0nmS6Nru2fzXMuHmU70EfZMjecOalOkGSY
         HPQs5w4lpGw+lSLuv7rOWKAYpKEVRAluvsjm8VmNBl7m+EusAivjT3Nj+Glf6QRcalzN
         /b0pPGw1Rf3K1OM2y2K86lauc540vD2LPITU8yS7GoLCiUfKZJbafYZ/hl2/0Xq2y0DL
         3a4CKD8SDGz7mykHatlbpDqHY8LrmYKr9L+ucr/v3RzcamFbytTzFv1xoN3CGTRWS2wa
         1Gpg==
X-Gm-Message-State: APjAAAV7F5CWOQ4sNw4gTbb7A6MfteibAH/1SX52Z3FqpOZhWhj+a2mR
        4ytlkqS8CYa6q4D0/0TbOLI=
X-Google-Smtp-Source: APXvYqwDT5F/8vs4gq8y83WnvoDtgEfdLw9PdUKUMNFEeeqEy8UT5lldgkYlAe9ovIz0mX/xQCGjRw==
X-Received: by 2002:a17:902:d68f:: with SMTP id v15mr8441406ply.95.1575920793966;
        Mon, 09 Dec 2019 11:46:33 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:33 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 22/22] btrfs: make smaller extents more likely to go into bitmaps
Date:   Mon,  9 Dec 2019 11:46:07 -0800
Message-Id: <ac871c707edc1c281e07924fed610b885c5243dc.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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

