Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C785E485ABD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244495AbiAEVdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 16:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244503AbiAEVcb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 16:32:31 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC3C061212
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 13:32:01 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1n5Dsz-0007Cg-UZ; Wed, 05 Jan 2022 21:31:57 +0000
Date:   Wed, 5 Jan 2022 21:31:57 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from
 suspend
Message-ID: <20220105213157.GE14058@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Filipe Manana <fdmanana@kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home>
 <20220105183407.GD14058@savella.carfax.org.uk>
 <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 08:38:37PM +0000, Filipe Manana wrote:
> On Wed, Jan 5, 2022 at 6:34 PM Hugo Mills <hugo@carfax.org.uk> wrote:
> >
> >    Hi, Filipe,
> >
> > On Wed, Jan 05, 2022 at 06:04:38PM +0000, Filipe Manana wrote:
> > > I don't think I have a wiki account enabled, but I'll see if I get that
> > > updated soon.
> >
> >    If you can't (or don't want to), feel free to put the text you want
> > to replace it with here, and I'll update the wiki for you...
> 
> Hi Hugo,
> 
> That would be great.
> I don't have a concrete text, but as you are a native english speaker,
> a version from you would sound better :)
> 
> Perhaps just mention that as of kernel 3.17 (and maybe point to that
> commit too), the behaviour is no longer guaranteed, and we can end up
> getting a file of 0 bytes.

   I'd rather not reinforce the wrong usage with an example of it. :)
Better to document the correct usage...

> So an explicit fsync on the file is needed (just like ext4 and other
> filesystems).

   At what point in the process does the fsync need to be done?
Before/after/instead of the sync?

   Hugo.

-- 
Hugo Mills             | Geek, n.:
hugo@... carfax.org.uk | Circus sideshow performer specialising in the eating
http://carfax.org.uk/  | of live animals.
PGP: E2AB1DE4          |                                                   OED
