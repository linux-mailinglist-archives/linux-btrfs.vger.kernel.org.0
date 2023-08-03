Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E886E76E3E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjHCJDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjHCJDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 05:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1665E7;
        Thu,  3 Aug 2023 02:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BBBE61CCB;
        Thu,  3 Aug 2023 09:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDF3C433C8;
        Thu,  3 Aug 2023 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053413;
        bh=VUNj4XyObd8fvYSE+Fq1GVqnwuTwQdzzUyxzUgJxvR4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hYR8H+dzJ+PeWM/44jc1smoUUoo/iYqFdl510Xug/29WLxzpE+us/ZgXPB8ovVKAz
         C3p9KIaBqGZr0tXNnzDV12pgBzN/6x18qmkgPqcZfW45Qi9zp0nDPpoxTrYTh+kDSR
         0mzq7ORubFklyBtcXfl27VvnNFkRNXrGlOFrX5dRykHgrr4qNrnM7U5/rCFyF81t4c
         2/lb9GgFjbv0D/dMpy61yt4iGNJeL2i0TSUH8WUqSZprEb6YR7tHbiC6pKjm87dPMU
         nqsOWlLmOHA+pvUFLkbyC/xpegZOgGiUCVMBobGDqNoiPbi6d/Pv79ZliYAj1gYoOK
         C04oVW9ZSXrjg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso494657fac.3;
        Thu, 03 Aug 2023 02:03:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLbh6XfnfjmsQCIfRfvAY3ySVqLQf/NGekdG+acB12PKLk35p1ap
        ph+iWSXnMh5Zpf/SZbmb3b1P1zDhpqGRe5zB210=
X-Google-Smtp-Source: APBJJlGIcKK4lYcUdo5kj3gU77Rnl06qfjJaF3YLDiiympBdScO0kYggbLY5y5UAxs2bPeNUXz8yKW3Bf7rJMO7zgNc=
X-Received: by 2002:a05:6870:5611:b0:1bd:a5ea:ed7d with SMTP id
 m17-20020a056870561100b001bda5eaed7dmr16901251oao.7.1691053412604; Thu, 03
 Aug 2023 02:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230801065529.50122-1-wqu@suse.com> <CAL3q7H7MbA5Vfwgu=8Xuhh2o-SMnSCg9CJQszMTgLfHzmuBFWg@mail.gmail.com>
 <26ccf055-8ca2-275d-627d-e8b6c2e12ffe@gmx.com> <16f417cd-a625-3abb-b11d-8673bed265ef@gmx.com>
 <CAL3q7H7kNyMBRPOH2DjohGKog69H4sdd306cZpe17fLLsHPsSA@mail.gmail.com> <b8c5c67b-57f9-eacb-bf54-ee49a89f6e98@gmx.com>
