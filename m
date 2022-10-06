Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F305F6F87
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiJFUmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiJFUmD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 16:42:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A721C3C8ED
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 13:41:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FDFA5C0036;
        Thu,  6 Oct 2022 16:41:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Oct 2022 16:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665088895; x=1665175295; bh=dCDAuJam/A
        LXcciL+1BUeUqgykAdymq0pE1nBU82yeY=; b=MYFJe5Zbg9XTsUomrFqIFRAfEe
        xmlJ2rvNayl7rLSyDySeCMrLatL0HgG8zxAApOoceq9pJ/ceLpt4nSwXOKb2cCIc
        +4Ccq4myysYfMl63VTbrYyLLQRP8bGlh3yjn7kQDorMxPy7FiDgwfzMO5JngS9+G
        UpENONO3nwOnVraACKjA+I3cAWvNdZwagdzna3u6nNp/ylYDN7QRBiJV99OYljG1
        f4z5z3dlbcDH4w8vllNkYWMnkNlFwXrEhKVcsnFgZi1wfiNMRxJVrbaNeOOHyEM8
        9tyFBogTCKuzqsiqBdlZE20Nwu9erNomiZqwLF4UIT49yKG3dUgxh5/IMoPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665088895; x=1665175295; bh=dCDAuJam/ALXcciL+1BUeUqgykAd
        ymq0pE1nBU82yeY=; b=lhcd+oJ8j7iJvoiwgB0fNRdlUqEQ4WNsdA0XOiXQIhcj
        nhhRPU/B3bZ7wYvYmBLdHd/6xHQhRliJBC1ZXVROFtFZe2EV4j2XywY4sa8pXYqs
        lNhrjS0bXEx3xnZVcTfzhGgh/Yuw1CqwqjCVbYAin7baUPRfN5GvZ91Oy5lFPa2E
        4nT9klF87EeU31WRRZYBOJeukV8zdOBIeAQdsHbqeldYyWUbiFNVz5OmpSvAeGx4
        mQrfJPaGkIb24c9WCqpvyYkuS6L5SmVQUtCL6SECfBqQCBR4k5Q4aWej6MejXTL2
        aqUhjkpvX+lj2tZPO6GVVcPbxqI5HFPMCtQ9wNr5pg==
X-ME-Sender: <xms:fj0_Yx8WYozJGGauyWJsc-gKYFXvXiu-WPoZxFkejeyxtXCyHCFDrw>
    <xme:fj0_Y1thLXSq24KNxLqClpbupDZ-zIVcf_lVHNg0CY_9M62Q0nHDJgJbIU8j8G3y3
    OT8rZyhbAZ3g0Q39y4>
X-ME-Received: <xmr:fj0_Y_CNDt7RcAIJ8U4MxLwAb3tUkPkQuzOqFSMqpNQTgCmSFbjaPLrm6wmSxtIhnM98NQWQq3MElLcyLiCMlH9WO5igbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:fz0_Y1d7291dBdhKx44cA-dHaOHVpgp5xIATLpZYteEBYsBWK2WDSQ>
    <xmx:fz0_Y2Nyuwnr4zKAOH6-3GAMriAkG3uYp17gm1Koiin5rGOs_P7RBQ>
    <xmx:fz0_Y3lCv1skXhYDJ2HEz1WBVI7f3MwNE3LF2E7g7tZC8i2TZXq3Sw>
    <xmx:fz0_Y_ZIT29f2QmScXNFFptih9OM08fbFJKyOeq_LyHoB0b982_WrA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 16:41:34 -0400 (EDT)
Date:   Thu, 6 Oct 2022 13:41:32 -0700
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
Message-ID: <Yz89fEqWnh+iwA9/@zen>
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com>
 <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
 <Yz8gq6ErCqeMGUO1@zen>
 <CAL3q7H6Bn47CFL0tOsjCZ3iLgEPRm9_ZXV7duUSMZ2H-g0JhgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6Bn47CFL0tOsjCZ3iLgEPRm9_ZXV7duUSMZ2H-g0JhgQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 06, 2022 at 08:56:03PM +0100, Filipe Manana wrote:
> On Thu, Oct 6, 2022 at 7:38 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Thu, Oct 06, 2022 at 10:48:33AM +0100, Filipe Manana wrote:
> > > On Thu, Oct 6, 2022 at 9:06 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > >
> > > >
> > > >
> > > > On 2022/10/6 03:49, Boris Burkov wrote:
> > > > > When doing a large fallocate, btrfs will break it up into 256MiB
> > > > > extents. Our data block groups are 1GiB, so a more natural maximum size
> > > > > is 1GiB, so that we tend to allocate and fully use block groups rather
> > > > > than fragmenting the file around.
> > > > >
> > > > > This is especially useful if large fallocates tend to be for "round"
> > > > > amounts, which strikes me as a reasonable assumption.
> > > > >
> > > > > While moving to size classes reduces the value of this change, it is
> > > > > also good to compare potential allocator algorithms against just 1G
> > > > > extents.
> > > >
> > > > Btrfs extent booking is already causing a lot of wasted space, is this
> > > > larger extent size really a good idea?
> > > >
> > > > E.g. after a lot of random writes, we may have only a very small part of
> > > > the original 1G still being referred.
> > > > (The first write into the pre-allocated range will not be COWed, but the
> > > > next one over the same range will be COWed)
> > > >
> > > > But the full 1G can only be freed if none of its sectors is referred.
> > > > Thus this would make preallocated space much harder to be free,
> > > > snapshots/reflink can make it even worse.
> > > >
> > > > So wouldn't such enlarged preallocted extent size cause more pressure?
> > >
> > > I agree, increasing the max extent size here does not seem like a good
> > > thing to do.
> > >
> > > If an application fallocates space, then it generally expects to write to all
> > > that space. However future random partial writes may not rewrite the entire
> > > extent for a very long time, therefore making us keep a 1G extent for a very
> > > long time (or forever in the worst case).
> > >
> > > Even for NOCOW files, it's still an issue if snapshots are used.
> > >
> >
> > I see your point, and agree 1GiB is worse with respect to bookend
> > extents. Since the patchset doesn't really rely on this, I don't mind
> > dropping the change. I was mostly trying to rule this out as a trivial
> > fix that would obviate the need for other changes.
> >
> > However, I'm not completely convinced by the argument, for two reasons.
> >
> > The first is essentially Qu's last comment. If you guys are right, then
> > 256MiB is probably a really bad value for this as well, and we should be
> > reaping the wins of making it smaller.
> 
> Well, that's not a reason to increase the size, quite the opposite.

