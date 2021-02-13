Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9916431A936
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 02:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBMBE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 20:04:56 -0500
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:42689 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBMBE4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 20:04:56 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1675483|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0032353-0.000107607-0.996657;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JYP2aiw_1613178252;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JYP2aiw_1613178252)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sat, 13 Feb 2021 09:04:12 +0800
Date:   Sat, 13 Feb 2021 09:04:17 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     fdmanana@kernel.org
Subject: Re: [PATCH 5.10.x] btrfs: fix crash after non-aligned direct IO write with O_DSYNC
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <94663c8a2172dc96b760d356a538d45c36f46040.1613062764.git.fdmanana@suse.com>
References: <94663c8a2172dc96b760d356a538d45c36f46040.1613062764.git.fdmanana@suse.com>
Message-Id: <20210213090416.926A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> This bug only affects 5.10 kernels, and the regression was introduced in
> 5.10-rc1 by commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround").
> The bug does not exist in 5.11 kernels due to commit ecfdc08b8cc65d
> ("btrfs: remove dio iomap DSYNC workaround"), which depends on other
> changes that went into the merge window for 5.11. So this is a fix only
> for 5.10.x stable kernels, as there are people hitting this.

It is OK too to backport commit ecfdc08b8cc65d
 ("btrfs: remove dio iomap DSYNC workaround") to 5.10 for this problem?

the iomap issue for commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")
is already fixed in 5.10?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/13


> Fixes: 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")
> CC: stable@vger.kernel.org # 5.10 (and only 5.10)
> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1181605
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/inode.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index acc47e2ffb46..b536d21541a9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8026,8 +8026,12 @@ ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	bool relock = false;
>  	ssize_t ret;
>  
> -	if (check_direct_IO(fs_info, iter, offset))
> +	if (check_direct_IO(fs_info, iter, offset)) {
> +		ASSERT(current->journal_info == NULL ||
> +		       current->journal_info == BTRFS_DIO_SYNC_STUB);
> +		current->journal_info = NULL;
>  		return 0;
> +	}
>  
>  	count = iov_iter_count(iter);
>  	if (iov_iter_rw(iter) == WRITE) {
> -- 
> 2.28.0


