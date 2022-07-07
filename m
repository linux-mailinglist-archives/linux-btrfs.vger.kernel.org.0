Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3E569ECB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 11:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiGGJpn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 05:45:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B0233370
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657187127;
        bh=1vvmSGrAMhoKYG3AYzaFrvOqSfRzpFVRA+oQ4F0MkBk=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=MaJjMDXKoPL2mXAcnvO6IXR62mtYYAZ0xyG0qAiPdYBboqFi628m4wxE+or71f9bF
         Pa76nXuquUa4mvuyHhgA+t4upC8vwH7A9S266f5T9/MpAVtCkSJyO4QbHK3RZShN8q
         JCVJW9WouTm6fMKPAodkE7Hm7+km+b7t7CL2IgK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1nHhWV1H2D-00sOy2; Thu, 07
 Jul 2022 11:45:26 +0200
Message-ID: <f2179520-f8d1-d029-661e-56d4a33b5b9d@gmx.com>
Date:   Thu, 7 Jul 2022 17:45:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
 <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
 <PH0PR04MB7416EDF3C4EC0AA72A2C2A619B839@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
In-Reply-To: <PH0PR04MB7416EDF3C4EC0AA72A2C2A619B839@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgARFgbVbIj0OODLtP5LrotinTZOsbcJw0fOPF0Hi7mphcKQJYV
 EnAgxgGoTgSjBiWRI7D+hsXGcGhxJBxsF8auApM+LiOyqkX8bLXLUBXbZ6aN0zEu9w5p6m1
 qav/bY1A3Ez/bHVpyhelE+V9I6s9LPOlNkhFGW6YgJRMmJnrfXmzXoZUD2lPAboI5UXv/pw
 N9iNsrg3E3WaM7yvwTyog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pc/TLQOnQcE=:PuQNPYVEPTQ3qrYvtOZak/
 QmZaYilc4hgnheJiUhbHPCdUucqB3f1NskJvw6gfXx0n5ibP0sS2cCMBz26QtZgagGKLCps3A
 +YziYMpZWnYz/fqfX+XAEZrxpkl40Z/saRtdqSZYK/pQGCBjSwWODiQ8mEhPx+bBR0fOtIy2r
 RmetltJPhvUzHUlOKrhdmXDROaZu429Qg0tSEe5G1C8Nzu71PU1aeVo9brJujy+snKQgXRxVX
 gxixyDb3b4BEu10MOZ7OvSij3QGpG7N5X8Fh6tbvYp7wnKtw614PwHH8Ie7sZwUbIuVqTxXgd
 mjImGQwRfczGD8wllvjScmsQPRhK+EYWIzCPLb9GmKo+Bob84Wv1wSlPjlbP54XzWh08ZRa4g
 LDdA2G+PjPb1uTkWNEdbH/5C1aPhiIIrBdHCiEpDC9Lis5sResi6Y94OhVkoHvtGaaX6d2vSD
 u2GhuHyPpGbVMHc9j1ZczzRp6KjDfe7YkkuJFf+2sGpKz59QZXDCLbotMRJuSL5glv/fkRgWl
 fej5+MZLWHJndlu44t1RM6fBJ8nBwKoi9RMhM2g8R568CLH2Bpf+xl7bnqNhPEQcDGhFxLNhY
 4+4Z1blPWbxKQBLLPZr+yxpuScX/hkQenLp+3NvoXhYvEqfmlBsEYB6VIezDOMMXaV08tOZCy
 qZUZiamTIgQvSmApQIItlFG2wE3o9lf+dvV7l9KvP3G9BMlaiPoQ3hb94LGPkv7ctLKtmMxz9
 vwfSTMGVYdxdEWhqLM1nv/NnXC76BV/KcTN+VnlWzxY+2xLpDaYzrctCdaj3zfiN60K62xBgi
 3CyqOEQ5Tvh9g9rqB0Y4Ef6QBDwWFmZGtGysIjPSEJGG67wb3+owjzVXmAeNnNxLwSdlvfQVk
 jQYcaGJWyTgttt6j9O8mZ+2/ACK4JzFdWiVA5YUKG4rQiO64DaQOE2ETbQJT3cYKTO4YUASye
 LJNlP+nXEp0mmA2Ajtab8hfyBd9+wnDm7oEznrLBEiqg7GbThsD+555eIywps2iHfvdQk0nBs
 UPdBAwOQmQtnfydfLDjxbjLRHJ4FkU+vxtGiG2RYdJCS4CPVCWH9yXLy7RizIMDlmSF5cO10J
 5FuBv8KupaNvDVBAj/gDU0LCl9lL46WB6civ9yD84LN8ez2Eupoz3fbqg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 17:37, Johannes Thumshirn wrote:
