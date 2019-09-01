Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14783A4BCC
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfIAUft (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Sep 2019 16:35:49 -0400
Received: from augustus.math.duke.edu ([152.3.25.8]:43384 "EHLO math.duke.edu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729043AbfIAUfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Sep 2019 16:35:45 -0400
X-Virus-Scanned: amavisd-new at math.duke.edu
Received: from [192.168.101.7] (cpe-76-182-105-20.nc.res.rr.com [76.182.105.20])
        (authenticated bits=0)
        by math.duke.edu (8.14.4/8.14.4) with ESMTP id x81KZeMi019282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 1 Sep 2019 16:35:40 -0400
Message-ID: <c608faa6a5dc9ec81b894d18c7761dac7a823ab7.camel@math.duke.edu>
Subject: Re: block corruption
From:   Rann Bar-On <rann@math.duke.edu>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Sun, 01 Sep 2019 16:35:40 -0400
In-Reply-To: <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
         <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
         <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
         <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
         <b3ec20d5-e9b1-4688-297b-b102b5a8fa10@gmx.com>
         <b855969a3108e7ef9be2e758eb8bd2f3539e5af0.camel@math.duke.edu>
         <CAJCQCtR9feFgGtOZ0Wik2y1oQ69V5z5Q-voFtYPLtnbnbWo7TA@mail.gmail.com>
Organization: Duke University Mathematics Department
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


-- 
Rann Bar-On
Senior Lecturer
Dept of Mathematics
Duke University

Pronouns: he/him/his

On Sun, 2019-09-01 at 14:09 -0600, Chris Murphy wrote:
> On Sun, Sep 1, 2019 at 11:39 AM Rann Bar-On <rann@math.duke.edu>
> wrote:
> > On Sun, 2019-09-01 at 07:48 +0800, Qu Wenruo wrote:
> > > On 2019/9/1 上午7:39, Rann Bar-On wrote:
> > > > On Sat, 2019-08-31 at 17:04 -0600, Chris Murphy wrote:
> > > > > On Sat, Aug 31, 2019 at 2:26 PM Rann Bar-On <
> > > > > rann@math.duke.edu>
> > > > > wrote:
> > > > > > I just downgraded to kernel 4.19, and the supposed
> > > > > > corruption
> > > > > > vanished.
> > > > > > This may be related to
> > > > > > 
> > > > > > https://www.spinics.net/lists/linux-btrfs/msg91046.html
> > > > > > 
> > > > > > If I can provide information that would help fix this
> > > > > > issue,
> > > > > > I'd be
> > > > > > glad to, but I cannot upgrade back to kernel 5.2, as I
> > > > > > can't
> > > > > > risk
> > > > > > this
> > > > > > system.
> > > > > 
> > > > > 5.2 has more strict checks for corruption, exposing the rare
> > > > > case
> > > > > where metadata in a leaf is corrupt but the checksum was
> > > > > properly
> > > > > computed.
> > > 
> > > Exactly.
> > > 
> > > Although for your case, it's some older kernel doing something
> > > bad.
> > > 
> > > It's also reported once for the same problem, some older kernel
> > > doesn't
> > > set the mode member properly.
> > > > > > > Btrfs v3.17
> > > > > 
> > > > > This is old. I suggest finding a newer version of btrfs-
> > > > > progs,
> > > > > ideally
> > > > > latest stable version is 5.2.1. Definitely don't use --repair
> > > > > with
> > > > > this version. It's safe to use check --readonly (which is the
> > > > > default)
> > > > > with this version but probably not that helpful to devs.
> > > > > 
> > > > 
> > > > Not really sure why that said 3.17:
> > > > 
> > > > $ btrfs --version
> > > > btrfs-progs v5.2.1
> > > > 
> > > > Anyway, running btrfs --repair on the file system didn't do
> > > > anything to
> > > > fix the above errors.
> > > 
> > > That's what we need to enhance next.
> > > 
> > > > I removed at least one of the corrupt files (the only one that
> > > > was
> > > > mode
> > > > 0) using kernel 4.19.
> > > > 
> > > > Happy to help further if I can. What would you suggest as far
> > > > as
> > > > fixing
> > > > this or reporting it usefully? If you believe 5.2 isn't causing
> > > > the
> > > > corruption, but rather, just exposing it, I'm more than happy
> > > > to
> > > > experiment with it.
> > > 
> > > Deleting the offending inodes would be enough to fix the alert.
> > > 
> > 
> > I deleted the file using the older kernel. I rebooted into the new
> > kernel, and things seem good for now.
> > 
> > Note: The newer one wouldn't let me access the file to delete it,
> > nor
> > did any btrfs repair tool do anything at all. This is a big problem
> > IMO!
> 
> The current behavior is an improvement over propagating corruption
> and
> never detecting it because the leaf is assumed to be correct only
> because the checksum matches. The next step is figuring out ways to
> work around such rare detected corruptions, hopefully automatically
> and while online.
> 
> I don't consider it user responsibility to have to do this, but I'm
> vaguely curious if it's possible to delete the offending file in a
> snapshot, then delete the original subvolume. i.e.
> 
> 1.
> snapshot the subvolume containing the file (default rw snapshot)
> 2.
> delete the bad file(s) in the snapshot
> 3.
> delete the original subvolume (snapshot's parent)
> 
> I'm curious if either 2 or 3 are permitted.
> 
> 

Wish I could help, but I already deleted the file. If there's something
I can do to move this forward, I'd be glad to.

