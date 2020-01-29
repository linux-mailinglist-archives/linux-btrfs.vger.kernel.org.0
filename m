Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1DD14D401
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgA2Xuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45288 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA2Xui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so1149232qkl.12
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XZ1Jx3Zqu1mD3sig1ehd/qr4KMIp5U8ozP74u4J0V9w=;
        b=d8eMIOnYMCJhYwaSe6g0/GtOXP/y9WlI9P8tHsRZwqjmufmTVJXTm3JPBsu+vSjA03
         QTvtHv4cgdudI/QiSExNKpBo2wk7a7cnFeytYfi1cJewfySh+wNn2+8ptyVt1ordakLS
         NrWQ3le383W26X3QMyvVUMNRRa1ySrKZmU01QBdUmuKYVTyaO2hOQ2RlhF5fUOlg73z/
         qUXCaCL/DvyoCYxTXj6vnRhr+/z/tNuj+xVThTz3QQsSgqCKBOj0KK5VgmrhHAM0mdp1
         sc1KAVHM+CuBxWm4E4vr5OBoNneXNUhGZlXaq2Pt56jnnoYBAm8VDASBIku4TKnbylNd
         pFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZ1Jx3Zqu1mD3sig1ehd/qr4KMIp5U8ozP74u4J0V9w=;
        b=MAJrWhAy9h+SHsazacriJn78Jo5e8osPNtgZBxPWonYd0dQF6/KrB5QxNblubOsEwW
         fv/UsJN1k3N86LN7ox1NxclgvFSuqN4GgpHbuYOW/1aMPHoa3oSImyxGvA7gZb9fI2rk
         DiT6H6iO3TrCk2b8BPm1Wjeyj7muwrlLNkt5/5Fnhw73FrJHBfTmXO+byfB3H8ecLFZM
         HpucPrbjPvCyLgTDPhY5nXKvTFIJtInqOEZkdYd1taByDN7iBy7vEl1zSOVE96MZdTNO
         lW2CFRkyWFVh6YLWvfIowVd+CnSwYVwmERkpn7UN1IlyoJjf7uVhI6D39tTNvD2mkihT
         JLfg==
X-Gm-Message-State: APjAAAXnrc7H6ZJYR0TmgSTEZ9+jsTgN5GtVq66z8wk58ym8T6QUI1Tb
        ZMIi0depPIX+UAVdyswmCYlRzxnqxVjFOw==
X-Google-Smtp-Source: APXvYqx6ixS4pBzZIE0D4EfhFG93i6MIvOpoq/5d6UDNVnt0u/f1H3eStymuTlN3b90Fc0jtOOFX7A==
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr2295678qkf.407.1580341836220;
        Wed, 29 Jan 2020 15:50:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e2sm1850735qkb.112.2020.01.29.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/20] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Wed, 29 Jan 2020 18:50:09 -0500
Message-Id: <20200129235024.24774-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have traditionally used flush_space() to flush metadata space, so
we've been unconditionally using btrfs_metadata_alloc_profile() for our
profile to allocate a chunk.  However if we're going to use this for
data we need to use btrfs_get_alloc_profile() on the space_info we pass
in.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 17e2b5a53cb5..5a92851af2b3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -604,7 +604,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
+				btrfs_get_alloc_profile(fs_info,
+							space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
-- 
2.24.1

