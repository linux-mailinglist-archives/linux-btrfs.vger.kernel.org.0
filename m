Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AADADF6A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 21:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfIIT0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 15:26:31 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:47356 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729060AbfIIT0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 15:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:Cc:To:From:Message-ID:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4SG25svB/9K9U9j1Nl9LLxjUycJiVHcnpOv7QUvrGzw=; b=G36eG5t+SQRcESeqTG3yFdUtIP
        ku4/mkPBAITR8xW+9fp31AnjQ4PDev6zXEHaxOVknmBQTC4+KA4ty6gjPWP25ISNZTyvutjXKr8pP
        9w5C2wtwwS1faZPTXmkiRe5CsC/7tmIwHldm2ce3elpCKuOT0SBPMSGH/CVyHhNcKBx1HJqsUoTnh
        LOo18p8KXFkc1aXnJMOKPQUjNt8fIrQi/kxr9tQXc767znc3qsM+LiKyBLwN3j6/wPwi/pzKw0PnZ
        rGbB6kv9AP3DCfEP7b9W5bZLf1hsK0UsbXgDXB54Dj7IERU7H97zXRA9GvVoVbbV45dZ6OIZOO8cx
        xggS53bQ==;
Received: from [::1] (port=49176 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7PIv-002hTu-QK
        for linux-btrfs@vger.kernel.org; Mon, 09 Sep 2019 15:26:30 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 15:26:25 -0400
Date:   Mon, 09 Sep 2019 15:26:25 -0400
Message-ID: <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     linux-btrfs@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
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

This post is a reply to Remi Gauvin's post, but the email got lost so  
I can't reply to him directly.

Remi Gauvin wrote on 2019-09-09 17:24 :
>
> On 2019-09-09 11:29 a.m., Graham Cobb wrote:
>
>>  and does anyone really care about
>> defrag any more?).
>>
>
>
> Err, yes, yes absolutely.
>
> I don't have any issues with the current btrfs defrag implementions, but
> it's *vital* for btrfs. (which works just as the OP requested, as far as
> I can tell, recursively for a subvolume)
>
> Just booting Windows on a BTRFS virtual image, for example, will create
> almost 20,000 file fragments.  Even on SSD's, you get into problems
> trying to work with files that are over 200,000 fragments.
>
> Another huge problem is rsync --inplace.  which is perfect backup
> solution to take advantage of BTRFS snapshots, but fragments larges
> files into tiny pieces (and subsequently creates files that are very
> slow to read.).. for some reason, autodefrag doesn't catch that one either.
>
> But the wiki could do a beter job of trying to explain that the snapshot
> duplication of defrag only affects the fragmented portions.  As I
> understand, it's really only a problem when using defrag to change
> compression.


Ok, a few things.

First, my defrag suggestion doesn't EVER unshare extents. The defrag  
should never unshare, not even a single extent. Why? Because it  
violates the expectation that defrag would not decrease free space.

Defrag may break up extents. Defrag may fuse extents. But it shouln't  
ever unshare extents.

Therefore, I doubt that the current defrag does "just as the OP  
requested". Nonsense. The current implementation does the unsharing  
all the time.

Second, I never used btrfs defrag in my life, despite mananging at  
least 10 btrfs filesystems. I can't. Because, all my btrfs volumes  
have lot of subvolumes, so I'm afraid that defrag will unshare much  
more than I can tolerate. In my subvolumes, over 90% of data is  
shared. If all subvolumes were to be unshared, the disk usage would  
likely increase tenfold, and that I cannot afford.

I agree that btrfs defrag is vital. But currently, it's unusable for  
many use cases.

Also, I don't quite understand what the poster means by "the snapshot  
duplication of defrag only affects the fragmented portions". Possibly  
it means approximately: if a file wasn't modified in the current  
(latest) subvolume, it doesn't need to be unshared. But, that would  
still unshare all the log files, for example, even all files that have  
been appended, etc... that's quite bad. Even if just one byte was  
appended to a log file, then defrag will unshare the entire file (I  
suppose).

