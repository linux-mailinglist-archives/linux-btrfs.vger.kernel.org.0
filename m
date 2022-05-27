Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9D536447
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiE0Oha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiE0Oh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 10:37:29 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72F2F01B
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 07:37:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C77C43F3BB;
        Fri, 27 May 2022 16:37:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -3.1
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jJYUGa6GSrQf; Fri, 27 May 2022 16:37:21 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9A3E53F6DF;
        Fri, 27 May 2022 16:37:21 +0200 (CEST)
Received: from [192.168.0.10] (port=50246)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nub5a-0009xk-TG; Fri, 27 May 2022 16:37:20 +0200
Message-ID: <dfdd1052-f00c-40cc-99f3-1a830d6df728@tnonline.net>
Date:   Fri, 27 May 2022 16:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: cp --reflink and NOCOW files
Content-Language: en-GB
To:     kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
From:   Forza <forza@tnonline.net>
In-Reply-To: <c6f55508-a0df-aea3-279d-75648793dfb2@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Goffredo,

On 2022-05-24 21:02, Goffredo Baroncelli wrote:
> Hi All,
> 
> recently I discovered that BTRFS doesn't allow to reflink a file
> when the source is marked as NOCOW

You probably saw in the my earlier email to the mailing list that this 
is a problem with the 'cp' tool, because it tries to set the +C after it 
has appended data to the target file.

> 
> $ lsattr
> ---------------C------ ./file-very-big-nocow
> $ cp --reflink file-very-big-nocow file2
> cp: failed to clone 'file2' from 'file-very-big-nocow': Invalid argument
> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
> 
> My first thought was that it would be sufficient to remove the "nocow" 
> flag.
> But I was unable to do that.
> 
> $ chattr -C file-very-big-nocow
> 
> $ strace cp --reflink file-very-big-nocow file2 2>&1 | egrep ioctl
> ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EINVAL (Invalid argument)
> 
> (I tried "chattr +C ..." too)
> 
> Ok, now my question is: how we can remove the NOCOW flag from a file ?
> 

The issue here is that nocow also means nodatasum (no checksums). The 
checksums are needed to verify the the integrity of the data blocks.

So in order to turn off nocow, checksums would have to be created for 
every block of data. Btrfs does not do this, because there is no way for 
Btrfs to actually know if the data is correct. The result is that Btrfs 
refuses to turn off the nocow fsattr.

The solution is to make a normal copy as you just experienced.

> My use case is to move files between subvolumes some of which are marked 
> as NOWCOW.
> The files are videos, so I want to avoid to copy the data.
> 

You can still reflink copy the files if you do something like:

# touch target/foo
# chattr +C target/foo
# cp --reflink=always source/foo target/foo

Target and source must be reachable from the same mountpoint. Easiest to
manage such a situation is to mount toplevel (subvolid=5) in /mnt/btrfs/ 
and handle the files from there.

Video files are unusual to keep as nocow. From my own experience and 
IMHO I think that nocow should always a last resort to take to in order 
to solve an urgent performance issue. Certain workloads can cause lots 
of extents and fragmentation due to the cow, but video editing or 
similar is normally not such a use case.

If you download large files to a spinning HDD, and they end up very 
fragmented, I suggest you use 'btrfs filesystem defrag' before you 
snapshot or reflink copy the files.

There are a lot of guides on the internet that suggest turning on nocow, 
but they rarely discuss the (potentially harmful) downsides with this 
choice.

You should now that because nocow also means nodatasum, Btrfs cannot 
self-heal or even detect data corruption in nocow files, even when using 
tools like 'scrub' or 'check'. In addition, there is no guaranteed 
redundancy with RAID/DUP profiles for those files because Btrfs relies 
on checksums to determine which device has a correct copy.

I advice against nocow in most situations because I have myself had 
corruption on precious photographs and videos due to bitrot. I have 
written a little about this on https://wiki.tnonline.net/w/Btrfs/Scrub

Good luck!

> 
> BR
> 
