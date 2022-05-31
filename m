Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335FF539366
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbiEaOxy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiEaOxw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 10:53:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA6E0BC;
        Tue, 31 May 2022 07:53:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jx22so27075235ejb.12;
        Tue, 31 May 2022 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnajSFs4DgNty7orDHrdOsB6V8V9bgUOexGBItj7yYs=;
        b=GBlM8XU0qqk8vyk41ayssiwNPIoeSPm+2C7ymoFOplfcpeTEoZGk4Lg80r4Fqgp121
         YoCXvJqNiZjMb6irJ/9l2/gQmRWKZjL9QItxahSUlfVuNPAd4QZI26i+XWwFcU0NO3VV
         zooiinLqh35iJY4jxittDYK/FZAs4pCybdyrMd/kENTpZJOGPKUEBFNCM301/kr1rxW9
         jaURHUb79an6UfYD4XykBrg80NYnHvyprT3q+U4sLq8OOE0QQUpNoVXlcZQ5G9oLGg6Q
         A9UPShsdvkgkNctAxa4edKhNpOZ0AaJy/f+q15YBWFU29jzolO96JdEh+erFwaLujxt1
         /QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnajSFs4DgNty7orDHrdOsB6V8V9bgUOexGBItj7yYs=;
        b=dHk3nsXs03m57yg+Wju1aS4FhGvInCI+/EyHOw80BMgoqsT6+sVn+WFYkhln/47EFQ
         wdhNGHQ0wR00jro8CWsTEIDwzU0Je8FM8TQIL6FV0Xkp3yRGazQ/QG2jgEt9FCmzjlD7
         NTmFK0xohxLzwduGuzgSiTW1EGKVsY79kS0ix/fHewuSrhMbM9/+iPB9LF05rWF4+4+m
         ktG7kQIQy4k/ctKOVKiY5vE5aUCW/IWoavCkM7yk33VvyOc+VpwReK6v9RpEgO+cr7nm
         z5dImQbuWVZ5zT3qJogUKK0Ex59EPFgPkMNTZOtqY3ri1F4rXKcFsfSq1l+LYIoBIBtK
         CM/w==
X-Gm-Message-State: AOAM533HVo6JEqIfC6D7m3SuqP1kxBxDu4XiNKXqfjugL04dBHXbRBNz
        +buCW9jkbK+k0PwgpHmmaRc=
X-Google-Smtp-Source: ABdhPJw64XzgP9z2G8cT5/Kennf/6dTzejX79K/0JkHCfm7gsLms53C8QzJH9B9IT5F9dRyd4NG9wA==
X-Received: by 2002:a17:907:7291:b0:6f9:a3b5:7ce4 with SMTP id dt17-20020a170907729100b006f9a3b57ce4mr54645962ejc.642.1654008829486;
        Tue, 31 May 2022 07:53:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-55-12-155.retail.telecomitalia.it. [79.55.12.155])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090603c200b006fea59ef3a5sm5099779eja.32.2022.05.31.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 07:53:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/3] btrfs: Replace kmap() with kmap_local_page() in inode.c
Date:   Tue, 31 May 2022 16:53:33 +0200
Message-Id: <20220531145335.13954-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531145335.13954-1-fmdefrancesco@gmail.com>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page() where
it is feasible. With kmap_local_page(), the mapping is per thread, CPU
local and not globally visible.

Therefore, use kmap_local_page() / kunmap_local() in inode.c wherever the
mappings are per thread and not globally visible.

Tested on QEMU + KVM 32 bits VM with 4GB of RAM and HIGHMEM64G enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81737eff92f3..7d84d57a0653 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10779,15 +10779,15 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			ret = -ENOMEM;
 			goto out_pages;
 		}
-		kaddr = kmap(pages[i]);
+		kaddr = kmap_local_page(pages[i]);
 		if (copy_from_iter(kaddr, bytes, from) != bytes) {
-			kunmap(pages[i]);
+			kunmap_local(kaddr);
 			ret = -EFAULT;
 			goto out_pages;
 		}
 		if (bytes < PAGE_SIZE)
 			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
-		kunmap(pages[i]);
+		kunmap_local(kaddr);
 	}
 
 	for (;;) {
-- 
2.36.1

