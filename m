Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8158139A03
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 20:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMTPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 14:15:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:37536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMTPX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 14:15:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C238AACD9;
        Mon, 13 Jan 2020 19:15:20 +0000 (UTC)
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
 <20200108150841.GH3929@twin.jikos.cz> <20200108151159.GI3929@twin.jikos.cz>
 <85422cb2-e140-563b-fadd-f820354ed156@gmx.com>
 <20200109143742.GN3929@twin.jikos.cz>
 <f8458b9c-0b6c-024e-399d-ea530abd1204@gmx.com>
 <d4322bd6-c2dd-e3e6-e8eb-2cda1963f9d7@gmx.com>
 <8b1245b4-ecac-57c1-d1bf-28360f089f6d@gmx.com>
 <20200113171903.GZ3929@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <df355d89-d126-0d82-0beb-f76cc8d0f9c3@suse.com>
Date:   Mon, 13 Jan 2020 21:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113171903.GZ3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.01.20 г. 19:19 ч., David Sterba wrote:
> On Mon, Jan 13, 2020 at 12:41:45PM +0800, Qu Wenruo wrote:
>> On 2020/1/10 上午8:58, Qu Wenruo wrote:
>>> On 2020/1/10 上午8:21, Qu Wenruo wrote:
>>>> On 2020/1/9 下午10:37, David Sterba wrote:
>>>>> On Thu, Jan 09, 2020 at 01:54:34PM +0800, Qu Wenruo wrote:
>>>>> We use smp_mb() because this serializes memory among multipe CPUs, when
>>>>> one changes memory but stores it to some temporary structures, while
>>>>> other CPUs don't see the effects. I'm sure you've read about that in the
>>>>> memory barrier docs.
>>>
>>> I guess the main difference between us is the effect of "per-cpu
>>> viewable temporary value".
>>>
>>> It looks like your point is, without rmb() we can't see consistent
>>> values the writer sees.
>>>
>>> But my point is, even we can only see a temporary value, the
>>> __before_atomic() mb at the writer side, ensures only 3 possible
>>> temporary values combination can be seen.
>>> (PTR, DEAD), (NULL, DEAD), (NULL, 0).
>>>
>>> The killed (PTR, 0) combination is killed by that writer side mb.
>>> Thus no need for the reader side mb before test_bit().
>>>
>>> That's why I insist on the "test_bit() can happen whenever they like"
>>> point, as that has the same effect as schedule.
>>
>> Can we push the fix to upstream? I hope it to be fixed in late rc of v5.5.
> 
> Yes the plan is to push it to 5.5-rc so we can get the stable backports.
> 
> About the barriers, we seem to have a conclusion to use smp_rmb/smp_wmb
> and not the smp_mb__before/after_atomic. Zygo also tested the patch and
> reported it's ok so I don't want to hold it back.
> 
> Understanding the memory barriers takes time to digest (which basically
> means to develop a cpu simulator in ones head with speculative writes
> and execution and then keep sanity when reasoning about them).

Or simply using the memory model tool and just write a "simple" litmus
test to see what's possible and what not in the given situation. (And
no, I don't think it's that trivial to do that either :) )

> 
