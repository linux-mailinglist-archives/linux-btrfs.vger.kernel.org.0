Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83777308D51
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhA2TY4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 14:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhA2TYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 14:24:03 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A38C0613D6
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jan 2021 11:23:22 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l5ZKE-00019B-3d; Fri, 29 Jan 2021 19:20:58 +0000
Date:   Fri, 29 Jan 2021 19:20:58 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: is back and forth incremental send/receive supported/stable?
Message-ID: <20210129192058.GN4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 29, 2021 at 08:09:49PM +0100, Christoph Anton Mitterer wrote:
> I regularly do the following with btrfs, which seems to work pretty
> stable since years:
> - having n+1 filesystems MASTER and COPY_n
> - creating snapshots on MASTER, e.g. one each month
> - incremental send/receive the new snapshot from MASTER to each of
>   COPY_n (which already have the previous snapshot)
> 
> 
> so for example:
> - MASTER has
>   - snapshot-2020-11/
>   - snapshot-2020-12/
>   and newly get's
>   - snapshot-2021-01/
> - each of COPY_n has only
>   - snapshot-2020-11/
>   - snapshot-2020-12(
> - with:
>   # btrfs send -p MASTER/snapshot-2020-12 MASTER/snapshot-2021-01  |  btrfs receive COPY_n/
>   I incrementally send the new snapshot from MASTER to each of COPY_n
>   using the already available previous snapshot as parent.
> 
> Works(TM)
> 
> 
> 
> Now I basically want to swap a MASTER with a COPY_n (e.g. because
> MASTER's HDD has started to age).
> 
> So the plan is e.g.:
> - COPY_1 becomes NEW_MASTER
> - MASTER becomes OLD_MASTER later known NEW_COPY_1
> 
> a) Can I then start e.g. in February to incrementally send/receive from
> NEW_MASTER back(!!) to OLD_MASTER?

   No.

   When you make an incremental send, you give it a reference
subvolume with -p. This subvol's UUID is sent in the send stream to
the remote side for receive.

   When receive gets told about a reference subvolume in this way, it
looks for the reference and snapshots it (RW) to use as the base to
apply the incremental on top of.

   The way it finds the reference subvol is to look for a subvol with
the "received_uuid" field matching. This field is set by the receiving
process that made it in the first place (as the result of an earlier
send).

   In your scenario with MASTER and COPY-1 swapped, you'd have to
match the received_uuid from the sending side (on old COPY-1) to the
actual UUID on old MASTER. The code doesn't do this, so you'd have to
patch send/receive to do this.

   Your best bet here is to do a new full send and then continue a new
incremental sequence based on that.

   There's a detailed and fairly formal description of this stuff that
I wrote a few years ago here:

https://www.spinics.net/lists/linux-btrfs/msg44089.html

   Hugo.

> Like:
> # btrfs send -p NEW_MASTER/snapshot-2021-01 NEW_MASTER/snapshot-2021-02  |  btrfs receive OLD_MASTER/
> 
> b) And the same from NEW_MSTER to all the other COPY_n?
> Like:
> # btrfs send -p NEW_MASTER/snapshot-2021-01 NEW_MASTER/snapshot-2021-02  |  btrfs receive COPY_n
> 
> 
> So in other words, does btrfs get, that the new parent (which is no
> longer on the OLD_MASTER but the previous COPY_1, now NEW_MASTER) is
> already present (and identical and usable) on the OLD_MASTER, now
> NEW_COPY_1, and also on the other COPY_n ?
> 
> 
> By the way, I'm talking about *precious* data, so I'd like to be really
> sure that this works... and whether it's intended to work and ideally
> have been tested.
> 
> 
> Thanks,
> Chris.
> 

-- 
Hugo Mills             | You shouldn't anthropomorphise computers. They
hugo@... carfax.org.uk | really don't like that.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
