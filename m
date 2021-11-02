Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0D443996
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Nov 2021 00:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKBX1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 19:27:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:58097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhKBX1F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 19:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635895467;
        bh=uyvCfQ62gzRKgOq3Hw/YeoZBs50kF/fJdBuSxnTFiqw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=WCoSsSo4lNTH94RBQhnjRTDBieiJyiGj9O8Q27Vi/a4JllpbkOfpiGmTghcpfhSbE
         YFHLLUXNcuMJhtZqSRsUu9ZQhdcqmKAyCRbYR3Pxg5sDpU1MkHuu9ltETQ9p2pexyH
         h9RMg0l0h3EJGpFm9ogUS5dhHsZegZzeBz7fHPFw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC34X-1mtuAJ05L3-00CSfP; Wed, 03
 Nov 2021 00:24:26 +0100
Message-ID: <a79daa40-b36e-c7db-da31-527c05f5954f@gmx.com>
Date:   Wed, 3 Nov 2021 07:24:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] btrfs-progs: Make "btrfs filesystem df" command to
 show upper case profile
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211102120637.44447-1-wqu@suse.com>
 <20211102141236.GI20319@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211102141236.GI20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O99VtRihHRGWg6vxFHI3y4oncDa3IVa58wJoN62SV6IJDJe6MaP
 lsTNh//+vr/6c+bBJma3NW/EwVS6JY0Z3gXSrXWYKyAUvHu+uXaWX3pKdEAUXzZFzIYunSQ
 RyHHVLS3PwleOK0Acr4AcI/ux7c53BUNtgkPlS82xKgae3ZNv+jXZ/btjyeqmj09vbznpOx
 2muDywJCyRvKuXtQNZbbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pOEkA1ME33Q=:R4oyySCcikeHcgC230/R5x
 jUR4+UUikbKCYLSlPGQsgXthaODyj4hiLUTAZI86zLd/2ysmP/yQBkYqpKNmoO/5ajFI1TwTL
 CzAuN7Rv1kt4LqAxRGMsRCtq845+3Lr25RanTKtCZbM8MIwmAbbMH7IrZeGRt/TVYJTiAzWxr
 96FhfTMMAKIafcY1VgFQVHOv00JPXfiZOXe094VXGVYzfWCywvWWTLGrC5lptHYFdNujov4hO
 WBgfa966oEYedYsDkwam5po67LBvJv16AzQcakFEh5OiRE/MZ5doiZuUwJPRiMt1eyTm+nWI4
 KaULns4YjWbmol6mbypD/4UaEHhYfSp40Y3lZmIog1BAmBfBA3ezP5CdUfUddHYtodEgvs5TR
 mI5uoDPuDHkp0nRyYhPZHA9aNtwNl2NkiygEqTACWx7ySSIqt/kFbfSs2tmiCIjJz8l9Hhku/
 EZy+Pxkt2/I8aJLBB14xH3LhoOIJbGSIEXW8PsWXF580+uFlIM53o4GzUdSji3IAyvE/ahyj3
 MsqXjRX4UNrqCGbRUZ6ughrWpKhup7VDhVWI8Z/iV3jOE2+i9hFCAng1xLKu5J9z0o7x8PAhy
 CsA4HWiKgWVrHRzGA0Pdh1dZr2luc+pEPgPG+7ZWrgtLwvpGwZ/MyH5O5z+LJKGtjqYWI/dCN
 4F5EpXPQ27thREuRMm7ZM6Yps2Km8Cb8Rf0U2UJyKMrUMWStRdYcvM8mKEDsTHydBtjTmDwaI
 Q5nY2CY/N3KWD01wfkZuA6wYRAegG8AQgL/QH2HhmWHYhdIriX+/G/zfCHfXYhHZQ8xv9KYeC
 VK/n6LfQgdXPMY0pTU3D7uZsDknPvapGBgr7/4/7333GDmqPATMmCjitjgxEXOwZCQNqRP4vy
 qvFBh1szWIdm6K5ffq3wzri72XzPVybBJQLlMKWEkJcWeRU02WXoZckaoigEYlAwqkHxUHULq
 jhVIaa0wGbvICmqN7HHvdei4ET3ujqY/idd7k7rwU2eTHdzUwWacjEtjJn2kkD2huQlJC0m0r
 XmzHYPT3Ma3AIlkJRVc5uWQ4BMJ15W/Ywhrhpk80PrBot9971NSLphkJbYI7VHcfvgjWIuCdR
 jElJT3na4FUQrw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/2 22:12, David Sterba wrote:
> On Tue, Nov 02, 2021 at 08:06:37PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
>> to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.
>>
>> The failure of btrfs/151 explains the reason pretty well:
>>
>> btrfs/151 1s ... - output mismatch
>>      --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 +0800
>>      +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 17:13:43.=
879999994 +0800
>>      @@ -1,2 +1,2 @@
>>       QA output created by 151
>>      -Data, RAID1
>>      +Data, raid1
>>      ...
>>      (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out ~/xfstests-dev/re=
sults//btrfs/151.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to us=
e
>> raid table") will use btrfs_raid_array[index].raid_name, which is all
>> lower case.
>>
>> [FIX]
>> There is no need to bring such output format change.
>
> Well, indeed, I thought it won't be such a problem. If we want to have
> the upper case version, it could be better to add another string to the
> raid table. It is a bit of duplication but it would be easier to avoid
> the temporary buffers whenever it's printed. For kernel we don't need
> that but progs print the profiles a lot.
>
That's also an alternative way I'm trying to go, but don't want to bring
duplication in the raid table.

Let me try to find a better way, like doing it using macros at
initialization time.

Thanks,
Qu
