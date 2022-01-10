Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46D0489ADC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 14:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiAJNyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 08:54:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41246 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiAJNyr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 08:54:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B09E8B81626;
        Mon, 10 Jan 2022 13:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D66C36AE5;
        Mon, 10 Jan 2022 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641822884;
        bh=AMpPZwuBeFlui573JA2JW/+6jV7sNHFamUmo+CvSvDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NNFcs1nVe3gwgmT6pBBSxmVMWFYpkDQXsihvJ+HBioPLnN3/AkwH2Ob2+5lSkOywT
         /NB25DYNu8oS+WsbRBCAs3WJFZ6JEKcCTBYScrnpTSjq9MRwLOqMNz/2HApoSmZ6DC
         2Xhd8ZfOdg9ghogEICz39ra0VIWsS9dHGSs6eE1iFvHNK4NIdXh/MUU76skLEjNGHo
         6sKSqpqFajUTUVFvDyEUV4JPZOqQRB9FRXqeHiX+qUcySqoHL3UqNRtw5P67GjxlTy
         XeWpnXoNW2eLbpBfQkMtaAZhWNsQ6ruGbTRqiKCa2yia2uCLuH/eo0rYxez2vu+8Ky
         B9ZSCs9y17c5g==
Received: by mail-qv1-f54.google.com with SMTP id a8so9081523qvx.2;
        Mon, 10 Jan 2022 05:54:44 -0800 (PST)
X-Gm-Message-State: AOAM530jiu/AD06tgL3CXkw1yyN0yfaV8YcIpvNthEUkrqZeXC4LtTVJ
        UYHQwnxhyTmXJaRNRw7iBHWcN0P7y8wfRhmAYW8=
X-Google-Smtp-Source: ABdhPJw1IWPbv6lgOGP9A5ofWCyEAvv8YYgEgLdg96T6uRr1d/XYLq/Ldjxp+uathpOs35WnSltSza2KXaW/iCEENJY=
X-Received: by 2002:a05:6214:27e9:: with SMTP id jt9mr8223940qvb.89.1641822883490;
 Mon, 10 Jan 2022 05:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20220110112848.37491-1-wqu@suse.com> <YdwfNDsgEGmTL6bY@debian9.Home>
 <7769bb16-39ae-73f7-e0e6-6a37c7d70dba@gmx.com> <CAL3q7H7eCwzM=a39AEeKRzVTbTtkA=BMgVQNWVdZ3kw4-dox+A@mail.gmail.com>
 <4e33b90e-4224-b320-ce3c-207a54cae1d0@gmx.com>
