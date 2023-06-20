Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4373676A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 11:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjFTJOi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjFTJOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 05:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5C1BDD;
        Tue, 20 Jun 2023 02:13:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 574C561087;
        Tue, 20 Jun 2023 09:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9061C433C0;
        Tue, 20 Jun 2023 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687252417;
        bh=EY3mfEHdUOLcXYHtlNQg3HjITE0OwsEM+r7rQeY/5lU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gBaoUQT5A9eww7xLTV44/kz1p3OR/3kL++IvklRy0NntsPztEbsj3sCNqGKIj2ldD
         L3UKBiLB4eITnj8IZvjXsQGtchEK8M/fUGwSNeg7XH6gGc/OeLG3M5XC0Au2t8BBA2
         MiccvB1zy6X27s5OXiBO9zkY1OgjsiDJck5TUekI7GD4hXWbjwYujGQ/T6acmK+Yy/
         Djr4z8Y4JCzqIxroBoEXP7CwXqSQ5gjBkBTZxJzfxURztr+w4XaaidK+Xt78sf3YCP
         IvwXfnjgceu9Cmj8sEugflW+Q6DeXwQBEJhb8App/NEMj1nGVCvI7wJDS1ddJeTMDr
         UEFwbG7e4FPrA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1aa0d354a8aso2194618fac.0;
        Tue, 20 Jun 2023 02:13:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDxA1OhLAwbmx6PYw0+Z1tDnYalyUp+0unRFlMcGxTtbQVp3Frh2
        7sooYYlCzLno5puzEffJA+yZZkezIkHegT6twRc=
X-Google-Smtp-Source: ACHHUZ6kk1xvXkUAsRfOF5QU4UEruKD9j10OD0cpUpu7A9wZfbKimI65i8eApLVfnRfOz+hPOyMw68KnrYjP1wgou7s=
X-Received: by 2002:a05:6870:4144:b0:1a2:8ebd:7d46 with SMTP id
 r4-20020a056870414400b001a28ebd7d46mr7799203oad.21.1687252416845; Tue, 20 Jun
 2023 02:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230608114836.97523-1-wqu@suse.com> <CAL3q7H6VhahmpcWZGpfauyUmrG76kqAyZAMQb8_5T74Xyg6U+A@mail.gmail.com>
 <3ea45213-fd95-4027-8a95-066b07fdecc9@suse.com>
