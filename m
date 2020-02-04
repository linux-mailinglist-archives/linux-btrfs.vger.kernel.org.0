Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFE151E23
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBDQUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40178 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBDQUG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so3269627qkl.7
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QY65H2Ej2vYYxz4dt00ByPGcslqzNwDDeH9YFLVM4l0=;
        b=Jx78oS8eA7daFxPFMMdRfqYbGCW136d4Ktyb614vq6kGcuSMY4pQgOvWWVPBlbnqnZ
         mjIps1ln8CWWpfw0BJt/JLh1AoQWmpthf5XGOQiKjGKj3RE36T2nPcsBGF3N53NFNS88
         QQS9ECjCN0IpcobJD30E1BdnSDuhG666oRX4GUCJMvwFwKIE6vTiQCNyAbgxbqPhwh8Q
         63xz/0McaltMQWOB2UBO9uAr0OSMlyapUK9EdPTxUEc+b59MhdzbXTD+7q5Bt/807xuG
         yKexaKtZC2aKoRRsVD1XKBBG0bwkEljzRmIWMhN+SiZOlgygY9QkEqeL15Wby1ayaenC
         YHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QY65H2Ej2vYYxz4dt00ByPGcslqzNwDDeH9YFLVM4l0=;
        b=grpCfY+6fwDScniftkUtJdSOnTmfj0h8dRrMpqP78SCezSBgHznkXBVteNpzn3hKaz
         U3Ofvown3v8dQ/YnlzBobd/5tr1bwgU7YBNwu0LbUEBjQ5McpsOOlWkWBpsS9aPEFWi/
         yjR14dd7X0lqwng6EdxVpg4rdxCF+R+grhDc+hjy222Y9jO0UNrlfOvERd9nkwI+pQlR
         H1hTMcI8bEA+pduwQ0YUq80ymXqbFT0ASscmoOlcppl2ba2f+cBxkCahzuKp8LK47+s3
         TxBcho+mEq6Q8mbTzZlTZxjOXfPJT6lJy/eUPwDjHefCUFp8RJ2a9Hf/zoaqWHys/skH
         RMMA==
X-Gm-Message-State: APjAAAUdwKyUzXDHUlTuTknsm2xHUt3IXdbUPEt5GAUq/q+nJ4puN9kH
        RlLGcx7uJdQvEP+oTaFn3nNZh6X1nsuKjw==
X-Google-Smtp-Source: APXvYqzIHTCV1O5PemH+e7fZVfogNIwaBP562jBOsI/qnxld9ntYtLF14rye3au8oXqTwe0uBGHRGQ==
X-Received: by 2002:a05:620a:1497:: with SMTP id w23mr28643818qkj.472.1580833205448;
        Tue, 04 Feb 2020 08:20:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r3sm2400818qtc.85.2020.02.04.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/23] btrfs: call btrfs_try_granting_tickets when unpinning anything
Date:   Tue,  4 Feb 2020 11:19:35 -0500
Message-Id: <20200204161951.764935-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When unpinning we were only calling btrfs_try_granting_tickets() if
global_rsv->space_info == space_info, which is problematic because we
use ticketing for SYSTEM chunks, and want to use it for DATA as well.
Fix this by moving this call outside of that if statement.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0783341ef2e7..dfa810854850 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2885,11 +2885,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 				len -= to_add;
 			}
 			spin_unlock(&global_rsv->lock);
-			/* Add to any tickets we may have */
-			if (len)
-				btrfs_try_granting_tickets(fs_info,
-							   space_info);
 		}
+		/* Add to any tickets we may have */
+		if (!readonly && return_free_space && len)
+			btrfs_try_granting_tickets(fs_info, space_info);
 		spin_unlock(&space_info->lock);
 	}
 
-- 
2.24.1

