Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE14C28A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 10:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiBXJ5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 04:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBXJ5t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 04:57:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7317070;
        Thu, 24 Feb 2022 01:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645696617;
        bh=C332AhrDIlzT/2XoIViHK7bqj7AuxbydaVZvJnTmdTY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=hJUDoDIkTmmgyqDMp8CywHnVIVZ3QH2hSBdSRJ/Bj1cIMUHXRaCP2kzsxKQf3KqpU
         +zXZdIV1+07BbWCj5OMsQQ1DItLvef4gmAzMCPw7evTwyJa2O0IsHi2jhWsRJhGbuW
         bEZmbU62/9JcQIJRHCH52WlWTwprii0DJ5E6+Hg8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1nuqze24EY-00b2BT; Thu, 24
 Feb 2022 10:56:57 +0100
Message-ID: <205e5941-6ae0-0482-b083-874daf0e5a46@gmx.com>
Date:   Thu, 24 Feb 2022 17:56:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Yujie Liu <yujie.liu@intel.com>, Qu Wenruo <wqu@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        dsterba@suse.com, nathan@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
 <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
 <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
 <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
In-Reply-To: <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y3w1cSk5CyKdUvcBcH7SHZzqBGO/AIkIUDmfQ9EPXDacHy9yCkt
 iWTDFG9uPyOGG1CPtqA9esJUdBnRE2wgJjaTjEslssQMomDhUs6xOpBzM8xva9tuPsgzwmn
 aQ6hrmpUtRXDR6v2FS9fWTI7nUE+N1dU4/0vKJsiu4JcEQCVv0M3ZqwUMurYcTYXV34MdR1
 t1UBkDFYBapvZeJbgLNEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CbhHkVsKYkI=:DQAbSz6tP7yo27vVEv4KXt
 hvq+4l5HUVTtY6s00/JFu/ScxELHHs0dbAOr1/9rJ9p9PA0+M+oQuTrIwAG+GJlIH/aFwt/So
 nJ6NelIwIsDTPT07YPhnbRxYrGIL+/U1LPw5hR3t81/Ob1Adw7PA/8If/cf/O7Qu9NhMBfHXM
 gROkD9sUW7kxM/RMgPq8mRGADR+t2UG+07kNTcf7RJYPz5oDA+mzRHvblLXPDl9BkZixP3A7P
 +cFqX2NBSOUNsp8YG7T0j1ZGoX937LRl+hjO2UHB5iMg0bNgCYpGwGdCxRR1dbLDPMvqelXRd
 xbQZRCfxdV4d2xh2okzc1JBapcRQ7+oq4WwHCYBlYqPipT4vEDGY81V08da+O9oHYbC3gTM+V
 2pFEpzyGVxTDSCGzF4y/DocAI5a1sxjHro75/yOIOjk56WWXfjBxXVJBBGaOeUNH9/MJtDGFh
 FY6wvRToF9BG8pz+pDPtZTwSMurj7AD6O5M8kF797CKoda1P6ZLhf/20xD2NiwVxjyaLaebEe
 24gl7XyMASYCePg9NoL3Nf1sCtZ/soPmGH4vlI0swDF3b7NI/ydZrpthqi2x/tEDKATTVk5W8
 VHTCJUCF9ShkwxqWQb8BUT5DxFdIuCta5KnK2DLGkCPiGMUgmcwDMByLrUpKL1Pcl8bNsUCD5
 L5iVU49GThrr17KYHtHmZ9ZnIFbSOSvP55/utbicc9W1CDTvRH8XD76LjXvW57chSi3Apfa4N
 g/rNA6afPA/O9O4o5VWkAOv998SmxkPEFVgwWfTDfONbiRVhvT7yOWg74+XOLFJAvGM2VEjFq
 9We4p8P3uLYYtIY2XOtc1phZfcwtlHlwOvd2K1EbQuHQdpsJrSyOzTUnhZOvq4+YZNBz72SGO
 CGh6zf7s3E3pGXjmzHOBEyMdr2IPi2zmnQxyid3TdnAjkEZST2GG0NzKOjuDc66rTi8G1XXeS
 U8fo3tegY07Uv8tVBsaYo1c5YVbeIUuL/GIao5tRht86M18Lb/BH1wjgS7OXBgoGnB/0eTD+6
 W/5mjOJvz2Sl8zFK8W6jzpqPAIq8O3Vlzi2sTpiCPB5bXqOGmt4+GdXBQlL9clfw4XeU+e7w9
 ob6skbFR+w2eKk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/24 17:48, Yujie Liu wrote:
