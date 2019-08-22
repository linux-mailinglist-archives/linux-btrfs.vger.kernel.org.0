Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8837699F7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388098AbfHVTLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:10 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37699 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbfHVTLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:09 -0400
Received: by mail-yw1-f65.google.com with SMTP id u141so2850716ywe.4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ew4qcK4M0DxS6E8NTsrjj5KHfKdh869Q49UUyA+3JWw=;
        b=Ybh4hbKNQdb9DrpV6fg8yjTaGiTq7FH1priJmCZwH2G3crWet/hlhFoWH1mFPqDbDx
         /iMmbzcMLyZ4f6av9Zh8kYfzMsjU73H5Pr4WbJv2AQ8WsXHve0nuwxuv6CdiLd1i2fge
         XbnjSmB+3ajupbMnBDanvrFDUTRr6T5S0yPxIZjppL4pLCc9LdTByuMeHvgpaj3TyHF1
         fyW9At4omTB8GnuLmcOFw8CXHBlV5hRWu6iOyerAA+51bH/nPTcLScC71TlFj8OAe6ua
         FS3CmyH+6FbUziKnWK03gh1bbrtzD889Y+GlDp4yuOnDPU4ZMOaAUxsJ2CZ/cBQOq1q9
         S0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ew4qcK4M0DxS6E8NTsrjj5KHfKdh869Q49UUyA+3JWw=;
        b=mKG7bx8WBfAM6Qg82dKPNJIPudt5/2BGlG0BnhffcR/3luIU+pn5P3IOoUAsh6GDqm
         sX+1AHe98pQPsdTtiT3f1P2CaeaHtDM83E/XLJ2CoyMgeG7Bu3jwidi0zaOSoy3dJn7C
         ps78H2924Jv5LsB8RomMfwKAluwoT4kjUNHcH1qVdCovK0Pb9a/g9fGZ5Y23Wi4uZ97y
         q+zVVYXBcgBAUZZdlbV9OPDKzgsBKKz3mstfyHqAEgpt4UtYiLs1y3LHcdMVX6ufxUyw
         npoFQ//Tbv/USASGGfcgHrJf995heCIe0PDowbLei8qWKnkiGTgwcNkxo9npEAE/DuDJ
         g4Ig==
X-Gm-Message-State: APjAAAVWSKA3HH7KGs6NEsGD26dhQtKw23GkEva248V9/2NPUUMvf4D3
        WIh7Ts721fw/CWuX+jARxcVv0w==
X-Google-Smtp-Source: APXvYqw9JLXD+QVG4bciN9T1ldEtPG2fpxHBA08hqV6SC5SDfkxXala60ps9BXZQHXPuQd3SQ/T44g==
X-Received: by 2002:a81:67d5:: with SMTP id b204mr675938ywc.416.1566501067518;
        Thu, 22 Aug 2019 12:11:07 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k67sm126136ywb.68.2019.08.22.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: do not allow reservations if we have pending tickets
Date:   Thu, 22 Aug 2019 15:10:54 -0400
Message-Id: <20190822191102.13732-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we already have tickets on the list we don't want to steal their
reservations.  This is a preparation patch for upcoming changes,
technically this shouldn't happen today because of the way we add bytes
to tickets before adding them to the space_info in most cases.

This does not change the FIFO nature of reserve tickets, it simply
allows us to enforce it in a different way.  Previously it was enforced
because any new space would be added to the first ticket on the list,
which would result in new reservations getting a reserve ticket.  This
replaces that mechanism by simply checking to see if we have outstanding
reserve tickets and skipping straight to adding a ticket for our
reservation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5f8f65599de1..33fa0ba49759 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -993,6 +993,7 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	struct reserve_ticket ticket;
 	u64 used;
 	int ret = 0;
+	bool pending_tickets;
 
 	ASSERT(orig_bytes);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_ALL);
@@ -1000,14 +1001,17 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 	spin_lock(&space_info->lock);
 	ret = -ENOSPC;
 	used = btrfs_space_info_used(space_info, true);
+	pending_tickets = !list_empty(&space_info->tickets) ||
+		!list_empty(&space_info->priority_tickets);
 
 	/*
 	 * Carry on if we have enough space (short-circuit) OR call
 	 * can_overcommit() to ensure we can overcommit to continue.
 	 */
-	if ((used + orig_bytes <= space_info->total_bytes) ||
-	    can_overcommit(fs_info, space_info, orig_bytes, flush,
-			   system_chunk)) {
+	if (!pending_tickets &&
+	    ((used + orig_bytes <= space_info->total_bytes) ||
+	     can_overcommit(fs_info, space_info, orig_bytes, flush,
+			   system_chunk))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
 		trace_btrfs_space_reservation(fs_info, "space_info",
-- 
2.21.0

