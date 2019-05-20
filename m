Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D684723FDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfETSED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 14:04:03 -0400
Received: from hr2.samba.org ([144.76.82.148]:24362 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfETSED (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 14:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-ID:Cc:To:From:Date;
        bh=/+fAkpfIAuPfdoPWlu9IQvtkJ+y8CPWAVo4eXdGbj0g=; b=Z1UjkERzCUzdPmOBfLDD7IXcHh
        qTqL1dG9CNNPwA8bImn6yZgALYnoS+Aev1+rHth8EQFmNrlNZO3oIgdDLP+pyHEpCs+IPPBlTNRML
        A0w9KaWQuIyNZWn82xj83gSF8LT+XdPED04NMLUGFNvy34F2JcA5vvmGnT8x1+pDTzEY=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1hSmdl-0002dC-3m; Mon, 20 May 2019 18:04:01 +0000
Date:   Mon, 20 May 2019 11:03:58 -0700
From:   Jeremy Allison <jra@samba.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Rowland penny <rpenny@samba.org>,
        sambalist <samba@lists.samba.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [Samba] Fw: Btrfs Samba and Quotas
Message-ID: <20190520180358.GB257371@jra4>
Reply-To: Jeremy Allison <jra@samba.org>
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen>
 <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
 <bd91e229-90cc-f30e-1709-d8c55818af1a@samba.org>
 <em24499f72-5f4d-4fc2-8998-b81b877d8d3f@ryzen>
 <5bbcabdc-ac46-7481-64a8-b515745d72b4@samba.org>
 <em1a6d365f-4482-4553-81d9-dfa58a31f5d4@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em1a6d365f-4482-4553-81d9-dfa58a31f5d4@ryzen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 20, 2019 at 05:54:13PM +0000, Hendrik Friedel via samba wrote:
> Hello,
> 
> > Is btrfs becoming more common ?
> In my impression: Yes. Also, this problem seems to affect also zfs and thus
> all (?) file systems that support checksums and scrubbing in linux;
> consequently all filesystems that are the choice of users who need this for
> ensuring data consistency.
> > You posted this:
> > 
> > I am using Openmediavault (debian based NAS distribution), which is not actively supporting btrfs
> > 
> > It is this that I was referring to.
> Ah, yes.
> OMV intended to move to btrfs as the only choice with the next version. In
> order to pave the way, I intended to be an early adopter. The problem I
> report here, that there is good reason to.
> 
> > > > it just a pain in the a.. Never use it together with quotas or CTDB it
> > > > will crash after short time. I only take xfs and have no problem at all.
> > > > I don't know wy, but it's not good idea to user brtfs with samba.
> > > 
> > > Well, as long as this is not being reported and being improved, it will remain that way...
> > > 
> > Possibly, but it works great with ext4
> Glad to hear that.
> > I suggest you sit down with a copy of 'man smb.conf' and remove all the default
> My intent is not to solve *my* problem, but to make developers aware of this
> issue and help getting this issue fixed.
> 
> I feel a bit helpless though, as I perceive a lack of interest...
> I mean... This Bug is now celebrating its 5th aniversary.
> https://bugzilla.samba.org/show_bug.cgi?id=10541

That's because the concept of a btrfs "subvolume" completely
breaks the POSIX idioms that smbd depends on.

We absolutely identify a file by a dev/ino pair, and
expect the dev to remain consistent under an exported
share path.

If you sub-mount this also breaks smbd dfree/quotas, and
that's a lot more common.

This identity is baked into Samba in order to implement
leases/oplocks and it's not going to change.

If you want to do this (subvolumes/submounts) I think
you should get familiar with the:

dfree command:

set quota command:

set quota command:

scripts in smb.conf.
