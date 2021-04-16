Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD073620D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhDPNZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhDPNZz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 09:25:55 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F4C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:25:30 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b139so23348701qkc.10
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ysckfYlfulGqFwzz3wVJ1CfghGjHJ7PFPlFP+3HD4J8=;
        b=jMhPt+vC4Kef4+hKs+22fonU0CXBcwiAzWCAqiAVOSzbSJwgwHkO97MVMsuf6Jh4jy
         XZ0Jzy/5CgUxsd7ovnhP/BBOJ4ChfCpEkzTO/CYWVLv4598F0/OYst69ic1CP8UzCXb9
         jdMzB8DOrBSNgQyHp32LXk+yvY/YcLLnhLqaxEHwCMmhCpUw1UGLxc/7VrhfJEPExOAf
         wCC1cZyfCG0Ei3OQiC8riqZjBExIciDWnkdm++vJnQ037a/kgcBUoLyef78HFacWPLst
         Z21xRhLVULkb10eGmdCVuKPk2HLtpFhtHgze/EM3czkEktVc9sD0ztKgzqzypjjUQetS
         QDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ysckfYlfulGqFwzz3wVJ1CfghGjHJ7PFPlFP+3HD4J8=;
        b=a6U3BCC2IXDo9GiLvRTzTR6grPQihu+rq5OxpZJY0cC825Yp9nitrEkkQ5HMQxAVJA
         2ICkPXhiUMZUnJKaZhfWW8a+qsXKbFdniM1izoJGwWuEK2qLt3P2r2tGs7jCa0v82Pn9
         T69INMG58p+sFSkhR6sV+X521kQsBx7MWmmOtzXVyDS6FnBaOpls6u/hzKfTYul/QMSa
         e72qhfCdXHLBFVjL02RVxEB38hAimhTTWz4bXoz2GZgRSXDhnpCOzh3G8zBmY4BXzww3
         W0gwK1zhk0Y7poFQ8IYmSwTfj/vZadimwlXWkIoIUKRTRUGynGHKUAYMzEDC03FruZ7j
         hh2Q==
X-Gm-Message-State: AOAM531MN52LrJIRZHvJz6XauvngDPY9fdZbDdxXf4eHMG9XTAz2lgsG
        X0603/Onx9a1RT2hS1ek1DFuYpjfLJni9w==
X-Google-Smtp-Source: ABdhPJxBxGSH3l1oM+J4pgLJAB9X5ulubISoTqCTIm9amRdIZkjO86AiseCsvQ0NxUFFM3a2L1xjgw==
X-Received: by 2002:a37:9982:: with SMTP id b124mr8995910qke.365.1618579529458;
        Fri, 16 Apr 2021 06:25:29 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u64sm695495qkc.127.2021.04.16.06.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 06:25:28 -0700 (PDT)
Subject: Re: [PATCH 04/42] btrfs: introduce submit_eb_subpage() to submit a
 subpage metadata page
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-5-wqu@suse.com>
 <475c3f1a-ffec-6a7a-1cb0-c7217c87367d@toxicpanda.com>
 <38f77eac-dd64-02dc-4130-105acba9e7a7@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8d076e67-97fc-b5a7-f1f2-81442c3ce8ee@toxicpanda.com>
Date:   Fri, 16 Apr 2021 09:25:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <38f77eac-dd64-02dc-4130-105acba9e7a7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 7:28 PM, Qu Wenruo wrote:
> 
> 
> On 2021/4/16 上午3:27, Josef Bacik wrote:
>> On 4/15/21 1:04 AM, Qu Wenruo wrote:
>>> The new function, submit_eb_subpage(), will submit all the dirty extent
>>> buffers in the page.
>>>
>>> The major difference between submit_eb_page() and submit_eb_subpage()
>>> is:
>>> - How to grab extent buffer
>>>    Now we use find_extent_buffer_nospinlock() other than using
>>>    page::private.
>>>
>>> All other different handling is already done in functions like
>>> lock_extent_buffer_for_io() and write_one_eb().
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 95 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index c068c2fcba09..7d1fca9b87f0 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -4323,6 +4323,98 @@ static noinline_for_stack int
>>> write_one_eb(struct extent_buffer *eb,
>>>       return ret;
>>>   }
>>> +/*
>>> + * Submit one subpage btree page.
>>> + *
>>> + * The main difference between submit_eb_page() is:
>>> + * - Page locking
>>> + *   For subpage, we don't rely on page locking at all.
>>> + *
>>> + * - Flush write bio
>>> + *   We only flush bio if we may be unable to fit current extent
>>> buffers into
>>> + *   current bio.
>>> + *
>>> + * Return >=0 for the number of submitted extent buffers.
>>> + * Return <0 for fatal error.
>>> + */
>>> +static int submit_eb_subpage(struct page *page,
>>> +                 struct writeback_control *wbc,
>>> +                 struct extent_page_data *epd)
>>> +{
>>> +    struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
>>> +    int submitted = 0;
>>> +    u64 page_start = page_offset(page);
>>> +    int bit_start = 0;
>>> +    int nbits = BTRFS_SUBPAGE_BITMAP_SIZE;
>>> +    int sectors_per_node = fs_info->nodesize >>
>>> fs_info->sectorsize_bits;
>>> +    int ret;
>>> +
>>> +    /* Lock and write each dirty extent buffers in the range */
>>> +    while (bit_start < nbits) {
>>> +        struct btrfs_subpage *subpage = (struct btrfs_subpage
>>> *)page->private;
>>> +        struct extent_buffer *eb;
>>> +        unsigned long flags;
>>> +        u64 start;
>>> +
>>> +        /*
>>> +         * Take private lock to ensure the subpage won't be detached
>>> +         * halfway.
>>> +         */
>>> +        spin_lock(&page->mapping->private_lock);
>>> +        if (!PagePrivate(page)) {
>>> +            spin_unlock(&page->mapping->private_lock);
>>> +            break;
>>> +        }
>>> +        spin_lock_irqsave(&subpage->lock, flags);
>>
>> writepages doesn't get called with irq context, so you can just do
>> spin_lock_irq()/spin_unlock_irq().
> 
> But this spinlock is used in endio function.
> If we don't use irqsave variant here, won't an endio interruption call
> sneak in and screw up everything?
> 

No, you use irqsave if the function can be called under irq.  So in the endio 
call you do irqsave.  This function can't be called by an interrupt handler, so 
just _irq() is fine because you just need to disable irq's.  Thanks,

Josef
