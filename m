Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA12850A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgJFRUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 13:20:18 -0400
Received: from smtp-18.italiaonline.it ([213.209.10.18]:58502 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgJFRUR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Oct 2020 13:20:17 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 13:20:15 EDT
Received: from venice.bhome ([94.37.195.85])
        by smtp-18.iol.local with ESMTPA
        id PqVQkdO98l7OPPqVQkkDM1; Tue, 06 Oct 2020 19:12:05 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1602004325; bh=IXgNuMSs2cPtsdjq0eQhwVzWAdckjIiSFnoX/GKdGag=;
        h=From;
        b=mv589dqVmsXqtoYa7XlI7WhFpJXWYVasV2oyw9QJ0FJ7kOTu9wT6YC1eCtH1jtk2f
         cnOwUosNYsiRK7VK3I/qAcCH3YSf7H6gYiTj632JclvGdKlGHKkTGKDGHY7qIGwm2q
         Mrk/RWkmEtYkagOp3hf5UifI41l2g1+epPg/6JJ27SxfrFZUYWUlIWAhZTHXOsvk+j
         1W/+H2QAzfoVu6ID0UrCmFzW13movi5fu9xGjO7rP0OoLewPW4AG/3yZUjIOHxHW5F
         gPsadvCeAmIzqQAt/CIIg7WQQOHgrAnLFKBkmuhPLW+vkUJk+w/k+63P9VFnJUY++u
         ZdYtU2n7B5nbg==
X-CNFS-Analysis: v=2.4 cv=VL9jI/DX c=1 sm=1 tr=0 ts=5f7ca565
 a=6i7ZtOMYC9jVyZJnprbtYA==:117 a=6i7ZtOMYC9jVyZJnprbtYA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8 a=jHGVAbiu1z7yCMA1S7cA:9
 a=eB-9-X1twNelMSns:21 a=JZL66dzF2liN54IP:21 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=SLz71HocmBbuEhFRYD3r:22
Reply-To: kreijack@inwind.it
Subject: Re: using raid56 on a private machine
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     cryptearth <cryptearth@cryptearth.de>, linux-btrfs@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
References: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
 <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
 <20201006012427.GD21815@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <db963644-ac4b-cf19-dcf6-795ff92413e8@inwind.it>
Date:   Tue, 6 Oct 2020 19:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201006012427.GD21815@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOBq4h9W3FEuqPqOD3EEby9yF4M3qA1497cdV5nXTV0UcporicQO2Zu1nbobO9Z+82+PmYJ1elRbz9zmKl5wJExTnIsVRPFXYP0sfvT2Fn1nDUTh2kmS
 t7lpG86ckA6sQGhU/RmfrbYUasnUTNqbJDuTy65vzdsqLNkCq/9ixRckTQ+cZckysFhyU6CstdKsFpxxAFf9AKZX9QHVjtpAQdat0lPAMIH6PX3A1RfmAs2B
 W/d7pEQ7zIxy/As6TDiC366+hgfKkcCGBB8HF3GLYHOB3h009TsYZjQAgO8DU/pt
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/6/20 3:24 AM, Zygo Blaxell wrote:
> On Mon, Oct 05, 2020 at 07:57:51PM +0200, Goffredo Baroncelli wrote:
[...]

>>
>> I have only few suggestions:
>> 1) don't store valuable data on BTRFS with raid5/6 profile. Use it if
>> you want to experiment and want to help the development of BTRFS. But
>> be ready to face the lost of all data. (very unlikely, but more the
>> size of the filesystem is big, more difficult is a restore of the data
>> in case of problem).
> 
> Losing all of the data seems unlikely given the bugs that exist so far.
> The known issues are related to availability (it crashes a lot and
> isn't fully usable in degraded mode) and small amounts of data loss
> (like 5 blocks per TB).

 From what I reading in the mailing list when the problem is too complex to solve
to the point that the filesystem has to be re-format, quite often the main issue is not to
"extract" the data, but is about the availability of additional space to "store" the data.

> 
> The above assumes you never use raid5 or raid6 for btrfs metadata.  Using
> raid5 or raid6 for metadata can result in total loss of the filesystem,
> but you can use raid1 or raid1c3 for metadata instead.
> 
>> 2) doesn't fill the filesystem more than 70-80%. If you go further
>> this limit the likelihood to catch the "dark and scary corners"
>> quickly increases.
> 
> Can you elaborate on that?  I run a lot of btrfs filesystems at 99%
> capacity, some of the bigger ones even higher.  If there were issues at
> 80% I expect I would have noticed them.  There were some performance
> issues with full filesystems on kernels using space_cache=v1, but
> space_cache=v2 went upstream 4 years ago, and other significant
> performance problems a year before that.

