Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97513190130
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 23:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCWWtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 18:49:00 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:44738 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWWs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 18:48:59 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id A45799C3F4; Mon, 23 Mar 2020 22:48:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1585003736;
        bh=DZaIRD1jQyf3tMrvhREoB+mSC3ewuhH72qtgTRGsLWc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GZAAS8+6ii4ryuds6RK3SDP28ieYZNbunHbA4E3R5KO5F8MJuChQtFGyH9eSgCD2g
         +u8MVD9OLqz4L5FWhnpdiY5tydTuT0sOi30eYcfD5P+Ih/Vn+jr4K0TF8exr6L3LnI
         B4tydYUIKZ2mN9tJ3P5tpIndFVIVmQOyShfgDkjFGu7Bo9VzYOkGoBAhCZ5WORBU3y
         0mcn/8s/eJ0wpRO11xKklRadlu53r1rsx1lHe9vONpAor4DGR72Bm2+hf9RXErXsAI
         WBfa8bqOkC0y+bcoJbFGVsSZ7bWXnr9uCZf9pFVRLEa3/smeVxPX6s7Sqh92mTsrgC
         OZv/MUDt9HRSg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 283759BBE6;
        Mon, 23 Mar 2020 22:48:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1585003730;
        bh=DZaIRD1jQyf3tMrvhREoB+mSC3ewuhH72qtgTRGsLWc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=imEfFKyr2n2hS+RTJXtibgWkoGRhnFHseOGFn9bToJZjQpoR5KfxAVFZcDdeLt32v
         F2O54bVkl68pCyn6x7PNHbZpuLejob7HbTsd63KbuPUx0L2dS7CM7Gvcwfg+cb54pF
         7dLKauCILZvJ8DJXSId9jm4FNcEzuVik1vtKrKgDJxfsSClxXQe0gXt66h7R4/p2fX
         j7VrRkTkX7OhVVdY/pnErrXNq3YR4KQKQRy5qhWD+Cv1SHVjORvXXA0rYMJ4/tDt/1
         VQlDKtDYxVXyMhMhN5gscQrbUF4CDUeV6nbpY3UK8+StExw1XZI05jDSnffrSjtTa8
         Y63F+9GaWuTsg==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id E5039D7B9F;
        Mon, 23 Mar 2020 22:48:47 +0000 (GMT)
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
 <20200322234934.GE2693@hungrycats.org>
 <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <28ddb178-674b-fab7-afa4-18a575299c1d@cobb.uk.net>
Date:   Mon, 23 Mar 2020 22:48:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2020 20:50, Goffredo Baroncelli wrote:
> On 3/23/20 12:49 AM, Zygo Blaxell wrote:
>> On Sun, Mar 22, 2020 at 09:38:30AM +0100, Goffredo Baroncelli wrote:
>>> On 3/22/20 9:34 AM, Goffredo Baroncelli wrote:
>>>
>>>>
>>>> To me it seems complicated to
>>> [sorry I push the send button too early]
>>>
>>> To me it seems too complicated (and error prone) to derive the target
>>> profile from an analysis of the filesystem.
>>>
>>> Any thoughts ?
>>
>> I still don't understand the use case you are trying to support.
>>
>> There are 3 states for a btrfs filesystem:
>>
> [...]
>>
>>     3.  A conversion is interrupted prior to completion.  Sysadmin is
>>     expected to proceed immediately back to state #2, possibly after
>>     taking any necessary recovery actions that triggered entry into
>>     state #3.  It doesn't really matter what the current allocation
>>     profile is, since it is likely to change before we allocate
>>     any more block groups.
>>
>> You seem to be trying to sustain or support a filesystem in state #3 for
>> a prolonged period of time.  Why would we do that?  

In real life situations (particularly outside a commercial datacentre)
this situation can persist for quite a while.  I recently found myself
in a real-life situation where this situation was not only in existence
for weeks but was, at some times, getting worse (I was getting further
away from my target configuration, not closer).

In this case, the original trigger was a disk in a well over 10TB
filesystem beginning to go bad. My strategy for handling that was to
replace the failing disk asap, and then rearrange the disk usage on the
system later. In order to handle the immediate emergency, I made use of
existing free space in LVM volume groups to replace the failing disk,
but that meant I had some user data and backups on the same physical
disk for a while (although I have plenty of other backups available I
like to keep my first-tier backups on separate local disks).

So, once the immediate crisis was over, I needed to move disks around
between the filesystems. It was weeks before I had managed to do
sufficient disk adds, removes and replaces to have all the filesystems
back to having data and backups on separate disks and all the data and
metadata in the profiles I wanted. Just doing a replace for one disk
took many days for the system to physically copy the data from one disk
to the other.

As this system was still in heavy use, this was made worse by btrfs
deciding to store data in profiles I did not want (at that point in the
manipulation) and forcing me to rebalance the data that had been written
during the last disk change before I could start on the next one.

Bottom line: although not the top priority in btrfs development, a
simple way to control the profile to be used for new data and metadata
allocations would have real benefit to overstretched sysadmins.

