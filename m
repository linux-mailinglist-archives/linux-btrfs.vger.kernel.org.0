Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D315530AEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 May 2022 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiEWHqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 May 2022 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiEWHqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 May 2022 03:46:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94784BC39
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653291968;
        bh=CbhB0cPgxiKRA/W83aMbhGRlIgGHQe+xhJLS8ZTJDrA=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=JUfMvLhF5r5LbtQQP/y9BZOfMvax5ovW7wc4wLzRtMi/8hmnzChIBPBNhiIYCdKIi
         GVoKh1AzHxfPHizFIEPymX9/MQWTAYbJSjknVJi3xjSPBcwJDqWN0y6nd5hepE6qa+
         KWYxUxl7cShE4cBKzkVxsQDzZGSd5aiudnrXLnMs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1nO5ao1Hov-00e4ot; Mon, 23
 May 2022 09:46:07 +0200
Message-ID: <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
Date:   Mon, 23 May 2022 15:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
 <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
 <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
 <20220523062636.GA29750@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
In-Reply-To: <20220523062636.GA29750@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r+20Y4y8gGT6P6X/TFuE9cKdRIA/xNtdGG38PwlhFtOHyRpBU5V
 E0Fm9gtiFMkBqn/KdLqyFxTnzbuQWcxphfr7ComVYjhJu5Hlg9eTcPV6ZgAYAfaT1ayS8/N
 J8p9Q9A3wc65FL4xOzteGXqBtPJee3k6AnwupxZL7wMYjD8lFhBuSWur5u7jikB4DUqvEUV
 s305wOv2KKILQKP3YxwWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mkKhOtmEc8o=:4pRt4ATf62JrDr5hw0FKsE
 90Nl9S327QRUTSz0SLkH4PXGgwyaHqQGUsIpUTVyq0gwJTZfNORUXx96qSPym6HCOT5PMR20O
 rPzf+IQH+m/aVH31ebvsgEbzkGBx+3hWl/ebV6Bd0ndEQgXGOqzAi1uG1lJWJUX890d/IFHRW
 K8F+jfx5MUnvY2f3Zh7gEme1x8uaU4AeyquQVEOejqw94Y9ayYcSywCoZLbrxFaxeiBNUZYgI
 VANm6TpZrfCK2ddxTVCr+LGhB3RA2Ibro6WNZ0v/TbXiYBgXQGuMppyME8dYNrq4ElUlwhvZk
 rVRbqH/0Cn9CtY2NWHRQNHalpBEmajvtJ08ySdc9c2CbRwzQFPpKjksfyPVh5mz8esL2FAFVh
 u9MZbhFDgtuBHkmbaGuQ5rDVlZ067+YPHC3M1ZTpKPepWTo4VgsJRxsOHfo0b57IRD8pD/FpP
 LC8p68ul/ZaCbqxFKGmAqqEERKBbQ83WHAEX4j0HxdaasQKkM/D7UF3OH3DZmRBpDgH9B6E6s
 qW9Gp8IpEqIgqoaSYIx2i9hzS1P1Tu6V3+/GgCTi6LmLHniEZ8OQr8Ral5B2fk+7WEwt9m0qe
 VQJYbEF6FhOVZb1PprfYa68m4E1nz44uCHh2YYKGZlL66RMxBL5FmqB3SVzDhZTX1W2BUwdYg
 dRnC841TTtAzRBluA9pJHyk7j8uz3nH+M17cksQ3hon1jH6hlHG78elayJfUcHDbQW+Uxei7M
 /BFATbd43ZSv0IYV3L6h1RN2EtSOvIC1H2cIMMAW6fUV9R75E8DK42+TjeSsyBpQfCbXcPU4a
 fkhxYSGW4o23ZkqpBr1TVK9JGQFW+BEmj6p2HWIwcO+LQYL0cC5/JGffG/XFAJUnxdlfSJQCc
 ZMVHfMOIB4EGRCumVZVZIMbKD2vqtM7nZ5r47G+ymXGw7upoIzgTBUcPwhChW+JKP+Bz21lCX
 r6Ni6YNrDR40LMPgrDj4nyAC6Bsby+GJF4rpI5M96b8J+uUban4Z7ID1X7z1VHNwNbHedrbOF
 s2noo8pfl3ZR1zq9/MOm5U+qAJ3LDwGzJvcT/HphYi2ldr2QmWUqIET5ATRR+kPFB4eaZi/WN
 ZjY+OiL8x1ZCvO2kRMBcjHbDHQD1zif3vXTGMgaw8m46IISXRXKdmxSIw==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/23 14:26, Christoph Hellwig wrote:
