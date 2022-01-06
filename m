Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9814D486B06
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiAFUXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 15:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiAFUXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 15:23:18 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63314C061245
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 12:23:18 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1n5ZI2-0000Y7-6z; Thu, 06 Jan 2022 20:23:14 +0000
Date:   Thu, 6 Jan 2022 20:23:14 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from
 suspend
Message-ID: <20220106202314.GA1698@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Chris Murphy <lists@colorremedies.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20220105183407.GD14058@savella.carfax.org.uk>
 <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
 <20220105213157.GE14058@savella.carfax.org.uk>
 <20220105213921.GF14058@savella.carfax.org.uk>
 <20220105215359.GG14058@savella.carfax.org.uk>
 <CAL3q7H538dogW0-5PR1+J7FCKNJX6vY2_7tEpazskCmL4dmxKA@mail.gmail.com>
 <20220106102056.GH14058@savella.carfax.org.uk>
 <CAL3q7H4d9t=gBXYB=OVnPDuEMdo1-jmJweJTEshvc=9AGDeaVQ@mail.gmail.com>
 <CAJCQCtTKkhQ+7=NK_KYktvuRxL+3yYMxma9WjB5eAbc5upWGaQ@mail.gmail.com>
 <CAJCQCtTyUk_TC=W+2o+Cy_W_mfX-0_sTXGBLf1S9AdQiHkDiMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTyUk_TC=W+2o+Cy_W_mfX-0_sTXGBLf1S9AdQiHkDiMA@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 06, 2022 at 01:06:40PM -0700, Chris Murphy wrote:
> On Thu, Jan 6, 2022 at 1:02 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Thu, Jan 6, 2022 at 3:28 AM Filipe Manana <fdmanana@kernel.org> wrote:
> > >
> > > On Thu, Jan 6, 2022 at 10:21 AM Hugo Mills <hugo@carfax.org.uk> wrote:
> > > >
> > > > > Yep, that's correct Hugo.
> > > > >
> > > > > Starting with 3.17, the example on the wiki needs an fsync on
> > > > > "file.tmp" after writing to it and before renaming it over "file".
> > > > > I.e. the full example should be:
> > > > >
> > > > > ****
> > > > > echo "oldcontent" > file
> > > > >
> > > > > # make sure oldcontent is on disk
> > > > > sync
> > > > >
> > > > > echo "newcontent" > file.tmp
> > > > > fsync file.tmp
> > > > > mv -f file.tmp file
> > > > >
> > > > > # *crash*
> > > > >
> > > > > Will give either
> > > > >
> > > > > file contains "newcontent"; file.tmp does not exist
> > > > > file contains "oldcontent"; file.tmp may contain "newcontent", be
> > > > > zero-length or not exists at all.
> > > > > ****
> > > >
> > > >    Since I can't find an "fsync" command line tool, I've rewritten the
> > > > example in more general terms, rather than tying it to a specific
> > > > implementation (such as a sequence of shell commands). I note that
> > > > we've got a near-duplicate entry in the FAQ, two items down ("What are
> > > > the crash guarantees of rename?"), that should probably be removed.
> > > >
> > > > Updated entry: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
> > > > Candidate for deletion: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_rename.3F
> > >
> > > There's the xfs_io command from xfsprogs that can be used to trigger
> > > an fsync like this:  xfs_io -c fsync /path/to/file
> > > But it's probably not well known for non-developers.
> > >
> > > Anyway, as it is, it looks perfect to me, thanks!
> >
> >
> > I think it's OK to use pseudo-code. Folks will figure it out. So you
> > can just write it as fsync() and even if you're not using the exact
> > correct syntax it'll be understood.
> 
> Topical xxample:
> https://lore.kernel.org/linux-xfs/6A65F394-C1BA-4339-AC9B-051885D12F65@corp.ovh.com/

   I did wonder whether to write it as C-ish code, but I felt that the
prose description was sufficient, and didn't presuppose any particular
implementation.

> Reminds me to ask Filipe if the example Hugo is writing up also needs
> an fsync() on the enclosing directory *after* the rename?

   As I understand it, as long as the data is fsynced properly before
the move, the semantics are safe and atomic (if you don't get the new
data afterwards, you get the old data, regardless of where the crash
is). Syncing the directory and waiting for that to complete gives you
the guarantee that you'll get the new data from that point on of the
system crashes afterwards.

   Hugo.

-- 
Hugo Mills             | I hate housework. You make the beds, you wash the
hugo@... carfax.org.uk | dishes, and six months later you have to start all
http://carfax.org.uk/  | over again.
PGP: E2AB1DE4          |                                           Joan Rivers
