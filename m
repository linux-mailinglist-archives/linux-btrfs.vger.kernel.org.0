Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB813AF329
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfIJXOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 19:14:14 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:43992 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfIJXOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 19:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nmRaVol3HwuiUVAgi3QxHVMKjf8eKbseQoBQ4uNotWw=; b=M3f+bSLglWqh2wEN0QI28r3cxF
        uXBMLtTD8+eX5+nS5/KFXSXC4PXOaytGGtg0UJbAJOTiwSOm29/ijvCgacKrRGbo8RmquDxsZZttH
        uhS4oF2ZIj0AhQnTduL8QBjQG2hD6RSiYIV472bj/pWVpAU/I3jP0khAlEkyecKsNfdydEfsajxrz
        7n47z1WqjyUQiAbusO9w0A3fRsF3lQ9sq2b0kWmnvbIw8CDGw2SvGSFsuKDD8mYKQu1FjAqZ0SuIF
        M1RBhpAjyG7WUfOTMPrp0PuB480RvQnkJ4Wi7absBFwkmATE6e0m4DJHT3KgWZw0vAm07mKgPm6jT
        BrmJQ8hA==;
Received: from [::1] (port=48296 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7pKq-0031vY-S5; Tue, 10 Sep 2019 19:14:13 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 19:14:08 -0400
Date:   Tue, 10 Sep 2019 19:14:08 -0400
Message-ID: <20190910191408.Horde.APH6UgFmn857ecvizpk_Ijb@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
 <20190909212434.Horde.S2TAotDdK47dqQU5ejS2402@server53.web-hosting.com>
 <3978da3b-bb62-4995-bc46-785446d59265@gmx.com>
In-Reply-To: <3978da3b-bb62-4995-bc46-785446d59265@gmx.com>
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

>>> So here what we could do is: (From easy to hard)
>>> - Introduce an interface to allow defrag not to touch shared extents
>>>   it shouldn't be that difficult compared to other work we are going
>>>   to do.
>>>   At least, user has their choice.
>>
>> That defrag wouldn't acomplish much. You can call it defrag, but it is
>> more like nothing happens.
>
> If one subvolume is not shared by snapshots or reflinks at all, I'd say
> that's exactly what user want.

If one subvolume is not shared by snapshots, the super-duper defrag  
would produce the same result concering that subvolume.

Therefore, it is a waste of time to consider this case separately and  
to go writing the code to cover just this case.

>>> - Introduce different levels for defrag
>>>   Allow btrfs to do some calculation and space usage policy to
>>>   determine if it's a good idea to defrag some shared extents.
>>>   E.g. my extreme case, unshare the extent would make it possible to
>>>   defrag the other subvolume to free a huge amount of space.
>>>   A compromise, let user to choose if they want to sacrifice some space.
>>
>> Meh. You can always defrag one chosen subvolume perfectly, without
>> unsharing any file extents.
>
> If the subvolume is shared by another snapshot, you always need to face
> the decision whether to unshare.
> It's unavoidable.

In my opinion, unsharing is a very bad thing to do. If the user orders  
it, then OK, but I think it that it is rarely required.

Unsharing can be done manually by just copying the data to another  
place (partition). So, if someone really wants to unshare, he can  
always easily do it.

When you unshare, it is hard to go back. Unsharing is a one-way road.  
When you unshare, you lose free space. Therefore, the defrag should  
not unshare.

In my view, the only real decision that needs to be left to the user  
is: what to defrag?

In terms of full or partial defrag:
* Everything
     - rarely; waste of time and resources, and it wears out SSDs
     - perhaps this shouldn't be allowed at all
* 2% od most fragmented files (2% ot total space used, by size in bytes)
     - good idea for daily or weekly defrag
     - good default
* Let the user choose between 0.01% and 10%  (by size in bytes)
     - the best

Options by scope:
   - One file (when necessary)
   - One subvolume (when necessary)
   - A list of subvolumes (with priority from first to last; the first  
one on the list would be defragmented best)
   - All subvolumes
   - All subvolumes, with one exclusion list, and one priority list
   - option to include or exclude RO subvolumes - as you said, this is  
probably the hardest and implementation should be postponed

Therefore, making a super-duper defrag which can defrag one file  
(without unsharing!!!) is a good starting point, instead of wasing  
time on your proposal "Introduce different levels for defrag".

>> So, since it can be done perfectly without unsharing, why unshare at all?
>
> No, you can't.
>
> Go check my initial "red-herring" case.

I might check it, but I think that you can't be right. You are  
thinking too low-level. If you can split extents and fuse extents and  
create new extents that are shared by multiple files, than what you  
are saying is simply not possible. The operations I listed are  
sufficient to produce a perfect full defrag. Always.



