Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15757D0D07
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376746AbjJTKXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Oct 2023 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjJTKXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Oct 2023 06:23:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6FD45;
        Fri, 20 Oct 2023 03:23:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE398C433C8;
        Fri, 20 Oct 2023 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697797417;
        bh=g4qUJ9Smj0zNwg8INGdYpPR6dJJTsnSXD/QBmWulOIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VqUN8VQM6zSS3xJY23qQUyzpyoRIRaK9ILEHxNHCihkEOCQDXZI3svkua4Wryhjxf
         A+Su+kamHiRQzdG35Hp9+t3FIERTVaSyjZuvUDw1iqrijLE7j+7uZYW7OLoBwR9bSU
         bKLHqPEiahBnOTZmN1LT+wQhf8RZIAQo3jbHhvvpA+V7hWIMdpFdTWbN5ypW+b3z6p
         jle6deKLkcA+HFsTyQwDDC59K3VL8Stj6qq2Yy4PnpdQ3QPOyIT38p+eSFWp0m1O5X
         AeFKe+O1F45AW0VcOeBVop8ZgstPZroKoHtE7Bv7SFa1XaJadPhZZ1q0TH/CZJGY0o
         f030lZfHQ61RA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9c41e95efcbso96152166b.3;
        Fri, 20 Oct 2023 03:23:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YzccwBn8G94m3W7IQDyciXuxD92OkwDEfbAY8Y6kqSKmHQU2QXE
        GZsY66FMAfoTkiZNCDaGPAL3GbTU8g6pt+uh/eg=
X-Google-Smtp-Source: AGHT+IHyKmiTiC1hlE2oCJ1IfM/Ytoggtds1sL0JACFSp217Ug7ulgJmvE9XuGcKSPCtH7CE35Yoou7B7SdDt1BSMVI=
X-Received: by 2002:a17:907:9492:b0:9ae:82b4:e306 with SMTP id
 dm18-20020a170907949200b009ae82b4e306mr1086284ejc.62.1697797415930; Fri, 20
 Oct 2023 03:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231018194658.3703329-1-zlang@kernel.org> <20231019143143.GC11391@frogsfrogsfrogs>
 <20231019181126.gu4g37sess2bmw6a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20231019181126.gu4g37sess2bmw6a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 20 Oct 2023 11:22:58 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5qSATSW8T6oejqtjQgAAY6oLEygUKCy6zMV+xKgMOJ+A@mail.gmail.com>
