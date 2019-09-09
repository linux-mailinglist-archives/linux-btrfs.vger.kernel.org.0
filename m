Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB2ADDD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfIIRLN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 13:11:13 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:55363 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbfIIRLN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 13:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fqQPcJ1LDJkMeAwhFwP+7abgWQ9XdVfN9t5nSXMjrUg=; b=5Fgt0VJG5JWoqVBdTsxjm1G19I
        bbZKI2pS5D6jRPM7Du3aP0BOQBCnym9d0VyaKMtuRIokVy49ZYnOcVGu1KgUTgwpMO5ewJd8dpfkK
        FVjLYZgM7z5jjK4xFW4OsUTwOLt7UpiSX+MpQGk09XYxVyyJjXtHDvDM7bAxKQnbhduy8iUvUI3rJ
        gZDaARWwWHiPa3vglL90IaiCSZAEkFhtYcXnO24HLzW4vgulmxWUQcyLq21p7C05s8HpR+nPdF6ss
        q+ExT0T7aahnQ5/HQmW+0zBas1tecCEB8eJp3E4a98Pa8HKQcttwtjhqJTWBPRWOUtsgESQ7dM4+1
        BB0+5ipg==;
Received: from [::1] (port=52040 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7NC0-001bR7-Gt
        for linux-btrfs@vger.kernel.org; Mon, 09 Sep 2019 13:11:12 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 13:11:08 -0400
Date:   Mon, 09 Sep 2019 13:11:08 -0400
Message-ID: <20190909131108.Horde.64FzJYflQ6j0CbjYFLqBEz0@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     linux-btrfs@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <083a7b76-3c30-f311-1e23-606050cfc412@gmx.com>
In-Reply-To: <083a7b76-3c30-f311-1e23-606050cfc412@gmx.com>
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:

> On 2019/9/9 下午8:18, Qu Wenruo wrote:
>>
>>
>> On 2019/9/9 下午7:25, zedlryqc@server53.web-hosting.com wrote:
>>>
>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>> 1) Full online backup (or copy, whatever you want to call it)
>>>>> btrfs backup <filesystem name> <partition name> [-f]
>>>>> - backups a btrfs filesystem given by <filesystem name> to a partition
>>>>> <partition name> (with all subvolumes).
>>>>
>>>> Why not just btrfs send?
>>>>
>>>> Or you want to keep the whole subvolume structures/layout?
>>>
>>> Yes, I want to keep the whole subvolume structures/layout. I want to
>>> keep everything. Usually, when I want to backup a partition, I want to
>>> keep everything, and I suppose most other people have a similar idea.
>>>
>>>> I'd say current send/receive is more flex.
>>>
>>> Um, 'flexibility' has nothing to do with it. Send/receive is a
>>> completely different use case.
>>> So, each one has some benefits and some drawbacks, but 'send/receive'
>>> cannot replace 'full online backup'
>>>
>>> Here is where send/receive is lacking:
>>>     - too complicated to do if many subvolumes are involved
>>>     - may require recursive subvolume enumeration in order to emulate
>>> 'full online backup'
>>>     - may require extra storage space
>>>     - is not mountable, not easy to browse the backup contents
>>>     - not easy to recover just a few selected files from backup
>>> There's probably more things where send/receive is lacking, but I think
>>> I have given sufficient number of important differences which show that
>>> send/receive cannot successfully replace the functionality of 'full
>>> online backup'.
>
> Forgot to mention this part.
>
> If your primary objective is to migrate your data to another device
> online (mounted, without unmount any of the fs).

This is not the primary objective. The primary objective is to produce  
a full, online, easy-to-use, robust backup. But let's say we need to  
do migration...
>
> Then I could say, you can still add a new device, then remove the old
> device to do that.

If the source filesystem already uses RAID1, then, yes, you could do  
it, but it would be too slow, it would need a lot of user  
intervention, so many commands typed, so many ways to do it wrong, to  
make a mistake.

Too cumbersome. Too wastefull of time and resources.

> That would be even more efficient than LVM (not thin provisioned one),
> as we only move used space.

In fact, you can do this kind of full-online-backup with the help of  
mdadm RAID, or some other RAID solution. It can already be done, no  
need to add 'btrfs backup'.

But, again, to cumbersome, too inflexible, too many problems, and, the  
user would have to setup a downgraded mdadm RAID in front and run with  
a degraded mdadm RAID all the time (since btrfs RAID would be actually  
protecting the data).

> If your objective is to create a full copy as backup, then I'd say my
> new patchset of btrfs-image data dump may be your best choice.

It should be mountable. It should be performed online. Never heard of  
btrfs-image, i need the docs to see whether this btrfs-image is good  
enough.

> The only down side is, you need to at least mount the source fs to RO mode.

No. That's not really an online backup. Not good enough.

> The true on-line backup is not that easy, especially any write can screw
> up your backup process, so it must be done unmounted.

Nope, I disagree.

First, there is the RAID1-alike solution, which is easy to perform  
(just send all new writes to both source and destination). It's the  
same thing that mdadm RAID1 would do (like I mentioned a few  
paragraphs above).
But, this solution may have a performance concern, when the  
destination drive is too slow.

Fortunately, with btrfs, an online backup is easier tha usual. To  
produce a frozen snapshot of the entire filesystem, just create a  
read-only snapshot of every subvolume (this is not 100% consistent, I  
know, but it is good enough).

But I'm just repeating myself, I already wrote this in the first email.

So, in conclusion I disagree that true on-line backup is not easy.

> Even btrfs send handles this by forcing the source subvolume to be RO,
> so I can't find an easy solution to address that.

This is a digression, but I would say that you first make a temporary  
RO snapshot of the source subvolume, then use 'btrfs send' on the  
temporary snapshot, then delete the temporary snapshot.

Oh, my.


