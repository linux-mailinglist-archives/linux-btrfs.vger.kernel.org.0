Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD6406722
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 08:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhIJGSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 02:18:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:51959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhIJGSN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 02:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631254619;
        bh=lGetMfuP7o+7igVOUj3U9wK70uuQhVA4SfJU/CT16jY=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=KHIrfRhBisp+Pc1kDrHPHR/YRqk8YoNbPtUWaMuDPdfEENWOswT7KFaPPjjkBPF3G
         PaqIOS89Pmiq3FvAuPXPWUBFBBHSE8i30hKOS6AKbbYqZCuksOh17gSUP4oUJ8DIYj
         eyjPmfiHCdlw+rNeQPpIzrWQzYTG02k3J3fBNWSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPokN-1mbPzd3ceZ-00MqZd; Fri, 10
 Sep 2021 08:16:59 +0200
To:     Sam Edwards <cfsworks@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
Message-ID: <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com>
Date:   Fri, 10 Sep 2021 14:16:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dvb16cB0EtzfFa5F6+lkdil+B3wmhlLPhmmdmfvfJQgLd4EqXjM
 QWyPz4OdBz//mxo958VebN6EgWeU9HzvfkRPJUFFkfLB5z2d4lVn8bGVziU7VO6J42PHro9
 HmT6eVS6g0Fzlr+m4iJ0kxqqs8YH75VPC/U9rQAneBfv0SnoQY8MIYR+oilfxqbR2OTmh8p
 EGaAiWsCiYPAepLcrLXjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V67ehMsyVnU=:bNKYmHfSDW9EfH3Atjiqst
 noZfdSNZ3s4gGktJzFb+5TzwmNNohstaeyB60g7dP7vPp0HyLdG/bLlMH/e+KHKGrOLUIcs3Q
 ZAjdueRs8iMR2hhBFmxjIOJOEXV56LUzZaLgeeoXffZYtwJwD2sFOs5wg2Guk2c1pPi+lzjpY
 p+6mUS5du3w72UsnOgCcbBzEsb0cfxx2cUOsCjcimGWZ+BHciIQVEvXbx89OxVm2aUlelrUzv
 D/il/38nIKJSyvZOkEx5jjODGAyif7YBxG5njTEpxj86o1LidT8xpiHiGtatQpbJNqk2sAhYV
 +dxhAj2vFc8WdoFTP8kmYYvkI5Q3CQWaQg/CBoO/ycyQdJ3/XiG/XKjYeZIDsCQAdu2lk9H1t
 EZ+Gxv84Kr8CT3kvXwaY3pxYoopKSbKs2WHZdw0PRQxRNh4rxwiGi8WCyg8b6L6kgwWQKxycP
 tCCbmN20ICUlASLVkqzVMtm5nFwWhyD/yHwM/DxvUcFnkcL+K4NIAeZzAWpPCXSJ4YCk06U61
 dfx45zv7NWk53OeWmhKDssI/WfgOSB374m+HLDK1PJnK6kkOoDFZwXYqiKcuApGWQYLBkvqxJ
 sQBhdOl4aRjzsTJ+y+1nsxyEEUMT7Dxna2VwJd1t5VGSRiRVN/5VLobt+deIgVB+XIH3VrYht
 uuLWPfcgfWXNzX6V15Nq2EGAqVQc92gLWF5oytMgrOHyODU1NaCMlu9+tnCzhL9sYrU27f9+x
 mQx/+pv1n5WtbVnCS1ZsqkOXc2rZn7h9N4I9/Vo0ZGYwxjphogItxvjWSKYGHBLSO0MFW+3HO
 TgxL8vmYu70ssYKtlDN0F4XHHGifOk2h6VmWS9SylTNimYiRDk02IdVqLcN0IE3D0fzd9g4uu
 rYmavwqZJJ9+KNL9C8AJj59dyxqKqM9iiS1P+hLrKsMqjmanVuvXXqnwXhROZMBxVAiJACI8o
 uQdR+1L4iU/ITcFcHjNYuTUfDs2vEYOaQoElnUGJmXQzGI2wt4djSzNj4/xKB4Hs6DFBwvXj+
 Y5J8nno8PtXdUW6xO90kwwWRLhO32kieYQc9jbR3VgwWd9E6ffminVj46oSUXpzj/jL34iAZt
 ifYUmAAotKh5qo=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/10 =E4=B8=8B=E5=8D=881:39, Sam Edwards wrote:
> Hello again,
>
> I've checked the hardware. The RAM tests out okay and SSD reads seem
> consistent. I'd be very surprised if this was hardware failure,
> though: the system isn't nearly old enough for degradation and I
> haven't seen any of the tell-tale signs of defective hardware.

