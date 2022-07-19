Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4B57A6D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiGSS6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiGSS6I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 14:58:08 -0400
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D71371A7
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 11:58:04 -0700 (PDT)
Received: from [192.168.1.27] ([94.34.5.22])
        by smtp-17.iol.local with ESMTPA
        id DsPxoThndX0RaDsPxo1snY; Tue, 19 Jul 2022 20:58:02 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1658257082; bh=/x0Fw86+NJdc/qdXAUO2oJNb1AUJIwVnzKburyE8Wxo=;
        h=From;
        b=SyBP8KZBo1LK5cAdQeBx7sYvXyFJ5g9H3jsJP0HLaxdZCdfZTymQY96JLhj7etkoo
         OxZSaGWopyG5BxBAK+2qWPFMhSskCxhN47ncGCm+hpfAwgRUtFNSickrfb1u8Q0Te9
         avhob6Qh3yuQigF5/giYRndZqbQogftqN+QcXX1TNvvr1e65d7oL5Z50gWWEWIKSdp
         Pnnm2mfVIyHs4V1mUGE0NVYubHQOD7Gy6bdHWHnZgMYfMIjGLWYo/zJ/heTWdZGhDZ
         WkeLTLgX4ZApmGJqNOeVsLBnApdRbL9/W/Bioeo8kCOQNpMSfmfFBoKpzPi2Y180gZ
         qDSpSJaBkMQ4Q==
X-CNFS-Analysis: v=2.4 cv=P7T/OgMu c=1 sm=1 tr=0 ts=62d6feba cx=a_exe
 a=hwDnfLutCD/4BcDojJwT2A==:117 a=hwDnfLutCD/4BcDojJwT2A==:17
 a=IkcTkHD0fZMA:10 a=ZByNqj1JR6MraFjA3qYA:9 a=QEXdDO2ut3YA:10
Message-ID: <b75dc157-2191-4a98-462d-15874a858051@inwind.it>
Date:   Tue, 19 Jul 2022 20:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <PH0PR04MB74163D25836A5AF57E3BB3249B8C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <PH0PR04MB74163D25836A5AF57E3BB3249B8C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHNCmtO7tHK3/iC/GURdAU56DzIMVpgOkQ/XW4BijvVk/5Z+xGOw/aCLCQT/0RZ6lGOJlKHkf/zf2ZoLoiJHlsROtWa347H32Vbu8dF25P6vwjRJS2xN
 Ruu/xjwRKM1125FtovXpQyUaEx/UPBW+kdbYD89wxSXa7wq7UFXrhEh+KgT323WaRJUsk9FO1tjobIdvjphDvOeZHjh86RFT0eB5zdVPLkACCKjBoin3VNaJ
 Bk+ZL6sTTSv5eV6uobnOnhT07v/ihJba3D8xgLfXzYmnIBNrJl8LzjcVdehfqFsC
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/07/2022 09.30, Johannes Thumshirn wrote:
> On 15.07.22 19:54, Goffredo Baroncelli wrote:
>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>> [...]
>>>
>>> Again if you're doing sub-stripe size writes, you're asking stupid things and
>>> then there's no reason to not give the user stupid answers.
>>>
>>
>> Qu is right, if we consider only full stripe write the "raid hole" problem
>> disappear, because if a "full stripe" is not fully written it is not
>> referenced either.
> 
> It's not that there wil lbe a new write hole, it's just that there is sub-optimal
> space consumption until we can either re-write or garbage collect the blocks.

May be that I was not very clear. Let me to repeat: if we assume that we
can write only full stripe (padding with 0, if smaller), we don't have the
write-hole problem at all, so we can also avoid using RST.

  
>>
>> Personally I think that the ZFS variable stripe size, may be interesting
> 
> But then we would need extra meta-data to describe the size of each stripe.

It is not needed. The stripe allocation is per extent. The layout of the stripe
depends only by the start of the extent and its length. Assuming that you
have n disks and a raid5 layout, you already know that each (n-1) data blocks,
there is a parity block in the extent.

The relation between the length of the extent and the real data stored is

extent-length = data-length + 4k*(data-length / 4k / (n-1))
extent-length += 4k if (data-length  %(4k * (n-1))) > 0

extent-length = size of the extent (which contains the parity block)
data-length = the real length of consecutive data
n = number of disk

Below some examples that show better my idea:

Assuming the following logical address

Disk1	0    12k  24k
Disk2	4k   16k  28k
Disk3	8k   20k  ....


first write: data size = 1 block

Disk1	D1 ...
Disk2	P1 ...
Disk3	...

Extent = (0, 8K),


second write; data size = 3 block ( D2, D2*, D3 )

Disk1	D1 D2* P3 ...
Disk2	P1 P2  ...
Disk3	D2 D3  ...

Extent = (8k, 20K)


Write a bigger data, and shape the stripe taller:

3rd write; data size 32k: (D6, D6*, ... D9*

Disk1	D1 D2* P3 P68 P6*8* P79 P7*9* ...
Disk2	P1 P2  D6 D6* D7    D7* ...
Disk3	D2 D3  D8 D8* D9    D9* ...

Extent = (28k, 48k)

The major drawbacks are:
- you can break the extent only at stripe boundary (up to 64K * n)
- the scrub is a bit more complex, because it involves some math around
   the extents start/length
- you need to have an extent that describe the stripe. I don't know if this
   requirements is fulfill by metadata

The schema above, has an huge simplification if we allow BTRFS to use BG with
dedicated stripe size. Moreover this would reduce the fragmentation, even tough it
requires a GC.

> 
>> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
>> we can store different BG with different number of disks. Let me to make an
>> example: if we have 10 disks, we could allocate:
>> 1 BG RAID1
>> 1 BG RAID5, spread over 4 disks only
>> 1 BG RAID5, spread over 8 disks only
>> 1 BG RAID5, spread over 10 disks
>>
>> So if we have short writes, we could put the extents in the RAID1 BG; for longer
>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by length
>> of the data.
>>
>> Yes this would require a sort of garbage collector to move the data to the biggest
>> raid5 BG, but this would avoid (or reduce) the fragmentation which affect the
>> variable stripe size.
>>
>> Doing so we don't need any disk format change and it would be backward compatible.
>>
>>
>> Moreover, if we could put the smaller BG in the faster disks, we could have a
>> decent tiering....
>>
>>
>>> If a user is concerned about the write or space amplicfication of sub-stripe
>>> writes on RAID56 he/she really needs to rethink the architecture.
>>>
>>>
>>>
>>> [1]
>>> S. K. Mishra and P. Mohapatra,
>>> "Performance study of RAID-5 disk arrays with data and parity cache,"
>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Processing,
>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>>
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

