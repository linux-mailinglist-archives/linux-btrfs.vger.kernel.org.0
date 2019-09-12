Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060E8B070D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfILDFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:05:48 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:48294 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729001AbfILDFr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:Cc:To:From:Message-ID:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j38OAwCEDwMA7fbS/4cgAPMcRX271WPWc5MGmF06dAI=; b=aAFBOTs2yUOV0OpJ1KT+QiGu7s
        Uu26xtjt0nSrzfZk9xkwAMYjNB81o8eLfQqMmc5tbhDoIGiAqRYEZ8SeRY5vffUtf9x1mWzygBzxG
        fMoT7BxfPodO+LaYWXJn2at2/H17nFGgPxgkk5H8mYhEkA6juWrxgvh+rDGxFrPFfVful6VosXHj5
        Q4CX/ez01aK40t6xVc+DFiUVhQ0pnJDQpSsvJy7lcST8ERWx5UYZv+GGSTCAPtolxrmTq453hCcRM
        t0cFWjp6nQi6GNS+v84/oBO2BAgCuLV9TtYmqSWV+ApTkU1VlwpBGVrjs5H6OEJWBiLR9RpQuSolU
        AzP/AW/A==;
Received: from [::1] (port=58824 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i8FQU-0035CL-4S; Wed, 11 Sep 2019 23:05:46 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Wed, 11 Sep 2019 23:05:42 -0400
Date:   Wed, 11 Sep 2019 23:05:42 -0400
Message-ID: <20190911230542.Horde.UywNUEBF6L2ExMalgJ0dDTG@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
In-Reply-To: <dafd460c-91fc-31c0-ce1f-e020278987e5@georgianit.com>
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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


Quoting Remi Gauvin <remi@georgianit.com>:

> On 2019-09-11 7:21 p.m., webmaster@zedlx.com wrote:
>
>> For example, lets examine the typical home user. If he is using btrfs,
>> it means he probably wants snapshots of his data. And, after a few
>> snapshots, his data is fragmented, and the current defrag can't help
>> because it does a terrible job in this particualr case.
>>
>
> I shouldn't be replying to your provocative posts, but this is just
> nonsense.

I really hope that I'm not such a bad person as that sentence is suggesting.
About the provocative posts, I don't know of any other way to get my  
thoughts across.
If I offended people, I appologize, but I cannot change the way I communicate.

Certainly, I like the btrfs filesystem and the features it offers, and  
I'll continue using it, and no matter what you think of me I want to  
say thanks to you guys who are making it all work.

>  Not to say that Defragmentation can't be better, smarter,, it happens
> to work very well for typical use.

My thought is that the only reason why it appears that it works is  
that a typical home user rarely needs defragmentation. He runs the  
"btrfs fi defrag", virtually nothing happens (a few log files get  
defragged, if they were shared than they are unshared), prints out  
"Done", the user is happy. Placebo effect.

> This sounds like you're implying that snapshots fragment data... can you
> explain that?  as far as I know, snapshotting has nothing to do with
> fragmentation of data.  All data is COW, and all files that are subject
> to random read write will be fragmented, with or without snapshots.

Close, but essentially: yes. I'm implying that snapshots induce future  
fragmentation. The mere act of snapshoting won't create fragments  
immediately, but if there are any future writes to previously  
snapshoted files, those writes are likely to cause fragmentation. I  
think that this is not hard to figure out, but if you wish, I can  
elaborate further.

The real question is: does it really matter? Looking at the typical  
home user, most of his files rarely change, they are rarely written  
to. More likely, most new writes will go to new files. So, maybe the  
"home user" is not the best study-case for defragmentation. He has to  
be at least some kind of power-user, or content-creator to experience  
any significant fragmentation.

> And running defrag on your system regularly works just fine.  There's a
> little overhead of space if you are taking regular snapshots, (say
> hourly snapshots with snapper.)  If you have more control/liberty when
> you take your snapshots, ideally, you would defrag before taking the
> snaptshop/reflink copy.  Again, this only matters to files that are
> subject to fragmentation in the first place.

Btrfs defrag works just fine until you get some serious fragmentation.  
At that point, if you happen to have some snapshots, you better delete  
them before running defrag. Because, if you do run defrag on  
snapshoted and heavily fragmented filesystem, you are going to run out  
of disk space really fast.

> I suspect if you actually tried using the btrfs defrag, you would find
> you are making a mountain of a molehill.. There are lots of far more
> important problems to solve.

About importance, well, maybe you are right there, maybe not. Somehow  
I guess that after so many years in development and a stable feature  
set, most remaining problems are bugs and trivialities. So you are  
fixing them, one by one, many of those are urgent. I see you are  
working on deduplication, that's a hell of a work which actually won't  
end up well if it is not supplemented by a good defrag.

Didn't someone say, earlier in this discussion, that the defrag is  
important for btrfs. I would guess that it is. On many OSes defrag is  
run automatically. All older filesystems have a pretty good defrag.

What I would say is that btrfs can have a much better defrag than it  
has now. If defrag is deemed important, thay why are improvements to  
defrag unimportant?


