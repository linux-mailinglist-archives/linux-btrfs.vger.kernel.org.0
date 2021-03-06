Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A432F7BD
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 03:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCFCCB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 21:02:01 -0500
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:35710 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhCFCBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 21:01:47 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04531713|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.205784-0.00577074-0.788446;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Jh5DJ5m_1614996102;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Jh5DJ5m_1614996102)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sat, 06 Mar 2021 10:01:43 +0800
Date:   Sat, 06 Mar 2021 10:01:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs-progs: fix false alert on tree block crossing 64K page boundary
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20210306004019.18528-1-wqu@suse.com>
References: <20210306004019.18528-1-wqu@suse.com>
Message-Id: <20210306100148.EBAE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

It passed the test. Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/06

> [BUG]
> When btrfs-check is executed on even newly created fs, it can report
> tree blocks crossing 64K page boundary like this:
> 
>   Opening filesystem to check...
>   Checking filesystem on /dev/test/test
>   UUID: 80d734c8-dcbc-411b-9623-a10bd9e7767f
>   [1/7] checking root items
>   [2/7] checking extents
>   WARNING: tree block [30523392, 30539776) crosses 64K page boudnary, may cause problem for 64K page system
>   [3/7] checking free space cache
>   [4/7] checking fs roots
>   [5/7] checking only csums items (without verifying data)
>   [6/7] checking root refs
>   [7/7] checking quota groups skipped (not enabled on this FS)
>   found 131072 bytes used, no error found
>   total csum bytes: 0
>   total tree bytes: 131072
>   total fs tree bytes: 32768
>   total extent tree bytes: 16384
>   btree space waste bytes: 125199
>   file data blocks allocated: 0
>    referenced 0
> 
> [CAUSE]
> Tree block [30523392, 30539776) is at the last 16K slot of page.
> As 30523392 % 65536 = 49152, and 30539776 % 65536 = 0.
> 
> The cross boundary check is using exclusive end, which causes false
> alerts.
> 
> [FIX]
> Use inclusive end to do the cross 64K boundary check.
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Fixes: fc38ae7f4826 ("btrfs-progs: check: detect and warn about tree blocks crossing 64K page boundary")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/mode-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check/mode-common.h b/check/mode-common.h
> index 8fdeb7f6be0a..3107b00c48bf 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -186,7 +186,7 @@ int get_extent_item_generation(u64 bytenr, u64 *gen_ret);
>  static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
>  {
>  	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=
> -	    (start + len) / BTRFS_MAX_METADATA_BLOCKSIZE)
> +	    (start + len - 1) / BTRFS_MAX_METADATA_BLOCKSIZE)
>  		warning(
>  "tree block [%llu, %llu) crosses 64K page boudnary, may cause problem for 64K page system",
>  			start, start + len);
> -- 
> 2.30.1


