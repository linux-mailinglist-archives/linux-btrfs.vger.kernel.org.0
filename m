Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D96141A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJaXZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaXZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 19:25:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEAB1116F
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 16:25:41 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0XD2-1pCnkD0mTE-00wTne; Tue, 01
 Nov 2022 00:25:38 +0100
Message-ID: <2ad00181-bb2e-b99d-896b-bc95374b6493@gmx.com>
Date:   Tue, 1 Nov 2022 07:25:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 8/8] btrfs: raid56: switch to the new run_one_write_rbio()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1666760699.git.wqu@suse.com>
 <7dca624de976e872abb869885b009713eddca061.1666760699.git.wqu@suse.com>
 <19e98ab7-949d-3c19-15c3-7b83ac428967@suse.com>
 <20221031164837.GE5824@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221031164837.GE5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tCAQO9ft3sTVngl8QET9vEGAkPyewmQ2uo0hVOM80mtD90mR7l3
 2GDZWvA3UYlHXMdjhYMXzmFBJ9LhUtDdCcEV2qrSYkY2kjB6m5UAYgLPT89qNOqfCwH4LxN
 PSbmC456ljLag6c/iVNt/Um2NvloIuqz9A6Pr3muCuyI/ShF4Eu+k3FIET/QrQq6ucQTiKC
 OFEovECYiV9aMSlOcgRJw==
UI-OutboundReport: notjunk:1;M01:P0:XfXZfzIfx8M=;JpRfmHdC6DVCOyli2NSx068GHjo
 qmsZt4JPqlHL3zSGqWPHLlxNqdMsC2NpqZuB66LCwWSnbevoeqYhr5QjMYE8MkpHsxe106NfD
 aIkTsKZ1eqIwyD1D6VUwkYdXFZ7ZSVekB5HA7Q/1dUUSCbd6GKsH6R8rbTFxBYnsaqBMZYCBt
 p9XE9tNxmiTdY0DOS/TdwHixPA8TqrybJ9UW2IcvB6WznO0PBd8TR97QyuT/ILcE/g5oTQyrc
 tvNU0nZ8UV+UKDR2mCXOefqFDZ/HdRQo31D2BfnyhE3Yg14ggXS9W0Ec8NGgJKFEO4dcgDagc
 V9L7lypEOPMz5rAThqF8emywevrBSVfGR43DWewTj21aXub790wF8r9ZnwutocfvfsNTxzJKd
 znABtbJ45Lz9S6HmoiofaADJ765FtBNMQcVkfMNnJJeB2/T9mfqARwVflP4rXvHrO54H+3rwu
 gkF+E9/BzpXPKSY0f4bRFsmUDdrVHkE+pVMztJQ4jas1Qt05Ffy7VVO9dPXsR10V22jAxdl2P
 KmDWwTA/pNNBxPD+xnzSHP8DI45N8AhUCo9yynA3/9Ti/djarwcG+xSuzibQcEqd8OY0H7kNI
 yz2D/MQl2u6BRxP0lBAMWpd+jC346v/6mQDL9UZXeo03dRBKggmXdM+AsT4P7B1ngDh13uxuz
 GlucVJbkuRZN9KRPatlK1Xl25qot5hnOt8SB6Tx5TwR3y7Eg1RADw6N/IZrYR2XRX3pX++Y+6
 zFNgF94k9q2CIigffTzWGBF8ae1kOn52TMh1K/fkJfwWIkPi44GlpZn4cG9pt2gQ86pZzJbdu
 blpvCIdwFd5XrQpRJ8bHP2rHD7zbFZf8CqHUahKzccEK2B+A4ixSOMaXBK7Uzc0eRtymk7Ep0
 a0brbbp8UqEwimBZr8H3OGO1jwR02MPDC6gnsNAgVRPNy04S3SlYz93yonUzTR09EwN3exd9B
 z+r1Smc+016EYNZoAs1XZrKdI9o=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/1 00:48, David Sterba wrote:
> On Mon, Oct 31, 2022 at 09:07:03AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/10/26 13:06, Qu Wenruo wrote:
>>> This includes:
>>>
>>> - Remove the functions only utilized by the old interface
>>>
>>> - Make unlock_stripe() to queue run_one_write_rbio_work_lock()
>>>     As at unlock_stripe(), the next rbio is the one holding the full
>>>     stripe lock, thus it can not use the existing
>>>     run_one_write_rbio_work(), or the rbio may not be executed forever.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>    fs/btrfs/raid56.c | 351 ++++------------------------------------------
>>>    fs/btrfs/raid56.h |   1 -
>>>    2 files changed, 27 insertions(+), 325 deletions(-)
>>>
>> [...]
>>> @@ -3284,16 +2987,16 @@ static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
>>>    				free_raid_bio(cur);
>>>    				continue;
>>>    			}
>>> -			queue_write_rbio(cur);
>>> +			queue_write_rbio(last);
>>>    		}
>>>    		last = cur;
>>>    	}
>>>    	if (last)
>>> -		queue_write_rbio(cur);
>>> +		queue_write_rbio(last);
>>>    	kfree(plug);
>>>    }
>>
>> This part is in fact a bug fix which should go into previous patch, or
>> it can break bisection.
>>
>> This is already fix in my github repo, will update the series with some
>> extra polish, like remove the raid56_parity_write_v2() definition, and
>> make recovery path to follow the same idea.
> 
> Ok, I'll use the github branch for for-next if needed.

Please don't, the github branch is going to under big changes to cover 
recovery and scrub.

Especially for recovery, it turns out it would be much easier if we 
start the convert for recovery first, as the code is shared between both 
recovery and degraded mount.

I'll send out a v2 to cover all raid56 entrance soon.

Thanks,
Qu
