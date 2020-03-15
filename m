Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE121859F5
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 05:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgCOEBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 00:01:55 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.91]:44985 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgCOEBy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 00:01:54 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 00:01:54 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D2FA732381
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Mar 2020 22:39:50 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id DK7yj9JeqEfyqDK7yjAafg; Sat, 14 Mar 2020 22:39:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HdNClwA12ve4OVb/muF6YbVeejQKBuAt4B9f8BZr0aM=; b=D6X45wVQs7ibsTNvS0+7yOtMOu
        t9TFLml0zeHVb321oRcr827KyEgJ1mRTJBGy/XWezdFk3U3o+byxlhrUBeq4eJlZEONEDfUEa4HzT
        0J7IUVjf+nrkTowVr0ZHOoLDpYM6ip6LxhF3w1rllevgVqf89/PNFqY/nTOHyWrr0GecICZi1gg41
        Ok/EMew5nLehd3DMWhqBXiY3LWR8r/0IJek1je6cwd9UfphEFcLLt0tYkNdbRyq1h1VMoqATlF0K8
        L8sINtwaEfg8Oa0ZO/U8mJdSZjO1gM9SeD4Zn/cWQvyfmb4cmfD2ysL3J4Wcys8I8kaon5qYoCQc/
        lA3meSRQ==;
Received: from [177.96.46.32] (port=45744 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jDK7y-001qVU-9e; Sun, 15 Mar 2020 00:39:50 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, wqu@suse.com, dsterba@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: qgroup-verify: Remove duplicated message in report_qgroups
Date:   Sun, 15 Mar 2020 00:42:53 -0300
Message-Id: <20200315034253.11261-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 177.96.46.32
X-Source-L: No
X-Exim-ID: 1jDK7y-001qVU-9e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [177.96.46.32]:45744
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Since 1d5b2ad9 ("btrfs-progs: qgroup-verify: Don't treat qgroup
difference as error if the fs hasn't initialized a rescan") a new
message is being printed when the qgroups is incosistent and the rescan
hasn't being executed, so remove the later message send to stderr.

While in this function, simplify the check for a not executed rescan
since !counts.rescan_running and counts.rescan_running == 0 means the
same thing.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 check/qgroup-verify.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index afe15acf..685370d6 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1336,14 +1336,11 @@ int report_qgroups(int all)
 	/*
 	 * It's possible that rescan hasn't been initialized yet.
 	 */
-	if (counts.qgroup_inconsist && !counts.rescan_running &&
-	    counts.rescan_running == 0) {
+	if (counts.qgroup_inconsist && !counts.rescan_running) {
 		printf(
 "Rescan hasn't been initialized, a difference in qgroup accounting is expected\n");
 		skip_err = true;
 	}
-	if (counts.qgroup_inconsist && !counts.rescan_running)
-		fprintf(stderr, "Qgroup are marked as inconsistent.\n");
 	node = rb_first(&counts.root);
 	while (node) {
 		c = rb_entry(node, struct qgroup_count, rb_node);
-- 
2.25.0

