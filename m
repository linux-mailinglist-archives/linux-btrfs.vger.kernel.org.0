Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365241863FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 04:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgCPD5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 23:57:45 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:16184 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgCPD5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 23:57:45 -0400
X-Greylist: delayed 681 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Mar 2020 23:57:35 EDT
Received: from localhost.localdomain (unknown [58.251.74.227])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 0F225664012;
        Mon, 16 Mar 2020 11:46:10 +0800 (CST)
From:   Zheng Wei <wei.zheng@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     kernel@vivo.com, wenhu.wang@vivo.com,
        Zheng Wei <wei.zheng@vivo.com>
Subject: [PATCH v2,RESEND] btrfs: fix the duplicated definition of 'inode_item_err'
Date:   Mon, 16 Mar 2020 11:45:57 +0800
Message-Id: <20200316034600.125962-1-wei.zheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VMS0hCQkJCQk1KQ05IWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6HRw6NTg0CjdKDgsaKUIP
        SR0wFDxVSlVKTkNPSEhLSExLQ09CVTMWGhIXVQweElUBEx4VHDsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSUxZV1kIAVlBSU9OTjcG
X-HM-Tid: 0a70e172eeb39373kuws0f225664012
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

remove the duplicated definition of 'inode_item_err'
in the file tree-checker.c

Signed-off-by: Zheng Wei <wei.zheng@vivo.com>
---

changelog
v1 -> v2
 - resend for the failure of delivery to some recipients.

 fs/btrfs/tree-checker.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a92f8a6dd192..517b44300a05 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -957,10 +957,6 @@ static int check_dev_item(struct extent_buffer *leaf,
 	return 0;
 }
 
-/* Inode item error output has the same format as dir_item_err() */
-#define inode_item_err(eb, slot, fmt, ...)			\
-	dir_item_err(eb, slot, fmt, __VA_ARGS__)
-
 static int check_inode_item(struct extent_buffer *leaf,
 			    struct btrfs_key *key, int slot)
 {
-- 
2.17.1

