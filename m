Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8E47637E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhLOUkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5742AC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:13 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id fo11so202389qvb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UqjAMkl+fiEY0/RLOfIVh5xg1AbbnkzlATWyKv6TVbE=;
        b=u2hCsljcnKx8ez48hscGqSoVLTMAxAsrCLa6RA/nxWhm/wduSzW9Wqpqa4kAdgnU3l
         Yd8X//BHo6keNyHq5L1ybXS68nu0Q6M/e1PizxJpwdCZWdnRAdMHBxKm94Go7gjJf5Iq
         hMc47osG6opmAqKE/5PygjsD4CMiKgoMm4Y868dLLLqAtQyd990fgrFt7Ttn7kqUsC/T
         ZfOF6emE2JAb0D/+ssIoZmxn1/nHpRHlFufizQeW/Q7/xxXSJYtRalAuU56NZqN4/NQN
         cEmvnhnmG5jefvRSvk6ecZf4NhoAUybrEH0KyzXNPtZt6wZc9hHM2JcKHYImQ6IjSMV/
         7WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqjAMkl+fiEY0/RLOfIVh5xg1AbbnkzlATWyKv6TVbE=;
        b=owYe1+VAo/7pym9T6WUIB5+1OZ3rwf9ck9dznFzvocPCOq7giCEf8b05mi9MEYF/Ve
         D5eRTbVXB6Y06fXZUnpm55gutMd7XOYx6vVQPQ4roZqd4yfZWBp3ZN8/3B7MmdZi5LgB
         k0jDvPzlRp6vKJOKB/epRyMTU+O6rp204PDLKWxdJ0xNjOTenJnfhaoOQZu923MShzQi
         3el+sUdlbBmj2bm9wPutH9k3tB+wQIl54Twq2BZR2zsiOPbdZ7tlujop3JEC4e1pKUpN
         5/CPF9sqUTRM+H/3J4BIoNaQt3U/yucfSHf7FRVzjl6rajzCLxfT0nuwjsgK+Lu2Nq4v
         T+qw==
X-Gm-Message-State: AOAM530cyg2pEC81TsAgm9xV6OFZO/y7G6+/m5c9viMuhmnt7FYOmB/u
        iRAf+8lvIoQqd94rNlmrutkMQhD1rParGQ==
X-Google-Smtp-Source: ABdhPJw/NSCt0LcM2v5aHg6un3o9AM8acwyBQkLeE4oslYi4rcuivXmun1Ws2tfx0zkCp3mG0aG2bw==
X-Received: by 2002:a05:6214:260c:: with SMTP id gu12mr13255448qvb.87.1639600812265;
        Wed, 15 Dec 2021 12:40:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a20sm1615379qkh.63.2021.12.15.12.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/11] btrfs: disable balance for extent tree v2 for now
Date:   Wed, 15 Dec 2021 15:39:59 -0500
Message-Id: <144832d4906cc756a17190b5a045cb7a92a79573.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With global root id's it makes it problematic to do backref lookups for
balance.  This isn't hard to deal with, but future changes are going to
make it impossible to lookup backrefs on any cowonly roots, so go ahead
and disable balance for now on extent tree v2 until we can add balance
support back in future patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a7071f34fe64..802bfc63aa21 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3253,6 +3253,12 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	u64 length;
 	int ret;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info,
+			  "relocate: not supported on extent tree v2 yet.");
+		return -EINVAL;
+	}
+
 	/*
 	 * Prevent races with automatic removal of unused block groups.
 	 * After we relocate and before we remove the chunk with offset
-- 
2.26.3

