Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FEBAE177
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 01:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfIIXZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 19:25:16 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:35527 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730138AbfIIXZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 19:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=j0bhePdfD0/vnNvoUnIU2xgJjnNfPtiyrZLTSAe85ks=; b=tU+rYiBF13RKe2W2jgFbEGdRYF
        CVwH06oYVuXWgVFVo91gP3CCfG3UjXSjk676uAzOO6RUl03oJZLFBepJzP3CIXzOXRTQObYQYXFRX
        cHfDs+P6sjVG9ERf3zZw1DRwMqyukvj1RCTDJ7yQJzAFlwJHq3Hdi9vhs/+fxnXudLKV/HnVvgU7x
        vuOda1gZSI4zbDNV0PJMghXWAIQIeCo9ZVvbYr5lQk0U76h97eSK/nWWZs2qCiJRhFRURzayrK8gL
        4Qy8qW3tbfGGlCatn7MisOW/SrXmxFhrNRBvyhRHfa7BErtbm4cZZM0vPHy8xHFFjygzPMH/2Xhqc
        r9qiAwyQ==;
Received: from [::1] (port=56658 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7T1y-0003Qq-Rw; Mon, 09 Sep 2019 19:25:15 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 19:25:10 -0400
Date:   Mon, 09 Sep 2019 19:25:10 -0400
Message-ID: <20190909192510.Horde.TcPhEiaioP0455GTkXqxE4Q@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
In-Reply-To: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
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


Quoting Graham Cobb <g.btrfs@cobb.uk.net>:

> On 09/09/2019 13:18, Qu Wenruo wrote:
>>
>>
>> On 2019/9/9 下午7:25, zedlryqc@server53.web-hosting.com wrote:
>>> What I am complaining about is that at one point in time, after issuing
>>> the command:
>>>     btrfs balance start -dconvert=single -mconvert=single
>>> and before issuing the 'btrfs delete', the system could be in a too
>>> fragile state, with extents unnecesarily spread out over two drives,
>>> which is both a completely unnecessary operation, and it also seems to
>>> me that it could be dangerous in some situations involving potentially
>>> malfunctioning drives.
>>
>> In that case, you just need to replace that malfunctioning device other
>> than fall back to SINGLE.
>
> Actually, this case is the (only) one of the three that I think would be
> very useful (backup is better handled by having a choice of userspace
> tools to choose from - I use btrbk - and does anyone really care about
> defrag any more?).
>
> I did, recently, have a case where I had started to move my main data
> disk to a raid1 setup but my new disk started reporting errors. I didn't
> have a spare disk (and didn't have a spare SCSI slot for another disk
> anyway). So, I wanted to stop using the new disk and revert to my former
> (m=dup, d=single) setup as quickly as possible.
>
> I spent time trying to find a way to do that balance without risking the
> single copy of some of the data being stored on the failing disk between
> starting the balance and completing the remove. That has two problems:
> obviously having the single copy on the failing disk is bad news but,
> also, it increases the time taken for the subsequent remove which has to
> copy that data back to the remaining disk (where there used to be a
> perfectly good copy which was subsequently thrown away during the balance).
>
> In the end, I took the risk and the time of the two steps. In my case, I
> had good backups, and actually most of my data was still in a single
> profile on the old disk (because the errors starting happening before I
> had done the balance to change the profile of all the old data from
> single to raid1).
>
> But a balance -dconvert=single-but-force-it-to-go-on-disk-1 would have
> been useful. (Actually a "btrfs device mark-for-removal" command would
> be better - allow a failing device to be retained for a while, and used
> to provide data, but ignore it when looking to store data).
>
> Graham

Thank you. I like your very nice example/story/use case, and I also  
like the solution: btrfs device mark-for-removal.

Of course, you didn't have the spare drive. I guess most users don't  
have it. I don't. They buy it when one of the drives in RAID1 fails.

I was thinking of a more general solution, so I proposed RAID level  
change feature, but this suggestion of yours covers most of the use  
cases. Maybe the case of RAID10 level downgrade should also be  
considered, in case of circumstances similar to what you described.



