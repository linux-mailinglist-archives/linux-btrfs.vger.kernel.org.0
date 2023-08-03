Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8476E5CA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjHCKdl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjHCKdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 06:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14519B0;
        Thu,  3 Aug 2023 03:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FC961D32;
        Thu,  3 Aug 2023 10:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6583C433C7;
        Thu,  3 Aug 2023 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691058806;
        bh=L5pLiCiAUOyJrYcPpqjntfC9+CZKy3lbaXA7VR69LaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LGZSXrgXvhkEZcYC9IbTIPurTPyCw7WG5/EBGxGGV6L+RGPQa5YYOyxVYXnHqd53c
         Ecv3XjvaqVRHIlgz/BiYLqRRIicbSP6ibB4RgFYGOACeM1Gt5lYbHPMWP5j+az2m4R
         GHPAyRPG8xaVYjbSpavqD4N1DBs/weeDv2+UpfW7OoIoZFPAgDX2sTh0agd0fODowX
         Jic0kwK+KmxQ74j5eldFPJn3rbPH29DKU1ZbOkPt838wXQ5NbBcjIaevtwZQs6GWtp
         RQuddK6QKq3XJRYtsAcigfVbfF3xjQXyQQZLW+tqu4p1a0rr6VgCkicHJnxBs429ds
         7JraP+aLqqJHQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1bf08ca187cso501628fac.3;
        Thu, 03 Aug 2023 03:33:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLb0hHzeIxuiw7ga9Y7mh/Ew6xL+2gmfOJT03Nr/UY6N0ps5/PZv
        VA1W6OYIhiPQc0Y7bu3hnBGGSht9glNj3wMdU/0=
X-Google-Smtp-Source: APBJJlEWEGcf46pujjJ5n3JMUbE6U2gaAYVatUv/t2WI1tP5dBNukWlW7L94RAr1V1C8K+A4oE9nw9LB4PWcdJrdMNI=
X-Received: by 2002:a05:6870:82a1:b0:1be:f1b0:fa7 with SMTP id
 q33-20020a05687082a100b001bef1b00fa7mr11404350oae.57.1691058805663; Thu, 03
 Aug 2023 03:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801065529.50122-1-wqu@suse.com> <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
 <26ccf055-8ca2-275d-627d-e8b6c2e12ffe@gmx.com> <16f417cd-a625-3abb-b11d-8673bed265ef@gmx.com>
 <CAL3q7H7kNyMBRPOH2DjohGKog69H4sdd306cZpe17fLLsHPsSA@mail.gmail.com>
 <b8c5c67b-57f9-eacb-bf54-ee49a89f6e98@gmx.com> <CAL3q7H4VBnfusYSFr=Ws=Df7k4oyvLwfj_0NZQ1xN7ToWCMAmw@mail.gmail.com>
