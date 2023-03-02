Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E06A8BFC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCBWgE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCBWgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:36:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4A4E5EF
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:35:52 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wq3-1qZZ3H1FBB-012IMu; Thu, 02
 Mar 2023 23:35:35 +0100
Message-ID: <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
Date:   Fri, 3 Mar 2023 06:35:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Z8961PAKK41+rSU5JDw7gmtprvDradryTbcBE0UDqsNEdFIk4EL
 vQplreMyzx0xWolwH45aRrm4eZJAdlEykuBcaGvmXVWrbEbue+UiLpYZ7vxv1Bxquw2+a/c
 6Gtf1VBBb78e3rMTLFK+kPLPSRRC/s+4k6H3Y3mfB89DNDrjXYHFdUnp90EFn3fiU37zbaq
 /bNy6TbkO3RXOsMA9UGhQ==
UI-OutboundReport: notjunk:1;M01:P0:iDhXyt26AqY=;ONxhVDpC+XWWmPwFFTR7tCjTGke
 cdiLZkkw2ziPH+l88FWMf0ZvNO+qlcKefAHc7C108eSzlanPE5hMi5L2TMsc7XZTXDbbE+xeZ
 w/SLUhmz/cX24uKqQyJOxdfEVinC8R0Ieb6vysZPYEAHlvbXV+UZ27Xai592qDIg1eU67eilh
 DrG8Na2eNnOoPyAxE2KAslsjl68xzsJIdN2NQFxxkOFww2j1q495Wt11QrXyrX5W4jgkuxfZ0
 GNELxdztSGm0+rMKQs+RpJzIulJftIslaxxN+vfczOJlrB2YpcoKDXmYP8achKNp99JcbGrZw
 YFO5LjUPwbA3FH+jEhJyvQHb2A5m4ZO4RtUJTE+b8db3/1lmXzsdbM7bdXkLKR9RRW7UmAXc+
 cDj2++eovxO9tSrIj3Gxx+C2kSgmPHodrx81/H3+GCJwxUuXme6ICrBqWm2XHCnRBcOwgeOiH
 A/hKEML4a+bRsRzY3yXqD5jmEshiWZOIY/AEi1+5wbzDHELMzOwrsgrtRnDJHGzmY2iegXfl9
 mER8XrvTbhu93GFTjfDlkC95T6a1xW4aDdQSgpCrVA4VklvXU0bL12cEktSMSxCyhcshOQG3K
 Lb2YjnwIdFjGOgRSbTltMXMRSZyqjjOA3c7TH0eujMpAtbDew3eXZc6vjMXjDrTlN64cDY1XW
 DUE6zlSA5HZ7jMhWvyEOklrkqsMvNAO4LrKlxci8PekRDR+tiyAEl8gU4RHfvpkGgNzbne9QL
 EpDqpG1yzMOKD0pfTi1k91C6W60pok+/j59D0U4RQ91FI1MIq32HcR6ststo+7QbgxE9ALGIf
 IwLVvVghfWMrBjkGXJbtY+8RrA5xR+QrJAdaZKSzRSC6izPLOmorD3DO3eIHtfHNCtS/Ra55G
 Q9d+9vGBovdMPwFjWfFVXtgJl5pdqBaOG/fJydh6Ay1WGGBlaWu/H5sCjor6KXvIlov+BTwpk
 7GSkSl01gKh6xu+mJW8It3Ozpp0=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/2 23:31, Johannes Thumshirn wrote:
> On 02.03.23 15:02, Christoph Hellwig wrote:
>> On Thu, Mar 02, 2023 at 11:58:13AM +0000, Johannes Thumshirn wrote:
>>>> Thus it can cause deadlock if the workqueue has one max_active, and the
>>>> running one is finish_ordered_fn(), which then can be waiting for the
>>>> RST work.
>>>>
>>>> But the RST work can only be executed if the endio_workers has finished
>>>> its current work, thus leading to a deadlock.
>>>
>>> How about adding a new workqueue for RST updates? That should mitigate
>>> the deadlock.
>>
>> The amount of weird workqueues in the btrfs end I/O path is worrysome.
>> What I plan to do, and might be ready to submit about next week is a
>> series to actually offload the I/O completion to a workqueue on a
>> per (original) btrfs_bio basis.  This means that RST updates,
>> ordered_extent processing, compressed write handling etc can all
>> run from the same end I/O worker.  As a bonus we remove all irqsave
>> locking from btrfs.
>>
> 
> If it's all running from the same end I/O worker then we can make sure
> the race Qu suspects can be eliminated, can't we?

In fact, waiting other workqueue inside other workqueue is already a wq 
hell...

Just make the in-memory RST update happen in finish_ordered_io() should 
be good enough.
Then we can keep the RST tree update in delayed ref.

Thanks,
Qu
