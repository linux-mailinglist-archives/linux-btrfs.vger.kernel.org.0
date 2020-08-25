Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0BD2521EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 22:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYUYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 16:24:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40957 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgHYUYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 16:24:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DAD6B5C00A4;
        Tue, 25 Aug 2020 16:24:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 16:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=Y
        NYS1v4HH7S0A0jSojXFpubYCzeVty6/4DC9QDe0hak=; b=Qiu7UKsVr0RENG1Ro
        3XI+8wwtwcGIN2QwltaUunX9TQ/gOAP8OSSlR4TDMXC5dsc6CrPHPFKmaZe3QAbk
        7ziiPtRNiSfvgmN7Ii1yfKtPvqX6o0H+p/iygdHhctpYEH8oz43JDsm5rPT1kWiF
        ZGcFBkVYvGIB1/hAXWPw5wsM4o//fvsBJSVLDXVGL330U5PQfETnep1yEuko/eOt
        1gIH/L9o3XeLOzfw7/oH0yqNnFZSruTl7hBq2RsH4M3hZXaDwVe2KHPdrYmzqndk
        dcGQHcr5lGG8ucqeR44M3rOywZd/Q74VkJ+Ch8NrI19W2QGimpPt3aYimqWjNLes
        AuGXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=YNYS1v4HH7S0A0jSojXFpubYCzeVty6/4DC9QDe0h
        ak=; b=nTARZSs8XarUGPTfzYSJruwQ/sqSsOVPMetZvL9+7xcw/b3uwxiDDslzB
        l21VQBViOPFihQmMQian/6ajRI/ZJ72Q/xfrCHOn9RUaEbuX0kMbTYfHnz92k6dD
        uam9swUPc2XHB82Ju511YEqlw47Z+l8vITa450tgdAc3qr96REAp69E+VVPisftF
        FHhVPZyDNJVCwxtJdoEABkIoDg0U56kH8k1DG/4EdBNK9d8StcF2jwkCvLgt4I7o
        r0UwTIvhC6Y6/MM5Jee+hKttvhoZlleI1wrPDjE234BTxQHFuO6bEI4ZE/DEVpSk
        YMP8plNUoTO1u+te2Y6/T6jndsACA==
X-ME-Sender: <xms:YHNFXyfrUYHN3m7L8HBlzQfQ-bmLi2myy7kLjk28zUb0u-N6P2JncA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjfgesthekredttderjeenucfhrhhomhepueho
    rhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrh
    hnpeeigfetjeehvdejuedtfeejudffiedtheeguedujeffvddvjeejjeeiteehleegleen
    ucfkphepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:YHNFX8NFEIt5akPLJTMzr3ZKEzxtk6FN1pKF35o1KoGo5bP51dNqsg>
    <xmx:YHNFXzg-vzUXYfvkujsCtDnd_J1dMgZU_GhqQjzmcqDB1kkEaTTzdg>
    <xmx:YHNFX_851-Q-z3WmJ1zwygmCh1zQmO5sfK0QGTrjlLdqlB_ZOiuPPg>
    <xmx:YHNFX87zj06kaJIXPFSdI_w56EFHV1FV5XX1Ok8_IlWLHSknVXddvg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DC70328005E;
        Tue, 25 Aug 2020 16:23:59 -0400 (EDT)
Date:   Tue, 25 Aug 2020 13:23:55 -0700
From:   Boris Burkov <boris@bur.io>
To:     Martin Raiber <martin@urbackup.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
Message-ID: <20200825202355.GA3956415@devvm842.ftw2.facebook.com>
References: <20200804175516.2511704-1-boris@bur.io>
 <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
 <5c0b0cd7-b04d-7715-8d0e-6466f7e802a5@toxicpanda.com>
 <01020173bed9de46-08b668c9-e188-412b-846c-4ed33ce2fe4f-000000@eu-west-1.amazonses.com>
 <20200807204533.GA429307@devvm842.ftw2.facebook.com>
 <01020173d98ca8c7-69541242-38df-4d7f-adfd-d415f9b688bc-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01020173d98ca8c7-69541242-38df-4d7f-adfd-d415f9b688bc-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mon, Aug 10, 2020 at 06:05:41PM +0000, Martin Raiber wrote:
