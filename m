Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41823F9157
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 02:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhH0Ajn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 20:39:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:42651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhH0Ajn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 20:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630024729;
        bh=hc6UDNAkER1R3kIVhRWneFIVpMk9TAQ9pdhijSAwzVs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iI50j7yVAw4xZSPeN/Umm90tzIhbRp5+qvRR1RejcvJO5nt62h6VENUq3UTI0HmGi
         plqvTmaaC4Klc8q6WIutIagDNwLztTZhkWT4Knvbw0N4Zxerald/0ePgVderlQELEA
         uBzHNcR/MxIf5SNKFxH6BytIcuLaDYLulERWLOdc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1mOtXI1TyW-005Z56; Fri, 27
 Aug 2021 02:38:49 +0200
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
 <20210816151026.GE5047@twin.jikos.cz>
 <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
 <20210826175314.GO3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <14e03a46-6ba3-9b7f-30c0-0be0dee5b4c8@gmx.com>
Date:   Fri, 27 Aug 2021 08:38:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826175314.GO3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n6n7Kt/Fp5HMGRJZ6g+OBNlXtNXxfrH3YILs4YDAdpNfkP6OMwI
 6hQQ7iAY1BtYeJQSE5Wq+es63voN4GQcq1hUeQClrqlA/abSUzVztYj7RxcKou9CoRgexJe
 p9mBSZ+lcEfbg+onYyeVUuwoBMGTqn5hUUpjsBAPyxaOFgsCO6pXHIKGEGKr/zvI6J2lJGz
 hsoE4eQon8AGakELUY4nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6clfs5Dc0kc=:QwAnVMV9Nt3VMFG2owsEh4
 +p/xN6kyc2vmxU9G9ovJdpFyad63ZYRiCQRUFpc3vLHoq87AWkUUb8ECdffzmCUHfmRUdlZuH
 /a1D0dyrpJa/2ZXI2qpxOlcsgrmxC7xh2cbfSndc/hfUaNPD3DS3XGBj0JuKOSRS/oqeka1O1
 nOpuEDO2UTQbFLvpdpxM4h2jAuepbpCDG/1+YSTOzqC5Gkj9QEBcnfP1S4jxaNXqdmGhj+eOH
 t0vmYbv9CI1+bsphOHZzBo/0DztDvzgqxSh7NniN8bwuzXskTmGpFQLLcnNk4Yw0usIyr6uoS
 9xEqxzCkGEhlvPweX/LVSqZu02g6UOy1MfF4ExoaHOkuU11QC7DLMV54P0yCJNsDbnrcCh5nt
 ydCJClKAtVxcj/gf9l57WrZhx6R1+waNdIiGz6Udt0XkrjkAMt6CFpwypurLGwA2xyeAmt4zY
 weAqizgUNEIZhDoMaVZlYejQqkY9JYW9xeac4aDRKCpIfGsnoiysbLl8ACuRamFnWapXVt4xl
 nTGOE9S7BszG8JstVQ2pETAWgD2xy0GJBzbHQiwXWnlyFk2Ovf18nSOcgAcl9yLm8H5fJ0itq
 S5njZVIIJgSV+l7xb2GbnhcFHy5BeRE8KksDeyHTt0tyhQOl7o5dFh0AB/e8XVc3O2Hy0wO16
 Dd7Ll0Jp1JSWwWG/1OS5v+Dtfdk0O3kspZcG/cHqUYRiUMNCIvjrfi8AGvmVgV+ooSQU17XNA
 OdS0T6RWu6WkmR2z9AkHdT/sUZ1reXCmjfkACXiKEc0pY+7A0EFBh1nhtaW3+h4vQmfqYrygU
 2KQ5yWISS+xciBuK443bi5QBEOl+XSpbp/gm3IqZrCdyOi3ODHCt77A5plstD6I47gRrAqIJF
 TMxn5y72Dvbx4VKIX/ZHY7sPwdLlDEMrlxO/fu61xULFQ48z4foslwVPFwIOBmcfluAb9/y4o
 hpX2TKwIdg9fN/2o42qeVoSPwBO8N9BDKLYhJ6Xpd2xSNDqlcmB3SQML6FPY/rLP+TYpJN0v0
 /bOYZ3FbbxtMM68aUTvZxsnfjb8D4nWkl0mIKCOoxNwRBd8gp+XkcmnupRZhU75yUEMtoEAOS
 zJZxfHJPg+W7AL+RR8ocpSC6majncA3JEhgEmuXRDauwKmm45OhPR9Ocw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/27 =E4=B8=8A=E5=8D=881:53, David Sterba wrote:
