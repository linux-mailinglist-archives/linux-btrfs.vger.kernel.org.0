Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45112D2BD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 14:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgLHN0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 08:26:15 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33913 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgLHN0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 08:26:15 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Cr1Bp4SPsz1qt3c;
        Tue,  8 Dec 2020 14:25:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Cr1Bp3w85z1tYW1;
        Tue,  8 Dec 2020 14:25:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id uVIR6yKWW-xH; Tue,  8 Dec 2020 14:25:20 +0100 (CET)
Received: from babic.homelinux.org (host-88-217-136-221.customer.m-online.net [88.217.136.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPS;
        Tue,  8 Dec 2020 14:25:20 +0100 (CET)
Received: from localhost (mail.babic.homelinux.org [127.0.0.1])
        by babic.homelinux.org (Postfix) with ESMTP id 37FD1454088D;
        Tue,  8 Dec 2020 14:25:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at babic.homelinux.org
Received: from babic.homelinux.org ([IPv6:::1])
        by localhost (mail.babic.homelinux.org [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id oTjOX12qyRzq; Tue,  8 Dec 2020 14:25:17 +0100 (CET)
Received: from [192.168.178.64] (paperino.fritz.box [192.168.178.64])
        by babic.homelinux.org (Postfix) with ESMTP id AA6D345403B3;
        Tue,  8 Dec 2020 14:25:16 +0100 (CET)
Subject: Re: btrfs-progs license
To:     Neal Gompa <ngompa13@gmail.com>, Stefano Babic <sbabic@denx.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
 <CAEg-Je9iUAn+9H7p+qm8D+bSY382VkTKZ0H4ExNLePAEZT9nEA@mail.gmail.com>
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
Message-ID: <4e94f309-2fed-7ad6-a322-1dcfeaeb5c6d@denx.de>
Date:   Tue, 8 Dec 2020 14:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je9iUAn+9H7p+qm8D+bSY382VkTKZ0H4ExNLePAEZT9nEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Neal,

On 08.12.20 13:37, Neal Gompa wrote:
> On Tue, Dec 8, 2020 at 4:52 AM Stefano Babic <sbabic@denx.de> wrote:
>>
>> Hi,
>>
>> I hope I am not OT. I ask about license for btrfs-progs and related
>> libraries. I would like to use libbtrfsutils in a FOSS project, but this
>> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
>> projects where secure boot is used.
>>
> 
> Please don't use this phrasing, because it's not true. There is no
> circumstance where the GNU version 3 licenses (GPL, LGPL, AGPL) are
> incompatible with secure boot environments. What you're talking about
> is an additional restriction *you* are imposing in which you don't
> want to make it possible for the software to be user-serviceable for
> any purpose. That's not the same thing as "secure boot".
> 

Sorry for misunderstanding, you're right - but you have perfectly
understood what I meant ;-)

>> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
>> also libbtrfs. But I read also that libbtrfs is thought to be dropped
>> from the project. And checking btrfs, this is linked against
>> libbtrfsutils, making the whole project GPLv3 (and again, not suitable
>> for many industrial applications in embedded systems).
>>
>> Does anybody explain me the conflict in license and if there is a path
>> for a GPLv2 compliant library ?
>>
> 
> I'm not sure there is a conflict, but there are relatively few authors
> of the libbtrfsutil code, so we could get the license downgraded to
> LGPLv2+ instead of being LGPLv3+.

This would be really nice !

Regards,
Stefano


-- 
=====================================================================
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
