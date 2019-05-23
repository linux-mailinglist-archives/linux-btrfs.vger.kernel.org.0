Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DA284F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfEWRbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 13:31:11 -0400
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:42530 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730904AbfEWRbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 13:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1558632668;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=4DW75E2wVpw1GJhdVrhwi8ZF7kDVomfQfNbBu9MZBSw=;
        b=ejY/vpC5htUt3gMELYVb50zqPQLYWkv3Mjuq4fzUKMV/5xVMKM6t8mohKOT8tmgD
        GmwViFrPrb1GHgJbuOXTw39QK96Q9fY6iAh65xpYSvrWWJdi7r5Mmuv6oCTIr6FSz+a
        /zr1Cjp5I/n1G2hq7AoDJs1LIUtqetaQS2dHvIzY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1558632668;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=4DW75E2wVpw1GJhdVrhwi8ZF7kDVomfQfNbBu9MZBSw=;
        b=TytXiuKui9o+wamGwzB1PKhwbT6kEey5Hbayay1Hs2pHLVjGijKCW6i1EHf3QjrT
        HuvhVE/mpv6xp+esl9dLJa+u1qDum2gzGUPxbnrnrpQs34Bkin6z9FRyXgU6CBIphm8
        HzWe7csFuAdMA83KjCPxSemNw/mguc424HOcQasQ=
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
 <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
 <979559b5-1fb5-debd-e101-6e4227348426@gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016ae5bf1e51-7cedfda5-aff2-4ecb-801b-ec8c04ce84b5-000000@eu-west-1.amazonses.com>
Date:   Thu, 23 May 2019 17:31:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <979559b5-1fb5-debd-e101-6e4227348426@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.05.23-54.240.4.2
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.05.2019 19:13 Austin S. Hemmelgarn wrote:
> On 2019-05-23 12:24, Chris Murphy wrote:
>> On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
>> <ahferroin7@gmail.com> wrote:
>>>
>>> On 2019-05-22 14:46, Cerem Cem ASLAN wrote:
>>>> Could you confirm or disclaim the following explanation:
>>>> https://unix.stackexchange.com/a/520063/65781
>>>>
>>> Aside from what Hugo mentioned (which is correct), it's worth
>>> mentioning
>>> that the example listed in the answer of how hardware issues could
>>> screw
>>> things up assumes that for some reason write barriers aren't honored.
>>> BTRFS explicitly requests write barriers to prevent that type of
>>> reordering of writes from happening, and it's actually pretty
>>> unusual on
>>> modern hardware for those write barriers to not be honored unless the
>>> user is doing something stupid (like mounting with 'nobarrier' or using
>>> LVM with write barrier support disabled).
>>
>> 'man xfs'
>>
>>         barrier|nobarrier
>>                Note: This option has been deprecated as of kernel
>> v4.10; in that version, integrity operations are always performed and
>> the mount option is ignored.  These mount options will be removed no
>> earlier than kernel v4.15.
>>
>> Since they're getting rid of it, I wonder if it's sane for most any
>> sane file system use case.
>>
> As Adam mentioned, it's mostly volatile storage that benefits from
> this.  For example, on the systems where I have /var/cache configured
> as a separate filesystem, I mount it with barriers disabled because
> the data there just doesn't matter (all of it can be regenerated
> easily) and it gives me a few percent better performance.  In essence,
> it's the mostly same type of stuff where you might consider running
> ext4 without a journal for performance reasons.
>
> In the case of XFS, it probably got removed to keep people who fancy
> themselves to be power users but really have no clue what they're
> doing from shooting themselves in the foot to try and get some more
> performance.
>
> IIRC, the option originally got added to both XFS and ext* because
> early write barrier support was a bigger performance hit than it is
> today, and BTRFS just kind of inherited it.

When I google for it I find that flushing the device can also be
disabled via

echo "write through" > /sys/block/$device/queue/write_cache

I actually used nobarrier recently (albeit with ext4), because a steam
download was taking forever (hours), when remounting with nobarrier it
went down to minutes (next time I started it with eatmydata). But ext4
fsck is probably able to recover nobarrier file systems with unfortunate
powerlosses and btrfs fsck... isn't. So combined with the above I'd
remove nobarrier.

