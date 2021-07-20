Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771D63CF54A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 09:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhGTGqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 02:46:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:56201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235895AbhGTGqH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 02:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626766003;
        bh=hd7Qk0Q8q2EXiUo3tcELkii05u2hGKkNqEDap2sXqYg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=KrlmitTBlFzSNA5c4eCygN4T13jbOc5dxcK4QMJ2tOa/WYmPyjGVYTraehfllkmxh
         y5Y6lTtpXpAK1actBmA4gbTw/kXYvBsY+BHrabWTA4PLXzarW2m7mGm3nBQdj1H4rK
         ZdaMIlscr+76tcqG8jLgo7HHJ3fogIXZSS5VNMfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2f5Z-1m6Yxx0mUB-004A4W; Tue, 20
 Jul 2021 09:26:42 +0200
To:     Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <59efd6b4-ef7d-f57c-938c-8b65231a1c1c@gmx.com>
Date:   Tue, 20 Jul 2021 15:26:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720064317.GC2031856@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ihxH9X2rbUZXeOHwGxiLb3nMdC6KIVvaLVSaJYWt/3O1EIv9/bI
 qc3jz8Zo8I+BvgMpA2KqrFjTB0I/wMyKNbu/P+eMq+wR6fD7wR7QEmy/pAqoj4V9S4EesA/
 LRz8EhrIwuP5JVmVwaokp9TMGujvUdV/oCyq/9//FEBqMIqtQ9SCkQWZVA/YjzUOD5jd7Re
 wPnEESZJ3Kqp/W1v6ZuIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jA3ZJlkwLLw=:+DqPBJes2mzBeX3HHUNt/T
 sVnDM2NPM/5ernIby+dRH99VEFWw6bxqNkKLtb4tMZFG8FcX1Cy2AUM5gnpV8O4QUf4KuE6Bd
 2/ZCIyhSvI+YYe6+yFWEzrUpVgRKHU2cEJ0uqStLFBObsxoMyAK9nVeAzy+6PSvkdKv9d3Ccc
 tvlkaMM391+YQ9Rh8D4mKwQKlgtJOl1wOqvGjM4fcSsUDZzzMWmBkPOXIIRd1ZStZZnSs+Uub
 LQQ9dXTun9vwr8fIUtcUpPPkILhcdTY+LMOm6mNsT+zE0hPF8SgOL/hvva0F/mTYUIemYwZFl
 QpyBMSzHY1lt5j7upPLREK576yZWsITnAD11380QADkjytAveGc6UMWAqZS8QLiFqlFASsMDJ
 aocrbs0jKGiHdQQg3Kv0i/sgnkco71DeZapCkBxbkE9W6icuAI4WM7uXVVRpqMWhmE86TRt60
 5HTMiWjDtzGV3kNC3H8Y9CCSjQLdV9x/vIdpfuxaXh4a8kfefW/2Dv8slOkaZKNRMJamedZiB
 2K8e++XH/CLUsM+S3Bcrs7kLo/REcivq166OCY9H7cSyoIDRvY8hAHQQu4F+vQeYqWD5PQe3z
 NS+qf2kr1s/chbLurzuImGuc//58B4Pxsmvn0mb4pR6rarXB81ZOrQuVuCVGmS5Z5wYtruxT4
 lqzr7uLdk1XDYWS3k3YOyBKkFuxEf+UzlOIGmxCFnPyBeHm67cOCoJ1oVkhSZggF3wi6MmZiI
 7sojwXbY1ZQirl35ra6pSpcscfnyJmT8trjWNL9g8vgSr79f2tCqLLTG4hwpsTC8IMNr+8CGA
 Ki9qNer8H50gGmh99bB/uaev4ulZ55KbpY2Og6NxTSoQYSV566+wIx3gpAZJhSEp8WbjNjNzc
 HKPEeof43PqA8FBFjGUsGR40oeyA+Ex8kqDLyHpYjBiz05Bix9OKaYU9kfJ5JZZMUG6ilXisg
 6PRsKBYXNXQom1xczjoaOTplT96LazJQnKVqZWv6YiIj0ZkOG3EEXERQ/rRlI83bZ8sNJuKKk
 hHpkcWrkkD3aPhJkvZDn0etgUgbX78nb7pkEU4ZwdhBZTqpwECIbc2z/5dQjMCXR18x3PD/wE
 kr3M6srIppPZMNNu0Oedj/M03Tw2+vCFauXqrAeil9DN4+CilaoepcpwA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=882:43, Dave Chinner wrote:
