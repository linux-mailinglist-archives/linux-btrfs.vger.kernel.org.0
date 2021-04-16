Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768EA362789
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbhDPSOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 14:14:36 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36187 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239524AbhDPSOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 14:14:36 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BEBD3152A;
        Fri, 16 Apr 2021 14:14:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 16 Apr 2021 14:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=J+R0xNCwpB7E1ePd3MvZDwBpEpW
        FeFxL9oidPWFo0tQ=; b=LLtMf67YQjqmXsOxrhQBs/WpvGVzhvAZ+9Ny4mFio4h
        q6wUOFUxfkXfwLL5ZpVVGXRqL07PT/R6FNobjyKPZJcaSY7xV1a/F5BYsLJUDuiD
        6j6aRMTSIo1Octai2L/VT5rk78fA5Z6YYooQ6LS2PbWmN6Hp6Q9QUMOKICCyud9q
        hCw4SRlHTqZxlAUVUD3JeJzdliWCRC4P/VkPPBt7KDoOL1ctuDO9poF+3MkCNHK2
        qhGujqV9TpUb9SbDRQDaJUD8OnlBs0BemS08/uKKKK42k8l1S/dWcH1RyKEbBGB6
        dbXjZaH9AKgd4OWRq6MdFbJYDQJYe5AGhBlJXH2NaqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=J+R0xN
        CwpB7E1ePd3MvZDwBpEpWFeFxL9oidPWFo0tQ=; b=oRmgmBtJNqObB1lmxRpLNE
        x9+HeDJVwIyTJST+9uq4uvU5qjM+kkl0IweaGdia/GlMhAGL+NOEBClEIZkG+6So
        dtKCCVo7Yo7Ct4FVyYHBTiVVxL+mvqGkfRnY3If4/t8qEXf0AKb4kAx3N4z6wr6X
        e8Q/1niJ8dgLyxEbJMC85p/7J1iD8zSbOYxcGKWFl7gOloDOXQGMvFfzJTvMOQFZ
        mag5z/XL6Qoj6grXcG5AXouIrxRiN2LIqxnepKzpDXdx7wFLTZ85YiEV4mQug28D
        2P4NO9pVzv92USMXuCizIYDBYNuVPY25O8arVqBmG4MhamI+PJJwpqD9qldt5IQQ
        ==
X-ME-Sender: <xms:8tN5YDjU5U7iVbn4H9y-D8-7b4dJFOK2v5XwcauSdDZiMPx1aHdgdA>
    <xme:8tN5YAOibnxj_tDpR4w4seRXc0FTTacwt5szGg8f3mVnFyg2xVdME0orBM1eJBVkN
    Y9jW7Sxz0hp2NnPBtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudelhedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucfk
    phepvddtjedrheefrddvheefrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:8tN5YE72R33G23qiRADSTCtELiVuBlVQJXrOcJ5cJZXTWuoULY4sTQ>
    <xmx:8tN5YO1wnJwjQNfoPx7IW6v2SUHk7s2BkNvTdy0moIX9LWKc0z0i6g>
    <xmx:8tN5YFbuJHrZiEv_eVvz8ZM7diKJS3Ws8UYktxX6OZOxt3Xo23qClw>
    <xmx:8tN5YPHcltCYPVWbW1p6whwF5L9Pbws_DPWE3e0HUQ6qiAWWSYYeqA>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id DDFDC240066;
        Fri, 16 Apr 2021 14:14:09 -0400 (EDT)
Date:   Fri, 16 Apr 2021 11:14:08 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <YHnT8Dwobux2J9Pt@zen>
References: <20210415053011.275099-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415053011.275099-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 01:30:11PM +0800, Qu Wenruo wrote:
> Currently mkfs.btrfs will output a warning message if the sectorsize is
> not the same as page size:
>   WARNING: the filesystem may not be mountable, sectorsize 4096 doesn't match page size 65536
> 
> But since btrfs subpage support for 64K page size is comming, this
> output is populating the golden output of fstests, causing tons of false
> alerts.
> 
> This patch will make teach mkfs.btrfs to check
> /sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
> size is supported.
> 
> Then only output above warning message if the sector size is not
> supported.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/fsfeatures.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 569208a9e5b1..13b775da9c72 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -16,6 +16,8 @@
>  
>  #include "kerncompat.h"
>  #include <sys/utsname.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
>  #include <linux/version.h>
>  #include <unistd.h>
>  #include "common/fsfeatures.h"
> @@ -327,8 +329,15 @@ u32 get_running_kernel_version(void)
>  
>  	return version;
>  }
> +
> +/*
> + * The buffer size if strlen("4096 8192 16384 32768 65536"),
> + * which is 28, then round up to 32.

I think there is a typo in this comment, because it doesn't quite parse.

> + */
> +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
>  int btrfs_check_sectorsize(u32 sectorsize)
>  {
> +	bool sectorsize_checked = false;
>  	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
>  
>  	if (!is_power_of_2(sectorsize)) {
> @@ -340,7 +349,32 @@ int btrfs_check_sectorsize(u32 sectorsize)
>  		      sectorsize);
>  		return -EINVAL;
>  	}
> -	if (page_size != sectorsize)
> +	if (page_size == sectorsize) {
> +		sectorsize_checked = true;
> +	} else {
> +		/*
> +		 * Check if the sector size is supported
> +		 */
> +		char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> +		char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> +		int fd;
> +		int ret;
> +
> +		fd = open("/sys/fs/btrfs/features/supported_sectorsizes",
> +			  O_RDONLY);
> +		if (fd < 0)
> +			goto out;
> +		ret = read(fd, supported_buf, sizeof(supported_buf));
> +		close(fd);
> +		if (ret < 0)
> +			goto out;
> +		snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
> +			 "%u", page_size);
> +		if (strstr(supported_buf, sectorsize_buf))
> +			sectorsize_checked = true;

Two comments here.
1: I think we should be checking sectorsize against the file rather than
page_size.
2: strstr seems too permissive, since it doesn't have a notion of
tokens. If not for the power_of_2 check above, we would admit all kinds
of silly things like 409. But even with it, we would permit "4" now and
with your example from the comment, "8", "16", and "32".

> +	}
> +out:
> +	if (!sectorsize_checked)
>  		warning(
>  "the filesystem may not be mountable, sectorsize %u doesn't match page size %u",
>  			sectorsize, page_size);

Do you have plans to change the contents of this string to match the new
meaning of the check, or is that too harmful to testing/automation?

> -- 
> 2.31.1
> 