In-Reply-To: <CAL3q7H4VBnfusYSFr=Ws=Df7k4oyvLwfj_0NZQ1xN7ToWCMAmw@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 3 Aug 2023 11:32:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5wht5a9oFjPLmu1BbuwsJhoN60_Kiyeo34PfVSpRW15g@mail.gmail.com>
Message-ID: <CAL3q7H5wht5a9oFjPLmu1BbuwsJhoN60_Kiyeo34PfVSpRW15g@mail.gmail.com>
Subject: Re: [PATCH] btrfs/276: allow a slight increase in the number of extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 3, 2023 at 10:02=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Thu, Aug 3, 2023 at 2:30=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
> >
> >
> >
> > On 2023/8/3 01:28, Filipe Manana wrote:
> > > On Wed, Aug 2, 2023 at 12:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx=
.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2023/8/2 18:36, Qu Wenruo wrote:
> > >>>
> > >>>
> > >>> On 2023/8/2 18:23, Filipe Manana wrote:
> > >>>> On Tue, Aug 1, 2023 at 8:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wr=
ote:
> > >>>>>
> > >>>>> [BUG]
> > >>>>> Sometimes test case btrfs/276 would fail with extra number of ext=
ents:
> > >>>>>
> > >>>>>       - output mismatch (see /opt/xfstests/results//btrfs/276.out=
.bad)
> > >>>>>       --- tests/btrfs/276.out     2023-07-19 07:24:07.000000000 +=
0000
> > >>>>>       +++ /opt/xfstests/results//btrfs/276.out.bad        2023-07=
-28
> > >>>>> 04:15:06.223985372 +0000
> > >>>>>       @@ -1,16 +1,16 @@
> > >>>>>        QA output created by 276
> > >>>>>        wrote 17179869184/17179869184 bytes at offset 0
> > >>>>>        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >>>>>       -Number of non-shared extents in the whole file: 131072
> > >>>>>       +Number of non-shared extents in the whole file: 131082
> > >>>>>        Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> > >>>>>       -Number of shared extents in the whole file: 131072
> > >>>>>       ...
> > >>>>>       (Run 'diff -u /opt/xfstests/tests/btrfs/276.out
> > >>>>> /opt/xfstests/results//btrfs/276.out.bad'  to see the entire diff=
)
> > >>>>>
> > >>>>> [CAUSE]
> > >>>>> The test case uses golden output to record the number of total ex=
tents
> > >>>>> of a 16G file.
> > >>>>>
> > >>>>> This is not reliable as we can have writeback happen halfway, res=
ulting
> > >>>>> smaller extents thus slightly more extents.
> > >>>>>
> > >>>>> With a VM with 4G memory, I have a chance around 1/10 hitting thi=
s
> > >>>>> false alert.
> > >>>>>
> > >>>>> [FIX]
> > >>>>> Instead of using golden output, we allow a slight (5%) float in t=
he
> > >>>>> number of extents, and move the 131072 (and 131072 - 16) from gol=
den
> > >>>>> output, so even if we have a slightly more extents, we can still =
pass
> > >>>>> the test.
> > >>>>>
> > >>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > >>>>> ---
> > >>>>>    tests/btrfs/276     | 41 ++++++++++++++++++++++++++++++++++++-=
----
> > >>>>>    tests/btrfs/276.out |  4 ----
> > >>>>>    2 files changed, 36 insertions(+), 9 deletions(-)
> > >>>>>
> > >>>>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> > >>>>> index 944b0c8f..a63b28bb 100755
> > >>>>> --- a/tests/btrfs/276
> > >>>>> +++ b/tests/btrfs/276
> > >>>>> @@ -65,10 +65,17 @@ count_not_shared_extents()
> > >>>>>
> > >>>>>    # Create a 16G file as that results in 131072 extents, all wit=
h a
> > >>>>> size of 128K
> > >>>>>    # (due to compression), and a fs tree with a height of 3 (root=
 node
