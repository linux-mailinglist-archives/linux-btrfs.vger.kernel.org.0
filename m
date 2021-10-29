Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEE94405D5
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhJ2Xl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 19:41:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:54073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhJ2XlZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 19:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635550733;
        bh=zu63csuaBtQK87cL9dyWZiQy3xLFozKEwv6xt50QWz4=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=QJGvk3egDtr3x0yxPY/JBv2rQEYccTauFRfE+x+4t302fRuTSdxqccP/5t7mZRmSr
         5hQagM99YDp1C1g+UKQ+8aUaOi7WglVPD7JIib4psCiwqAtXlnZ65evonopWpRcUTB
         K6lddB5qhdVFAzNZRbwSu5GhMN73HmNx0E0uewS4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1mexZ01SNG-002sVz; Sat, 30
 Oct 2021 01:38:53 +0200
Message-ID: <6b69f8a6-2769-1a5e-630b-76421529b2a7@gmx.com>
Date:   Sat, 30 Oct 2021 07:38:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com> <20211029141059.GC20319@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
In-Reply-To: <20211029141059.GC20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:46DzWFgb0TYZ6xJcdZT7vlpwj0wZ9+SlX5eKtLC1IuEbO328TlY
 f3WC32pcetYzlv92pwAJ71kZi3FAVefRdE2w28zOqMTDD/UrLxhjZ50VobZ6jySi8Afs5oE
 QJpcgpXY3BCGhKM+7a5EHQCXt1d8EwJigtQJfuBp9+r4fRwC9GugBbtbadPBwwxvLRjk95T
 /lT6FD1TPtaIpsDdt3+nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rMCnK7QiM8Q=:wxb8rcUJcdQPvLwZZk6/rG
 tFbI88pY2Ge2Dxh/b7Q0wO41vxwkn0odU9uUqsO8hHaUo5qjgTWo6eunxr9ukLB3Kiq8Wr0yT
 JT3bcRUTIj3K0MFdM5zGEqlrHr7+YOudkQ+uYnLDbRFnzfJ3J2Kk5+m4Y2XhjCqil3DnrjIJq
 mt/RtJI3lPreITqpOukB/V4hYpx6T9Q0O0hl2DA7Vy2vDDh+WmyyZ7DwHnFbJvd0nTfeo6MfZ
 AeQqxP23YCpxZZPolguFJMiRCiILSpoSdHGz36jJuSuEfloSb3pkB9VNmtHKsVdLAOpFl3c5F
 EDlsTbAwTfIycdg/OpeBzhUIFFRBP2uK1bAfW5g4M5NSzXv0O6H6b9CFZmN2TmZppZOEPJgKc
 unPKj8P88i8oVi67lOOfVrH4gE15LVVLjUzqYtIaf8TAiyNsnFrh0/B28d5y3s5xnjxZGW7qE
 UDQ+CoWut7S5cOW0PNmYLZqE8vxdEXAG/ApXjVaPCDFwx80ba7qMsGwhikY3SHvePnonDhzNW
 1lt7xKaFGxfwrMXiuoqdish6q+OVferHcuSkpHeJpC0LVW90ji1iIyZHrwKRyVvLo9PZbS2r+
 qXMklZVQCOXFuCGYBDrKdZYGO1nAt8d2u+QnO7c8YRFqbN6gcHPSYm+OW017v21GyQ1EPp+B9
 89UsEh0CQ6+aaEO/6TOy/WKRfj1EpRESKjV+0M85zHrABd9okyFNBLSZWO/S01rCc4mCbDym3
 I2lcb1ZInLA0es4jBeUI20iZBqt4P0hY/Bv+06VcoAtvFMnSmbO8YLIlQfw/Cn4xpjvlYt9vO
 n2fQB1moQ9hNXQgbjRN3QsrKw5YmaCv0sh0dUdXVzVr4F6VbpsuUvYD/jDFaEZgGzlEJF8VPQ
 aqJdMkrm9Wz7Sj4Ng9mmBVCjxHkP1VUNyrubMdhUi8KOqoqo9IrBvlkhswY2VZmCfZLlZauRt
 fXoATUL8j833ZU/FUrkRCPOQ1ynqhyhe3FWmqLOxUkAdFNnFlFlHt3RAyc/EmKWskVP+37WdT
 y0lKio7KNVN2uvg8li6UF7Og4gXXiGUWLUZjV5HijE20ExZrPOU2U0/IT2Vv50T2pE6JJjrB8
 RnH8r8/QZAm3oc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/29 22:11, David Sterba wrote:
