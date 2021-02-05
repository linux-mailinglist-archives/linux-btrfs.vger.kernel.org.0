Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2D310F76
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 19:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhBEQXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 11:23:46 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:35814 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233590AbhBEQUP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 11:20:15 -0500
Received: from venice.bhome ([84.220.31.15])
        by smtp-33.iol.local with ESMTPA
        id 85QWl4Fo711DD85QWl430a; Fri, 05 Feb 2021 19:01:53 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612548113; bh=vB2P/FA9P5mgNG9EoUzFsYBBIfvKwGFhbqzqqJalARY=;
        h=From;
        b=C+Cc7VWbAr6jfHLyw8D9D4OhGdBcK2YX+4qSHkikTvbcD32iH01jgurDWTK0H2pcS
         Zg3wHKJbmj3q+wS2Oezy+Y7eF8IdcP85CKRA6AVo1KcgKjBLOGsH9H08T2SJIcqVsF
         PKMK6+C34bSH2Hucxr6pIvIfbxev0aGG6D6ObBnINNKwtMxWm6oHpu8LPcJaQr36Ew
         9KDbqi/7fTnQuhgK9Q+Tg4hlaqe8eyTzuXgu2BfuH4eWlY+w86SfcHNs5LZy95cu2o
         IX5rQOpHLk+olo0gtn65cDPkQccxLHgk/3DDT5A3BwKuRtVIvsdi4YogJmGN7SYe0M
         5G1hXhh9j9GjQ==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=601d8811 cx=a_exe
 a=x2dg/lNnxV9i/e65rnwt7A==:117 a=x2dg/lNnxV9i/e65rnwt7A==:17
 a=IkcTkHD0fZMA:10 a=fystPN74lEtJ2zckaD0A:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 5/5] btrfs: add allocator_hint mode
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-6-kreijack@libero.it>
 <20210204232445.GC32440@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <9b4fc7b1-750c-643d-8487-153e5cf7cebd@libero.it>
Date:   Fri, 5 Feb 2021 19:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204232445.GC32440@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPImS0kAAoSPwSr4grpSCKJLfjEuoeJwrE3YP08p5o13fM/wQ1COeK+rtGaWEt93E0q3yw9ZB8+ONDTV3Qqr1czSx/cfoB+0BA0w9uYeZjEuR+B7a78a
 7IDJMzr9o4XOdMxbeoHZgRrlrtjU63wLOom9qBIvLr0iaqcgYmsVgDBTn3QuPHkGn7twgYd2DsxbT6AOc9K1YLtnWlwHSrTzG3CLSMsvgHkW30LLsYn6Iyal
 52S5tDjAWU3eLvJX66PhUSoDXVM2paAxhUYJUzZFYz/+kAlaQo8fpRbRNu0XiCwo
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/5/21 12:24 AM, Zygo Blaxell wrote:
> On Mon, Feb 01, 2021 at 10:28:20PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
[...]
Hi Zygo
> 
> Well, I guess if you're going to keep putting the mount option in each
> new patch version, then I'm going to keep saying "please remove the
> mount option" from each new patch version.
> 
> The right side of this || can be deleted, and the entire patch 4/5
> (which adds the mount option).

In the next iteration I will move the "mount option" patch at the end of the chain; this will help you to remove this part of the patch that you don't like.

[...]



> 	(gdb) l *(btrfs_alloc_chunk+0x74b)
> 	0xffffffff8190c3ab is in btrfs_alloc_chunk (fs/btrfs/volumes.c:5047).
> 	5042            ndevs = 0;
> 	5043            while (ndevs < ctl->ndevs) {
> 	5044                    hint = devices_info[ndevs++].alloc_hint;

> 	5045                    while (devices_info[ndevs].alloc_hint == hint &&
> 	5046                           ndevs < ctl->ndevs)

this check is WRONG. The left and right side of && have to be swapped. Otherwise it is possible
an access to the last element+1 of the array before the out of bound check.
My fault.

> 	5047                                    ndevs++;
> 	5048                    if (ndevs >= ctl->devs_min)
> 	5049                            break;
> 	5050            }
> 	5051

BR
G.Baroncelli


> 
>> +		if (ndevs >= ctl->devs_min)
>> +			break;
>> +	}
>> +
>> +	BUG_ON(ndevs > ctl->ndevs);
>> +	ctl->ndevs = ndevs;
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index d776b7f55d56..31a3e4cf93b5 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -364,6 +364,7 @@ struct btrfs_device_info {
>>   	u64 dev_offset;
>>   	u64 max_avail;
>>   	u64 total_avail;
>> +	int alloc_hint;
>>   };
>>   
>>   struct btrfs_raid_attr {
>> -- 
>> 2.30.0
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