> Hi,
>
> Sorry for the noise of this false alert.

No problem at all, in fact your bots are awesome detecting real bugs
like previously it detects some uninitialized values from my patches.

Kudos to your guys!
LKP bots really rocks.

>
> For clang analyzer reports, usually we do internal check firstly. We'll
> send out the
> report only when we think that it is highly possible to be a true alert.

BTW, do performance benchmarks also go through the same procedure?

Although your bots are awesome at detect compiling warning/errors,
sometimes it's not that straightforward to reproduce the same
performance regressions.

So it may be worthy some extra steps to verify certain performance
regressions.

Thanks,
Qu

>
> We scanned our report history and found this report was produced on
> 1/26, but it was
> still in the internal check domain and was not likely to be sent to Qu
> or mailing lists,
> so we are kind of confusing about this consequence.
>
> Souptick, could you help to provide the original report by link or
> attachment?
> Then we can do some check to figure out whether we have any flaw in our
> process.
>
> Thanks,
> Yujie
>
> On 2/22/2022 16:04, Qu Wenruo wrote:
>>
>>
>> On 2022/2/22 15:50, Souptick Joarder wrote:
>>> On Mon, Feb 21, 2022 at 5:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/2/20 22:46, Souptick Joarder wrote:
>>>>> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>>>>>
>>>>> Kernel test robot reported below warning ->
>>>>> fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
>>>>> returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
>>>>>
>>>>> Initialize ret to 0.
>>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>>>>
>>>> Although the patch is not yet merged, but I have to say, it's a
>>>> false alert.
>>>
>>> Yes, I agree it is a false positive but this patch will at least keep
>>> kernel test robot happy :)
>>
>> I'd say we should enhance the compiler to fix the false alert.
>>
>> Thus adding LLVM list here is correct.
>>
>>
>> To me, the root problem is that, we lack the hint to allow clang to
>> know that, @logical_length passed in would not cause u64 overflow.
>>
>> Unfortunately the sanity check to prevent overflow is hidden far away
>> inside tree-checker.c.
>>
>> Maybe some ASSERT() for overflow check would help LLVM to know that?
>>
>> Thanks,
>> Qu
>>
>>>>
>>>> Firstly, the while loop will always get at least one run.
>>>>
>>>> Secondly, in that loop, we either set ret to some error value and
>>>> break,
>>>> or after at least one find_first_extent_item() and scrub_extent() cal=
l,
>>>> we increase cur_logical and reached the limit of the while loop and
>>>> exit.
>>>>
>>>> So there is no possible routine to leave @ret uninitialized and
>>>> returned
>>>> to caller.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> ---
>>>>> =C2=A0=C2=A0 fs/btrfs/scrub.c | 2 +-
>>>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>>> index 4baa8e43d585..5ca7e5ffbc96 100644
>>>>> --- a/fs/btrfs/scrub.c
>>>>> +++ b/fs/btrfs/scrub.c
>>>>> @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct
>>>>> scrub_ctx *sctx,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 max_length =3D SZ_64K=
;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D {};
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cur_logical =3D logical_sta=
rt;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The range must be inside the=
 bg */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(logical_start >=3D bg->s=
tart &&
>>>
>>
