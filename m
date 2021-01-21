Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694982FE2F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 07:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbhAUGgD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 01:36:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:54765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbhAUGfG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 01:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611210766;
        bh=aOut60LPOnDil1HjuYg7wSKFbMpgFlrB5QkJ647IOlo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JkW+Kvd7zPkFhuI7TCmOWM7gXihY1EUiES/DOxoISSgZmmrw3WqTl4LqfrsS6KgB6
         5jLtXp5MrTRCih3VArcXz3LJTrpfCYhDghwAiJXWR5x+vS33We0dL8oWfvoky6l0Hk
         CBjwLHWcZflufVHyqpZWN4XdIHfn+bnwgQcYPiTw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1lPwUc3e7T-00NySj; Thu, 21
 Jan 2021 07:32:46 +0100
Subject: Re: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error
 bits in __process_pages_contig()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-2-wqu@suse.com>
 <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c4bd841c-6657-5a72-85ac-fc8359c87a74@gmx.com>
Date:   Thu, 21 Jan 2021 14:32:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G37dwui//e4n1Gp/TpJlGlVkpG8QGki6pVSZu2eIpZGWdn+SS92
 yYbxdrWj7MR8lMcrbLh3pwKRRPZSDeGqHuIJzjaxY19WyPcxjpPqVw0JSRcfIMdcRTBqIoy
 a8MQAoQfsBZiy4+kMpTerx+iZZ8gvMXXrnJc1O7mtD3qQ2j7ir0E6YtCqj7tr4vDubsjKx8
 U8Q6s5NxO2zYDyMK6QC0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NuKkhEKf4Lg=:e/MrFA0FwirrpX6yk1QWRp
 EDOraJydrMAle8C4UuKcQESnea0hcSTeToIqh08kL4jZ164MC4xoZx9P8mPKESVEfrdi285SI
 1XNofyF+jRsRRM/aVfl+7RxckU+OZ86nZ/wSvnySSQVCI9oyCYNtb2BEE83h10HTX8qu3/Ocg
 illrnkqIEiG3hWOfUW2Vyh9YUYLZU6rGXyz3GQ3RTjYwGYDMX14A/wzn50QIkA8sXxpdS0sn+
 JtbbZIUOTP+jjNrkPkQ2XupP1xOHpzaqKs6eawR1ouRxPlQyLhUJDLrDBEsl7n56spDO7Dc57
 cxHh6LwD5YBKRXd/Od8/x7+vZMvcYMNDfzUn5qsR3d7osE45oK1DEfLPbHUN4F4eXZetYN7Yh
 WLimUn0i5BgL4QaaB6WyjcrcScAnbgoguAkgMVFyfu1o++KJuwDNc7EIVx/nDqQq7CJUAV6zk
 vx0bl3z3OrsRSM1hJFDbxgtlV+1aPY2jp1eBdJcEQs/071S76E4APT9Z9LMgStDX/VDZDchSf
 C5msXsXpFJOz2Qdju0uUMohLn5g6xpkScYDF889vyzsW8wDscvC3LFIqa5V6tcBHkyCgvysOr
 PEWmai2H3Dt9CCMmnvfmEVbzkSQkw5ED7uF9mc9aat7/XBFIV1e6MQe/PbGnDl3WQZwyfolaP
 HBlEyseGP09k3Ye6YKMSqYmhSrvEq3UHqFUk1vn6JCHiolUOIQyZoUuYv7CLGLS7QbQbYTOfo
 4cqA86XhgyfkIvzwAaQHJAHOWtP7nkkrdPYZGXem2khm06Ok3z80vWdfr1O6FlJk8hooIsCxP
 Ch9rirK0xRY4qGnMDz5P+8VWi/LuYBb/LfqREB5MALYbCTPa+fIeQ+HuyXq/EaVs1cxpkOSR0
 tvoXjcT4tfIBZTuTfGig==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8A=E5=8D=885:41, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>> When __process_pages_contig() get called for
>> extent_clear_unlock_delalloc(), if we hit the locked page, only Private=
2
>> bit is updated, but dirty/writeback/error bits are all skipped.
>>
>> There are several call sites call extent_clear_unlock_delalloc() with
>> @locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBACK
>>
>> - cow_file_range()
>> - run_delalloc_nocow()
>> - cow_file_range_async()
>> =C2=A0=C2=A0 All for their error handling branches.
>>
>> For those call sites, since we skip the locked page for
>> dirty/error/writeback bit update, the locked page will still have its
>> dirty bit remaining.
>>
>> Thankfully, since all those call sites can only be hit with various
>> serious errors, it's pretty hard to hit and shouldn't affect regular
>> btrfs operations.
>>
>> But still, we shouldn't leave the locked_page with its
>> dirty/error/writeback bits untouched.
>>
>> Fix this by only skipping lock/unlock page operations for locked_page.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Except this is handled by the callers.=C2=A0 We clear_page_dirty_for_io(=
) the
> page before calling btrfs_run_delalloc_range(), so we don't need the
> PAGE_CLEAR_DIRTY, it's already cleared.=C2=A0 The SetPageError() is hand=
led
> in the error path for locked_page, as is the
> set_writeback/end_writeback.=C2=A0 Now I don't think this patch causes
> problems specifically, but the changelog is at least wrong, and I'd
> rather we'd skip the handling of the locked_page here and leave it in
> the proper error handling.=C2=A0 If you need to do this for some other r=
eason
> that I haven't gotten to yet then you need to make that clear in the
> changelog, because as of right now I don't see why this is needed.=C2=A0=
 Thanks,

This is mostly to co-operate with a later patch on
__process_pages_contig(), where we need to make sure page locked by
__process_pages_contig() is only unlocked by __process_pages_contig() too.

The exception is after cow_file_inline(), we call
__process_pages_contig() on the locked page, making it to clear page
writeback and unlock it.

That is going to cause problems for subpage.

Thus I prefer to make __process_pages_contig() to clear page dirty/end
writeback for locked page.

Thanks,
Qu
>
> Josef
