Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F8F2D2F6C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgLHQYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLHQYp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:24:45 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893DC0613D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:04 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z188so16421510qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMa7bV9M06CL/jmsCalzp9jQP6wxpAhOdiQ2gxt0798=;
        b=Ncg/4UArxyhEnZD9J3wptTXF0pAT68y2RWknOnHJYOYznCLe0Xwhri5KwKsB/AfOJS
         KeYSj1BHLbF1QqqkK+xP/GYicEq5qk6qhucgfJg6PTm5HOy8cNC0xzfYGt7YKBYquIAQ
         Vh/pvrc3rVywGWski76AEZb24N3cVHO8yt2W7BkEG8ESrYKy1X/rVNWeYV9pEi20tovM
         nGLeuCKv1LWb90hw9ohorubDdhGgR+vL7RPOuflZ86H8IU981gkIXfu5bbPfp+iI1XBz
         OT4qUAmeaoXmruNNVbTQ0B6m38C1mGc7Ou35czwdNQANbmcSeD+FyI4LXxYFt9SiXqxB
         cFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMa7bV9M06CL/jmsCalzp9jQP6wxpAhOdiQ2gxt0798=;
        b=kEFV6rKajNq0JgDPUoStSnTvnzw+Y0jSyiptx0YQ+ke4H8UVSUjxdnMbdz9f289215
         aNEz7V4uUfmLHng8R9I3cF4qfCYG0CGxWxkSl3S+b56KyujKVaWgPSHF+hYKGant8oZq
         ADC7TGYGukZi4hJ1UwWVoM181OT0tphkofAb252lRZobRgbVyTk29Nr6ZEoNMtV2Uauq
         6K39OkBMkzZ9qztX/frsnU83GA6u3HdT+U0hbS40A9FRPmS14AY3WjJSRYCkiGbouoty
         hIcXcP+9n7axMD7h4NiONv8+/KxZNvsIKf/Md6WirAZEuJpOXi4kwqnAooUzVDP4cRHV
         TkIA==
X-Gm-Message-State: AOAM532CWRJVAJL92Ux7MhxJkQLRdSP/IQoY/UqYHA8oTqcOAt3YWeEN
        1BS2TSAWft+8jzNX/OzJ5n0QrYe033k0exqm
X-Google-Smtp-Source: ABdhPJwU8dTzKKUBuPGgVmG/8B2/Scum4XP6RZJkkh7DlbaR0QWKE8K+CGRMNL5T/1r/2mMqc3uSeg==
X-Received: by 2002:a37:66d4:: with SMTP id a203mr30718606qkc.362.1607444643673;
        Tue, 08 Dec 2020 08:24:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p27sm14231877qkp.70.2020.12.08.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 01/52] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Tue,  8 Dec 2020 11:23:08 -0500
Message-Id: <19dc35ed62b15274a23dcfe78639d18b1cf120af.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cc89b63d65a4..56e132d825a2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2821,6 +2822,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

