Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3C1BA2E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgD0Lok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 07:44:40 -0400
Received: from len.romanrm.net ([91.121.86.59]:47338 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgD0Lok (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 07:44:40 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 70A3340229;
        Mon, 27 Apr 2020 11:44:36 +0000 (UTC)
Date:   Mon, 27 Apr 2020 16:44:36 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc Lehmann <schmorp@schmorp.de>
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
Subject: Re: questoin about Data=single on multi-device fs
Message-ID: <20200427164436.05c5c257@natsu>
In-Reply-To: <20200427112946.GA3648@schmorp.de>
References: <20200426100405.GA5270@schmorp.de>
        <20200426102547.GM32577@savella.carfax.org.uk>
        <20200427112946.GA3648@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 27 Apr 2020 13:29:47 +0200
Marc Lehmann <schmorp@schmorp.de> wrote:

> On Sun, Apr 26, 2020 at 11:25:47AM +0100, Hugo Mills <hugo@carfax.org.uk> wrote:
> > > The reason I chose data=single was specifically to help in case of device
> > > loss at the cost of performance.
> > 
> >    Make backups. That's the only way to be sure about this sort of thing.
> 
> I think you are unthinkingly repeating a wrong (and slightly dangerous)
> claim - backups cannot actually do that sort of thing: a raid will protect
> against (some amount of) disk failures with no data loss, but backups
> cannot: Backups can protect against complete data loss, but cannot
> completely protect against data loss.

With backups it is at least clear enough to anyone that only the data that has
been backed up will be recoverable from the backup;

On the other hand you follow a much more dangerous theory, that a low-level
JBOD-style merging of disks can be of any significant "help" in case of a
device failure. That's often heard applied to LVM LVs spanned across multiple
devices, or MD Linear, or in this case Btrfs "single". In all of those cases I
have to wonder how getting to keep a few chunks of what some time ago was a
filesystem, or in your case, *random pieces of random files* being luckily
intact, will be of any help and alleviate the need to restore from backups.

If you really want a JBOD-style storage merged into a single pool, with device
failures having impact limited only to that device, better look into FUSE
file-level overlay filesystems, such as MergerFS and MHDDFS. At least with
those you are guaranteed to have whole files intact on still running devices.
Exactly what Btrfs doesn't guarantee you now (seemingly even more so), but most
importantly never did, not even on any prior kernel version.

-- 
With respect,
Roman
