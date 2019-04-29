Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52994E8AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfD2RU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 13:20:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33913 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfD2RU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 13:20:58 -0400
Received: by mail-it1-f195.google.com with SMTP id z17so486483itc.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1JaNyJVW+yMoByjMDmiT6EqB9uQ4r2ZZODEarh9Ax14=;
        b=R/h9xfxSoRX1GqYb5i8CIUCvLLDzuqS337Ryo5MHx4P96sGNz0E+uWMDDjpln+OYh5
         C3mYF/HxZ91N0fWbSDsTHrfOPQDzleS709RoAUPRYRK4q2hnrJaAn4Nm3Pvhi8kgACtS
         3dbXbJEeUAAI7qEi8exlgPJxfmwD+0UClY9SxuGwPeGrllioxTrB9iEnFD0mCuUqCmRk
         j2Zoky1pJBytp1tdx2gom6Ixl6uyngweC4BnLc06Zdupdmpf2DT+P81OrZNaECQC5Mbi
         jDt8cg45qttkFFWAf1wa9kuaVWBK+/z9l+Iv755sxw5ORTS8BXOM3C6x645d3PBRWcYp
         vqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1JaNyJVW+yMoByjMDmiT6EqB9uQ4r2ZZODEarh9Ax14=;
        b=PYJBabA+3yhR/+JS7/bhGvErr6dy5I4KREdPuPzpHFTyksRCUr+ux0VOEnn4T6AN1N
         LI3hZlC6QCsQY0MPISBJtL5dqmHotzE5AG6HvVXys5fmobsi6WWv0a42+vJL9g5ARPxa
         7sqysYqSFf5MesPDxVVg9g9rdEWqPyUgcnwbg05pG50dM/sjMRf/Gt3bZQRO06sUanKn
         r06so/mVamMPnzTbZif3i3kaAxIUntyxjRlXOdpH+Ag5PGMyybHbXuf7KfoorylV9fUg
         AzCOQ3Y3ESNKYLwTXeBuXZ6JPHz5IdlCjCmN4TKOMGBbhGEl6ZlEHHMVNbpHdd3LsW/X
         /lKg==
X-Gm-Message-State: APjAAAXbkI0wWrWLGo5DFIAjyF4FSDq1QKrA29ohdrZIpe0rjFV12Zlk
        14JwjI0rRNX2jdp8XNsRDEo3urPTcTA=
X-Google-Smtp-Source: APXvYqxy5oAx1w6ZQmim/Xd+p+QD0GYnnUEIfQBYAlhGZgVszORwAtFoRz+vwqYuhB+OzFoDLo2oDQ==
X-Received: by 2002:a24:39ca:: with SMTP id l193mr138298ita.164.1556558457388;
        Mon, 29 Apr 2019 10:20:57 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id y18sm180969ita.3.2019.04.29.10.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:20:56 -0700 (PDT)
Subject: Re: Migration to BTRFS
To:     Hendrik Friedel <hendrik@friedels.name>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <emb78b630a-c045-4f12-8945-66a237852402@ryzen>
 <0f1a1f40-c951-05dc-f9fd-d6de5884f782@gmail.com>
 <e27cc7ee-4256-0ccc-a9f1-79cd6898e927@gmail.com>
 <em12ddda3f-4221-4678-aa1c-0854489007e1@ryzen>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <595b60f2-2a93-2078-93f2-e5952aac1fa3@gmail.com>
