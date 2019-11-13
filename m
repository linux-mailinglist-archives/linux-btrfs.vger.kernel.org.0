Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB8FBBE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMWvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 17:51:19 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:53297 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKMWvT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 17:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201810; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X7tIGq4ukxDj+jkgelnPKccAG1VwNdEqH5IUmUXrAlM=; b=eKfj8jsa312ZTKifYQYLuLatJr
        1XLRV3aXL/FMpeMvZJmObGCmZ/I85ESuF8ENV9dD6PkNmlrS7Ft56+6Ytsn97aac/7dFoHlPw1UIS
        QCZqnrtGKf42QheMSueyVoqb4coN7aET2tE/3vERY5MN7yQKOwLra/O0hXBMsL59yzOuuuofi4ZpF
        MPecJTG3fCMW4Lj966kNh9qNZNdFL3BxkhzRLiQZXkEPxTcnOGTjKq9Lh1EZlj1RQK/fJhBoRYeyM
        np1dm+r2MZv0gokgeBDLK7zjPx1XVTZEtdDsJ3vs2rOI1Ou6cYITidj9bLxfAJvUCwP1p+mgysS3Q
        uzZtl/kQ==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:7746 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1iV1To-0005Yg-4S; Wed, 13 Nov 2019 23:51:16 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Avoiding BRTFS RAID5 write hole
To:     Hubert Tonneau <hubert.tonneau@fullpliant.org>,
        Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
References: <0JGAX5Q12@briare1.fullpliant.org>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <c8f387e9-9240-945d-da3e-568edaf032da@dirtcellar.net>
Date:   Wed, 13 Nov 2019 23:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <0JGAX5Q12@briare1.fullpliant.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First of all, I am just a regular and a BTRFS enthusiast with no proper 
filesystem knowledge.

regarding the write hole.... I was just pondering (and I may be totally 
wrong about this , but it is worth a shot)

If raid5/6 needs to read-modify-write - would not the write hole be 
avoided if you first log a XOR cipher value in the metadata, then you 
modify an already existing stripe by XOR'ing whatever needs to be 
modified on the rewriten stripe. The journal would only need to know 
what stripes are being modified so it can be checked on a mount.

If you encounter the write hole, the parity would not match and since 
the XOR cipher is in the metadata you can roll back any failed update 
byte by byte until the checksum match and you will be good to go with 
the old data instead of the new one.

If on the other hand you can write a new stripe the problem goes away. I 
personally are willing to have increased disk IO and reduced performance 
for space. After all raid5/6 is not performance oriented , but primarily 
a space saver.

once (if ever) BTRFS supports per subvolume raid levels then the 
performance issues goes away as you can always raid1/0 some subvolume if 
you need to sacrifice space for performance.

- Waxhead


Hubert Tonneau wrote:
> Goffredo Baroncelli wrote:
>>
>>> What I am suggesting is to write it as RAID1 instead of RAID5, so that if it's changed a lot of times, you pay only once.
>> I am not sure to understand what are you saying. Could you elaborate ?
> 
> The safety problem with RAID5 is that between the time you start to overwrite a stripe and the time you finish, disk safety is disabled because parity is broken.
> On the other hand, with RAID1, disk safety more or less remains all the time, so overwriting is no issue.
> 
> There are several possible strategies to keep RAID5 disk safety all the time:
> 
> 1) Use a journal
> This is the MDADM solution because it's the only resonable one if the RAID layer is separated from the filesystem (because you don't whan to add another sectors mapping layer).
> The problem is that it's IO expensive.
> This is the solution implemented in Liu Bo 2017 patch, as far as I can understand it.
> 
> 2) Never overwrite the RAID5 stripe
> This is stripe COW. The new stripe is stored at different disks positions.
> The problem is that it's even more IO expensive.
> This is the solution you are suggesting, as far as I can understand it.
> 
> What I'm suggesting is to use your COW solution, but also write the new (set of) stripe(s) as RAID1.
> Let me call this operation stripe COW RAID5 to RAID1.
> The key advantage is that if you have to overwrite it again a few seconds (or hours) later, then it can be fast, because it's already RAID1.
> 
> Morever, new stripes resulting from writing a new file, or appending, would be created as RAID1, even if the filesystem DATA is configured as RAID5, each time the stripe is not full or is likely to be modified soon.
> This will reduce the number of stripe COW RAID5 to RAID1 operations.
> 
> The final objective is to have few stripe COW operations, because they are IO expensive, and many RAID1 stripe overwrite operations.
> The price to pay for the reduced number of stripe COW operations is consuming more disk space, because RAID1 stripes consumes more disk space than RAID5 ones, and that is why we would have a background process that does stripe COW from RAID1 to RAID5 in order to reclaim disk space, and we could make it more aggressive when we lack disk space.
> 
> What I'm trying to provide is the idea that seeing the DATA as RAID1 or RAID5 is not a good idea when we have BTRFS flexibility. We should rather see it as RAID1 and RAID5, RAID5 beeing just a way to reclaim disk space (same for RAID1C3 and RAID6).
> Having METADATA as RAID1 and DATA as RAID5 was a first step, but BTRFS flexibility probably allows to do more.
> 
> Please notice that I understand the BTRFS and RAID principles, but on the other hand, I have not read the code, so can hardly say what is easy to implement.
> Sorry about that. I've written a full new operating system (see www.fullpliant.org) but the kernel :-)
> 
