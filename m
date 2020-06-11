Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01911F6728
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFKLuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 07:50:15 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:38651 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbgFKLuO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 07:50:14 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id jLikjCc31trlwjLikjdj7U; Thu, 11 Jun 2020 13:50:10 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1591876210; bh=jsN2eMXvw5mJdHyCAr473KfK0MLBf4OIoxDlyD8dQgg=;
        h=From;
        b=jgUkBgBciqgaKASMdIA9HJ1ezj8ZT06o4jRg2cwW3wQxWm+SbqIXHZDseHus+89gg
         FLYgQeTTLX8BdyMMJ03o7koHHfUlTlCnjBGYfg/XA5mWclJmumNLybgNlx1N9yC2iW
         Hxjq86z5peV7phLm7rTSvJjISQxu8ieeFcOKUIXlzIQstTkJWodXy3u3r57XhUV8NQ
         Ga7kIB11x69Z0OmckgTUzEow8+tXKbWYv4PSPd0iBlwFjT8mnh5DnSBReKl1529hZU
         MK0mSOWuIAgXiHjtAiumQWUf6tUw4SurzKz3rc0tiDQ0yhuXleGUJkF9rptZkZEERQ
         QZzMIRyXPYPEg==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=ZMUWrXv0YcRg3GD29LMA:9 a=AuaMehczVH3II9PI:21
 a=itSLJ9krsox7bTBa:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <20200525171430.GX18421@twin.jikos.cz>
 <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
 <20200610203023.GL27795@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <d75fcfa5-0320-c6c2-13df-329cfdf45eaf@inwind.it>
Date:   Thu, 11 Jun 2020 13:50:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610203023.GL27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKEh4rulxAgH1Vf4RW9XDp76WNtL9HVjMjXjpf0IRexNd9+2aTA5BR4j0/aRn4B1naZgfVyCltlQQbJEwIzCSomyB+4w/4dD6DM1OhUsiUTC0hjJ/TLw
 OgdltrYgAQoHKj7NxvjtqscVvA6rYjeMcHupkiY1XsgRgxpirb4AJGb+BLgT8UcVzcwEyZ8tX+XauXnIzCtlWrFmeOnyIztq3U/SqqnNipAkK28DU6ZTjie2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/10/20 10:30 PM, David Sterba wrote:
> On Tue, May 26, 2020 at 10:19:35PM +0200, Goffredo Baroncelli wrote:
>> On 5/25/20 7:14 PM, David Sterba wrote:
>>> I'll start with the data structures
>>>
>>> On Thu, Mar 19, 2020 at 09:39:13PM +0100, Goffredo Baroncelli wrote:
>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>> +struct btrfs_chunk_info_stripe {
>>>> +	__u64 devid;
>>>> +	__u64 offset;
>>>> +	__u8 dev_uuid[BTRFS_UUID_SIZE];
>>>> +};
>>>> +
>>>> +struct btrfs_chunk_info {
>>>> +	/* logical start of this chunk */
>>>> +	__u64 offset;
>>>> +	/* size of this chunk in bytes */
>>>> +	__u64 length;
>>>> +
>>>> +	__u64 stripe_len;
>>>> +	__u64 type;
>>>> +
>>>> +	/* 2^16 stripes is quite a lot, a second limit is the size of a single
>>>> +	 * item in the btree
>>>> +	 */
>>>> +	__u16 num_stripes;
>>>> +
>>>> +	/* sub stripes only matter for raid10 */
>>>> +	__u16 sub_stripes;
>>>> +
>>>> +	struct btrfs_chunk_info_stripe stripes[1];
>>>> +	/* additional stripes go here */
>>>> +};
>>>
>>> This looks like a copy of btrfs_chunk and stripe, only removing items
>>> not needed for the chunk information. Rather than copying the
>>> unnecessary fileds like dev_uuid in stripe, this should be designed for
>>> data exchange with the usecase in mind.
>>
>> There are two clients for this api:
>> - btrfs fi us
>> - btrfs dev us
>>
>> We can get rid of:
>> 	- "offset" fields (2x)
>> 	- "uuid" fields
>>
>> However the "offset" fields can be used to understand where a logical map
>> is on the physical disks. I am thinking about a graphical tool to show this
>> mapping, which doesn't exits yet -).
>> The offset field may be used as key to get further information (like the chunk
>> usage, see below)
>>
>> Regarding the UUID field, I agree it can be removed because it is redundant (there
>> is already the devid)
> 
> Offset is ok. I had something like this:
> 
> struct dump_chunks_entry {
>         u64 devid;
>         u64 start;
>         u64 lstart;
>         u64 length;
>         u64 flags;
>         u64 used;
> };
> 
> This selects the most interesting data from the CHUNK_ITEM, except the
> 'used' member, see below.


The structure above is a structure "device basis". This means that for (e.g.) raidX chunks the fields:
- lstart
- length
- flags
- used
are repeated

In fact only devid and start are device specific.
I see the following possibilities

1)

struct dump_chunks_entry {
          u64 lstart;
          u64 length;
          u64 flags;
          u64 used;
          u64 start;
	 u64 devid;
}

pro: simple api
cons: waste of space (60% of data are repeated

2)

struct dump_chunk_disk_entry {
          u64 devid;
          u64 start;
}

struct dump_chunks_entry {
          u64 lstart;
          u64 length;
          u64 flags;
          u64 used;
	 u16 disks_count;
	 struct dump_chunk_disk_entry disks[]
};

pro: smaller data
cons: variable length data

3)

two different ioctl

BTRFS_IOC_DUMP_BLOCK_GROUP

struct dump_block_group {
	u64	lstart
	u64	used
	u64	length
	u64	flags
}

BTRFS_IOC_DUMP_CHUNK

struct dump_chunks_entry {
          u64 lstart;
          u64 start;
	 u64 devid;
}


Where the filed lstart is the key

pro: smaller data (only lstart is repeated); quite orthogonal api
cons: two IOCTLs

Considering that having as optional the "used" field, means to have two ioctl (or one ioctl with a parameter, but this is not so different).
More I think, more I like option 3), however I am less happy to loose an information like sub_stripes (will something like RAID50 comes to BTRFS ?). Unfortunately to have this information, we need to duplicate it for each dump_chunks_entry...

GB





> 
>>> The format does not need follow the exact layout that kernel uses, ie.
>>> chunk info with one embedded stripe and then followed by variable length
>>> array of further stripes. This is convenient in one way but not in
>>> another one. Alternatively each chunk can be emitted as a single entry,
>>> duplicating part of the common fields and adding the stripe-specific
>>> ones. This is for consideration.
>>>
>>> I've looked at my old code doing the chunk dump based on the search
>>> ioctl and found that it also allows to read the chunk usage, with one
>>> extra search to the block group item where the usage is stored. As this
>>> is can be slow, it should be optional. Ie. the main ioctl structure
>>> needs flags where this can be requested.
>>
>> This info could be very useful. I think to something like a balance of
>> chunks which are near filled (or near empty). The question is if we
>> should have a different ioctl.
> 
> I was not proposing a new ioctl but designing the data exchange format
> to optionally provide a way to pass more information, like the usage.
> The reference to search ioctl was merely to point out that there's one
> more search for BLOCK_GROUP_ITEM where the 'used' is stored. As this is
> potentially expensive, it won't be filled by default.
> 
> The structure above does not capture all the chunk data. We could pack
> more such structures into one ioctl call. I think that num_stripes is
> missing from there as this would make possible the raid56 calculations
> but otherwise it should be it.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