> On Mon, May 23, 2022 at 08:07:01AM +0800, Qu Wenruo wrote:
>>
>> I checked the code, but still find the code in patch "btrfs: add new
>> read repair infrastructure" not that instinctive.
>>
>> - Why we bother different repair methods in btrfs_repair_one_mirror()?
>>    In fact btrfs_repair_io_failure() can handle all profiles.
>
> Becasue btrfs_repair_io_failure can't handle multiple-page I/O.  It
> is also is rather cumbersome because it bypassed the normal bio
> mapping.  As a follow on I'd rather move it over to btrfs_map_bio
> with a special flag for the single mirror parity write rather than that
> hack.

In fact so far for all callers of btrfs_repair_io_failure(), we are
always handling things inside one stripe.

Thus we can easily enhance that function to handle multi page ranges.

Although a dedicated btrfs_map_bio() flags seems more generic and better.
>
>>    Then why we go back to write the whole bio?
>
> Because the whole bio at this point is all the bad sectors.  There
> is no point in writing only parts of the bio because that would leave
> corruption on disk.
>
>>    The only reason I can think of is, we're still trying to do some
>>    "optimization".
>>
>>    But all our bio submission is already synchronous, I doubt such
>>    "optimization" would make much difference.
>
> Can you explain what you mean here?

We wait for the read bio anyway, I doubt the batched write part is that
important.

If you really want, I can try to make the write part asynchronous, while
still keep the read part synchronous, and easier to read.

>
>>
>> - The bio truncation
>>    This really looks like a bandage to address the checker pattern
>>    corruption.
>>    I doubt why not just do per-sector read/write like:
>
> Because now you wait for each I/O.

Yeah, that's the biggest performance drop here, that's definitely no doubt=
.

>
>> To me, the "optimization" of batched read/write is only relevant if we
>> have tons of corrupted sectors in a read bio, which I don't believe is =
a
>> hot path in real world anyway.
>
> It is is very easy low hanging fruit,

Unfortunately, this is not that a simple fruit, or I won't go full
bitmap way.

In your current version, the do {} while() loop iterates through all
mirrors.

But for the following case, we will hit problems thanks to RAID1C3 again:

Mirror 1 	|X|X|X|X|
Mirror 2	|X| |X| |
Mirror 3	| |X| |X|

We hit mirror 1 initially, thus @initial_mirror is 1.

Then when we try mirror 2, since the first sector is still bad, we jump
to the next mirror.

For mirror 3, we fixed the first sector only. Then 2nd sector is still
from mirror 3 and didn't pass.
Now we have no more mirrors, and still return -EIO.

What saves our day is the VFS read retry, which will try read the range
sectors by sector, and got every sector fixed.


Unfortunatly we waste a lot of code to hack the bio size, but it still
doesn't work, and falls back to exactly the same sector-by-sector wait
behavior.

So my points still stand, if we want to do batched handling, either we
go bitmap or we give up.

Such hacky bandage seems to work at first glance and will pass your new
test cases, but it doesn't do it any better than sector-by-sector waiting.
(Forgot to mention, the new RAID1C3 test case may also be flawed, as any
read on other mirrors will cause read-repair, screwing up our later
retry, thus we must check pid first before doing any read.)

Thus it's a low hanging but rotten fruit.

Thanks,
Qu

> and actually pretty common for
> actual failures of components.  In other words:  single sector failures
> happen some times, usually due to corruption on the transfer wire.  If
> actual corruption happens on the driver it will usually fail quite
> bit areas.  These are rather rare these days as a lot of device shut
> down before returning bad data, but if it happens you'll rarely see
> just a single sector.
