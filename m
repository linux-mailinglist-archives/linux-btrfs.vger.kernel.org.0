Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114CE2F6BF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhANURk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 15:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhANURk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 15:17:40 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879C3C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 12:16:44 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DGwZL152Tz1rx85;
        Thu, 14 Jan 2021 21:16:42 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DGwZL0WXWz1tYWf;
        Thu, 14 Jan 2021 21:16:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7bqAxT1OmFqQ; Thu, 14 Jan 2021 21:16:40 +0100 (CET)
Received: from babic.homelinux.org (host-88-217-136-221.customer.m-online.net [88.217.136.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPS;
        Thu, 14 Jan 2021 21:16:40 +0100 (CET)
Received: from localhost (mail.babic.homelinux.org [127.0.0.1])
        by babic.homelinux.org (Postfix) with ESMTP id C7CED45404D8;
        Thu, 14 Jan 2021 21:16:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at babic.homelinux.org
Received: from babic.homelinux.org ([127.0.0.1])
        by localhost (mail.babic.homelinux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bNFf_OB-KZpC; Thu, 14 Jan 2021 21:16:36 +0100 (CET)
Received: from [192.168.178.47] (stefano-MacBookPro.fritz.box [192.168.178.47])
        by babic.homelinux.org (Postfix) with ESMTPS id 0070345407BC;
        Thu, 14 Jan 2021 21:16:35 +0100 (CET)
Subject: Re: btrfs-progs license
To:     Neal Gompa <ngompa13@gmail.com>, Stefano Babic <sbabic@denx.de>
Cc:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
 <X8/pUT3B1+uluATv@relinquished.localdomain>
 <20201210112742.GC6430@twin.jikos.cz>
 <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
 <CAEg-Je93py9VSkUN98fZw5SN6yuKsa2jUMd2+KsvJ5WctRsH4w@mail.gmail.com>
From:   Stefano Babic <sbabic@denx.de>
Message-ID: <1e045d02-2c77-4fb6-75be-102beed5c76c@denx.de>
Date:   Thu, 14 Jan 2021 21:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je93py9VSkUN98fZw5SN6yuKsa2jUMd2+KsvJ5WctRsH4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Neal,

On 14.01.21 20:38, Neal Gompa wrote:
> On Thu, Dec 10, 2020 at 7:18 AM Stefano Babic <sbabic@denx.de> wrote:
>>
>> Hi David,
>>
>> On 10.12.20 12:27, David Sterba wrote:
>>> On Tue, Dec 08, 2020 at 01:00:01PM -0800, Omar Sandoval wrote:
>>>> On Tue, Dec 08, 2020 at 10:49:10AM +0100, Stefano Babic wrote:
>>>>> Hi,
>>>>>
>>>>> I hope I am not OT. I ask about license for btrfs-progs and related
>>>>> libraries. I would like to use libbtrfsutils in a FOSS project, but this
>>>>> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
>>>>> projects where secure boot is used.
>>>>
>>>> libbtrfsutil is LGPLv3, where did you get the idea that it is GPLv3?
>>>>
>>>>> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
>>>>> also libbtrfs. But I read also that libbtrfs is thought to be dropped
>>>>> from the project. And checking btrfs, this is linked against
>>>>> libbtrfsutils, making the whole project GPLv3 (and again, not suitable
>>>>> for many industrial applications in embedded systems).
>>>>>
>>>>> Does anybody explain me the conflict in license and if there is a path
>>>>> for a GPLv2 compliant library ?
>>>>
>>>> No objections from me to make it LGPLv2 instead, I suppose. Dave,
>>>> thoughts?
>>>
>>> I've replied in https://github.com/kdave/btrfs-progs/issues/323, the
>>> initial question regarding GPL v3 does not seem to be relevatnt as
>>> there's no such code.
>>>
>>
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
> While I'm not a lawyer, what I've been told by others is that it just
> means that you need a way to reset the keys for loading custom
> software. That doesn't mean giving your official keys, just a way to
> reset the trust for custom keys. This is analogous to how Secure Boot
> works on PCs with support for adding the user's own keys and removing
> preloaded keys.

This is correct, but this is unsatisfactory for embedded devices. Full 
agree in case of PCs, where you can load your keys.

But think about a medical device (a lung ventilator, for example, as we 
are all rather conditioned from news), or a device that was certified by 
some authority. It is simply not allowed to replace the running 
firmware, and manufacturers want to be sure that only their software is 
allowed to run. Or device on aircraft, or whatever.

It is more over the initial reason for GPLv3, that is the "tivoization" 
on set-top boxes. For such kind of restrictive applications, replacing 
the software is a noway. Manufacturers take care of this issue, run 
fossology and they avoid (L)GPLv3 software at all, even if it is easier 
and technically better to use them.

> 
> You can design systems to only interoperate on matching keys, so if a
> custom firmware is loaded, it's distrusted by standard firmware, and
> so on.
> 

Agree, but this cannot be applied for any device.

> This approach actually makes sense for the longevity of secure devices
> in the field, because they often outlast the companies that made them.
> Having a way to have another party "take over" and maintain the
> firmware is a good thing for the long-term stability of leveraging
> technology in sensitive industries.

This is not what I see in the embedded systems, and specially in case of 
certified devices.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
