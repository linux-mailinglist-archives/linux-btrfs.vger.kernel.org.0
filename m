Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D07581D49
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 03:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiG0Bo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 21:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiG0Bo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 21:44:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C0120BA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658886253;
        bh=5PvVzfbj0Vkv/kAYmc43dxzntf1qapwlz9dwpXonOPs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=V+qa8TFhelBYrvXPTOiXoh2BMSSN0+Gxqnoq4cGvUiYi19JnavtWcN7eE8yrIGVbh
         dXRKTqJdAATX5fmE2Pne9oNDYaDMQPNrLpeVqW2jMTGsKkc8q1pztcH/HIAabwCmUr
         HUbbeuBoS0ZkhV4x2ORoSb++8ORhPAy529QV+qM8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAh0-1njNCO436e-00bdY7; Wed, 27
 Jul 2022 03:44:13 +0200
Message-ID: <59e228e2-9927-56a1-5fac-ab6b7e49451e@gmx.com>
Date:   Wed, 27 Jul 2022 09:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Boris Burkov <boris@bur.io>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
 <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
 <20220726181353.GJ13489@twin.jikos.cz> <YuBUTX1i63o7Uo1O@zen>
 <20220726213928.GP13489@twin.jikos.cz> <YuB238MyKE0VTDtq@zen>
 <a33107a0-1207-7b56-39f4-1465a74f8fe3@dorminy.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a33107a0-1207-7b56-39f4-1465a74f8fe3@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZsnmBSIG3ijLg78Tinhb+V3jYgD/STsxJPUCaxjFdkfw36hm5SW
 w2wBUpFuG4Njgrm4Q39oFFY75QDWcS36mO69hnego9zvOvlpLocudtxX93gKH7ZZewGcwUn
 DFD14HhEgvnkw8ukJUNvD5PXvK6E0C0Ipbovfb0Gd6RQaDUEK7fo6+y97mIn4EkDv9BI8un
 MfuJVs9uVQ0EM9qo09iow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u3uzcIfdxtM=:/kB2AQ3CZGxkDOZ/SvMaLS
 UC5Q4bnu848IOYYCex+ypDE5F+w2TYUZwXJHol1Y+Da1geWQY9lPVkcdU9shWhWPEjj1/vp66
 q/MjW4yPsX+1voRe1rYK3FXoHBH1/ySUWzwWw7JoGcKyYy5SE8nXIYcAVncCQi5tjqQdVp+fG
 nNTP40jlpqPzvceljjI6bsR39xlnhGHC1ZaPrNH2miceS8sCyihoDKhdb2RwQKb0qDmYh2rnx
 YEXXwJwpUh5YIwqrKXPR6fZAwgtPektdD2g3T4AsYlF03rdEcWZAFFSunf/0X0YObQi54OC12
 NR4HeL6VakiL8wv//1eugdluTJ7p/wzzbW/6djStSVLzCijyW1TrA02L9RK1GHMIHvqiyz1uF
 kwn7KRXim0EVfFvQNP21STsujjn/7KkOlBZR4CUqX6jC4ikIMpGlH7/ll8jQYjIKVv2ptygnT
 XiSqZRfv8QRi/ZJP53ajehHAy1q/dXwIz0k8QulEsqfNgfURpkUepUJ52NBhp2O0SVqfZDtis
 usX+5Z01ipgXbR8c6XmVkBbMVk3ypaOfRAbCk/C2I4Zjxs33P315Al9lQXNWpjoNtxJV8dQYT
 UcmHHNhlY2Aq/e2gN/AGJ0tiJhspq6Zgu3Wm9dlDXg0qv5V2GgS+0kXAontsyoaEeBxyXkTq3
 1UTemcsjxrzY1ZzuqVV9PVjUExMm2Cms+Edi5b72Q+OVTqt+/N2omE283boOiibIi2qRsazEq
 nEeaRD20TMNz6qEBh3joOWqqbRz8qzTun+wpohg07hho2P1VoVqavwWNN3Osux5P4u3XgohPp
 UElm/nNuc1QhRWRgzhoLd+nOe3sUXW8VcWazvbDdEdvpAnTNtyAJdZwzoY7bIuUnddZNX8VVR
 EYZORMm2pEok/GsvnC1FvUL/N4I+8jLUKwEv7rduHMTIckgfBzkvqh8qhFxdYadTBt3IxRSrw
 +OV8iJ+IRUJKicC1OVTQPqGmaZFnhiISlcUtO9+XvJRJ1CkEd2wJ3LtTo8biKEgvQgA8RdlI5
 jBUTmCKzed/Il2/D4qi3AXukMiD0Gk0x1/ydoOvd6tqrRgVJWEyoWsBKNjjEUyMbdul2FmJr5
 NvHz+8Hn0+6ypfhY76TJDCw8etpgyc2oxm2xITCancwyyVlHBebcU4d2Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/27 09:21, Sweet Tea Dorminy wrote:
>
>
> On 7/26/22 19:21, Boris Burkov wrote:
>> On Tue, Jul 26, 2022 at 11:39:28PM +0200, David Sterba wrote:
>>> On Tue, Jul 26, 2022 at 01:53:33PM -0700, Boris Burkov wrote:
>>>>> Yes we shold care about readability but kernel printk output lines c=
an
>>>>> be interleaved, single line is much easier to grep for and all the
>>>>> values are from one event. The format where it's a series of
>>>>> "key=3Dvalue"
>>>>> is common and I think we're used to it from tracepoints too. There a=
re
>>>>> lines that do not put "=3D" between keys and values we could unify t=
hat
>>>>> eventually.
>>>>
>>>> Agreed that a long line is OK, and preferable to full on splitting.
>>>>
>>>> What about making some btrfs printing macros that use KERN_CONT? I
>>>> think
>>>> that would do what Qu wants without splitting the lines or being bad
>>>> for
>>>> ratelimiting.
>>>
>>> IIRC I've read some discussions about KERN_CONT suggesting not to use
>>> it, I'll ask what's the status.
>>
>> I just saw a comment at its definition that reads:
>>
>> /*
>> =C2=A0 * Annotation for a "continued" line of log printout (only done a=
fter a
>> =C2=A0 * line that had no enclosing \n). Only to be used by core/arch c=
ode
>> =C2=A0 * during early bootup (a continued line is not SMP-safe otherwis=
e).
>> =C2=A0 */
>> #define KERN_CONT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KERN_SOH "c"
>>
>> So that's not an encouraging sign. OTOH, I found some code in
>> ext4/super.c that prints its errors with KERN_CONT here:
>> 'ext4: super.c: Update logging style using KERN_CONT
>
> Some other log message from somewhere else could be emitted to the
> printk ringbuffer between the original and the continued message. In
> such a case, the continued message instead gets treated as its own
> message of loglevel default. (kernel/printk/printk.c:2173ish) Using
> KERN_CONT seems like it has a lot of potential for confusion, especially
> if the default message level has been changed to be different from the
> original messages' level.

Thanks for all the discussion, it looks like the current long single
line is the way to go (in fact, the space info dumping itself is still
two lines, and we may want to fix it).

Although it's not that human readable, the racy nature of message output
is indeed a concern.
This also means the old DUMP_BLOCK_RSV() function calls are not safe eithe=
r.


But on the other hand, what if we output one line with multiple '\n'?
Would it keep things readable while still count as one single line?

If so, I'd prefer multiple line split.

Thanks,
Qu
