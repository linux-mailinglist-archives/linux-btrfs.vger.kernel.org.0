Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B33D696E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhGZVmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 17:42:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:34825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhGZVmm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 17:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627338187;
        bh=m3rIpSL7e725VGE5Yb83FHDhaDZy5o5eKiHv9/bSrjk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dpu+FoI6mY/TZywhmEOWLndMPfLqoJJ+WaytxDySWm9zcMGDOP/P/8HjYDqNY1AQy
         iR05NxdQdEeoo+oqbssv0n+Ux1EwRgQwUmWWIZnWNOya1dnAlhd5Ma9j9N+ED/xiXr
         +VxKLW7oB49q++cX0GIkXTNZsnsGSXJab7kNGFJQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpOT-1lSCPb1knB-00gDpf; Tue, 27
 Jul 2021 00:23:07 +0200
Subject: Re: [PATCH 08/10] btrfs: simplify data stripe calculation helpers
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
 <41a6c967-1f34-b48a-c24c-14cf226a5c67@gmx.com>
 <20210726150651.GF5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b1af7184-740c-457d-b8ac-daad094ce7cb@gmx.com>
Date:   Tue, 27 Jul 2021 06:23:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726150651.GF5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+6mYV5XIKFTdKzHzaVKYjojGKt6J//n/BrowtNlQBdx6LchYmF
 K2+H5aQUK8OgPphgKzMJwLP2SqyDakWkyt11mmuK3jnte+xvSuAZKNkeJ2Wg2CM3xWMuzbR
 JSk3bvQE21BjB1NEoscnojUgESyQ9d8e2QjJvxuOM9TV38LiTvzE2ekCy+FNhlq2qPfEdOU
 PaPpNJ31gwfCQsyvcxFYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C/HUHtU6ZQ8=:r0+RInz8Kcz2vFmhKOUCDy
 n3ySUXSYGtM5Mnsx4DEgpLDuKnnm7g9lVX6R0nIURBfBtHxI4ph81BJIFSFEeiWqoPYoMqXO1
 YjbAP8VJklctho+mHqoLwm9QFV52aUJw8IVPddUucxaCMYAkTcwdavCVEP63ViaqD402ouYjS
 3pGNu1iUURWVCIasyZTG7jWJxq68l6S1LB3i7vqaHy696tiKKfSM4Lbyig5ep85iwQaPzwhTm
 Zj/y05RGPDWEU2+Jj8CLcFvUS2mrYHsPogu6tS5Eiuqh6tbr6tRbV3tP+W/iPKiOkKOH2L0Gk
 4ENJv207cf4913Dnv0bz9+sHirC0yRdzr7Q8TPAGynuFsAs17XRIn6/lqgEIOHnqCh//6vUAI
 1YdCmTzwcU2hfEPzZVRlB2islYlRSVefqb8vx1HDlHHoGDKqLAR7gwzkZ8JC1KsotxWUyJ4x6
 2rTiFFbuPYwTz3jfdNh23caBrHCfWQGxv/+/AXsD/bjkq3CdKSfsAsHmJfYgJMxID0Yk2V4eU
 YOqtnZnScbA5W3tD8QBudBRWI3iut7ibcH7AkaxV9WdLBjHz4vC6FPJ8TuOFF4vXJ3c9W56Tn
 t9sNWG6jNkRw9sHX6N6mHseISfzCj+ZQjZ2jhOVUCa8oJg/NmSyGozzQiLUM7zckORbwNaSGJ
 JkfooBoSmtjpS6Tmmjd+gAaMc00MQ7gMR1NHoGOnHLdxRRk6pNXn9SMvW0jSd7r7uQB/a5qIq
 UgzkLkUHEtsK6bPL7Y/ilv2zb6R6P4Z82A74EiwpUy9KB4hsK5vbt/moz16LZtsNk5b1UaBPo
 m6/rc38RRHwpJ6NfBP7Qej81rVfz9FJ5eGudkyupksWm8UKSC8GE71X6D56TBG+IHPS8ufISI
 2i2SNltmyCZW9snmR2vv6xsQRd6a7MFiScwZGNeDMwVJA/xGz5cSDM3Un1tueiStNLyAr+G1A
 6if/FYb2QJp9cXwcWv7+DfJVHdPaLEkhkLJanBSgwVgI5YtHrdPzxC4ZASUCAjOFlMrZgRUg+
 3ohSu+Tj3nzJYlCcLTzdItdPGqMmhQwEWrV2rMlD5mUPlXUxLa45nyAXKVymZZ5dOD09ZMkVU
 m9ctX91ooL0qTtIuE1vcV1kixfSKzlANp0w2vD37+QwxaH1UCZwwC3sZQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=8811:06, David Sterba wrote:
> On Mon, Jul 26, 2021 at 08:38:16PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
>>> There are two helpers doing the same calculations based on nparity and
>>> ncopies. calc_data_stripes can be simplified into one expression, so f=
ar
>>> we don't have profile with both copies and parity, so there's no
>>> effective change. calc_stripe_length should reuse the helper and not
>>> repeat the same calculation.
>>>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Just one nitpick inlined below.
>>> ---
>>>    fs/btrfs/volumes.c | 15 ++-------------
>>>    1 file changed, 2 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index d98e29556d79..78dd013d0ee3 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -3567,10 +3567,7 @@ static u64 calc_data_stripes(u64 type, int num_=
stripes)
>>>    	const int ncopies =3D btrfs_raid_array[index].ncopies;
>>>    	const int nparity =3D btrfs_raid_array[index].nparity;
>>>
>>> -	if (nparity)
>>> -		return num_stripes - nparity;
>>> -	else
>>> -		return num_stripes / ncopies;
>>
>> I would prefer an ASSERT() here to be extra sure.
>> But it's my personal taste (and love for tons of ASSERT()).
>
> Assert for what exactly? I had a thought about that too but was not sure
> what to put there.
>

To ensure we have either non-zero nparity with 1 ncopy or zero nparity
with ncopies > 1.

Thanks,
Qu