My suggestion was more to have enough space to not stress the filesystem
than "if you go behind this limit you have problem".

A problem of BTRFS that confuses the users is that you can have space, but you
can't allocate a new metadata chunk.

See
https://lore.kernel.org/linux-btrfs/6e6565b2-58c6-c8c1-62d0-6e8357e41a42@gmx.com/T/#t


Having the filesystem filled to 99% means that you have to check carefully
the filesystem (and balance it) to avoid scenarios like this.

On other side 1% of 1TB (a small filesystem for today standard) are about
10GB, that everybody should consider enough....

  
> The last few GB is a bit of a performance disaster and there are
> some other gotchas, but that's an absolute number, not a percentage.

True, it is sufficient to have few GB free (i.e. not allocated by chunk)
in *enough* disks...

However these requirements are a bit complex to understand by a new BTRFS
users.

> 
> Never balance metadata.  That is a ticket to a dark and scary corner.
> Make sure you don't do it, and that you don't accidentally install a
> cron job that does it.
> 
>> 3) run scrub periodically and after a power failure ; better to use
>> an uninterruptible power supply (this is true for all the RAID, even
>> the MD one).
> 
> scrub also provides early warning of disk failure, and detects disks
> that are silently corrupting your data.  It should be run not less than
> once a month, though you can skip months where you've already run a
> full-filesystem read for other reasons (e.g. replacing a failed disk).
> 
>> 4) I don't have any data to support this; but as occasional reader of
>> this mailing list I have the feeling that combing BTRFS with LUCKS(or
>> bcache) raises the likelihood of a problem.

> I haven't seen that correlation.  All of my machines run at least one
> btrfs on luks (dm-crypt).  The larger ones use lvmcache.  I've also run
> bcache on test machines doing power-fail tests.


> 
> That said, there are additional hardware failure risks involved in
> caching (more storage hardware components = more failures) and the
> system must be designed to tolerate and recover from these failures.
> 
> When cache disks fail, just uncache and run scrub to repair.  btrfs
> checksums will validate the data on the backing HDD (which will be badly
> corrupted after a cache SSD failure) and will restore missing data from
> other drives in the array.
> 
> It's definitely possible to configure bcache or lvmcache incorrectly,
> and then you will have severe problems.  Each HDD must have a separate
> dedicated SSD.  No sharing between cache devices is permitted.  They must
> use separate cache pools.  If one SSD is used to cache two or more HDDs
> and the SSD fails, it will behave the same as a multi-disk failure and
> probably destroy the filesystem.  So don't do that.
> 
> Note that firmware in the SSDs used for caching must respect write
> ordering, or the cache will do severe damage to the filesystem on
> just about every power failure.  It's a good idea to test hardware
> in a separate system through a few power failures under load before
> deploying them in production.  Most devices are OK, but a few percent
> of models out there have problems so severe they'll damage a filesystem
> in a single-digit number of power loss events.  It's fairly common to
> encounter users who have lost a btrfs on their first or second power
> failure with a problematic drive.  If you're stuck with one of these
> disks, you can disable write caching and still use it, but there will
> be added write latency, and in the long run it's better to upgrade to
> a better disk model.
> 
>> 5) pay attention that having an 8 disks raid, raises the likelihood of a
>> failure of about an order of magnitude more than a single disk ! RAID6
>> (or any other RAID) mitigates that, in the sense that it creates a
>> time window where it is possible to make maintenance (e.g. a disk
>> replacement) before the lost of data.
>> 6) leave the room in the disks array for an additional disk (to use
>> when a disk replacement is needed)
>> 7) avoid the USB disks, because these are not reliable
>>
>>
>>>
>>> Any information appreciated.
>>>
>>>
>>> Greetings from Germany,
>>>
>>> Matt
>>
>>
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
