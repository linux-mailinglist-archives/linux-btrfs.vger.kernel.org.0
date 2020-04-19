Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA421AFB81
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Apr 2020 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgDSOye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Apr 2020 10:54:34 -0400
Received: from out20-26.mail.aliyun.com ([115.124.20.26]:48388 "EHLO
        out20-26.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgDSOye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Apr 2020 10:54:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0801112|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.137629-0.00138172-0.860989;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16370;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.HJr3Pll_1587308070;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HJr3Pll_1587308070)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 19 Apr 2020 22:54:30 +0800
Date:   Sun, 19 Apr 2020 22:55:37 +0800
From:   Eryu Guan <guan@eryu.me>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/4] fsx: add missing file size update on zero range
 operations
Message-ID: <20200419145537.GE388005@desktop>
References: <20200408103552.11339-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408103552.11339-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a zero range operation increases the size of the test file we were
> not updating the global variable 'file_size' which tracks the current
> size of the test file. This variable is used to for example compute the
> offset for a source range of clone, dedupe and copy file range operations.
> 
> So just fix it by updating the 'file_size' global variable whenever a zero
> range operation does not use the keep size flag and its range goes beyond
> the current file size.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  ltp/fsx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 9d598a4f..fa383c94 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
>  	}
>  
>  	end_offset = keep_size ? 0 : offset + length;
> +	if (!keep_size && end_offset > file_size)
> +		file_size = end_offset;

I think this should be done after we really excute fallocate(2),
otherwise we may return early below:

        if (testcalls <= simulatedopcount)                                                                                                                                                                                                     
	                return;

Thanks,
Eryu

>  
>  	if (end_offset > biggest) {
>  		biggest = end_offset;
> -- 
> 2.11.0
> 
