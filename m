Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BC191858
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCXR7u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 13:59:50 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:52663 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbgCXR7u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 13:59:50 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id Gnq6jHOl7a1lLGnq6jGA0o; Tue, 24 Mar 2020 18:59:47 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1585072787; bh=K8RJlHVAryijWipcAt94vwZlTL4wTibuURUrZLb+qjE=;
        h=From;
        b=Js7km4vYr1oVZmELVH29uCphgX4X1eeYU3R+6WOJHd4C3N/Upznn+/EapnzmofqV0
         kb0phV/8HbXcuUjiwinABO3KDmcFoAE8bBgAoRqN3fIp1bXSFK8G0YC3I/aogE58Gp
         47BMZ24zS1OMj6NWvpN26msjFauxE3hZDZ/1QRbfPfm8rfRL9tVZbDvalgGP7Vy6EX
         srN5aOJO/lkdzboNnLfQbSkoZtJfz6FcgTIPC0yOg9NOafMZAai13C6A6MaWefCVKn
         srv8MyRll9ZNsKVD9TcT8MZTNkYxSQzNA6S1hG2c1NYy20zfWPt3R0VWj+jmG55xCt
         XsYP8TeeHjDew==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=IhhncFWBRmtyYThBR9kA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Anand Jain <anand.jain@oracle.com>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <2c7f2844-b97d-0e15-6ae6-40c9c935aa77@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <8977ac3d-7af6-65a7-5515-caab07983672@inwind.it>
Date:   Tue, 24 Mar 2020 18:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2c7f2844-b97d-0e15-6ae6-40c9c935aa77@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDKuN/L6G9QzMuYw/+nqNhLCw7M07yQI2wUYbuZ8KvHuj6sdswDmlhJ76HIAltuKFcX0bBfyhLvWT3h+LsecOfLyaqGPm8DPC+/p22msdm4Jy6eaqIEY
 wRsFW1JAuft/lhzT9D8WUyjEy9F8TEknFNnZ8zZFSR1nIWWArv2Cf4uAxIo1WQYXwOhjYb3e5rQBFB8DIF0LaQ7B9JlSq1KS+C3e9VMlJ89JOZ8ML3T4PqsA
 UHVwA1x0KuL4iQ4LeoqJAw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/24/20 5:55 AM, Anand Jain wrote:
> On 3/21/20 1:56 AM, Goffredo Baroncelli wrote:
>> Hi all,
[..]
>> Looking at the code it seems to me that the logic is the following (from btrfs_reduce_alloc_profile())
>>
>>          if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID6;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID5;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID10;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID1;
>>          else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>                  allowed = BTRFS_BLOCK_GROUP_RAID0;
>>
>>          flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>
>> So in the case above the profile will be RAID6. And in the general if a RAID6 chunk is a filesystem, it wins !
> 
>   That's arbitrary and doesn't make sense to me, IMO mkfs should save
>   default profile in the super-block (which can be changed using ioctl)
>   and kernel can create chunks based on the default profile. 

I'm working on this idea (storing the target profile in super-block). Of course this increase the consistency, but
doesn't prevent the possibility that a mixed profiles filesystem could happen. And in this case is the user that
has to solve the issue.

Zygo, suggested also to add a mixed profile warning to btrfs (prog). And I agree with him. I think that we can use
the space info ioctl (which doesn't require root privileges).

BR
G.Baroncelli

> This
>   approach also fixes chunk size inconsistency between progs and kernel
>   as reported/fixed here
>     https://patchwork.kernel.org/patch/11431405/
> 
> Thanks, Anand
> 
>> But I am not sure.. Moreover I expected to see also reference to DUP and/or RAID1C[34] ...
>>
>> Does someone have any suggestion ?
>>
>> BR
>> G.Baroncelli
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
