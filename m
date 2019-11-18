Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB3FFE26
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 06:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfKRF4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 00:56:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38860 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfKRF4L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 00:56:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so9830163pfp.5
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Nov 2019 21:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRFj6zMSZsBJ/HmiWIrPps3Swl2rLDbmGmiCxHfa7P4=;
        b=D5jFb1IWSR/whFv+1WE1MpgHXX9HnzthX6S6jfooeotpLy/5WY1fKIU83Wv+9OKtKV
         wmcF+0jnH+cgRej4wzf9YQW0E1qgKVnyczIdDxytx/yDFyRyCPlBJN8D9ZfRsEP3IbrD
         sh5iFUNuCGck8GzVah7RUfWtSQrDheA51YURi6W/siH+ZBGuY3tzUid+rJ/2z50SdPmo
         I9YlyjjiFHkE2Iwjoa11PKOQ8CZn9/iZrQbjV023BjkEGMYQnVad/Wq/Z010SWHFqUqS
         pp5plQZOkRKXxYGioTQjQm0R0NO4Jf4yMFkiqP8+MycHMPNxmwrgMe+qwBxXRbPnEpGW
         tUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BRFj6zMSZsBJ/HmiWIrPps3Swl2rLDbmGmiCxHfa7P4=;
        b=gmGTNfVJDKRLaVBGHzsaZcQruPHYmibe6OKZBI5sNyye4yVMjMI/v08e94iaISGHR5
         L8F7KgY1SrjXfdF7ZQbVuxLSw8IOyw7nQ8yXAPBoQO+LwtaGs8UQE3G3subXNcm+tVsM
         Us6uRjEsV4FW9D7Ff0ChncHfj9vD9NzhQihCZh1DREFq/WU6FLXE0qZY1JH4LXjUCMzD
         22gzSmqfsYBfG/vCeravjtRM+H1H1nabctkuU4jszzkMuBJY1rxekC2CUHTD5j4z0DJs
         eJmmJW0eGdatBs8PP9V87eMdykDe/gDzfFcxcJ7ut4pJHx3w+JIWsrbAU7A72v6b5W81
         nBSQ==
X-Gm-Message-State: APjAAAV9zlPGly8t7cDgwxQABJMyEY1mVfSX7xnTDItWlr3NqcwjAPof
        FXHkOGqOGML97ZlrT/+HxPtnb3PkBQE=
X-Google-Smtp-Source: APXvYqzA1YqnsK82JKw3IZk3J7UjKIc/gYGq7YbEpjHF5jgbm6P9e6Tw7I4EEKpz6LSfuwSID+he1w==
X-Received: by 2002:a63:ee48:: with SMTP id n8mr31948645pgk.374.1574056569465;
        Sun, 17 Nov 2019 21:56:09 -0800 (PST)
Received: from cat-arch.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id d38sm2611564pgd.59.2019.11.17.21.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 21:56:08 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Damenly_Su@gmx.com
Subject: [PATCH] btrfs: block group: do not exclude bytenr adjacent to block group
Date:   Mon, 18 Nov 2019 13:56:03 +0800
Message-Id: <20191118055603.10011-1-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

while excluding super stripes from one block group, the logical bytenr
should not be excluded if the block group's start + length equals the
bytenr since the bytenr is not belong to the block group.

This is insipred by same bugous code of btrfs-progs.
The fuzz image is rejected to be mounted by tree-checker, but not
bad to enhance the check in practice.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1e521db3ef56..54f970f459f5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1539,7 +1539,7 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 		while (nr--) {
 			u64 start, len;
 
-			if (logical[nr] > cache->start + cache->length)
+			if (logical[nr] >= cache->start + cache->length)
 				continue;
 
 			if (logical[nr] + stripe_len <= cache->start)
-- 
2.23.0

