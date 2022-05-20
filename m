Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FAC52F4B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiETU70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiETU7Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 16:59:25 -0400
X-Greylist: delayed 123847 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 13:59:21 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F1196695
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 13:59:21 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 8584F9B6D3; Fri, 20 May 2022 21:59:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1653080359;
        bh=2uvEV1LWIas/sbv9uPIfGBqzdAeGyQk1W1mzNM7QMHg=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=E0zj/bBb/A8QLesaBDoTmoO8dDugetqhQQmGwZwwoH3krTK+tlroXRKSm9mCVsI35
         SII+AG9X7B/zpElNtcM/MH/4gic6sL2wQBcgmSvOgRNr3mPZGsIEnLEntOLdCjEEf+
         9IOBxJSc5ZAAMb6A/KcKSpsb8MvVDeGrD6XdpiYzihRM2JNtGHXpOXVuDAktGyAR+N
         EdhDO06xCG065PAXYX6oiIznilfb3awMPOEIGpHAHJHIgUWz02tzVUsdD0gymBmYvM
         zxuPtJkBEV1HOEUwBP0guybN+TNBiIwjwttT1jny2IJV3mco4gxbzxXy5bi36EzHIg
         KQHQYmm+WnAsA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id C14AD9B6AD;
        Fri, 20 May 2022 21:58:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1653080306;
        bh=2uvEV1LWIas/sbv9uPIfGBqzdAeGyQk1W1mzNM7QMHg=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=DpdFGO/7j73xyANGNogCZWWIHFBHSEx8TAkrvzxW3T3eryfVzt3HpF/kkw2DWbBe1
         kchvu3ngNZ5KX43gwg2lWtFoJy+UwSunbfGLd4KgMqp++a6MAmWoMbM/nQ1sY7ewYd
         PWZ70SRJMpjDZCvBAxUj8eHNF//OxChlTtjyBo9gODyufriX9HQZjBvmXnzpfnhUtb
         TWYVGBsW0qdYGVHJKyzXGUxsK3g0oCpdPVoRkSZN1NrNRPjJbG8Oo+tFW2jl9WaZDy
         SCJhHSrOgFbG5UgkMIn/WF5wekWwdsBBCy8k3EDwtyu12SxNzYPciPFICwTxN8XYmw
         UcyqquhA0zIsw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 8061B1706C8;
        Fri, 20 May 2022 21:58:26 +0100 (BST)
Message-ID: <7345e376-3573-6065-bdb2-7dbdd636cf6c@cobb.uk.net>
Date:   Fri, 20 May 2022 21:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   g.btrfs@cobb.uk.net
Subject: Re: [PATCH v15 3/7] btrfs: add send stream v2 definitions
Content-Language: en-US
To:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1649092662.git.osandov@fb.com>
 <abea9f460c7341361e58cbba8af355654eb94b5b.1649092662.git.osandov@fb.com>
 <20220518210003.GK18596@twin.jikos.cz>
 <YoVyXsuWEOX6dtXE@relinquished.localdomain> <20220519160748.GM18596@suse.cz>
 <YobFXNs0TVBV8xCc@relinquished.localdomain>
 <20220520193429.GT18596@twin.jikos.cz>
