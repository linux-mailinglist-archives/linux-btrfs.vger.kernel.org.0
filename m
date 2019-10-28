Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C08E7438
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfJ1O6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 10:58:15 -0400
Received: from a4-5.smtp-out.eu-west-1.amazonses.com ([54.240.4.5]:51962 "EHLO
        a4-5.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbfJ1O6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 10:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1572274692;
        h=Subject:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=9YVQQUvfqC6mFjsKJvpPjFjLdOq/hxjkjLTrO1Wud/A=;
        b=Y6+qnpIHVot8Pg2R5oI/UmyG+fEugoYM96Inh6yK50efMM/okBztKtIVjuEY+gLv
        4IYVszW1vrmK91r0Pr/zc9bWmBt2VqBnLLzswaUJDcDdnw+B6Qc1kVNWZL/XCgcA1ex
        ks867Huvi+hJA0YmG8HlZpr5fO3q3h9as0h+uDzo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1572274692;
        h=Subject:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=9YVQQUvfqC6mFjsKJvpPjFjLdOq/hxjkjLTrO1Wud/A=;
        b=bozLQ+cM4x2FVingJINYtcMecdku7jwBwlQf2dS4AoAZQoA/I2NLl0dSWhHq7u0T
        N+oJhXpnA56WTKQaHpUcTKpyGq5OBQG/svusB8c0uRLKOPWAgMKRba6fKxEeLOdtjuw
        FexZJuuPqb83cwWFrWaJgMkbZ0+lAzJAfK9VIuio=
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
 <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
 <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
 <6364c263-0e47-9ff1-9288-7f6cadcc69bb@gmx.com>
 <CAL3q7H7B=dBmKNm7V6Pb13VKa2bWt9GjX25zh=e_7epqPx7LYA@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016e12dfe1c8-e501c103-ced0-48d4-8f5b-99bead594dac-000000@eu-west-1.amazonses.com>
Date:   Mon, 28 Oct 2019 14:58:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7B=dBmKNm7V6Pb13VKa2bWt9GjX25zh=e_7epqPx7LYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.10.28-54.240.4.5
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.10.2019 13:43 Filipe Manana wrote:
> On Mon, Oct 28, 2019 at 12:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> On 2019/10/28 下午7:30, Filipe Manana wrote:
>>> On Sun, Oct 27, 2019 at 4:51 PM Atemu <atemu.main@gmail.com> wrote:
>>>>> It's really hard to determine, you could try the following command to
>>>>> determine:
>>>>> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
>>>>>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
>>>>>
>>>>> Then which key is the most shown one and its size.
>>>>>
>>>>> If a key's objectid (the first value) shows up multiple times, it's a
>>>>> kinda heavily shared extent.
>>>>>
>>>>> Then search that objectid in the full extent tree dump, to find out how
>>>>> it's shared.
>>>> I analyzed it a bit differently but this should be the information we wanted:
>>>>
>>>> https://gist.github.com/Atemu/206c44cd46474458c083721e49d84a42
>>> That's quite a lot of extents shared many times.
>>> That indeed slows backreference walking and therefore send which uses it.
>>> While the slowdown is known, the memory consumption I wasn't aware of,
>>> but from your logs, it's not clear
>>> where it comes exactly from, something to be looked at. There's also a
>>> significant number of data checksum errors.
>>>
>>> I think in the meanwhile send can just skip backreference walking and
>>> attempt to clone whenever the number of
>>> backreferences for an inode exceeds some limit, in which case it would
>>> fallback to writes instead of cloning.
>> Long time ago I had a purpose to record sent extents in an rbtree, then
>> instead of do the full backref walk, go that rbtree walk instead.
>> That should still be way faster than full backref walk, and still have a
>> good enough hit rate.
> The problem of that is that it can use a lot of memory. We can have
> thousands of extents, tens of thousands, etc.
> Sure one can limit such cache to store up to some limit N, cache only
> the last N extents found (or some other policy), etc., but then either
> hits become so rare that it's nearly worthless or it's way too
> complex.
> Until the general backref walking speedups and caching is done (and
> honestly I don't know the state of that since who was working on that
> is no longer working on btrfs), a simple solution would be better IMO.
>
> Thanks.
Yeah, some short term plan to mitigate this would be appreciated. I am
running with this patch Qu Wenruo posted a while back:
https://patchwork.kernel.org/patch/9245287/

Some flag/switch/setting or limit to backref walking so this patch isn't
needed would be appreciated. Without this btrfs send is just too slow
once I have a few reflinks and snapshots. I haven't had a kernel panic,
though.

The problem is finding extents to reflink in the clone sources, correct?
My naive solution would be to create a (temporary) cache of (logical
extent) to (ino, offset) per send clone source. Then lookup every extent
in that cache. Maybe add a bloom filter as well (that should filter most
negatives). In some cases iterating over all extents in the clone
sources prior to the send operation would be faster than doing the
backref-walks during send. As an optimization it could be made
persistent and incrementally created from the parent snapshot's cache.
EXTENT_SAME would invalidate it/or it would need to update it.