> On Wed, Oct 27, 2021 at 01:28:59PM +0800, Qu Wenruo wrote:
>> +#define BTRFS_RAID_SHIFT	(ilog2(BTRFS_BLOCK_GROUP_RAID0) - 1)
>> +
>>   enum btrfs_raid_types {
>> -	BTRFS_RAID_RAID10,
>> -	BTRFS_RAID_RAID1,
>> -	BTRFS_RAID_DUP,
>> -	BTRFS_RAID_RAID0,
>> -	BTRFS_RAID_SINGLE,
>> -	BTRFS_RAID_RAID5,
>> -	BTRFS_RAID_RAID6,
>> -	BTRFS_RAID_RAID1C3,
>> -	BTRFS_RAID_RAID1C4,
>> +	BTRFS_RAID_SINGLE  =3D 0,
>> +	BTRFS_RAID_RAID0   =3D ilog2(BTRFS_BLOCK_GROUP_RAID0 >> BTRFS_RAID_SH=
IFT),
>> +	BTRFS_RAID_RAID1   =3D ilog2(BTRFS_BLOCK_GROUP_RAID1 >> BTRFS_RAID_SH=
IFT),
>> +	BTRFS_RAID_DUP     =3D ilog2(BTRFS_BLOCK_GROUP_DUP >> BTRFS_RAID_SHIF=
T),
>> +	BTRFS_RAID_RAID10  =3D ilog2(BTRFS_BLOCK_GROUP_RAID10 >> BTRFS_RAID_S=
HIFT),
>> +	BTRFS_RAID_RAID5   =3D ilog2(BTRFS_BLOCK_GROUP_RAID5 >> BTRFS_RAID_SH=
IFT),
>> +	BTRFS_RAID_RAID6   =3D ilog2(BTRFS_BLOCK_GROUP_RAID6 >> BTRFS_RAID_SH=
IFT),
>> +	BTRFS_RAID_RAID1C3 =3D ilog2(BTRFS_BLOCK_GROUP_RAID1C3 >> BTRFS_RAID_=
SHIFT),
>> +	BTRFS_RAID_RAID1C4 =3D ilog2(BTRFS_BLOCK_GROUP_RAID1C4 >> BTRFS_RAID_=
SHIFT),
>
> Please use const_ilog2 in case all the terms in the expression are
> constants that can be evaluated at the enum definition time.

Why? Kernel ilog2() is already handling the constants.

That's the biggest difference between kernel ilog2() and btrfs-progs
ilog2().

Only in btrfs-progs we need const_ilog2().

In fact, the comment of kernel ilog2() already shows this:

/**
  * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
  * @n: parameter
  *
  * constant-capable log of base 2 calculation
  * - this can be used to initialise global variables from constant
data, hence
  * the massive ternary operator construction
  *
  * selects the appropriately-sized optimised version depending on sizeof(=
n)
  */

>
> I agree that deriving the indexes from the flags is safe but all the
> magic around that scares me a bit.

That's indeed a little concerning.

That's why I spare no code to make it as hard as possible to break, like
all the explicit definition of each BTRFS_RAID_* number.

To me the only possible problem in the future is someone adding two or
more profiles in one go, and possibly corrupt the BTRFS_NR_RAID_TYPES.

But all BTRFS_RAID_* number should be pretty safe.

Thanks,
Qu
