Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A146A969E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 12:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCCLmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 06:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCCLmh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 06:42:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CF5F529
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 03:42:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1qQZC03Khd-00tTvO; Fri, 03
 Mar 2023 12:42:06 +0100
Message-ID: <839ea665-7fc0-334c-e289-deceb417c0fc@gmx.com>
Date:   Fri, 3 Mar 2023 19:42:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DGkW4RzTgWZAXxuoJdXmTS9G7WiCKJGeNOU56nkXIJfjYfmDmO1
 0uDACU73HIB5C5g/GjRW81EgGpDcf4W5DRdL+Nb/Bp7nQix3w0T6x1j5DlLUczZ8gGdSnaD
 iczmZHMcNsK0ikco/SmbPgCkv10DU6vSt61V+AAfRpFQLGDdYQQk8C8LIqm5UnvLDxuPjG0
 Bbvx2yCEXgHeWRGKGhdOQ==
UI-OutboundReport: notjunk:1;M01:P0:0FK0RtQt9jk=;7qWGI3KytV56ij+gIWNDVT51ErL
 /ArE4E8t+xfSbIlM4sDq+Zs1ji+CJtiDWox3SHzdZCV7GzZdf4sR5EBz79fY2+OieoqEdY01y
 dUtb758U6P9qmLjqap1AkqXJk7MrkhqX3hKR+NKU5avdhFkxobbscm4Smi4WyxJuccegQEI6K
 skwzJyGS4jo3+KMWDYi5DDOk73MGPbWsyoJPs4NWct6vtXbO3ogNCXen6DvAyiJRZPJBiaW+1
 rUgow+AbaWfuBkKJ7DhLpMown7wvGs00xJv8y3eNpKxeqGupba/nteolspONa4m8wocIz3IIC
 Evo2v3E1nqLHAxCIeKsJ2Ej23OZthMAocweXVCNwgUkiAoQScQbQRdT48AQb+M4tmQ9lx/fgh
 ziS6StZJUMa+aPzfImlEyLD7joXleX5uWiar8mmzN3Muac96uE4fyFQ2UIoadjnUJkoJ1Hb7S
 sGi/p89yu05sGXpnrr6LOWADYq9FklndryQnD309Wr2jayzbeZimiQL17fu9+1Wc6naNu1yO3
 It/eXN9ONcc/y1dwtX8YlrOQ8kvjqv1dA2RM4tLvQbvCNqAd/Rs2NCOuyIMv4IurCwrwfI3fx
 3WjLCGTo3c1Lw7AYe7hUOvgD/5nxPChqPCi3Aa363KcWgoIUjki+XkA0JIyIw3pY5i5VJhaTH
 E2NAItPoBnWpXl/PBD69OT6UcMPbnJVu3OGsdOpU+F6S6etOhr/0BvqGTV3kVHh//RauDw4qG
 r2k5iA0jMaQTe8ryDj+1pSBHttYUQQ4/PRW2laredDzu0HkMACcETGrvsBt4q+enX49Qp0Qeg
 5AFWpMEVMC0C1RTkSoBXa5eD7Xru8j6PjwaDv1NHnMMZPqPBMRF2lw3+/vqgrmZ+6WTnVqTr9
 sg4TgBwsLZlHI4boWI8/AS/p3XjvE4CvM0ivT1xKmo2/LPtO6TgLQv63eYJaGfi51yGSS4xsu
 mLcSzigwrnfI0clEh8j0YwbitA8=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/3 19:15, Johannes Thumshirn wrote:
> On 02.03.23 23:35, Qu Wenruo wrote:
>>>
>>> If it's all running from the same end I/O worker then we can make sure
>>> the race Qu suspects can be eliminated, can't we?
>>
>> In fact, waiting other workqueue inside other workqueue is already a wq
>> hell...
>>
>> Just make the in-memory RST update happen in finish_ordered_io() should
>> be good enough.
>> Then we can keep the RST tree update in delayed ref.
> 
> There's two possibilities how to handle it:
> 1) Have a common workfn that handles all the calls in the correct order
> 2) Do the RST update in btrfs_finish_ordered_io()
> 
> To me both are valuable options, so I don't care. Both need a bit of
> preparation work before, but that's the nature of the beast.
> 
> For 2) we need a pointer to the bioc in ordered_extent, so we need to
> make sure the lifetimes are in sync. Or the other way around, have
> ordered_stripe hold enough information for the RST updates and the
> end_io handler insert it in the ordered_stripe (that needs to be
> passed into the bioc or bbio).
> 
> *Iff* I interpret Christoph's proposal in [1] correctly, options 1) is
> easier to implement.

 From my understanding, HCH's proposal is a super set of 2), not only do 
the ordered IO thing in the same workqueue, but also all the other endio 
works, thus if done properly can easily handle all the complex dependency.

But that still depends on the final patchset.

Thanks,
Qu
> 
> Qu, Christoph and others, what do you think?
> 
> [1] https://lore.kernel.org/linux-btrfs/ZACsVI3mfprrj4j6@infradead.org
> 
