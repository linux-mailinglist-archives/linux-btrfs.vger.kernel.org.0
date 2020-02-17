Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1D161403
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgBQNzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 08:55:44 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:42206 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQNzo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 08:55:44 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1j3gsA-00068j-4K; Mon, 17 Feb 2020 13:55:42 +0000
Date:   Mon, 17 Feb 2020 13:55:42 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Menion <menion@gmail.com>
Cc:     =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs: convert metadata from raid5 to raid1
Message-ID: <20200217135542.GD1235@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Menion <menion@gmail.com>,
        =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
 <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
 <CAJVZm6fj9V7G2zLjNpR5MRcZOke0NxydWm1aMY44n2L18fP04w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJVZm6fj9V7G2zLjNpR5MRcZOke0NxydWm1aMY44n2L18fP04w@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 17, 2020 at 02:51:12PM +0100, Menion wrote:
> Also, since the number of HDD is 5, how this "raid1" scheme is deployed?

   Two copies of any one piece of data, each copy on a separate
device.

   Hugo.

> Il giorno lun 17 feb 2020 alle ore 14:50 Menion <menion@gmail.com> ha scritto:
> >
> > Is it ok to run it on a mounted filesystem with concurrent read and
> > write operations?
> >
> > Il giorno lun 17 feb 2020 alle ore 14:49 Swâmi Petaramesh
> > <swami@petaramesh.org> ha scritto:
> > >
> > > Hi,
> > >
> > > On 2020-02-17 14:43, Menion wrote:
> > > > What is the correct procedure to convert metadata from raid5 to proper
> > > > raid scheme (raid1 or)?
> > >
> > > # btrfs balance start -mconvert=raid1 /array/mount/point should do the trick
> > >
> > > ॐ
> > >

-- 
Hugo Mills             | Turning, pages turning in the widening bath,
hugo@... carfax.org.uk | The spine cannot bear the humidity.
http://carfax.org.uk/  | Books fall apart; the binding cannot hold.
PGP: E2AB1DE4          | Page 129 is loosed upon the world.               Zarf