In-Reply-To: <b8c5c67b-57f9-eacb-bf54-ee49a89f6e98@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 3 Aug 2023 10:02:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4VBnfusYSFr=Ws=Df7k4oyvLwfj_0NZQ1xN7ToWCMAmw@mail.gmail.com>
Message-ID: <CAL3q7H4VBnfusYSFr=Ws=Df7k4oyvLwfj_0NZQ1xN7ToWCMAmw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/276: allow a slight increase in the number of extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 3, 2023 at 2:30=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> On 2023/8/3 01:28, Filipe Manana wrote:
> > On Wed, Aug 2, 2023 at 12:18=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> >>
> >>
> >>
> >> On 2023/8/2 18:36, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2023/8/2 18:23, Filipe Manana wrote:
> >>>> On Tue, Aug 1, 2023 at 8:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrot=
e:
> >>>>>
> >>>>> [BUG]
> >>>>> Sometimes test case btrfs/276 would fail with extra number of exten=
ts:
> >>>>>
> >>>>>       - output mismatch (see /opt/xfstests/results//btrfs/276.out.b=
ad)
> >>>>>       --- tests/btrfs/276.out     2023-07-19 07:24:07.000000000 +00=
00
> >>>>>       +++ /opt/xfstests/results//btrfs/276.out.bad        2023-07-2=
8
> >>>>> 04:15:06.223985372 +0000
> >>>>>       @@ -1,16 +1,16 @@
> >>>>>        QA output created by 276
> >>>>>        wrote 17179869184/17179869184 bytes at offset 0
> >>>>>        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>>>>       -Number of non-shared extents in the whole file: 131072
> >>>>>       +Number of non-shared extents in the whole file: 131082
> >>>>>        Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> >>>>>       -Number of shared extents in the whole file: 131072
> >>>>>       ...
> >>>>>       (Run 'diff -u /opt/xfstests/tests/btrfs/276.out
> >>>>> /opt/xfstests/results//btrfs/276.out.bad'  to see the entire diff)
> >>>>>
> >>>>> [CAUSE]
> >>>>> The test case uses golden output to record the number of total exte=
nts
> >>>>> of a 16G file.
> >>>>>
> >>>>> This is not reliable as we can have writeback happen halfway, resul=
ting
> >>>>> smaller extents thus slightly more extents.
> >>>>>
> >>>>> With a VM with 4G memory, I have a chance around 1/10 hitting this
> >>>>> false alert.
> >>>>>
> >>>>> [FIX]
> >>>>> Instead of using golden output, we allow a slight (5%) float in the
> >>>>> number of extents, and move the 131072 (and 131072 - 16) from golde=
n
> >>>>> output, so even if we have a slightly more extents, we can still pa=
ss
> >>>>> the test.
> >>>>>
> >>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>>> ---
> >>>>>    tests/btrfs/276     | 41 ++++++++++++++++++++++++++++++++++++---=
--
> >>>>>    tests/btrfs/276.out |  4 ----
> >>>>>    2 files changed, 36 insertions(+), 9 deletions(-)
> >>>>>
> >>>>> diff --git a/tests/btrfs/276 b/tests/btrfs/276
> >>>>> index 944b0c8f..a63b28bb 100755
> >>>>> --- a/tests/btrfs/276
> >>>>> +++ b/tests/btrfs/276
> >>>>> @@ -65,10 +65,17 @@ count_not_shared_extents()
> >>>>>
> >>>>>    # Create a 16G file as that results in 131072 extents, all with =
a
> >>>>> size of 128K
> >>>>>    # (due to compression), and a fs tree with a height of 3 (root n=
ode
> >>>>> at level 2).
> >>>>> +#
> >>>>> +# But due to writeback can happen halfway, we may have slightly mo=
re
> >>>>> extents
> >>>>> +# than 128K, so we allow 5% increase in the number of extents.
> >>>>> +#
> >>>>>    # We want to verify later that fiemap correctly reports the
> >>>>> sharedness of each
> >>>>>    # extent, even when it needs to switch from one leaf to the next
> >>>>> one and from a
> >>>>>    # node at level 1 to the next node at level 1.
> >>>>>    #
> >>>>> +nr_extents_lower=3D$((128 * 1024))
> >>>>> +nr_extents_upper=3D$((128 * 1024 + 128 * 1024 / 20))
> >>>>> +
> >>>>>    $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G" $SCRATCH_MNT/foo |
> >>>>> _filter_xfs_io
> >>>>
> >>>> Does adding '-s' (fsync after every write) to the $XFS_IO_PROG fixes
> >>>> the issue?
> >>>> On my test vm, it doesn't increase runtime by that much (16 to 23
> >>>> seconds).
> >>>
> >>> This indeed is much better, without dirty pages pressure we can go th=
e
> >>> old golden output.
> >>
> >> Unfortunately I still have a very low chance (~1/20) to hit 1~3 more
> >> extent than the golden output.
> >>
> >> There are still extra things like the commit intervals to let us to
> >> writeback halfway.
> >>
> >> The best situation would be direct IO, but unfortunately direct IO
> >> doesn't support compression, thus the resulted file would lead to merg=
ed
> >> fiemap results.
> >
> > The compression is not needed.
> > I wrote the test to use compression because it makes creating a file wi=
th
> > thousands of extents very fast and using very little space.
> >
> > The goal is really to have many file extent items spanning multiple lea=
ves and
> > to have a root at level 2 (or higher), to verify the sharedness
> > detection is correct
> > for subtrees.
> >
> >>
> >> The other solution is to write between two files using direct IO, to
> >> make each extent inside the same file not continuous with each other.
> >>
> >> But that would lead to at least 512M * 2, and we also need to do the
> >> same interleaved writes again for the 1M writes.
> >>
> >> Any ideas would be appreciated.
> >
> > See if this works:
> >
> > https://pastebin.com/raw/QnNtSrDP
>
> This works fine as after 20 runs I still didn't hit any output mismatch.
>
> Although you can further improve it by using direct IO and much smaller
> blocksize (4K), which can further reduce the size and completely
> eliminate the possibility of writeback halfway.
> (This would require 4K sector size though)

