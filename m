Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54B31F427
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 04:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSDSW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 18 Feb 2021 22:18:22 -0500
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:45375 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSDSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 22:18:21 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09440605|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0772871-0.000735082-0.921978;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JaPj5zO_1613704658;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JaPj5zO_1613704658)
          by smtp.aliyun-inc.com(10.147.41.187);
          Fri, 19 Feb 2021 11:17:39 +0800
Date:   Fri, 19 Feb 2021 11:17:44 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     josef@toxicpanda.com
Subject: error in backport of 'btrfs: fix possible free space tree corruption with online conversion'
Cc:     linux-btrfs@vger.kernel.org
Message-Id: <20210219111741.95DD.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Josef Bacik

We noticed an error in 5.10.x backport of 'btrfs: fix possible free
space tree corruption with online conversion'

It is wrong in 5.10.13, but right in 5.11.

5.10.13
@@ -146,6 +146,9 @@ enum {
 	BTRFS_FS_STATE_DEV_REPLACING,
 	/* The btrfs_fs_info created for self-tests */
 	BTRFS_FS_STATE_DUMMY_FS_INFO,
+
+	/* Indicate that we can't trust the free space tree for caching yet */
+	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
 };

the usage sample of this enum:
set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);


5.11
enum{
..
    /* Indicate that the discard workqueue can service discards. */
    BTRFS_FS_DISCARD_RUNNING,

    /* Indicate that we need to cleanup space cache v1 */
    BTRFS_FS_CLEANUP_SPACE_CACHE_V1,

    /* Indicate that we can't trust the free space tree for caching yet */
    BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
};

the usage sample of this enum:
set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/19


