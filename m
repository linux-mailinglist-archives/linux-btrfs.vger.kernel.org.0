Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF4362C68
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Apr 2021 02:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhDQAYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 20:24:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:34045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQAYA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 20:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618619010;
        bh=HiG9mD7tt8jUL12ybc6yTvgh2W4W1L4EOTpp04j4U3s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TkG7QYf+gqcC1jOyFyXNokL3GZMZL/15j2gub+8JAbN+oFe7mHDManWh6r75Bqfwd
         rhQm0Em2lbH1aKoZe7V5SWe/3mK444FuorkDrzWm/jgLsngixADQ1DhdWq9mUxUN9Y
         gncq6WHOrKJT6T1FWaMJJxC++5PxrnXCBN2xGVFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1m18D037N9-00hz8L; Sat, 17
 Apr 2021 02:23:30 +0200
Subject: Re: [PATCH] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210415053011.275099-1-wqu@suse.com> <YHnT8Dwobux2J9Pt@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8d764e02-9f6e-e068-f470-f4503ca23ca8@gmx.com>
Date:   Sat, 17 Apr 2021 08:23:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHnT8Dwobux2J9Pt@zen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mj4zxgrZamibazSNRoyFhl8NQcUTWbFMeApBIF2+zN0RPNhg0/d
 GSSQ8rwFL3UtmhnrUnC1w4qTLqnsNgFJ8J5DYR8bELV8ZFs67tPMn7eicl8wsymBU54JpTv
 S9Pd6kE8dNpGW9Nkr76oNYGkRWESisifL+FEWk09c2ObzM9UoC/V5G3BujePgB5wQOWLyC9
 fCEw7AF3keCrHVs+fA6hQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sr5g0P0dFw0=:HpFh0n8RGpaJnDXkWhGLP9
 ZvOKzuEPTSqRKljA9hhrd8gs6EPYPF1w3yBqyHEGE3hD0vqcvLujw6+fd/EjYZp5reUl8U0p5
 EJUxlloan4YhunA0FNGACPxfqf8YwoLvDmTRLUSC5ERXFP/+jsl6/ev0rL9of931whANo/SlJ
 RHxXizPn1cMJu9ktTJzByXMadmvRQKgorOa63WwvvEf56ZUEK/ORFVWagBgCJiOpbllblLfK3
 wGeGeMUt9o/pq+m7fCJLzDMfsCioYMGvP/nlCApOx1YyUhJaQI06z3Qf0hM/6NvQw1tbneVhF
 ZIek507itdyGQrXtnl56YXNY0v63qn2ZvS1+dn3IDbC6z/xXZt0ZlIPiExTeVq5BciZbSpuVV
 V8rRZ/MYB5+x9PBlb9OLBuy2wRhfDnh4Dd/rILarLHZ8pBXfXArmnAic8hoSVpQB3717TlBF7
 +Uyg9xk1GVs+Qv9qJ46JSztTzdDaEUD3WMGDWIW+51aXf/VA3Xdn2PgFkaKpiKv6TXPNT5LYm
 QWE/4hhQPFcK4X8Wc5npiE75/X731DaDjiaVunc/saEteYFMIa92aQKoJF7RWaZSk7Xw2+et0
 FkAYwz4mrMuQKVTkO9OhI1Ou7uXaUjgjpabydthZH/NWWUWpWWnGzgdHT8XYkWw8ZkgGmrZiK
 /wt09JCB5lKzRCBU7VhCV+mGYWcUho+nogiVvR+L0JTzt3rVStRi53QXLsFCCAppVih2xd4pP
 a+dpYWUmEJer9fgdk0uF3yHhb0qMbVos55DP+mJ8oNFPrvHa3ObtJUq8KZWo7ssrrqTpjwk3v
 EZkwFmczz6PPvz1HZW9cCPWszMLPIyJwscxzYbyGM8VpOQoIYT2lvEc+aAQVYLCth7xwIRYb2
 OpnSvFErOm7/vJYoTA3IZ9r1tuGlJgvA6baAvLB1kXuSmgy9VvxMyl2/K5QFW12lajCtz+CuR
 xfW/Ic15GDXsBZMy0H7PuLfUU6h/e+sQCL9tDvF6W/6Hn/aHPIQw1MFIzmgsNsk+kipJiiUwJ
 DqdWV4Mf2GnJS/nh2jfuL0TUydAXbzKeLO6nAvEAKAqrsQqmAfBDhOfKT0dyqB9ppxhtDu2oG
 Y+TBPGGRxAWh5wqznYwl89y0JDzgTfQemH96eKc4FZ2I/NjwQiwSFKCKGn4otrDbsfM/mEtPl
 WrucFyxCvx8CPZcxGfKnms/0LEpajqqlfdMDJzjqf9h4w4W6xr5FqSp4wex+cssKpbckREKca
 CmPSMT+DgsIhZK5hk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/17 =E4=B8=8A=E5=8D=882:14, Boris Burkov wrote:
