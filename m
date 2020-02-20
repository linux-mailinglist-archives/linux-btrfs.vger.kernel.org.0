Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC7166296
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 17:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgBTQ2C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 11:28:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40268 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBTQ2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 11:28:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so3274578qto.7
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 08:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UviHg6tUmGt8eoUwlbI62s/9N8nSevzkd+LqP7c9NqY=;
        b=A/n52aAfprsjs/eWWnLZhbZfO4rwWXs/XLXKC7ZSnyTSTocJdHUZ5zjwiE8yP8QISd
         4+eM7OZNPZYm0nUQL2MpopaNqSx++JowYEZp6oBPf2QwgOVgy+CvSn2VU8IrVDZW60ZB
         SHgD3KIGtEBhAHiEwQUKmZqcCBgq4LxxXH8RvWRLCdZWgqJesgQXyE7LLNsIhnTfTWVi
         QxOUiXnI1hEbaIw/23KZC8UoAugSwnAm/cchlhKnC4EpOkzp4wWQMnFEpf0hxRmejh6j
         93gqHx5peUDpG3JlFtdCdNzpAU7FjVgEI28EVEKUJKyeZ+tG4/9GovXFFw+FGWQ8xHwF
         1k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UviHg6tUmGt8eoUwlbI62s/9N8nSevzkd+LqP7c9NqY=;
        b=mqLXEHGc7MX0tXS0FZ8y4XlvXiMfk4aYyVx2k9iZJbXdyxXezRoYxrsngFHbGms0ml
         v5ELWm1J/teFLXgRBaSq50NAKr0UIkDKv3OO8Az3EQAGAu6iZPex94nzziKd2mE9a3R8
         d2V0AMBqwyX1MCHe03B6tmW6tzXIaeAf0/BvvWqD7yi8m/8Xkj9FO0HM/N2HN8yyCgWm
         cnFsS8o+8BarIUCoPLPyHBT5O6rCshN20axAlDTUqROwn4DGlVTIUOZoVpuEeAZm7ugG
         9Y7QkgWhgG1xpLrKdESo1VfISJ6WAvnYT6guIvwGC5PoGw9HbnbrXZPbekeSdGDm9oxL
         4REw==
X-Gm-Message-State: APjAAAUOQepAqhWxUUWhINCDJt0asxU+RsRLzSfms3sC6RwyDYNGa6In
        z8Y+MS8SZIjNpes8NBNQPTPUB+RkRdAgkw==
X-Google-Smtp-Source: APXvYqwXcq/biGMNLFREkfHGaJYecS0coWqLF2kBfpDmdV482XuKLCCF54r3N7+BNX+E8XL8O3t0QQ==
X-Received: by 2002:aed:33e2:: with SMTP id v89mr27364868qtd.162.1582216080633;
        Thu, 20 Feb 2020 08:28:00 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c26sm2357qtn.19.2020.02.20.08.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 08:27:59 -0800 (PST)
Subject: Re: [PATCH 4/4] Btrfs: implement full reflink support for inline
 extents
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200219140615.1641680-1-fdmanana@kernel.org>
 <4ac11008-d118-1877-151d-3e7da3e9a73a@toxicpanda.com>
 <CAL3q7H5buWQjhR2JTNyPVhZStJui8DKpUBhv1J_m8FVsbBWZ=Q@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3beb82d2-f4fc-8c49-1262-e23aa70680bc@toxicpanda.com>
Date:   Thu, 20 Feb 2020 11:27:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5buWQjhR2JTNyPVhZStJui8DKpUBhv1J_m8FVsbBWZ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/20/20 11:09 AM, Filipe Manana wrote:
> On Thu, Feb 20, 2020 at 3:30 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 2/19/20 9:06 AM, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> There are a few cases where we don't allow cloning an inline extent into
>>> the destination inode, returning -EOPNOTSUPP to user space. This was done
>>> to prevent several types of file corruption and because it's not very
>>> straightforward to deal with these cases, as they can't rely on simply
>>> copying the inline extent between leaves. Such cases require copying the
>>> inline extent's data into the respective page of the destination inode.
>>>
>>> Not supporting these cases makes it harder and more cumbersome to write
>>> applications/libraries that work on any filesystem with reflink support,
>>> since all these cases for which btrfs fails with -EOPNOTSUPP work just
>>> fine on xfs for example. These unsupported cases are also not documented
>>> anywhere and explaining which exact cases fail require a bit of too
>>> technical understanding of btrfs's internal (inline extents and when and
>>> where can they exist in a file), so it's not really user friendly.
>>>
>>> Also some test cases from fstests that use fsx, such as generic/522 for
>>> example, can sporadically fail because they trigger one of these cases,
>>> and fsx expects all operations to succeed.
>>>
>>> This change adds supports for cloning all these cases by copying the
>>> inline extent's data into the respective page of the destination inode.
>>>
>>> With this change test case btrfs/112 from fstests fails because it
>>> expects some clone operations to fail, so it will be updated. Also a
>>> new test case that exercises all these previously unsupported cases
>>> will be added to fstests.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/reflink.c | 212 ++++++++++++++++++++++++++++++++-------------
>>>    1 file changed, 152 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
>>> index 7e7f46116db3..c19c87de6d4a 100644
>>> --- a/fs/btrfs/reflink.c
>>> +++ b/fs/btrfs/reflink.c
>>> @@ -1,8 +1,12 @@
>>>    // SPDX-License-Identifier: GPL-2.0
>>>
>>>    #include <linux/iversion.h>
>>> +#include <linux/blkdev.h>
>>>    #include "misc.h"
>>>    #include "ctree.h"
>>> +#include "btrfs_inode.h"
>>> +#include "compression.h"
>>> +#include "delalloc-space.h"
>>>    #include "transaction.h"
>>>
>>>    #define BTRFS_MAX_DEDUPE_LEN        SZ_16M
>>> @@ -43,30 +47,121 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
>>>        return ret;
>>>    }
>>>
>>> +static int copy_inline_to_page(struct inode *inode,
>>> +                            const u64 file_offset,
>>> +                            char *inline_data,
>>> +                            const u64 size,
>>> +                            const u64 datal,
>>> +                            const u8 comp_type)
>>> +{
>>> +     const u64 block_size = btrfs_inode_sectorsize(inode);
>>> +     const u64 range_end = file_offset + block_size - 1;
>>> +     const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
>>> +     char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
>>> +     struct extent_changeset *data_reserved = NULL;
>>> +     struct page *page = NULL;
>>> +     bool page_locked = false;
>>> +     int ret;
>>> +
>>> +     ASSERT(IS_ALIGNED(file_offset, block_size));
>>> +
>>> +     ret = btrfs_delalloc_reserve_space(inode, &data_reserved, file_offset,
>>> +                                        block_size);
>>
>> This could potentially deadlock, as we could need to flush delalloc for this
>> inode that we've dirtied pages for and not be able to make progress because we
>> have this range locked.
> 
> But we have already flushed the range before, after locking the inode
> and waiting for dio requests,
> so during the reflink operation no one should be able to dirty pages
> in the range. Or did I miss some edge case?

I had it in my head that we could do this multiple times, but that's stupid 
because there's only one inline extent to copy from.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
