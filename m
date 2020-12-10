Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174E82D59F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgLJMFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 07:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgLJMFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 07:05:17 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF672C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Dec 2020 04:04:21 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CsCH1295Mz1rvy2;
        Thu, 10 Dec 2020 13:03:09 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CsCH11W6Nz1tv25;
        Thu, 10 Dec 2020 13:03:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id v0uM1cm9uhos; Thu, 10 Dec 2020 13:03:07 +0100 (CET)
Received: from babic.homelinux.org (host-88-217-136-221.customer.m-online.net [88.217.136.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPS;
        Thu, 10 Dec 2020 13:03:07 +0100 (CET)
Received: from localhost (mail.babic.homelinux.org [127.0.0.1])
        by babic.homelinux.org (Postfix) with ESMTP id 295BC4540586;
        Thu, 10 Dec 2020 13:03:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at babic.homelinux.org
Received: from babic.homelinux.org ([IPv6:::1])
        by localhost (mail.babic.homelinux.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id hsdvj19QnyXN; Thu, 10 Dec 2020 13:03:04 +0100 (CET)
Received: from [192.168.178.64] (paperino.fritz.box [192.168.178.64])
        by babic.homelinux.org (Postfix) with ESMTP id 2A2254540483;
        Thu, 10 Dec 2020 13:03:04 +0100 (CET)
Subject: Re: btrfs-progs license
To:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        Stefano Babic <sbabic@denx.de>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
 <X8/pUT3B1+uluATv@relinquished.localdomain>
 <20201210112742.GC6430@twin.jikos.cz>
From:   Stefano Babic <sbabic@denx.de>
Autocrypt: addr=sbabic@denx.de; prefer-encrypt=mutual; keydata=
 mQGiBEfdB5IRBADkpYcnh2BoAkGD5p186ysEkWlcp5DU07m7BKzvkEMRhFjeFUOU0klKNmh0
 ZM6rKpYpAYPYBm9YahMyqvj9DmLrZ4yfJ5MssvW9SRETmHpva+h1rN+DzmEcwrqZmLG1JWGy
 LA5ruJaFSzxJHBoROoog1NDMbNDB8A9F7VKrePfkVwCgmODpW/uh2IuMYLVidzDeuvo7alED
 /iV8rwU7C+eBcKy2htuDsEmsqlkBxIDM7IO6h5XxdyqbZOYizuBP3Ksb6xK54weEaB5aQs7S
 8N9Soi0p1Xh0LMWj6PBCzTC4LF+OCGEMBPc6bBHNzivChgztJlUMioCDSVpOXB/QpBaK302G
 yP5WdmcB1Jn6neq/YRlxHN38MV2yA/46jnzeUotL9LliVZKA/ql4GmyWg2Ae1BUiCqEJQNwl
 knGJOmIS4uABLArB5HjsfDU5hA9FORaNGCIiZlezBkZ3JXA2uQMQhfgqBXrZt4j1fcw9I7E+
 7IZ2kSCeTPZFLd5FiGQPDOm3Z9eHrpK6pmBGMeBG0pDgUEbN9awyLNBLj7QeU3RlZmFubyBC
 YWJpYyA8c2JhYmljQGRlbnguZGU+iGMEExECACMCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIX
 gAUCT9deSgIZAQAKCRD09WXkmmjvppF1AKCRl8d49K4yxWzdBVRTTWG55cyo/gCfRD1RAttl
 R1ofs2wGLHNtXousyL25Ag0ER90HmBAIAIFfX4bKnOmCyB3nPh+jbXZuBSMZTuyDEnguRxl5
 N8Q0ayofQwucCBjXYv65sQ9Rq6FNhEnWqUZBu8A5CwvSakOFOGNC5ta/8VxVRLh0Z0ZTgEep
 SKiPonJyacCbmgWDECdVrKowV7QB9be3Wu67uAZ74rPw2Kd7f0FKnL3djvVRMaBWFIpyQ6SE
 bGOCJjhRQ5L1pIM1Soko+reU7eO+1g6IBw6YkFJisdQE6fzTwaSqUKPPsQLz/W03invQltOb
 Eg7ZwtFs0DFonr1DMm57ksiEhW6SN1wylRO/JzRYG1Qe7u1EVln6iV3ilBvbbfkyRssk4/0e
 kicpSnQknA72YOMAAwYH+QGpAiQ4hAMHrp1bUrtyGXYdeQpYufIZAM4etOnBy/G+e1nfu6y+
 jH4SN9sVK7bwBBAbhEJqkqR5LVsFIRapThJQOWB11rQxLpwkBU9wao/pRM+o95ujGo32WUzf
 wWrzWrkTDy7vMCZuUOLVi4n1GZlUAwpG4rzb6UxPC6GWymkVWGgXp1NC58og5i3Y+rKT7+Xi
 XT2BtvC6PDepoH4JhD+9OkHQO6UfTxPSmtgNbTgtl6L6tj+bm5dOHgkPJFMkEiG8qhUZYQzb
 bYz37orRbA72M2bxK76e9QKn0mVu+d/YCd8wRcvvJbGsozpzcxPvD5Wy5RNJCES8McPtAseU
 tMeISQQYEQIACQUCR90HmAIbDAAKCRD09WXkmmjvpv+3AJ9RakBsH1j0X/Kxp6t2lf0VUfS2
 qACfZ+J6ktk8PKNuyHf0J/I0mbCrhV4=
Message-ID: <7f16d12b-c420-86f1-2cb5-ece52bec6a2f@denx.de>
Date:   Thu, 10 Dec 2020 13:03:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210112742.GC6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 10.12.20 12:27, David Sterba wrote:
> On Tue, Dec 08, 2020 at 01:00:01PM -0800, Omar Sandoval wrote:
>> On Tue, Dec 08, 2020 at 10:49:10AM +0100, Stefano Babic wrote:
>>> Hi,
>>>
>>> I hope I am not OT. I ask about license for btrfs-progs and related
>>> libraries. I would like to use libbtrfsutils in a FOSS project, but this
>>> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
>>> projects where secure boot is used.
>>
>> libbtrfsutil is LGPLv3, where did you get the idea that it is GPLv3?
>>
>>> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
>>> also libbtrfs. But I read also that libbtrfs is thought to be dropped
>>> from the project. And checking btrfs, this is linked against
>>> libbtrfsutils, making the whole project GPLv3 (and again, not suitable
>>> for many industrial applications in embedded systems).
>>>
>>> Does anybody explain me the conflict in license and if there is a path
>>> for a GPLv2 compliant library ?
>>
>> No objections from me to make it LGPLv2 instead, I suppose. Dave,
>> thoughts?
> 
> I've replied in https://github.com/kdave/btrfs-progs/issues/323, the
> initial question regarding GPL v3 does not seem to be relevatnt as
> there's no such code.
> 

I read this, thanks.

I was quite confused about the license for libbtrfsutil due to both
"COPYING" and "COPYING.LESSER" in the library path. COPYING reports
GPLv3. But headers in file set LGPLv3, sure, and btrfs.h is GPLv2.


> I'd like to understand what's the problem with LGPLv3 before we'd
> consider switching to LGPLv2, which I'd rather not do.
> 

Please forgive me ig I am not correct because I am just a developer and
not a lawyer.

The question rised already when QT switched from LGPv2 to LGPLv3, and
after the switch what companies should do to be license compliant. Based
on information given by qt.io and from lawyers (I find again at least
this link https://www.youtube.com/watch?v=lSYDWnsfWUk), it is possible
to link even close source SW to libraries, but to avoid the known
"tivoization", the manufacturer or user of a library must provide
instruction to replace the running code. This is an issue for embedded
devices, specially in case the device is closed with keys by the
manufacturer to avoid attacks or replacement with malware - for example,
medical devices. This means that such a keys to be licence compliant
(anyone please correct me if I am wrong) must be provided, making the
keys itself without sense. The issue does not happen with LGPv2.1, and
this is the reason why many manufacturers are strictly checking to not
have (L)GPLv3 code on their device.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