> On Thu, Apr 15, 2021 at 01:30:11PM +0800, Qu Wenruo wrote:
>> Currently mkfs.btrfs will output a warning message if the sectorsize is
>> not the same as page size:
>>    WARNING: the filesystem may not be mountable, sectorsize 4096 doesn'=
t match page size 65536
>>
>> But since btrfs subpage support for 64K page size is comming, this
>> output is populating the golden output of fstests, causing tons of fals=
e
>> alerts.
>>
>> This patch will make teach mkfs.btrfs to check
>> /sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
>> size is supported.
>>
>> Then only output above warning message if the sector size is not
>> supported.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/fsfeatures.c | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 569208a9e5b1..13b775da9c72 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -16,6 +16,8 @@
>>
>>   #include "kerncompat.h"
>>   #include <sys/utsname.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>>   #include <linux/version.h>
>>   #include <unistd.h>
>>   #include "common/fsfeatures.h"
>> @@ -327,8 +329,15 @@ u32 get_running_kernel_version(void)
>>
>>   	return version;
>>   }
>> +
>> +/*
>> + * The buffer size if strlen("4096 8192 16384 32768 65536"),
>> + * which is 28, then round up to 32.
>
> I think there is a typo in this comment, because it doesn't quite parse.

I mean the strlen() =3D=3D 28, then round the value to 32.

Any better alternative?


>
>> + */
>> +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
>>   int btrfs_check_sectorsize(u32 sectorsize)
>>   {
>> +	bool sectorsize_checked =3D false;
>>   	u32 page_size =3D (u32)sysconf(_SC_PAGESIZE);
>>
>>   	if (!is_power_of_2(sectorsize)) {
>> @@ -340,7 +349,32 @@ int btrfs_check_sectorsize(u32 sectorsize)
>>   		      sectorsize);
>>   		return -EINVAL;
>>   	}
>> -	if (page_size !=3D sectorsize)
>> +	if (page_size =3D=3D sectorsize) {
>> +		sectorsize_checked =3D true;
>> +	} else {
>> +		/*
>> +		 * Check if the sector size is supported
>> +		 */
>> +		char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] =3D { 0 };
>> +		char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] =3D { 0 };
>> +		int fd;
>> +		int ret;
>> +
>> +		fd =3D open("/sys/fs/btrfs/features/supported_sectorsizes",
>> +			  O_RDONLY);
>> +		if (fd < 0)
>> +			goto out;
>> +		ret =3D read(fd, supported_buf, sizeof(supported_buf));
>> +		close(fd);
>> +		if (ret < 0)
>> +			goto out;
>> +		snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
>> +			 "%u", page_size);
>> +		if (strstr(supported_buf, sectorsize_buf))
>> +			sectorsize_checked =3D true;
>
> Two comments here.
> 1: I think we should be checking sectorsize against the file rather than
> page_size.

Damn it, all my bad.

> 2: strstr seems too permissive, since it doesn't have a notion of
> tokens. If not for the power_of_2 check above, we would admit all kinds
> of silly things like 409. But even with it, we would permit "4" now and
> with your example from the comment, "8", "16", and "32".

Indeed I took a shortcut here.

It's indeed not elegant, I'll change it to use " " as token to analyse
each value and compare to sector size.

Thanks,
Qu
>
>> +	}
>> +out:
>> +	if (!sectorsize_checked)
>>   		warning(
>>   "the filesystem may not be mountable, sectorsize %u doesn't match pag=
e size %u",
>>   			sectorsize, page_size);
>
> Do you have plans to change the contents of this string to match the new
> meaning of the check, or is that too harmful to testing/automation?
>
>> --
>> 2.31.1
>>
