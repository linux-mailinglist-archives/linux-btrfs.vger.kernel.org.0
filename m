Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD02B477066
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhLPLi6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 06:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLPLi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 06:38:58 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63A6C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 03:38:57 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1mxp60-0007mJ-PN; Thu, 16 Dec 2021 11:38:48 +0000
Date:   Thu, 16 Dec 2021 11:38:48 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
Subject: Re: receive failing for incremental streams
Message-ID: <20211216113848.GA21083@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
 <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
 <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
 <ea6260d5-c383-9079-8a53-2051972b11d3@cobb.uk.net>
 <70553d13e265a2c7bced888f1a3d3b3e65539ce1.camel@ericlevy.name>
 <e479561d-98be-5da2-4853-e697eb9690b3@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e479561d-98be-5da2-4853-e697eb9690b3@cobb.uk.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 10:24:09AM +0000, Graham Cobb wrote:
> On 16/12/2021 01:13, Eric Levy wrote:
> >> Later you snapshot /data again to create /data-2 on the source
> >> system.
> >> You btrfs-send /data-2 to the other system again and it creates a new
> >> read-only subvolume - you tell btrfs-receive what to call it and
> >> where
> >> to put it, let's say you call it /copy-data-2 - using the data in the
> >> stream and reusing some extents from the existing /copy-data-1.
> >> /copy-data-2 is now a (read-only) copy of /data-2 from the source
> >> system.
> >>
> >> How you use that copy is up to you. If you are just taking backups
> >> you
> >> probably do nothing with it unless you have a problem (it will form
> >> part
> >> of the source for data for any future /copy-data-3). If you want to
> >> use
> >> it to initialize a read-write subvolume on the destination system you
> >> can take a read-write snapshot of /copy-data-2 to create a new
> >> subvolume
> >> (say /my-new-data) on the destination system.
> > 
> > Such is close to what I have always understood about receive, but the
> > confusion is that the second receive command makes no reference to the
> > subvolume created by the first command. How do I ultimately create a
> > restore target that combines the original full capture with the
> > incremental differences?
> 
> It's just magic. Seriously, as long as you have already restored the
> parent (and any clone sources, if you have specified those) to the same
> filesystem, btrfs will find them and clone the necessary files into the
> new subvolume.

   This is what happens:

Sending machine                        Receiving machine

$ send A
    Send all the data of A
    plus its UUID (uA)

                                       $ receive
				          Make a new subvol, A'
					  Write all the data to it
					  Set "received_uuid" on A' to uA
					  Make A' read-only

$ send B -p A
    Send the differences between A
    and B, plus their UUIDs, uA and uB

                                      $ receive
				         Find the subvol with
					 "received_uuid" == uA (this is A')
					 Snapshot it to B'
					 Modify B' using the differences
					 Set "received_uuid" of B' to uB
					 Make B' read-only


> > When I ask how I use it, I mean what commands do I enter into the
> > system.
> 
> Assume subvolume called /data.
> 
> On the sending side...
> 
> btrfs subv snapshot -r /data /data-1
> btrfs send /data-1 -f data-1.send
> 
> Later, to generate the incremental stream from /data-1...
> 
> btrfs subv snapshot -r /data /data-2
> btrfs send -p /data-1 /data-2 -f data-2.send
> 
> When you want to restore...
> 
> btrfs receive -f data-1.send /recv-data-1
> btrfs receive -f data-2.send /recv-data-2
> 
> If you want read-write access to the data you need to create a new
> subvolume...
> 
> btrfs subv snapshot /recv-data-2 /new-data
> 
> [I haven't tested these so sorry for any mistakes - hopefully you get
> the idea]
> 
> > 
> > Note in my case I archive the streams into regular (compressed) filesm
> > for later recovery.
> 
> I considered doing that but I don't recommend it. The biggest issue is
> that you have to keep all the incrementals since the last full backup,
> as all the steps must complete in order to restore. This means that if
> something has gone wrong with the archive (even a single bit corruption,
> or an unexpected truncation) all the incremental streams after that
> point are useless. btrfs receive doesn't have a "try hard" mode - it
> will just fail unless all the sources it needs, and the stream it is
> processing, are perfect. And you don't know, unless you do regular test
> restorations.
> 
> In the end I decided I would keep the archive subvolumes themselves, not
> the streams. Even in the worst case, this takes very little more space
> (assuming you have turned on compression) - after all the cloned data is
> still cloned. And even if something has been corrupted you can still get
> at undamaged files in the various subvolumes. And if you make sure that
> each send stream is only using the directly previous snapshot as its
> clone source, you can remove any older snapshots that you like without
> making later subvolumes useless.
> 
> Once I decided that, I ended up using btrbk - which makes a good job of
> managing the backup and archive subvolumes, on both the source system
> and the destination system. Of course, many other tools are available.
> 

-- 
Hugo Mills             | Computer Science is not about computers, any more
hugo@... carfax.org.uk | than astronomy is about telescopes.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                       Esdger Dijkstra
