Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F74AF302
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfIJWl2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 18:41:28 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:32945 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfIJWl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 18:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NYb376gXoQ3HF0FhPfkcBe3cqt9vR91OvgFFreY+rCw=; b=4UF4BerqcszaTTB8V4V1+lX6/b
        eu1M4Lx8T16bN9qgTNuzqkVSzucoMdxr4E4/Wt15w0tBGd/vHttZHFwvJR7hkj/qXfXVlw+orYX++
        oAIt/Wrz8KVPi7F4PZ3eA21RWkDMkaNLiUcVE8Jq+zbghJt8zlWEYCGA/hoWqtI9QILDwYtitBowJ
        Ki9cVEIUyv8CeB5b24JIiOCxXwDOJFlzOkZPox2Fc8Y3J2AxqUOTQdH9ZvQNuzpNgpQCI3xxaSNXT
        VJwrVCTjF6MsEuDWhefK+gjctSVdSZ49M925qeB5iYusMDv4ePgGvEKRJqtZGALlj374/aNAxjka8
        7yhxDU6g==;
Received: from [::1] (port=37948 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7op9-002klf-07; Tue, 10 Sep 2019 18:41:27 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 18:41:22 -0400
Date:   Tue, 10 Sep 2019 18:41:22 -0400
Message-ID: <20190910184122.Horde.3fBVb1d5mYyRnhiwZGiCS_M@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <083a7b76-3c30-f311-1e23-606050cfc412@gmx.com>
 <20190909131108.Horde.64FzJYflQ6j0CbjYFLqBEz0@server53.web-hosting.com>
 <610e9567-2f17-c7c3-01aa-0e1215be44d0@gmail.com>
In-Reply-To: <610e9567-2f17-c7c3-01aa-0e1215be44d0@gmail.com>
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


Quoting Andrei Borzenkov <arvidjaar@gmail.com>:

> 09.09.2019 20:11, webmaster@zedlx.com пишет:
> ...
>>>
>>> Forgot to mention this part.
>>>
>>> If your primary objective is to migrate your data to another device
>>> online (mounted, without unmount any of the fs).
>>
>> This is not the primary objective. The primary objective is to produce a
>> full, online, easy-to-use, robust backup. But let's say we need to do
>> migration...
>>>
>>> Then I could say, you can still add a new device, then remove the old
>>> device to do that.
>>
>> If the source filesystem already uses RAID1, then, yes, you could do it,
>
> You could do it with any profile.
>
>> but it would be too slow, it would need a lot of user intervention, so
>> many commands typed, so many ways to do it wrong, to make a mistake.
>>
>
> It requires exactly two commands - one to add new device, another to
> remove old device.
>

Yes, sorry I got a bit confused.

The point is that migration is not the objective. The objective could,  
possibly, be restated as: make another copy of the filesystem.  
Migration is something different.

>> Too cumbersome. Too wastefull of time and resources.
>>
>
> Do you mean your imaginary full backup will not read full filesystem?
> Otherwise how can it take less time and resources?

My imaginary full backup needs to read and write the entire filesystem.
It can't take less than that.



