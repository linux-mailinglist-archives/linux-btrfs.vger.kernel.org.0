Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54B5445254
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 12:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhKDLmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 07:42:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:49753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDLms (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Nov 2021 07:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636026007;
        bh=ecY571786Ydn3mJ5ZUCsIa2pwfykBpraL93vAzJf/xE=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=kPLhJwOqH8TgJn7kzKDxtdAouDx8Ma6EMsJ4UhBhkp7kX4NpWzyV9w/OjCjnPm/Kq
         dd+B2hr/71YZ0ZiW2AwgvuwGDezRfkj/kcJyynyLzPhsaQkpX0jOrqleBZlfGIYekH
         aJSemUoNYFxESnxq8cUu7Yx7ULyrFARiV4SsKrPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9gE-1mz9VC3QvU-00GaAT; Thu, 04
 Nov 2021 12:40:07 +0100
Message-ID: <95fa5a69-b029-08b7-4c2e-26661bcae052@gmx.com>
Date:   Thu, 4 Nov 2021 19:40:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1635773880.git.dsterba@suse.com>
 <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
 <20211102145018.GK20319@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.16
In-Reply-To: <20211102145018.GK20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6nikZuf9tdB8k2I2zxmW5IswgXn5bXGqEQRqaJdj/AglhlNjBmM
 dzXUCQdsyAOVCGPPwOU0ztoOicUcsnrgniC26RrmOoQwPda5h2HkqF78QG4jdjhIRClljWW
 0p75F2qIO9wf9FnfzLeLknP+7aHw87TgHQybGAzheb0M6h6xrXm4rjFdvUf+ynAgGG0gLAu
 qU/wZ+blq47WgEZ4YFSUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAp5QGhiFsg=:W1dmlAb0q4tr+yXvpTiOkW
 By7qu/kfJYaEyl3OFewvHkI71VfnDa42sMXeYohoqX1f7xR+bzjyky9VEYaGY9KAInfHrdWLh
 4/xnDGeb0pda6bwOeLHoY2+RqHOT6qlPc3ml+Wk+rvPtOvGeXsZZzOVNxjKFeB+NF26X11Agq
 hxwM2tBkg7Ij9zo17NUwvH/TZVDn6OeBtT3mZbrtxL+Ok8uvHCbPf3mA2Fq2udroq9dXKMGMH
 683ralHHeUH4riCA0bF9/Y6P8AelXbYGShgDOO4aiCBNEfns+/OeFYBu4R6m7FGz8gY2WrjRT
 eIEYDIQWpJ31UMW0x3PW0tGkfrqSOzkTfSvFJ9loGGVSZEMaYDUe+B+1vLXYOfCuWOdyO1wZ+
 8khudOj4SAfosw2ngOfosy+H34+HNjQVSApwNpXh/ItX98AU7anoNaqk198Hl7Nk48Ij6q4M5
 lh5YA1T5wpx1T5eUF5qPLDx98Xu0152d/lxTXxfWRuDMh2u3KFbnaH8+awU2Wvkkbfzn2zE1O
 sfpg76hh/Pti3AUf3WpEnqmcdmvZaw/NXWw0WImkW7xIAShDGR/GbWXmyfjTKv2geweDu1V1V
 neCIlAYzmH8/GrZOfCA2ICLooQozjTU/aBLFcXyZi4PSomQjOupD+iqMy04T0zi1l7i3wI+rB
 XIcn75cLpTXuRDPW4VOaImxYDxvZ+sqrORVez2EL4X47X1bhBl6sS9BGYLshHD5bDGdN5gmMt
 cKq+05DrEIFngsOyhmm64Oq3boeWGcIYlyIxPtGNlTSHm6mSUSwrl8XRS9kD+AYHTVtfFQ396
 W13PfZ4BV7E+lzmfsB+r8nOqYLLhP9BqNyUlvsp1iLol35/EuVz4Uq3LdMTUFj01c3MubwiYr
 EwL9WAWFTTtBYXPbborfqjiXWVYtxbQYIQ5vyHm9Ix5CufqzYmMs7ToZfBL7+R+vt7+vxlY9w
 UoRIpG5zwtC1zDu8vemWcula7OfM9w8CN6SsCZWeHK3C/oY4LpQC8vo+/q2okiKQd5LwB+BaP
 cPQiqEvt0HVuoMs5Yf2clbdglHOsFBV/2gI/zdcU1WfQvflQHvHHLRlFJbi1o09lfHJpfO1GT
 MgNcHUA/lARB48=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/2 22:50, David Sterba wrote:
> On Mon, Nov 01, 2021 at 01:03:25PM -0700, Linus Torvalds wrote:
>> On Mon, Nov 1, 2021 at 9:46 AM David Sterba <dsterba@suse.com> wrote:
>>>
>>> There's a merge conflict due to the last minute 5.15 changes (kmap
>>> reverts) and the conflict is not trivial.
>>
>> You don't say.
>>
>> I ended up just re-doing that resolution entirely, and as I did so, I
>> think I found a bug in the original revert that caused the conflict in
>> the first place.
>>
>> And since that revert made it into 5.15, I felt like I had to fix that
>> bug first - and separately - so that the fix can be backported to
>> stable.
>>
>> I then re-did my merge on top of that hopefully fixed state, and maybe
>> it's correct.
>>
>> Or maybe I messed up entirely.
>>
>> I did end up comparing it to your other branch too, but that was
>> equally as messy, apart from the "ok, I can mindlessly just take your
>> side".
>>
>> And it was fairly different from what I had done in my merge
>> resolution, so who knows.
>
> Looks good to me, thanks for catching the bug.
>
>> ANYWAY. What I'm trying to say is that you should look very very
>> carefully at commits
>>
>>    2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")
>>    037c50bfbeb3 ("Merge tag 'for-5.16-tag' of git://git.../linux")
>>
>> because I marked that first one for stable, and the second is
>> obviously my entirely untested merge.
>>
>> It makes sense to me, but apart from "it builds", I've not actually
>> tested any of it. This is all purely from looking at the code and
>> trying to figure out what the RightThing(tm) is.
>>
>> Obviously the kmap thing tends to only be noticeable on 32-bit
>> platforms, and that lzo_decompress_bio() bug also needs just the
>> proper filesystem settings to trigger in the first place.
>>
>> Again - please take a careful look. Both at my merge and at that
>> alleged kmap fix.
>
> I checked the commits individually and in the source files, all the
> kmaps seem to be correctly paired with kunmaps. We'll do more tests too.
> I'm sorry that it turned out to be such mess.
>

OK, something is going weird now.

As an extra step to make sure there is no leakage, I ran fstests with
"compress=3Dlzo" mount option, but the result can't be more ugly.

For the master branch (which includes the fix), it has a very strange
"leakage" behavior, at least in my x86 32bit VM.

The used memory reported from free would just suddenly sky rocket during
generic/027.
(From regular 100~200M to 800M and more).
Easily causing OOM for my 2G RAM VM.

I originally think it's btrfs LZO, but nope.

On v5.15 tag with the fix from Linus, generic/027 runs fine as expected
with lzo compression.

BTW, zlib/zstd compression runs fine.

I guess there is something changed in MM layer causing the problem.
Btrfs LZO has tons of quick kmap()/kunmap() pairs, unlike what we did in
zlib/zstd, thus I guess that may be a triggering factor.

Any clue?

Thanks,
Qu