In-Reply-To: <3ea45213-fd95-4027-8a95-066b07fdecc9@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 20 Jun 2023 10:13:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4pnOBX_9ZRd_5tcc-ZQ4_CaVM15t5n_aMq0xCVt7zjmQ@mail.gmail.com>
Message-ID: <CAL3q7H4pnOBX_9ZRd_5tcc-ZQ4_CaVM15t5n_aMq0xCVt7zjmQ@mail.gmail.com>
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 20, 2023 at 2:07=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/6/20 00:13, Filipe Manana wrote:
> > On Thu, Jun 8, 2023 at 1:02=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> There is a chance that btrfs/266 would fail on aarch64 with 64K page
> >> size. (No matter if it's 4K sector size or 64K sector size)
> >>
> >> The failure indicates that one or more mirrors are not properly fixed.
> >>
> >> [CAUSE]
> >> I have added some trace events into the btrfs IO paths, including
> >> __btrfs_submit_bio() and __end_bio_extent_readpage().
> >>
> >> When the test failed, the trace looks like this:
> >>
> >>   112819.764977: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D=
1 len=3D196608 pid=3D33663
> >>                                      ^^^ Initial read on the full 192K=
 file
> >>   112819.766604: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D=
2 len=3D65536 pid=3D21806
> >>                                      ^^^ Repair on the first 64K block
> >>                                          Which would success
> >>   112819.766760: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D65536 mirro=
r=3D2 len=3D65536 pid=3D21806
> >>                                      ^^^ Repair on the second 64K bloc=
k
> >>                                          Which would fail
> >>   112819.767625: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D65536 mirro=
r=3D3 len=3D65536 pid=3D21806
> >>                                      ^^^ Repair on the third 64K block
> >>                                          Which would success
> >>   112819.770999: end_bio_extent_readpage: read finished, r/i=3D5/257 f=
ileoff=3D0 len=3D196608 mirror=3D1 status=3D0
> >>                                           ^^^ The repair succeeded, th=
e
> >>                                               full 192K read finished.
> >>
> >>   112819.864851: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D=
3 len=3D196608 pid=3D33665
> >>   112819.874854: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D0 mirror=3D=
1 len=3D65536 pid=3D31369
> >>   112819.875029: __btrfs_submit_bio: r/i=3D5/257 fileoff=3D131072 mirr=
or=3D1 len=3D65536 pid=3D31369
> >>   112819.876926: end_bio_extent_readpage: read finished, r/i=3D5/257 f=
ileoff=3D0 len=3D196608 mirror=3D3 status=3D0
> >>
> >> But above read only happen for mirror 1 and mirror 3, mirror 2 is not
> >> involved.
> >> This means by somehow, the read on mirror 2 didn't happen, mostly
> >> due to something wrong during the drop_caches call.
> >>
> >> It may be an async operation or some hardware specific behavior.
> >>
> >> On the other hand, for test cases doing the same operation but utilizi=
ng
> >> direct IO, aka btrfs/267, it never fails as we never populate the page
> >> cache thus would always read from the disk.
> >>
> >> [WORKAROUND]
> >> The root cause is in the "echo 3 > drop_caches", which I'm still
> >> debugging.
> >>
> >> But at the same time, we can workaround the problem by forcing a
> >> cycle mount of scratch device, inside _btrfs_buffered_read_on_mirror()=
.
> >>
> >> By this we can ensure all page caches are dropped no matter if
> >> drop_caches is working correctly.
> >>
> >> With this patch, I no longer hit the failure on aarch64 with 64K page
> >> size anymore, while before this the test case would always fail during=
 a
> >> -I 10 run.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> RFC:
> >> The root cause is still inside that "echo 3 > drop_caches", but I don'=
t
> >> have any better solution if such fundamental debug function is not
> >> working as expected.
> >>
> >> Thus this is only a workaround, before I can pin down the root cause o=
f
> >> that drop_cache hiccup.
> >> ---
> >>   common/btrfs | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/common/btrfs b/common/btrfs
> >> index 344509ce..1d522c33 100644
> >> --- a/common/btrfs
> >> +++ b/common/btrfs
> >> @@ -599,6 +599,11 @@ _btrfs_buffered_read_on_mirror()
> >>          local size=3D$5
> >>
> >>          echo 3 > /proc/sys/vm/drop_caches
> >> +       # Above drop_caches doesn't seem to drop every pages on aarch6=
4 with
> >> +       # 64K page size.
> >> +       # So here as a workaround, cycle mount the SCRATCH_MNT to ensu=
re
> >> +       # the cache are dropped.
> >> +       _scratch_cycle_mount
> >
> > Btw, I'm getting some tests failing because of this change.
> >
> > For e.g.:
> >
> > ./check btrfs/143
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian0 6.4.0-rc6-btrfs-next-134+ #1 SMP
> > PREEMPT_DYNAMIC Thu Jun 15 11:59:28 WEST 2023
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> > btrfs/143 6s ... [failed, exit status 1]- output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
> >      --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
> >      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
> > 2023-06-19 17:04:00.575033899 +0100
> >      @@ -1,37 +1,6 @@
> >       QA output created by 143
> >       wrote 131072/131072 bytes
> >       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >      ...
> >      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/143
> > Failures: btrfs/143
> > Failed 1 of 1 tests
> >
> > The problem is this test is using dm-rust, and _scratch_cycle_mount()
> > doesn't work in that case.
> > It should be _unmount_dust() followed by_mount_dust() for this particul=
ar case.
>
> Any idea on a better solution?
>
> My current idea is to grab the mounted device of SCRATCH_MNT, then
> unmount and mount the grabbed device, instead of always using scratch
> device.

Maybe that, yes.

>
> But it may look a little over-complicated and would affect too many test
> cases.
>
> Or maybe we can detect if it's using dust device inside
> _btrfs_buffered_read_on_mirror() instead?

Well, that sounds fragile. Maybe there are other tests using dmflakey
instead of dmrust, or some other target.
Or maybe not now, but in the future...

>
> Thanks,
> Qu
> >
> >
> >>          while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
> >>                  exec $XFS_IO_PROG \
> >>                          -c "pread -b $size $offset $size" $file) ]]; =
do
> >> --
> >> 2.39.1
> >>
