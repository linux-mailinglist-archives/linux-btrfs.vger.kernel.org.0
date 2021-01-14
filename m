Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26592F6BB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 21:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbhANUBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 15:01:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46157 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhANUBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 15:01:07 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DGwCL5kHQz1qs3X;
        Thu, 14 Jan 2021 21:00:14 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DGwCL5BSSz1tYWf;
        Thu, 14 Jan 2021 21:00:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id drDcm9R6_Qk2; Thu, 14 Jan 2021 21:00:13 +0100 (CET)
Received: from babic.homelinux.org (host-88-217-136-221.customer.m-online.net [88.217.136.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPS;
        Thu, 14 Jan 2021 21:00:13 +0100 (CET)
Received: from localhost (mail.babic.homelinux.org [127.0.0.1])
        by babic.homelinux.org (Postfix) with ESMTP id CAEF245407BC;
        Thu, 14 Jan 2021 21:00:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at babic.homelinux.org
Received: from babic.homelinux.org ([127.0.0.1])
        by localhost (mail.babic.homelinux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aUXeC7-4VgEh; Thu, 14 Jan 2021 21:00:10 +0100 (CET)
Received: from [192.168.178.47] (stefano-MacBookPro.fritz.box [192.168.178.47])
        by babic.homelinux.org (Postfix) with ESMTPS id CC3FD45404D8;
        Thu, 14 Jan 2021 21:00:09 +0100 (CET)
Subject: Re: btrfs-progs license
To:     dsterba@suse.cz, Stefano Babic <sbabic@denx.de>,
        Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
 <X8/pUT3B1+uluATv@relinquished.localdomain>
 <20201210112742.GC6430@twin.jikos.cz>
 <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
 <20210114184706.GD6430@twin.jikos.cz>
From:   Stefano Babic <sbabic@denx.de>
Message-ID: <7e6b258f-c3b4-32e7-eac5-8ee1b2611364@denx.de>
Date:   Thu, 14 Jan 2021 21:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114184706.GD6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 14.01.21 19:47, David Sterba wrote:
> On Thu, Dec 10, 2020 at 01:03:04PM +0100, Stefano Babic wrote:
>> I read this, thanks.
>>
>> I was quite confused about the license for libbtrfsutil due to both
>> "COPYING" and "COPYING.LESSER" in the library path. COPYING reports
>> GPLv3. But headers in file set LGPLv3, sure, and btrfs.h is GPLv2.
>>
>>
>>> I'd like to understand what's the problem with LGPLv3 before we'd
>>> consider switching to LGPLv2, which I'd rather not do.
>>>
>>
>> Please forgive me ig I am not correct because I am just a developer and
>> not a lawyer.
>>
>> The question rised already when QT switched from LGPv2 to LGPLv3, and
>> after the switch what companies should do to be license compliant. Based
>> on information given by qt.io and from lawyers (I find again at least
>> this link https://www.youtube.com/watch?v=lSYDWnsfWUk), it is possible
>> to link even close source SW to libraries, but to avoid the known
>> "tivoization", the manufacturer or user of a library must provide
>> instruction to replace the running code. This is an issue for embedded
>> devices, specially in case the device is closed with keys by the
>> manufacturer to avoid attacks or replacement with malware - for example,
>> medical devices. This means that such a keys to be licence compliant
>> (anyone please correct me if I am wrong) must be provided, making the
>> keys itself without sense. The issue does not happen with LGPv2.1, and
>> this is the reason why many manufacturers are strictly checking to not
>> have (L)GPLv3 code on their device.
> 
> I haven't forgotten about this, but haven't researched that enough to
> make the decision.

;-)


> I need to do the 5.10 release and that will be
> without change to the license.

Of course.

> There are no new changes to libbtrfsutil
> so the number of people who'd need to agree with the potential
> relicensing remains the same.
>

That's fine.

In my understanding, current licensing for btrf-progs could be 
problematic. It is declared GPLv2 but it links libbtrfutils, and GPLv2 
is not compatible according to FSF to (L)GPLv3. If libbtrfsutil becomes 
LGPLv2.1, all conflicts are resolved ;-).

Best regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
