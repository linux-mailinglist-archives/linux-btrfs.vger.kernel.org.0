Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65916117603
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLITiu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:38:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37012 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITit (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:38:49 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so6316108pjb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:38:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BQoqx+QQ10btEuvgKyeuNujQayQkYNEsqlTh4A9qAUQ=;
        b=tmoL0R03ttmI5x2vGMKcnnaeIrCoZxTeYZtzhUnf6sjHNzv5pQG4/QIidWlAqyAOd8
         UvFOxOIQVSvkbOcPDzfarKMDqXTDe3eVlrl3VH5pHo7VmDeUKO5pr2hDFa3UtjFnMh3S
         6RLufb8MREkSIuUQwOdrNE4RR9Qa4+Nn8ydyOOrDvxY4s8T2xWySgz6JonyAM+TPURAm
         YAC7FMeF31zI+NvDCOjXC2vBVe5AzUGIQGsj/ityJKXE7o83BjGADdNlx6k2LxLnRzNM
         VaDon3wzW277BKroXQx7T+TGy2oisVU/M2cQE1DPUvBzuidD9kkMy4evUs52YJ6w6BqR
         ga1g==
X-Gm-Message-State: APjAAAV0DpRtIJBnXkHyop96Xb3NnUgQRGqFw+v7PEpfw2VDbHKb/7jz
        89D8qf4mgL/iYrC1lFMOnxQ=
X-Google-Smtp-Source: APXvYqwDdnsSCIi9TcUKZps3/93xcyj2AiOEFqf+97eJmA7kMIRzSF444KAngjK1pMJiip4fyr2VCA==
X-Received: by 2002:a17:902:aa8f:: with SMTP id d15mr28782768plr.276.1575920329056;
        Mon, 09 Dec 2019 11:38:49 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id q11sm265359pff.111.2019.12.09.11.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:38:48 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] btrfs: discard before adding to the free space cache
Date:   Mon,  9 Dec 2019 11:38:46 -0800
Message-Id: <20191209193846.18162-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Returning free space to the free space cache lets it immediately be
reused. So discard before returning the free space otherwise we can race
here.

Fixes: 55e734b728c0 ("btrfs: Don't discard unwritten extents")
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 625439875299..1ab13943cdf0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3250,13 +3250,14 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		    clear_reserved_extent &&
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
 		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
-			btrfs_free_reserved_extent(fs_info,
-						   ordered_extent->start,
-						   ordered_extent->disk_len, 1);
 			if (ret && btrfs_test_opt(fs_info, DISCARD))
 				btrfs_discard_extent(fs_info,
 						ordered_extent->start,
 						ordered_extent->disk_len, NULL);
+
+			btrfs_free_reserved_extent(fs_info,
+						   ordered_extent->start,
+						   ordered_extent->disk_len, 1);
 		}
 	}
 
-- 
2.17.1

