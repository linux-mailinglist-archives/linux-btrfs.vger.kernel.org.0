Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4383048B0E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbiAKPdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 10:33:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiAKPdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 10:33:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35F73212CA;
        Tue, 11 Jan 2022 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641915230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PC1+yQTAqGGv0c5giVP1endqqFOpyWW0VVaN0eecr0=;
        b=Ni35sVtH5s/VjS7LdDoXdkJnrvl5I1pYW8upRpsqZo4hSe9XQSZQcwE8M6uMmYGXBQBx2v
        qq73F5vp958i5/qRgDmnoFBhITd3NiA3+ux/f8zCatC4mtnQbpe0T1zOynm2d+24XrrThQ
        Z31UbjA2TT8QYiFm0My5oe5vKHCYUFA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF4D213ADE;
        Tue, 11 Jan 2022 15:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k+tGN12j3WEyEAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 11 Jan 2022 15:33:49 +0000
Subject: Re: btrfs send picks wrong subvolume UUID
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
References: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
 <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
 <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <86abf8ba-5613-cf1b-bdca-6039b5e23524@suse.com>
Date:   Tue, 11 Jan 2022 17:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.01.22 г. 20:09, Dāvis Mosāns wrote:
> svētd., 2022. g. 2. janv., plkst. 22:37 — lietotājs Andrei Borzenkov
> (<arvidjaar@gmail.com>) rakstīja:
>>
>> On Sun, Jan 2, 2022 at 8:05 PM Dāvis Mosāns <davispuh@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> I have a bunch of snapshots I want to send from one fs to another,
>>> but it seems btrfs send is using received UUID instead of subvolumes own UUID
>>> causing wrong subvolume to be picked by btrfs receive and thus failing.
>>>
>>> $ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
>>> 2019-11-02/etc
>>>         Name:                   etc
>>>         UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
>>>         Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
>>>         Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403
>>>
>>
>> btrfs send will always use received UUID if available, it works as
>> designed and is not a bug. Bug is to have received UUID on read-write
>> subvolume. btrfs does not prevent it and it is the result of wrong
>> handling on the user side. You should never ever change read-only
>> subvolume used for send/receive to read-write directly - instead you
>> should always create writable clone from it.
>>
>> This was discussed extensively, see e.g.
>> https://lore.kernel.org/linux-btrfs/d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com/
> 
> I consider it as bug. How can anyone know they shouldn't do that. It
> is perfectly valid use case for sending subvolumes from one system to
> another system. After sending using "btrfs property set ro false" to
> set RW. Sounds very logical, why should I create a new snapshot? I
> just sent new one. Original system's subvolume could even be deleted
> with no plans to ever do any incremental sends. And seems many people
> have had this issue which just proves my point it's a bug. And if this
> is not supported, then why there exists such "btrfs property set ro
> false" at all who lets you shoot yourself in foot? If it didn't exist
> then everyone would use only other option by creating new RW snapshot
> which actually sounds more like a workaround for broken property set.
> So I would say first bug that needs fixing is changing "btrfs property
> set ro false" in kernel so that it clears received_uuid and
> regenerates new subvolume uuid because such modified subvolume isn't
> same as source and would still causes issue if it stayed same.
> That would fix it for future but wouldn't solve it for many people who
> already have such subvolumes. And it's pretty hard problem to track
> down unless you already know it. Like it took me a lot of time to
> figure out why send is failing. ro->rw was done 7 years ago and all
> snapshots since then have same received_uuid but I noticed btrfs send
> not working only now. For me, easiest way I'll just patch kernel to
> always use subvolume's uuid and ignore received_uuid, then btrfs send
> all snapshots so it will work fine for me. As for others, in general
> seems proper fix would be that btrfs send would give both uuid and
> received_uuid. Then btrfs receive could have a flag to ignore
> received_uuid and just use uuid. Or search by uuid and then fallback
> to received_uuid.


That behavior got fixed in btrfs-progs in version 5.14, in particular
commit:

https://github.com/kdave/btrfs-progs/commit/3b90ebc2d7eb4b4a4d5d55eff362e8127a673828

Of course it requires users upgrading btrfs-progs but even if we merged
some kernel-side fix (there's been one I authored couple of years ago
and it's been circulated on the mailing list but didn't get merged) it
would still require users upgrading their kernel eventually.

> 