In-Reply-To: <4e33b90e-4224-b320-ce3c-207a54cae1d0@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 10 Jan 2022 13:54:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7EdN=LvsnTuhVU5u=W5D84p7Z7YqPAugCvpAsYsU2_-g@mail.gmail.com>
Message-ID: <CAL3q7H7EdN=LvsnTuhVU5u=W5D84p7Z7YqPAugCvpAsYsU2_-g@mail.gmail.com>
Subject: Re: [PATCH] btrfs/011: handle finished replace properly
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 1:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/10 20:52, Filipe Manana wrote:
> > On Mon, Jan 10, 2022 at 12:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/1/10 19:57, Filipe Manana wrote:
> >>> On Mon, Jan 10, 2022 at 07:28:48PM +0800, Qu Wenruo wrote:
> >>>> [BUG]
> >>>> When running btrfs/011 inside VM which has unsafe cache set for its
> >>>> devices, and the host have enough memory to cache all the IO:
> >>>
> >>> Btw, I use the same setup and the test never fails for me.
> >>> It's quite of a strech assuming that using unsafe caching and having
> >>> enough memory are the only reasons for the failure.
> >>>
> >>> I use a debug kernel with plenty of heavy debug features enabled,
> >>> so that may be one reason why I can't trigger it.
> >>
> >> I guess that's the reason.
> >>
> >> For most cases I only enable light-weight debug features for regular runs.
> >> The heavy ones like KASAN/kmemleak are reserved for more tricky cases.
> >>
> >>>
> >>>>
> >>>> btrfs/011 98s ... [failed, exit status 1]- output mismatch
> >>>>       --- tests/btrfs/011.out 2019-10-22 15:18:13.962298674 +0800
> >>>>       +++ /xfstests-dev/results//btrfs/011.out.bad    2022-01-10 19:12:14.683333251 +0800
> >>>>       @@ -1,3 +1,4 @@
> >>>>        QA output created by 011
> >>>>        *** test btrfs replace
> >>>>       -*** done
> >>>>       +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
> >>>>       +(see /xfstests-dev/results//btrfs/011.full for details)
> >>>>       ...
> >>>> Ran: btrfs/011
> >>>> Failures: btrfs/011
> >>>> Failed 1 of 1 tests
> >>>>
> >>>> [CAUSE]
> >>>> Although commit fa85aa64 ("btrfs/011: Fill the fs to ensure we
> >>>> have enough data for dev-replace") tries to address the problem by
> >>>> filling the fs with extra content, there is still no guarantee that 2
> >>>> seconds of IO still needs 2 seconds to finish.
> >>>>
> >>>> Thus even we tried our best to make sure the replace will take 2
> >>>> seconds, it can still finish faster than 2 seconds.
> >>>>
> >>>> And just to mention how fast the test finishes, after the fix, the test
> >>>> takes around 90~100 seconds to finish.
> >>>> While on real-hardware it can take over 1000 seconds.
> >>>>
> >>>> [FIX]
> >>>> Instead of further enlarging the IO, here we just accept the fact that
> >>>> replace can finish faster than our expectation, and continue the test.
> >>>
> >>> If I'm reading this, and the code, correctly this means we end up never
> >>> testing that the replace cancel feature ends up being exercised and
> >>> while a replace is in progress. That's far from ideal, losing test
> >>> coverage.
> >>
> >> Yep, you're completely right.
> >>
> >> In fact for my environment, only around 10% runs really utilized the
> >> cancel path, the remaining 90% go finished routine.
> >>
> >> But...
> >>
> >>>
> >>> Josef sent a patch for this last month:
> >>>
> >>> https://lore.kernel.org/linux-btrfs/01796d6bcec40ae80b5af3269e60a66cd4b89262.1638382763.git.josef@toxicpanda.com/
> >>>
> >>> Don't know why it wasn't merged. I agree that changing timings in the
> >>> test is not ideal and always prone to still fail on some setups, but
> >>> seems more acceptable to me rather than losing test coverage.
> >>
> >> My concern is, it's just going to be another whac-a-mole game.
> >>
> >> With more RAM in the host, and further optimization, I'm not sure if 10
> >> seconds is enough.
> >> Furthermore 10 seconds may be too long for certain environment, to fill
> >> the whole test filesystem and cause other false alerts.
> >>
> >> As a safenet, we have dedicated cancel workload test in btrfs/212, and
> >
> > btrfs/212 is about balance, not device replace.
>
> Oh, my bad.
>
> Then I guess it's time for us to have dedicated replace and cancel test
> case.
>
> >
> >> IIRC for most (if not all) bugs exposed in btrfs/011, it's in the
> >> regular replace path, not the cancel path.
> >
> > Even if we have had few bugs in the replace cancel patch, compared to
> > the regular replace path,
> > that's not an excuse to remove or reduce replace cancel coverage.
> >
> >>
> >> Thus I want to end the whac-a-hole game once and for all, even it will
> >> drop the coverage for super fast setup.
> >
> > If everyone starts having a setup that is faster, then we will end up
> > not getting replace cancel covered in the long run,
> > and increasing the chances of finding out regressions only after
> > kernels are released, by users.
> >
> > As I said earlier, I agree that the whac-a-mole style of change sent
> > by Josef is far from ideal, but at least it doesn't lose test
> > coverage.
>
> It still doesn't solve the possible false alerts, it's doing masking,
> just a different way.
>
> But that masking will eventually hit ENOSPC and cause a different false
> alerts.
>
>
> If we have dedicated replace cancel tests, can we remove the false-alert
> prone cancel test in btrfs/011?

In the end it's the same problem however, making sure that by the time
the cancel is requested, the replace operation is still in progress.

I don't see how making that in a separate test case will be more
reliable, unless you're considering something like dm delay (and in
that case why can't it be made in btrfs/011).

Thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Thanks.
> >>>
> >>>>
> >>>> One thing to notice is, since the replace finished, we need to replace
> >>>> back the device, or later fsck will be executed on blank device, and
> >>>> cause false alert.
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>>    tests/btrfs/011 | 15 +++++++++++++--
> >>>>    1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> >>>> index b4673341..aae89696 100755
> >>>> --- a/tests/btrfs/011
> >>>> +++ b/tests/btrfs/011
> >>>> @@ -171,13 +171,24 @@ btrfs_replace_test()
> >>>>               # background the replace operation (no '-B' option given)
> >>>>               _run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
> >>>>               sleep $wait_time
> >>>> -            _run_btrfs_util_prog replace cancel $SCRATCH_MNT
> >>>> +            $BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $seqres.full
> >>>>
> >>>>               # 'replace status' waits for the replace operation to finish
> >>>>               # before the status is printed
> >>>>               $BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
> >>>>               cat $tmp.tmp >> $seqres.full
> >>>> -            grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
> >>>> +
> >>>> +            # There is no guarantee we canceled the replace, it can finish
> >>>> +            if grep -q 'finished' $tmp.tmp ; then
> >>>> +                    # The replace finished, we need to replace it back or
> >>>> +                    # later fsck will report error as $SCRATCH_DEV is now
> >>>> +                    # blank
> >>>> +                    $BTRFS_UTIL_PROG replace start -Bf $target_dev \
> >>>> +                            $source_dev $SCRATCH_MNT > /dev/null
> >>>> +            else
> >>>> +                    grep -q 'canceled' $tmp.tmp || _fail \
> >>>> +                            "btrfs replace status (canceled ) failed"
> >>>> +            fi
> >>>>       else
> >>>>               if [ "${quick}Q" = "thoroughQ" ]; then
> >>>>                       # The thorough test runs around 2 * $wait_time seconds.
> >>>> --
> >>>> 2.34.1
> >>>>
