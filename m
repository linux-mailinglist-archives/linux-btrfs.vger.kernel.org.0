Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5AA92D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 22:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfIDUJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 16:09:45 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:35365 "EHLO
        6.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIDUJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 16:09:45 -0400
X-Greylist: delayed 26704 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2019 16:09:44 EDT
Received: from player755.ha.ovh.net (unknown [10.108.57.141])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 934A3189B66
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2019 16:04:49 +0200 (CEST)
Received: from grubelek.pl (31-178-94-81.dynamic.chello.pl [31.178.94.81])
        (Authenticated sender: szarpaj@grubelek.pl)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id E0242987EF23;
        Wed,  4 Sep 2019 14:04:45 +0000 (UTC)
Received: by teh mailsystemz
        id 7B36D171D7E5; Wed,  4 Sep 2019 16:04:44 +0200 (CEST)
Date:   Wed, 4 Sep 2019 16:04:44 +0200
From:   Piotr Szymaniak <szarpaj@grubelek.pl>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     =?utf-8?B?U3fDom1p?= Petaramesh <swami@petaramesh.org>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Michel Bouissou <michel@bouissou.net>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
Message-ID: <20190904140444.GH31890@pontus.sran>
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Ovh-Tracer-Id: 14159598704614577792
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 12:03:10PM +0300, Andrei Borzenkov wrote:
> On Wed, Sep 4, 2019 at 9:16 AM Swâmi Petaramesh <swami@petaramesh.org> wrote:
> >
> > Hi list,
> >
> > Is there an advised way to completely “clone” a complete BTRFS
> > filesystem, I mean to get an exact copy of a BTRFS filesystem including
> > subvolumes (even readonly snapshots) and complete file attributes
> > including extended attributes, ACLs and so, to another storage pool,
> > possibly defined with a different RAID geometry or compression ?
> >
> 
> As long as you do not use top level subvolume directly (all data is
> located in subolumes), send/receive should work.
> 
> > The question boils down to getting an exact backup replica of a given
> > BTRFS filesystem that could be restored to something logically
> > absolutely identical.
> >
> > The usual backup tools have no clue about share extents, snapshots and
> > the like, and using btrfs send/receive for individual subvols is a real
> > pain in a BTRFS filesystem that may contain hundreds of snapshots of
> > different BTRFS subvols plus deduplication etc.
> >
> 
> Shared extents could be challenging. You can provide this information
> to "btrfs send", but for one, there is no direct visibility into which
> subvolumes share extents with given subvolume, so no way to build
> corresponding list for "btrfs send". I do not even know if this
> information can be obtained without exhaustive search over all
> extents. Second, btrfs send/receive only allows sharing of full
> extents which means there is no guarantee of identical structure on
> receiving side.

So right now the only answer is: use good old dd?


Piotr Szymaniak.
-- 
Jedyne  napisy,  które rozumie każdy  Amerykanin,  to  "Wyprzedaż", "Za
darmo" i "Seks".  Kiedyś  widziałem w Arizonie tablicę  "Seks za darmo.
Ograniczenie prędkości do 60 km/h".
  -- Nelson DeMille, "The Lion's Game"
