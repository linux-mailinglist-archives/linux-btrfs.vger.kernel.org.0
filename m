Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D2AAF382
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 01:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfIJX6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 19:58:40 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:44563 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfIJX6j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 19:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:Cc:To:From:Message-ID:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q6M1n7HFWRx0/qGDhxuuFSSG470IvII6OFMBHac086o=; b=lN49EeRndW82nc/1/Oj7e8t7K0
        Rt0TNl7qct7p8BnKwV9kW+J8otKJvxifXbkqjnRMBuVnN0YXecfrcl3+ELR/xLxAkuEwlhp4Rl0Db
        eyZOPAPm62hwuyw9Nhuz4m/hqVAUHEH2kMVea8vncEpoJuVBvNOAWWoaE96kt6j2PaDDAO67VW5Zb
        ZyfoxoQkbnLf7QjKLZJECcRUqG6YsA19K2L0c9QZ6rbhGIslEOFx42E0tnGvjbPWKVB2m2/ZNknuy
        6titSbPrkp0HqE+DaQbdj9oxokjnKZ4cdplQJo4hGdsC6Oel/MGZbGtLi1JljdXZjGg4x7UUfbACr
        u327vBuQ==;
Received: from [::1] (port=35540 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7q1q-003OLH-6b; Tue, 10 Sep 2019 19:58:38 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 19:58:34 -0400
Date:   Tue, 10 Sep 2019 19:58:34 -0400
Message-ID: <20190910195834.Horde.nY4PVqoyBbYA17I11YfHH5a@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
In-Reply-To: <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
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


Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:

>> Also, I don't quite understand what the poster means by "the  
>> snapshot duplication of defrag only affects the fragmented  
>> portions". Possibly it means approximately: if a file wasn't  
>> modified in the current (latest) subvolume, it doesn't need to be  
>> unshared. But, that would still unshare all the log files, for  
>> example, even all files that have been appended, etc... that's  
>> quite bad. Even if just one byte was appended to a log file, then  
>> defrag will unshare the entire file (I suppose).
>>
> What it means is that defrag will only ever touch a file if that  
> file has extents that require defragmentation, and will then only  
> touch extents that are smaller than the target extent size (32M by  
> default, configurable at run-time with the `-t` option for the  
> defrag command) and possibly those directly adjacent to such extents  
> (because it might merge the small extents into larger neighbors,  
> which will in turn rewrite the larger extent too).

Umm... it seems to me that it's quite a poor defrag you got there.

> * There's almost no net benefit to not defragmenting when dealing  
> with very large files that mostly see internal rewrites (VM disk  
> images, large databases, etc) because every internal rewrite will  
> implicitly unshare extents anyway.

Ok, so if you have a database, and then you snapshot its subvolume,  
you might be in trouble because of all the in-place writes that  
databases do, right?

It would almost be better if you could, manually, order the database  
file to be unshared and defragmented. So, that would be the use-case  
for defrag-unsharing. Interesting. Ok, I would agree with that. So,  
there needs to be the operation called defrag-unshare, but that has  
nothing to do with the real defrag.

I mean, this defrag-unsharing is just a glorified copy operation, but  
there are a few twists, because it must be consistent, as opposed to  
online copy, which would fail the consistency criteria.

But, you and other developers here seem to be confusing this  
defrag-unshare with the real defrag. I bet you haven't even considered  
what it means to "defrag without usharing" in terms of: what the final  
result of such defrag should be, when it is done perfectly.



