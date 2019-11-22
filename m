Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83FA107381
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfKVNlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 08:41:03 -0500
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:36446 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfKVNlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 08:41:03 -0500
X-Greylist: delayed 1243 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 08:41:02 EST
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id 913281405F4
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Nov 2019 06:20:17 -0700 (MST)
Received: from box790.bluehost.com ([66.147.244.90])
        by cmsmtp with ESMTP
        id Y8rBioUih94wVY8rBi1sUv; Fri, 22 Nov 2019 06:20:17 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Robr0huK c=1 sm=1 tr=0
 a=9zS9oP4XFFrDhkEDEs+BAQ==:117 a=9zS9oP4XFFrDhkEDEs+BAQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=MeAgGD-zjQ4A:10:nop_rcvd_month_year
 a=2ITzLR9P390A:10:endurance_base64_authed_username_1 a=CngwRIvfAAAA:8
 a=tWLE9rZIvy5bUJVNCpMA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=4_miDDMz0JLoEzr4jVLQ:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=casa-di-locascio.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:To:From:References:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ztzQmk3ySydBOY4V6leYwP2++XVg8KOmS15m07alUuw=; b=iLCKHlyn5weA8XKMWOPTqB/xJB
        pdKB6ArQe8FRAy65BfpNHocJPoysblISKQVnfP//N+mPXXraCRbcxxV6my6cJvGC50C3RqNjsnqYb
        4HOTOA+o/B7qluGooMwvEu0JK;
Received: from host86-165-35-216.range86-165.btcentralplus.com ([86.165.35.216]:33958 helo=[192.168.1.148])
        by box790.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <devel@roosoft.ltd.uk>)
        id 1iY8r6-000Rde-4k
        for linux-btrfs@vger.kernel.org; Fri, 22 Nov 2019 06:20:12 -0700
Subject: Re: Problems balancing BTRFS
References: <65447748-9033-f105-8628-40a13c36f8ce@casa-di-locascio.net>
 <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com>
From:   devel@roosoft.ltd.uk
Openpgp: preference=signencrypt
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Autocrypt: addr=devel@roosoft.ltd.uk; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e382e662-b09f-c9f3-e589-44560a7b9b97@casa-di-locascio.net>
Date:   Fri, 22 Nov 2019 13:20:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1de2144f-361a-4657-662f-ac1f17c84b51@gmx.com>
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
X-Exim-ID: 1iY8r6-000Rde-4k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host86-165-35-216.range86-165.btcentralplus.com ([192.168.1.148]) [86.165.35.216]:33958
X-Source-Auth: dlocasci+casa-di-locascio.net
X-Email-Count: 1
X-Source-Cap: Y2FzYWRpbG87Y2FzYWRpbG87Ym94NzkwLmJsdWVob3N0LmNvbQ==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/11/2019 13:10, Qu Wenruo wrote:
>
> On 2019/11/22 下午8:37, devel@roosoft.ltd.uk wrote:
>> So been discussing this on IRC but looks like more sage advice is needed.
> You're not the only one hitting the bug. (Not sure if that makes you
> feel a little better)



Hehe.. well always help to know you are not slowly going crazy by oneself.

>>
>> The csum error is from data reloc tree, which is a tree to record the
>> new (relocated) data.
>> So the good news is, your old data is not corrupted, and since we hit
>> EIO before switching tree blocks, the corrupted data is just deleted.
>>
>> And I have also seen the bug just using single device, with DUP meta and
>> SINGLE data, so I believe there is something wrong with the data reloc tree.
>> The problem here is, I can't find a way to reproduce it, so it will take
>> us a longer time to debug.
>>
>>
>> Despite that, have you seen any other problem? Especially ENOSPC (needs
>> enospc_debug mount option).
>> The only time I hit it, I was debugging ENOSPC bug of relocation.
>>

As far as I can tell the rest of the filesystem works normally. Like I
show scrubs clean etc.. I have not actively added much new data since
the whole point is to balance the fs so a scrub does not take 18 hours.


So really I am not sure what to do. It only seems to appear during a
balance, which as far as I know is a much needed regular maintenance
tool to keep a fs healthy, which is why it is part of the
btrfsmaintenance tools 

Are there some other tests to try and isolate what the problem appears
to be?


Thanks.

-- 
==

D LoCascio

Director

RooSoft Ltd

