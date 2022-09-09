Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9845B2D4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 06:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiIIERF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 00:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIIERE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 00:17:04 -0400
Received: from out20-157.mail.aliyun.com (out20-157.mail.aliyun.com [115.124.20.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABA12110B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 21:16:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04674798|-1;BR=01201311R701S75rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0704953-0.0577002-0.871805;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.PBZNxTl_1662697016;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PBZNxTl_1662697016)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 12:16:57 +0800
Date:   Fri, 09 Sep 2022 12:17:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH PoC 1/9] btrfs: introduce BTRFS_IOC_SCRUB_FS family of ioctls
In-Reply-To: <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com> <e37ae2c85731ec307869e7c8f87c10d36d51846f.1662191784.git.wqu@suse.com>
Message-Id: <20220909121701.B343.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> The new ioctls are to address the disadvantages of the existing
> btrfs_scrub_dev():
> 
> a One thread per-device
>   This can cause multiple block groups to be marked read-only for scrub,
>   reducing available space temporarily.
> 
>   This also causes higher CPU/IO usage.
>   For scrub, we should use the minimal amount of CPU and cause less
>   IO when possible.
> 
> b Extra IO for RAID56
>   For data stripes, we will cause at least 2x IO if we run "btrfs scrub
>   start <mnt>".
>   1x from scrubbing the device of data stripe.
>   The other 1x from scrubbing the parity stripe.
> 
>   This duplicated IO should definitely be avoided
> 
> c Bad progress report for RAID56
>   We can not report any repaired P/Q bytes at all.
> 
> The a and b will be addressed by the new one thread per-fs
> btrfs_scrub_fs ioctl.
> 
> While c will be addressed by the new btrfs_scrub_fs_progress structure,
> which has better comments and classification for all errors.
> 
> This patch is only a skeleton for the new family of ioctls, will return
> -EOPNOTSUPP for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c           |   6 ++
>  include/uapi/linux/btrfs.h | 173 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index fe0cc816b4eb..3df3bcdf06eb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -5508,6 +5508,12 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		return btrfs_ioctl_scrub_cancel(fs_info);
>  	case BTRFS_IOC_SCRUB_PROGRESS:
>  		return btrfs_ioctl_scrub_progress(fs_info, argp);
> +	case BTRFS_IOC_SCRUB_FS:
> +		return -EOPNOTSUPP;
> +	case BTRFS_IOC_SCRUB_FS_CANCEL:
> +		return -EOPNOTSUPP;
> +	case BTRFS_IOC_SCRUB_FS_PROGRESS:
> +		return -EOPNOTSUPP;

Could we add suspend/resume for scrub when huge filesysem?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/09


