Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4929951D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 19:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784029AbgJZSSN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 14:18:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40900 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784008AbgJZSSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 14:18:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id m9so7413863qth.7
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y9JdjpM4anMcNe9Rm4u/VZMVCiw0d5EcNQIWvf6Jupw=;
        b=wHk5XhaJGXXU408Te6V34PielcLuITbUIfavnWupx6LoENByZ3c6Iufrgz6pkI5Lfq
         dJqsHRPFlyOg8JQvFxYOAoJSjkIGsTqbsw2sd9J3cXCjyihAhs30+On8yPhK7hXZx55D
         PnWj32a+ye7nztXKgM+Kygba31oncMcUqfPoC0bE4YLAVoZlh0/Grn/0DLRuO23roY5g
         iCwM2LD8gtfbR54hwisaz8cnIpApoT72RRhSH8JCHA2FbAjaDpOuXbnTLScJgCFuNOKv
         dwAoYGRDMQIZLp4NZFSj//uxMZg+JWF5csk36eIyuZrzMZWOuAV+B4JoHYwvxXnxeXWu
         VnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9JdjpM4anMcNe9Rm4u/VZMVCiw0d5EcNQIWvf6Jupw=;
        b=LK8tFh4BdADb55The9kmrQzYMvlySklH9G8vFONRtTp2luxUCWIIVOZ/9dcwR/Z1F0
         7ryVWOe5ZjoAXYNvWSownt4AFFCeAQd92b2ebIMBGxr5gW3Om1cw5lJ7ybq0Zlfc5goS
         D72SXYkB5aqSIGfK1rhP5Hr4uEyTc42PebHSJLmppB3IKbRMq2A+XItBxdaKWfNQaLAz
         WUfsVzxpnC0u3/OkKc5COF3miRbkMS/ZVpxUCRMRTKt9XxoiqCPxdXIskas6NPsrGi2g
         DmXcH8rxHt2CVnwdHeuBTJoW7tXzL4+/ejGE3psKr8BFQzxGQFGEVuvEbDDQ+/TFFIhW
         n5lA==
X-Gm-Message-State: AOAM533krPpjWBrwMIoqMFUPuYZyq7I6jiOw07kporCnvx+G7LUDbPcW
        hlXYnfWQCrdP8Nfqb/bmrmrtmTmClIMEeJKL
X-Google-Smtp-Source: ABdhPJxwStsMaG/PDAFW4v23iAEzF+vF62yfhrLfEbwiQ4vR52FSb7NqsnNL9n6a+ThExOBsKCiFZA==
X-Received: by 2002:ac8:5bc5:: with SMTP id b5mr17433208qtb.174.1603736290380;
        Mon, 26 Oct 2020 11:18:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r58sm7401176qte.94.2020.10.26.11.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:18:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: print the block rsv type when we fail our reservation
Date:   Mon, 26 Oct 2020 14:18:05 -0400
Message-Id: <d3568eaa428026c8e144f253a341e77cd7b7dec6.1603736169.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603736169.git.josef@toxicpanda.com>
References: <cover.1603736169.git.josef@toxicpanda.com>
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

