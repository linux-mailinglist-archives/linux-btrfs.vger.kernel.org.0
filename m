Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829806C6182
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCWIVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCWIVC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:21:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A32FCC2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:21:00 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1qfMzA2fon-0103Da; Thu, 23
 Mar 2023 09:20:50 +0100
Message-ID: <6b1d2d63-ef00-3c6c-8bea-481e46b6fcef@gmx.com>
Date:   Thu, 23 Mar 2023 16:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-4-hch@lst.de>
 <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de>
 <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
 <20230321125550.GB10470@lst.de>
 <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
 <20230322083258.GA23315@lst.de>
 <bbcb7c0b-42e7-4480-abec-5ffe13ec7255@gmx.com>
 <20230323081237.GA21669@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230323081237.GA21669@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Psb9E//9BNKq4Csl90fGy6Nk5qeOtpXOytbydHZYuAk5fmU2oM3
 65lsKbzb13rruHKg7cmR9sSKsY6SpGQ6nuQdskUONLCADTwMxFnuRuiRCRpL456Z55M5QOM
 Y7I1ai2qXLb9FTxTh0KrDaJuYJVeixzm02SUt1JDuMuAj5E7Fjk968uhAQKxAuNFkgV8hDq
 nVVaJQ5LxZ+bV3fV0Rfgw==
UI-OutboundReport: notjunk:1;M01:P0:e9hUGDF2LB8=;6tT+VXln6byHvqoYPdqyERsjkGQ
 fFeLp9Wqm2zCN8rrAHaVXuac9ra7wL/CeFsFz6EtIGa8lbVz3Onlvy7VXij6EitmNws3U1MRZ
 uLKQXVP1hvu8HsyIHnAJNo/hJzjtIWVbb1yjPbbfmBpycLuAwVVOlq+AVJidAqAgP3VluTKBI
 RVmNBPAad7Xl4dLh1TB/6g1HsFUzO5ppGqZ9fen3FHt3w2e+dmTMfNpCwz9AW/lNzype/BvDR
 S7o7fSSwPaGTda1MCkqrtVCawDY7cTCtkK3P5+UFH80Ud6K3ycuZPfm+Svxh9ZR0l2F3njq+B
 hWbty5v2/NG9GFurG0+bd6E0nvL5iz5NKsqeQkzW2Y8MtMQh8pKVy7v5cJ6q5KYeY3r0JA4Z4
 z4MGB7TUExaeJVXyCuaJ0ybXOc9inCKw2fVWNRak0V2oVCN/I9SnWN6m7vMdD8MYiKxMPBDyP
 VY9DA2zc46wt2C4e+KRsCRWBs7VMFfdwhoKHGWIs2wf5oraG355tDJjRoEfLbu+b4gduw3N13
 ZQ7EIgpOyqWPuIpu6wI5rmUsAjBXB9ZJ9Xx3J22FXOvQDLepdyQz2Xxndlc+GMgIeon7Yv/uo
 +XX0sGvuKbWtqgmGhqAYvU0CpN+6kGGaqZbJpZH6lmjbq80rJC/TYpHUhrkazAOaAjp4TC8TH
 Vvjw+bq0vX/gGNzp9D9ndttKFnoviZv2N5H/RHSE9ocgfemUVddwO0rxiVEOQPb1zRDX1SXBk
 vDSaJGK39MF6sdUz0bqp/rs/OuHkId/el9Bd0SYW7LrUAyLNVLXt7wQgMWHowv3dyGQ8aONkA
 hfNOvI2fTbLFvfAaXYnRABnMSyWJ4kL13McDI2V6BOwMeZKyILUV1gcOP8Xbb3LIQXheTtEGb
 KPg35EZIDXuRqdIAv3X5eppA/bO8hMd/V0VnjPgBB4vLmiHAGi4rc4v2I8wZMaKDXBT8cw4ae
 nhClAMON4qe81cOQnTNw8cvuSso=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/23 16:12, Christoph Hellwig wrote:
> On Thu, Mar 23, 2023 at 04:07:28PM +0800, Qu Wenruo wrote:
>>>> And if a work load can only be deadlock free using the default max_active,
>>>> but not any value smaller, then I'd say the work load itself is buggy.
>>>
>>> Anything that has an interaction between two instances of a work_struct
>>> can deadlock.  Only a single execution context is guaranteed (and even
>>> that only with WQ_MEM_RECLAIM), and we've seen plenty of deadlocks due
>>> to e.g. only using a global workqueue in file systems or block devices
>>> that can stack.
>>
>> Shouldn't we avoid such cross workqueue workload at all cost?
> 
> Yes, btrfs uses per-sb workqueues.  As do most other places now,
> but there as a bit of a learning curve years ago.
> 
>>> So this is the first time I see an actual explanation, thanks for that
>>> first.  If this is the reason we should apply the max_active to all
>>> workqueus that do csum an compression work, but not to other random
>>> workqueues.
>>
>> If we're limiting the max_active for certain workqueues, then I'd say why
>> not to all workqueues?
>>
>> If we have some usage relying on the amount of workers, at least we should
>> be able to expose it and fix it.
> 
> Again, btrfs is the odd one out allowing the user to set arbitrary limits.
> This code predates using the kernel workqueues, and I'm a little
> doubtful it still is useful.  But for that I need to figure out why
> it was even be kept when converting btrfs to use workqueues.
> 
>> (IIRC we should have a better way with less cross-workqueue dependency)
> 
> I've been very actively working on reducing the amount of different
> workqueues.  This series is an important part of that.
> 
Yeah, your work is very appreciated, that's without any doubt.

I'm just wondering if we all know that we should avoid cross-workqueue 
dependency to avoid deadlock, then why no one is trying to expose any 
such deadlocks by simply limiting max_active to 1 for all workqueues?

Especially with lockdep, once we got a reproduce, it should not be that 
hard to fix.

That's the only other valid usecase other than limiting CPU usage for 
csum/compression, I know regular users should not touch this, but us 
developer should still be able to create a worst case for our CI systems 
to suffer.

Thanks,
Qu
