Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517544E7DE2
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Mar 2022 01:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiCYTZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCYTZc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 15:25:32 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8714528F812
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 11:57:11 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-16.iol.local with ESMTPA
        id Xp5QnGr4vxXfVXp5QnXxz8; Fri, 25 Mar 2022 19:55:03 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1648234503; bh=kYjrePQzxhTdrscKY5tsBeLzQYkoyu3GIJUt/Lc9o9g=;
        h=From;
        b=uugIogAQGQlK6py3Fwx4fE9YTAtPDio9/ijenKXB+gjwfxMJP5oSZ+lgO3NzNf+TE
         zC3MxHGuaP2b3w3qN6h8alYnfYr2W8q82r+mBDHMF5raySVgVMOZd1G4UhUMEbF3/e
         CFIBCJPHtoUVAw936VF3Gb6aAw4pr5vjAxiXkc2nFHIx6xDV5N5oxdZHC8ewGaQcdJ
         RsTYWfbBToxEfDgRkzJ7q+ku6bAFmIttFeDMiHKpwD79EET0yGgjUbZquMW7xMjjF5
         9bNWViWXz/Gl943mBj3Hi88docF/no4gAfrhi98K3ndWkCRIH4lX+spzkjnZOkPhSe
         J8ExaXAJfp2yw==
X-CNFS-Analysis: v=2.4 cv=XoI/hXJ9 c=1 sm=1 tr=0 ts=623e1007 cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=YZ9HFjzuCqBDBibpDxYA:9 a=QEXdDO2ut3YA:10
Message-ID: <6e5970a1-c068-30f8-a6ca-eb6d24828321@inwind.it>
Date:   Fri, 25 Mar 2022 19:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/5] btrfs: add flags to give an hint to the chunk
 allocator
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1646589622.git.kreijack@inwind.it>
 <b15072e61eac46aa9f61317c59219713a01ff897.1646589622.git.kreijack@inwind.it>
 <Yjoo5TOlfGXgAUyk@localhost.localdomain>
 <42e2b1fd-809d-3370-e802-2a9b926d38c5@libero.it>
 <Yj3Yv/3d9hvyh6Jh@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <Yj3Yv/3d9hvyh6Jh@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP/DvZJpyCdc5zzGfUGZHLEU/XYAkDon7ClKQn2QnBpFW+7f7GpYoyTWE6F7wVuSBoUTDnIptlqyYi2P1Z+VKOYO7f7zoOopqOOAxO/ihSo65byHFYyD
 /m133pj2Hv2qya/8Sy82XdhFKJIGasmmVB0GJLIoMem8sTafhlqUNXRsT8ZIVSkPLluSxFAvvSB+7G2TWKF5YosOlisubGu5J1YL7lAUZ3HZIZjE0S1Opicy
 RWZq+jiR9uCnEy8EYx2uy1otJ5xgjRZEyEs4N2WVbIqNLHTClfB3P9i89CUj3Djz3kDBPLgtTGvV7VEmLRXqSMCBVBBF/sHHkZzyKJibjVdYW1pxLpbx7xGe
 oVnrFcbMh1IwwHJ9FlbPRffqHLbZ0A==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/03/2022 15.59, Josef Bacik wrote:
> On Tue, Mar 22, 2022 at 09:25:45PM +0100, Goffredo Baroncelli wrote:
>> On 22/03/2022 20.52, Josef Bacik wrote:
>>> On Sun, Mar 06, 2022 at 07:14:39PM +0100, Goffredo Baroncelli wrote:
>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>
>>>> Add the following flags to give an hint about which chunk should be
>>>> allocated in which disk:
>>>>
>>>> - BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED
>>>>     preferred for data chunk, but metadata chunk allowed
>>>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED
>>>>     preferred for metadata chunk, but data chunk allowed
>>>> - BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY
>>>>     only metadata chunk allowed
>>>> - BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY
>>>>     only data chunk allowed
>>>>
>>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>>> ---
>>>>    include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>>>> index b069752a8ecf..e0d842c2e616 100644
>>>> --- a/include/uapi/linux/btrfs_tree.h
>>>> +++ b/include/uapi/linux/btrfs_tree.h
>>>> @@ -389,6 +389,22 @@ struct btrfs_key {
>>>>    	__u64 offset;
>>>>    } __attribute__ ((__packed__));
>>>> +/* dev_item.type */
>>>> +
>>>> +/* btrfs chunk allocation hint */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
>>>> +/* btrfs chunk allocation hint mask */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
>>>> +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
>>>> +/* preferred data chunk, but metadata chunk allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED	(0ULL)
>>>> +/* preferred metadata chunk, but data chunk allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED	(1ULL)
>>>> +/* only metadata chunk are allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
>>>> +/* only data chunk allowed */
>>>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
>>>> +
>>>
>>> I also just realized you're using these as flags, so they need to be
>>>
>>> (1ULL << 0)
>>> (1ULL << 1)
>>> (1ULL << 2)
>>> (1ULL << 3)
>>>
>>
>> Could you elaborate a bit ? These are mutual exclusive values...
> 
> Your set patch is doing
> 
> type = (type & ~MASK) | value;



> 
> So if you have METADATA_PREFERRED set already, and you do DATA_PREFERRED it'll
> be
> 
> type = (1) | 0
> 
> which is METADATA_PREFERRED.

May be that I am missing something, however

MASK = 3
~MASK = ~3 = 0xfffffffffffffffc; /* see below */

so

type = (type & ~MASK) | 0 =
        (1 & 0xfffffffffffffffc) | 0 = 0 -> DATA_PREFERRED


May be that you missed '~' ?

In any case, my MASK definition is wrong, it should contain (u64)1

#define BTRFS_DEV_ALLOCATION_HINT_MASK       \
    (((u64)1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)

otherwise on a 32 bit arch, BTRFS_DEV_ALLOCATION_HINT_MASK = 0xfffffffc


> 
> If you were doing simply
> 
> type = <value>
> 
> then these values would make sense.  So either we need to treat them as bit
> flags, which should be <<, or you need to stop using the | operator.  It sounds
> like you want them to be exclusive, so you should just change the setting code?
> Thanks,
> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
