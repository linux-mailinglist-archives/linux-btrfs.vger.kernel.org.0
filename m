Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338C83CF238
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhGTCLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 22:11:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:47721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244946AbhGTCEv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 22:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626749121;
        bh=qn50R+zbKyhWbz79trPCZ48S57d9etbinZq8FMvzmfc=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=E4GLuI3Yl7t/IzFSHsVW+SZzBAQo8ceA96S/8r7RFP86Vn5+9VvzLh6iYhSMSIpGn
         YUdZhuVQL8+uoBySICooZLLDqhROqlYFLC0kGcEo51sCzpDxmHxaVhVDC2zq9Z88bd
         /cTOpWtI7KdpqrHvpUKkDCQJub3uPkkQ9Tgka9WA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXtY-1lfJBY0yA4-00QWXy; Tue, 20
 Jul 2021 04:45:20 +0200
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
Date:   Tue, 20 Jul 2021 10:45:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720021437.GB2031856@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eW1pIdZdQ/0+SgAEIlFRTG9Os87uhKfEBevdEAjojMfS6cSRTaU
 gV7dKby59WkeaX3TmWBhROgr7ggYSZ1+mWvmUAud0aB2VmE/AfRBcxMXxhiYUKaaZwWdO6o
 8z2nXsNIrmggUXe43ZYnQVIXjI8uCltwp0qqf+gkykEWN1T74tyqnszBXGrDq7lF0t+EiJ8
 NYbqdiGuhCeAYQQKUg5eA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JomcCQ/uqII=:ZwYSPu3nlmLbu+v5RxQ/QR
 hPeb9FDDsJ7/F7msjd2hHAkO2Ronc05hzc0N/Eg+U5hBQkZQTtBsY/Nw5rOwTI7WAXWauO3W4
 wOK7Jrtxb4ZXToQfCYwTCFhL3uytCahZ07AxLuGP0yMaQRjXy5zDCV22WBPF1IsuwQeS9Ee6C
 gVYPXGv6OneByhEF9eidarXTtNMwESSoTyG1ufi6rgFmN+5Up3G9ZqUPBM2FfxHeYQwVu51QU
 xo/Yseq455i+WVZHqMp3oeuWWIla+PvnLl+KM3VEWFhGVCjM5g1pdnPS/NskqZ4EdNecwPgKI
 SW33ohbd1sXjI26c/KlRCQpc2jZK4Sszk0ihm4BqbAJ/m5sH2x1Ph9m1slYSxI250TVkGCzGj
 PEl5MjapsQH2/1nzIwy+OQza2WSMVmxTiAUAt2DYWZjk95LsS9W0wCk7HGzR+CNYo3LPlb/0Y
 GJ8hemf3/9F+OYnmg6Y6TO5/HSumkjj+FgeH6Jbxz7poTLje2YhW6Aw3V+iHNji07bzYhuyXt
 yW98FubxBtapH8GtNHepenOja1MJ4xRKVcE1ck9LRtovnDAu2AgbGuVbwGhgcA4Zb5sCLoPFz
 a4QslChI/FsjFU/5WFPT26fhmeUJz46dEDrY1GeNOvLJkhfnTlAcCyfcgAr9OnjHo4/SyNnec
 PumB0kEGxcjMRrqVZQ8037M1EEnzzNTOVHFAjvCD24F3Dfxk4r/96ov3a+Q3xM4YrhjKdgFL1
 mF2A0kC44yamjikIYise7rNYuiHswkIlj6mRIpGoyMNoJOmsCIDQ84T3/uGYFio9a2zJ1cRJI
 ZDOy+EqV4B2Ky1tfyd1yttR9ciWJLSG3LBg4QVfABd5Ry4mEeItjrLGvex3mitG/OfuG+feFR
 EUMVgAG0e/Cqyrt6gj2Wmtq9spqkFy3j8c8KNHgCETCqsu2zrQlziE5/emtjplB1xC4MacnJv
 eNdJ8UdiQml522ofK4W4sfsOZXL23vrlVU9JQIo/t18IKQGCwXOkjChTSsuaV+JupFeGuQoT/
 t6HgGDNFSYommM2hnxDq6ex+YB0q3NyTThvadalJA7VQub+nOyjcyQufwH3yBA7l0glQUl1o2
 oppMuFoyXkYAe9MuJcNkTX1bnotdNKuZGghbis2ara22P+oCxYhP+PbTA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8A=E5=8D=8810:14, Dave Chinner wrote:
