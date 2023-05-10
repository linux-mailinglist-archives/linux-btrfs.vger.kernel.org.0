Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD96FD36F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 03:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjEJBJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 21:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJBJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 21:09:37 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A329D49C1
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 18:09:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E6A62320093C;
        Tue,  9 May 2023 21:09:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 21:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683680973; x=1683767373; bh=lI
        jK30CzwyqbzxCiPYpkgJPNb2TwRcBVw8b8oAILw6A=; b=CORK/ePHrVhJLgGsQF
        maM0aMX+7Z9IGwF7eeoBW9SnjPBIRL+VkcyfJyk1tUxNOVYtOLU1/X1yNz3xOimT
        m7V25AvWPnNfOBQGp/SI0f+r+ErMx9lVWP8rzgZSzevd0j5upcjOVjoyEwcJDkw3
        UHLNpr7bgoIGLEo0Jj79sFklv9p1zgWwy04HuTGmUhHPSbNRyx+AtWegQpB70iJZ
        hTL+Cx5pHOsby2U3ypPciWcIVO6Fsx3+fu/HlpGEsCfRBQvgTedGM1Q+YnrWoVcH
        T6DNw0Ch1Ykp4SHIe2jTt2W7tNsgfnqIcjzZxCg+INwnkj4JUW7mXaoEGHywFRbK
        qetA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683680973; x=1683767373; bh=lIjK30Czwyqbz
        xCiPYpkgJPNb2TwRcBVw8b8oAILw6A=; b=GKdLcuawnTdg7EK/fqduk8dqGXwqq
        4xmk+q++GmuD7Y+WmLImRR2N8Te8F/1F+Ha3ExJNiwozfNfdfapzg1cCQ1qWXb78
        HKyqco06vsMidzYW82ISae0UYSIXngZtYm7GgB6B+ECoCwDcQsLFj1gPCcieMhFO
        pxdPuxpQ9+0Cn294Nu9bijNIKPREzzmDfvW9FOwpypPULriy4qb3YVihc6013naK
        3PalXv0ar1zF47eU9jJ7maiCHA85mSqlikkHhXYjts+vk178qgmC0RjZ6BBDO+Aa
        ixfdxZ/6Qj+OEyK0p5sKt4wnVRDsWfPcQG2csPTzpJYAVFh53Pe3ZCUaA==
X-ME-Sender: <xms:ze5aZJzqckSrb-MwnWJm9YTeWsKIvkea_7jgrVRFFY7XYoCVHN5_Ig>
    <xme:ze5aZJQofDtTnKkFBid7JduN95zno0rPrBbaIaodyuRkl9d_dvZPz0n9Blzf2B5kE
    HSPtFg5mH0KH9gw9gw>
X-ME-Received: <xmr:ze5aZDWXIphy-ODjvtdPCfZ1oa7nM6T8ieKJnzrbSH8T-AVBpf0jJjCWSmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    elffegveegteeugeeltdeuledutddukeehhfduueehgeefveeiheetveeijeeuteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ze5aZLhrU3qDVTHsbF-NFb3aEOkbaIAsvTgqxz4tFif88abUfP4B3g>
    <xmx:ze5aZLDxLyL2-qjoFmSlEhw_Qs-iQ2wzg-Qqc-Y_tmS-R_94YDUwpg>
    <xmx:ze5aZEKktJBveDpVGMeuZMxMlI4dYr_Kube4_FlLOcpSCW5ncCdMKw>
    <xmx:ze5aZA42l4ky99a3YLqx1nbcT9pgB9MsHcMovfIFA7oZxkr8IiPXuA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 21:09:32 -0400 (EDT)
Date:   Tue, 9 May 2023 18:09:26 -0700
From:   Boris Burkov <boris@bur.io>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH RFC 0/9] btrfs: simple quotas
Message-ID: <ZFruxlTqEg51FMwv@devvm9258.prn0.facebook.com>
References: <cover.1683075170.git.boris@bur.io>
 <ed97c734-a3fb-539c-c7cd-0b0667465790@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed97c734-a3fb-539c-c7cd-0b0667465790@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 05, 2023 at 12:13:58PM +0800, Anand Jain wrote:
