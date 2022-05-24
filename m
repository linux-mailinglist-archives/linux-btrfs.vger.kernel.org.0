Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A7532525
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 10:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiEXIV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiEXIVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 04:21:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796813818F
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653380503;
        bh=9Qu9nN7CMU7n2brIGDtQTW3KE7ohnxN17+e2yMbExvw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iMYppwtPBe/VlC/l/TyxU590tWELhYr9EQx9icAxzo+lMNJB+1en1o2j64EXIiezZ
         1lzwr/StIOPJn2obkdR6d8XnrgTVsLfj+o8QksV+tHtaW1YRATRc6691YAIvv4Df3D
         2/R/AftJQCiF9q/DlNVjQpvCbM1uKi9+xIvGXHEc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQjH-1o3bsR2jEr-00GsIE; Tue, 24
 May 2022 10:21:43 +0200
Message-ID: <b78b6c09-eb70-68a7-7e69-e8481378b968@gmx.com>
Date:   Tue, 24 May 2022 16:21:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
 <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
 <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
 <20220523062636.GA29750@lst.de>
 <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
 <20220524073216.GB26145@lst.de>
 <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1pWBI9LZGtvmBcOcSfICgDtYVBrFySWe3LxQcZnTHKkKIQVNrcU
 XAnrxaGSqeGJ/FQ/1HxWk308qiOBEExmU92wzO9pqW4cBXo7P//rvYZN65SDL3r+z86/sSy
 qqqD1C0VBzqug4ZfpYBq7JJAyGjccdrSHuoj74tW8Nv9u1F7lU2YGk9vS9evU1E7tMwWArJ
 HhexMdyAuEt0TXwhaIPOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dw9ZoqVxSF8=:zfwet2YzetQMV1HlfeifUj
 QV5mkD9TF5smWLXhAbNq56KVoEBy2kMVyBdvnxEY+GVLnTvSEUsPbrJ+DarDbHpr2mf8T5CfI
 hUJ1/zEm0qf1WZESOp66u5NTvYoRYt7N5NC7n+TQpk1JqOGsJ1Y81nFcHoovDbKr/CrN83IxM
 lBduazb+kc8B837pk+535hivKY7lgUz/lCFLf0mKB+omFrrnILcBPBoZ5eCVWS6GCW/P4g1kl
 pr2OJIPjC7JYd5gpCjbm0c4y60rdm+FsqD7bi/6qU60yDAo+XB72gm1VbUsjiIaBGhEnFRvx6
 YLIoQFXWhzthW2wrz0082+7Gz26S8Y2KvWu6McGn2ru9b1ZdWXyXis5ayJ5GdCjFepsp3aaaj
 tSBdl8zNqb+RsCnAj12jLPcz0uHbNLD/jlR4SbIVco0z0YIo8aRjY+aCUIarZn2M0M9gK3dJf
 X38BzSL/+bzwPDcE1nQiN4KKizhPau7dVFCd2GM8gaF21H68e6xxcoVqs7Q1NhD4kIw6p1bqd
 5tYbLF9M80DmVol3LSfo/inVpQAgH6a24VVBGR3D7mhYkS8qJMK8vvDkhnH8tI2zJPMp6R+tB
 T7KHQObD0RWXQVFn5mAQ83xOsly9HYp0PzqfNnAFLJ31C3OK70BPISvpf4kgOuEkT1RUeanwi
 hh9smA2TLELVAlj7aXge+WkI/sx/U18A7Yft+8WzlaAqDeIryNID0u/j90eSqD3N4PrsqDk2K
 MYMP4jl36fKFY7rCscGa8w176YU8d0cxktkl+BoKMjsMbOTH3qI0ucH5G8jrGzJXj+IFc88iN
 V9Wwas2iRg3DOSJP9irinDsFpAYffNQbUH+1EI4yYLK7agkddm7yt8CCyR2yO7G2xhhJYywQh
 QVhHTkvD6pMWCDhGwGm1KWslNrm1Q/3ohZkPmJaVleYedqfnzWFURPqy+iAWfDjlK1acaWeHv
 blRpX6U5+wbnuFFt6FFr8/Bj2nYwCGFJ7bxNkFyaOMgQ2wzyUuDFgjBd5TM3kWCYFygMVKA4u
 yCd26FrgqrSVP5PLiWe5f4WJyBnEYKqBTq84n44CWJZ9zWskvHC4y1fcHAu43C7RQ0GIcQtWR
 UmafISvQBlm9Yv6L9hhMUTh9kR91MH8fVt8Fo0xTjQ5XV7BkkYpK233fw==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 16:04, Qu Wenruo wrote:
>
>
> On 2022/5/24 15:32, Christoph Hellwig wrote:
>> On Mon, May 23, 2022 at 03:46:02PM +0800, Qu Wenruo wrote:
>>>> Becasue btrfs_repair_io_failure can't handle multiple-page I/O.=C2=A0=
 It
