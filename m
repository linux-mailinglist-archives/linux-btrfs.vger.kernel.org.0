Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04D44898DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 13:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245680AbiAJMwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 07:52:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49214 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbiAJMww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 07:52:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3FBE61262;
        Mon, 10 Jan 2022 12:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083EBC36AF3;
        Mon, 10 Jan 2022 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641819171;
        bh=tV672hjjxcrx1fuMiL9LRDGPvjI8Wt3LrTwliO50J+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nyUF28XxXLE+LGKTNJizqwYYhvYyhvJAAjCcIxX/kh5cATb+v9OgpXxywyY4OvrJr
         kbBgR6Az2PobE4Krdm4Jd9ANJlxYYi/obfQSwhZT8jMLP1RjrMoWMLkfW4S6AvYfY8
         jMPOaXns4BHNazQDNFD9t/8jsgAZ8ZJqZpnKxvvDANpA7D1+PJboOdCfdtPIBgwfbR
         jWX/EUegThRFzyr8FcJPlWH+LdEz/2E+GQqrNntm3jtMteBtb/SN9/WHrxkl6sqQMY
         fW7XPD0W/Q2cegAzrzOnJetH+Oei1oRnws7TnPW8Fz+R4IYtn1NTxb2TtKaRco0cvZ
         uva/joMR3vZiw==
Received: by mail-qt1-f170.google.com with SMTP id l17so14256262qtk.7;
        Mon, 10 Jan 2022 04:52:50 -0800 (PST)
X-Gm-Message-State: AOAM530kbIbDvD3LIVkCrOx652KeRwjraYkbqUA0T5nssqxGhY0hqhgQ
        kE7F4Bj/410rThYoy/SUaAxI1Qe/64OnSbNgsm4=
X-Google-Smtp-Source: ABdhPJyfCgf8oPA5jEYYg7A9nHE4XOGTLv0t0Mfow+G1FxfeauAtFGGMwfOmZB3sBXwH/P5Fsh7Q1fF66k/+uOu8b40=
X-Received: by 2002:a05:622a:155:: with SMTP id v21mr14373256qtw.267.1641819170000;
 Mon, 10 Jan 2022 04:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20220110112848.37491-1-wqu@suse.com> <YdwfNDsgEGmTL6bY@debian9.Home>
 <7769bb16-39ae-73f7-e0e6-6a37c7d70dba@gmx.com>
