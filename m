Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4E388E83
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 15:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbhESNCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 09:02:41 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:36829 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbhESNCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 09:02:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04705721|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00571472-0.000673969-0.993611;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KFk2-a0_1621429279;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.KFk2-a0_1621429279)
          by smtp.aliyun-inc.com(10.147.41.137);
          Wed, 19 May 2021 21:01:19 +0800
Date:   Wed, 19 May 2021 21:01:22 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: mark ordered extent and inode with error if we fail to finish
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <72c99ae5a88109487565b0ce156cb323e94aa371.1621265174.git.josef@toxicpanda.com>
References: <72c99ae5a88109487565b0ce156cb323e94aa371.1621265174.git.josef@toxicpanda.com>
Message-Id: <20210519210122.B480.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Without this patch, xfstests btrfs/146 passed.
With this patch,  xfstests btrfs/146 failed.

xfstests 146.out.bad:
QA output created by 146
Format and mount
Third fsync on fd[0] failed: Input/output error

xfstests btrfs/146 or something in this patch need to be updated?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/05/19


> 
> While doing error injection testing I saw that sometimes we'd get an
> abort that wouldn't stop the current transaction commit from completing.
> This abort was coming from finish ordered IO, but at this point in the
> transaction commit we should have gotten an error and stopped.
> 
> It turns out the abort came from finish ordered io while trying to write
> out the free space cache.  It occurred to me that any failure inside of
> finish_ordered_io isn't actually raised to the person doing the writing,
> so we could have any number of failures in this path and think the
> ordered extent completed successfully and the inode was fine.
> 
> Fix this by marking the ordered extent with BTRFS_ORDERED_IOERR, and
> marking the mapping of the inode with mapping_set_error, so any callers
> that simply call fdatawait will also get the error.
> 
> With this we're seeing the IO error on the free space inode when we fail
> to do the finish_ordered_io.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 955d0f5849e3..b5459239ae81 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3000,6 +3000,17 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  	if (ret || truncated) {
>  		u64 unwritten_start = start;
>  
> +		/*
> +		 * If we failed to finish this ordered extent for any reason we
> +		 * need to make sure BTRFS_ORDERED_IOERR is set on the ordered
> +		 * extent, and mark the inode with the error.
> +		 */
> +		if (ret) {
> +			set_bit(BTRFS_ORDERED_IOERR, &ordered_extent->flags);
> +			mapping_set_error(ordered_extent->inode->i_mapping,
> +					  -EIO);
> +		}
> +
>  		if (truncated)
>  			unwritten_start += logical_len;
>  		clear_extent_uptodate(io_tree, unwritten_start, end, NULL);
> -- 
> 2.26.3


