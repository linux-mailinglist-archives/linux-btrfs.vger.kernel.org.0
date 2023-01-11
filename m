Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B0666725
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 00:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjAKX2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 18:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAKX2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 18:28:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2785F3D1EE;
        Wed, 11 Jan 2023 15:28:02 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9uU-1pWjOQ0Uuw-00IFpU; Thu, 12
 Jan 2023 00:27:40 +0100
Message-ID: <685f8fbc-5e61-d230-767f-e69784111b88@gmx.com>
Date:   Thu, 12 Jan 2023 07:27:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] btrfs: use PAGE_{ALIGN, ALIGNED, ALIGN_DOWN} macro
To:     dsterba@suse.cz
Cc:     zys.zljxml@gmail.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
References: <20230103051137.4085572-1-zys.zljxml@gmail.com>
 <87d14908-dc9d-7ce4-c594-b28a9991efbb@gmx.com>
 <20230111184037.GI11562@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111184037.GI11562@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Kp2RjR85hmW9Kyf/GsKYhJahGsItLZBQroP/Pwr2bc+teQHwD3C
 FxkyGDE++ijqWPUf688K35uDVxaPIQx+Key5H90OlELU26Gz/IZYe5P/Xdi/DMlCzbFlWUy
 hUze0XzR/zbk/W4JCrWbkg2XSTOjtBdPqWaHWmefMAflY5xSL+RFeHxLheWtAqiAcOh8G7S
 Fyj8Y6d2WGWwRfpeMtx8g==
UI-OutboundReport: notjunk:1;M01:P0:phg6aEFCvJE=;leuH3HfgEhbbPK8kOGUsBxN/v7s
 SvPHwR+T1QEgwYl+Sjq2tAc4Deadg2BW0BZYaFESzyTStqfTdeUhvLkrbJoRCw8YUVjT25VZd
 GtiJjlHiGEy7QMP6opCZZkGlVA1ABDF7AUlDAIqmia8hPSrnNzEX8RKRJSu4Uga57+gK4euGy
 EKNpfUqZBkdE9wE0xFOzuCf8uBfPtkhWfn3KnIWNRG0yENBgzNQ3aMutdUFOptvmVm1blL7Lf
 8LApiz3bpN+SluppGcEaT4kZrHtOiPoR/wl18eDas5bl13CoPAOFt0ZlcwYx5cdMqIswczvBW
 tsOrKy5ZPaD0/Jzr/IiDnEhXi9G1AdPO2vP7fyLfEQxZ2kbv8XJ5gJmvfdFTJqzOXlUSAyhNN
 udzR6FWamddrhIXWQjBY9bayXe2zTmSSMPFGBN9zBytpDdBIqZCiF0kXA8Z/Z7ADotgoYP3D4
 FIRANAwHwXUiOrrgxUtNDETmNaoB8jiHCCU0cKGDZWg8UyZaxssy4hE0z/Rt1XEfSPhfA/53V
 FqTbXwmvdOvCIt+5UpnVrl145nc/7O5d4UJ4WjcVGs93XOcbzj80Fz9/CgEvCsAHm76jl2jDN
 GT3NBX47VMd916rkrgawvlLiCdzbTsWzVmR8CcEG3hdjIiq+ES4UKsVPnNrAswt2qe58sJOdo
 uBLjGklBYVyimQZAYn5eix90q1AoMBMzfTEuITtjYKlqU++YGpsVshBXfVubmVbgTqu1b/eRh
 /OWdeEidCIRwjhnqXFxxbw0epcZj7Fp5lmLxpLyqSgRZdOOTRx+s4PCMJhuWhPbGjNXIsNe9Z
 Ai5YXTv8Gw79ABvIL85+e0kIRplOZOH3QICXREwWt9o2S85RgOfZZtg33pgYdIPB4wQJhZz0g
 sFXwvqLLTp0UnAoXWZ0I2Wis2p02NeVFFFwj7TuT9FV2PWvfpJFmsOlgCVkMaHYSxxULBQlpo
 4WMTcT9awOX9Ph5SL1fMCxa7/Bk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/12 02:40, David Sterba wrote:
> On Tue, Jan 03, 2023 at 01:47:43PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/1/3 13:11, zys.zljxml@gmail.com wrote:
>>> From: Yushan Zhou <katrinzhou@tencent.com>
>>>
>>> The header file linux/mm.h provides PAGE_ALIGN, PAGE_ALIGNED,
>>> PAGE_ALIGN_DOWN macros. Use these macros to make code more
>>> concise.
>>
>> Is there anything benefit from the change?
>>
>> In fact, PAGE_ALIGN()/PAGE_ALIGNED() is just using the same
>> ALIGN()/IS_ALIGNED() macro.
>>
>> Thus I don't think your change is of any usefulness, not to mention it's
>> going to introduce confusion and extra effort.
>>
>> I'm completely fine with regular ALIGN()/IS_ALIGNED() usage with PAGE_SIZE.
> 
> We already have PAGE_ALIGN in some places and I think it's a bit better
> than the ALIGN/IS_ALIGN as it's clear that it's for a page.

I'd argue that PAGE_ALIGN() is good for MM code, which btrfs has some.

But overall, btrfs is more about sector alignment, and if we need to mix 
them, regular ALIGN() would be more flex.

Thanks,
Qu