> On Tue, Jul 20, 2021 at 10:45:17AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/20 =E4=B8=8A=E5=8D=8810:14, Dave Chinner wrote:
>>> On Tue, Jul 20, 2021 at 08:36:49AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/7/20 =E4=B8=8A=E5=8D=888:25, Dave Chinner wrote:
>>>>> On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
>>>>>> This patch will allow fstests to run custom hooks before and after =
each
>>>>>> test case.
>>>>>>
>>>>>> These hooks will need to follow requirements:
>>>>>>
>>>>>> - Both hook files needs to be executable
>>>>>>      Or they will just be ignored
>>>>>>
>>>>>> - Stderr and stdout will be redirected to "$seqres.full"
>>>>>>      With extra separator to distinguish the hook output with real
>>>>>>      test output
>>>>>>
>>>>>>      Thus if any of the hook is specified, all tests will generate
>>>>>>      "$seqres.full" which may increase the disk usage for results.
>>>>>>
>>>>>> - Error in hooks script will be ignored completely
>>>>>>
>>>>>> - Environment variable "$HOOK_TEMP" will be exported for both hooks
>>>>>>      And the variable will be ensured not to change for both hooks.
>>>>>>
>>>>>>      Thus it's possible to store temporary values between the two h=
ooks,
>>>>>>      like pid.
>>>>>>
>>>>>> - Start hook has only one parameter passed in
>>>>>>      $1 is "$seq" from "check" script. The content will the path of=
 current
>>>>>>      test case. E.g "tests/btrfs/001"
>>>>>>
>>>>>> - End hook has two parameters passed in
>>>>>>      $1 is the same as start hook.
>>>>>>      $2 is the return value of the test case.
>>>>>>      NOTE: $2 doesn't take later golden output mismatch check nor d=
mesg/kmemleak
>>>>>>      check.
>>>>>>
>>>>>> For more info, please refer to "README.hooks".
>>>>>
>>>>> This is all info that should be in README.hooks, not in the commit
>>>>> message.  Commit messages are about explaining why something needs
>>>>> to exist or be changed, not to describe the change being made. This
>>>>> commit message doesn't tell me anything about what this is for, so I
>>>>> can't really make any value judgement on it - exactly what is this
>>>>> intended to be used for?
>>>>
>>>> To run whatever you may want.
>>>
>>> No, don't try to turn this around and put it on me to think up use
>>> cases to justify your change. You have a use case for this, so
>>> *document it so everyone understands what it is*.
>>
>> If you don't need it, then fine.
>>
>> But there are already other guys interesting in this feature.
>>
>> Talk to them too.
>>
>> Something you don't need doesn't mean other don't.
>
> Hold up, what's with the attitude?
>
> I asked you to describe the use case for the hooks because it wasn't
> in the commit message and I don't have a clue how you intend to use
> it. Hence I need you, the patch author and submitter, to tell me
> what it is intended for.
>
> Shouting at me telling how I should read about what others want when
> instead of actually answering my question by describing your use
> case as I've asked you (repeatedly) to describe is not helpful.
>
> So please clam down, take a step back and please explain to me in a
> calm, rational, professional manner what this functionality is
> needed for.

I only need to do the very simple work like call trace-cmd clear and
trace-cmd set -b 4.

But I can see other guys may want such generic hook to do whatever they
want (but still overall simple things).

Bringing a generic simple framework while you can't see the usage to
replace your complex stack isn't the correct way to go.

I admit it's not obvious in the RFC that only simple work should be put
into the hook (aka throw away nature).

>
>>> My concerns are about whether the infrastructure is maintainable
>>> from a long term persepective, and that all depends on what use
>>> cases we have for it and whether global hooks are the likely best
>>> solution to those use cases over the long term.  I'm not opposed to
>>> adding hooks, I'm just asking for context and justification that is
>>> needed to be able to consider if this is the best solution for the
>>> use cases that are put forward...
>>
>> Nope. All hook users are responsible for whatever they do.
>>
>> Maybe it's adding trace-cmd calls, maybe it's to do extra error
>> injection setup, I don't care.
>
> You might not care, but other people will. I can see that if these
> execution hooks becomes a common thing people use, it will need to
> be formalised and further developed and documented.

