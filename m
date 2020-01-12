Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AFF138791
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2020 18:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbgALRjO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jan 2020 12:39:14 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:46351 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgALRjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jan 2020 12:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dirtcellar.net; s=ds201912; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WpfQJ8f9Y3kok/8pxRHMGxIeRdYnO6eLEqT7Eq8UQE4=; b=JxacdiEugZugtgTlXDIbvT0LAm
        YZudATt39X8GVm2HdrPOMH5FUV3jxgz9T1/3+eSiy8gyjmKskaub3rlfuDmpUKnAhGrAWuDw/ksdd
        5S+eM/85LxKi0953Y3SCWA02lgbQBLUWaKdzDkbkJycPhji56nRb0YdIMlS3seR+AyR0tA2MilGQ1
        Dl9S+tHvfjqc/yVF6ZzM1zK0yUN3lQFrNFN2r+6KfFQvR6bTp/CxN2q0/GH4eRQdRaZSVnS1yoVEP
        hlqQLX5AjMEg8H20M1Fd6VwzmhabxLsTi0FooWxN44ggyHzN1Cj6nK82p0KCPOCPB385XNbt9WILv
        kVtihwFA==;
Received: from 254.79-160-170.customer.lyse.net ([79.160.170.254]:6779 helo=[10.0.0.10])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <waxhead@dirtcellar.net>)
        id 1iqhCh-0000MN-I6; Sun, 12 Jan 2020 18:39:11 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error
 occurred
To:     Philip Seeger <philip@philip-seeger.de>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net>
 <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
 <2a9bf923-e7b9-9d82-5f1d-bbdfc192978e@suse.com>
 <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
 <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de>
 <9b6d7519-cffb-2cfa-5e77-b514817b5f0a@gmail.com>
 <2ddeb325-7c53-5423-8b14-8393c6928350@philip-seeger.de>
From:   waxhead <waxhead@dirtcellar.net>
Message-ID: <01a333c2-b3fc-128c-073a-d7b4d455f13c@dirtcellar.net>
Date:   Sun, 12 Jan 2020 18:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <2ddeb325-7c53-5423-8b14-8393c6928350@philip-seeger.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I agree with this. btrfs device stats /mnt should show the number of 
filesystem errors as well. In short I think regular users (like me for 
example) would want a output that shows how many fixes has been 
performed. E.g. each time BTRFS' repair logic kicks inn an either logs a 
file as corrupt or corrects a checksum failure with a second copy it 
should be logged.

Speaking of... it would be great if btrfs device stats /mnt (or some 
other command) could offer to show a list of corrupted files with paths 
(which I assume the filesystem know about). That would make restoring 
files from backup a breeze!

-Waxhead

Philip Seeger wrote:
> On 1/11/20 8:42 AM, Andrei Borzenkov wrote:
> 
>> On one mirror piece. It likely got correct data from another piece.
> 
> This may be a dumb question, but what mirror are we talking about here? 
> Note that this "csum failed" message happened on a different system 
> (than the "read error corrected" I quoted in the first message of this 
> thread). This happened on a simple btrfs partition and by default, 
> "data" isn't mirrored (fi df: single).
> I wrote it in the same thread, not to cause confusion, but simply 
> because I saw the same problem I'm trying to describe in another 
> configuration: "dev stats" claims no errors occurred and monitoring 
> tools relying on "dev stats" therefore won't be able to notify admins 
> about a bad drive before.
> 
> I think this is a serious bug. Just think about what that means. A drive 
> goes bad, btrfs keeps fixing errors caused by that drive but as "dev 
> stats" keeps saying "all good" (which is checked hourly or daily, by a 
> monitoring job), no admin will be notified. A few weeks later, a second 
> drive fails, causing data loss. The whole raid array might be gone and 
> even if the backups are relatively up-to-date, the work from the past 
> few hours will be lost and then there's the outage and the downtime 
> (everything has to be shut down and restored from the backup, which 
> might take a lot of time if the backup system is slow, maybe some parts 
> are stored on tapes...).
> 
> In other words: What's the point of a RAID system if the admin won't be 
> able to know that a drive is bad and has to be replaced?
> 
>> This is not device-level error. btrfs got data from block device without
>> error. That content of data was wrong does not necessarily mean block
>> device problem.
> 
> I understand that it's unlikely that it was a block device problem, 
> after all it's a new hard drive (and I ran badblocks on it which didn't 
> find any errors).
> But if the drive is good and the file appears to be correct and one (of 
> two?) checksum matched the file's contents, why was the other checksum 
> wrong? Or could it be something completely different that triggers the 
> same error message?
> 
>> You have mirror and btrfs got correct data from another device
>> (otherwise you were not able to read file at all). Of course you should
>> be worried why one copy of data was not correct.
> 
> Which other device?
> 
> By one copy of data you mean one of two checksums (which are stored 
> twice in case one copy gets corrupted like in this case apparently)?
> 
>> Again - there was no error *reading* data from block device. Is
>> corruption_errs also zero?
> 
> Yes, all the error counts were zero.