Agreed. My point was more: why is it 256MiB? There is something we would
tradeoff against bookend waste (based on your later comment, I take it
to be performance for the big files). I believe that with 256MiB we have
already crossed the bookend rubicon, so we might as well accept it.

> 
> >
> > The second is that I'm not convinced of how the regression is going to
> > happen here in practice.
> 
> Over the years, every now and then there are users reporting that
> their free space is mysteriously
> going away and they have no clue why, even when not using snapshots.
> More experienced users
> provide help and eventually notice it's caused by many bookend
> extents, and the given workaround
> is to defrag the files.
> 
> You can frequently see such reports in threads on this mailing list or
> in the IRC channel.

That's not what I was asking, really. Who overwrites 256MiB but not
1GiB? Is that common? Overwriting <256MiB (or not covering an extent)
in the status quo is exactly as bad, as far as I can see.

> 
> > Let's say someone does a 2GiB falloc and writes
> > the file out once. In the old code that will be 8 256MiB extents, in the
> > new code, 2 1GiB extents. Then, to have this be a regression, the user
> > would have to fully overwrite one of the 256MiB extents, but not 1GiB.
> > Are there a lot of workloads that don't use nocow, and which randomly
> > overwrite all of a 256MiB extent of a larger file? Maybe..
> 
> Assuming that all or most workloads that use fallocate also set nocow
> on the files, is quite a big stretch IMO.

Agreed. I won't argue based on nocow.

> It's true that for performance critical applications like traditional
> relational databases, people usually set nocow,
> or the application or some other software does it automatically for them.
> 
> But there are also many applications that use fallocate and people are
> not aware of and don't set nocow, nor
> anything else sets nocow automatically on the files used by them.
> Specially if they are not IO intensive, in which
> case they may not be noticed and therefore space wasted due to bookend
> extents is more likely to happen.
> 
> Having a bunch of very small extents, say 4K to 512K, is clearly bad
> compared to having just a few 256M extents.
> But having a few 1G extents instead of a group of 256M extents,
> probably doesn't make such a huge difference as
> in the former case.
> 
> Does the 1G extents benefit some facebook specific workload, or some
> well known workload?

I observed that we have highly fragmented file systems (before
autorelocate) and that after a balance, they regress back to fragmented
in a day or so. The frontier of new block group allocations is all from
large fallocates (mostly from installing binary packages for starting or
updating services, getting configuration/data blobs, etc..)

If you do two 1GiB fallocates in a fs that looks like:
       BG1                BG2            BG3
|xxx.............|................|................|
you get something like:
|xxxxAAAABBBBCCCC|DDDDEEEEFFFFGGGG|HHHH............|
then you do some random little writes:
|xxxxAAAABBBBCCCC|DDDDEEEEFFFFGGGG|HHHHy...........|
then you delete the second fallocate because you're done with that
container:
|xxxxAAAABBBBCCCC|DDDD............|HHHHy...........|
then you do another small write:
|xxxxAAAABBBBCCCC|DDDDz...........|HHHHy...........|
then you fallocate the next package:
|xxxxAAAABBBBCCCC|DDDDzIIIIJJJJ...|HHHHyKKKK.......|
and so on until you blow through 100 block groups in a day.

I don't think this is particularly Facebook specific, but does seem
specific to a "installs/upgrades lots of containers" type of workload.

> 
> 
> >
> > Since I'm making the change, it's incumbent on me to prove it's safe, so
> > with that in mind, I would reiterate I'm fine to drop it.
> >
> > > >
> > > > In fact, the original 256M is already too large to me.
> > > >
> > > > Thanks,
> > > > Qu
> > > > >
> > > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > > ---
> > > > >   fs/btrfs/inode.c | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > > > index 45ebef8d3ea8..fd66586ae2fc 100644
> > > > > --- a/fs/btrfs/inode.c
> > > > > +++ b/fs/btrfs/inode.c
> > > > > @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
> > > > >       if (trans)
> > > > >               own_trans = false;
> > > > >       while (num_bytes > 0) {
> > > > > -             cur_bytes = min_t(u64, num_bytes, SZ_256M);
> > > > > +             cur_bytes = min_t(u64, num_bytes, SZ_1G);
> > > > >               cur_bytes = max(cur_bytes, min_size);
> > > > >               /*
> > > > >                * If we are severely fragmented we could end up with really
