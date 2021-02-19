Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5131FBE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBSPVh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 10:21:37 -0500
Received: from out20-110.mail.aliyun.com ([115.124.20.110]:49770 "EHLO
        out20-110.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBSPVe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 10:21:34 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05383348|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0939308-0.000954575-0.905115;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Jae6Omv_1613748044;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jae6Omv_1613748044)
          by smtp.aliyun-inc.com(10.147.44.129);
          Fri, 19 Feb 2021 23:20:45 +0800
Date:   Fri, 19 Feb 2021 23:20:51 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Holger Hoffst?tte <holger@applied-asynchrony.com>
Subject: Re: error in backport of 'btrfs: fix possible free space tree corruption with online conversion'
Cc:     josef@toxicpanda.com, linux-btrfs@vger.kernel.org
In-Reply-To: <d07905be-f714-3cbd-01c7-d348ea13c07e@applied-asynchrony.com>
References: <20210219111741.95DD.409509F4@e16-tech.com> <d07905be-f714-3cbd-01c7-d348ea13c07e@applied-asynchrony.com>
Message-Id: <20210219232049.554C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 2021-02-19 04:17, Wang Yugui wrote:
> > Hi, Josef Bacik
> >
> > We noticed an error in 5.10.x backport of 'btrfs: fix possible free
> > space tree corruption with online conversion'
> >
> > It is wrong in 5.10.13, but right in 5.11.
> >
> > 5.10.13
> > @@ -146,6 +146,9 @@ enum {
> >   	BTRFS_FS_STATE_DEV_REPLACING,
> >   	/* The btrfs_fs_info created for self-tests */
> >   	BTRFS_FS_STATE_DUMMY_FS_INFO,
> > +
> > +	/* Indicate that we can't trust the free space tree for caching yet */
> > +	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> >   };
> >
> > the usage sample of this enum:
> > set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
> >
> >
> > 5.11
> > enum{
> > ..
> >      /* Indicate that the discard workqueue can service discards. */
> >      BTRFS_FS_DISCARD_RUNNING,
> >
> >      /* Indicate that we need to cleanup space cache v1 */
> >      BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
> >
> >      /* Indicate that we can't trust the free space tree for caching yet */
> >      BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> > };
> >
> > the usage sample of this enum:
> > set_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
> > 
> Out of curiosity I decided to check how this happened, but don't see it.
> Here is the commit that went into 5.10.13 and it looks correct to me:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57

> The patch that went into 5.10 looks identical to the original commit in 5.11.
> What tree are you looking at?

the 5.10.y is the URL that you point out.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57

but the right one for 5.11 is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs?id=2f96e40212d435b328459ba6b3956395eed8fa9f

5.11:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/btrfs?id=2f96e40212d435b328459ba6b3956395eed8fa9f

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0225c5208f44c..47ca8edafb5e6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -564,6 +564,9 @@ enum {
 
 	/* Indicate that we need to cleanup space cache v1 */
 	BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
+
+	/* Indicate that we can't trust the free space tree for caching yet */
+	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
 };
 
 /*

but 5.10.y:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=2175bf57dc9522c58d93dcd474758434a3f05c57

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e01545538e07f..30ea9780725ff 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -146,6 +146,9 @@ enum {
 	BTRFS_FS_STATE_DEV_REPLACING,
 	/* The btrfs_fs_info created for self-tests */
 	BTRFS_FS_STATE_DUMMY_FS_INFO,
+
+	/* Indicate that we can't trust the free space tree for caching yet */
+	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
 };
 
 #define BTRFS_BACKREF_REV_MAX		256

Both the line(Line:146 vs Line:564) and the content are wrong.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/19


