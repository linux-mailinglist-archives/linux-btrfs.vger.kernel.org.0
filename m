Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1AF23F3F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Aug 2020 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgHGUpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Aug 2020 16:45:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44157 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728545AbgHGUpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Aug 2020 16:45:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 85C775C0135;
        Fri,  7 Aug 2020 16:45:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Aug 2020 16:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=1
        sB9ZdDG1I4hVZ1klQFggMSurS3kilRWByI0MkUtses=; b=skjoi1HETdUUxH3RI
        KyniUTP5pF67b9BEL15MqROBx2gA9wnuNi8DIoO0Pl0HqzKCxYrHDgc4JzniX5e9
        JRctXE1feJUoRCTpWkzLSZcsj4sPyoTC9U6J+6/yML4XECDrZQa/jVS0sttleiRY
        dLNbeW0A35GPXUkRFCl9S9ppeOQqog6eMoOqkBzueWknzpJ01GZ+E84kZKGSLr4l
        Hx6R5HK4DeJHY1VMmhhDDviy+UaqyEDMn5QNLrom/3nf7sUbXRpEKh8kiJEtLf4t
        n34kPHeGRRgz70a/Y5qoYrvPVLBXAs6AJaxrOl6KYVBUfeH91gARHXglJOSYan3F
        U8CAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=1sB9ZdDG1I4hVZ1klQFggMSurS3kilRWByI0MkUts
        es=; b=l5zS0ZY7ZkV1v6GlHDSipO2iy1DqOqJkNmV1amhDP3jFccJZXa+rZXImM
        oaUg+TZdxnQXUx6xv22up0iPi0P+/xAE/ftkUHkvvmNTgSa+3ewva7Wehr66TkJf
        F58aAigummR0Dkbk0h2rWGuxWDQ3G3AlX8JAz1Lfpd9TYA/BD5lWo6h8GfiE5vYX
        1SJ/JKKDWaOcvHebT/g8q3gZrNLA+jgyofAh90QdSTYG6Qt6V5Fko3KcwghTwSh/
        Fes7tLepWHaSWcyia7pOmDYB6eLU6BYmjhMWx6k7TU8N8HqXn9f2akW9eWwSTDuO
        PT95SeafMn7ZOT5SDryvoh+qouE3A==
X-ME-Sender: <xms:cb0tXyO6CCLv8n0oZAbBlOIEey1lEvt2lrKcFmdAZRdhLvBTSB1Ntw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtreejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epiefgteejhedvjeeutdefjeduffeitdehgeeuudejffdvvdejjeejieetheelgeelnecu
    kfhppeduieefrdduudegrddufedvrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:cb0tXw_PLI86YsazdYzRFE2f2Spb8GTlfJ5yHq9pr1xoIxL8B6pmhQ>
    <xmx:cb0tX5T7TxP-zxCZyDLMYVpO4WkYBAQ-i4Z1bFr6-QUDGBapcjNeCQ>
    <xmx:cb0tXyuCaJ5dYASkTqQQTFU_U4IQD77GuarlqCZQEzwuWfuCQYPDaw>
    <xmx:cr0tX65dfFkbOsEG2X4GgYpNIrnjmH0WffzW8HvDNB-iVOigZHRnBg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 102173060067;
        Fri,  7 Aug 2020 16:45:37 -0400 (EDT)
Date:   Fri, 7 Aug 2020 13:45:33 -0700
From:   Boris Burkov <boris@bur.io>
To:     Martin Raiber <martin@urbackup.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
Message-ID: <20200807204533.GA429307@devvm842.ftw2.facebook.com>
References: <20200804175516.2511704-1-boris@bur.io>
 <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
 <5c0b0cd7-b04d-7715-8d0e-6466f7e802a5@toxicpanda.com>
 <01020173bed9de46-08b668c9-e188-412b-846c-4ed33ce2fe4f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01020173bed9de46-08b668c9-e188-412b-846c-4ed33ce2fe4f-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 05, 2020 at 01:40:16PM +0000, Martin Raiber wrote:
> On 05.08.2020 01:08 Josef Bacik wrote:
> >On 8/4/20 6:48 PM, Qu Wenruo wrote:
> >>
> >>
> >>On 2020/8/5 上午1:55, Boris Burkov wrote:
> >>>Currently, btrfs_ioctl_subvol_setflags forces a
> >>>btrfs_commit_transaction
> >>>while holding subvol_sem. As a result, we have seen workloads where
> >>>calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
> >>>legitimately slow commit. This gets even worse if the workload tries to
> >>>set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
> >>>
> >>>Change the commit to a btrfs_end_transaction so that the ioctl can
> >>>return in a timely fashion and piggy back on a later commit.
> >>>
> >>>Signed-off-by: Boris Burkov <boris@bur.io>
> >>>---
> >>>  fs/btrfs/ioctl.c       | 2 +-
> >>>  fs/btrfs/transaction.c | 4 ++--
> >>>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>>diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >>>index bd3511c5ca81..3ae484768ce7 100644
> >>>--- a/fs/btrfs/ioctl.c
> >>>+++ b/fs/btrfs/ioctl.c
> >>>@@ -1985,7 +1985,7 @@ static noinline int
> >>>btrfs_ioctl_subvol_setflags(struct file *file,
> >>>          goto out_reset;
> >>>      }
> >>>  -    ret = btrfs_commit_transaction(trans);
> >>>+    ret = btrfs_end_transaction(trans);
> >>
> >>This means the setflag is not committed to disk, and if a powerloss
> >>happens before a transaction commit, then the setflag operation just get
> >>lost.
> >>
> >>This means, previously if this ioctl returns, users can expect that the
> >>flag is always set no matter what, but now there is no guarantee.
> >>
> >>Personally I'm not sure if we really want that operation to be committed
> >>to disk.
> >>Maybe that transaction commit can be initialized in user space, so for
> >>multiple setflags, we only commit once, thus saves a lot of time.
> >>
> >
> >I'm of the opinion that we shouldn't be committing the transaction
> >for stuff like this, unless there's a really good reason to.
> >Especially given we're holding the subvol lock here, we should
> >just do end_transaction.  Thanks,
> From a user perspective I'd appreciate having the option to set it
> in a non-durable way (I have seen btrfs property sets hanging for a
> long time as well). But currently my application kind of depends on
> it being durable. Making it non-durable wouldn't break much and I
> guess the old behaviour could be emulated by a "btrfs fi sync
> <subvol>" afterwards, but idk how much other stuff depends on it
> being durable. Making it consistent with btrfs subvol del with the
> "-c" switch would be nice and consistent as well (and the -c switch
> could be done via IOC_SYNC after setting the properties).

Martin,

Thanks for your perspective, that's helpful. Could you elaborate on how
your application relies on the durability? I would just like to learn
more about how this might affect people.

I really like the -c idea, but I fear if people are broadly depending on
that behavior by default, it wouldn't be enough.
