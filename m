Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA1161463
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 15:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgBQORK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 09:17:10 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:42224 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgBQORK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 09:17:10 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1j3hCu-0006Ef-U6; Mon, 17 Feb 2020 14:17:08 +0000
Date:   Mon, 17 Feb 2020 14:17:08 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Menion <menion@gmail.com>
Cc:     =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs: convert metadata from raid5 to raid1
Message-ID: <20200217141708.GE1235@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Menion <menion@gmail.com>,
        =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
 <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
 <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org>
 <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 17, 2020 at 03:12:35PM +0100, Menion wrote:
> ok thanks
> I have launched it (in a tmux session), after 5 minutes the command
> did not return yet, but dmesg and  btrfs balance status
> /array/mount/point report it in progress (0%).
> Is it normal?

   Yes, it's got to rewrite all of your metadata. This can take a
while (especially if you have lots of snapshots or reflinks -- such as
from running a deduper). You should be able to see progress happening
fairly regularly in dmesg. This is typically one chunk every minute or
so, although some chunks can take much *much* longer.

   Hugo.

> Il giorno lun 17 feb 2020 alle ore 14:55 Swâmi Petaramesh
> <swami@petaramesh.org> ha scritto:
> >
> > On 2020-02-17 14:50, Menion wrote:
> > > Is it ok to run it on a mounted filesystem with concurrent read and
> > > write operations?
> >
> > Yes. Please check man btrfs-balance.
> >
> > All such BTRFS operations are to be run on live, mounted filesystems.
> >
> > Performance will suffer and it might be long though.
> >
> > > Also, since the number of HDD is 5, how this "raid1" scheme is deployed?
> >
> > BTRFS will manage storing 2 copies of every metadata block on 2
> > different disks, and will choose how by itself.
> >
> > ॐ
> >

-- 
Hugo Mills             | You've read the project plan. Forget that. We're
hugo@... carfax.org.uk | going to Do Stuff and Have Fun doing it.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                           Jeremy Frey
