Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96148750D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 10:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbiAGJwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 04:52:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:37355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346631AbiAGJwp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 04:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641549160;
        bh=jg1P4l3t5qcYKcxxkj1gmBVLZ6mcvt4GGQ8dFMujjtY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=gYpdlvfkKnPZZ3fVFdtho/DTbAeB7U7EodOjobHrvhzQSTYIXst2XUiOID73J1r6D
         zJ4eOv/KEptftNDkmJ546ijkdYJ115AK1/1bqIFR+RIyD1LoYtV/kkOAzMkF62BFSL
         XeYOlHSbDY8QgMvZnCps6r55itnPAZAEHuxvkS3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6KUd-1mHhN81rwX-016hYm; Fri, 07
 Jan 2022 10:52:40 +0100
Message-ID: <03d9ada8-1b57-90a8-c36a-b79f0e162359@gmx.com>
Date:   Fri, 7 Jan 2022 17:52:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] btrfs: refactor scrub_raid56_parity()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220107070951.48246-1-wqu@suse.com>
 <20220107070951.48246-2-wqu@suse.com>
 <1617e7dc-57e7-0c68-a8dd-1462ed246157@opensource.wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1617e7dc-57e7-0c68-a8dd-1462ed246157@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z6Txxuwg2bd/SspkaDFeSGwiS61Ag3tAx1YKArGhK3l9H8aQzEm
 g/z/n9XwaotJ4GjCujivkfjBnjoNYNqjxMquZa+sKIEjO+7CEWEaLd8uOz7bAb7qTB9SiUK
 DVc2/xPD/BWrPAAJHs1hART4wAgU7F26Rt5fyVWo2pDtuWkXYCLoANejYaYHZFs2Yh/TGzs
 ulXZ2+wYoshj6iO4ofRAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kPtaEB82idU=:x+sErBh/5hPleR9KQGdELE
 RzVhwBwkb10fW3QHAOZaNAt8sLINYwzNR1Z/L9PIxpuGsD+RkoxeiehKudulJGJp4ocpd0fM6
 Y7/33ZEe9z6XeZt2RiBBQ5kOrJs/qGPf7qfEz0cnX9n5eDGMTsYdsM5YslBBYndr/IQe8Wz4o
 Pzg/AMGX/BrZLZ1NW+MF3pA5TO3NsCRh7sDzwWkHHQgba1ehZPaPHkwvxm/nTnj/b5J+qotmo
 Uv/VVramwjpPNg/nFObDkcObMoJkuUGoXcWT97yClMGHuiZfsxC8nZ4Wrebh4n4hpJWsHkqVh
 rWgMxl/0nBv+CrdxwMIfY7eaCRFPj6la+3mSH+RvmJAjZ+T0rvhqqeP3lmYRXJ8LRRsjX2mHl
 nliQieMrRZTMPcHOpwPGA/8F5EiaWZWGL60lVH7Tm43zTFtoU7NGvMAocgXviDZFSX3WtGLc/
 ofrTLDGnTG8PAi95lt68z9wUKkoYvf5iRShDYrisCJAYXZnSK2cs67LmMLdyUFNWAzoAaaCJc
 2LK/NFozjODgYQ9RmajeztwbWRjbf/EiaYWbqOrntQVkqZNh5hj8cVV+gCZ3PN7bD5u2j8ZSN
 /ulxy7PWk2kpHIPyLJI7OyR4ogQc65JHNIkQeaOsqIb8TIAWwZGC5AtWtOAqDMwwXtRdNwdWs
 KwnZ6laftRTnKeIAymrj1U4weJSWDN8zmnhOn0vy8+2B7RwsfLG6FrrNBqch4JqDxhe4BKVd8
 4EjouAL1uRCJpDySeQ5+tRsoeAQDt+zmWTtxsFG8biNRVNxfaBca4H/EF8BKIhYUbl7ouh7f7
 DC8+5r4J60D5OLpOb3QGYIluVZOccNpHcxDyXnQdM/2DAndTLA6FnWMrwJHsDVW1Yu1tSy6vu
 MCdQqzDGKwcNsdSoh7SDkglyXqbYc+zuGJ+l9NP7pwxowHjU0uBu0EsgMzRDl85disYSfasjD
 c8iohQYVFIsxwYGxmhWHIYUwbdrgMZOSeiOcty0nDoeuuU8NToiAd1S39Bg03bQSFQkm9EK6/
 RSUEXWWwiNsuaXXRVxzeg+BclLUkvtp9BbL9QTkWrxWKy3MjUefau5+d2KriTXXFL7oOvVMw/
 gL8fQEZZgzu6os=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/7 16:20, Damien Le Moal wrote:
> On 1/7/22 16:09, Qu Wenruo wrote:
>> +		if (!ret) {
>> +			if (!bioc || mapped_length < extent_size)
>> +				ret =3D -EIO;
>> +		}
>
> The double "if" looks a little weird... You can simplify this:
>
> 		if ((!ret) && (!bioc || mapped_length < extent_size))
> 			ret =3D -EIO;

Sure, this is indeed better.
[...]
>> +		ret =3D scrub_extent_for_parity(sparity, extent_start,
>> +					      extent_size, extent_physical,
>> +					      extent_dev, extent_flags,
>> +					      extent_gen, extent_mirror_num);
>> +		scrub_free_csums(sctx);
>> +
>> +		if (ret) {
>> +			scrub_parity_mark_sectors_error(sparity, extent_start,
>> +							extent_size);
>> +			break;
>> +		}
>> +
>
> It would be nice to have the entire code above factored in one or more
> functions to make reading the loop easier.

Originally there is a if (ret < 0) check before return, and at there
call the mark_sectors_error().

Since in this patch extent_start/extent_size is defined inside the loop,
making it harder to keep the branch out of the main loop.

But you mentioned this, I'd better move the
scrub_parity_mark_sectors_error() out of the loop, as it's making the
code reading harder.

Thanks,
Qu
