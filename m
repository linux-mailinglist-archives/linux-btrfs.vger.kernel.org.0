Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0631024A528
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHSRqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 13:46:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59085 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgHSRqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 13:46:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 86B3F5C00A3;
        Wed, 19 Aug 2020 13:46:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 19 Aug 2020 13:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=0nyNgkeHqA10W9HAQqD4120OLWwcCt2jSe0b4jwu
        6fk=; b=BbwV/4JBD55taSvlBp57hkMxwnCvbIUvHaBG2blCHDTXrXvPpjUt0bqY
        lL2fzicCmPA3DAMCU+fdpv++WBng3IVJhUKtcvb+XLV9dt5SZFH5IO023KIwxg7V
        /FUkyo501y49cHuBiP2Me4s1QIklHddjRefIKaFMVcL8LTFHDuYL3yEylYgTbUPn
        pNKVCPWVLTbZQKcwbSFyt4TMWjbhObZgq5frKb8IrweffQiJQoXQ3+BAW3c5XRZQ
        neNUI9R7OXTRWFRxkwYamCAbWKU8zWcdOMJ6oXqMs+bUrxJ8eUswTM+uUCN6pSo5
        q9ouob/csJLuGPjjLdBjthhKdhZ9pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0nyNgk
        eHqA10W9HAQqD4120OLWwcCt2jSe0b4jwu6fk=; b=TGOK4rFcxM8nhXVerkwJ7a
        IAVWqcccFv2Huf/lFnH4/GAy+IEXcAubYtEEdegkDjLnt6VMifIEDZWcjgDZPO0F
        2y93ptODMKgcXhJTom96wsGYH1fh0NAS5HMActuei+wIYFemvTdHyKgn/Yrjt3vV
        hikwL+/sCcaintmHUDNF4bUb2Uq1AGcWvaNrFOErX7Pa/KLsR2mRasRPX6x3LBC3
        JbB8+WjwAnUBPSRk0AD2J0mCvxIPEgWyg6jP17JJTbS/7856Lg7R7cFjT7Sa6i4l
        1gAwv8tw/gETLCY/Pm8uj8Inqb7v5p9oKmRQkRkcUsuw1+myhDkkv8mMa4oebYkQ
        ==
X-ME-Sender: <xms:ZGU9X31bq_vhMfn59eJG3tOW19x5T90_ddcZNVw6HFAw_cki2AtBAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dvhffghfetueeggfdtgeduvedugeekgeeuvddvhfdugeduhfetkeevtdeitdegueenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ZWU9X2FeWiEMmfg0sVNfGtzYPBSuxHREWq8E2YXv5qVbw_SNabQ7qQ>
    <xmx:ZWU9X36tEXuVderarf-ZAuEpujqG6pGn5uomfaLcFfqt--VlOq_-sw>
    <xmx:ZWU9X81-ccGRXvyrkdWUHS1wi2bbmW75_vfvop18iIRpaevry6ekdA>
    <xmx:ZWU9X2gE60bU2tCWSGpJwX2JJ3GcX-TR5MJ9egAY9q5bST7K6NLMjQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6FBC30600B4;
        Wed, 19 Aug 2020 13:46:12 -0400 (EDT)
Date:   Wed, 19 Aug 2020 10:46:09 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, Graham Cobb <g.btrfs@cobb.uk.net>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: detect nocow for swap after snapshot delete
Message-ID: <20200819174609.GA1218106@devvm842.ftw2.facebook.com>
References: <20200818180005.933061-1-boris@bur.io>
 <20200819112941.GK2026@twin.jikos.cz>
 <563ca3a3-d07c-cf1f-cb0f-f41f50f8d516@cobb.uk.net>
 <20200819142548.GN2026@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819142548.GN2026@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 04:25:48PM +0200, David Sterba wrote:
> On Wed, Aug 19, 2020 at 12:59:28PM +0100, Graham Cobb wrote:
> > On 19/08/2020 12:29, David Sterba wrote:
> > > How often could the snapshot deletion and swapfile activation happen at
> > > the same time? Snapshotting subvolume with the swapfile requires
> > > deactivation, snapshot/send/whatever and then activation. This sounds
> > > like a realistic usecase.
> > 
> > It is very likely when the swapfile is one that is only used
> > occasionally (for example, when running a particular program which needs
> > a massive amount of virtual memory, or having to stop using a different
> > swapfile because a disk looks like it is starting to fail).
> > 
> > If the swapfile is not normally used, it is not unlikely it got
> > snapshotted (as part of a larger operation, presumably) while
> > deactivated. When the user tries to use it, they realise it isn't
> > working because it is snapshotted, so they delete the snapshot and then
> > immediately try to activate it again -- causing confusion when it still
> > fails.
> 
> That makes sense from user POV. I still don't uderstand if it's
> sufficient to commit the transaction deleting the snapshot or if it's
> necessary to wait until the subvolume is completely cleaned.
> 
> The former would require 'btrfs subvol delte -c /snapshot' while the
> latter needs the id of the subvolume and then
> 'btrfs subvol sync /path id'.

My reproduction has been:
create subvol
create swapfile in subvol
btrfs subvol snapshot subvol snapshot
btrfs subvol delete snapshot
sync/btrfs fi sync/waiting
swapon subvol/swapfile

Note that I haven't been touching the swapfile in any way after
initially creating it. Nor have I been turning swap on/off in any
coordinated way before/after the snapshot except to test after the
snapshot is deleted.

I tried both suggestions with and without the patch and saw that with
the patch, swapon reliably succeeds after 'btrfs subvol sync' and does
not reliably succeed even after 'btrfs subvol delete -c' or sync calls,
so it seems that we need the subvolume to be completely cleaned. Without
the patch, after both 'btrfs subvol delete -c' and after 'btrfs subvol
sync', the swapon fails. Thanks for the review, and testing suggestions!