Unless there is obvious corruption shown from btrfs tree-checker, we
won't even bother considering RAM bitflip.

But for SSD/HDD, we're more cautious about any transid error.

There are already known bad disks which don't follow FLUSH requests,
thus leads to super easy transid mismatch on powerloss:

https://btrfs.wiki.kernel.org/index.php/Hardware_bugs


But in your case, dm-crypto is another layer between btrfs and hardware,
thus we can't verify if it's dm-crypto or btrfs doing something wrong.

>
> Also, if this was due to bit flips in the SSD, the dm-crypt layer
> would amplify that across the 128-bit AES blocks (cipher mode is XTS).
> I'm not seeing signs of that either.
>
> I'm now pretty familiar with btrfs inspect-internal and have checked
> the trees manually. Absolutely nothing looks corrupt, but several
> leaf/node blocks are outdated. More interesting is the byte range of
> blocks that were "rolled back": 1065332064256-1065565601792, by my
> count. That fits pretty nicely in 256 MiB. This range is also not even
> close to aligned on a 256 MiB boundary in LBA terms - even taking into
> account luks and partition offsets. Thus this seems more like a
> software cache that didn't get flushed rather than a SSD bug.
>
> So, question: does the btrfs module use 256 MiB as a default size for
> write-back cache pages anywhere?

No.

> Or might this problem reside deeper
> in the block storage system?

So if possible, please test without dm-crypto to make sure it's really
btrfs causing the problem.

>
> Also, for what it's worth: the last generation to be written before
> these inconsistencies seems to be 66303. Files written as part of that
> transaction have a birth date of Sep. 7. That's during the same boot
> as the failure to read-only,

That's interesting.

Btrfs aborts transaction when it hits critical metadata problems to
prevent further damage, but I still remember some possible corruption
caused by aborting transaction in the old days.
But those corruptions should not exist in v5.14.

Furthermore, the read-only flips itself is more important, do you have
the dmesg of that incident?


Recently we also see some corrupted free space cache causing problems.

If you're going to re-test this, mind to use space cache v2 to do the
tests?

> which suggests that the cached buffer
> wasn't merely "not saved before a previous shutdown" but rather
> "discarded without being written back." Thoughts?

This should not be a thing for btrfs.

Btrfs COW protects its metadata, as long as there is no problem in btrfs
itself allocating new tree blocks to ex you're reporting some RO
incidents, then I guess the COW mechanism may be broken at that time
alreadyisting blocks in the same transaction, we're completely safe.

But considering you're reporting some RO incidents, then I guess the COW
mechanism may be broken at that time already.
(Maybe abort leads to some corrupted free space cache?)

Thanks,
Qu

>
> Cheers,
> Sam
>
>
> On Wed, Sep 8, 2021 at 6:47 PM Sam Edwards <cfsworks@gmail.com> wrote:
>>
>> Hello list,
>>
>> First, I should say that there's no urgency here on my part.
>> Everything important is very well backed up, and even the
>> "unimportant" files (various configs) seem readable. I imaged the
>> partition without even attempting a repair. Normally, my inclination
>> would be to shrug this off and recreate the filesystem.
>>
>> However, I'd like to help investigate the root cause, because:
>> 1. This happened suspiciously soon (see my timeline in the link below)
>> after upgrading to kernel 5.14.1, so may be a serious regression.
>> 2. The filesystem was created less than 5 weeks ago, so the possible
>> causes are relatively few.
>> 3. My last successful btrfs scrub was just before upgrading to 5.14.1,
>> hopefully narrowing possible root causes even more.
>> 4. I have imaged the partition and am thus willing to attempt risky
>> experimental repairs. (Mostly for the sake of reporting if they work.)
>>
>> Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no LVM=
)
>> OS: Gentoo
>> Earliest kernel ever used: 5.10.52-gentoo
>> First kernel version used for "real" usage: 5.13.8
>> Relevant information: See my Gist,
>> https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
>> Misc. notes: I have run "fstrim /" on occasion, but don't have
>> discards enabled automatically. I doubt TRIM is the culprit, but I
>> can't rule it out.
>>
>> My primary hypothesis is that there's some write bug in Linux 5.14.1.
>> I installed some package updates right before btrfs detected the
>> problem, and most of the files in the `btrfs check` output look like
>> they were created as part of those updates.
>>
>> My secondary hypothesis is that creating and/or using the swapfile
>> caused some kind of silent corruption that didn't become a detectable
>> issue until several further writes later.
>>
>> Let me know if there's anything else I should try/provide!
>>
>> Regards,
>> Sam
