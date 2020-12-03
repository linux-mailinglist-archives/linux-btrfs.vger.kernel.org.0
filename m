Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A72CDD7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgLCSZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgLCSZG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A0C094253
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:03 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so3002758qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S3VP7V8lCU9GOZcXdgfVCrRDY0XgENnr4Aval9CKvcA=;
        b=FLhg0n82aG0DP5Rxl+skPbssvIHMLfNZSqy19bBFsvNZYCklSKeJpKhhKCd0tetbNQ
         ih4uz0sQ1Tmborpo6P+KWlSZqEw8uvDc1rkwqyqSWKwzQWWja6Sewa+Exp48I6eXx+UE
         WrSiNXZ7Sq6VywFULqArenswnxMdQoDFcD4BzhaahayB5cQR7NwVZ2mzZ0ZQUZ8ggve0
         wLoXDqFnLoRcDl73iZfwZhNWTLP2AotmOva7TMylqU3J5oYKsFvtF2bKFaOujYUiTwGx
         AhQPwhsk3602Es7QN7vBxo4YmDENeqUp4Op+TJp6PadXzrTw5gntkkw6D3C+IdN8rT5s
         oZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3VP7V8lCU9GOZcXdgfVCrRDY0XgENnr4Aval9CKvcA=;
        b=eK0L7gHrRUkBWP4Y/6IxPZIne20R/76Ks8M3kFoBlToP2Qdsqgx1wmZSK3UXG+B/kX
         4akG3cBZkNl0gSPlHUTHXcNJhR1t5+vRdKrFaZWBi3nng4TP/MnWJ6DB/oSoj4dDvkiO
         M3DrjW0hW6mxaSaEm6mejr8tXWIitBpwGk7vRqteWRA0hapX1k7OIp4wtInj/h7TCETT
         JNVYDh278+ItXsN4xm+62Yr+yL403pp11kFb0WeEfCZNXSu+mQjX81G3mfy1h4zWbFTq
         Cu8G5TOvVRCsjJjOxjCOV02DmAON1RMxW8md6P5P4Bufx5JoVxIFaw5gHdOs/mE4g5mL
         0zpg==
X-Gm-Message-State: AOAM532bkNsHb4sfGTsBNcMEotixV1zVgxPcz8cUBZKFQYnojTFi1WCG
        yGA1VKqc7vZLIbmpmE/s97MjQQVykkCRpw85
X-Google-Smtp-Source: ABdhPJyD3XC0y5/5CjFAFDUi/HnATKgcWvDIuyBSWZYWOTnffs16hMyR3cL6T9y0daBSSXiOoxOBRQ==
X-Received: by 2002:a05:620a:15ad:: with SMTP id f13mr4288011qkk.242.1607019842404;
        Thu, 03 Dec 2020 10:24:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 68sm2147402qkf.97.2020.12.03.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 35/53] btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
Date:   Thu,  3 Dec 2020 13:22:41 -0500
Message-Id: <bb662de6e4e72a9c91256b06f75464065effc524.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
an error properly in prepare_to_merge.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f329903024b0..b4ced3a0ca6f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1860,10 +1860,21 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		 */
 		if (!err)
 			btrfs_set_root_refs(&reloc_root->root_item, 1);
-		btrfs_update_reloc_root(trans, root);
+		ret = btrfs_update_reloc_root(trans, root);
 
+		/*
+		 * Even if we have an error we need this reloc root back on our
+		 * list so we can clean up properly.
+		 */
 		list_add(&reloc_root->root_list, &reloc_roots);
 		btrfs_put_root(root);
+
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			if (!err)
+				err = ret;
+			break;
+		}
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.26.2