In-Reply-To: <20220520193429.GT18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2022 20:34, David Sterba wrote:
> On Thu, May 19, 2022 at 03:31:56PM -0700, Omar Sandoval wrote:
>> On Thu, May 19, 2022 at 06:07:49PM +0200, David Sterba wrote:
>>> The SETFLAGS ioctls are obsolete and I don't want to make them part of
>>> the protocol defition because the bit namespace contains flags we don't
>>> have implemented or are not releated to anything in btrfs.
>>>
>>> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/fs.h#L220
>>>
>>> It's basically just naming and specifying what exactly is the value so
>>> we should pick the most recent interface name that superseded SETFLAGS
>>> and the XFLAGS.
>>
>> This is the situation with FS_IOC_SETFLAGS, FS_IOC_FSSETXATTR, and
>> fileattr as I understand it. Please correct me if I'm wrong:
>>
>> - FS_IOC_SETFLAGS originally came from ext4 and was added to Btrfs very
>>   early on (commit 6cbff00f4632 ("Btrfs: implement
>>   FS_IOC_GETFLAGS/SETFLAGS/GETVERSION")).
>> - FS_IOC_FSSETXATTR originally came from XFS and was added to Btrfs a
>>   few years ago (in commit 025f2121488e ("btrfs: add FS_IOC_FSSETXATTR
>>   ioctl")).
>> - The two ioctls allow setting some of the same flags (e.g., IMMUTABLE,
>>   APPEND), but some are only supported by SETFLAGS (e.g., NOCOW) and
>>   some are only supported by FSSETXATTR (none of these are supported by
>>   Btrfs, however).
>> - fileattr is a recent VFS interface that is used to implement those two
>>   ioctls. It basically passes through the arguments for whichever ioctl
>>   was called and translates the equivalent flags between the two ioctls.
>>   It is not a new UAPI and doesn't have its own set of flags.
>>
>> Is there another new UAPI that I'm missing that obsoletes SETFLAGS?
> 
> That was supposed to be FSSETXATTR, new flags have appeared there, the
> reason for btrfs was to allow the FS_XFLAG_DAX bit as people are were
> working on the DAX support, and potentially other bits like
> FS_XFLAG_NOSYMLINKS or FS_XFLAG_NODEFRAG. Or new flags that we want to
> be able to set, NODATASUM for example.
> 
>> I see your point about the irrelevant flags in SETFLAGS, however. Is
>> your suggestion to have our own send protocol-specific set of flags that
>> we translate to whatever ioctl we need to make?
> 
> Yes, that's the idea, the flags are not protocol-specific but rather
> btrfs-specific, ie we want to support namely the bits that btrfs inodes
> can have.
> 

>>>> This is in line with the other commands being straightforward system
>>>> calls, but it does mean that the sending side has to deal with the
>>>> complexities of an immutable or append-only file being modified between
>>>> incremental sends (by temporarily clearing the flag), and of inherited
>>>> flags (e.g., a COW file inside of a NOCOW directory).
>>>
>>> Yeah the receiving side needs to understand the constraints of the
>>> flags, it has only the information about the final state and not the
>>> order in which the flags get applied.
>>
>> If the sender only tells the receiver what the final flags are, then
>> yes, the receiver would need to deal with, e.g., temporarily clearing
>> and resetting flags. The way I envisioned it was that the sender would
>> instead send commands for those intermediate flag operations. E.g., if
>> the incremental send requires writing some data to a file that is
>> immutable in both the source and the parent subvolume, the sender could
>> send commands to: clear the immutable flag, write the data, set the
>> immutable flag. This is a lot like the orphan renaming that you
>> mentioned.
> 
> I see, so the question is where do we want to put the logic. I'd go with
> userspace as lots of things are easier there, eg. maitaining some
> intermediate state or delayed application of bits/flags.
>
We should remember that what you are designing here is a protocol for
transmission of a snapshot. The protocol features are numbers that have
to remain unchanged across all future software updates and all
implementations of this version of the protocol. The values may or may
not co-incidentally match some constant we know today in the Linux 5.x
ABI but it may have no relation to *anything* on the receiving side.
Don't forget that some people are archiving send streams as a form of
backup with the intention of playing them back in 10 or 20 years time on
a btrfs implementation that might bear little resemblance to anything we
would recognise today (not a good idea, but people are doing it).

There is no way the sender has any idea what those future
implementations might have to do to replicate the source data - that is
up to those implementations. For example, it is very easy to imagine
that some future OS might disallow the concept of "clearing the
immutable flag". In that case, what the receiver needs to know is that
this new data represents a new immutable file, based on the contents of
previous file with some specified differences - maybe it will handle
this by turning off the immutable flag, or deleting the old file and
writing a new one, or asking the system manager to authorize it, or
using some versioning feature built into a future version of btrfs, or ...

The right question isn't to ask "what would a Linux BTRFS receiver
running the same software rev as the sender need to do", it needs to be
"what information do I need to supply that gives a future receiver, on a
completely different system, with a different I/O architecture and a
different kernel, in 20 years, the best chance to implement it".

Graham

P.S. I'm an old network guy, not a file system guy. Send/receive is a
network protocol, with the added problems that (i) there is no
negotiation or feedback channel, and (ii) the data is probably mission
critical to some people and they expect it to be usable in 10's of years
time.

>> If we want to have receive handle the intermediate states instead, then
>> I would like to postpone SETFLAGS (or whatever we call it) to send
>> protocol v3, since it'll be very tricky to get right and we can't add it
>> to the protocol without having an implementation in the receiver.
> 
> Yeah it would be tricky to generate the sequence right, while if it's on
> the receiving side we can simply ignore/report it or implement a subset
> where we know how to apply (eg. immutable) and don't need to postpone
> it.
> 
>> On the other hand, if send takes care of the intermediate states and
>> receive just has to blindly apply the flags, then we can add SETFLAGS to
>> the protocol and receive now and implement it in send later. That is
>> exactly what this patch series does.
> 
> It adds a command to the protocol but does not outline the plan how to
> use it, not counting this discussion.
> 
>> I'm fine with either of those paths forward, but I don't want to block
>> the compressed send/receive on SETFLAGS or fallocate.
> 
> I get that you care only about the encoded write, but I don't want to
> rev protocol every few releases because we did not bother to implement
> something we know is missing in the protocol. Anyway, encoded write will
> be in v2 scheduled for 5.20 and I'll implement the rest plus will have a
> look at your fallocate patches.

