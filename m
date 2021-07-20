Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16C13CF654
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGTILc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 04:11:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:43155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232287AbhGTIFI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 04:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626770674;
        bh=1FBydMUdr5SBBEWX7UJ+djUwawBWu+TIpND3K/PjJEA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HL/mPw9PxH5PLN8z0g8G5UMNceyPwej+CB+P6acMlQTvfHRXNUDHK1MGxOb91OHeG
         p3xeP7ioSy5MfPiU9n3mxmn+S8b7VBH90IUaPY/avZrUASs8bdyhKLh2lTNu7dQOHm
         gcvkTzunVIdGrvm0jI+u3gxh4i6556x/dMT50ihM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1lQfW22f03-00fjRo; Tue, 20
 Jul 2021 10:44:34 +0200
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     Eryu Guan <eguan@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com>
Date:   Tue, 20 Jul 2021 16:44:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DjUhkcVjv1gc0E5hcs2IjAxcu+i989Q37AaXVBTCsoiWSY/1Z+v
 yhIIyso7i/LEQVry1Uk/vDOOl5Ha4mcD3a/c+ODVDqDRwJfePpLqik+i0745j8gebrQEq/9
 ZjPgl+41ycFe4sp44FaO2m0lTBRSWjuVEJK7r3BqrWQqqkh8u70ojDxmlOyEKbF+CqjOzzv
 ZwuHu45qBif4NR9PzeznA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x9w8VzAsalU=:/11HsaO7g2pI22J++r/VOx
 b2CXgiHPxJ7dANOaGOzo9M1fAQ+es51G+cm5a4wVsyzsD3zn/xNcTMohoyfkHaAw2YTAnXFLm
 Qk8NcaCYJaOpYMtBsvobvBXJ9apM/nFbLk7+FH4R5aSPNbpL6Nd+XNzf7/+j5mPVq2ign/3OA
 5carFyC4rm/7KfzkY3lF0xcHuE9yWaNghoLmIwlsJ2FPqJUNXf2agX0Ta3O9ifBq9nRmb3JaZ
 eUx2+mUrLYW17Qf2ckZ6oXnjApjQhV6JXxA1NGCef5+7UkfFYZ8NSlM4IbDX99E4yxvwOB+6U
 dhY122+1W/fNEUc/6Qd9DV/fZf510Y0TPgw+dnZHlACfVI+5jNeCsdIJk/mUcZiyWQVv26xG9
 xqDulbpqw34dccA/rS5zfHhnpbPGw/NI9Tc+0Z6qRXDUOnRTKzh6E7sWXC2yUAZC3smoZlxsS
 hy7q9rmK7O0uqikbYjnZ2Ux0+85poRtGJZ8VbhjmEKPp3Gi01xltHimpJe4f7o5Zujr8kdaU9
 gykEKzRxLeSS42eQ9B73qagYqq7F5IBGiJFZYcfnlyfrOj1TTpBVEzx/cxIc8G910Z9448yMK
 bRGhQSo6Lk+r14fs0bI3R1A8jaaTZK0EZplDMBiB4S0mFB5gGq+DiOZkCNqm7f3FTLTyiJQe6
 LJpnbMcHuE3O5kkktXwoCfOiN+iFxw6v9mOK3udIgA8mrAHbALQ/gOIOulistCetNZVv9I9li
 eczcoKATtIKfOK6uvUkrstR0ZorUNEf17P5/qTf9dTzckBAFDsl+de4pdG3WnRyBAmzL13eoR
 mRMlE4vQuUeiQidMBKMXGiEwJcjuqEaHHyGPFzyDffE+aMPB6X0NlylOze0/wQN9RnyRoUQfx
 B8fhd9QAkdd3wOxl3mjQ8bj1JNvRc0oJVb4tHWjSN6YCMYZ8+I4u/6ITOrBEBNYgo6cHULwtY
 ptsjFk58vCWcIiVKqXIlGtIZyqD7ztFw2kB5sqRC4cf+/SLRQB+jSMC80WsRwhFu/lKbQPlA9
 YtXjBshnh/atPuuyotImBQEIQ7CMteFAMvurnx5dSS/ffheaXWgAZQhiowz6RKgSM4dr3KnWn
 zid2Bg8p/Khfwlvf7G6RXZYvNs6D8gbZL9/Y0GEu3KgAUYLggAP7jGrXQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=884:29, Qu Wenruo wrote:
>
>
> On 2021/7/20 =E4=B8=8B=E5=8D=883:57, Eryu Guan wrote:
>> On Tue, Jul 20, 2021 at 04:43:17PM +1000, Dave Chinner wrote:
>> [snip]
>>>
>>> And given that it appears you haven't thought about maintaining a
>>> local repository of hooks, I strongly doubt you've even consider the
>>> impact of future changes to the hook API on existing hook scripts
>>> that devs and test engineers have written over months and years
>>> while debugging test failures.
>>>
>>> Darrick pointed out the difference between running in the check vs
>>> test environment, which is something that is very much an API
>>> consideration - we change the test environment arbitrarily and fix
>>> all the tests that change affects at the same time. But if there are
>>> private scripts that depend on the test environment and variables
>>> being stable, then we can't do things like, say, rename the "seqres"
>>> variable across all tests because that will break every custom hook
>>> script out there that writes to $seqres.full...
>>
>> I was thinking about this as well, if such private hook scripts are
>> useful to others as well, then I think maybe it's worth to maintain suc=
h
>> scripts in fstests repo, and further changes to the hook API won't brea=
k
>> the scripts
>
> But those hook scripts are really craft by each developer, which can
> have vastly different usage.
>
> How could that be maintained inside fstests?

Anyway, if building a stable and complex API just for hooks, then it's
completely against my initial purpose.

I'll just discard this patch then.

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> Thanks,
>> Eryu
>>