> On Tue, Jul 20, 2021 at 08:36:49AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/20 =E4=B8=8A=E5=8D=888:25, Dave Chinner wrote:
>>> On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
>>>> This patch will allow fstests to run custom hooks before and after ea=
ch
>>>> test case.
>>>>
>>>> These hooks will need to follow requirements:
>>>>
>>>> - Both hook files needs to be executable
>>>>     Or they will just be ignored
>>>>
>>>> - Stderr and stdout will be redirected to "$seqres.full"
>>>>     With extra separator to distinguish the hook output with real
>>>>     test output
>>>>
>>>>     Thus if any of the hook is specified, all tests will generate
>>>>     "$seqres.full" which may increase the disk usage for results.
>>>>
>>>> - Error in hooks script will be ignored completely
>>>>
>>>> - Environment variable "$HOOK_TEMP" will be exported for both hooks
>>>>     And the variable will be ensured not to change for both hooks.
>>>>
>>>>     Thus it's possible to store temporary values between the two hook=
s,
>>>>     like pid.
>>>>
>>>> - Start hook has only one parameter passed in
>>>>     $1 is "$seq" from "check" script. The content will the path of cu=
rrent
>>>>     test case. E.g "tests/btrfs/001"
>>>>
>>>> - End hook has two parameters passed in
>>>>     $1 is the same as start hook.
>>>>     $2 is the return value of the test case.
>>>>     NOTE: $2 doesn't take later golden output mismatch check nor dmes=
g/kmemleak
>>>>     check.
>>>>
>>>> For more info, please refer to "README.hooks".
>>>
>>> This is all info that should be in README.hooks, not in the commit
>>> message.  Commit messages are about explaining why something needs
>>> to exist or be changed, not to describe the change being made. This
>>> commit message doesn't tell me anything about what this is for, so I
>>> can't really make any value judgement on it - exactly what is this
>>> intended to be used for?
>>
>> To run whatever you may want.
>
> No, don't try to turn this around and put it on me to think up use
> cases to justify your change. You have a use case for this, so
> *document it so everyone understands what it is*.

If you don't need it, then fine.

But there are already other guys interesting in this feature.

Talk to them too.

Something you don't need doesn't mean other don't.

>
>> Don't you want to run some trace-cmd to record the ftrace buffer for
>> certain tests to debug?
>
> I already have a way of doing that, thanks - the command line is
> just fine for tracing failing tests. IOWs, I don't actually need
> hooks inside fstests for that.

Then don't teach me how to do my debug setup.

>
> Again, this isn't about what I need from fstests. This is something
> _you_ want, so describe your use case and how these hooks are the
> best way to provide the functionality you require.
>
>>> FWIW, if a test needs something to be run before/after the test, it
>>> really should be in the test, run as part of the test.
>>
>> Not the trace-cmd things one is going to debug.
>
> I don't follow your reasoning, likely because you haven't actually
> described how you intend to use these hooks.
>
> If it's for tracing one-off test failures, then we can already do
> that from the command line. If it's for something else, then you
> haven't described what that is yet....
>
>>> Adding
>>> overhead to every test being just to check for something that
>>> doesn't actually have a defined use, nor will exist or be used on
>>> the vast majority of systems running fstests doesn't seem like the
>>> best idea to me.
>>
>> Then you can do whatever you did when you debug certain test case like
>> before, adding whatever commands you need into "check" script.
>>
>> If you believe that's the cleanest way to debug, then sure.
>
> Again, this isn't about what I "beleive".
>
> My concerns are about whether the infrastructure is maintainable
> from a long term persepective, and that all depends on what use
> cases we have for it and whether global hooks are the likely best
> solution to those use cases over the long term.  I'm not opposed to
> adding hooks, I'm just asking for context and justification that is
> needed to be able to consider if this is the best solution for the
> use cases that are put forward...

Nope. All hook users are responsible for whatever they do.

Maybe it's adding trace-cmd calls, maybe it's to do extra error
injection setup, I don't care.

I just provide a way to do that more simply, to add two points to call
executable scripts, and any modification in their hooks won't be
submitted to fstests by default (check the gitignore update)

What users do in their hooks is not what I really care, and nor what you
should care.

You use your wrapper or whatever command to do your debug, fine.
Don't expect others should follow whatever you do.

>
> It may be there are different ways to do what you need, or there are
> better places to implement it, or it might need more fine grained
> scope than an single global hook that all tests run. I can see that
> per-test granularity would be much preferable to having to do this
> sort of stuff in global hook files:
>
> case $seq in
> generic/001) ....
> 	;;
> generic/005) ....
> 	;;
> ....
> esac
>
> But that assumes that this is intended for hooking every test and
> doing different things for different tests (which appears to be what
> the implementation does).

If someone is running hooks with every test case, it's their problem or
intention. I don't care!

>
> IOWs, without a description of your use case and requirements, I
> have no basis from which to determine if this is useful
> infrastructure over the long term or not.
OK, my use case is just to run "trace-cmd clear" before one test,
btrfs/160, and I don't want to populate my workplace so that I may
submit some patch with my debugging setup included.

I would only run that btrfs/160 with my custom hook, that's all.

But I don't know whether Ted/Darrick would want to do for their workload.
Everyone has their own special debug setup, and I don't really want to
be taught how I should debug.

> It may be a horrible
> maintenance nightmare when people start writing tests that are
> dependent on certain hooks being present once the infrastructure is
> in place....

Check the gitignore! The hook will be ignored by default!

I should add something to the README like:

"If you use hook, don't expect any support from fstests community,
you're on your own"

Thanks,
Qu

>
> Cheers,
>
> Dave.
>
