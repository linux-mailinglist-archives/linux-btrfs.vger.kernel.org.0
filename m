Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB31E1864
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 02:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgEZANP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 20:13:15 -0400
Received: from magic.merlins.org ([209.81.13.136]:39802 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgEZANO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 20:13:14 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jdNDS-0004Se-MO by authid <merlin>; Mon, 25 May 2020 17:13:10 -0700
Date:   Mon, 25 May 2020 17:13:10 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
Message-ID: <20200526001310.GG19850@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQaN+4TY4_Y-CwPBQTtrJ52E-cc-A1+Nt2jOsyTrkX9fw@mail.gmail.com>
 <CAJCQCtQgeYE3XPFACru08qhSOTxv5N9icj4xV27rG81UeaVa=g@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 25, 2020 at 04:47:31PM -0600, Chris Murphy wrote:
> Maybe. The story arc on Btrfs is that check --repair only fixes the
> things it knows how to fix. It's gotten better but still has the scary

that's always been true indeed :)

> warning, and lately has a 10 second delay to really make sure the user
> meant to use it. And regardless of mode, it's slow and just can't
> scale. Neither does "wipe and restore from backup". So the problems of
> inconsistency need to be understood to avoid the problem in the first
> place.

that's ideal, but honestly it's a multi prong approach. I'm stil hoping
that check --repair can improve.
 
> What about finding inode 14058737 and deleting it? In all of the
> listed subvolumes? And then unmount and check again?
 
it's in all the subvolumes, including the btrfs send ones. 
So sure, I can delete my btrfs send snapshots and have to start over,
but really btrfs check should fix this better than rm, even if it makes
the file not what it was. I can always replace it with a good copy
 
On Mon, May 25, 2020 at 04:51:51PM -0600, Chris Murphy wrote:
> Before deleting it, can you check if chattr +C is set? Or what kind of
> file is this? Because there's an old loophole in older kernels where

saruman:~# lsattr /mnt/mnt/root/usr/share/locale/en_GB/LC_MESSAGES/gstreamer-1.0.mo
-------------------- /mnt/mnt/root/usr/share/locale/en_GB/LC_MESSAGES/gstreamer-1.0.mo

> You could try just making a 'cp --reflink=never' copy of the file. And
> delete the original (and all of its copies in all subvolumes). Now
> 'btrfs check'.

I can restore the file from backup without issues, it's more that with
btrfs send, I'm not allowed to delete the inode until it cycles out, and
I can't cycle it out because btrfs send dies when it sees the
inconsistent state.

I mean, yes, I can do this and delete all the snapshots, I was just
hoping to do slighty better as this is close to wiping the filesystem
and starting over (actually it's mostly the same to be honest)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
