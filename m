Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A317176322
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCBSsD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36375 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbgCBSsD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so792343qto.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lt3R0PwHR8RzOkN8CpItcScVihBk66gzuAVrELTCWyM=;
        b=fymMPgrEl3f8Y2LfyicuVABEno+4f369M0f9eefWBQL52dfvCvmFQiRLep83brkAYk
         h6EcVfvlCuFQxckLc/hlh2ShEee9duECAPB9DZRjm8JEqX4Uqka5huvmmis0TcTgPtTs
         kAaJLV21XGeLkJfUdiUZ3UwfA9A+tZloBFAUMHjeNST8d7YDNkVnn+jT8QkxlP3xhzVb
         klKf33Mz2fCGqTw1Ile1kLENS8rhULS55/Rwziwp84jfChN5QVYG0DQZrGU28+oxQ/hO
         lLkj4zcfOo3t9RdYhJTJFoA5bEnnkkP09j79fxJLfjLROzoMPBBvEMRnF0z+r7SQEBuJ
         Fm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lt3R0PwHR8RzOkN8CpItcScVihBk66gzuAVrELTCWyM=;
        b=liRKwW1qmUvrS1Tv+UfUrjIUM7ahUYKn+iBnJuU1bUBGfYXSCcszkaOZDiFGGwjRYW
         YKRvWmzDWgBDnF/UuSB0znf05faTSonvE8EE9QAZRttr+zfe4l9P6ms/2YrFUmzIeKvY
         lR3CZWzzb3AZX1sXQxo25y/Zcjo9SHYcRDQR2RXKeWavwB0eEPnBoTM2oYYOAn1fj+H5
         VyzEgBwgSQXc24/zirlrMv4rST8Ye0u52D7Dz+znusc5KrYy9m0b/a2y5gqYw5gstyto
         aluuXBYGqWkZUAapVIwpXxrPZWpK7QKkFISzmeirxV2dZkfDNY4haKMl8Wux6dU4F8lj
         2ROw==
X-Gm-Message-State: ANhLgQ0VbiDQdqQhHseHQpYmjLhru9mVOCF2w/x5cvPGdK3BEeLEm0Ov
        fjxhEYJJgQPrpIN5htxShyDx8RqNZYQ=
X-Google-Smtp-Source: ADFU+vuBiH7LKoUwA/Fzdt9vYoKwQyh1ogRm2pwdSb4nY/L72FiDwZnPgAR7yMkTVa2SEOVpaAcwvw==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr1016754qtu.281.1583174882088;
        Mon, 02 Mar 2020 10:48:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 65sm10797701qtf.95.2020.03.02.10.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: drop block from cache on error in relocation
Date:   Mon,  2 Mar 2020 13:47:51 -0500
Message-Id: <20200302184757.44176-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have an error while building the backref tree in relocation we'll
process all the pending edges and then free the node.  This isn't quite
right however as the node could be integrated into the existing cache
partially, linking children within itself into the cache, but not
properly linked into the cache itself.  The fix for this is simple, use
remove_backref_node() instead of free_backref_node(), which will clean
up the cache related to this node completely.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4fb7e3cc2aca..507361e99316 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			free_backref_node(cache, lower);
 		}
 
-		free_backref_node(cache, node);
+		remove_backref_node(cache, node);
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);
-- 
2.24.1

