Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17C43CF107
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 02:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380984AbhGTASA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 20:18:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:35499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353336AbhGSX4Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 19:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626741413;
        bh=ulyEvw4No4EfJFJSjOQgzHVLnWd4RfvP0axlH2vg9kk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kWfDSR4udF3HkAolomudovCWAMSE3+D/x69HFmch0t8NyZFgfX2FV0biKHbhU34DD
         hwTVotejVRT8SEfQPDOFaDovyDgbSQ+1DL3iipe8noNRaP55H8dn2tc+TERpqMFPsH
         tUVhs3L8M+tgpjr62dtK4c94EM1QOZY0bqXM4kAM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1m3zal0DeY-001fMu; Tue, 20
 Jul 2021 02:36:53 +0200
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
Date:   Tue, 20 Jul 2021 08:36:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720002536.GA2031856@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xIQyieE+8AnwKrR0CZwTQbwASh5VLLJsyMHqJU64/AMa+Az2PMR
 Txx+v79INZZD0z4lJbSLzvVu/tCsHR0qAs6zEvPEM1/UEPmTUg0BNu8BL5/Wu+ARbsM0/kG
 XAOg9EWUceHcCb8t79kstYlJz8Nd2l1SDwx3c2U74w3niZTDwG7KMvE+WqLnAud57fH608L
 yCgoZjzxi39J7mKCrnKWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZaeM+5luWE=:WxyS4ALzab/RYcuXKHHiNx
 FOk7DxP/e7uKwYjZp6aKNn0441Oag8iASP9bAwgT8A8dIk+hGLZ79c0q2xBYCkgBdNrGB1+f7
 BoTsVS7mNi7ELG9nNPT8Tx2TAyPbdrNEVDbcUL2UlqfMTZChpXhk1z926MUcLfJbN2XC44RmW
 uNCLmSCRQIvmTCHKCS21x6Uu42AuqE9XYHfHvctE72d/RbK4AawayvZJsnp7DfptUgTjX0WXz
 ZwL9febrJtUeCU2loUocM1uzxhyTGLxCHtiAHAC57fQ0vso2rYIxFwQ2A7avpmXUz/9deKvU6
 zyAIJWyiflv5oxSci3y3F+e815Htft9EJmUPgA7BCkq083m+jMXbE3kftf8QxPubMCsNwTzgl
 PDweUmOHXhbc25BTcNQsF9X/dp1JyxmTW152ssLRg/VWAi52qDRoZGZZ4iymRBxtg3/tmDKbL
 GmynfKb5LlBEK/aNH0P5gz7O7nd3tMaZc/A8Z0RJtvAYttB3UYmd7jCA2Vz10lUCz07jo9T6S
 kCM57yCaeReM3pHgvGMs1z+cWPJnAY2ZjJo9FhM5UNB8peNXoriuP1W9l9ayCmtrcQigA9tpt
 g65iwVESV5g2Mi+d4vb7pOZn+mRqqHUm49jC9l8xLq2coqEf/uRBl2HeJa9g3ZqqBgz3GhpHm
 HYK1arvDdpQxKDSyrAYflP1A0h7W7HmtzqZfoQq8yRSuuQwZaKUga3kYuEZU33mSjPKme706O
 ZdylppO4gVGhoM1mIp4saY1KjCVvUrKPXYT/J+Rsf4ZVBgDzcan/4CF0i6+JWpCQ7AdC1RSdX
 OAewvSeqKExAHNg7l0OzyTCctukHn5cf2a2z6x3JOCCt7GvvhvwRY5TLcoa0TjukrPGWZmNns
 umgreXYBkN3tLFOJvY1Tx/7KoMfyPhs+Td9Dweae6la3Q0cDqh3xxQz/6/VhIewME86LGtcPZ
 NpdgD8sDq6C9mYmq+H3kHJa+UxeiXxns3UjqnPUdUfOHBKU8UVrFPgOB5vyxBAwW4Kp/Rf+qV
 wzbbRj2fS69fiRjxNqQ1qOzMMJ7pTMb/K4TnzzALrPbXIlbnqJeEDTIwYtVhnLgzRiNFfM+be
 9n7zkfOIbDSmzB+F2HGvqpszYlrxJQWzoNrUAuOfD9NKR6wzFkOdqKWFA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8A=E5=8D=888:25, Dave Chinner wrote:
> On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
>> This patch will allow fstests to run custom hooks before and after each
>> test case.
>>
>> These hooks will need to follow requirements:
>>
>> - Both hook files needs to be executable
>>    Or they will just be ignored
>>
>> - Stderr and stdout will be redirected to "$seqres.full"
>>    With extra separator to distinguish the hook output with real
>>    test output
>>
>>    Thus if any of the hook is specified, all tests will generate
>>    "$seqres.full" which may increase the disk usage for results.
>>
>> - Error in hooks script will be ignored completely
>>
>> - Environment variable "$HOOK_TEMP" will be exported for both hooks
>>    And the variable will be ensured not to change for both hooks.
>>
>>    Thus it's possible to store temporary values between the two hooks,
>>    like pid.
>>
>> - Start hook has only one parameter passed in
>>    $1 is "$seq" from "check" script. The content will the path of curre=
nt
>>    test case. E.g "tests/btrfs/001"
>>
>> - End hook has two parameters passed in
>>    $1 is the same as start hook.
>>    $2 is the return value of the test case.
>>    NOTE: $2 doesn't take later golden output mismatch check nor dmesg/k=
memleak
>>    check.
>>
>> For more info, please refer to "README.hooks".
>
> This is all info that should be in README.hooks, not in the commit
> message.  Commit messages are about explaining why something needs
> to exist or be changed, not to describe the change being made. This
> commit message doesn't tell me anything about what this is for, so I
> can't really make any value judgement on it - exactly what is this
> intended to be used for?

To run whatever you may want.

Don't you want to run some trace-cmd to record the ftrace buffer for
certain tests to debug?

>
> FWIW, if a test needs something to be run before/after the test, it
> really should be in the test, run as part of the test.

Not the trace-cmd things one is going to debug.

> Adding
> overhead to every test being just to check for something that
> doesn't actually have a defined use, nor will exist or be used on
> the vast majority of systems running fstests doesn't seem like the
> best idea to me.

Then you can do whatever you did when you debug certain test case like
before, adding whatever commands you need into "check" script.

If you believe that's the cleanest way to debug, then sure.

Thanks,
Qu

>
> Cheers,
>
> Dave.
>