> > >>>>> at level 2).
> > >>>>> +#
> > >>>>> +# But due to writeback can happen halfway, we may have slightly =
more
> > >>>>> extents
> > >>>>> +# than 128K, so we allow 5% increase in the number of extents.
> > >>>>> +#
> > >>>>>    # We want to verify later that fiemap correctly reports the
> > >>>>> sharedness of each
> > >>>>>    # extent, even when it needs to switch from one leaf to the ne=
xt
> > >>>>> one and from a
> > >>>>>    # node at level 1 to the next node at level 1.
> > >>>>>    #
> > >>>>> +nr_extents_lower=3D$((128 * 1024))
> > >>>>> +nr_extents_upper=3D$((128 * 1024 + 128 * 1024 / 20))
> > >>>>> +
> > >>>>>    $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo |
> > >>>>> _filter_xfs_io
> > >>>>
> > >>>> Does adding '-s' (fsync after every write) to the $XFS_IO_PROG fix=
es
> > >>>> the issue?
> > >>>> On my test vm, it doesn't increase runtime by that much (16 to 23
> > >>>> seconds).
> > >>>
> > >>> This indeed is much better, without dirty pages pressure we can go =
the
> > >>> old golden output.
> > >>
> > >> Unfortunately I still have a very low chance (~1/20) to hit 1~3 more
> > >> extent than the golden output.
> > >>
> > >> There are still extra things like the commit intervals to let us to
> > >> writeback halfway.
> > >>
> > >> The best situation would be direct IO, but unfortunately direct IO
> > >> doesn't support compression, thus the resulted file would lead to me=
rged
> > >> fiemap results.
> > >
> > > The compression is not needed.
> > > I wrote the test to use compression because it makes creating a file =
with
> > > thousands of extents very fast and using very little space.
> > >
> > > The goal is really to have many file extent items spanning multiple l=
eaves and
> > > to have a root at level 2 (or higher), to verify the sharedness
> > > detection is correct
> > > for subtrees.
> > >
> > >>
> > >> The other solution is to write between two files using direct IO, to
> > >> make each extent inside the same file not continuous with each other=
.
> > >>
> > >> But that would lead to at least 512M * 2, and we also need to do the
> > >> same interleaved writes again for the 1M writes.
> > >>
> > >> Any ideas would be appreciated.
> > >
> > > See if this works:
> > >
> > > https://pastebin.com/raw/QnNtSrDP
> >
> > This works fine as after 20 runs I still didn't hit any output mismatch=
.
> >
> > Although you can further improve it by using direct IO and much smaller
> > blocksize (4K), which can further reduce the size and completely
> > eliminate the possibility of writeback halfway.
> > (This would require 4K sector size though)
>
> The 64K was chosen precisely so that it works with any sector size.
> I don't know why you worry about the size - it's a ~250M file, quite smal=
l.
>
> >
> > In that case, you can even reuse the old 131072 number, as we only need
> > around 512M (file size would be 1G) for data.
> >
> >
> > Another thing is, if tree level 3 (root node level 2) is needed, we can
> > even further reduce the file size by requiring 4K nodesize, which can
> > further speed up the test, without the need for xattr.
>
> Yes, but I prefer to keep the default node size, so that it works on
> any environment and
> configuration, therefore increasing test coverage.
>
> >
> > >
> > > It accomplishes the same goals and it's still fast (about 23 seconds
> > > on my non-debug test vm, before it was about 16 seconds).
> >
> > The modified version is already fast enough even with a KASAN enabled
> > kernel, only 60s compared to the old 120+s.
> >
> > Mind to send the modification as a proper fix? That's a much improved
> > version compared to mine.
>
> I will, thanks.

For cross reference, here it is:

https://lore.kernel.org/linux-btrfs/c54bf70be6bbeefe440ea5b1341495b16803455=
c.1691058187.git.fdmanana@suse.com/

>
> >
> > Thanks,
> > Qu
> >
> > >
> > > Thanks.
> > >
> > >>
> > >> Thanks,
> > >> Qu
> > >>>
> > >>> Thanks,
> > >>> Qu
> > >>>>
> > >>>> I'd rather do that so that we can be sure fiemap is working correc=
tly
> > >>>> and not returning more extents than there really are - this approa=
ch
> > >>>> of allowing a bit more allows for that type of bug to be unnoticed=
,
> > >>>> plus that little bit more might not be always enough (depending on
> > >>>> available rm, writeback settings, etc).
> > >>>>
> > >>>> Thanks.
> > >>>>
> > >>>>>
> > >>>>>    # Sync to flush delalloc and commit the current transaction, s=
o
> > >>>>> fiemap will see
> > >>>>> @@ -76,13 +83,22 @@ $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G"
> > >>>>> $SCRATCH_MNT/foo | _filter_xfs_io
> > >>>>>    sync
> > >>>>>
> > >>>>>    # All extents should be reported as non shared (131072 extents=
).
> > >>>>> -echo "Number of non-shared extents in the whole file:
> > >>>>> $(count_not_shared_extents)"
> > >>>>> +found1=3D$(count_not_shared_extents)
> > >>>>> +echo "Number of non-shared extents in the whole file: ${found1}"=
 >>
> > >>>>> $seqres.full
> > >>>>> +
> > >>>>> +if [ $found1 -lt $nr_extents_lower -o $found1 -gt $nr_extents_up=
per
> > >>>>> ]; then
> > >>>>> +       echo "unexpected initial number of extents, has $found1
> > >>>>> expect [$nr_extents_lower, $nr_extents_upper]"
> > >>>>> +fi
> > >>>>>
> > >>>>>    # Creating a snapshot.
> > >>>>>    $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/=
snap
> > >>>>> | _filter_scratch
> > >>>>>
> > >>>>>    # We have a snapshot, so now all extents should be reported as=
 shared.