> On 07.08.2020 22:45 Boris Burkov wrote:
> >On Wed, Aug 05, 2020 at 01:40:16PM +0000, Martin Raiber wrote:
> >>On 05.08.2020 01:08 Josef Bacik wrote:
> >>>On 8/4/20 6:48 PM, Qu Wenruo wrote:
> >>>>
> >>>>On 2020/8/5 上午1:55, Boris Burkov wrote:
> >>>>>Currently, btrfs_ioctl_subvol_setflags forces a
> >>>>>btrfs_commit_transaction
> >>>>>while holding subvol_sem. As a result, we have seen workloads where
> >>>>>calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
> >>>>>legitimately slow commit. This gets even worse if the workload tries to
> >>>>>set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
> >>>>>
> >>>>>Change the commit to a btrfs_end_transaction so that the ioctl can
> >>>>>return in a timely fashion and piggy back on a later commit.
> >>>>>
> >>>>>Signed-off-by: Boris Burkov <boris@bur.io>
> >>>>>---
> >>>>>   fs/btrfs/ioctl.c       | 2 +-
> >>>>>   fs/btrfs/transaction.c | 4 ++--
> >>>>>   2 files changed, 3 insertions(+), 3 deletions(-)
> >>>>>
> >>>>>diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >>>>>index bd3511c5ca81..3ae484768ce7 100644
> >>>>>--- a/fs/btrfs/ioctl.c
> >>>>>+++ b/fs/btrfs/ioctl.c
> >>>>>@@ -1985,7 +1985,7 @@ static noinline int
> >>>>>btrfs_ioctl_subvol_setflags(struct file *file,
> >>>>>           goto out_reset;
> >>>>>       }
> >>>>>   -    ret = btrfs_commit_transaction(trans);
> >>>>>+    ret = btrfs_end_transaction(trans);
> >>>>This means the setflag is not committed to disk, and if a powerloss
> >>>>happens before a transaction commit, then the setflag operation just get
> >>>>lost.
> >>>>
> >>>>This means, previously if this ioctl returns, users can expect that the
> >>>>flag is always set no matter what, but now there is no guarantee.
> >>>>
> >>>>Personally I'm not sure if we really want that operation to be committed
> >>>>to disk.
> >>>>Maybe that transaction commit can be initialized in user space, so for
> >>>>multiple setflags, we only commit once, thus saves a lot of time.
> >>>>
> >>>I'm of the opinion that we shouldn't be committing the transaction
> >>>for stuff like this, unless there's a really good reason to.
> >>>Especially given we're holding the subvol lock here, we should
> >>>just do end_transaction.  Thanks,
> >> From a user perspective I'd appreciate having the option to set it
> >>in a non-durable way (I have seen btrfs property sets hanging for a
> >>long time as well). But currently my application kind of depends on
> >>it being durable. Making it non-durable wouldn't break much and I
> >>guess the old behaviour could be emulated by a "btrfs fi sync
> >><subvol>" afterwards, but idk how much other stuff depends on it
> >>being durable. Making it consistent with btrfs subvol del with the
> >>"-c" switch would be nice and consistent as well (and the -c switch
> >>could be done via IOC_SYNC after setting the properties).
> >Martin,
> >
> >Thanks for your perspective, that's helpful. Could you elaborate on how
> >your application relies on the durability? I would just like to learn
> >more about how this might affect people.
> >
> >I really like the -c idea, but I fear if people are broadly depending on
> >that behavior by default, it wouldn't be enough.
> 
> It is a backup software that currently works a bit like this:
> 
> 1. Add database entry for new backup A with done=0
> 2. Create btrfs subvol A for backup
> 3. rsync backup source to A
> 4. btrfs fi sync A
> 5. Set subvol A to read-only
> 6. Set database entry for A to done=1
> 
> On startup: Delete all btrfs subvols of backups where done!=1 in the
> database.
> 
> Switching 4. and 5. should fix it if changing properties is not
> durable. Otherwise there could be subvols that don't get deleted on
> startup (after crash) and are not read-only. Those would be an
> annoyance e.g. if the backups are further replicated using btrfs
> end/receive, or if one relies on the finished backups being
> read-only.
> 
> Worst case there is someone that leaves 4. out and relies on 5. to
> sync to disk (would that work?).
> 
> 
Thanks for the extra detail, that example makes sense.

As I see it, our options to move forward are:
1. Leave the sync; suffer hung setflags calls, but no regression.
2a. Use this patch; risk affecting use-cases like Martin's.
2b. Also add a -c option to btrfs subvol setflags for people to move to.
3. Add an 'async' option to btrfs subvol setflags people can use if
they're affected by the issue this patch fixes.
4. Introduce a new command for setting a subvol read only with a -c flag

1 is a bummer as it doesn't move us towards less unneeded syncs. 2a/b
are "easy" but I fear they might be too risky. 3 and 4 introduce
different kinds of ugliness into the user interface, but don't
negatively affect existing use cases. I'm happy to write up whichever
variant people think is best.
