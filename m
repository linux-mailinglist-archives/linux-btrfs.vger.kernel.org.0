Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67F9A92FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfIDUUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 16:20:20 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:59248 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfIDUUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 16:20:16 -0400
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1i5blE-0003c3-PN; Wed, 04 Sep 2019 21:20:12 +0100
Date:   Wed, 4 Sep 2019 21:20:12 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Piotr Szymaniak <szarpaj@grubelek.pl>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Michel Bouissou <michel@bouissou.net>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
Message-ID: <20190904202012.GF2488@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Piotr Szymaniak <szarpaj@grubelek.pl>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Michel Bouissou <michel@bouissou.net>
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
 <20190904140444.GH31890@pontus.sran>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904140444.GH31890@pontus.sran>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 04:04:44PM +0200, Piotr Szymaniak wrote:
> On Wed, Sep 04, 2019 at 12:03:10PM +0300, Andrei Borzenkov wrote:
> > On Wed, Sep 4, 2019 at 9:16 AM Swâmi Petaramesh <swami@petaramesh.org> wrote:
> > >
> > > Hi list,
> > >
> > > Is there an advised way to completely “clone” a complete BTRFS
> > > filesystem, I mean to get an exact copy of a BTRFS filesystem including
> > > subvolumes (even readonly snapshots) and complete file attributes
> > > including extended attributes, ACLs and so, to another storage pool,
> > > possibly defined with a different RAID geometry or compression ?
> > >
> > 
> > As long as you do not use top level subvolume directly (all data is
> > located in subolumes), send/receive should work.
> > 
> > > The question boils down to getting an exact backup replica of a given
> > > BTRFS filesystem that could be restored to something logically
> > > absolutely identical.
> > >
> > > The usual backup tools have no clue about share extents, snapshots and
> > > the like, and using btrfs send/receive for individual subvols is a real
> > > pain in a BTRFS filesystem that may contain hundreds of snapshots of
> > > different BTRFS subvols plus deduplication etc.
> > >
> > 
> > Shared extents could be challenging. You can provide this information
> > to "btrfs send", but for one, there is no direct visibility into which
> > subvolumes share extents with given subvolume, so no way to build
> > corresponding list for "btrfs send". I do not even know if this
> > information can be obtained without exhaustive search over all
> > extents. Second, btrfs send/receive only allows sharing of full
> > extents which means there is no guarantee of identical structure on
> > receiving side.
> 
> So right now the only answer is: use good old dd?

   If you want an exact copy, including all of the exact UUIDs, yes.

   Be aware of the problems of making block-level copies of btrfs
filesystems, though:
https://btrfs.wiki.kernel.org/index.php/Gotchas#Block-level_copies_of_devices

   Hugo.

-- 
Hugo Mills             | I have a step-ladder. My real ladder left when I was
hugo@... carfax.org.uk | a child.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
