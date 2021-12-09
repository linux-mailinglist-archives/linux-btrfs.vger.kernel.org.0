Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD246E6A1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 11:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhLIKis (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 05:38:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:40027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhLIKis (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 05:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639046110;
        bh=nEmhvgNk4XjnD1n4GWjUzc+eNaMokMRe7qJsrrSo94I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I+ySKj+Z7f4pIgrhmU8BecqRTJh4iUX2BAJYoVRwu33J7U4AHzDHsrGHgD0E+AZi+
         aygdKMO34QBfrPl0CuPkBInEEtinJVyrg7gSPcwBcEZGmzTDiQwF9gIx836BgJFO1I
         WhSXZsNxrqRoN5oxjv31iI0RZp5l0aDTSC1bgRcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmUHp-1mCtPI44e1-00iW4v; Thu, 09
 Dec 2021 11:35:10 +0100
Message-ID: <c42daef2-e763-0f76-1952-6f162281a5da@gmx.com>
Date:   Thu, 9 Dec 2021 18:35:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 06/17] btrfs: replace btrfs_dio_private::refs with
 btrfs_dio_private::pending_bytes
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20211206022937.26465-1-wqu@suse.com>
 <20211206022937.26465-7-wqu@suse.com>
 <PH0PR04MB7416D9D7F3A2BB818E9215239B709@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416D9D7F3A2BB818E9215239B709@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IzPT2BlutC3nxqKw9Y40gm2aYdcK++gaL6rS08L4jjALsUbED2v
 r7LoxMmkG/msAUF5tYGsC5qmv13mmAGejpGr1REe8JyaUACEPlLyN4hZO7EhEfze9I5TOOR
 LeS+GyWbNwvZkE2XC1q5wWJIAUu+8PlAgLAVfrHklP/roouQEpzLV+DeQIPlcztY9WWJJtz
 6kznXI3PIVnNxR/pW3CDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7KB4IInFJ4w=:dCuCQDLg25vrxRvhZhAral
 X/fqfhMkLofSCK7VvwEw0Cv12dCLeuN+qA5LDTl0SAyBT9a8zkyXRkqp100BCoMiqHGkbOXu3
 E3uS6Si8Z8At8rp35MT+FcBhJD5It84FcrKsR/EzMbZlhgEJSHbC0h1LUBFNBj9fb3vr1/RZ0
 R3YUZ0MvnzUm+slfoRSUs1R31T5OH6KB7MsaVI3RiV3aehhHvAJ+Oc1HldZ2cJZ88SzpMhMAd
 PfXbUi0Rlw8Fu8ruh7HalcljB5jjC0/bp8ny/y88d6c5qyyFQ4P57iDFJOBBvFr71tLuKpVIk
 ABb30D+RvMDDkG3ZmnmbvHxpNq7mV7MXNpghmqRpUTeePcCUCKgdP78dDswHzchcYtNC/RGJh
 JcbW+6HdvyjEysz8OABynOp4521WpiDH+2jNOoBBxdiQz4WXwxjlSGteezLbgQa9yje1wVIrA
 lAtvhbeoPqktZbo7oWmoYqz0eA1Laf6YvZI6vDf2gkgJI4or5falBVuxwS7ul8x19Mj0YdrTT
 +sfQTSx4SREDkSIJr3wdzEdk1YVbCw6piTCB+tus78R2VtN0EVig1YvsXXg+TF7wlykqD66R2
 tB+infe7RHL13rDPofl9EroyMOvjwA9JB6qVnMKdD0wWokCKS8K6UTVTvPfu3OKuV6lqCC1zl
 94F3RXyCwkGiPJzF4FVADXgt3beeyKAGtsIqJ8QCjVobpPC1CoZ8etbqj0rDOfWtMn5dT5c9G
 tRH4RxsRqSkruzhpYvhYS0alzbuqmjuUBjr2/C4/8LPFofUYQm/WEFt4ZlGV+xHNKPSFzGZRb
 jp3OPrWuP1PMrTp3byjOvdF6yVlSla8Q8gxvqz3fTB8G9GuqqHpFNlP9oRzkk+KpFkh3g064O
 nURpWvOt92aXSo3w4wbFfz7Ky0W5QO2CtXbfPlo5zR0AsPFZEFSkcGia+orQJzVnhw0d3WzeO
 ui9dk2UWAR9QL/QGlsWctCySpfxPzpLrlVw+Jdo5XrELCDkhiKAB3x3G1eD4Hw7zZP0UnXIND
 s006Zbb9n4VVmNRi5PBhXkKs+J9Dl7gL49ro3ADtdHeJbc+Uh3pAwB1rgYBZRyl0M9aLOgLYL
 lngrXzqmTWrJqg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/9 18:02, Johannes Thumshirn wrote:
> On 06/12/2021 03:30, Qu Wenruo wrote:
>> This mostly follows the behavior of compressed_bio::pending_sectors.
>>
>> The point here is, dip::refs is not split bio friendly, as if a bio wit=
h
>> its bi_private =3D dip, and the bio get split, we can easily underflow
>> dip::refs.
>>
>> By using the same sector based solution as compressed_bio, dio can
>> handle both unsplit and split bios.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>
> JFYI, for this patch I get checkpatch complains:
>
> Applying: btrfs: replace btrfs_dio_private::refs with btrfs_dio_private:=
:pending_bytes
> .git/rebase-apply/patch:37: space before tab in indent.
>                                       u32 bytes)
> warning: 1 line adds whitespace errors.
> ERROR:CODE_INDENT: code indent should use tabs where possible
> #32: FILE: fs/btrfs/inode.c:7693:
> +^I    ^I^I^I     u32 bytes)$
>
> WARNING:SPACE_BEFORE_TAB: please, no space before tabs
> #32: FILE: fs/btrfs/inode.c:7693:
> +^I    ^I^I^I     u32 bytes)$
>
> total: 1 errors, 1 warnings, 180 lines checked
>
Oh, I should add checkpatch to my git hooks...

Thanks for catching this, will rebase the branch to misc-next with this
fixed.

Thanks,
Qu
