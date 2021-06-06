Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B4139CF6C
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jun 2021 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhFFOAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Jun 2021 10:00:55 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:57199 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFOAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Jun 2021 10:00:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08849365|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0742867-0.000680708-0.925033;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.KOP4lft_1622987942;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KOP4lft_1622987942)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 06 Jun 2021 21:59:03 +0800
Date:   Sun, 6 Jun 2021 21:59:02 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        g.btrfs@cobb.uk.net, quwenruo.btrfs@gmx.com
Subject: Re: [PATCH] btrfs: support other sectorsizes in
 _scratch_mkfs_blocksized
Message-ID: <YLzUph/ehN12cMCC@desktop>
References: <d27e3a324f986b5b52d11df7c7bdcde6744fad4b.1622807821.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27e3a324f986b5b52d11df7c7bdcde6744fad4b.1622807821.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 04, 2021 at 08:26:44PM +0800, Anand Jain wrote:
> When btrfs supports sectorsize != pagesize it can run these test cases
> now,
> generic/205 generic/206 generic/216 generic/217 generic/218 generic/220
> generic/222 generic/227 generic/229 generic/238
> 
> This change is backward compatible for kernels without non pagesize
> sectorsize support.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC->v1:
>   Fix path to the supported_sectorsizes path check if the file exists.
>   Grep the word.
> 
>  common/rc | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 919028eff41c..baa994e33553 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1121,6 +1121,15 @@ _scratch_mkfs_blocksized()
>      fi
>  
>      case $FSTYP in
> +    btrfs)
> +	test -f /sys/fs/btrfs/features/supported_sectorsizes || \
> +		_notrun "Subpage sectorsize support is not found in $FSTYP"

As we're updating _scratch_mkf_blocksized, would you please unify the
indention for the whole function to use tab instead of spaces? They're
old code, this way we're slowly migrating old/space indention to tab.

> +
> +	grep -q \\b$blocksize\\b /sys/fs/btrfs/features/supported_sectorsizes || \

I think grep -qw should be fine.

> +		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
> +
> +	_scratch_mkfs $MKFS_OPTIONS --sectorsize=$blocksize

No need to specify $MKFS_OPTIONS here, _scratch_mkfs will append
$MKFS_OPTIONS anyway.

> +	;;
>      xfs)
>  	_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize

So this $MKFS_OPTIONS isn't needed either, but that belongs to another
patch.

Thanks,
Eryu

>  	;;
> -- 
> 2.18.4