> > >>>>> -echo "Number of shared extents in the whole file:
> > >>>>> $(count_shared_extents)"
> > >>>>> +found2=3D$(count_shared_extents)
> > >>>>> +echo "Number of shared extents in the whole file: ${found2}" >>
> > >>>>> $seqres.full
> > >>>>> +if [ $found2 -ne $found1 ]; then
> > >>>>> +       echo "unexpected shared extents, has $found2 expect $foun=
d1"
> > >>>>> +fi
> > >>>>>
> > >>>>>    # Now COW two file ranges, of 1M each, in the snapshot's file.
> > >>>>>    # So 16 extents should become non-shared after this.
> > >>>>> @@ -97,8 +113,18 @@ sync
> > >>>>>
> > >>>>>    # Now we should have 16 non-shared extents and 131056 (131072 =
- 16)
> > >>>>> shared
> > >>>>>    # extents.
> > >>>>> -echo "Number of non-shared extents in the whole file:
> > >>>>> $(count_not_shared_extents)"
> > >>>>> -echo "Number of shared extents in the whole file:
> > >>>>> $(count_shared_extents)"
> > >>>>> +found3=3D$(count_not_shared_extents)
> > >>>>> +found4=3D$(count_shared_extents)
> > >>>>> +echo "Number of non-shared extents in the whole file: ${found3}"
> > >>>>> +echo "Number of shared extents in the whole file: ${found4}" >>
> > >>>>> $seqres.full
> > >>>>> +
> > >>>>> +if [ $found3 !=3D 16 ]; then
> > >>>>> +       echo "Unexpected number of non-shared extents, has $found=
3
> > >>>>> expect 16"
> > >>>>> +fi
> > >>>>> +
> > >>>>> +if [ $found4 !=3D $(( $found1 - $found3 )) ]; then
> > >>>>> +       echo "Unexpected number of shared extents, has $found4 ex=
pect
> > >>>>> $(( $found1 - $found3 ))"
> > >>>>> +fi
> > >>>>>
> > >>>>>    # Check that the non-shared extents are indeed in the expected=
 file
> > >>>>> ranges (each
> > >>>>>    # with 8 extents).
> > >>>>> @@ -117,7 +143,12 @@ _scratch_remount commit=3D1
> > >>>>>    sleep 1.1
> > >>>>>
> > >>>>>    # Now all extents should be reported as not shared (131072 ext=
ents).
> > >>>>> -echo "Number of non-shared extents in the whole file:
> > >>>>> $(count_not_shared_extents)"
> > >>>>> +found5=3D$(count_not_shared_extents)
> > >>>>> +echo "Number of non-shared extents in the whole file: ${found5}"=
 >>
> > >>>>> $seqres.full
> > >>>>> +
> > >>>>> +if [ $found5 !=3D $found1 ]; then
> > >>>>> +       echo "Unexpected final number of non-shared extents, has
> > >>>>> $found5 expect $found1"
> > >>>>> +fi
> > >>>>>
> > >>>>>    # success, all done
> > >>>>>    status=3D0
> > >>>>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> > >>>>> index 3bf5a5e6..e318c2e9 100644
> > >>>>> --- a/tests/btrfs/276.out
> > >>>>> +++ b/tests/btrfs/276.out
> > >>>>> @@ -1,16 +1,12 @@
> > >>>>>    QA output created by 276
> > >>>>>    wrote 17179869184/17179869184 bytes at offset 0
> > >>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >>>>> -Number of non-shared extents in the whole file: 131072
> > >>>>>    Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> > >>>>> -Number of shared extents in the whole file: 131072
> > >>>>>    wrote 1048576/1048576 bytes at offset 8388608
> > >>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >>>>>    wrote 1048576/1048576 bytes at offset 12884901888
> > >>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > >>>>>    Number of non-shared extents in the whole file: 16
> > >>>>> -Number of shared extents in the whole file: 131056
> > >>>>>    Number of non-shared extents in range [8M, 9M): 8
> > >>>>>    Number of non-shared extents in range [12G, 12G + 1M): 8
> > >>>>>    Delete subvolume (commit): 'SCRATCH_MNT/snap'
> > >>>>> -Number of non-shared extents in the whole file: 131072
> > >>>>> --
> > >>>>> 2.41.0
> > >>>>>
