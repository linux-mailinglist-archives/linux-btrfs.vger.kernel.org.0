Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91D9194574
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgCZR2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 13:28:10 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:40411 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727889AbgCZR2J (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 13:28:09 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id HWIYjsK8OMAUpHWIYjYpiq; Thu, 26 Mar 2020 18:28:07 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585243687; bh=hWxpIfqqlRHu4lfZCxc5K4BfIXhkXeE5gV4Ty3S9vnE=;
        h=From;
        b=fjjwFB+uu9f202CTt1tvOWXe11w++18CRpGXvC3mvVnVqXaF7Gsg01rBC+okIBLQO
         rynqcE5SiTG9BEehQjNdbyanffZ1AeSQv3w4lXVz1mSikBxsLtx9g2K9x2KKehFeBc
         LjG9uCKZl9R5eBJXrokoCU82H3VX+8CVI6kuaeqCL0Na+oRY/IAsczgAFdTEVLuFSy
         xVyjFaHZg2mx+5pVbqZvjKJsSYOnLwF3Au1wDmp9Vf05fcyraSAAwsJ6YH/LDP31Yx
         LaxtfyYBXk6jPLWgYs9MvXd+uMknj/zUovutZOQCZ7mhjWAsMSx2Kgx4163vPKLOmV
         DzWm3wlZSOr5Q==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=Af_NbHoicizH-blvzNAA:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/4] btrfs-progs: Add missing fields to btrfs_raid_array[]
 for raid1c[34].
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200325201042.190332-1-kreijack@libero.it>
 <20200325201042.190332-2-kreijack@libero.it>
 <484bec80-2469-b638-b80b-8811a0e8e9ff@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <caf00fb2-cbf6-e9d4-7f5d-66a81d87b57d@libero.it>
Date:   Thu, 26 Mar 2020 18:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <484bec80-2469-b638-b80b-8811a0e8e9ff@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGAn2d8Lf80poc6PLciuNfkkwsex09FWSZlFT5DLFCzHLW2Mj9UZG46uhVHROOfwGEmjYEavfW8gY90jk60hVcPaK+37lNINr3CQ3cAzMIlRB0rrCyMe
 ES6dK4oY6TvrVX/ZF5SGTb1KB7LKrQdmSdOWXF8lyIHz9coC1GuEntK13q7iE/1/B9p7BD211W9BE2hzFO3tnap1MXMmUg6hUYxbc4V9t9Wyg0wIfN86iE0c
 eRGKNgtTxgvN4I7drjQWr12fOwk3qJVrDU6v7lotMUmI9hmnB3lbpfTUoFAXTA+u
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/26/20 2:59 AM, Qu Wenruo wrote:
> 
> 
> On 2020/3/26 上午4:10, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   volumes.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/volumes.c b/volumes.c
>> index b46bf598..9e37f986 100644
>> --- a/volumes.c
>> +++ b/volumes.c
>> @@ -65,6 +65,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>>   		.tolerated_failures = 2,
>>   		.devs_increment	= 3,
>>   		.ncopies	= 3,
>> +		.raid_name	= "raid1c3",
>> +		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C3,
> 
> Since you're here, mind to also add .mindev_error?

I will take care of
BR
G.Baroncelli

> 
> Thanks,
> Qu
>>   	},
>>   	[BTRFS_RAID_RAID1C4] = {
>>   		.sub_stripes	= 1,
>> @@ -74,6 +76,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>>   		.tolerated_failures = 3,
>>   		.devs_increment	= 4,
>>   		.ncopies	= 4,
>> +		.raid_name	= "raid1c4",
>> +		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C4,
>>   	},
>>   	[BTRFS_RAID_DUP] = {
>>   		.sub_stripes	= 1,
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
