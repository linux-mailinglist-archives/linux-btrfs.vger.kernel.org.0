Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D956A38DE01
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 01:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhEWXWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 19:22:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:46333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbhEWXWM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 19:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621812035;
        bh=75znUGmNjYlBrsCeBh8+QQInnpymmytztBuVyz5T9fk=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=GPLltnHpEi3zl2Unys/N8gqRL4EMtMjY07yRZ3ELeNmzc6vT8wSIg7dMJzxbu40m9
         Vkwea8lKx3e0ss6zPPdvcMVnKSiUwAQ3M8g7RaVmUILwV+sD31+Y8bALT51NOKoONI
         mav9NhAw+buGwTf5QNHlE7Y1QbiDj1zJVQX/NKjc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNtP-1l1yXv0l3t-00lpie; Mon, 24
 May 2021 01:20:34 +0200
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Andreas Falk <mail@andreasfalk.se>
Cc:     linux-btrfs@vger.kernel.org
References: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
 <20210523201550.GC11733@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs check discovered possibly inconsistent journal and now the
 errors are gone
Message-ID: <bcbfd681-7e98-39fa-71d1-231bf676fb8b@gmx.com>
Date:   Mon, 24 May 2021 07:20:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210523201550.GC11733@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SFLy8ZnKeHuHAQKSuIisv6MVNglZvsg3H3mgRHx/CC6ZXmRJeXy
 vtK1vXx+WZuKYTIe9wyJ/MGuXK6BBqjA1pQXVw5Spax8Dw0Xubodo7HdmCdugaSm9bnJAX+
 yeX4asPkLcGyaEOM6m5XdjZvcwUYPquowLxv16m9ZIevsY4Q0rUPU+fOgG391JDFzi0gF5i
 Mc7ckgk6jVfpfnZ1jakug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fM2fKQVIW8=:0u7kSxXsrf6ZhdMZ1WCfQq
 4PE7b3EE2UUCQf157yKo4WAtuah6rk3ZUGdaBavSx3JqerjuI7qK1BGf++MF7K9MegFibMYdL
 4aIZjO9qIUp0j3evw9K9Bs/E8QlPR1dAikLdasRBzqyzE3GrH0dwo6bwU2Qeb7cAteZRu2B6k
 jBcFvFfnlqGuaCUJOoicSEpxv9ZVXm+QQKTu9WhrmwlsjB5jkbaBEvNMu4mMQwktXFxOh8RgL
 gxu3Ht23ySYmifZ1lO170YHPx7quZ252gl7Nj16SO5Kqv/G25Fmu0C/3SHD/OJLszIMNFjumn
 HxTk5dFT0aeyw5C7KtuqDCYUSSYoajyNmLOnmblphxCtnMwjFFsiob4dQlzZEFUbaXqE4ifMU
 3GqgMxKHQUJeJ2T8pMgz2aj7+23rYWf5fUIBzBuYteCwsWgkvaqm2ycjeQ/1q0dCVJut7Tags
 g6vkeYIOMvc3WJ8AVr8OYfnDBnQgTHN/rk1NNyCmJSdPaLSk+pnvPq7RC0lKgt11Pbfxj3sqi
 ae1Udlsn6Gr1dAzfFL6QEDAQ7pvzEuoY2NJEz7R/3iM2oIDXFA2n5RhzsVRINtsUwXlWsUQy/
 E37gyiiEwXJX64zQKfbtSeeqxn8VySDvoJhoUpRTAxRmkgjcu/q0liNlYefXQA+riGeEO86Zi
 8dfeuPdrJCqncNo0vVnmfXpXhMm7jacDU2QPlzSIb1pbr4qj6us0tkE3N+nk17927tb0P7HoE
 0kq4o/jFRfIisHPNIZt6Y6xkNt2dQTRvsnHBKDRCHMUkcb0b46jBUyyFa31YtQqvBGBNBKq9B
 08oQwuUfGGbMuyMY4s66Aj7o4J5RxI9hc+ReCKD2ESOiPo2FzdZAkCMoDTQxw4700grsqDCw0
 LPRzIS+vPMWe+EdBPxi4WstixZuiLmFQmo6t1MdKQkx16/W5rYMKXaJbKLNfSR/49Ia9vfX0V
 x0cY682Nid4U2cU3lXOvPx0zdTSBFCYGPEuRHRp7hTVwKCJT6+Qh20lhwZY7a2m/5UEVVUREf
 61nluDiJVTsEIjuq0oxJyLOzhzArNlYIpCdw5081CZLhjqsQpnjl5s1kC6KbFL7UwtIHVp124
 q99Mxi9JBPdk3Rn8lZiPN6Wib9ScDPLhDl7x8b/3nlsqUYVdsXrpEUW5A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/24 =E4=B8=8A=E5=8D=884:15, Zygo Blaxell wrote:
> On Sun, May 23, 2021 at 04:55:16PM +0100, Andreas Falk wrote:
>> Hey,
>>
>> I want to start with clarifying that I've got backups of my important
>> data so what I'm asking here is primarily for my own education to
>> understand how btrfs works and to make restoring things more
>> convenient.
>>
>> I'm running a small home server with family photos etc with btrfs in
>> raid1 and we recently experienced a power cut. I wasn't around when it
>> got turned back on and when I finally got to it everything had run for
>> ~2h with the filesystem mounted in readwrite mode so I ran (after the
>> fact I realized that I should have probably unmounted immediately and
>> made sure /etc/fstab had everything in readonly mode):
>>
>> $ sudo btrfs check --readonly --force /dev/sdb
>
> Did you run that with the filesystem mounted?  If so, it explains all
> of the following errors, and the way they seem to appear and disappear.
> They are the result of btrfs check losing races against the filesystem
> while the filesystem moves metadata around.
>
> Don't run btrfs check on a mounted filesystem.  It won't work.
>
> Don't run btrfs check at all, unless there are errors the kernel cannot
> recover from with a scrub.  btrfs check necessarily has fewer data
> integrity checks than the kernel (otherwise it would not be able to repa=
ir
> anything)

I can't agree with that part though.

The truth is, although kernel has tree-checker, it doesn't do
cross-check for things like extent backref or anything crosses leaf
boundary.

Thus btrfs check can still detect problem better than kernel.

For things can be rejected by kernel tree-checker, it's still a
rejection, it's still a problem.
Not to mention sometimes tree-checker can be a little too sensitive,
like inode transid/generation problems, which won't really affect user
data at all.

I agree with the don't run btrfs check on mounted fs, unless it's RO
mounted.
But if possible, we still want user to run btrfs check and report back
any problem found.

> but that means check can stumble into problems that the kernel
> would have easily avoided, and can cause damage with --repair as a resul=
t.
>
> If you suspect damage to the filesystem (e.g. due to buggy firmware in
> the drives + power loss), then run btrfs scrub first.  If that reports n=
o
> errors (or corrects all the errors it does find), then there is usually
> no need to do anything else.

But corrupted extent tree like missing backref won't be detected by
scrub at all.
As scrub just checks the csum of data and metadata, it never checks the
contents of the metadata.

Such extent tree mismatch can later lead to broken COW.

Thus at least for now, btrfs check is still a very needed tool.

Thanks,
Qu