> On 07.07.22 07:49, Qu Wenruo wrote:
>>
>>
>> On 2022/7/7 13:36, Christoph Hellwig wrote:
>>> Just a high level comment from someone who has no direct stake in this=
:
>>>
>>> The pain point of classic parity RAID is the read-modify-write cycles,
>>> and this series is a bandaid to work around the write holes caused by
>>> them, but does not help with the performane problems associated with
>>> them.
>>>
>>> But btrfs is a file system fundamentally designed to write out of plac=
e
>>> and thus can get around these problems by writing data in a way that
>>> fundamentally never does a read-modify-write for a set of parity RAID
>>> stripes.
>>>
>>> Wouldn't it be a better idea to use the raid stripe tree that Johannes
>>> suggest and apply that to parity writes instead of beating the dead
>>> horse of classic RAID?
>>
>> This has been discussed before, in short there are some unknown aspects
>> of RST tree from Johannes:
>>
>> - It may not support RAID56 for metadata forever.
>>     This may not be a big deal though.
>
> This might be a problem indeed, but a) we have the RAID1C[34] profiles a=
nd
> b) we can place the RST for meta-data into the SYSTEM block-group.
>
>> - Not yet determined how RST to handle non-COW RAID56 writes
>>     Just CoW the partial data write and its parity to other location?
>>     How to reclaim the unreferred part?
>>
>>     Currently RST is still mainly to address RAID0/1 support for zoned
>>     device, RAID56 support is a good thing to come, but not yet focused=
 on
>>     RAID56.
>
> Well RAID1 was the low hanging fruit and I had to start somewhere. Now t=
hat
> the overall concept and RAID1 looks promising I've started to look into =
RAID0.
>
> RAID0 introduces srtiping for the 1st time in the context of RST, so the=
re might
> be dragons, but nothing unsolvable.
>
> Once this is done, RAID10 should just fall into place (famous last words=
?) and
> with this completed most of the things we need for RAID56 are there as w=
ell, from
> the RST and volumes.c side of things. What's left is getting rid of the =
RMW cycles
> that are done for sub stripe size writes.
>
>>
>> - ENOSPC
>>     If we go COW way, the ENOSPC situation will be more pressing.
>>
>>     Now all partial writes must be COWed.
>>     This is going to need way more work, I'm not sure if the existing
>>     data space handling code is able to handle it at all.
>
> Well just as with normal btrfs as well, either you can override the "gar=
bage"
> space with valid data again or you need to do garbage collection in case=
 of
> a zoned file-system.

My concern is, (not considering zoned yet) if we do a partial write into
a full stripe, what would happen?

Like this:

D1	| Old data | Old data |
D2	| To write |  Unused  |
P	| Parity 1 | Parity 2 |

The "To write" part will definite need a new RST entry, so no double.

But what would happen to Parity 1? We need to do a CoW to some new
location, right?

So the old physical location for "Parity 1" will be mark reserved and
only freed after we did a full transaction?


Another concern is, what if the following case happen?

D1	| Old 1 | Old 2 |
D2	| Old 3 | Old 4 |
P	|  P 1  |  P 2  |

If we only write part of data into "Old 3" do we need to read the whole
"Old 3" out and CoW the full stripe? Or can we do sectors CoW only?

Thanks,
Qu
>
>>
>> In fact, I think the RAID56 in modern COW environment is worthy a full
>> talk in some conference.
>> If I had the chance, I really want to co-host a talk with Johannes on
>> this (but the stupid zero-covid policy is definitely not helping at all
>> here).
>>
>> Thus I go the tried and true solution, write-intent bitmap and later
>> full journal. To provide a way to close the write-hole before we had a
>> better solution, instead of marking RAID56 unsafe and drive away new us=
ers.
>>
>> Thanks,
>> Qu
>>
>
