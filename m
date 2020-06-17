Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DB1FD43E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQSTc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFQSTb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 14:19:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D123C06174E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 11:19:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so2282109qtq.11
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ygmg5pJ3Q6RAkZDdpWTzoQBPWiWmPTO6zFsDmZl2Zo=;
        b=cT52h2ZnmsufofRf+wMCIPQ8EvOaRDlYtQ86xpEeukmIV/6RocEm/QAZzGG9f6e3iv
         UHMbYzxQEKqa5FRxWNpDE3DaTNWeHbQHY2tX19ysOUTcJZWvNDJchHwcsB4HiWZg2apY
         w3d1tu0Ucnqvt1p+i9KuIQajfh+69QROTYS+5ymu5uYMoChDVtspjy+35W+mhSYxdu4w
         CCaKA2W8hkdmnE3dhYQJD+PAVJVjSdVG3L0k7qm8HA4v/axEbyMYUgWwWiJMUz7HcU7E
         6SDJZ1HpbD9ZyujyiQJqLh0m7c0MXNJeEB/wk8HfFGHmAAohxdclLYRKtuofX/zyudpD
         meqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ygmg5pJ3Q6RAkZDdpWTzoQBPWiWmPTO6zFsDmZl2Zo=;
        b=bnD4hREJet8S4Lt/Mb5tFQKhO+eyTP23YXHA7YoyibuG66MAMqYLclwSCJUTny2Fui
         0Msq2dD6uqM8zvw0z3cUlgzDzfV/RfkRxqA8nEpatOj08W7XCS5Oy2HTyZC3FFo7Y2OD
         9MY8Jis9C4WIZJx1ol++w+wmSeN0I7T68Icr3bgy3ZdGwAPjwaxiE+DAaWZktKlWx+VC
         GTnTUgiIb9hMZOdI/9e/zPZRh24TwOrdft84/LMY78i1Cb452pY/MAy4Gdjv+ub0vJfq
         KGgvsovRw0iwhJ5cFCMsIOXPc8qpP1dF4Xvzs8F471kjDUZTjUtigCmnvV+mMZzawAih
         hiNA==
X-Gm-Message-State: AOAM532U+2phF9F1jx5R5sFRN8ar5oAmAeDtxpM/iLhhYLriTY3CDxkj
        AWMHEx9qESoF+sot+BGyr8Tx1Q==
X-Google-Smtp-Source: ABdhPJyuInpJpDChXaQb7d+bR+LEx4TD8K3MTPdfbyh1qpch1hfnlKkDXVNs6VwJEYxzaYm/9qYPpQ==
X-Received: by 2002:ac8:7252:: with SMTP id l18mr361264qtp.71.1592417969382;
        Wed, 17 Jun 2020 11:19:29 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1193? ([2620:10d:c091:480::1:6146])
        by smtp.gmail.com with ESMTPSA id u10sm671035qth.32.2020.06.17.11.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 11:19:28 -0700 (PDT)
Subject: Re: [PATCH btrfs/for-next] btrfs: fix fatal extent_buffer readahead
 vs releasepage race
To:     fdmanana@gmail.com, Chris Mason <clm@fb.com>
Cc:     Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
References: <20200617162746.3780660-1-boris@bur.io>
 <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
 <ADB20899-1E88-4546-BEB5-4F2165386184@fb.com>
 <CAL3q7H5q1ocLa6HjSfiXgVJ67kyfqNBDhcwMqeRVDfbiyr5-tg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1fdc19e9-8517-efb3-78c7-6f4d0152d87f@toxicpanda.com>
Date:   Wed, 17 Jun 2020 14:19:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5q1ocLa6HjSfiXgVJ67kyfqNBDhcwMqeRVDfbiyr5-tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/17/20 2:11 PM, Filipe Manana wrote:
> On Wed, Jun 17, 2020 at 6:43 PM Chris Mason <clm@fb.com> wrote:
>>
>> On 17 Jun 2020, at 13:20, Filipe Manana wrote:
>>
>>> On Wed, Jun 17, 2020 at 5:32 PM Boris Burkov <boris@bur.io> wrote:
>>>
>>>> ---
>>>>   fs/btrfs/extent_io.c | 45
>>>> ++++++++++++++++++++++++++++----------------
>>>>   1 file changed, 29 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index c59e07360083..f6758ebbb6a2 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -3927,6 +3927,11 @@ static noinline_for_stack int
>>>> write_one_eb(struct extent_buffer *eb,
>>>>          clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
>>>>          num_pages = num_extent_pages(eb);
>>>>          atomic_set(&eb->io_pages, num_pages);
>>>> +       /*
>>>> +        * It is possible for releasepage to clear the TREE_REF bit
>>>> before we
>>>> +        * set io_pages. See check_buffer_tree_ref for a more
>>>> detailed comment.
>>>> +        */
>>>> +       check_buffer_tree_ref(eb);
>>>
>>> This is a whole different case from the one described in the
>>> changelog, as this is in the write path.
>>> Why do we need this one?
>>
>> This was Josef’s idea, but I really like the symmetry.  You set
>> io_pages, you do the tree_ref dance.  Everyone fiddling with the write
>> back bit right now correctly clears writeback after doing the atomic_dec
>> on io_pages, but the race is tiny and prone to getting exposed again by
>> shifting code around.  Tree ref checks around io_pages are the most
>> reliable way to prevent this bug from coming back again later.
> 
> Ok, but that still doesn't answer my question.
> Is there an actual race/problem this hunk solves?
> 
> Before calling write_one_eb() we increment the ref on the eb and we
> also call lock_extent_buffer_for_io(),
> which clears the dirty bit and sets the writeback bit on the eb while
> holding its ref_locks spin_lock.
> 
> Even if we get to try_release_extent_buffer, it calls
> extent_buffer_under_io(eb) while holding the ref_locks spin_lock,
> so at any time it should return true, as either the dirty or the
> writeback bit is set.
> 
> Is this purely a safety guard that is being introduced?
> 
> Can we at least describe in the changelog why we are adding this hunk
> in the write path?
> All it mentions is a race between reading and releasing pages, there's
> nothing mentioned about races with writeback.
> 

I think maybe we make that bit a separate patch, and leave the panic fix on it's 
own.  I suggested this because I have lofty ideas of killing the refs_lock, and 
this would at least keep us consistent in our usage TREE_REF to save us from 
freeing stuff that may be currently under IO.

I'm super not happy with our reference handling coupled with releasepage, but 
these are the kind of hoops we're going to have to jump through until we have 
some better infrastructure in place to handle metadata.  Thanks,

Josef
