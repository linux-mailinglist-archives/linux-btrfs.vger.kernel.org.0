Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0433AC300
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 07:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhFRGBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 02:01:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:54151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhFRGBG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 02:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623995923;
        bh=D9aVNIU1B3CoHEAGrA4gQ39LndI6nJ4+V38ZQ+SrzrQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OkrnCvn5yBI3Bs5NnjYgXv4BjXcT4ulECTmDUX3oe9ujdQ+wicdEqYKQkwMS322hR
         jBNe/TeuJaOro0GznG8mvxq3zdU/Gjbtc7EegOx0JbFkt2PnLZp6IawRyEkY8Tp4/M
         HzjZeDsf8vZCtX7ZYHG2RXUKd91RQcdMgwHGrAK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XPn-1lGxF23ZEP-014V34; Fri, 18
 Jun 2021 07:58:42 +0200
Subject: Re: [PATCH 1/1] btrfs: tests: remove unnecessary oom message
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210617083053.1064-1-thunder.leizhen@huawei.com>
 <20210617203518.GZ28158@twin.jikos.cz>
 <5f6198a7-3d3a-603e-73fe-b56c0b71fbf9@huawei.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b464d670-aa49-2f41-36f6-36a432959f46@gmx.com>
Date:   Fri, 18 Jun 2021 13:58:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5f6198a7-3d3a-603e-73fe-b56c0b71fbf9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:djaEt6cqrObeL9wMHkk2tgk/z4TkT7/ZiDQ9Vrlx1dFSfec7nYZ
 XKunt6/+KDXrb+4d4FHlvLxjpXkumV/wDu8Qd8EjlhNme7bRH0WmbcYXUCfOV9zqMv/bcYp
 KhDsGPYvAIbKam9rM9lNiiArNWvZcrgS5BTKTo9Mkf4sBfpmPCGiPtp8jgIsh6/BTF8TyTu
 GMUcO/lt+ZTG3NNmtZdvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yP1yDe2kBw8=:IV1vUv3R5ifyvZpS8SNy/R
 bZduj6MEj61C6J9im0FEhYtxTtNTRGhBAiafFBpTJHvpFNUE/RTi1aYM3bJ1Zdu2lWwpJlQZ/
 HlwYqyEKeQHdyNGVAitPZvaHYow4sH5DRb7YOsSvt/HxXZ3qtI4f4FZJ1Qx1fj2cfgY8fyRfY
 SkIAKIw4g51AfwdmCVey6HcZ1Wds9tfqzMD/tDp1ktQNwx/xqTsqso4wV5Xqe9TbJAj3VkGRA
 h8jKXITeh61pfc4becPJ39OQHqSOA0azmxa++k/63l7XtqrGk5HXjvzw0JBBLleURLbIVfr1t
 9wYGJseaHRWVByeEqVXKceME/nhxZyJHWgb+65wqGHOH/dYliu1dbiTx9rtInQRwVIhSz9Fjc
 fgOr2H4PcLGjWZnYY/MMjn8Q55BsfDSEpRghRekltJK3kTUvzNybYK+GSTkSNMVMyZeH23DYG
 2cFB7md1Bf3XqaLeLrSRpc5p0qajS6/EpW9ynm0DrpdmcfMbuw5gE72X8nt5NpxH9EbSDHx/T
 nuTmae8dYjw8lycDMBFUKJz/Bi4XN3176vrsHK7Zxp7Yg9QNPDRzpJU9jhHcKXZu1jLhfi5HE
 FH4E7VdmT2VnVqhT0F/Bb8tcypnn6SYCcorv8tI38FsMVWWxdxyURzzwzLm2MUlwjuEOJPBEc
 yXYjlk2voQgQy5Hy8RREaDPuOANqExBixy9tkEh1q93bk0aGAr7V/SXY5XVfivLGno32wUAwR
 zyEdebwCKXTQFYAKRn9K6xL8TJMGVN1rSVtiqPypOSVPw7jVJ7+i1Nz7R6PXVTPrjCVCgijo4
 fVb03ns6s7jGEHxWNLQjOozFJVN88AujZjLxbI2N73kAolduDODh0dRDS+AZzUInU9j9jadEp
 XgL5PV4ToRxbQaw9qJAEzK44rxA7215vtHBV8n7LtfumpmpSO/e93oi/uEHg5cwSs3Xd6KuOA
 o8bAE+yZB2gNq6ztx5d1UEVtgXuJukIkissB8o9GsPg2FshkFQ2wa0SDQ5OVGuDEDoCvSUiTX
 C9VvnAxszosmawlxbbOx7p3utDp8llTQHEjZ5KZjs8sZLStp/jemuB7yda/7Cw+myONTPc1fK
 UUFUXmC8/IYb9N359FBKOqXqGMgWaANhnnUItbPxSgFfmAXvBOJi9poIw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/18 =E4=B8=8A=E5=8D=8810:33, Leizhen (ThunderTown) wrote:
>
>
> On 2021/6/18 4:35, David Sterba wrote:
>> On Thu, Jun 17, 2021 at 04:30:53PM +0800, Zhen Lei wrote:
>>> Fixes scripts/checkpatch.pl warning:
>>> WARNING: Possible unnecessary 'out of memory' message
>>>
>>> Remove it can help us save a bit of memory.
>>
>> Well, we have a few more messages in tests regarding failed memory
>> allocations.  Though I've never seen one in practice, I think it's not
>> a big deal to have that one here as well. The failures in the testsuite
>> are intentionally verbose and saving a few bytes in optional developmen=
t
>> feature hardly bothers anyone.
>
> The calltrace of the OOM message contains all the information printed by
> test_err() here. I don't think anyone wants to see a bunch of unhelpful =
tips
> when locating an OOM problem.

This only get enabled for btrfs developers, in production environment
would enable CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy.

Thus this error message are only for btrfs developers.

And I'm 100% sure you won't need to investigate such OOM problem, nor
even see it.

>
>>
>> Where bytes can be saved are error messages for the same type of error,
>
> It also saves a dozen bytes of binary code.

It won't make any different as you won't enable that config.

Thanks,
Qu
>
>> that I've implemented in the past, see file fs/btrfs/tests/btrfs-tests.=
c
>> array test_error that maps enums to strings.
>
> As mentioned above, I don't think these "no memory" strings are necessar=
y,
> unless the rest of the test can continue to run healthy. Otherwise, no o=
ne trusts
> the test results in the OOM situation. They're going to locate the OOM p=
roblem
> first, and these information are pointless. >
>>
>> .
>>
>
