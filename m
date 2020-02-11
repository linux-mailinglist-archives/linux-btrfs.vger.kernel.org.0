Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FC159488
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgBKQMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 11:12:52 -0500
Received: from gateway20.websitewelcome.com ([192.185.49.40]:36717 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729390AbgBKQMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 11:12:51 -0500
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 11:12:51 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 60474400D059E
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 08:11:12 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 1XP3jYr22AGTX1XP3jlIeZ; Tue, 11 Feb 2020 09:24:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hm/23NW+SCo6nlE9b57ji0EYuqf5cV9tPkdyZTDdTQ8=; b=ImeXzwnyNIMnAZ/x68MtAhO9qs
        EencLIgV8uhbSE01pD6cPy9jZ+NZj4THnkbh8hyXQhmDKnQ7jgKm/G2qFU8JcyiIyXP0lVAc2rPmv
        KHRMUylDriEeR2XCNUIRxfIhZtxdS1WAg/lxJRsXCKqZDgplvq3sKDQe8KRqlYZXAv2z9CAvHR5Qy
        cq/bVXi7B2+tYecgZ61b4lsyVTKkdE1SqotiP5G0XD1tQbern3P89+dDzNaTgzywqsf+wZ+wor9yd
        0GFvqe9R0Opimm4hv9joVTfWqUHCWK/4L3EgFdrtq278joKnuVVoVoCz08FZiy7e5JlbySxD2xmBC
        Ru0X2ZoA==;
Received: from [189.114.219.35] (port=33874 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1j1Vy7-0017fX-Dc; Tue, 11 Feb 2020 10:52:51 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        wqu@suse.com
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Subject: [PATCH] btrfs: ioctl: resize: Only how new size if size changed
Date:   Tue, 11 Feb 2020 10:55:26 -0300
Message-Id: <20200211135526.22793-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.114.219.35
X-Source-L: No
X-Exim-ID: 1j1Vy7-0017fX-Dc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [189.114.219.35]:33874
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 0
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no point to inform the user about "new size" if didn't changed
at all.

Signed-off-by: Marcos Paulo de Souza <marcos@mpdesouza.com>
---
 fs/btrfs/ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be5350582955..fa31a8021d24 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1712,9 +1712,6 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 
 	new_size = round_down(new_size, fs_info->sectorsize);
 
-	btrfs_info_in_rcu(fs_info, "new size for %s is %llu",
-			  rcu_str_deref(device->name), new_size);
-
 	if (new_size > old_size) {
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
@@ -1727,6 +1724,9 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		ret = btrfs_shrink_device(device, new_size);
 	} /* equal, nothing need to do */
 
+	if (ret == 0 && new_size != old_size)
+		btrfs_info_in_rcu(fs_info, "new size for %s is %llu",
+			  rcu_str_deref(device->name), new_size);
 out_free:
 	kfree(vol_args);
 out:
-- 
2.24.0