> On 3/5/23 08:59, Boris Burkov wrote:
> > btrfs quota groups (qgroups) are a compelling feature of btrfs that
> > allow flexible control for limiting subvolume data and metadata usage.
> > However, due to btrfs's high level decision to tradeoff snapshot
> > performance against ref-counting performance, qgroups suffer from
> > non-trivial performance issues that make them unattractive in certain
> > workloads. Particularly, frequent backref walking during writes and
> > during commits can make operations increasingly expensive as the number
> > of snapshots scales up. For that reason, we have never been able to
> > commit to using qgroups in production at Meta, despite significant
> > interest from people running container workloads, where we would benefit
> > from protecting the rest of the host from a buggy application in a
> > container running away with disk usage.
> > 
> > This patch series introduces a simplified version of qgroups called
> > simple quotas (squotas) which never computes global reference counts
> > for extents, and thus has similar performance characteristics to normal,
> > quotas disabled, btrfs. The "trick" is that in simple quotas mode, we
> > account all extents permanently to the subvolume in which they were
> > originally created. That allows us to make all accounting 1:1 with
> > extent item lifetime, removing the need to walk backrefs. However, this
> > sacrifices the ability to compute shared vs. exclusive usage. It also
> > results in counter-intuitive, though still predictable and simple,
> > accounting in the cases where an original extent is removed while a
> > shared copy still exists. Qgroups is able to detect that case and count
> > the remaining copy as an exclusive owner, while squotas is not. As a
> > result, squotas works best when the original extent is immutable and
> > outlives any clones.
> > 
> > In order to track the original creating subvolume of a data extent in
> > the face of reflinks, it is necessary to add additional accounting to
> > the extent item. To save space, this is done with a new inline ref item.
> > However, the downside of this approach is that it makes enabling squota
> > an incompat change, denoted by the new incompat bit SIMPLE_QUOTA. When
> > this bit is set and quotas are enabled, new extent items get the extra
> > accounting, and freed extent items check for the accounting to find
> > their creating subvolume.
> > 
> > Squotas reuses the api of qgroups. The only difference is that when you
> > enable quotas via `btrfs quota enable`, you pass the `--simple` flag.
> > Squotas will always report exclusive == shared for each qgroup.
> > 
> > This is still a preliminary RFC patch series, so not all the ducks are
> > fully in a row. In particular, some userspace parts are missing, like
> > meaningful integration with fsck, which will drive further testing.
> > 
> > My current branches for btrfs-progs and fstests do contain some (sloppy)
> > minimal support needed to run and test the feature:
> > btrfs-progs: https://github.com/boryas/btrfs-progs/tree/squota-progs
> > fstests: https://github.com/boryas/fstests/tree/squota-test
> > 
> > Current testing methodology:
> > - New fstest (btrfs/400 in the squota-test branch)
> > - Run all fstests with squota enabled at mkfs time. Not all tests are
> >    passing in this regime, though this is actually true of qgroups as
> >    well. Most of the issues have to do with leaking reserved space in
> >    less commonly tested cases like I/O failures. My intent is to get this
> >    test suite fully passing.
> > - Run all fstests without squota enabled at mkfs time
> > 
> > Basic performance test:
> 
> > In this test, I ran a workload which generated K files in a subvolume,
> > then took L snapshots of that subvolume, then unshared each file in
> > each subvolume.
> 
> Can you pls provide a link to the test script?
> I couldn't find it in the links mentioned above.
> 
> Thanks, Anand

Hey Anand,

Sorry I missed this message and haven't replied yet.

The reason I didn't share the scripts is that they are sort of spread
across a couple different places and I haven't collected them into a
shareable form (probably in fsperf, eventually)