> On Tue, Aug 24, 2021 at 01:54:21PM +0800, Anand Jain wrote:
>> On 16/08/2021 23:10, David Sterba wrote:
>>> On Tue, Aug 10, 2021 at 11:23:44PM +0800, Anand Jain wrote:
>>>> The mount option max_inline ranges from 0 to the sectorsize (which is
>>>> equal to pagesize). But we parse the mount options too early and befo=
re
>>>> the sectorsize is a cache from the superblock. So the upper limit of
>>>> max_inline is unaware of the actual sectorsize. And is limited by the
>>>> temporary sectorsize 4096 (as below), even on a system where the defa=
ult
>>>> sectorsize is 64K.
>>>
>>
>>> So the question is what's a sensible value for >4K sectors, which is 6=
4K
>>> in this case.
>>>
>>> Generally we allow setting values that may make sense only for some
>>> limited usecase and leave it up to the user to decide.
>>>
>>> The inline files reduce the slack space and on 64K sectors it could be
>>> more noticeable than on 4K sectors. It's a trade off as the inline dat=
a
>>> are stored in metadata blocks that are considered more precious.
>>>
>>> Do you have any analysis of file size distribution on 64K systems for
>>> some normal use case like roo partition?
>>>
>>> I think this is worth fixing so to be in line with constraints we have
>>> for 4K sectors but some numbers would be good too.
>>
>> Default max_inline for sectorsize=3D64K is an interesting topic and
>> probably long. If time permits, I will look into it.
>> Furthermore, we need test cases and a repo that can hold it (and
>> also add  read_policy test cases there).
>>
>> IMO there is no need to hold this patch in search of optimum default
>> max_inline for 64K systems.
>
> Yeah, I'm more interested in some reasonable value, now the default is
> 2048 but probably it should be sectorsize/2 in general.

Half of sectorsize is pretty solid to me.

But I'm afraid this is a little too late, especially considering we're
moving to 4K sectorsize as default for all page sizes.

Thanks,
Qu

>
>> This patch reports and fixes a bug due to which we are limited to test
>> max_inline only up to 4K on a 64K pagesize system. Not as our document
>> claimed as below.
>> -----------------
>>    man -s 5 btrfs
>>    ::
>>           max_inline=3Dbytes
>>              (default: min(2048, page size) )
>>    ::
>> 	In practice, this value is limited by the filesystem block size
>> 	(named sectorsize at mkfs time), and memory page size of the
>> 	system.
>> -----------------
>>
>>
>>    more below.
>>
>>>>
>>>> disk-io.c
>>>> ::
>>>> 2980         /* Usable values until the real ones are cached from the=
 superblock */
>>>> 2981         fs_info->nodesize =3D 4096;
>>>> 2982         fs_info->sectorsize =3D 4096;
>>>>
>>>> Fix this by reading the superblock sectorsize before the mount option=
 parse.
>>>>
>>>> Reported-by: Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>    fs/btrfs/disk-io.c | 49 +++++++++++++++++++++++-------------------=
----
>>>>    1 file changed, 25 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index 2dd56ee23b35..d9505b35c7f5 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -3317,6 +3317,31 @@ int __cold open_ctree(struct super_block *sb, =
struct btrfs_fs_devices *fs_device
>>>>    	 */
>>>>    	fs_info->compress_type =3D BTRFS_COMPRESS_ZLIB;
>>>>
>>>> +	/*
>>>> +	 * flag our filesystem as having big metadata blocks if
>>>> +	 * they are bigger than the page size
>>>
>>> Please fix/reformat/improve any comments that are in moved code.
>>
>>    I think you are pointing to s/f/F and 80 chars long? Will fix.
>
> Yes, already fixed in the committed version in misc-next, thanks.
>
