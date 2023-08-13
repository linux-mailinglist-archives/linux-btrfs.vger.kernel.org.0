Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7477A613
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHMLCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 07:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHMLCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 07:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E463170D;
        Sun, 13 Aug 2023 04:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262FE61950;
        Sun, 13 Aug 2023 11:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A40EC433C8;
        Sun, 13 Aug 2023 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691924552;
        bh=UvA73neR78vkE+SW834hmvUxPCYMsj9hk0MudjnYNGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i3P3tsz346vLXDnuAbVcmuqK8tbi8cOI0OmMKGOW9fs7dNK3fIJiMqBCzUUyJ10sq
         diF9b11h97FEG/PwybgZ/KgqDvM/K3/dxZUy4cor3nE2YvW21PJneKy7crJ5YHH1b0
         ueu21uGtE4PhDRPRiCLVCTDe/0P7OTzLZFhgVVRMYqTSn5MuK+pzuKu7IkZqhTdo2r
         wPh2wxuL9eA8mgiRMkUOiybeHnmfFlZkQvhy4f6uLV8xhD2CEYprN42GyN1OYyhCis
         DriuPKvjrEiXmcCCtM9IAfZ4H+pixgD+iNrpxWvQDMcDJNYTOw1BtofMMvkKk53nqB
         g2cfOPVJgxWhw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a44cccbd96so2739419b6e.3;
        Sun, 13 Aug 2023 04:02:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy34TRMDHib0WN0vGbr0bWTIFrZGP/j+Woh6hsH2e0XyThxbupa
        dRyeqdUH7ttzsARk+pBbWkVnMTsuD4vePYIeg+E=
X-Google-Smtp-Source: AGHT+IEXUaph6nuD84BycE4t4QnJ2E10VABJCIUB3bbALvgssFzPcXinTZY5F642nXfpULLpLszuRBhSmyPQysmPPuE=
X-Received: by 2002:a05:6808:4388:b0:3a1:c108:41b1 with SMTP id
 dz8-20020a056808438800b003a1c10841b1mr7764540oib.25.1691924551685; Sun, 13
 Aug 2023 04:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <1e2924e9a604f781ad446ba8e2d789583e377837.1684408079.git.fdmanana@suse.com>
 <ff12321e5ddfdb763b9258f746e67fe3f6ea1321.1684489375.git.fdmanana@suse.com> <20230812204850.B86D.409509F4@e16-tech.com>
In-Reply-To: <20230812204850.B86D.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 13 Aug 2023 12:01:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5aZ8CAfvw241qKMty59ZBur4Ld2FCY3bwqAwZDXA7kmA@mail.gmail.com>
Message-ID: <CAL3q7H5aZ8CAfvw241qKMty59ZBur4Ld2FCY3bwqAwZDXA7kmA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/213: avoid occasional failure due to already
 finished balance
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 12, 2023 at 1:54=E2=80=AFPM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
>
> Hi,
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > btrfs/213 writes data, in 1M extents, for 4 seconds into a file, then
> > triggers a balance and then after 2 seconds it tries to cancel the
> > balance operation. More often than not, this works because the balance
> > is still running after 2 seconds. However it also fails sporadically
> > because balance has finished in less than 2 seconds, which is plausible
> > since data and metadata are cached or other factors such as virtualized
> > environment. When that's the case, it fails like this:
> >
> >   $ ./check btrfs/213
> >   FSTYP         -- btrfs
> >   PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc1-btrfs-next-131+ #1 SM=
P PREEMPT_DYNAMIC Thu May 11 11:26:19 WEST 2023
> >   MKFS_OPTIONS  -- /dev/sdc
> >   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> >   btrfs/213 51s ... - output mismatch (see /home/fdmanana/git/hub/xfste=
sts/results//btrfs/213.out.bad)
> >       --- tests/btrfs/213.out 2020-06-10 19:29:03.822519250 +0100
> >       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad  2=
023-05-17 15:39:32.653727223 +0100
> >       @@ -1,2 +1,3 @@
> >        QA output created by 213
> >       +ERROR: balance cancel on '/home/fdmanana/btrfs-tests/scratch_1' =
failed: Not in progress
> >        Silence is golden
> >       ...
> >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/213.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/213.out.bad'  to see the en=
tire diff)
> >   Ran: btrfs/213
> >   Failures: btrfs/213
> >   Failed 1 of 1 tests
> >
> > To make it much less likely that balance has already finished before we
> > try to cancel it, unmount and mount again the filesystem before startin=
g
> > balance, to clear cached metadata and data, and also double the time we
> > spend writing 1M data extents. Also make the test not run with an
> > informative message if we detect that balance finished before we could
> > cancel it.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > v2: Make the test _notrun if we detect that balance finished before we
> >     could cancel it.
> >
> >  tests/btrfs/213 | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/btrfs/213 b/tests/btrfs/213
> > index e16e41c0..5666d9b9 100755
> > --- a/tests/btrfs/213
> > +++ b/tests/btrfs/213
> > @@ -31,7 +31,7 @@ _fixed_by_kernel_commit 1dae7e0e58b4 \
> >  _scratch_mkfs >> $seqres.full
> >  _scratch_mount
> >
> > -runtime=3D4
> > +runtime=3D8
> >
> >  # Create enough IO so that we need around $runtime seconds to relocate=
 it.
> >  #
> > @@ -42,11 +42,21 @@ sleep $runtime
> >  kill $write_pid
> >  wait $write_pid
> >
> > +# Unmount and mount again the fs to clear any cached data and metadata=
, so that
> > +# it's less likely balance has already finished when we try to cancel =
it below.
> > +_scratch_cycle_mount
> > +
> >  # Now balance should take at least $runtime seconds, we can cancel it =
at
> >  # $runtime/2 to ensure a success cancel.
> >  _run_btrfs_balance_start -d --bg "$SCRATCH_MNT"
> > -sleep $(($runtime / 2))
> > -$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> > +sleep $(($runtime / 4))
> > +# It's possible that balance has already completed. It's unlikely but =
often
> > +# it may happen due to virtualization, caching and other factors, so i=
gnore
> > +# any error about no balance currently running.
> > +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in=
 progress'
> > +if [ $? -eq 0 ]; then
> > +     _not_run "balance finished before we could cancel it"
> > +fi
>
> fstests(btrfs/213) failed once here.
>
> btrfs/213 22s ... - output mismatch (see /usr/hpc-bio/xfstests/results//b=
trfs/213.out.bad)
>     --- tests/btrfs/213.out     2023-03-28 06:09:10.372680814 +0800
>     +++ /usr/hpc-bio/xfstests/results//btrfs/213.out.bad        2023-08-1=
2 20:31:47.848303940 +0800
>     @@ -1,2 +1,5 @@
>      QA output created by 213
>     +/usr/hpc-bio/xfstests/tests/btrfs/213: line 59: _not_run: command no=
t found
>     +ERROR: error during balancing '/mnt/scratch': No space left on devic=
e
>     +There may be more info in syslog - try dmesg | tail
>      Silence is golden
>
> we need to fix the error of '_not_run: command not found'  firstly.
>
> I will update the info if fstests(btrfs/213) fails again.

It's a misspelled function name, it should be _notrun instead of
_not_run. I just sent a fix for that.

The test is not very reliable as balance can finish quickly, so
occasionally it may be skipped in some environments.

Thanks.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/08/12
>
>
>
