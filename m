Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADEB170E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 03:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIMBdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 21:33:13 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:55330 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfIMBdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 21:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GxN3fn7cwoSan/9jB3Ngiu5uF4jkQLtazh5MHYqk6SI=; b=PXVj5smM1HxQRMrkARDvDI6m5h
        koF5ykPh8N4Uf8ZFelzqsvnwVZUfcKxTnoiqaol+C2FIrvSQO3N4fCgOnHFVRaFm9EfGn2jk5tEQ5
        xUpNeFtMLEtWqUo06FXXT+jknX6lVF68VzvAsfgcDVjhKA5j1VFYKcoPnA9B5hLnKa+3FdmJWa0NA
        AG04WAImxm1L4ovm42bP9wQ2gs1XqqAWkrCFS22r84nd2QYrwSKppHJP9mQsNMIhWP6rHVYdcbyj0
        wnfjbCHo/k3aVcPvInPDPax6kX2+jlz50tW/lwWKPrsSHZew2uCXugdu5HTR7Ptr8mdHIsHST7nXW
        +vHhwXgw==;
Received: from [::1] (port=50646 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8aSQ-000rSi-Mu; Thu, 12 Sep 2019 21:33:11 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Thu, 12 Sep 2019 21:33:06 -0400
Date:   Thu, 12 Sep 2019 21:33:06 -0400
Message-ID: <20190912213306.Horde.KegQXAvmTiibI7O00A40M5o@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911160101.Horde.mYR8sgLb1dgpIs3fD4D5Cfy@server53.web-hosting.com>
 <20190911214211.GC22121@hungrycats.org>
In-Reply-To: <20190911214211.GC22121@hungrycats.org>
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
X-Authenticated-Sender: server53.web-hosting.com: general-zed@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:

> On Wed, Sep 11, 2019 at 04:01:01PM -0400, webmaster@zedlx.com wrote:
>>
>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>

>> > Not necessarily. Even ignoring the case of data deduplication (which
>> > needs to be considered if you care at all about enterprise usage, and is
>> > part of the whole point of using a CoW filesystem), there are existing
>> > applications that actively use reflinks, either directly or indirectly
>> > (via things like the `copy_file_range` system call), and the number of
>> > such applications is growing.
>>
>> The same argument goes here: If data-deduplication was performed, then the
>> user has specifically requested it.
>> Therefore, since it was user's will, the defrag has to honor it, and so the
>> defrag must not unshare deduplicated extents because the user wants them
>> shared. This might prevent a perfect defrag, but that is exactly what the
>> user has requested, either directly or indirectly, by some policy he has
>> choosen.

>> You can't both perfectly defrag and honor deduplication. Therefore, the
>> defrag has to do the best possible thing while still honoring user's will.
>> <<<!!! So, the fact that the deduplication was performed is actually the
>> reason FOR not unsharing, not against it, as you made it look in that
>> paragraph. !!!>>>
>
> IMHO the current kernel 'defrag' API shouldn't be used any more.  We need
> a tool that handles dedupe and defrag at the same time, for precisely
> this reason:  currently the two operations have no knowledge of each
> other and duplicate or reverse each others work.  You don't need to defrag
> an extent if you can find a duplicate, and you don't want to use fragmented
> extents as dedupe sources.

Yes! The current defrag that you have is a bad counterpart for deduplication.

To preserve deduplication, you need the defrag that I suggested: the  
defrah which never unshares file data.

>> If the system unshares automatically after deduplication, then the user will
>> need to run deduplication again. Ridiculous!
>>
>> > > When a user creates a reflink to a file in the same subvolume, he is
>> > > willingly denying himself the assurance of a perfect defrag.
>> > > Because, as your example proves, if there are a few writes to BOTH
>> > > files, it gets impossible to defrag perfectly. So, if the user
>> > > creates such reflinks, it's his own whish and his own fault.
>>
>> > The same argument can be made about snapshots.  It's an invalid argument
>> > in both cases though because it's not always the user who's creating the
>> > reflinks or snapshots.
>>
>> Um, I don't agree.
>>
>> 1) Actually, it is always the user who is creating reflinks, and snapshots,
>> too. Ultimately, it's always the user who does absolutely everything,
>> because a computer is supposed to be under his full control. But, in the
>> case of reflink-copies, this is even more true
>> because reflinks are not an essential feature for normal OS operation, at
>> least as far as today's OSes go. Every OS has to copy files around. Every OS
>> requires the copy operation. No current OS requires the reflinked-copy
>> operation in order to function.
>
> If we don't do reflinks all day, every day, our disks fill up in a matter
> of hours...

The defrag which I am proposing will honor all your reflinks and won't  
unshare them ever withut user's specific request.

At the same time, it can still defrag this reflinked data, not  
perfectly, but almost as good as a perfect defrag.
So you can enjoy both your reflinks and have a reasonably  
defragmented, fast disk IO.

You can have both. It can be done!



