Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189D314F4D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAaWge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37476 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgAaWgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so8242285qky.4
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CCJGAmj8zhaN6UFv+rbjnkqAKaxFdKlrvRJCkn7m3c=;
        b=X7Z+GDQPSbNCRumXH2mo30ChtBFTqUm4sl51iNwh/hMR+n5fPEEGEuzXUbs4frrDT2
         OcWvPnEX0j/bUNK/qqtJBxuEU3BQqG5uvAcVTvm08/TzBHogyxFe/jWdojYPNtVGSDF0
         mhquPbrFqzsxwGP0nJdgCCf+OE5Qb2r3uD8/mguLyVWCNCI5o49PWnvZEwtRQAn0zIKV
         RmFeg9AYEZLWfyE4+zMiNVDAe/GoCT98efJDEQaTv9AcPAAWpKMzbzaTtQn2vjcuOD9L
         RNE6orAlfQvcjPaMbfvI85RvI7hMyPBrc/iUY1g52J9mSadSKi2moeyyGMEF+Y1TMdjQ
         pvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CCJGAmj8zhaN6UFv+rbjnkqAKaxFdKlrvRJCkn7m3c=;
        b=N2UzadeSbLJHW/1KPAcGN6YAKrzQbZi9Q8zd/IcDuUCMhLA6u4U9Pr17uCAhM4rC0c
         h5fi7eNvk3rfdFxxmMfA/WVoQe4+btvn/4WVGv3VnBuKk3EXQ2gr+dn5cGqmS4zzawgu
         c1zR2xiRs7MyM01wRnjeDN+4zO3kD8guX4oKQuIaUSTWURuvNzjg+Op9aWibsLeo+sAy
         l95+Bb8Tsj+hJYfYfRz3BHntJxF+EZOyJ3cm3NzSwjNM3fNEvz8d4kCU63ji+6exoToS
         sOELr/EgHJaaGo9KgINV+N3h5D8qHgsjQigCvH9GAVjZ28T7f0w7Ur1ahgJpEm8azG4d
         64XA==
X-Gm-Message-State: APjAAAUPXdNHQPK8+SAZTmcybYsoREK1mr7i2ouUHze6NBc3uwFIb17V
        CD6Rufd1k1Kke+ByrZZ5QUy55pw9neirag==
X-Google-Smtp-Source: APXvYqyW7DOz5Q1CqB4Wy6A5G0PEuKRiqr3Q06at1gsMW2+IqTXMhEtwdzb9J24ohuA4YwANcdeVNA==
X-Received: by 2002:a37:274a:: with SMTP id n71mr12604517qkn.302.1580510190678;
        Fri, 31 Jan 2020 14:36:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h34sm6001285qtc.62.2020.01.31.14.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/23] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Fri, 31 Jan 2020 17:35:58 -0500
Message-Id: <20200131223613.490779-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have compression on we could free up more space than we reserved,
and thus be able to make a space reservation.  Add the call for this
scenario.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 616d0dd69394..aca4510f1f2d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2899,6 +2899,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 						      space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
+
+		/*
+		 * Compression can use less space than we reserved, so wake
+		 * tickets if that happens.
+		 */
+		if (num_bytes < ram_bytes)
+			btrfs_try_granting_tickets(cache->fs_info, space_info);
 	}
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
-- 
2.24.1