>
>> and it seemed to mostly run fine but after a while it started printing
>> messages like this along with what looked like some paths that were
>> problematic (from what I remember, but these are not my exact
>> messages):
>>
>> parent transid verify failed on 31302336512 wanted 62455 found 62456
>> parent transid verify failed on 31302336512 wanted 62455 found 62456
>> parent transid verify failed on 31302336512 wanted 62455 found 62456
>>
>> along with (these are my exact messages from a log that I saved):
>>
>> The following tree block(s) is corrupted in tree 259:
>> tree block bytenr: 17047541170176, level: 0, node key:
>> (18446744073709551606, 128, 25115695316992)
>> The following tree block(s) is corrupted in tree 260:
>> tree block bytenr: 17047541170176, level: 0, node key:
>> (18446744073709551606, 128, 25115695316992)
>> tree block bytenr: 17047547396096, level: 0, node key:
>> (18446744073709551606, 128, 25187668619264)
>> tree block bytenr: 17047547871232, level: 0, node key:
>> (18446744073709551606, 128, 25124709920768)
>> tree block bytenr: 17047549526016, level: 0, node key:
>> (18446744073709551606, 128, 25195576877056)
>> tree block bytenr: 17047551426560, level: 0, node key:
>> (18446744073709551606, 128, 25162283048960)
>> tree block bytenr: 17047551803392, level: 0, node key:
>> (18446744073709551606, 128, 25177327333376)
>>
>> I didn't have time to look into it deeper at the time and decided to
>> just shut it down cleanly until today when I'd have some time to look
>> further at it. I booted it today (still in readwrite unfortunately)
>> and immediately modified /etc/fstab to not mount any of the volumes,
>> disabled services that might touch them and then rebooted it again to
>> make sure it's not touching the disks anymore. Then I ran a check
>> again:
>>
>> $ sudo btrfs check --readonly --progress /dev/sdb
>
> If the filesystem is readonly then btrfs check has a lower chance of
> failure.  Still not zero, though.  btrfs check should only be run on
> unmounted filesystems, if it should be run at all.
>
>> and now it's no longer finding any problems or printing any paths that
>> are problematic.
>>
>> >From what I've understood from this[a] article, the errors I saw were
>> likely due to an inconsistent journal.
>
> One rule of thumb for finding bad advice about btrfs on the Internet is =
to
> ask if the author believes in the existence of a 'btrfs journal'.  If so=
,
> it's a safe bet that the author has no idea what they're writing about.
>
> btrfs doesn't use a journal.  It uses wandering trees for metadata
> integrity, and a log tree for fsync().  These store different things
> than a journal, and have very different failure behavior compared to
> journals in other filesystems.
>
>> Now for my questions:
>>
>> 1. I'm guessing that my reboots, in particular the ones where I still
>> had it mounted in readwrite mode somehow cleared the journal and
>> that's why I'm no longer seeing any errors. Does this sound
>> plausible/correct?
>
> Well, there's no journal, so that can't be part of any correct theory.
>
> It is most likely that there were no errors on disk in the first place.
> If btrfs check is reading metadata while btrfs was modifying it, then
> it will always see an inconsistent view of the filesystem.  Each time
> you run btrfs check, it will see a different inconsistent view of the
> filesystem, so old errors will disappear, and new ones could appear.
>
> That said, self-correction is not impossible.  Normally btrfs raid1 will
> automatically correct a corrupted mirror using data from a good mirror.
> This uniformly handles cases ranging from bits flipped in drive DRAM,
> writes that were dropped on their way to the disk (due to UNC sector,
> firmware bug, power loss, misdirected write, FTL failure, or hundreds
> of other possible reasons), and drives that temporarily disconnected
> from arrays.
>
>> The errors being gone without me manually clearing
>> them feels scary to me.
>
> btrfs will usually report such events in the kernel log and increment th=
e
> 'btrfs dev stats' counters, though there are a handful of exceptions.
>
> The correction is automatic when possible.  It occurs both on normal
> reads and during scrubs.
>
>> 2. Is there any way to identify the paths again that were problematic
>> based on the values in the log that I posted above so I can figure out
>> what to restore from backups rather than doing a full restore?
>
> The error messages you posted are all metadata tree issues.  Paths are
> in a higher layer of the filesystem.  Depending on which metadata is
> affected, anywhere from a few hundred paths to the entire filesystem
> may be affected.
>
> Note that if you ran 'btrfs check' on a mounted filesystem, the errors
> reported are most likely a result of that mistake, and you should ignore
> all of check's output under those conditions.
>
> If there are really unrecovered metadata errors on the disks then paths
> do not matter very much.  The filesystem cannot be safely modified in
> this case, so only a full mkfs + restore (or successful 'btrfs check
> --repair --init-extent-tree' run) can make the filesystem writable again=
.
>
> Note that we have no evidence that you are in this situation, or indeed
> any evidence of a problem at all.  Power failures are totally routine
> events for btrfs, and most drive firmware will handle them with no
> problems (though there are one or two popular drive models out there
> that won't).
>
>> a. https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/
>
> This article features a random mashup of btrfs recovery commands and
> error messages.  Half of it is simply wrong:  zero-log cannot fix a
> parent transid verify failed error, all but two btrfs errors imply that
> you don't need to run chunk-recover, there is no journal...
>
>> Thank you,
>> Andreas
