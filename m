Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8569558E8A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiHJIYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHJIYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 04:24:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3121E84EF6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660119861;
        bh=IFE9oNSz+KOVvevbKcoO5+d1nAyMaeKPlJqWnp4GEjg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=RcSZHlUCUv892UyBK5h6yCuHpThDpwD1l6ajEp+fP6/UshOk1BnGAYWBtPm4DmTgn
         5d6FbGvoygUpdBxzP4s5/25aITp0YSTQu8r72X+NkxuG9HICD9d0PQt8JQpd+mZNPw
         mSv+3BunDlDsX0VTAT9BXwu5tvdoS5mpe6KvgPpM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wLZ-1oIfnz3u1L-007TzB; Wed, 10
 Aug 2022 10:24:21 +0200
Message-ID: <8015f630-3dc9-4655-3e30-5d241af3e0bc@gmx.com>
Date:   Wed, 10 Aug 2022 16:24:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     kreijack@inwind.it, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <d3a3fea9-a260-dcdc-d3a0-70b1d1f0fb2d@gmx.com>
 <YvK1gqSvQRi0B+05@hungrycats.org>
 <9f504e1b-3ee2-9072-51c7-c533c0fb315f@gmx.com>
 <92a7cc01-4ecc-c56a-5ef4-26b28e0b2aae@libero.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
In-Reply-To: <92a7cc01-4ecc-c56a-5ef4-26b28e0b2aae@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJTaSNpplt31GV0kcu38xY1oKTq+iwRLCJtdNEV9ePBAQpcfknG
 jIG6L4yVo6ppJLmjUqHzGmsA3EY8DYVIwvlk5n4HEain0D9LyBYsrk7nXyDw8Sy8a47++OB
 dlowScrC4dTBIJw917R/pBPppyyw0tUxMnyegmRu+49Eb0/JI8nybKW6e90l8iBVnIilOm/
 SAL4VmQaCt8nniI9YfZEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JFtenMjzGjo=:GvijgEnLeDy5Jk4GEjDG5u
 eCJt0mZLSsuaBRRCmV8CbYzV535esHoUV+dRz6OgA6D3uGDImOlrmlqJcJehZUg1DwJIIt4t/
 OdywuyBG8JjI71HRyD5AeK3sJXztl3mbYEsuWD4Ek/rtTN0snj02p2ZB4tQSVuZVUGjgcVkR2
 oXNgVBT+RKYu+8Nhgqzy+eiWgfQABVAzv9bcifEmlW6QOyf4L9xu/pVyuFG2kYHsN2m6jCdjV
 1LisioM0dqHubrl4qpXFwsrj6hGaT1GMoBk7780iHL73Hn2GzuNWJfNEd5wq61uMiUya7ieLM
 JPod9IBKdFtN/Wb2Bpjbrj1XbOHWKLiM1Xh5za+u+kNBzniBExnpv3bc8R0Q2rrcVYbSKiZZA
 gYMG0VtFrqjR0skNG8C2i6kBmbZgHUmklUkos1Auz0eZwwOmwFEEu5Dys65vKfNIwrmp1dQio
 HgWc454YFgcIEWbAQf4eFtQZIit2yekjDZDfaY5A5UvTWwbWZUkvhTVlEkJJe8YC5m+6qpDfW
 JKD9NEuQeGsoirLii7NbqyaVmfXWlFkPEiV5nsoDoxgRPOL5SBf66GwSh2KiJ6YJ5O35C/mMt
 21rbbK5i5NBnKbvXtFKRzEmKEB6POp08Y6NV4mGsdJvl+f1Y/kIFRo67avIPohQoG/ljitpbl
 zKqqXhWun8mPIFKVcOVdqhpVV3gX9h5Zfguw+jYdoo6MwP0Eyv3vvKLR8JzEfuL59oIOf6wLv
 60XeWIrCZ2Abmp0dqi4SkyJI0XZMq53ANuuW0SeC0qHoAkVg+i5vp7uiVcHcZM9syh1YZiO75
 5gD+fyVT4Q/NXdSQroTBwfUJZsapY/yyPRGt5qzwFTy7hhb435W3liFJewDrYgJdhSFa2PUX2
 m2nqkNNaj2RVEVzHBfIsBlpPneMtf9JKWmRf8C1qetQ2JZiTxuyuznw8OXXGhGQSu6mduu/Y4
 g3zT+10B0xtkN0baMtchO3HfWe7dOXIk7gqUS6K+Hr4pZpeKS1cb81h4hyrsu177qeMwrMYP9
 zaimNupZnG5k/Lw2tCu+tKM2vPeY9sHhAzuywhha21+Wjasc6fZRsIC/wvUx/9Lqm/ggfsY9O
 jDlmjCQXMmsgiKSmJc3PNszeAQCSsAYgsInN1KisFMYADup8EvaD3+ZBA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 16:08, Goffredo Baroncelli wrote:
> On 09/08/2022 23.50, Qu Wenruo wrote:
>>>> n 2022/8/9 11:31, Zygo Blaxell wrote:
>>>>> Test case is:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0- start with a -draid5 -mraid1 filesystem on=
 2 disks
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0- run assorted IO with a mix of reads and wr=
ites (randomly
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0run rsync, bees, snapshot create/delete, bal=
ance, scrub, start
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0replacing one of the disks...)
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0- cat /dev/zero > /dev/vdb (device 1) in the=
 VM guest, or run
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0blkdiscard on the underlying SSD in the VM h=
ost, to simulate
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0single-disk data corruption
>>>>
>>>> One thing to mention is, this is going to cause destructive RMW to
>>>> happen.
>>>>
>>>> As currently substripe write will not verify if the on-disk data stri=
pe
>>>> matches its csum.
>>>>
>>>> Thus if the wipeout happens while above workload is still running, it=
's
>>>> going to corrupt data eventually.
>>>
>>> That would be a btrfs raid5 design bug,
>>
>> That's something all RAID5 design would have the problem, not just btrf=
s.
>>
>> Any P/Q based profile will have the problem.
>
>
> Hi Qu,
>
> I looked at your description of 'destructive RMW' cyle:
>
> ----
> Test case btrfs/125 (and above workload) always has its trouble with
> the destructive read-modify-write (RMW) cycle:
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 32K=C2=A0=C2=A0=C2=A0=C2=A0 64K
> Data1:=C2=A0 | Good=C2=A0 | Good=C2=A0 |
> Data2:=C2=A0 | Bad=C2=A0=C2=A0 | Bad=C2=A0=C2=A0 |
> Parity: | Good=C2=A0 | Good=C2=A0 |
>
> In above case, if we trigger any write into Data1, we will use the bad
> data in Data2 to re-generate parity, killing the only chance to recovery
> Data2, thus Data2 is lost forever.
> ----
>
> What I don't understood if we have a "implementation problem" or an
> intrinsic problem of raid56...
>
> To calculate parity we need to know:
>  =C2=A0=C2=A0=C2=A0=C2=A0- data1 (in ram)
>  =C2=A0=C2=A0=C2=A0=C2=A0- data2 (not cached, bad on disk)
>
> So, first, we need to "read data2" then to calculate the parity and then
> to write data1.

First thing first, the idea of RAID5/6 itself doesn't involve how to
verify the data is correct or not.

Btrfs is better because it has extra csum ability.

Thus for bad on-disk data case, it's even worse for all the other
RAID5/6 implementations which don't have csum for its data.

>
> The key factor is "read data", where we can face three cases:
> 1) the data is referenced and has a checksum: we can check against the
> checksum and if the checksum doesn't match we should perform a recover
> (on the basis of the data stored on the disk)

Then let's talk about the detail problems in the btrfs specific areas.

Yes, it's possible that we can try to check the csums when doing RMW for
sub-stripe writes.

But there are problems:

=3D=3D=3D csum tree race =3D=3D=3D

1) Data writes (with csum) into some data 1 stripes finished

2) By somehow the just written data is corrupted

3) RAID56 RMW triggered for write into data 2

4) We search csum tree, and found nothing, as the csum insert hasn't
    happen yet

5) Csum insert happens for data write in 1)

Then we still have the destructive RMW.
Yes we can argue that 2) is so rare that we shouldn't really bother, but
in theory this can still happen, all just because the csum tree search
and csum insert has race window.

=3D=3D=3D performance =3D=3D=3D

This means, every time we do a RMW, we have to do a full csum tree and
extent tree search.
And this also mean, we have to read the full stripe, including the range
we're going to write data into.

AKA, this is full scrub level check.

This is definitely not a small cost, which will further slowdown the
RAID56 write.

Thus even if we're going to implement such scrub level check, I'm not
going to make it the default option, but make it opt-in.

Although recently since I'm working on RAID56, unless there are some
possible dead-lock, I believe it's possible to implement.

Maybe in the near future we may see some prototypes to try to address
this problem.

Thanks,
Qu


> 2) the data is referenced but doesn't have a checksum (nocow): we cannot
> ensure the corruption of the data if checksum is not enabled. We can
> only ensure the availability of the data (which may be corrupted)
> 3) the data is not referenced: so the data is good.
>
> So in effect for the case 2) the data may be corrupted and not
> recoverable (but this is true in any case); but for the case 1) from a
> theoretical point of view it seems recoverable. Of course this has a
> cost: you need to read the stripe and their checksum (doing a recovery
> if needed) before updating any part of the stripe itself, maintaining a
> strict order between the read and the writing.
>
>
