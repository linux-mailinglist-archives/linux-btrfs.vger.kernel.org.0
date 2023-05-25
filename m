Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8F711A90
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 01:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjEYX0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 19:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYX0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 19:26:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B329E7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685057185; x=1685661985; i=quwenruo.btrfs@gmx.com;
 bh=sxDXZR7QIok0ars9CAtrClsEbcZBUEA9F3ftvYc7hpM=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=O0KQzbrDBRm83EnLJrJjh1vl7LSsstYveHDAbqWxWxCGWVp5x+rxOG6cIywqCTltXRRMJXU
 +dGzB/xxJ4czWjf6oMNzrMN1lRQooXaG4/78eGdMWPz8duDYMrrGozbsovTVZZaJhryb4AsyX
 c25r2ZfzNmVAOeqc+YfsBshO97R3uEZTZDXFmgXyKV7rJH9PM3t1U8sw1LnS2fJJfqPW1HMiz
 f7Hq5khniXls+Q3rtrTH05goXFBmOC8w3MA4F/7ctw1IbGFHcKIrK2+YpA6OPLzQ4unsIP/6j
 ajB/uKDnZAzWWM3KY4qp0/XH8Sx3EQRf+ocGjdnTrIhl9fgx0NZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTmY-1peaQh0VnS-00WVru; Fri, 26
 May 2023 01:26:25 +0200
Message-ID: <30ccb91f-7a08-a1d4-b3b9-437c7830c6e9@gmx.com>
Date:   Fri, 26 May 2023 07:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <232abb666a6901f909aeb21dc6f5998f0250e073.1684967923.git.dsterba@suse.com>
 <58561722-bb40-ffd5-0154-b466810c4cf0@gmx.com>
 <20230525230028.GL30909@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 7/9] btrfs: drop NOFAIL from set_extent_bit allocation
 masks
In-Reply-To: <20230525230028.GL30909@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I//wAgcjLh0Um+UzT4rA9hyyaZzN1Ir9IPfgIYXz99tX4+4WJLO
 9gQ2ab07uI3NnyHuktRGSPEHd710VfWRzNcHjRefSoDbbK+hdCpy+FiTmCtDS6d+UtV75Nm
 lndUhU4+bfYJz/DrJ8mN07/hSV49RoPJGQuHK6NEyESFRgRQpx9Y+Gz4wcJ7Z5mIhOYjZpc
 A3sO1qnNWL4VPE9V4Of0g==
UI-OutboundReport: notjunk:1;M01:P0:wbEW0HOuuj4=;AMcQu/qeZPIAEZ0x+wObRySAtoz
 9mPjY4HnfO0JdilKu6rvhiCoLbHfrjhDbUS4EWOncRuGUqRfjyk/KFy1em48Z7yrDERHmFqPB
 MUpzcJ0c+C1cuDLqbllMoX2qEYFom0Jco/YoErfq65GpcxPWkoB9ZF6pgpzLapWUiPwUK9tqp
 he0N4a3+/PjVa44fXbHbKHT7quzYKzEC4eeav1IizNrPYVnG9FDQ5PlOu/ebfS3uPzkkQpJRj
 lMIup1A2JcEvkpcm04OVQA9op8VNlFqoNOED5xw/5SIaxS/6Il/Bbkb9uO0yUW62xVxtyreBm
 nErJGIjB98H+jCDCmsRsU+OwWn3TfxxK/iEdcCqo81CuPmOnL+S7s01kyqxpKDa4StnaotdXO
 CRHzHX1AOauUH53Npq7hef0OIzQSkf8yjcA0iD2T12Mu6FfY/gFuFJ56N0yrl3CJlcK0ge/gX
 3WaVQad2/Wg8jvKLeK1j+JE/Nqxvb+x62CSQxgNyqWQPPgke1bI3yjJBQnbFoyqMzZ96nyfk3
 cfvnMGQjTCBY22rCmR9GrYeW67o8+I4o+M6JLxXGOZ+jTdkhidx3AmUg7qxNo9/YcqD09UJT6
 2lfeZ8cp9T5/DL+3nBZ1kRuQqA1t9ARt9egJi9T3HOXBZ1dFIkPOWUOXPfDVhU5Phe8Fa9f27
 6zGrkErLj9drPJiPa2lWh7kpvcIDw7N65NvDs6lFJUwyGOGrxqhr/S/pZiAXi0j4ygGg7/2k1
 cupwjp4okb9/I3iVh6QhXzOofVY9hSEwjdRf6k+tY/Eu2x89GkipM5ZnvfIXe6M3RJmhEVKTk
 6qb1Q4s4zfcl9Ki+N0lIGJ4aS7+Y0hHwcYwhNkhXBW8120MEv4h6APdE8kx25A9fSMcIOJILa
 p1ksjtZXucN6qagWI9O2069d8lF+Ze5kwBk2RocQHMJiQygzN6zrgGjJtwslid6QyFZLSUzzN
 kmUceosy1WWm0tmnjroQ94GujDQ=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/26 07:00, David Sterba wrote:
> On Thu, May 25, 2023 at 06:38:51PM +0800, Qu Wenruo wrote:
>> On 2023/5/25 07:04, David Sterba wrote:
>>> The __GFP_NOFAIL passed to set_extent_bit first appeared in 2010
>>> (commit f0486c68e4bd9a ("Btrfs: Introduce contexts for metadata
>>> reservation")), without any explanation why it would be needed.
>>>
>>> Meanwhile we've updated the semantics of set_extent_bit to handle fail=
ed
>>> allocations and do unlock, sleep and retry if needed.  The use of the
>>> NOFAIL flag is also an outlier, we never want any of the set/clear
>>> extent bit helpers to fail, they're used for many critical changes lik=
e
>>> extent locking, besides the extent state bit changes.
>>
>> As I mentioned in the cover letter, if we really want to set/clear bits
>> to not fail, and can accept the extra memory usage (as high as twice th=
e
>> number of extent states), then we should really consider the following
>> changes:
>>
>> - Introduce hole extent_state
>>     For ranges without any bit set, there still needs to be an
>>     extent_state.
>>
>> - Make callers to pre-allocate 2 extent_state and pass them as mandator=
y
>>     parameters to set/clear bits
>>
>> - Make set/clear bits to use the preallocated 2 extent states
>>
>> By this, we should be able to completely get rid of the memory
>> allocation inside the extent io tree set/clear calls.
>
> I did not understand what you mean from the cover letter comment but now
> I see it. The size of extent_state is 72 bytes on release build, which
> is not that much, doubling that size is still in acceptable range even
> if we'd never utilize the preallocated memory at some point. That we
> dont't see any failures now is 1) GFP_NOFS does not fail 2) we're using
> a slab cache and the objects get reused within the same allocated space
> due to frequent state changes. Even if 1) wasn't true we'd still have to
> hit a hard memory allocation error, i.e. no available pages for a slab
> extension.

Well, I still remember an internal bugzilla that openSUSE on RPI4
triggered failure at the extent_state allocation.

>
> If the preallocation prevents any failure due to memory allocations then
> we can keep the current way of dealing with extent bit change error
> handling, i.e. none because we rely on the allocator.

The preallocation is not going to help much after the first allocation
is being used.

After that, all later states are allocated using GFP_ATOMIC, which has a
much smaller pool to fulfill from.
And considering how many call sites don't check the return value at all,
we'd either go forward changing all call sites, or really make the
set/clear bits bulletproof (and only fail out of the set/clear call).

Thanks,
Qu
