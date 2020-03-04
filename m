Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74A1794DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbgCDQSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45988 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbgCDQSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id z12so2144137qkg.12
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vMlEv+ThwTDRGC5bEBvf0GHUwzFZBrDT7i4XBc7/BqI=;
        b=wY06ozvDM0IgWMl6DIMqyNsUxcGPwyPZA63sG8qPjcwSLsF4r2o8+Rwv5DFj1wdXww
         iQ3I7qQth9tOMhOVDzePGO66Zo1mAMuUWDF5vzgGCaJQwTLpXPNiHlm7a+ZpcD+YJjeo
         EuaWhjFpiZzRvzuQoluaSH9q+0qhm25e6jHyK6NzTweXYbeleP+vuBtJvxqITrz4zXTH
         LA0/aPUP8ej8vb7u/JmsW7DSC+N10xfsaHGSaigPNXW08SR0nTcwVcwSDy5x+HhxC0Lf
         QRrDDX47rYi7KUeAzMWCx0/ZAnh9toMGujhWzs9wR9MlmXSVwqnT/9QV2BwDK5kAz/oB
         SFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMlEv+ThwTDRGC5bEBvf0GHUwzFZBrDT7i4XBc7/BqI=;
        b=WP6hRJIzY17OSp27N+xbUmiZsyuIg6toEuF8cbhW3uGCVA/ZEN0XBYcei/J5iSYNmc
         T0tXSIWRlmXFLr+Upsydy/gdoW5dpiyReRZfqfI61i2SSAcEn4sQHO2CeCWRi+aJYWMx
         IW4zfDSnHNbfsh5S/IY/jxjOJOsQkgxSKVZxU3AaPMQv9K3FRvkoLVR1p+FCmJU47xG9
         WzVaxI0aTYOIEFJMGPiTACtNLq34wjXhdSyKkpeiasGxtoPs6oe1q5i0dxyDzz31ua5a
         doz68xYsqY45rJ+kGZBEJFw4Oq/jplfjhMVHq3z8DqUYk3sf7IWFTKXt+pMWskkEUk0x
         U4pQ==
X-Gm-Message-State: ANhLgQ0/+xQonc/EtbyjFYt7IRXs/j2YPJjofMIIUKeDeLYqYQph4VjY
        nqKFPkKxmweP3nw+cNG16+TD0p4ip9M=
X-Google-Smtp-Source: ADFU+vtEAAlCBpEA1Yzzsk1eYfPcNIumpTA5qCJFMW84nXfwNq0Qb45aqywTCK5ILX6F12wGHtMbyg==
X-Received: by 2002:a05:620a:388:: with SMTP id q8mr2718596qkm.488.1583338721845;
        Wed, 04 Mar 2020 08:18:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g2sm13959356qkb.27.2020.03.04.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: run clean_dirty_subvols if we fail to start a trans
Date:   Wed,  4 Mar 2020 11:18:27 -0500
Message-Id: <20200304161830.2360-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do merge_reloc_roots() we could insert a few roots onto the dirty
subvol roots list, where we hold a ref on them.  If we fail to start the
transaction we need to run clean_dirty_subvols() in order to cleanup the
refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f6237d885fe0..53509c367eff 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4279,10 +4279,10 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		goto out_free;
 	}
 	btrfs_commit_transaction(trans);
+out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
 		err = ret;
-out_free:
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
 	return err;
@@ -4711,6 +4711,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
+		clean_dirty_subvols(rc);
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-- 
2.24.1

