Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A11C1660F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBTPaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 10:30:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40261 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTPaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 10:30:21 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so3127044qto.7
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 07:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=snJBiMdXE08SfkF80Qfwz2Tx6mMzk6QrLBBeUt+1oGQ=;
        b=0645QS2/6FpMUCCaZHttw/4j9mts/TPqJ2GsyxXpwlHTNa56FjtrSf3AV1nZlZO5RX
         ggnKUt309etKxkgjouXANsbG9sV5UqprtG4TWpYAw5Fg8iqTGRcFM8G+w5ZwW8iu6T95
         F33ucqBJFKcmprjqVB/9iQ+MB9IkXgcd5iD0H2Pm8s65fAXPDRLduv6B5k2HDE+qbIf3
         jNCw0vCpLjzADkAlPn7WzM3XRF4B7qfJWczMHmY1TtpjQSvnXhuZXiaEV5/F8TPv+al3
         4sDhQHBmc46+NTyMbRkT7gtwFr1u7admYgiyp6/eykkAsIjdO8128UeUhFjjgxe1ChPI
         tFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=snJBiMdXE08SfkF80Qfwz2Tx6mMzk6QrLBBeUt+1oGQ=;
        b=JXCNkWUVHDz+uplUWSqpQqdVH/138oCLJ5zEIucAdwh1LS6G2UBlghlx+/BI/3ZG9d
         ZNZh+3uHv1/8ngZ9cCshGJLPEHCJvZyHwNpXu+fuCPB3I/Xr2/4UkKHMIuM/W7Hd34al
         Yuc8qym0NIhosw1YVJA2CIQ88ihKv5tWSi1RzBm9XcM6bJ3WQ65tz1x2k7ava3k/AJGg
         iUIHm/YDnF5Zq4plOSqPaJkmi6JPX46+grr2qY8GJoaSyhIqcdsxB2rvnHcoxnN9lwdL
         dLO09p6ibCnzzllIxMUcDqI0Kd5mshUVw3RI9+aMXHqnP740DFeDgcyG7CzKFXpyH7Ie
         W/Gw==
X-Gm-Message-State: APjAAAXSGzdkir0RC6qPOY8bc6nKP21J+8uiHqayUuXYch+pStYUT2nW
        YHQ5BkPZYkwAtdpkmqu/cqmCUHcxyPM=
X-Google-Smtp-Source: APXvYqwAT5q6JtLS1lofgtakXPOzFV5bx3wAoDhzPwMKvB3SLHASAR/AEYVQZA9t59LzQAF+P6BPmA==
X-Received: by 2002:ac8:5447:: with SMTP id d7mr14648158qtq.137.1582212618629;
        Thu, 20 Feb 2020 07:30:18 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k29sm1943120qtu.54.2020.02.20.07.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:30:17 -0800 (PST)
Subject: Re: [PATCH 4/4] Btrfs: implement full reflink support for inline
 extents
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200219140615.1641680-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4ac11008-d118-1877-151d-3e7da3e9a73a@toxicpanda.com>
Date:   Thu, 20 Feb 2020 10:30:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219140615.1641680-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/20 9:06 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are a few cases where we don't allow cloning an inline extent into
> the destination inode, returning -EOPNOTSUPP to user space. This was done
> to prevent several types of file corruption and because it's not very
> straightforward to deal with these cases, as they can't rely on simply
> copying the inline extent between leaves. Such cases require copying the
> inline extent's data into the respective page of the destination inode.
> 
> Not supporting these cases makes it harder and more cumbersome to write
> applications/libraries that work on any filesystem with reflink support,
> since all these cases for which btrfs fails with -EOPNOTSUPP work just
> fine on xfs for example. These unsupported cases are also not documented
> anywhere and explaining which exact cases fail require a bit of too
> technical understanding of btrfs's internal (inline extents and when and
> where can they exist in a file), so it's not really user friendly.
> 
> Also some test cases from fstests that use fsx, such as generic/522 for
> example, can sporadically fail because they trigger one of these cases,
> and fsx expects all operations to succeed.
> 
> This change adds supports for cloning all these cases by copying the
> inline extent's data into the respective page of the destination inode.
> 
> With this change test case btrfs/112 from fstests fails because it
> expects some clone operations to fail, so it will be updated. Also a
> new test case that exercises all these previously unsupported cases
> will be added to fstests.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/reflink.c | 212 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 152 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 7e7f46116db3..c19c87de6d4a 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -1,8 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
>   #include <linux/iversion.h>
> +#include <linux/blkdev.h>
>   #include "misc.h"
>   #include "ctree.h"
> +#include "btrfs_inode.h"
> +#include "compression.h"
> +#include "delalloc-space.h"
>   #include "transaction.h"
>   
>   #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
> @@ -43,30 +47,121 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> +static int copy_inline_to_page(struct inode *inode,
> +			       const u64 file_offset,
> +			       char *inline_data,
> +			       const u64 size,
> +			       const u64 datal,
> +			       const u8 comp_type)
> +{
> +	const u64 block_size = btrfs_inode_sectorsize(inode);
> +	const u64 range_end = file_offset + block_size - 1;
> +	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
> +	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
> +	struct extent_changeset *data_reserved = NULL;
> +	struct page *page = NULL;
> +	bool page_locked = false;
> +	int ret;
> +
> +	ASSERT(IS_ALIGNED(file_offset, block_size));
> +
> +	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, file_offset,
> +					   block_size);

This could potentially deadlock, as we could need to flush delalloc for this 
inode that we've dirtied pages for and not be able to make progress because we 
have this range locked.

Josef
