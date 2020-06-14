Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9461F8886
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgFNLHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 07:07:04 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:59720 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726965AbgFNLGc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 07:06:32 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id kQT5jesOetrlwkQT5jwBye; Sun, 14 Jun 2020 13:06:28 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1592132788; bh=/k/FBGXl8gBOpAgQlZbZD/eprw+sAT+SLcsn6/22K2k=;
        h=From;
        b=kgLMz5sfEFkqUgxvKWWGx0dNgXnpYrEYSdJTpd2PktS2k1SJPRV9j2lKNcBy2R9Wu
         Ex6Ek8+gcXgHupQDFRtt9spV7IIueCogSegZw+SF2LcgtaChsNIUQObEbWBV4mcyi0
         tjaFCEMDhOxj4yLj0XLNYPgcGaXusbzRi1BqV2srCbf2DWHbcYwIt5eOekgd9rmVGd
         Dr69Bgvl2tDOjFwZ49DZxKmAwkaW7+2AGtdsQmfuMJU50DTHxy3fREwUaqo0IAPIdF
         w9ciCGGTzMq4YCYwTLL98f7pKGL0waQ0LUz+jTjYNjQKlSdWeij0/SGvPYCIi2VA6U
         QoK/c5QgSdk4A==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=_XWl5NMPOCL_FlYR2_oA:9 a=ldc33jUJ-eSerI9a:21
 a=dxTL3XpELyMygeVq:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
From:   Goffredo Baroncelli <kreijack@inwind.it>
To:     dsterba@suse.cz
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <20200525171430.GX18421@twin.jikos.cz>
 <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
 <20200610203023.GL27795@twin.jikos.cz>
 <d75fcfa5-0320-c6c2-13df-329cfdf45eaf@inwind.it>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Message-ID: <28fc9170-e8f8-7009-eb62-0bf680620f6b@inwind.it>
Date:   Sun, 14 Jun 2020 13:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <d75fcfa5-0320-c6c2-13df-329cfdf45eaf@inwind.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKvNkgSnk/SHOXWAPxiV0vwzixyCG7nSBTYugQD0SdAzaJTr6tLUZMscGhW0y75oy3W6sqhmUAwvG6Da5lSCV94Pa9SLopd3NCczLPIp7bDW50LJImU7
 A0v22jR7un81gFgN5SMmfc74KKEcJ9xR2uP2R+m4Jhzf+5B7DY2EHBEe04S4qpdqU0BOYB8QlBS0CXcfGd4ev54f0qdWigOZ3CsguZ4i4t/+HunGQxHmraQB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi david,

