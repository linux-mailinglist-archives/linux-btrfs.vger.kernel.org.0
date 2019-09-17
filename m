Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7AB46A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 06:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfIQEzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 00:55:50 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35356 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727234AbfIQEzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 00:55:50 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id ECBAE42C9A1; Tue, 17 Sep 2019 00:55:48 -0400 (EDT)
Date:   Tue, 17 Sep 2019 00:55:48 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     General Zed <general-zed@zedlx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190917045548.GF24379@hungrycats.org>
References: <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
 <20190914005655.GH22121@hungrycats.org>
 <20190913215038.Horde.gsxNyK9aSRLm6Qsl5sUNhf0@server53.web-hosting.com>
 <20190914044219.GL22121@hungrycats.org>
 <20190915135407.Horde.qqs07Bais-BPrjIVxyrrIfo@server53.web-hosting.com>
 <20190916225126.GB24379@hungrycats.org>
 <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
 <CAJCQCtRW8ObeQ5nL_Q9t-7rXDtOk5TQLcZnhH6bGRMA-puUVNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtRW8ObeQ5nL_Q9t-7rXDtOk5TQLcZnhH6bGRMA-puUVNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 16, 2019 at 07:44:31PM -0600, Chris Murphy wrote:
> Reflinks are like a file based snapshot, they're a file with its own
> inode and other metadata you expect for a file, but points to the same
> extents as another file. Off hand I'm not sure other than age if
> there's any difference between the structure of the original file and
> a reflink of that file. Find out. Make a reflink, dump tree. Delete
> the original file. Dump tree.

Ehhhh...not really.

The clone-file ioctl is a wrapper around clone-file-range that fills
in 0 as the offset and the size of the file as the length when creating
reflinks.  clone-file-range copies all the extent reference items from
the src range to the dst range, replacing any extent reference items that
were present before.  It's O(n) in the number of source range extent refs,
and it doesn't have snapshot-style atomicity.

The offset for src and dst can both be non-zero, and src and dst inode
can be the same.  Src and dst cannot overlap, but they can be logically
adjacent, creating a logical-neighbor loop for physical extents.
