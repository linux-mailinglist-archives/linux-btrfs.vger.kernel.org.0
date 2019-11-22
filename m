Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1508D1073D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKVOHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 09:07:47 -0500
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:55100 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfKVOHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 09:07:46 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id 7F16E14067E
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Nov 2019 07:07:45 -0700 (MST)
Received: from box790.bluehost.com ([66.147.244.90])
        by cmsmtp with ESMTP
        id Y9b7iAqM2Xy4mY9b7i1dWr; Fri, 22 Nov 2019 07:07:45 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=V+9TL9vi c=1 sm=1 tr=0
 a=9zS9oP4XFFrDhkEDEs+BAQ==:117 a=9zS9oP4XFFrDhkEDEs+BAQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=MeAgGD-zjQ4A:10:nop_rcvd_month_year
 a=2ITzLR9P390A:10:endurance_base64_authed_username_1 a=CngwRIvfAAAA:8
 a=HtaX_TNpu4LKavGKsBUA:9 a=ME9zoP5OuEEiGJMH:21 a=TbcvCE74ZyMI_5B1:21
 a=QEXdDO2ut3YA:10:nop_charset_2 a=4_miDDMz0JLoEzr4jVLQ:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:To:References:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cTzPtTA/F2HiVS99IjVFXDmMW7BYSdFzlIAFOBqKa08=; b=EItsMeQy4cAgnkvKpL+T360q+s
        W4hDr/oL3Mw6IkQYH3r8GMhdm1SnG7L/A6EzNPuWhDKxaJXnqJOy6lHWHflj6Wpv6MZWMCVrCDXHR
        3Uqy9yB9tMPLuRNi3Cm9pa4Dg;
Received: from host86-165-35-216.range86-165.btcentralplus.com ([86.165.35.216]:41922 helo=[192.168.1.148])
        by box790.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <devel@roosoft.ltd.uk>)
        id 1iY9b7-000z5k-5n
        for linux-btrfs@vger.kernel.org; Fri, 22 Nov 2019 07:07:45 -0700
Subject: Re: Problems balancing BTRFS
References: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
 <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com>
 <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
 <b1df6eec-4e23-33df-214c-6d49fb5fc085@gmx.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   devel@roosoft.ltd.uk
Openpgp: preference=signencrypt
Message-ID: <3f62a074-7712-b72c-fbe1-b63c5ca97271@roosoft.ltd.uk>
Date:   Fri, 22 Nov 2019 14:07:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <b1df6eec-4e23-33df-214c-6d49fb5fc085@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box790.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roosoft.ltd.uk
X-BWhitelist: no
X-Source-IP: 86.165.35.216
X-Source-L: No
X-Exim-ID: 1iY9b7-000z5k-5n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host86-165-35-216.range86-165.btcentralplus.com ([192.168.1.148]) [86.165.35.216]:41922
X-Source-Auth: dlocasci+casa-di-locascio.net
X-Email-Count: 1
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94NzkwLmJsdWVob3N0LmNvbQ==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/11/2019 13:56, Qu Wenruo wrote:
>
> On 2019/11/22 下午9:20, devel@roosoft.ltd.uk wrote:
>> On 22/11/2019 13:10, Qu Wenruo wrote:
>>> On 2019/11/22 下午8:37, devel@roosoft.ltd.uk wrote:
>>>> So been discussing this on IRC but looks like more sage advice is needed.
>>> You're not the only one hitting the bug. (Not sure if that makes you
>>> feel a little better)
>>
>>
>> Hehe.. well always help to know you are not slowly going crazy by oneself.
>>
>>>> The csum error is from data reloc tree, which is a tree to record the
>>>> new (relocated) data.
>>>> So the good news is, your old data is not corrupted, and since we hit
>>>> EIO before switching tree blocks, the corrupted data is just deleted.
>>>>
>>>> And I have also seen the bug just using single device, with DUP meta and
>>>> SINGLE data, so I believe there is something wrong with the data reloc tree.
>>>> The problem here is, I can't find a way to reproduce it, so it will take
>>>> us a longer time to debug.
>>>>
>>>>
>>>> Despite that, have you seen any other problem? Especially ENOSPC (needs
>>>> enospc_debug mount option).
>>>> The only time I hit it, I was debugging ENOSPC bug of relocation.
>>>>
>> As far as I can tell the rest of the filesystem works normally. Like I
>> show scrubs clean etc.. I have not actively added much new data since
>> the whole point is to balance the fs so a scrub does not take 18 hours.
> Sorry my point here is, would you like to try balance again with
> "enospc_debug" mount option?
>
> As for balance, we can hit ENOSPC without showing it as long as we have
> a more serious problem, like the EIO you hit.


Oh I see .. Sure I can start the balance again.


>>
>> So really I am not sure what to do. It only seems to appear during a
>> balance, which as far as I know is a much needed regular maintenance
>> tool to keep a fs healthy, which is why it is part of the
>> btrfsmaintenance tools 
> You don't need to be that nervous just for not being able to balance.
>
> Nowadays, balance is no longer that much necessary.
> In the old days, balance is the only way to delete empty block groups,
> but now empty block groups will be removed automatically, so balance is
> only here to address unbalanced disk usage or convert.
>
> For your case, although it's not comfortable to have imbalanced disk
> usages, but that won't hurt too much.


Well going from 1Tb to 6Tb devices means there is a lot of weighting
going the wrong way. Initially there was only ~ 200Gb on each of the new
disks and so that was just unacceptable it was getting better until I
hit this balance issue. But I am wary of putting too much new data
unless it is symptomatic of something else.



> So for now, you can just disable balance and call it a day.
> As long as you're still writing into that fs, the fs should become more
> and more balanced.
>
>> Are there some other tests to try and isolate what the problem appears
>> to be?
> Forgot to mention, is that always reproducible? And always one the same
> block group?
>
> Thanks,
> Qu


So far yes. The balance will always fall at the same ino and offset
making it impossible to continue.


Let me run it with debug on and get back to you.


Thanks.




