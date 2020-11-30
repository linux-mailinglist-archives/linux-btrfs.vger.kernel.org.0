Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C052C8CBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 19:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgK3SZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 13:25:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41109 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgK3SZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:25:33 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 513E35C017D;
        Mon, 30 Nov 2020 13:24:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Nov 2020 13:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=owrCQkj6tert0ju5pjk8erqwhiATuyvFVReQWfyi
        Mcs=; b=PvVsE2C8sN/o+/cVNtY+1qXO3IkYp1x+NrHHjTGBZhwfgwTvCOPuTt2A
        cnMNOHy4+Q2nnCvQ74MgLrdiCfMLX+4XEMnCpQOKZq3tgG5lH8f8SGbKwICdd8D1
        3DHD9byrAh9Mx880WA8NlETDCPe1vloxCtEVmqoxQ39gctGOpiqiUClvM3Abed8W
        24ptoQBDp9sMDbP5j7IjC1GMZuyPmtGWM6kte/L9kpKFATqH+z/fPi4YKb3tZIVQ
        Wv3RKcyhwuN2nAQ/FBGqq0zPzotk22zleYk2LBqI0+fe4NVBZEoEvA657R0LiKIs
        Z3X+9Kx/bJT8Xo1W5HgRnb9/jovpMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=owrCQk
        j6tert0ju5pjk8erqwhiATuyvFVReQWfyiMcs=; b=p2Ito0/3/5d4XCODrzCMnQ
        F8wGAaCcswsJ4ThUmKlDbnTTaDXtApBb5dX0E0OrSgLSpjaYEBR/RqySGdQKmgN9
        O//27XAt8JBrJcKGx9Oli5i5C8id8e4j6PjtQiIlrdY3suQcJOXgBbftg9Zu3Os6
        4YetCswLXKSZAxi3EcufsVsmZgNsPqaZraSEtnmgq4MOCXzzJRke3SrZ9RPyebOj
        HUkh6mlYgYz+HaC0qHZxSzqyK503T86tErF0uYuq/GAiT3Vtpi50DsahDpydpe1k
        3y8+AJizEsZY8IUooA5kt97BksHO4+avG7AjgOx4CrrhYfSEPmJOCDAcnY2ThQSw
        ==
X-ME-Sender: <xms:2DjFX5jbErWiiKhEjyO4bZX4Sj1CqTz_b0NuVvO9jAwTxrNUQNjFhw>
    <xme:2DjFX-AraJIbKFbTWStldZchvvhFYoeOumdS2ri3Lx8C4_Z_uftjUyI190ebnz4jb
    kyK5qObY86kYZkVSS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeitddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfgesth
    dtredttdervdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpedvhffghfetueeggfdtgeduvedugeekgeeuvd
    dvhfdugeduhfetkeevtdeitdegueenucfkphepudeifedruddugedrudefvddrfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:2DjFX5FGppcIomYOCUT22kd22xyYeeYYI_HVOjACp5x3FpiA0C9xjw>
    <xmx:2DjFX-S9wQU8ox8MfouxjUz4xSN9DYKbQKXA35yd-A1j_ZcBWd-qww>
    <xmx:2DjFX2x2jIYN7EGDQEGUU_dS2xEOYwYXO9tIVnpaX9Nfs0CNLxzm0w>
    <xmx:2TjFX8ZEhTwJLnrblaIB9sSpoiPDPWaF2pW3jU-fwp0lR6Z00yYlrA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 789EB3064AA6;
        Mon, 30 Nov 2020 13:24:24 -0500 (EST)
Date:   Mon, 30 Nov 2020 10:24:16 -0800
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 00/10] btrfs: free space tree mounting fixes
Message-ID: <20201130182416.GA2017125@devbig008.ftw2.facebook.com>
References: <cover.1605736355.git.boris@bur.io>
 <20201120213222.GA8669@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120213222.GA8669@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 20, 2020 at 10:32:22PM +0100, David Sterba wrote:
> On Wed, Nov 18, 2020 at 03:06:15PM -0800, Boris Burkov wrote:
> > This patch set cleans up issues surrounding enabling and disabling various
> > free space cache features and their reporting in /proc/mounts.  Because the
> > improvements became somewhat complex, the series starts by lifting rw mount
> > logic into a single place.
> > 
> > The first patch is a setup patch that unifies very similar logic between a
> > normal rw mount and a ro->rw remount. This is a useful setup step for adding
> > more functionality to ro->rw remounts.
> > 
> > The second patch fixes the omission of orphan inode cleanup on a few trees
> > during ro->rw remount.
> > 
> > The third patch stops marking block groups with need_free_space when the
> > free space tree is not yet enabled.
> > 
> > The fourth patch adds enabling the free space tree to ro->rw remount.
> > 
> > The fifth patch adds a method for clearing oneshot mount options after mount.
> > 
> > The sixth patch adds support for clearing the free space tree on ro->rw remount.
> > 
> > The seventh patch sets up for more accurate /proc/mounts by ensuring that
> > cache_generation > 0 iff space_cache is enabled.
> > 
> > The eigth patch is the more accurate /proc/mounts logic.
> > 
> > The ninth patch is a convenience kernel message that complains when we skip
> > changing the free space tree on remount.
> > 
> > The tenth patch removes the space cache v1 free space item and free space
> > inodes when space cache v1 is disabled (nospace_cache or space_cache=v2).
> > 
> > The eleventh patch stops re-creating the free space objects when we are not
> > using space_cache=v1
> > 
> > The twelfth patch fixes a lockdep failure in creating the free space tree.
> 
> Is this fixing a problem caused by some patches in this series? Because
> if yes, the fix should be folded there. A standalone patch makese sense
> in case we can't fold it there (eg. after merging to Linus' tree),
> otherwise the merged patchsets should be made of complete patches,
> without fixes-to-fixes. Even if the patchset is in misc-next, fixups are
> still doable.

The new 'needs_free_space' patch (#3) fixes the bug in this series that
you caught, so if I understand correctly, I should appropriately fold
that one into one of the existing patches.

The lockdep issue exists in misc-next as far as I can tell, so I think a
standalone patch makes sense.

Let me know if I misunderstood you on either of those.

Thanks,
Boris
