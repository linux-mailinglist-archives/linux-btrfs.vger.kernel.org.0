Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA28643FDB
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLFJaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 04:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFJaS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 04:30:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A461CFF9
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 01:30:16 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhuU-1pFBaj1Tus-00Dq5B; Tue, 06
 Dec 2022 10:30:04 +0100
Message-ID: <36b85b39-bd88-d374-cd55-a7eea62a1686@gmx.com>
Date:   Tue, 6 Dec 2022 17:29:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1670314744.git.wqu@suse.com>
 <Y48ADI5Qa2Wt+/JR@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PoC PATCH 00/11] btrfs: scrub: rework to get rid of the complex
 bio formshaping
In-Reply-To: <Y48ADI5Qa2Wt+/JR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZvFTN24/0XHjD9wJ/RNGiQRNR5KBa6uuQmAi8dqOSCI6bTg6duS
 Lm41iYPg9x2ZA8HhQ+EIxRMAlGBLsIOJ+YxtrDiHTx9aEh48yEq0oHyW+cXew/03WMHjhu+
 7JfQZCcX7upkL1nx2yNQ/SIKRFuy54b9jjHi0MODpvPNY2akByllYkM3qiRjGsd/3zv38FC
 TXUXV8V41StKq5imAJs4g==
UI-OutboundReport: notjunk:1;M01:P0:Y+NoniqST6w=;ki8cEDzlKK/WR+L/QdHatjYO5ND
 B6ENpuSRUkZuGjxdea7eHwjeHgC1GI9+hmh/bE6XDPekTmYlbyaXJWav78RQJpxczHew5w+in
 eaZKnPGmbxSaPrxFllL8aHfuk1asgcTNL3HR3byK3GRlB5H4Y87nJBir1EpUAPhr8o3VK4Zpa
 UvZ+Anzo4PYx8n/Q86eBYCPNdXJxlaGA/oKWSwoLZTh9JWPzdCWxRqA3NAvn4TbIrynLvjmqV
 iddJgFgxQl0ZERAF4W+YUP64CACSqao3UA5px/CWUnkKGcLjkVkJeLuH6FGUt4VckxX8E3dDf
 qRqHeYIII02vTszAl1DPufVQg65Q7ybnkP06Oqz4OgtoUkCZjL7HksRp6fpSSOGb8d4L8EukJ
 Soxl8QbFa8iP/RXKWI7TGAaXq9n1LiMRW/+Zo7cqLaTNDKtwHvuYOqZwGAkQ1rzO0lchYFWT5
 5zz/8Q1E6gm5O+LPzai7VStiq/rkqSapZbYixttphQ5L/vc+I82qNwGBjZVRl9E786/XVyEtB
 1+ri3qjVGgng2gKL4YEAEtyWsiKJm367aTr4JSQ6UY5UhUFvr+s/QL9lBsfiGuDr9kQXfPrw0
 qdLYhGAcZjGWYp+ioz0TMnWMctlerxLUUrMQ2J0HfRfuGdA8FAyaMQsotd5hZnDbZ3yRDII8U
 8GE/HuEHAcplX8vSpMJQSgfllMQ/CQfUdSdHwcn1BuVsxHEgopnRqc85XkV2JNGKmhoslrzqn
 SIqrsgytPJzK183iJmO62ZdmzqoB3En4aQ3zjNki0+GNMCBTaoxr54Sg5ZuMBM6yDIDKqM/2q
 TSr6lcXY/C+fOB8qPqc2ZPaGFYdnM1ABSkFApNgPva3N+1/XYMEacmCXGVdsI78cuKYVkUXOB
 KvgwCvk9oxt/Ba0KI+cnpR6AeEcHQNCa5dq4PNznZA1qRnefZNtS3pLuLWg4zGADIVO7VZ4yV
 jqczadHhzvTspWMdZFiUhMQNwUY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/6 16:40, Christoph Hellwig wrote:
> On Tue, Dec 06, 2022 at 04:23:27PM +0800, Qu Wenruo wrote:
>> TL;DR
>> The current scrub code is way too complex for future expansion.
>>
>> Current scrub code has a complex system to manage its in-flight bios.
> 
>  From my own ventures into that code I have to agree.
> 
>> This behavior is designed to improve scrub performance, but has a lot of
>> disadvantage too:
> 
> Just curious:  any idea how it was supposed to improve performance?
> Because the code does not actually look particularly optimized in terms
> of I/O patterns.

I'm not 100% sure, but my educated guess is, it's just merging bios.

- Merge physically adjacent read/writes into one scrub_bio
   This will mostly help RAID0/RAID10/RAID5 scrubbing.
   As although logically each stripe is only 64K, this allows scrub
   to assemble all read/writes into a larger bio instead always split
   them at stripe boundary.

   However the effectiveness should not be that huge, as the scrub_bio
   size is only slightly increased from 64K to 128K.

I'd argue that if the extents are all interleaved, then my 
always-read-64K behavior would be better.

> 
>> Furthermore, all work will done in a submit-and-wait fashion, reducing
>> the delayed calls/jumps to minimal.
> 
> I think even with this overall scheme we could do a bit of async
> state machine if needed.

Yes, the infrastructure is already here.

In raid56, we need to scrub the data stripes first.
In that case, scrub2_stripe_group is introduced, and use workqueue for 
each stripe to scrub.

So if later we determine the current read-64K-then-next behavior is not 
fast enough, we can use scrub2_stripe_group to run several stripes at once.

>  But then again scrube is not the main
> I/O fast path, so in doubt we can just throw more threads at the
> problem if that becomes too complicated.

Exactly.

I'd do some benchmark later to show the difference.

Thanks,
Qu