In-Reply-To: <7769bb16-39ae-73f7-e0e6-6a37c7d70dba@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 10 Jan 2022 12:52:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7eCwzM=a39AEeKRzVTbTtkA=BMgVQNWVdZ3kw4-dox+A@mail.gmail.com>
Message-ID: <CAL3q7H7eCwzM=a39AEeKRzVTbTtkA=BMgVQNWVdZ3kw4-dox+A@mail.gmail.com>
Subject: Re: [PATCH] btrfs/011: handle finished replace properly
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 12:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/10 19:57, Filipe Manana wrote:
> > On Mon, Jan 10, 2022 at 07:28:48PM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> When running btrfs/011 inside VM which has unsafe cache set for its
> >> devices, and the host have enough memory to cache all the IO:
> >
> > Btw, I use the same setup and the test never fails for me.
> > It's quite of a strech assuming that using unsafe caching and having
> > enough memory are the only reasons for the failure.
> >
> > I use a debug kernel with plenty of heavy debug features enabled,
> > so that may be one reason why I can't trigger it.
>
> I guess that's the reason.
>
> For most cases I only enable light-weight debug features for regular runs.
> The heavy ones like KASAN/kmemleak are reserved for more tricky cases.
>
> >
> >>
> >> btrfs/011 98s ... [failed, exit status 1]- output mismatch
> >>      --- tests/btrfs/011.out 2019-10-22 15:18:13.962298674 +0800
> >>      +++ /xfstests-dev/results//btrfs/011.out.bad    2022-01-10 19:12:14.683333251 +0800
> >>      @@ -1,3 +1,4 @@
> >>       QA output created by 011
> >>       *** test btrfs replace
> >>      -*** done
> >>      +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
> >>      +(see /xfstests-dev/results//btrfs/011.full for details)
> >>      ...
> >> Ran: btrfs/011
> >> Failures: btrfs/011
> >> Failed 1 of 1 tests
> >>
> >> [CAUSE]
> >> Although commit fa85aa64 ("btrfs/011: Fill the fs to ensure we
> >> have enough data for dev-replace") tries to address the problem by
> >> filling the fs with extra content, there is still no guarantee that 2
> >> seconds of IO still needs 2 seconds to finish.
> >>
> >> Thus even we tried our best to make sure the replace will take 2
> >> seconds, it can still finish faster than 2 seconds.
> >>
> >> And just to mention how fast the test finishes, after the fix, the test
> >> takes around 90~100 seconds to finish.
> >> While on real-hardware it can take over 1000 seconds.
> >>
> >> [FIX]
> >> Instead of further enlarging the IO, here we just accept the fact that
> >> replace can finish faster than our expectation, and continue the test.
> >
> > If I'm reading this, and the code, correctly this means we end up never
> > testing that the replace cancel feature ends up being exercised and
> > while a replace is in progress. That's far from ideal, losing test
> > coverage.
>
> Yep, you're completely right.
>
> In fact for my environment, only around 10% runs really utilized the
> cancel path, the remaining 90% go finished routine.
>
> But...
>
> >
> > Josef sent a patch for this last month:
> >
> > https://lore.kernel.org/linux-btrfs/01796d6bcec40ae80b5af3269e60a66cd4b89262.1638382763.git.josef@toxicpanda.com/
> >
> > Don't know why it wasn't merged. I agree that changing timings in the
> > test is not ideal and always prone to still fail on some setups, but
> > seems more acceptable to me rather than losing test coverage.
>
> My concern is, it's just going to be another whac-a-mole game.
>
> With more RAM in the host, and further optimization, I'm not sure if 10
> seconds is enough.
> Furthermore 10 seconds may be too long for certain environment, to fill
> the whole test filesystem and cause other false alerts.
>
> As a safenet, we have dedicated cancel workload test in btrfs/212, and

btrfs/212 is about balance, not device replace.

> IIRC for most (if not all) bugs exposed in btrfs/011, it's in the
> regular replace path, not the cancel path.

Even if we have had few bugs in the replace cancel patch, compared to
the regular replace path,
that's not an excuse to remove or reduce replace cancel coverage.

>
> Thus I want to end the whac-a-hole game once and for all, even it will
> drop the coverage for super fast setup.

If everyone starts having a setup that is faster, then we will end up
not getting replace cancel covered in the long run,
and increasing the chances of finding out regressions only after
kernels are released, by users.

As I said earlier, I agree that the whac-a-mole style of change sent
by Josef is far from ideal, but at least it doesn't lose test
coverage.

Thanks.



>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> One thing to notice is, since the replace finished, we need to replace
> >> back the device, or later fsck will be executed on blank device, and
> >> cause false alert.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   tests/btrfs/011 | 15 +++++++++++++--
> >>   1 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> >> index b4673341..aae89696 100755
> >> --- a/tests/btrfs/011
> >> +++ b/tests/btrfs/011
> >> @@ -171,13 +171,24 @@ btrfs_replace_test()
> >>              # background the replace operation (no '-B' option given)
> >>              _run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
> >>              sleep $wait_time
> >> -            _run_btrfs_util_prog replace cancel $SCRATCH_MNT
> >> +            $BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $seqres.full
> >>
> >>              # 'replace status' waits for the replace operation to finish
> >>              # before the status is printed
> >>              $BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
> >>              cat $tmp.tmp >> $seqres.full
> >> -            grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
> >> +
> >> +            # There is no guarantee we canceled the replace, it can finish
> >> +            if grep -q 'finished' $tmp.tmp ; then
> >> +                    # The replace finished, we need to replace it back or
> >> +                    # later fsck will report error as $SCRATCH_DEV is now
> >> +                    # blank
> >> +                    $BTRFS_UTIL_PROG replace start -Bf $target_dev \
> >> +                            $source_dev $SCRATCH_MNT > /dev/null
> >> +            else
> >> +                    grep -q 'canceled' $tmp.tmp || _fail \
> >> +                            "btrfs replace status (canceled ) failed"
> >> +            fi
> >>      else
> >>              if [ "${quick}Q" = "thoroughQ" ]; then
> >>                      # The thorough test runs around 2 * $wait_time seconds.
> >> --
> >> 2.34.1
> >>
