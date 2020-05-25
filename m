Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFC1E1543
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbgEYUkE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 16:40:04 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:51495 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389950AbgEYUkD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 16:40:03 -0400
Received: from venice.bhome ([94.37.169.164])
        by smtp-34.iol.local with ESMTPA
        id dJtAjLkyUtrlwdJtAj8MJX; Mon, 25 May 2020 22:40:01 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590439201; bh=rMKi23xcYQsoGd4XaTyy/E4EDQkbeKg165g0qcyvTC0=;
        h=From;
        b=tWDjJyyRmaQV8I9A6tOx3RBiWHP6+eH5tvn8Dji6++JT6uHvdKD6E/vAeBaoxPqLG
         usYIPv9F5XhF+m//PpVtRmEjD0AFZeJP2A3G2XEullbWfB0/aOyLbbwRnLAJ5Ku9Q0
         b92MFmSjG8tSrpEP+tHp7kWqT6KiT4++HoeuVhiOgKMvHxqDuzOAsrQsPHARe5bGV4
         YAPvHaspNLs2CiHRc6DbZ7jAicFJA+HRDO4fsTtViillKGzfXKcTuEJzUc9YVYsn6W
         anQg5NNXEnaCLAa7YAL2lM8/ulENOpx0M9WzkcgbFK+cSzEMVzKuFAD7ZV0Z9a3q2P
         1RgCkvQnVtudw==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=ZMZ8MMmEMFyyBR6AU47QNg==:117 a=ZMZ8MMmEMFyyBR6AU47QNg==:17
 a=IkcTkHD0fZMA:10 a=40O-eZYNRSQPSXI9VYIA:9 a=lT_7I3K7BEpWP4jG:21
 a=dog5HGTVdPGmN9ol:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200318211157.11090-1-kreijack@libero.it>
 <20200525132734.GT18421@twin.jikos.cz>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <a1819577-dec1-6f99-65cd-4675c59695d6@libero.it>
Date:   Mon, 25 May 2020 22:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525132734.GT18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFiMTP8dX0kZ1RlGAMhS2dsTYK1dm0zNqqMbMmzEb90gThAcMAUiu4W0BLRWhbaeFCpRVwJ4wPCPquKDm/QeBTsYo7UvADFwq98/xFWsXPZ/ILgaJVV5
 buf9hIvZdZ+JAuMYyJC7VJv7TTzlavo7BUUiadfijo7ocfDIEX+XuiVX6T6+kqmbQgGqmMT0txEyckn8BbdUuVEQfeydIKJhU3Q=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/25/20 3:27 PM, David Sterba wrote:
> On Wed, Mar 18, 2020 at 10:11:56PM +0100, Goffredo Baroncelli wrote:
>> this patch adds support for the raid5/6 profiles in the command
>> 'btrfs filesystem usage'.
>>
>> Until now the problem was that the value r_{data,metadata}_used is not
>> easy to get for a RAID5/6, because it depends by the number of disks.
>> And in a filesystem it is possible to have several raid5/6 chunks with a
>> different number of disks.
> 
> I'd like to get the raid56 'fi du' fixed but the way you implement it
> seems to be a too big leap. I've tried to review this patch several
> times but always got the impression that reworking the calculations to
> make it work for some profiles will most likely break something else. It
> has happened in the past.

I understand your fear. Frankly speaking this code is quite complex.
More than it should be (even without the raid56 support).

I am looking for a solution less intrusive. Let me few days and I will
update the patch.

Then we can discuss its validity.

  
> So, let's start with the case where the filesystem does not have
> multiple profiles per block group type, eg. just raid5 for data and
> calculate that.
> 
> If this also covers the raid56 case with different stripe counts, then
> good but as this is special case I won't mind addressing it separately.
> 
> The general case of multiple profiles per type is probably an
> intermediate state of converting profiles, we can return something sane
> if possible or warn as what we have now.

Another possibility is when a drive is added and a balance is not performed.

However this should be "safe" because it would underestimate the free space.

> 
> I'm fine if you say you're not going to implement that.
> 

I want to work on that.


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
