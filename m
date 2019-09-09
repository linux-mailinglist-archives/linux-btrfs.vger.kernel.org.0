Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B669AAD7D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 13:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391011AbfIILZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 07:25:24 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:37124 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730361AbfIILZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 07:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:To:
        From:Message-ID:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rEVVnlasduRIXZnzXW81KLLY+HurRycSYCACsfnh99w=; b=JgnrH+6ZpBhFdhQfh/b/JfQwEN
        mmD6nsRm3EZHV3MEcs6QRUCboo6cfHZdadHNa2NashXgu4cesMXK8OY8S6+W/8KQWHlaqpoV/wLJR
        9HtbUyEhjlPaEnTpQ2I8IrN6e9a5LKUiRReTSzGV2jUwdfQfl2TPh5IPM0vzt/Iq/F2epuXHhOv3s
        r78P447lxy02KJjpfj0fYkoTMLRr//d7x//Qm3Ugki+1wqtXiBT6jKYfOHburiR1lnOOGKNr2rhzK
        NcU1RPDlluOn1j//J8O5smss+jVirxDWt2efxNvXNDyhymu1+3+3l6wcIYW7144EOtiGEiaojuwaU
        6Xcm/bRw==;
Received: from [::1] (port=48790 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <zedlryqc@server53.web-hosting.com>)
        id 1i7HnK-003AUu-SH
        for linux-btrfs@vger.kernel.org; Mon, 09 Sep 2019 07:25:23 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 07:25:18 -0400
Date:   Mon, 09 Sep 2019 07:25:18 -0400
Message-ID: <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
From:   zedlryqc@server53.web-hosting.com
To:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
In-Reply-To: <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - server53.web-hosting.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/primary_hostname/system user
X-Authenticated-Sender: server53.web-hosting.com: zedlryqc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, actual sender is the system user
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>> 1) Full online backup (or copy, whatever you want to call it)
>> btrfs backup <filesystem name> <partition name> [-f]
>> - backups a btrfs filesystem given by <filesystem name> to a partition
>> <partition name> (with all subvolumes).
>
> Why not just btrfs send?
>
> Or you want to keep the whole subvolume structures/layout?

Yes, I want to keep the whole subvolume structures/layout. I want to  
keep everything. Usually, when I want to backup a partition, I want to  
keep everything, and I suppose most other people have a similar idea.

> I'd say current send/receive is more flex.

Um, 'flexibility' has nothing to do with it. Send/receive is a  
completely different use case.
So, each one has some benefits and some drawbacks, but 'send/receive'  
cannot replace 'full online backup'

Here is where send/receive is lacking:
	- too complicated to do if many subvolumes are involved
	- may require recursive subvolume enumeration in order to emulate  
'full online backup'
	- may require extra storage space
	- is not mountable, not easy to browse the backup contents
	- not easy to recover just a few selected files from backup
There's probably more things where send/receive is lacking, but I  
think I have given sufficient number of important differences which  
show that send/receive cannot successfully replace the functionality  
of 'full online backup'.

> And you also needs to understand btrfs also integrates volume
> management, thus it's not just <partition name>, you also needs RAID
> level and things like that.

This is a minor point. So, please, let's not get into too many  
irrelevant details here.

There can be a sensible default to 'single data, DUP metadata', and a  
way for a user to override this default, but that feature is  
not-so-important. If the user wants to change the RAID level, he can  
easily do it later by mounting the backup.

>
> All can be done already by send/receive, although at subvolume level.

Yeah, maybe I should manually type it all for all subvolumes, one by  
one. Also must be carefull to do it in the correct order if I want it  
not to consume extra space.
And the backup is not mountable.

This proposal (workaround) of yours appears to me as too complicated,  
too error prone,
missing important features.

But, I just thought, you can actually emulate 'full online backup'  
with this send/receive. Here is how.
You do a script which does the following:
	- makes a temporary snapshot of every subvolume
	- use 'btrfs send' to send all the temporary snapshots, on-the-fly  
(maybe via pipe), in the correct order, to a proces running a 'brtfs  
receive', which should then immediately write it all to the  
destination partition. All the buffers can stay in-memory.
	- when all the snapshots are received and written to destination, fix  
subvol IDs
	- delete temporary snapshots from source
Of course, this script should then be a part of standard btrfs tools.

> Please check if send/receive is suitable for your use case.

No. Absolutely not.


>> 2) Sensible defrag
>> The defrag is currently a joke.

>> How to do it:
>> - The extents must not be unshared, but just shuffled a bit. Unsharing
>> the extents is, in most situations, not tolerable.

> I definitely see cases unsharing extents makes sense, so at least we
> should let user to determine what they want.

Maybe there are such cases, but I would say that a vast majority of  
users (99,99%) in a vast majority of cases (99,99%) don't want the  
defrag operation to reduce free disk space.

> What's wrong with current file based defrag?
> If you want to defrag a subvolume, just iterate through all files.

I repeat: The defrag should not decrease free space. That's the  
'normal' expectation.

>> - I think it would be wrong to use a general deduplication algorithm for
>> this. Instead, the information about the shared extents should be
>> analyzed given the starting state of the filesystem, and than the
>> algorithm should produce an optimal solution based on the currently
>> shared extents.
>
> Please be more specific, like giving an example for it.

Let's say that there is a file FFF with extents e11, e12, e13, e22,  
e23, e33, e34
- in subvolA the file FFF consists of e11, e12, e13
- in subvolB the file FFF consists of e11, e22, e23
- in subvolC the file FFF consists of e11, e22, e33, e34

After defrag, where 'selected subvolume' is subvolC, the extents are  
ordered on disk as follows:

e11,e22,e33,e34 - e23 - e12,e13

In the list above, the comma denotes neighbouring extents, the dash  
indicates that there can be a possible gap.
As you can see in the list, the file FFF is fully defragmented in  
subvolC, since its extents are occupying neighbouring disk sectors.


>> 3) Downgrade to 'single' or 'DUP' (also, general easy way to switch
>> between RAID levels)
>>  Currently, as much as I gather, user has to do a "btrfs balance start
>> -dconvert=single -mconvert=single
>> ", than delete a drive, which is a bit ridiculous sequence of operations.

> That's a shortcut for chunk profile change.
> My first idea of this is, it could cause more problem than benefit.
> (It only benefits profile downgrade, thus only makes sense for
> RAID1->SINGLE, DUP->SINGLE, and RAID10->RAID0, nothing else)

Those listed cases are exactly the ones I judge to be most important.  
Three important cases.

> I still prefer the safer allocate-new-chunk way to convert chunks, even
> at a cost of extra IO.

I don't mind whether it allocates new chunks or not. It is better, in  
my opinion, if new chunks are not allocated, but both ways are  
essentially OK.

What I am complaining about is that at one point in time, after  
issuing the command:
	btrfs balance start -dconvert=single -mconvert=single
and before issuing the 'btrfs delete', the system could be in a too  
fragile state, with extents unnecesarily spread out over two drives,  
which is both a completely unnecessary operation, and it also seems to  
me that it could be dangerous in some situations involving potentially  
malfunctioning drives.

Please reconsider.


