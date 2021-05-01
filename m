Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D770E370945
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 00:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhEAWv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhEAWv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 18:51:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271EC06174A;
        Sat,  1 May 2021 15:51:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1288710wmh.4;
        Sat, 01 May 2021 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PwSV7FUhyJ1mxH+xfT6PmlAiJ1kI3txZ1OhhYMJ+KoM=;
        b=bNYTxQvFFKjVbSmFkmHmnAwxnykw2R7jrMyD8gjKefiQk700UnoZXsRZZNk0X1XdtV
         1boXIS3JLX3+uzTrFwRCTaMuQ6wKcHJMPr4PGgvvbLfstIXZVsV6InLfEQFUhqQSU2/d
         s0XphrdWof5VwAT9Xf+vyKViTmHeuKMkWoqRSlrsmGjUg496WxbTJodgoapM8ON2y/VG
         FapDERrqnRsisWw7Nt1cwl0ab+2/im04sb3cSeQiJhfOuTYuyPJUhMrtYOD3MB724E9B
         CfQjfjxiUqcN/plFO1tSyapsxUvFvWIT/AJemOheYuIxKBUzrDHnl2WE7akykKz4lhTv
         GwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PwSV7FUhyJ1mxH+xfT6PmlAiJ1kI3txZ1OhhYMJ+KoM=;
        b=eYuR7DDW/6UAMExE/QeE28FKj9p9tBq3+d9q6X2Vgp9csvSEcHr45RBPOAdJ63nwFx
         ZnC0vZhed86Wc/m5EfDS/Ni+hIepLfvgPaFbzl3kL8QmVG2Ye/a8vJyEstgKRgtOWCl8
         6IBNNRXItFx1+MS65yNZ7gnpfcmFDLO1HS85EjybvdUg4QSDWBBDKDgqbagXSIBfpkT8
         VPgR8pxNF2UFhE8DGbWvgBSJ9DbgjnPpQLQkxb+1rp7BjuzFJ9Rd2feRxErW/7vDR3K2
         qt5EySl5DMzKzdV6LlgKb3x/YZrZSn8qceYz/BTzJkDC9qYwIn4N96OfMyOt6PF5VUhi
         XkVQ==
X-Gm-Message-State: AOAM532DjoIRTeGiOApNTXRV9f5y43PvJv6sM00uLRujIwvOmHSyHYLx
        BvJ3MaTy+ry85WQth5B+g4wOIdlL9KOD5bgG
X-Google-Smtp-Source: ABdhPJw4heNvR+XcJW4rZ0mvVyn/rkIN69A1d9f4P8AgO5ne57CgcPSt73A8oWx0ai5jS7goZCnS7A==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr13678574wmd.82.1619909464863;
        Sat, 01 May 2021 15:51:04 -0700 (PDT)
Received: from localhost.localdomain ([102.156.189.222])
        by smtp.gmail.com with ESMTPSA id t17sm2570172wrx.40.2021.05.01.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 15:51:04 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/btrfs: Fix uninitialized variable
Date:   Sat,  1 May 2021 23:50:46 +0100
Message-Id: <20210501225046.9138-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix the warning: variable 'zone' is used
uninitialized whenever '?:' condition is true.

Fix that by preventing the code to reach
the last assertion. If the variable 'mirror'
is invalid, the assertion fails and we return
immediately.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8250ab3f0868..23da9d8dc184 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -145,7 +145,7 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
 	default:
 		ASSERT((u32)mirror < 3);
-		break;
+		return 0;
 	}
 
 	ASSERT(zone <= U32_MAX);

base-commit: b5c294aac8a6164ddf38bfbdd1776091b4a1eeba
-- 
2.17.1