This is already your guess.

Again, here the hook is simple, do your work there, if it works, good
the hook works for you.

If it brings some unexpected behavior, you're on your own, RTFC crafted
by yourself.

We will explicitly state that, this feature is only for debug purpose
and use on your risk.
No complain, no code compatibility, if one day code update break your
hook, it's not our problem, it's the one who crafts the hook.

> Because if they
> are in widespread use, we really, really care about things like API
> changes because breaking everyone's custom hook scripts because we
> removed or changed a global variable or function is not in anyone's
> interests.

You're again building the whole thing on the "if" part.

>
>> I just provide a way to do that more simply, to add two points to call
>> executable scripts, and any modification in their hooks won't be
>> submitted to fstests by default (check the gitignore update)
>> What users do in their hooks is not what I really care, and nor what yo=
u
>> should care.
>
> Yes, I get it that you don't care. And that's a problem.
>
> ISTM that you haven't thought this through beyond "add a hook for
> running throw-away debug code". You clearly haven't thought about
> what a developer would need to do to build a library of hook
> implementations for debugging different tests.

No, we are not doing that complex thing whatever you want to utilize.

It's just a simple hook, no guarantee, just to make it simple to do
simple things.

> I say that because
> maintaining that library via commits in local fstests repositories
> is impossible because gitignore rules you added.

Because it's supposed to be simple.

> I know, you don't
> care, but I very much do, because storing stacks of custom changes
> to fstests in local repositories is how I deploy fstests to my test
> machines...

If your stack is so complex, this is not for you.

Submit whatever you may want to add to fstests, and try to push a
complex framework for your workload.

>
> And given that it appears you haven't thought about maintaining a
> local repository of hooks, I strongly doubt you've even consider the
> impact of future changes to the hook API on existing hook scripts
> that devs and test engineers have written over months and years
> while debugging test failures.

Let me state it again, fstests itself only cares for the test cases.

You use the hook, you're on your own.

Don't expect any stable thing, this is just for simple usage.

>
> Darrick pointed out the difference between running in the check vs
> test environment, which is something that is very much an API
> consideration - we change the test environment arbitrarily and fix
> all the tests that change affects at the same time. But if there are
> private scripts that depend on the test environment and variables
> being stable, then we can't do things like, say, rename the "seqres"
> variable across all tests because that will break every custom hook
> script out there that writes to $seqres.full...
>
> See what I'm getting at here? I've looked at the proposal and I'm
> asking questions that your implementation raises. I'm not asking
> these questions to be difficult, I'm asking them because I want to
> know if I can use the hooks to replace some of the things I do with
> other methods.

My answer to this question is, this hook is only for simple work.

Either you maintain your complex hook to work for latest fstests, or
just put simple things into it.

If you want more complex work or stable ABI, then this is not for you.

> And if I do, how I'm expected to maintain and deploy
> them to the test machine farm from my master git repository they all
> pull from...

This feature is at least not designed for such usage.

It's more for the through away debug setup.

>
>> If someone is running hooks with every test case, it's their problem or
>> intention. I don't care!
>>
>>>
>>> IOWs, without a description of your use case and requirements, I
>>> have no basis from which to determine if this is useful
>>> infrastructure over the long term or not.
>> OK, my use case is just to run "trace-cmd clear" before one test,
>> btrfs/160, and I don't want to populate my workplace so that I may
>> submit some patch with my debugging setup included.
>>
>> I would only run that btrfs/160 with my custom hook, that's all.
>
> If you have to submit a patch with the debugging and custom hook
> defined in it to the build system, why can't you just submit a patch
> that, say, runs "trace-cmd clear" at the start of btrfs/160 itself?
>
> IOWs, I don't understand why generic, fstests-global script
> execution hooks are needed just to run a simple command for helping
> debug a single test. Why not just *patch the test* and then once
> you're done throw away the debug patch?

It's again back to the original question.

I only need to run several small commands, but I guess others may be
interested in adding some more complex but still overall simple work.

If it helps you, great.
If it doesn't, just don't use it and go back to what works for you.

>
> Cheers,
>
> Dave.
>