>>>> is also is rather cumbersome because it bypassed the normal bio
>>>> mapping.=C2=A0 As a follow on I'd rather move it over to btrfs_map_bi=
o
>>>> with a special flag for the single mirror parity write rather than th=
at
>>>> hack.
>>>
>>> In fact so far for all callers of btrfs_repair_io_failure(), we are
>>> always handling things inside one stripe.
>>>
>>> Thus we can easily enhance that function to handle multi page ranges.
>>>
>>> Although a dedicated btrfs_map_bio() flags seems more generic and
>>> better.
>>
>> I did think of moving btrfs_repair_io_failure over to my new
>> infrastructure in fact, because it seems inherently possible.=C2=A0 Jus=
t
>> not the highest priority right now.
>>
>>>> Because the whole bio at this point is all the bad sectors.=C2=A0 The=
re
>>>> is no point in writing only parts of the bio because that would leave
>>>> corruption on disk.
>>>>
>>>>> =C2=A0=C2=A0=C2=A0 The only reason I can think of is, we're still tr=
ying to do some
>>>>> =C2=A0=C2=A0=C2=A0 "optimization".
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 But all our bio submission is already synchronous=
, I doubt such
>>>>> =C2=A0=C2=A0=C2=A0 "optimization" would make much difference.
>>>>
>>>> Can you explain what you mean here?
>>>
>>> We wait for the read bio anyway, I doubt the batched write part is tha=
t
>>> important.
>>
>> I still don't understand the point.=C2=A0 Once we read more than a sing=
le
>> page, writing it back as a patch is completely trivial as shown by
>> this series.=C2=A0 Why would we not do it?
>>
>>>
>>> If you really want, I can try to make the write part asynchronous, whi=
le
>>> still keep the read part synchronous, and easier to read.
>>
>> Asynchronous writes gets us back into all the I/O completion handler
>> complexities, which was the whole reason to start on the synchronous
>> repair.
>>
>>> In your current version, the do {} while() loop iterates through all
>>> mirrors.
>>>
>>> But for the following case, we will hit problems thanks to RAID1C3
>>> again:
>>>
>>> Mirror 1=C2=A0=C2=A0=C2=A0=C2=A0 |X|X|X|X|
>>> Mirror 2=C2=A0=C2=A0=C2=A0 |X| |X| |
>>> Mirror 3=C2=A0=C2=A0=C2=A0 | |X| |X|
>>>
>>> We hit mirror 1 initially, thus @initial_mirror is 1.
>>>
>>> Then when we try mirror 2, since the first sector is still bad, we jum=
p
>>> to the next mirror.
>>>
>>> For mirror 3, we fixed the first sector only. Then 2nd sector is still
>>> from mirror 3 and didn't pass.
>>> Now we have no more mirrors, and still return -EIO.
>>
>> Can you share a test case?
>
> Unfortunately no real test case can work here.
>
> The problem is, VFS will try to re-read with smaller block size.
> In that case, fallback to sector-by-sector repair, thus even if we have
> some policy terribly wrong, as long as the sector-by-sector behavior is
>  =C2=A0fine, it will be hidden.
>
> That's why when I do my bitmap version, I have to add extra trace events
> to make sure it's not the retry, but really my read-repair code doing
> the correct repair, without triggering the re-read.
>
>> =C2=A0The code resets initial_mirror as soon as
>> we made any progress so that should not happen.
>
> Oh, didn't see that part.
>
> And in that case, yes, it will work for the checker pattern, although
> not really any more efficient.
>
> We will do 4 different reads to fix it, no better than sector-by-sector
> repair.
> And worse than 2 reads from the bitmap version.
>
> But I get your point, it can handle continuous corruption better than
> sector-by-sector, and no worse than bitmap version in that case.
>
>>
>>> So my points still stand, if we want to do batched handling, either we
>>> go bitmap or we give up.
>>
>> Why?=C2=A0 For the very common case of clustered corruption or entirely
>> failing reads it is significantly faster than a simple synchronous
>> read of each sector, and also much better than the existing code.
>> It also is a lot less code than the existing code base, and (maybe
>> I'm biassed) a lot more readable.
>
> The problem here is, yes, you can pick the common case one, but it comes
> with the burden of worst cases too.
>
> And for the readable part, I strongly doubt.
>
> The things like resetting initial_mirror, making the naming "initial"
> meaningless.
> And the reset on the length part is also very quirky.

In fact, if you didn't do the initial_mirror and length change (which is
a big disaster of readability, to change iterator in a loop, at least to
me), and rely on the VFS re-read behavior to fall back to sector by
secot read, I would call it better readability...

Thanks,
Qu

>
> Yes, my bitmap version is super complex, that's no doubt, but the idea
> and code should be very straightforward.
>
> Just loop all mirrors until the bad bitmap is all zero. No need to reset
> the length or whatever halfway, bitmap and mirror number is the only
> iterator.
>
> And even for the bitmap preallocation failure part, we have VFS to bail
> us out.
> And code wise, it's not that simpler, if you ignore the bitmap
> pre-allocation part...
>
> And for the ultimate readability, the sector-by-sector method can not be
> beaten.
> Thus I'm not a particular fan of any middle ground here.
>
>>
>> Bitmaps only help you with randomly splattered corruption, which simply
>> is not how SSDs or hard drives actually fail.
>
> But that's the case you have to take into consideration.
>
> Even for cases where real world SSD to corrupt a big range of data, we
> can still submit a read that crosses the corruption boundary.
>
>>
>>> Such hacky bandage seems to work at first glance and will pass your ne=
w
>>> test cases, but it doesn't do it any better than sector-by-sector
>>> waiting.
>>> (Forgot to mention, the new RAID1C3 test case may also be flawed, as a=
ny
>>> read on other mirrors will cause read-repair, screwing up our later
>>> retry, thus we must check pid first before doing any read.)
>>
>> The updated version uses the read from mirror loop from btrfs/142
>> that cleverly used bash internals to not issue the read if it would
>> be done using the wrong mirror.=C2=A0 Which also really nicely speeds u=
p
>> the tests including the exist 140 and 141 ones.
>>
> That's wonderful.
>
> However the smaller problem is still there, we have no way to know if
> it's the read-repair itself does its part correctly, or it's VFS retry
> saves our day.
>
> But yeah, btrfs/142 method is much better and should be backported to
> btrfs/140 and btrfs/141.
>
> Thanks,
> Qu