The repo which has some scripts to scale snapshots, extents and files:
https://github.com/boryas/scripts/tree/main/sh/btrfs-scale
(which depends on my silly personal shell script infra to really
run... https://github.com/boryas/clitools)
and then I don't currently have the script that puts it all together,
(forgot to push and its on a diff computer but I'm at LSFMMBPF...)
but IIRC it does something like:

mkfs on an nvme; mount it
make a subvol
put K files into the subvol with the files scaling script
make a snapshot dir
make L identical snapshots in that dir (no snapshots of snapshots)
touch 4k of each of the 8k files with dd to unshare

If you'd like to play around with the workload before then, but this
isn't enough info, let me know and I'll share more with you ASAP. I
think you should be able to slap something together with this, though.

TL;DR: it's a dumb script that was just a PoC to convince me the basic
scaling was what I expected. But I promise to better share my
methodology with the next time I send the patch series.

Thanks for your interest!

Boris

> 
>  The measurement is just total walltime. K is the row
> > index and L the column index, so in these tables, we vary between 1
> > and 100 files and 1 and 10000 snapshots. The "n" table is no quotas,
> > the "q" table is qgroups and the "s" table is squotas. As you can see,
> > "n" and "s" are quite similar, while "q" falls of a cliff as the
> > number of snapshots increases. More sophisticated and realistic
> > performance testing that doesn't abuse such an insane number of
> > snapshots is still to come.
> > 
> > n
> >          1       10      100     1000    10000
> > 1       0.18    0.24    1.58    16.49   211.34
> > 10      0.28    0.43    2.80    29.74   324.70
> > 100     0.55    0.99    6.57    65.13   717.51
> > 
> > q
> >          1       10      100     1000    10000
> > 1       2.19    0.35    2.32    25.78   756.62
> > 10      0.34    0.48    3.24    68.72   3731.73
> > 100     0.64    0.80    7.63    215.54  14170.73
> > 
> > s
> >          1       10      100     1000    10000
> > 1       2.19    0.32    1.83    19.19   231.75
> > 10      0.31    0.43    2.86    28.86   351.42
> > 100     0.70    0.90    6.75    67.89   742.93
> > 
> > 
> > Boris Burkov (9):
> >    btrfs: simple quotas mode
> >    btrfs: new function for recording simple quota usage
> >    btrfs: track original extent subvol in a new inline ref
> >    btrfs: track metadata owning root in delayed refs
> >    btrfs: record simple quota deltas
> >    btrfs: auto hierarchy for simple qgroups of nested subvols
> >    btrfs: check generation when recording simple quota delta
> >    btrfs: expose the qgroup mode via sysfs
> >    btrfs: free qgroup rsv on io failure
> > 
> >   fs/btrfs/accessors.h            |   6 +
> >   fs/btrfs/backref.c              |   3 +
> >   fs/btrfs/delayed-ref.c          |  13 +-
> >   fs/btrfs/delayed-ref.h          |  28 ++++-
> >   fs/btrfs/extent-tree.c          | 143 +++++++++++++++++----
> >   fs/btrfs/fs.h                   |   7 +-
> >   fs/btrfs/ioctl.c                |   4 +-
> >   fs/btrfs/ordered-data.c         |   6 +-
> >   fs/btrfs/print-tree.c           |  12 ++
> >   fs/btrfs/qgroup.c               | 216 +++++++++++++++++++++++++++++---
> >   fs/btrfs/qgroup.h               |  29 ++++-
> >   fs/btrfs/ref-verify.c           |   3 +
> >   fs/btrfs/relocation.c           |  11 +-
> >   fs/btrfs/sysfs.c                |  26 ++++
> >   fs/btrfs/transaction.c          |  11 +-
> >   fs/btrfs/tree-checker.c         |   3 +
> >   include/uapi/linux/btrfs.h      |   1 +
> >   include/uapi/linux/btrfs_tree.h |  13 ++
> >   18 files changed, 471 insertions(+), 64 deletions(-)
> > 
> 
> 