On 6/11/20 1:50 PM, Goffredo Baroncelli wrote:
> On 6/10/20 10:30 PM, David Sterba wrote:
>> On Tue, May 26, 2020 at 10:19:35PM +0200, Goffredo Baroncelli wrote:
>>> On 5/25/20 7:14 PM, David Sterba wrote:
>>>> I'll start with the data structures
>>>>
>>>> On Thu, Mar 19, 2020 at 09:39:13PM +0100, Goffredo Baroncelli wrote:
>>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>> +struct btrfs_chunk_info_stripe {
>>>>> +    __u64 devid;
>>>>> +    __u64 offset;
>>>>> +    __u8 dev_uuid[BTRFS_UUID_SIZE];
>>>>> +};
>>>>> +
>>>>> +struct btrfs_chunk_info {
>>>>> +    /* logical start of this chunk */
>>>>> +    __u64 offset;
>>>>> +    /* size of this chunk in bytes */
>>>>> +    __u64 length;
>>>>> +
>>>>> +    __u64 stripe_len;
>>>>> +    __u64 type;
>>>>> +
>>>>> +    /* 2^16 stripes is quite a lot, a second limit is the size of a single
>>>>> +     * item in the btree
>>>>> +     */
>>>>> +    __u16 num_stripes;
>>>>> +
>>>>> +    /* sub stripes only matter for raid10 */
>>>>> +    __u16 sub_stripes;
>>>>> +
>>>>> +    struct btrfs_chunk_info_stripe stripes[1];
>>>>> +    /* additional stripes go here */
>>>>> +};
>>>>
>>>> This looks like a copy of btrfs_chunk and stripe, only removing items
>>>> not needed for the chunk information. Rather than copying the
>>>> unnecessary fileds like dev_uuid in stripe, this should be designed for
>>>> data exchange with the usecase in mind.
>>>
>>> There are two clients for this api:
>>> - btrfs fi us
>>> - btrfs dev us
>>>
>>> We can get rid of:
>>>     - "offset" fields (2x)
>>>     - "uuid" fields
>>>
>>> However the "offset" fields can be used to understand where a logical map
>>> is on the physical disks. I am thinking about a graphical tool to show this
>>> mapping, which doesn't exits yet -).
>>> The offset field may be used as key to get further information (like the chunk
>>> usage, see below)
>>>
>>> Regarding the UUID field, I agree it can be removed because it is redundant (there
>>> is already the devid)
>>
>> Offset is ok. I had something like this:
>>
>> struct dump_chunks_entry {
>>         u64 devid;
>>         u64 start;
>>         u64 lstart;
>>         u64 length;
>>         u64 flags;
>>         u64 used;
>> };
>>
>> This selects the most interesting data from the CHUNK_ITEM, except the
>> 'used' member, see below.
> 
> 
> The structure above is a structure "device basis". This means that for (e.g.) raidX chunks the fields:
> - lstart
> - length
> - flags
> - used
> are repeated
> 
> In fact only devid and start are device specific.
> I see the following possibilities
> 
> 1)
> 
> struct dump_chunks_entry {
>           u64 lstart;
>           u64 length;
>           u64 flags;
>           u64 used;
>           u64 start;
>       u64 devid;
> }
> 
> pro: simple api
> cons: waste of space (60% of data are repeated
> 
> 2)
> 
> struct dump_chunk_disk_entry {
>           u64 devid;
>           u64 start;
> }
> 
> struct dump_chunks_entry {
>           u64 lstart;
>           u64 length;
>           u64 flags;
>           u64 used;
>       u16 disks_count;
>       struct dump_chunk_disk_entry disks[]
> };
> 
> pro: smaller data
> cons: variable length data
> 
> 3)
> 
> two different ioctl
> 
> BTRFS_IOC_DUMP_BLOCK_GROUP
> 
> struct dump_block_group {
>      u64    lstart
>      u64    used
>      u64    length
>      u64    flags
> }
> 
> BTRFS_IOC_DUMP_CHUNK
> 
> struct dump_chunks_entry {
>           u64 lstart;
>           u64 start;
>       u64 devid;
> }
> 
> 
> Where the filed lstart is the key
> 
> pro: smaller data (only lstart is repeated); quite orthogonal api
> cons: two IOCTLs
> 
> Considering that having as optional the "used" field, means to have two ioctl (or one ioctl with a parameter, but this is not so different).
> More I think, more I like option 3), however I am less happy to loose an information like sub_stripes (will something like RAID50 comes to BTRFS ?). Unfortunately to have this information, we need to duplicate it for each dump_chunks_entry...
> 
> GB

After some more thinking, I reached the conclusion that we should have two IOCTLs. The first one, is like the original one (where each item contains near all the information chunk related, with at the end an array of device-id involved+offset). The only exception is the removal of the UUID fields (and eventually the stripe_len/substripe/num_stripe/substripe fields). This could give us a good representation of the chunks layout.

The second one is an IOCTL to get the list of the block_group_item. Basically return a little less information than the previous one, with the notability exception of the "used".

My original idea was to lighting the chunk_info IOCTL and get most information from the block_group IOCTL. However I fear that if an user is interested only to the chunk layout (i.e. to answer to question like which device is used ?), he has to perform 2 ioctl. So after some thinking I returned to my original layout, with a second IOCTL to return the used values (eventually with other fields...)

Have an unique ioctl which could return both the information is quite complex because doing so we should merge two lists with all the exception of the case (what if we have a block_group without a chunk_item ? or the opposite ? ).

What is your opinion ?

BR
G.Baroncelli

> 
> 
> 
> 
> 
>>
>>>> The format does not need follow the exact layout that kernel uses, ie.
>>>> chunk info with one embedded stripe and then followed by variable length
>>>> array of further stripes. This is convenient in one way but not in
>>>> another one. Alternatively each chunk can be emitted as a single entry,
>>>> duplicating part of the common fields and adding the stripe-specific
>>>> ones. This is for consideration.
>>>>
>>>> I've looked at my old code doing the chunk dump based on the search
>>>> ioctl and found that it also allows to read the chunk usage, with one
>>>> extra search to the block group item where the usage is stored. As this
>>>> is can be slow, it should be optional. Ie. the main ioctl structure
>>>> needs flags where this can be requested.
>>>
>>> This info could be very useful. I think to something like a balance of
>>> chunks which are near filled (or near empty). The question is if we
>>> should have a different ioctl.
>>
>> I was not proposing a new ioctl but designing the data exchange format
>> to optionally provide a way to pass more information, like the usage.
>> The reference to search ioctl was merely to point out that there's one
>> more search for BLOCK_GROUP_ITEM where the 'used' is stored. As this is
>> potentially expensive, it won't be filled by default.
>>
>> The structure above does not capture all the chunk data. We could pack
>> more such structures into one ioctl call. I think that num_stripes is
>> missing from there as this would make possible the raid56 calculations
>> but otherwise it should be it.
>>
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
