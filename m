Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680173A20D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 01:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFIXdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 19:33:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:50835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhFIXdj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 19:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623281502;
        bh=u/sMZpt6MycAIiJDw2YX4XKh/08uCtNVfmWdfWoB2Rw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k17+taO53wami08aPqImv3cWIGC+s4aLjiF0BBZ4jk62bDSDEQpxToVNkRYfLQBT+
         1l4oce1J073LqI+Rd9w6FDrqDf5n0K7LXXhrF5sOwVUQw52ODlnVNqNczAuRRwSKrw
         ESYx2r/l8/ieJiItdU/CyM7CNIS0YE0H2oXGqu2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCbIn-1m0EE21SBH-009kVW; Thu, 10
 Jun 2021 01:31:42 +0200
Subject: Re: [PATCH v3 00/10] btrfs: defrag: rework to support sector perfect
 defrag
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210608025927.119169-1-wqu@suse.com>
 <20210609152650.GC27283@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <13f125a6-c544-e864-2834-71c49fa32145@gmx.com>
Date:   Thu, 10 Jun 2021 07:31:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609152650.GC27283@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eix3oPDxupL5F21kVTlgCyi5pegLt8qwT0MErjx4+5dnZRvxukM
 OeSjoC29vE6WmEwv0zqBC6vHQ/+pne1vU1DpBPN/ZXNIFTVQcwUsvg+4784xMMlCGwfW00U
 PI9B+cc7pxIuLKN9IQcZIoabsPBYV6oO5B9vRFKLxGMB17j+jGTY3CXRnw773zqeRm4fpek
 gOfQAKtdkFLIg7+/glhpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4mIO/6qDRuQ=:2ujCZU1xqmPM8HVKNOO+yn
 jtzlAxm6SNUtftBUEKeIEuTTXXs1wKKOeO8NTRnmwlY/MVZwO6A6k4Kio1cXZglrYr+guB67n
 7/Xn7wI2H6X7M3icrmPnMkOsCMx7y3PKxx3DviPv5F+VN49gZFd2tOSPEzkpPdBtIrY62BCSg
 wz32isTpE9hVhOBnsPC8Wg9bHowg6pIZJIQtikErQ/c0VyqVUs7AF3Mn7cwufeNLJkMQB+DTb
 5vLUoJNcu8NWWPfh3WSk/kPXIKIpqYKt9u9UXMr6WRkKuSBYm9TCA4/BPuk3DrjI6F8c0eqKM
 7+qrtmywdikBuG9V+1L7hLvpXLXEQvDpW4YrGq2OuuikbjUioGzgHwlPiAmgjr6lUI1WbXJv/
 Uv5huvRHG7c3jPUBtXHEqZ6A1n56LgMDxf47t1+Qdl44uaDnXjNB6TDfD3rfToYCQMg9H1Bvq
 oFOj1FZl1d2SMqR0iBN7PZNrIau4UWYgxfR5A1FP6nAp/bJZP4oS5kmlKgeRfTDnmEkDU3Pcb
 cL4e20MVjS8UgZ+22Wy1igCUj8JSghb7fRsi6sa7u/Hi7KOCNSbGVDgswBS1+ovki3XxtD1U2
 ld80sjs5tOZ8yzROJ+PncPklcDn9+SSwDLzvHqYj/o9fxjJPU57N14VVoqjoRq9TNq5lT5v99
 G2ttPi0bogmTqf9kgXnFH6mJmOH6Lwb9uOIZZSXWR+I6FG9SajfvkJhRh92eQeYX2hhE/rIGt
 3oO/3/+4auY1i99sizUloBfQK6jGNGZ9SJPNeEp0GsRbFOGHnIx0ULR6K/ffjKwJjGQp7f4q3
 uIo9lexzq3+4/roEdcVUT6uPuxSQ86PT2dW9ZEsqeRjKlirSpkrSYtsSKx66zqGwxL1iebsao
 gLDVmeo+DWoKo1jMMm96nSlAB0mZ6P0sDMDPwJBpaBG2h7GCbTTj8njHFsGWKjbLiiSsEtq9o
 s33nxccULQ7Tj2cMHHxwTH9dl2S9l+syDxD48LBubot5NdaIPoxS4gJhX6jloI4LQkspSJGD9
 uZkeW1HgFfYIQ9kTA6A65VbNZ+wZD2lOJylMxcXsw51bt19TmYYR59GW93jtDBY6/52o2zHyc
 C0+/3hMO/BecXBi4b+sYu/pueXPeVG59dV3Ka83BO6IZubK69gjTxeNag==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/9 =E4=B8=8B=E5=8D=8811:26, David Sterba wrote:
> On Tue, Jun 08, 2021 at 10:59:17AM +0800, Qu Wenruo wrote:
>> This branch is based on subpage RW branch, as the last patch needs to
>> enable defrag support for subpage cases.
>>
>> But despite that one, all other patches can be applied on current
>> misc-next.
>>
>> [BACKGROUND]
>> In subpage rw branch, we disable defrag completely due to the fact that
>> current code can only work on page basis.
>>
>> This could lead to problems like btrfs/062 crash.
>>
>> Thus this patchset will make defrag to work on both regular and subpage
>> sectorsize.
>>
>> [SOLUTION]
>> To defrag a file range, what we do is pretty much like buffered write,
>> except we don't really write any new data to page cache, but just mark
>> the range dirty.
>>
>> Then let later writeback to merge the range into a larger extent.
>>
>> But current defrag code is working on per-page basis, not per-sector,
>> thus we have to refactor it a little to make it to work properly for
>> subpage.
>>
>> This patch will separate the code into 3 layers:
>> Layer 0:	btrfs_defrag_file()
>> 		The defrag entrace
>> 		Just do proper inode lock and split the file into
>> 		page aligned 256K clusters to defrag
>>
>> Layer 1:	defrag_one_cluster()
>> 		Will collect the initial targets file extents, and pass
>> 		each continuous target to defrag_one_range()
>>
>> Layer 2:	defrag_one_range()
>> 		Will prepare the needed page and extent locking.
>> 		Then re-check the range for real target list, as initial
>> 		target list is not consistent as it doesn't hage
>> 		page/extent locking to prevent hole punching.
>>
>> Layer 3:	defrag_one_locked_target()
>> 		The real work, to make the extent range defrag and
>> 		update involved page status
>>
>> [BEHAVIOR CHANGE]
>> In the refactor, there is one behavior change:
>>
>> - Defraged sector counter is based on the initial target list
>>    This is mostly to avoid the paremters to be passed too deep into
>>    defrag_one_locked_target().
>>    Considering the accounting is not that important, we can afford some
>>    difference.
>
> As you're going to resend, please fix all occurences of 'defraged' to
> 'defragged'.
>
> I'll give the patchset some testing bug am not sure if it isn't too
> risky to put it to the 5.14 queue as it's about time to do only safe
> changes.
>

Please keep the branch out of the 5.14 queue.
It's safe to test, but I don't think the current test coverage is
acceptable enough for defrag.

The latest branch in my github is safe enough for now, but considering
how few test cases there are dedicated for defrag, and I'm not yet
convinced even the existing defrag code is safe.

Thanks,
Qu
