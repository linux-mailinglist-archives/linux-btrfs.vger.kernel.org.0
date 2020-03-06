Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCB17C3AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgCFRHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 12:07:52 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.97]:36963 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbgCFRHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 12:07:51 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7EAD38606F
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Mar 2020 10:46:07 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AG6xjT9leAGTXAG6xjamCT; Fri, 06 Mar 2020 10:46:07 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a0yfOiyYtsn67/xw854Gi9PS9vsekXy7OaHr3ZdUtSM=; b=fn4/ra0rE4bp/rosZ9RYHUFyv6
        /N3piaBjmUoMihSThSuzygMoAc0Usf1H8YHqkSquw1IJdl1W+p1tj4QSHiw5n2DOKPghBAaktwpMM
        GV9aLkXqxd/NNC3vMLXsZxkqkheCUDa11IDKcKDiSdh0EYKPcwhFnoWTIFK1s6bodSLETOioXbWDu
        oe37C4vPDVQiKjERSxXRzBszarIUXU6YXMooHMQ+sCk9xQkSEGfsBCfokb9FLVdWyae80IOOaOl5z
        uhlzZn3QlnP1fhwjoCMcO48Z2q0BbKI2yBfsJqL14TDiOXDMzWtO6nX7ccJCSx81pFHZdLcBrRt9S
        mJRtLPHg==;
Received: from [201.166.190.186] (port=51790 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jAG6v-001sRG-Bx; Fri, 06 Mar 2020 10:46:06 -0600
Date:   Fri, 6 Mar 2020 10:49:12 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] Btrfs: delayed-inode.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200306164912.GA22197@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.190.186
X-Source-L: No
X-Exim-ID: 1jAG6v-001sRG-Bx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.190.186]:51790
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/btrfs/delayed-inode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 74ae226ffaf0..ca96ef007d8f 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -70,7 +70,7 @@ struct btrfs_delayed_item {
 	refcount_t refs;
 	int ins_or_del;
 	u32 data_len;
-	char data[0];
+	char data[];
 };
 
 static inline void btrfs_init_delayed_root(
-- 
2.25.0

