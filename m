Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F382E151E21
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbgBDQUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32913 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBDQUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so7623958qkm.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLLDCYglTQyc6q+pzWi11ctq/nNJqAfSAF42GWV+QfQ=;
        b=a1eFpDSwiQc+c9hGb55hxshfZxId/49YsxmL3GxSjUfV+++CLu7H/xUdd3VDaSlFGZ
         bRe079Ov4Nf6OFgidWJVfAUbElANLmfyotC3bWuIChnTIUeCI1h0f9fIpQFRH3kTSOnX
         b/rNVmX38eEDh5lNDIIkZQB67UBgZp0C6Lp/4Pp0uOrMueszMKjJFNVB6WPWf07pu4p/
         0M0DQhTPmNGmsEZoykrote5WSVjw+G0C/VAz3yoXfrdOV1LeqY0bD8xXyCbTY2BYfE4a
         2wXUCD47VoQ5I8rKkaTxbVmxUXfOWOTG4iRIq96sAzNz9BiG4NtjwaBieBPYGsu30ghh
         aOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLLDCYglTQyc6q+pzWi11ctq/nNJqAfSAF42GWV+QfQ=;
        b=LfieFlLvPN+82VBa/4+KL4mmGZC4BtP96oREkcXfwl1Wav3qdluTK82i+xvwk7y9w8
         kZ+lHMOpsA8+Vqk/7HDvJkZiG+ib7aj2mS2F8fEhHpt1rSc4j8kHBRpEB0wv/7gB2qTi
         Bt/9tIbQsjt1wp1LYr3jKnvowPEj0YD/rmHgPfmyigzwLW4201QGl+O6ECM2425eXjni
         mkZSDHjJpDjII8N9rPhFa05XdeUHUiMXS8X+qfz3HQpzb3x9OT+XwuRxAREkGORRUK5l
         4u4jLFXSdfRZduQNPDbnLs8mQv+B61FFbNQfwmbenGe/r6kTEi++J0MbchmMpvsvekVh
         ZVIA==
X-Gm-Message-State: APjAAAWzAajB6Qq4UH8uyqjCHad9XBg1XS4/BkA0QYS9rWIpWA+B2c8K
        axyf5Wwrt48xdl0TLVbMsAXfuHgeF1wvrw==
X-Google-Smtp-Source: APXvYqxoRJmafuk4V3Z4go0aa6FTNejK4bhLRWb0cKekWwrzzXWFvnA1OG78NCvJDUv+h1I0S67tyQ==
X-Received: by 2002:a37:96c1:: with SMTP id y184mr26195502qkd.55.1580833202245;
        Tue, 04 Feb 2020 08:20:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d9sm11672046qth.34.2020.02.04.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Tue,  4 Feb 2020 11:19:33 -0500
Message-Id: <20200204161951.764935-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have traditionally used flush_space() to flush metadata space, so
we've been unconditionally using btrfs_metadata_alloc_profile() for our
profile to allocate a chunk.  However if we're going to use this for
data we need to use btrfs_get_alloc_profile() on the space_info we pass
in.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 17e2b5a53cb5..5a92851af2b3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -604,7 +604,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
+				btrfs_get_alloc_profile(fs_info,
+							space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
-- 
2.24.1