The 64K was chosen precisely so that it works with any sector size.
I don't know why you worry about the size - it's a ~250M file, quite small.

>
> In that case, you can even reuse the old 131072 number, as we only need
> around 512M (file size would be 1G) for data.
>
>
> Another thing is, if tree level 3 (root node level 2) is needed, we can
> even further reduce the file size by requiring 4K nodesize, which can
> further speed up the test, without the need for xattr.

Yes, but I prefer to keep the default node size, so that it works on
any environment and
configuration, therefore increasing test coverage.

>
> >
> > It accomplishes the same goals and it's still fast (about 23 seconds
> > on my non-debug test vm, before it was about 16 seconds).
>
> The modified version is already fast enough even with a KASAN enabled
> kernel, only 60s compared to the old 120+s.
>
> Mind to send the modification as a proper fix? That's a much improved
> version compared to mine.

I will, thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> Thanks,
> >> Qu
> >>>
> >>> Thanks,
> >>> Qu
> >>>>
> >>>> I'd rather do that so that we can be sure fiemap is working correctl=
y
> >>>> and not returning more extents than there really are - this approach
> >>>> of allowing a bit more allows for that type of bug to be unnoticed,
> >>>> plus that little bit more might not be always enough (depending on
> >>>> available rm, writeback settings, etc).
> >>>>
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>>    # Sync to flush delalloc and commit the current transaction, so
> >>>>> fiemap will see
> >>>>> @@ -76,13 +83,22 @@ $XFS_IO_PROG -f -c "pwrite -b 8M 0 16G"
> >>>>> $SCRATCH_MNT/foo | _filter_xfs_io
> >>>>>    sync
> >>>>>
> >>>>>    # All extents should be reported as non shared (131072 extents).
> >>>>> -echo "Number of non-shared extents in the whole file:
> >>>>> $(count_not_shared_extents)"
> >>>>> +found1=3D$(count_not_shared_extents)
> >>>>> +echo "Number of non-shared extents in the whole file: ${found1}" >=
>
> >>>>> $seqres.full
> >>>>> +
> >>>>> +if [ $found1 -lt $nr_extents_lower -o $found1 -gt $nr_extents_uppe=
r
> >>>>> ]; then
> >>>>> +       echo "unexpected initial number of extents, has $found1
> >>>>> expect [$nr_extents_lower, $nr_extents_upper]"
> >>>>> +fi
> >>>>>
> >>>>>    # Creating a snapshot.
> >>>>>    $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/sn=
ap
> >>>>> | _filter_scratch
> >>>>>
> >>>>>    # We have a snapshot, so now all extents should be reported as s=
hared.
> >>>>> -echo "Number of shared extents in the whole file:
> >>>>> $(count_shared_extents)"
> >>>>> +found2=3D$(count_shared_extents)
> >>>>> +echo "Number of shared extents in the whole file: ${found2}" >>
> >>>>> $seqres.full
> >>>>> +if [ $found2 -ne $found1 ]; then
> >>>>> +       echo "unexpected shared extents, has $found2 expect $found1=
"
> >>>>> +fi
> >>>>>
> >>>>>    # Now COW two file ranges, of 1M each, in the snapshot's file.
> >>>>>    # So 16 extents should become non-shared after this.
> >>>>> @@ -97,8 +113,18 @@ sync
> >>>>>
> >>>>>    # Now we should have 16 non-shared extents and 131056 (131072 - =
16)
> >>>>> shared
> >>>>>    # extents.
> >>>>> -echo "Number of non-shared extents in the whole file:
> >>>>> $(count_not_shared_extents)"
> >>>>> -echo "Number of shared extents in the whole file:
> >>>>> $(count_shared_extents)"
> >>>>> +found3=3D$(count_not_shared_extents)
> >>>>> +found4=3D$(count_shared_extents)
> >>>>> +echo "Number of non-shared extents in the whole file: ${found3}"
> >>>>> +echo "Number of shared extents in the whole file: ${found4}" >>
> >>>>> $seqres.full
> >>>>> +
> >>>>> +if [ $found3 !=3D 16 ]; then
> >>>>> +       echo "Unexpected number of non-shared extents, has $found3
> >>>>> expect 16"
> >>>>> +fi
> >>>>> +
> >>>>> +if [ $found4 !=3D $(( $found1 - $found3 )) ]; then
> >>>>> +       echo "Unexpected number of shared extents, has $found4 expe=
ct
> >>>>> $(( $found1 - $found3 ))"
> >>>>> +fi
> >>>>>
> >>>>>    # Check that the non-shared extents are indeed in the expected f=
ile
> >>>>> ranges (each
> >>>>>    # with 8 extents).
> >>>>> @@ -117,7 +143,12 @@ _scratch_remount commit=3D1
> >>>>>    sleep 1.1
> >>>>>
> >>>>>    # Now all extents should be reported as not shared (131072 exten=
ts).
> >>>>> -echo "Number of non-shared extents in the whole file:
> >>>>> $(count_not_shared_extents)"
> >>>>> +found5=3D$(count_not_shared_extents)
> >>>>> +echo "Number of non-shared extents in the whole file: ${found5}" >=
>
> >>>>> $seqres.full
> >>>>> +
> >>>>> +if [ $found5 !=3D $found1 ]; then
> >>>>> +       echo "Unexpected final number of non-shared extents, has
> >>>>> $found5 expect $found1"
> >>>>> +fi
> >>>>>
> >>>>>    # success, all done
> >>>>>    status=3D0
> >>>>> diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
> >>>>> index 3bf5a5e6..e318c2e9 100644
> >>>>> --- a/tests/btrfs/276.out
> >>>>> +++ b/tests/btrfs/276.out
> >>>>> @@ -1,16 +1,12 @@
> >>>>>    QA output created by 276
> >>>>>    wrote 17179869184/17179869184 bytes at offset 0
> >>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>>>> -Number of non-shared extents in the whole file: 131072
> >>>>>    Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
> >>>>> -Number of shared extents in the whole file: 131072
> >>>>>    wrote 1048576/1048576 bytes at offset 8388608
> >>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>>>>    wrote 1048576/1048576 bytes at offset 12884901888
> >>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>>>>    Number of non-shared extents in the whole file: 16
> >>>>> -Number of shared extents in the whole file: 131056
> >>>>>    Number of non-shared extents in range [8M, 9M): 8
> >>>>>    Number of non-shared extents in range [12G, 12G + 1M): 8
> >>>>>    Delete subvolume (commit): 'SCRATCH_MNT/snap'
> >>>>> -Number of non-shared extents in the whole file: 131072
> >>>>> --
> >>>>> 2.41.0
> >>>>>
