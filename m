Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7AA29984E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgJZU5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 16:57:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35969 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgJZU5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 16:57:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id r7so9782796qkf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y9JdjpM4anMcNe9Rm4u/VZMVCiw0d5EcNQIWvf6Jupw=;
        b=E2t87IDfDQiaUBZ3/yUmZnhUDu3M6kL4kkABbk1IYE7tiNnMrUvwOkb8refhBVWHSj
         +OV0bEGjF64oSHdswpqN8NNVb0uwxiz6QaqjCYvGk0OwfBYXlLA3xdnx9HvnFqCW9gzb
         Kg8HF8sLHGXXI8eV2+58XJ1TG2AxuuG0QDfJHL8SjcX9webkcNMWi5vDdp96Zs/Q8EUS
         O0QR+kF/CC+g11KMQVTojeXRD2+UMP9cBBLK+pZ605f5C+A/HA8P8bCjuylYFwh+rmU3
         jxuW/zWFZlYokXbRijyg8c8i7tw5X0XZdU3tiEW+jL2MOuGAQrMvqJSI69E2cTgZ4GY6
         qmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9JdjpM4anMcNe9Rm4u/VZMVCiw0d5EcNQIWvf6Jupw=;
        b=RTenGlcGKDdLlQoT1BPgN5ydKsX3px4ueRPaqsdbnmsrZzAIQtWXMggjuAopQlSIBW
         zgdweDVA2PVXd8/k51r6tTX+HA9PjK0wuiakXY9QF21f/KvPPQ2MFWSK6SwPWA3Xf6J/
         GWp199yUVDuXUQQvuNG+jZNOIw25wbEtUs3thfNN2YD5gu8mExKIcqkliGn2HPnuye5K
         e7UwrUaTQz/7mG0bXf7/7BYmhclE99jkfb3s0XqGvh+oVI2jgT3fiFx/LssdlIfL9j2j
         n33XKGVWG5BA0V+t2bEFSfqKipAt3QYMAi+goTjM2HJHtHu4QVicdisqvrpKsFAsrKw9
         X6iw==
X-Gm-Message-State: AOAM531mzCbwTMmvqsDh9XCmndgnjUVwXJG82JZRBM68fJxUnM7kubl2
        pYa4rqRJzcGg8XfXGaO6r3x2TU4l9QVyAhl9
X-Google-Smtp-Source: ABdhPJw3+jImnilyXgwQoLx/007zAiY/i+Va2dcyWcqiOTP0h7zBmCUkZvszZIxHeNDOMPVGL7Jmog==
X-Received: by 2002:a37:a38b:: with SMTP id m133mr20533259qke.45.1603745851634;
        Mon, 26 Oct 2020 13:57:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s14sm3052671qtb.25.2020.10.26.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:57:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: print the block rsv type when we fail our reservation
Date:   Mon, 26 Oct 2020 16:57:26 -0400
Message-Id: <d3568eaa428026c8e144f253a341e77cd7b7dec6.1603745723.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603745723.git.josef@toxicpanda.com>
References: <cover.1603745723.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To help with debugging, print the type of the block rsv when we fail to
use our target block rsv in btrfs_use_block_rsv.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 4651f8bf890b..04a6226e0388 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -519,7 +519,8 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 				/*DEFAULT_RATELIMIT_BURST*/ 1);
 		if (__ratelimit(&_rs))
 			WARN(1, KERN_DEBUG
-				"BTRFS: block rsv returned %d\n", ret);
+				"BTRFS: block rsv %d returned %d\n",
+				block_rsv->type, ret);
 	}
 try_reserve:
 	ret = btrfs_reserve_metadata_bytes(root, block_rsv, blocksize,
-- 
2.26.2