Date:   Mon, 29 Apr 2019 13:20:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <em12ddda3f-4221-4678-aa1c-0854489007e1@ryzen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-04-29 12:16, Hendrik Friedel wrote:
> Hello,
>>> With "single" data profile you won't lose filesystem, but you will
>>> irretrievably lose any data on the missing drive. Also "single" profile
>>> does not support auto-healing (repairing of bad copy from good copy). If
>>> this is acceptable to you, then yes, both variants will do what you want.
>> Actually, it's a bit worse than this potentially. You may lose 
>> individual files if you lose one disk with the proposed setup, but you 
>> may also lose _parts_ of individual files, especially if you have lots 
>> of large (>1-5GB in size) files.
> You mean if parts of the files are on the failed drive, or what do you 
> have in mind?
Yes, it's if parts of the files are on the failed drive. Essentially, if 
a file has more than one extent, then with the single profile those 
extents may be stored on different drives.  The common case for this is 
dealing with files larger than the data chunk size for the filesystem 
(typically between 1-5GB on most reasonably sized volumes), because an 
extent can't be larger than a chunk.
> 
>> And on top of this, finding what data went missing will essentially 
>> require trying to read every byte of every file in the volume.
> Why is that and how would it be done (scrub, I suppose?)
There's no other way short of scanning the filesystem internals to 
figure out what chunks would be present on a missing disk and then map 
the contents of those chunks to the files they are part of.  Ideally, 
this wouldn't be the case, but it's a unusual enough situation that it's 
just not been a priority to provide a tool to do it.

As far as the actual process itself, scrub is one way to do it, but it 
requires using a separate tool to map the inode numbers spit out by the 
scrub messages in the kernel logs to actual file names.  There are a 
bunch of other ways to do it too though.  Personally, I'd probably 
through something together in Python to try and read each file all the 
way through, bail if it hit _any_ IO error, and then log the names of 
files it found IO errors in, though even something just chaining `find` 
and `cat` together and then watching the kernel log for IO error 
messages would be enough.
> I am wondering, why the design of 'single' is that way? It seems to me, 
> that this is unneccessarily increasing the failure probability. My 
> thinking: If I have two separate file-systems, I have a FP of Z, with Z 
> the probability of one drive to fail. If I one btrfs-system in single 
> profile, I have a FP of Z^N, wheras it could -with a different design- 
> still be Z, no?
Yes, it is technically possible, you just place each file entirely on 
one device.  In fact, you can see this as a placement option in many 
distributed filesystems.  There are a couple of reasons it's not done 
with local filesystems backed with conventional block storage:

* It adds an extra layer of complexity.  In a distributed filesystem, or 
even with mhddfs, you already have a nice, easy to use filesystem 
interface (or an object-storage interface) so you don't have to handle 
block mapping.  With a local filesystem though, you still have to do 
block translation, which then becomes far more complicated because of 
the new, extra, constraint on where each block can go.
* It is very good at confusing regular end-users.  Assume you have to 
place a 4GB file on a volume arranged like this, but only have 2G of 
space left on each disk.  You still technically have 4G of free space, 
but you can't put the file on the volume because there isn't enough 
space on either disk for it.  This type of situation is extremely 
confusing for normal users, and is not all that uncommon in desktop 
usage scenarios.  BTRFS also already has issues like this to begin with, 
and adding another source for them is not a good idea.
* The exact benefits of this usually don't matter for (comparatively) 
small local storage devices.  The primary reason it's done at all is for 
big hosting companies so that they can trivially guarantee that services 
will be fully functional if they can actually see all the files.  For a 
regular user on a small desktop, it just doesn't matter in most cases.

>>> As of today there is no provision for automatic mounting of incomplete
>>> multi-device btrfs in degraded mode. Actually, with systemd it is flat
>>> impossible to mount incomplete btrfs because standard framework only
>>> proceeds to mount it after all devices have been seen.
> Do you talk about the mount during boot or about mounting in general?
Both, unless you do some heavy modifications of some of the standard 
installed files (you need to disable some specific udev rules and then 
replace the standard `mount.btrfs` wrapper that systemd uses).
> 
>  > If I where you, with your use case I would consider using mhddfs
>  > https://romanrm.net/mhddfs which is filesystem agnostic layer on top 
> of 2x [-m
>  > DUP, -d SINGLE] BTRFS drives. Last time I tested mhddfs (about 5+ 
> years ago) it
>  > was dead slow, but that might not be very important to you. For what 
> it does it
>  > works great!
> 
> In fact, that is what I am using today. But when using snapshots, this 
> would become a bit messy (having to do the snapshot on each device 
> separately, but identically.
> 
>  > remember that backup is not a backup unless it has a extra backup
> 
> I do have two backups (one offsite) of all data that is irreplacable and 
> one of data that is nice to have (TV-Recordings).
> 
> 
> Greetings,
> Hendrik
> 

