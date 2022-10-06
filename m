Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D25F6D92
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 20:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiJFSin (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJFSim (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 14:38:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C2C5101
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 11:38:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CE645C0106;
        Thu,  6 Oct 2022 14:38:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 06 Oct 2022 14:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665081518; x=1665167918; bh=yT7TdFj/SL
        9c5RLgORfdiJreNvJOaNfD1Hqs/obPsCU=; b=kGI6XcEsQs5VWFEG9DyC4hdZ2p
        mQ+bQNBjOVGv97UJueTBaHB+fAXMgCE3kzxpDe6qH303YzJdkM8vhYgQTDrkr9uw
        oRoylfG6YzqYFiYv7paAEjXtN11OhxatpHgTRrWSLrQEYAJlpF97Jv8JxiRDhJd/
        rjByv1lTM13lk40yTBVBxVd92HLcRsRDOvGL9PDVWl2dd9BdT0aCO6rtoIawgKfE
        yTRb9CUxNv9vNBYGmDHh77d2fKQWr/VJAEtACH67sAjaiQOHL8am7BAA1utunXQC
        ELCFPrF1yfCFVHdK9CKalOlhd8Qw3CcePX7qS0d92q6qis/tAjC66Vg4ySeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665081518; x=1665167918; bh=yT7TdFj/SL9c5RLgORfdiJreNvJO
        aNfD1Hqs/obPsCU=; b=0FSw/JtTR9QRshVck3jpSM2WoudPce3/DenGajDA/et8
        cwEnpfKp4gWcCUbjlXeO+ehGBSCz6uFO7l/siJUZWccMUVqE4UCkT0YVB2vBv2Mc
        1MZgrCLic8FGJWh+zlp/sPiRQxkfAQUB+97+JmB1bNjtaQX2CXGPWpf38uEppRnC
        pTWja3DrK0jRRpcaA+SbfqV/eIT6IvJ4I2/7nRlosu0aOao5bmIXv69raeVy09dG
        9Mdr40jActr3wyq0iVYwjSY2cvbRfzf71a70dKLhWrnTE5RR2jZkHBVH0ZV5l+Ja
        v2qwZ0xyeQrJzXONnOkQb2Jf1kvBMmywrmrgA21BQw==
X-ME-Sender: <xms:rSA_Y0fcisygmd0Ri0uz4bWB-qJOxCDGzsocQPJZ8oOPxmEW0nndiw>
    <xme:rSA_Y2OwccRzs4Ggy3jr2psQ3C7WQd7tqzdDBi5crDoF2gnar4n_oIU1P4QTwOSTh
    ZKycUYE97fUop3ZKgM>
X-ME-Received: <xmr:rSA_Y1hkhTW6cg5smW-k6BA58b2lYtch4oF1tn_2weROx61fEm36IDLGB3-vz_o4TJe6kRoskgUecrtZXFyB-eC82UGyLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:rSA_Y5819rdKqHQHY3Fbyctd2t6naWCUig5e4QC_m0ngKAe9Cy4hEw>
    <xmx:rSA_Ywtz2RSZ4OoDYQsEEZ37tPtt2d1uOOrvwDLNLqA-WsYIee74lg>
    <xmx:rSA_YwF6_FYgroqb6jbeuoWsJbayCwP7ZArtZcG0E29nn8Hw7k14Ww>
    <xmx:riA_Y5623fB2ePU_9ksUkags_0I1nzc45DGo9dJjz2cUji2Kt6tJvA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 14:38:37 -0400 (EDT)
Date:   Thu, 6 Oct 2022 11:38:35 -0700
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
Message-ID: <Yz8gq6ErCqeMGUO1@zen>
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com>
 <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 06, 2022 at 10:48:33AM +0100, Filipe Manana wrote:
> On Thu, Oct 6, 2022 at 9:06 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2022/10/6 03:49, Boris Burkov wrote:
> > > When doing a large fallocate, btrfs will break it up into 256MiB
> > > extents. Our data block groups are 1GiB, so a more natural maximum size
> > > is 1GiB, so that we tend to allocate and fully use block groups rather
> > > than fragmenting the file around.
> > >
> > > This is especially useful if large fallocates tend to be for "round"
> > > amounts, which strikes me as a reasonable assumption.
> > >
> > > While moving to size classes reduces the value of this change, it is
> > > also good to compare potential allocator algorithms against just 1G
> > > extents.
> >
> > Btrfs extent booking is already causing a lot of wasted space, is this
> > larger extent size really a good idea?
> >
> > E.g. after a lot of random writes, we may have only a very small part of
> > the original 1G still being referred.
> > (The first write into the pre-allocated range will not be COWed, but the
> > next one over the same range will be COWed)
> >
> > But the full 1G can only be freed if none of its sectors is referred.
> > Thus this would make preallocated space much harder to be free,
> > snapshots/reflink can make it even worse.
> >
> > So wouldn't such enlarged preallocted extent size cause more pressure?
> 
> I agree, increasing the max extent size here does not seem like a good
> thing to do.
> 
> If an application fallocates space, then it generally expects to write to all
> that space. However future random partial writes may not rewrite the entire
> extent for a very long time, therefore making us keep a 1G extent for a very
> long time (or forever in the worst case).
> 
> Even for NOCOW files, it's still an issue if snapshots are used.
> 

I see your point, and agree 1GiB is worse with respect to bookend
extents. Since the patchset doesn't really rely on this, I don't mind
dropping the change. I was mostly trying to rule this out as a trivial
fix that would obviate the need for other changes.

However, I'm not completely convinced by the argument, for two reasons.

The first is essentially Qu's last comment. If you guys are right, then
256MiB is probably a really bad value for this as well, and we should be
reaping the wins of making it smaller.

The second is that I'm not convinced of how the regression is going to
happen here in practice. Let's say someone does a 2GiB falloc and writes
the file out once. In the old code that will be 8 256MiB extents, in the
new code, 2 1GiB extents. Then, to have this be a regression, the user
would have to fully overwrite one of the 256MiB extents, but not 1GiB.
Are there a lot of workloads that don't use nocow, and which randomly
overwrite all of a 256MiB extent of a larger file? Maybe..

Since I'm making the change, it's incumbent on me to prove it's safe, so
with that in mind, I would reiterate I'm fine to drop it.

> >
> > In fact, the original 256M is already too large to me.
> >
> > Thanks,
> > Qu
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >   fs/btrfs/inode.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 45ebef8d3ea8..fd66586ae2fc 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
> > >       if (trans)
> > >               own_trans = false;
> > >       while (num_bytes > 0) {
> > > -             cur_bytes = min_t(u64, num_bytes, SZ_256M);
> > > +             cur_bytes = min_t(u64, num_bytes, SZ_1G);
> > >               cur_bytes = max(cur_bytes, min_size);
> > >               /*
> > >                * If we are severely fragmented we could end up with really