Message-ID: <CAL3q7H5qSATSW8T6oejqtjQgAAY6oLEygUKCy6zMV+xKgMOJ+A@mail.gmail.com>
Subject: Re: [PATCH] fstests: filter out fsstress error output
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        fdmanana@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 19, 2023 at 7:12=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, Oct 19, 2023 at 07:31:43AM -0700, Darrick J. Wong wrote:
> > On Thu, Oct 19, 2023 at 03:46:58AM +0800, Zorro Lang wrote:
> > > The f55e46d6 ("fstests: redirect fsstress' stdout to $seqres.full
> > > instead of /dev/null") did lots of changes as below:
> > >
> > >   -$FSSTRESS_PROG $args >/dev/null 2>&1 &
> > >   +$FSSTRESS_PROG $args >>$seqres.full &
> > >
> > > Although it's good to replace /dev/null with $seqres.full, but the
> > > change also removed the "2>&1", that againsts the original behavior.
> > > Some test cases might want to ignore fsstress error output, but now
> > > the error output breaks the gardon image. For example:
> > >
> > >   FSTYP         -- xfs (non-debug)
> > >   PLATFORM      -- Linux/s390x xxx-xxx-xxx
> > >   MKFS_OPTIONS  -- -f -m crc=3D1,finobt=3D1,reflink=3D1,rmapbt=3D1,bi=
gtime=3D1,inobtcount=3D1 -b size=3D1024 /dev/loop1
> > >   MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/loop=
1 /mnt/fstests/SCRATCH_DIR
> > >
> > >   generic/269       - output mismatch (see /var/lib/xfstests/results/=
/generic/269.out.bad)
> > >       --- tests/generic/269.out     2023-10-17 22:32:46.162110249 -04=
00
> > >       +++ /var/lib/xfstests/results//generic/269.out.bad    2023-10-1=
7 23:07:45.752145653 -0400
> > >       @@ -3,3 +3,60 @@
> > >        Run fsstress
> > >
> > >        Run dd writers in parallel
> > >       +p36: No such file or directory
> > >       +p41: No such file or directory
> > >       +p42: No such file or directory
> > >       +p43: No such file or directory
> > >       ...
> > >
> > > The generic/269 hopes to run fsstress with ENOSPC error, so it
> > > redirects stderr to /dev/null. But now it fails.
> > >
> > > The f55e46d6 ("fstests: redirect fsstress' stdout to $seqres.full
> > > instead of /dev/null") only wants to redirect stdout, so we'd better
> > > to keep stderr output to /dev/null, if a case hopes to do that.
> > >
> > > Fixes: f55e46d6 ("fstests: redirect fsstress' stdout to $seqres.full =
instead of /dev/null")
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > >
> > > Hi,
> > >
> > > This patch only trys to bring "2>&1" back, if case has it at beginnin=
g. To make
> > > sure we don't break the original behavior of these cases.
> > >
> > > If some of below cases really want to remove the "2>&1", better to do=
 that in
> > > another patch, and show a proper reason.
> > >
> > > Thanks,
> > > Zorro
> > >
> > >  tests/btrfs/028   | 2 +-
> > >  tests/btrfs/049   | 2 +-
> > >  tests/btrfs/060   | 2 +-
> > >  tests/btrfs/061   | 2 +-
> > >  tests/btrfs/062   | 2 +-
> > >  tests/btrfs/063   | 2 +-
> > >  tests/btrfs/064   | 2 +-
> > >  tests/btrfs/065   | 2 +-
> > >  tests/btrfs/066   | 2 +-
> > >  tests/btrfs/067   | 2 +-
> > >  tests/btrfs/068   | 2 +-
> > >  tests/btrfs/069   | 2 +-
> > >  tests/btrfs/070   | 2 +-
> > >  tests/btrfs/071   | 2 +-
> > >  tests/btrfs/072   | 2 +-
> > >  tests/btrfs/073   | 2 +-
> > >  tests/btrfs/074   | 2 +-
> > >  tests/btrfs/136   | 2 +-
> > >  tests/btrfs/192   | 2 +-
> > >  tests/btrfs/232   | 2 +-
> > >  tests/btrfs/261   | 2 +-
> > >  tests/btrfs/286   | 2 +-
> > >  tests/ext4/057    | 2 +-
> > >  tests/ext4/307    | 2 +-
> > >  tests/generic/068 | 2 +-
> > >  tests/generic/269 | 2 +-
> > >  tests/xfs/051     | 2 +-
> >
> > These two changes (269, 051) duplicates
> > https://lore.kernel.org/fstests/169687550821.3948976.689216161600839359=
4.stgit@frogsfrogsfrogs/T/#m613d9379a026fcae5357650af09d5d0725d324f5
>
> Thanks for fixing it.
>
> >
> > AFAICT the other generic and xfs tests aren't setting up fsstress to hi=
t
> > errors, so we should be dumping them to the golden output because that'=
s
> > a sign that something has gone very wrong.
> >
> > I suppose prior to f55e46d629 ("fstests: redirect fsstress' stdout to
> > $seqres.full instead of /dev/null") we'd discard the error messages.
> >
> > OTOH I've now run the generic and xfs tests with stderr going to the
> > .out file and none of them complain, so I'd prefer to see those tests
> > stay the way they are now.
>
> OK, due to that commit affects btrfs specific cases more, besides btrfs p=
art
> there're only below 5 cases removed the "2>&1":
>
> ext4/057
> ext4/307
> generic/068
> generic/269
> xfs/051
>
> As we've reviewed generic and xfs part, and will fix generic/269 and xfs/=
051,
> and those two ext4 cases look good without the "2>&1". So *if btrfs list =
feels
> good without the stderr filter*, I can drop this patch.

The stderr filter is not needed for the btrfs tests.
None of them expects errors from fsstress, so we want the tests to
fail in case fsstress faisl.

Thanks.

>
> Thanks,
> Zorro
>
> >
> > --D
> >
> > >  tests/xfs/057     | 2 +-
> > >  tests/xfs/297     | 2 +-
> > >  tests/xfs/305     | 2 +-
> > >  tests/xfs/538     | 2 +-
> > >  31 files changed, 31 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/tests/btrfs/028 b/tests/btrfs/028
> > > index d860974e..c4853e06 100755
> > > --- a/tests/btrfs/028
> > > +++ b/tests/btrfs/028
> > > @@ -35,7 +35,7 @@ args=3D`_scale_fsstress_args -z \
> > >     -f fsync=3D10 -n 100000 -p 2 \
> > >     -d $SCRATCH_MNT/stress_dir`
> > >  echo "Run fsstress $args" >>$seqres.full
> > > -$FSSTRESS_PROG $args >>$seqres.full &
> > > +$FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >  fsstress_pid=3D$!
> > >
> > >  echo "Start balance" >>$seqres.full
> > > diff --git a/tests/btrfs/049 b/tests/btrfs/049
> > > index c48e4087..e5f37ccd 100755
> > > --- a/tests/btrfs/049
> > > +++ b/tests/btrfs/049
> > > @@ -42,7 +42,7 @@ args=3D`_scale_fsstress_args -z \
> > >     -f write=3D10 -f creat=3D10 \
> > >     -n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
> > >  echo "Run fsstress $args" >>$seqres.full
> > > -$FSSTRESS_PROG $args >>$seqres.full
> > > +$FSSTRESS_PROG $args >>$seqres.full 2>&1
> > >
> > >  # Start and pause balance to ensure it will be restored on remount
> > >  echo "Start balance" >>$seqres.full
> > > diff --git a/tests/btrfs/060 b/tests/btrfs/060
> > > index a0184891..5c10fc51 100755
> > > --- a/tests/btrfs/060
> > > +++ b/tests/btrfs/060
> > > @@ -38,7 +38,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start balance worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/061 b/tests/btrfs/061
> > > index c1010413..407066e3 100755
> > > --- a/tests/btrfs/061
> > > +++ b/tests/btrfs/061
> > > @@ -36,7 +36,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start balance worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/062 b/tests/btrfs/062
> > > index 818a0156..dacf56db 100755
> > > --- a/tests/btrfs/062
> > > +++ b/tests/btrfs/062
> > > @@ -37,7 +37,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start balance worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/063 b/tests/btrfs/063
> > > index 2f771baf..88d0ed21 100755
> > > --- a/tests/btrfs/063
> > > +++ b/tests/btrfs/063
> > > @@ -36,7 +36,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start balance worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/064 b/tests/btrfs/064
> > > index e9b46ce6..cad78248 100755
> > > --- a/tests/btrfs/064
> > > +++ b/tests/btrfs/064
> > > @@ -46,7 +46,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     # Start both balance and replace in the background.
> > > diff --git a/tests/btrfs/065 b/tests/btrfs/065
> > > index c4b6aafe..d388f1e1 100755
> > > --- a/tests/btrfs/065
> > > +++ b/tests/btrfs/065
> > > @@ -46,7 +46,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     # make sure the stop sign is not there
> > > diff --git a/tests/btrfs/066 b/tests/btrfs/066
> > > index a29034bb..ecb35f38 100755
> > > --- a/tests/btrfs/066
> > > +++ b/tests/btrfs/066
> > > @@ -38,7 +38,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     # make sure the stop sign is not there
> > > diff --git a/tests/btrfs/067 b/tests/btrfs/067
> > > index 709db155..d9808177 100755
> > > --- a/tests/btrfs/067
> > > +++ b/tests/btrfs/067
> > > @@ -39,7 +39,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     # make sure the stop sign is not there
> > > diff --git a/tests/btrfs/068 b/tests/btrfs/068
> > > index 15fd41db..321bb4d2 100755
> > > --- a/tests/btrfs/068
> > > +++ b/tests/btrfs/068
> > > @@ -39,7 +39,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     # make sure the stop sign is not there
> > > diff --git a/tests/btrfs/069 b/tests/btrfs/069
> > > index 139dde48..4a65c7e5 100755
> > > --- a/tests/btrfs/069
> > > +++ b/tests/btrfs/069
> > > @@ -44,7 +44,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start replace worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/070 b/tests/btrfs/070
> > > index 54aa275c..b823d95b 100755
> > > --- a/tests/btrfs/070
> > > +++ b/tests/btrfs/070
> > > @@ -45,7 +45,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start replace worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/071 b/tests/btrfs/071
> > > index 6ebbd8cc..ff16d5ac 100755
> > > --- a/tests/btrfs/071
> > > +++ b/tests/btrfs/071
> > > @@ -44,7 +44,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start replace worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/072 b/tests/btrfs/072
> > > index 4b6b6fb5..3eda8dfb 100755
> > > --- a/tests/btrfs/072
> > > +++ b/tests/btrfs/072
> > > @@ -37,7 +37,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start scrub worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/073 b/tests/btrfs/073
> > > index b1604f94..d3264f3b 100755
> > > --- a/tests/btrfs/073
> > > +++ b/tests/btrfs/073
> > > @@ -36,7 +36,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start scrub worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/074 b/tests/btrfs/074
> > > index 9b22c620..3d08415c 100755
> > > --- a/tests/btrfs/074
> > > +++ b/tests/btrfs/074
> > > @@ -37,7 +37,7 @@ run_test()
> > >
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $SCR=
ATCH_MNT/stressdir`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >
> > >     echo -n "Start defrag worker: " >>$seqres.full
> > > diff --git a/tests/btrfs/136 b/tests/btrfs/136
> > > index 70e836a5..fd637f33 100755
> > > --- a/tests/btrfs/136
> > > +++ b/tests/btrfs/136
> > > @@ -39,7 +39,7 @@ populate_data(){
> > >     mkdir -p $data_path
> > >     args=3D`_scale_fsstress_args -p 20 -n 100 $FSSTRESS_AVOID -d $dat=
a_path`
> > >     echo "Run fsstress $args" >>$seqres.full
> > > -   $FSSTRESS_PROG $args >>$seqres.full &
> > > +   $FSSTRESS_PROG $args >>$seqres.full 2>&1 &
> > >     fsstress_pid=3D$!
> > >     wait $fsstress_pid
> > >  }
> > > diff --git a/tests/btrfs/192 b/tests/btrfs/192
> > > index 00ea1478..0d926635 100755
> > > --- a/tests/btrfs/192
> > > +++ b/tests/btrfs/192
> > > @@ -140,7 +140,7 @@ pid1=3D$!
> > >  delete_workload &
> > >  pid2=3D$!
> > >
> > > -"$FSSTRESS_PROG" $fsstress_args >> $seqres.full &
> > > +"$FSSTRESS_PROG" $fsstress_args >> $seqres.full 2>&1 &
> > >  sleep $runtime
> > >
> > >  "$KILLALL_PROG" -q "$FSSTRESS_PROG" &> /dev/null
> > > diff --git a/tests/btrfs/232 b/tests/btrfs/232
> > > index 84c39c07..8ac0ce7c 100755
> > > --- a/tests/btrfs/232
> > > +++ b/tests/btrfs/232
> > > @@ -25,7 +25,7 @@ writer()
> > >
> > >     while true; do
> > >             args=3D`_scale_fsstress_args -p 20 -n 1000 $FSSTRESS_AVOI=
D -d $SCRATCH_MNT/stressdir`
> > > -           $FSSTRESS_PROG $args >> $seqres.full
> > > +           $FSSTRESS_PROG $args >> $seqres.full 2>&1
> > >     done
> > >  }
> > >
> > > diff --git a/tests/btrfs/261 b/tests/btrfs/261
> > > index 58fa8e75..9968c694 100755
> > > --- a/tests/btrfs/261
> > > +++ b/tests/btrfs/261
> > > @@ -36,7 +36,7 @@ prepare_fs()
> > >     # Then use fsstress to generate some extra contents.
> > >     # Disable setattr related operations, as it may set NODATACOW whi=
ch will
> > >     # not allow us to use btrfs checksum to verify the content.
> > > -   $FSSTRESS_PROG -f setattr=3D0 -d $SCRATCH_MNT -w -n 3000 >> $seqr=
es.full
> > > +   $FSSTRESS_PROG -f setattr=3D0 -d $SCRATCH_MNT -w -n 3000 >> $seqr=
es.full 2>&1
> > >     sync
> > >
> > >     # Save the fssum of this fs
> > > diff --git a/tests/btrfs/286 b/tests/btrfs/286
> > > index 71f6d4bd..ab4f9b24 100755
> > > --- a/tests/btrfs/286
> > > +++ b/tests/btrfs/286
> > > @@ -36,7 +36,7 @@ workload()
> > >     # Use nodatasum mount option, so all data won't have checksum.
> > >     _scratch_mount -o nodatasum
> > >
> > > -   $FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT >> $seqres.full
> > > +   $FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT >> $seqres.full 2>&1
> > >     sync
> > >
> > >     # Generate fssum for later verification, here we only care
> > > diff --git a/tests/ext4/057 b/tests/ext4/057
> > > index 6babedb2..b6d19339 100755
> > > --- a/tests/ext4/057
> > > +++ b/tests/ext4/057
> > > @@ -42,7 +42,7 @@ _scratch_mount
> > >
> > >  # Begin fsstress while modifying UUID
> > >  fsstress_args=3D$(_scale_fsstress_args -d $SCRATCH_MNT -p 15 -n 9999=
99)
> > > -$FSSTRESS_PROG $fsstress_args >> $seqres.full &
> > > +$FSSTRESS_PROG $fsstress_args >> $seqres.full 2>&1 &
> > >  fsstress_pid=3D$!
> > >
> > >  for n in $(seq 1 20); do
> > > diff --git a/tests/ext4/307 b/tests/ext4/307
> > > index 8b1cfc9e..75a8bff0 100755
> > > --- a/tests/ext4/307
> > > +++ b/tests/ext4/307
> > > @@ -21,7 +21,7 @@ _workout()
> > >     out=3D$SCRATCH_MNT/fsstress.$$
> > >     args=3D`_scale_fsstress_args -p4 -n999 -f setattr=3D1 $FSSTRESS_A=
VOID -d $out`
> > >     echo "fsstress $args" >> $seqres.full
> > > -   $FSSTRESS_PROG $args >> $seqres.full
> > > +   $FSSTRESS_PROG $args >> $seqres.full 2>&1
> > >     find $out -type f > $out.list
> > >     cat $out.list | xargs  md5sum > $out.md5sum
> > >     usage=3D`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> > > diff --git a/tests/generic/068 b/tests/generic/068
> > > index af527fee..b2967d13 100755
> > > --- a/tests/generic/068
> > > +++ b/tests/generic/068
> > > @@ -57,7 +57,7 @@ touch $tmp.running
> > >        # We do both read & write IO - not only is this more realistic=
,
> > >        # but it also potentially tests atime updates
> > >        FSSTRESS_ARGS=3D`_scale_fsstress_args -d $STRESS_DIR -p $procs=
 -n $nops $FSSTRESS_AVOID`
> > > -      $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
> > > +      $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full 2>&1
> > >      done
> > >
> > >      rm -r $STRESS_DIR/*
> > > diff --git a/tests/generic/269 b/tests/generic/269
> > > index b852f6bf..eddca10d 100755
> > > --- a/tests/generic/269
> > > +++ b/tests/generic/269
> > > @@ -23,7 +23,7 @@ _workout()
> > >     out=3D$SCRATCH_MNT/fsstress.$$
> > >     args=3D`_scale_fsstress_args -p128 -n999999999 -f setattr=3D1 $FS=
STRESS_AVOID -d $out`
> > >     echo "fsstress $args" >> $seqres.full
> > > -   $FSSTRESS_PROG $args >> $seqres.full &
> > > +   $FSSTRESS_PROG $args >> $seqres.full 2>&1 &
> > >     pid=3D$!
> > >     echo "Run dd writers in parallel"
> > >     for ((i=3D0; i < num_iterations; i++))
> > > diff --git a/tests/xfs/051 b/tests/xfs/051
> > > index 1c670964..eca67bb8 100755
> > > --- a/tests/xfs/051
> > > +++ b/tests/xfs/051
> > > @@ -38,7 +38,7 @@ _scratch_mount
> > >
> > >  # Start a workload and shutdown the fs. The subsequent mount will re=
quire log
> > >  # recovery.
> > > -$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full &
> > > +$FSSTRESS_PROG -n 9999 -p 2 -w -d $SCRATCH_MNT >> $seqres.full 2>&1 =
&
> > >  sleep 5
> > >  _scratch_shutdown -f
> > >  $KILLALL_PROG -q $FSSTRESS_PROG
> > > diff --git a/tests/xfs/057 b/tests/xfs/057
> > > index 6af14c80..9b52da79 100755
> > > --- a/tests/xfs/057
> > > +++ b/tests/xfs/057
> > > @@ -56,7 +56,7 @@ _scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqr=
es.full 2>&1 ||
> > >  _scratch_mount
> > >
> > >  # populate the fs with some data and cycle the mount to reset the lo=
g head/tail
> > > -$FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=3D1 -p 4 -n 100000 >> $seq=
res.full
> > > +$FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=3D1 -p 4 -n 100000 >> $seq=
res.full 2>&1
> > >  _scratch_cycle_mount || _fail "cycle mount failed"
> > >
> > >  # Pin the tail and start a file removal workload. File removal tends=
 to
> > > diff --git a/tests/xfs/297 b/tests/xfs/297
> > > index 1d101876..cd7bccb2 100755
> > > --- a/tests/xfs/297
> > > +++ b/tests/xfs/297
> > > @@ -39,7 +39,7 @@ _scratch_mount
> > >  STRESS_DIR=3D"$SCRATCH_MNT/testdir"
> > >  mkdir -p $STRESS_DIR
> > >
> > > -$FSSTRESS_PROG -d $STRESS_DIR -n 100 -p 1000 $FSSTRESS_AVOID >>$seqr=
es.full &
> > > +$FSSTRESS_PROG -d $STRESS_DIR -n 100 -p 1000 $FSSTRESS_AVOID >>$seqr=
es.full 2>&1 &
> > >
> > >  # Freeze/unfreeze file system randomly
> > >  echo "Start freeze/unfreeze randomly" | tee -a $seqres.full
> > > diff --git a/tests/xfs/305 b/tests/xfs/305
> > > index d8a6712e..a93576bc 100755
> > > --- a/tests/xfs/305
> > > +++ b/tests/xfs/305
> > > @@ -36,7 +36,7 @@ _exercise()
> > >     _qmount
> > >     mkdir -p $QUOTA_DIR
> > >
> > > -   $FSSTRESS_PROG -d $QUOTA_DIR -n 1000000 -p 100 $FSSTRESS_AVOID >>=
$seqres.full &
> > > +   $FSSTRESS_PROG -d $QUOTA_DIR -n 1000000 -p 100 $FSSTRESS_AVOID >>=
$seqres.full 2>&1 &
> > >     sleep 10
> > >     $XFS_QUOTA_PROG -x -c "disable -$type" $SCRATCH_DEV
> > >     sleep 5
> > > diff --git a/tests/xfs/538 b/tests/xfs/538
> > > index 0b5772a1..d36673a9 100755
> > > --- a/tests/xfs/538
> > > +++ b/tests/xfs/538
> > > @@ -63,7 +63,7 @@ $FSSTRESS_PROG -d $SCRATCH_MNT \
> > >             -f readv=3D0 \
> > >             -f stat=3D0 \
> > >             -f aread=3D0 \
> > > -           -f dread=3D0 >> $seqres.full
> > > +           -f dread=3D0 >> $seqres.full 2>&1
> > >
> > >  # success, all done
> > >  status=3D0
> > > --
> > > 2.41.0
> > >
> >
>
