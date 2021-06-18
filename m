Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D3B3AC314
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jun 2021 08:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhFRGIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Jun 2021 02:08:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:45105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhFRGIf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Jun 2021 02:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623996373;
        bh=3K5b0oac+qlrgWc3CuD1q3sc96qvP6/P6FtQ/aVaD7E=;
        h=X-UI-Sender-Class:From:To:References:Subject:Date:In-Reply-To;
        b=hIlJ1C23ReeLbTcFZIsIvVqmljiV6VqBRyNPJFjq9lMK07lSjMbImJ7ISlAZac+U/
         +G01RbDtzAbbosLAfeMdDksTRKpNraR+yTHuo+S5qQXbTDPEe8HVPLlhZ9ZU7EKz6U
         FXI9SpBKIlhAkJBP1kitmQ5gcc2x8ApZ2FU1pbOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95iR-1lGOd12487-0164fa; Fri, 18
 Jun 2021 08:06:13 +0200
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210617083053.1064-1-thunder.leizhen@huawei.com>
 <20210617203518.GZ28158@twin.jikos.cz>
 <5f6198a7-3d3a-603e-73fe-b56c0b71fbf9@huawei.com>
 <b464d670-aa49-2f41-36f6-36a432959f46@gmx.com>
Subject: Re: [PATCH 1/1] btrfs: tests: remove unnecessary oom message
Message-ID: <55b0c70b-f0c1-07e2-f8dd-073f4fdc8f07@gmx.com>
Date:   Fri, 18 Jun 2021 14:05:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b464d670-aa49-2f41-36f6-36a432959f46@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:puvVML7jyWrPY3gj+zCd15p3uYxzahRXzGg7InksdiHpTwuHEO2
 C2AvhkacQjnpxjH2f1/8HViqwNVvcQHgtYDDk7AH3JnFaKEv5ROU1ZVlCO5Vo4x5HYQI7PG
 IqvAtr/FXCa+YLJs1WstzKAfyT4HjwU8WWlGHG9iOI23jDh5LBFh+Bft0Qik3rDlO41IyR3
 7mQAuem/Eh+MDQ+QxNeew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCsizn4LubM=:0wL2hQxp2Ak2PwJtgC2taY
 4tpnmZAfHlggMOr5Fw56zLM2fLXTywHBYAGg3v/KXcLfw+D2xb6jj/WC9LYmQtcf3cFXSn9nr
 hROvpxq6m12uWpO2//+bpuykdvX+mn07nSsbFVbVXqkC9WgxCuyV4RlFp/G14hjHHavqxdOVH
 lDMtorWZ5cM66Yxvpby/OoDfUaIDRBllpgpzjeICj+TS2SsWk2p1yW19mAue95JxHhGd9jD0Z
 eRzDQQoDG0MJtvIu6+BEswXy2Q9XON/B3GfuFrd3voPqWobxNC6udvRxHNuWdsAEcEMRyw+pN
 KaquugSa10x0Ql0z/icBncUhuJNr8n6lmWCzO13fT0IAc26qEvIOb2l/blTNswA/v03RpJqv/
 cO1/LKcPbmQtbdehApjePdRAqb2FDSkt5KoBxXhvqxywhImffakRVTCfv8dgYFSdCAm29g2M1
 MXE+cL/cM2xl1CvUnWJ1qazAJ542CBPu86iLIoUqy/UZj/hihe7pMvrK6nHM1eoARfSa1O9R6
 wKay5AxN9RwJDjFpL4Bkq/1KB+SlcaXEEv7lLRq4hRGET5salhnvVQ+jXqLrTGXtZPSGIclqV
 gXesFRhB6iIbwVkd6manThAB2/kEc7zNjvk8Wz/l2CqaGhowHTinwiKfgKrp8amrPVBlmcvw5
 O7u0pOwTjL1wADpxQegLs5kLaALzjTkOGhD2auW3sqHk60HHQ4Airodnt3kuckJjgjm3WUjkE
 2C/146dEguPqNYtFDQAd/LWKQyJGZD1si/FCUfA6P6lW5T/VN1p6tuU35WHlBddLzj6qwm0b2
 tH2WstfgC2QM7KbOjwyyUsIz/bzDEyq8YR4TQ2OrFQ3AjvvQUtAHB3BhcySK/4q7oAAzDFTX0
 Z5fwj92JDCteiokf7NvFct8Pppvr8Z9PWNCq4be/9fr6Ey3nJwA5anwWZCVXgrUEmcTxUJa/Y
 M333rXDoCJdQ6FCFIyY4wLiXnGimL01LcjvYOqNWqUjMNmrHGwHivR9NQpM9IkNyWkwTd7KUs
 Cd5s/3Dh9z6uGIEc9OwRvEwsm28TqIz1ICo2E21M4EVvYRo0hoPelOQsdDNpHNyBOp6n5vuSK
 YCZNldOj6406GkexHklvCPQgGVdt16QQX02Yax9yElO3BAstpQbtdTfkQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/18 =E4=B8=8B=E5=8D=881:58, Qu Wenruo wrote:
>
>
> On 2021/6/18 =E4=B8=8A=E5=8D=8810:33, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/6/18 4:35, David Sterba wrote:
>>> On Thu, Jun 17, 2021 at 04:30:53PM +0800, Zhen Lei wrote:
>>>> Fixes scripts/checkpatch.pl warning:
>>>> WARNING: Possible unnecessary 'out of memory' message
>>>>
>>>> Remove it can help us save a bit of memory.
>>>
>>> Well, we have a few more messages in tests regarding failed memory
>>> allocations.=C2=A0 Though I've never seen one in practice, I think it'=
s not
>>> a big deal to have that one here as well. The failures in the testsuit=
e
>>> are intentionally verbose and saving a few bytes in optional developme=
nt
>>> feature hardly bothers anyone.
>>
>> The calltrace of the OOM message contains all the information printed b=
y
>> test_err() here. I don't think anyone wants to see a bunch of
>> unhelpful tips
>> when locating an OOM problem.
>
> This only get enabled for btrfs developers, in production environment
> would enable CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dy.
>
> Thus this error message are only for btrfs developers.
>
> And I'm 100% sure you won't need to investigate such OOM problem, nor
> even see it.
>
>>
>>>
>>> Where bytes can be saved are error messages for the same type of error=
,
>>
>> It also saves a dozen bytes of binary code.
>
> It won't make any different as you won't enable that config.
>
> Thanks,
> Qu
>>
>>> that I've implemented in the past, see file fs/btrfs/tests/btrfs-tests=
.c
>>> array test_error that maps enums to strings.
>>
>> As mentioned above, I don't think these "no memory" strings are
>> necessary,
>> unless the rest of the test can continue to run healthy. Otherwise, no
>> one trusts
>> the test results in the OOM situation. They're going to locate the OOM
>> problem
>> first, and these information are pointless. >

And nope, it's not only OOM can cause the selftest to fail, but also
error injection.

I guess you never ran error injection tests for filesystems.

Under most case, we inject error with specific call chain, but sometimes
without any call chain specification, error injection may find some
corner cases we're unaware of.

If by chance the injected memory allocation failure happens during
selftest, there will be *NO* OOM dump at all.

In that case, have a good luck investigating why selftest fails.


Your words make sense for common path, but next time before sending such
patches to earn your KPI, please dig a little deeper to understand the
context.

Thanks,
Qu

>>>
>>> .
>>>
>>
