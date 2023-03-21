Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A46C3EA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 00:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCUXhz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCUXhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 19:37:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B253D96
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 16:37:52 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1qVDT325mU-00rUkD; Wed, 22
 Mar 2023 00:37:12 +0100
Message-ID: <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
Date:   Wed, 22 Mar 2023 07:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
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
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230321125550.GB10470@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TGAWGUuL7IP794tX7qeqCkYafqNSQr4fRgpGJxXFh+Zwn4TS5n6
 hIOW8XNOeeD0MYpVVUjSKJSqra6pkJLzBmYJiI5jafNWUgN9bSDRpD8Xklak6+kEXKOPAoO
 xH2Gvp1iw/vvgyEAEMd1nVW1AIYs7Uu8wEUuBYtJfPvhQ2MW11NrYYQMP0Dw9DKS6PjqhK3
 ztsDelBbaRzSR7zYaKkoA==
UI-OutboundReport: notjunk:1;M01:P0:RsP/xsZYWXA=;nSBrOhPouQFefTeRIeZQpstvVM4
 6jwz2M5J3omR8HR3nbecg/zCQgs+9gjSilkspPaRCaarO6mqhBxmg1/ayXxQG+vJwYNy6Zqxk
 56+PCbYl+WNl9cTAXaFPZDBdrM25WmHlLDnofPquH6fjt6ddUfKmFXxhw22TUrPIjgWs2bLqx
 qd03ehBm+cx15QrwDBHQRPImFi6ZA29PJVX0igJSlbLmU2VOUrloLCpjsCIQHP+cx6qaiIGRn
 0d+s7KcBqiMSOVa1HtxrIeCZdhcYoS2jSsxfvGyP5k4RHL14uCWoveLCRHg2PXitfhJ4suIWY
 cGti8Ahc6Hn4kbxqqhqq14cyqvRHCwDk1+2LyOm2kYsUEqzl6hBdPKiBbWEwumpaRb+nm9t+J
 aaZRNJmRntJoGsRad2XZpZgPbYE1O+kac4aiw3Sx075D1+NiCVQDIOgPy7fDVNP7Rq3bh7Bgn
 RckOPi6RrJRjCZg62arpHTnEEvxg09sABJJrxC2JZlLlmY6Ue3/FVvZL7baw0GNiv28IPUSHB
 4iTYs+apwjB785+ecLTETBl649KguFmpQaykkaUJ8Xv9SlgHZz5ZlRqTeddNL7ylOqNW18cz0
 ayrhVcmw/T5LmFQXTQZRhi4dm75Y9VckYtPPo2P0UEvn+1edT488Du0+AMMQ8tBFNo7BZJTPS
 rbW+jIJyBd2OGo4oalMf1zzfOPkjcyjLtqMHLV+0ErsgHY8DUgdDXHeK3sJwS+nsUefsHXdKJ
 asA/uNrZbJEJ9ubrz/hfhA2e2hiRQnoKOpoWA71mjAuBMuyE93B9tmb1ddupaCKHMbz4KpvFR
 rmJwL66zxI4Pa+43qSlWZwmksASXP7a+dNIpF8m39LafS/kMzpqUlYeuC3wGhPmfDQsmv6a4C
 //stbAoTHChkdrFpMp66ipkRUC4Ls2TFfOgvChe1nY/1AXYUO80wfo9JjVIRrzoJodr6kf/bN
 PWMyeA==
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 20:55, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 07:37:46AM +0800, Qu Wenruo wrote:
>>> I think it is stalled.  That's why the workqueue heavily discourages
>>> limiting max_active unless you have a good reason to, and most callers
>>> follow that advise.
>>
>> To me, this looks more like hiding a bug in the workqueue user.
>> Shouldn't we expose such bugs instead of hiding them?
> 
> If you limit max_active to a certain value, you clearly tell the
> workqueue code not not use more workers that that.  That is what the
> argument is for.

And if a work load can only be deadlock free using the default 
max_active, but not any value smaller, then I'd say the work load itself 
is buggy.

> 
> I don't see where there is a bug, and that someone is hiding it.
> 
>> Furthermore although I'm a big fan of plain workqueue, the old btrfs
>> workqueues allows us to apply max_active to the plain workqueues, but now
>> we don't have this ability any more.
> 
> You can pass max_active to plain Linux workqueues and there is a bunch
> of places that do that, although the vast majority passes either 0 to
> use the default, or 1 to limit themselves to a single active worker.
> 
> The core also allows to change it, but nothing but the btrfs_workqueue
> code ever does.  We can wire up btrfs to change the conccurency if we
> have a good reason to do.  And I'd like to figure out if there is one,
> and if yes for which workqueue, but for that we'd need to have an
> argument for why which workqueue would like to use a larger or smaller
> than default value.  The old argument of higher resource usage with
> a bigger number of workers does not apply any more with the concurrency
> managed workqueue implementation.

The usecase is still there.
To limit the amount of CPU time spent by btrfs workloads, from csum 
verification to compression.

And if limiting max_active for plain workqueue could help us to expose 
possible deadlocks, it would be extra benefits.

Thanks,
Qu

> 
>>>> Personally speaking, I'd like to keep the btrfs bio endio function calls in
>>>> the old soft/hard irq context, and let the higher layer to queue the work.
>>>
>>> Can you explain why?
>>
>> Just to keep the context consistent.
> 
> Which is what this series does.  Before all read I/O completion handlers
> were called in workqueue context, while write ones weren't.  With the
> series write completion handlers are called from workqueue context
> as well, and with that all significant btrfs code except for tiny bits
> of bi_end_io handlers are called from process context.
> 
>> Image a situation, where we put some sleep functions into a endio function
>> without any doubt, and fully rely on the fact the endio function is
>> executed under workqueue context.
> 
> Being able to do that is the point of this series.
