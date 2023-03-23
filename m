Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1D6C614B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCWIHu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCWIHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:07:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86B19F22
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:07:44 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNp7-1qKOhV3snF-00lp48; Thu, 23
 Mar 2023 09:07:33 +0100
Message-ID: <bbcb7c0b-42e7-4480-abec-5ffe13ec7255@gmx.com>
Date:   Thu, 23 Mar 2023 16:07:28 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230322083258.GA23315@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8fE682kYB/oCQrY6rDi+J5eKh1jhO3bYOPCzfXSUzIvWRWcWr4P
 lkrsplwZtCUunwYqxzZXr6HiyTLDiVnNpdL0zK/pIV9/hWDrvITCDS3nkySbSzB8CrPey6X
 FtBPez1pxn630xgg6sVtxMPT+yg9Dqif3p85s5T1O62BMuSSWjaQjpKIDr6wobcADYYRK7y
 2R5b8nlIJWd+3bS86YrWw==
UI-OutboundReport: notjunk:1;M01:P0:Q63EEhNMY9A=;l5oQxAsoL9iyD8NDcwLYyvKELMa
 1xm4HcRifJYzqcZkGgntzyKlfXDGh97aX6OUnlxb3+/fIV9HdbGxcT5qto5UsfXQvVp79LZfS
 +kygZ8yEzGFUMWVQjO9YZaLSsTYkFb9rbvTpWC4wGIAHVIvExkS8pk2f+TJ8DKtyxxvNZm2c6
 f///kWFF3xmllF18Mr1rk4pdyxSAjUrk5/jt0HWNb3AHwsn3T4LAr3k1VQbu//R2j9Y6WiV39
 hrVAjan4blKHQ7/HaGeryUPBQ75nUjMpnq38GE6yML9FdHt41B1lUmyu2U/2PST8IIrrKFyia
 6p7Iv/jFklr4mjCFDDbmQM3PWosTCOjrYNvUjLSanWRX+eJS9RbJbf7OyHjMOZJqhnxo4CO6b
 MYMzDRobNJrDJb6WWfbOZBP/AVxeTr/NO3jCV5N5Ivm9NnkbwAQ9asW2EfYus0rB1GHluapyG
 ShHNf+On72NbyOw44YK0FCJ+hH0V7oQollou2hfYkGcyWcd1YOGaDPYyRh0V3lQKXGTGUEYR2
 NDhS3CKe5EbME5wV9enq2hZ24QGi/8518d1dE1p9cR+S/1w/cP8d+3+ifeK7DNXajpEpq7ZR1
 u7NVvFs6pQUpAQJGo8hVpfSLnVxQUvHPJuqw+7u9Ppj75oJ/B2YPPEgVEXZYgCGW7OeQag+bJ
 lG52xM8qzftaZLXQeGh8aaJ2FUM9LzCYFVTC8lY9Rfe+hZ5tquTfiLMG7avO6QAxQWDsKLT5i
 HASHzBhn+V6FKNMs+v3VtGNH/PxQGLu05ZymdpMU5NQiLmSg6t6liOusEuvhzXZ5OSCCfWW+F
 tC7owhoTNj5pku0J/+OxmN1XbNbTFDT2e3qVLnJV0aw3r0ZwqJk32ROX0StRkyohvjzVweou2
 2i1b1JUlIgtMrNkWEM0q5zls36GoAFpsRth7mNN5fmHtcvWyNXZlSUAx0WIvL+AbkT1FesCbZ
 TEnrHY1NcpdqWUHHWGTX9DpYZEM=
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/22 16:32, Christoph Hellwig wrote:
> On Wed, Mar 22, 2023 at 07:37:07AM +0800, Qu Wenruo wrote:
>>> If you limit max_active to a certain value, you clearly tell the
>>> workqueue code not not use more workers that that.  That is what the
>>> argument is for.
>>
>> And if a work load can only be deadlock free using the default max_active,
>> but not any value smaller, then I'd say the work load itself is buggy.
> 
> Anything that has an interaction between two instances of a work_struct
> can deadlock.  Only a single execution context is guaranteed (and even
> that only with WQ_MEM_RECLAIM), and we've seen plenty of deadlocks due
> to e.g. only using a global workqueue in file systems or block devices
> that can stack.

Shouldn't we avoid such cross workqueue workload at all cost?

IIRC at least we don't have such usage in btrfs.
And I hope we will never have.

> 
> Fortunately these days lockdep is generally able to catch these
> dependencies as well.
> 
>> The usecase is still there.
>> To limit the amount of CPU time spent by btrfs workloads, from csum
>> verification to compression.
> 
> So this is the first time I see an actual explanation, thanks for that
> first.  If this is the reason we should apply the max_active to all
> workqueus that do csum an compression work, but not to other random
> workqueues.

If we're limiting the max_active for certain workqueues, then I'd say 
why not to all workqueues?

If we have some usage relying on the amount of workers, at least we 
should be able to expose it and fix it.
(IIRC we should have a better way with less cross-workqueue dependency)

Thanks,
Qu

> 
> Dave, Josef, Chis: do you agree to this interpretation?
