Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3822125364D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHZSIl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 14:08:41 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.221]:44566 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgHZSIk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 14:08:40 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 4E48A2BBD
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 13:08:34 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id AzqckDatUOIGpAzqcknAOZ; Wed, 26 Aug 2020 13:08:34 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EP63rDs5IWtLnwLKyzqW7iBUrKu6Fv884EdarrFpkPI=; b=ip2XtYbMsZzk9oRmgz0ZdS2pSi
        2A2qvzGr0IMPKUu+I8YzWczP7KI40yNv1YgCyLH00OFapceacg9mJnLc1XZQo2E7jZt+w7k3F8XN6
        0xi2qXpomo7NtemIid0fbzp4fIIu3PqNiUAy4iklOfJWAEtpbHMPPOCRHZy0LoljLaQ8DpVOkC31W
        J9lXoiutwumoXV15PMffoAhHxqyJLhbDyBn6Pt3npR1BjGDxOPxkdbWOiXI6Ur3iI+Mpcg8p8/DqX
        526B3EuAKKZSepIfeKb9hn1jQagA+f8eoeQIn4huwk7g8L6ETWFt9sH1MgIUmMeyhbKcLPy/EBBV+
        ALvqsx8A==;
Received: from 189.26.177.226.dynamic.adsl.gvt.net.br ([189.26.177.226]:60752 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kAzqb-000OeN-Q9; Wed, 26 Aug 2020 15:08:34 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: convert: Make ASSERT not truncate cctx.total_bytes value
Date:   Wed, 26 Aug 2020 15:08:20 -0300
Message-Id: <20200826180820.31695-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.177.226
X-Source-L: No
X-Exim-ID: 1kAzqb-000OeN-Q9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.177.226.dynamic.adsl.gvt.net.br (hephaestus.suse.de) [189.26.177.226]:60752
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Commit 670a19828ad ("btrfs-progs: convert: prevent 32bit overflow for
cctx->total_bytes") added an assert to ensure that cctxx.total_bytes did
not overflow, but this ASSERT calls assert_trace, which expects a long
value.

By converting the u64 to long overflows in a 32bit machine, leading the
assert_trace to be triggered since cctx.total_bytes turns to zero.

Fix this problem by comparing the cctx.total_bytes with zero when
calling ASSERT.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 convert/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert/main.c b/convert/main.c
index 5f8f64c5..378fd61a 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1158,7 +1158,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	if (ret)
 		goto fail;
 
-	ASSERT(cctx.total_bytes);
+	ASSERT(cctx.total_bytes != 0);
 	blocksize = cctx.blocksize;
 	total_bytes = (u64)blocksize * (u64)cctx.block_count;
 	if (blocksize < 4096) {
-- 
2.28.0

