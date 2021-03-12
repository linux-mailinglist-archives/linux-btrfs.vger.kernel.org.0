Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC06339856
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhCLU0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhCLU0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:25 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C796C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 6so4829882qty.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1uEgOSpXoD2jR96iEnRQSqCDRpwYRl1rnc/KDZZlLo=;
        b=x0pWYXUNTS04QiBA9YeuHplp5zSLbkkASju9tDC9cykoiutJXX9ZbCK7NZEEDKg3Ya
         xw1/ticop59RXiUp3mzd1M7ae/vsmZy3CTy4JkusCb1uPV0AJpcdWfd1CuENoDWHD74v
         xUF17ThutCTymFD4/KnxrAw+A3f34WoFf5SYERxTGwgZT+UzOYqRnMFzIXr/x6gyyRrX
         QvenQB0ne4y45eZ2xK4S1E5YRQ53Srq+CU0IpMUDkj6wiTfOuZlJjMihIUdvDuhzBCz1
         GRO3uGtiNUAD9figmGC1hnH3oIH3LriJS8zKPGMTVig0cjRxl0pcqBGXW30AwANsvOVT
         mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1uEgOSpXoD2jR96iEnRQSqCDRpwYRl1rnc/KDZZlLo=;
        b=EUK2H0z2P4Vz0fmlO17c/re/0mnjfadBqGDkIMMZZyHAhcnRYUxSl8tLV+D/ddIaaB
         8Z47cTos/mh8IWOlOghH8NICUs31FSfEDSh4ovBt3nQrL/Ps0oj1HBmYsJUp+LR1c7vr
         Ow64FvvJxn6I8isWh6VS4HpPmP3eWuw8N/zQdOxDIgMeLmUirzLAy2crUx8yha+blDyN
         ZNiNBVHcfDphVNoocscmy4qh7EK/MTrRjyOVMDx/3nb+gPaqkQIQp1jGEALPVdvDwnQW
         HLN1Nppd0WCQPXFXYgRrtUHwM7EP7kmAL6PkTN1O8frWrvA+JFnj7DZD31/YiTjNnfrr
         ryBQ==
X-Gm-Message-State: AOAM5302h5fU8HWnpsf/xm+p6N44EQCMt3cYt2NLMWf7PDWpzd/NQNLY
        qBqCF1CuncK5yGB9C4n2SnMLXXPFo7kml2qH
X-Google-Smtp-Source: ABdhPJzWJdwHZ2TGSLuBDPVJr7lKihixFOUeThBX98jzkNyqmt95IIwiqMPlJpbAVO3nSg6A5aQ+jA==
X-Received: by 2002:ac8:590c:: with SMTP id 12mr2421979qty.291.1615580784170;
        Fri, 12 Mar 2021 12:26:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d70sm5312673qkg.30.2021.03.12.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 31/39] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Fri, 12 Mar 2021 15:25:26 -0500
Message-Id: <d6963a2bf1e8a8711bc18bca954fc95e5eb9fefc.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f4ade821307d..8e5926232d1e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1290,6 +1290,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
 	}
 	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
 
-- 
2.26.2

