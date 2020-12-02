Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA92CC723
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbgLBTxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbgLBTxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:17 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBC6C09424C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:31 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f15so1958975qto.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qhokq9in10lp163pHnGcT2VBA0zMfVv69pIfLJBBEPo=;
        b=0yoWQoxQh7+/iPkNROyNew4bdvYqoWpWBeil8BpnYvSqBLq8adTkzteiBdV7tEBIPK
         wjIYKcVcat5LlPYELlINYLovcIo5kuLSjE+7I4pWKqHFsB6S4EDhqlIRom5dFMGGa+lA
         xr397pv1bkGbRRpU8TlnUGzKgNtUZ8F23bF9gO0qESBPjvhAW+aAhTjXY8Aet9e3twhg
         06I7qc1OqkfhBZ7E8zzhh8q2PvQdCSYZtT49arh5vhRVshLd1Vz/VJDtvpEGQVPHRLVn
         UCsWIaVZN6LOcnkFav4TF/cGdgwynWINCSDCasfb51FrP5ccjTG9XGhdcH6D/Ul0YA26
         Aryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qhokq9in10lp163pHnGcT2VBA0zMfVv69pIfLJBBEPo=;
        b=ZDSPlonBlZZRDtZ6sqYRrSFMALTFTkahH6r/N/9CQd1295Q/o4kVflxhcrW3Vg5gIY
         ny7FDTBt+uJN5Lwgo8XBTDP8ZnjadS/FcMqImIC8Ogu/vGfvts7FPoePdFJ+UOO9pIA3
         h4jDWmyhCl13T27WQvKGbwIUMKp3F6elcsMZ41dXWOsgy+/0M8V8DHjKbv0S13wrUEtj
         CuUZZ+gTkjyIIsogbv4WA54zjsyQvRfSdpfZhqUvI0ph8SLYmSrgMYoUcfYnKDwn8OqQ
         zSjkfMkT64JGtnqKu+gXSf1JgP1JHhMkq9TliUqIw9VEcmV6jM0EttiUwUjYiCCuNorh
         dKUQ==
X-Gm-Message-State: AOAM531FH6Dyop0L5Vntk8ZJb+2jTF9fWHtYiUNkQBDWj6I0xSl0SoMm
        tqv3/ONNrtzEVaN28UDctfuH+/pVz1EgjQ==
X-Google-Smtp-Source: ABdhPJyhUimQ9uTbfvNCRylI6cUv1EgK3F7tCB87FySOsDgjOYD+0X/2P2o4Xoez3sJoToJTVawdIw==
X-Received: by 2002:ac8:5197:: with SMTP id c23mr4311603qtn.202.1606938750282;
        Wed, 02 Dec 2020 11:52:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h26sm2888919qkh.127.2020.12.02.11.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 42/54] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Wed,  2 Dec 2020 14:51:00 -0500
Message-Id: <cf522824a3a16e2186b43c5336b4d99cd0cd4d19.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 028e733e42f3..39714aeb9b36 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1283,6 +1283,11 @@ static int check_extent_item(struct extent_buffer *leaf,
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

