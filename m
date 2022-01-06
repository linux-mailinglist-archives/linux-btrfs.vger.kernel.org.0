Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839F4861AB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiAFIxQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 03:53:16 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:56088 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236914AbiAFIxQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jan 2022 03:53:16 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-36.iol.local with ESMTPA
        id 5OWFnjSVDeQ4z5OWFnJRh8; Thu, 06 Jan 2022 09:53:14 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1641459194; bh=pueEp1SNhoqOAL6K+CYfMzk97RtV3pjdwr7kGiydJGk=;
        h=From;
        b=la5JTmVRCYCn8htvMQDilhq8AarbfyQHp/O0KlNGHibbiHVS7+t66njbysPXXnILB
         qKEDETG6owPmgEL5dONuunVDBDBcuDHH1kF+ay/7icPmWbaF3J2/ufqd5yDnqYFiv0
         rfWqyWX8XG1vlNdsaqSvwc1/fL+e2HIFK3jsVFB+KKLx2IJ6OJXl6T6NSiUsL+7GBf
         LqVQ2sk1zCBkMQ83uxz1QdEoEpSWa88xkkoZK5qxJHVPwIkH5GCnEH9SymCfEdvYDf
         On0armzMhMNuMOW63ensFtZoFMYIOmapevSlSlMlFThjKJa9426yVQ46xO2otOQClu
         SykSAFotztdsA==
X-CNFS-Analysis: v=2.4 cv=WK+64lgR c=1 sm=1 tr=0 ts=61d6adfa cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=xKy2jhtLynXqGDVUPboA:9 a=QEXdDO2ut3YA:10
Message-ID: <82a340b5-6cd3-ec5b-827b-417eaede3f44@libero.it>
Date:   Thu, 6 Jan 2022 09:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/6] btrfs: add flags to give an hint to the chunk
 allocator
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
 <377d6c51cb957fbad5627bb93ff0a76ce9ba79da.1639766364.git.kreijack@inwind.it>
 <YdYXWlp+naKtzV+E@zen>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YdYXWlp+naKtzV+E@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGdw5eLhvucyoQgSJcetHZOCYMryu9Xyv3tcQ70xiG9ufCosx0FZy788a5C5Fn0bfkdwjmb8O17LSs1RewI/O6lJyNk29wlnez+6r8kD288arst9wuTn
 3CslJOXnEFmYhYmH3TwsxjEB0n/wZmIZU4UvZi+hChD7Gpvvu8P8Y/kUtIkcZ7j0ulJSBwNDbyPu9Wrhf7k0cr/NMrWJSXOVrdyhtfvRKKV7+Z+M2FXvFreA
 I9ea1pTXKhda59WtLs19ggRpYEosdUC5YtpOeMWe9L/j2A6K7dcl6csFxKRKlR1VdLKKJcSWGfqcsqilhX+j1iZM42bvUDnvvRGTy1uCIzs0pRfNV/36hEZz
 dGOE8PxRMxDNrYeVS/nND6bQ+Wj87bhymUq/bqyRdNhL50MabiSIOh1LRFYDcdHgeVHOTS6Y
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/01/2022 23.10, Boris Burkov wrote:
> On Fri, Dec 17, 2021 at 07:47:17PM +0100, Goffredo Baroncelli wrote:
[...]
> 
> Therefore, I think you should go with DATA_ONLY, DATA_PREFERRED,
> METADATA_ONLY, METADATA_PREFERRED. Definitely put ONLY/PREFERRED on the
> same side of DATA/METADATA for all four, regardless of which you choose.

This was the conclusion that I already reached with Zygo. The next patches set
will rename the flag in this way.


> 
> Looks good otherwise.
> 
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwid.it>
>> ---
>>   include/uapi/linux/btrfs_tree.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>> index 5416f1f1a77a..55da906c2eac 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -386,6 +386,22 @@ struct btrfs_key {
>>   	__u64 offset;
>>   } __attribute__ ((__packed__));
>>   
>> +/* dev_item.type */
>> +
>> +/* btrfs chunk allocation hint */
>> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT	2
>> +/* btrfs chunk allocation hint mask */
>> +#define BTRFS_DEV_ALLOCATION_HINT_MASK	\
>> +	((1 << BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) -1)
>> +/* preferred data chunk, but metadata chunk allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA	(0ULL)
>> +/* preferred metadata chunk, but data chunk allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA	(1ULL)
>> +/* only metadata chunk are allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY		(2ULL)
>> +/* only data chunk allowed */
>> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY		(3ULL)
>> +
>>   struct btrfs_dev_item {
>>   	/* the internal btrfs device id */
>>   	__le64 devid;
>> -- 
>> 2.34.1
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
