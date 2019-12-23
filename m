Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311BF1296B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2019 14:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWN7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Dec 2019 08:59:37 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:56830 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLWN7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Dec 2019 08:59:37 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1ijOFD-0002nA-Nk; Mon, 23 Dec 2019 13:59:35 +0000
Date:   Mon, 23 Dec 2019 13:59:35 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Metadata chunks on ssd?
Message-ID: <20191223135935.GN23304@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 23, 2019 at 02:44:07PM +0100, Stéphane Lesimple wrote:
> Hello btrfs gurus,
> 
> Has this ever been considered to implement a feature so that metadata chunks
> would always be allocated on a given set of disks part of the btrfs
> filesystem?

   Yes, many times. There was even an RFC implementation, many years
ago, but it wasn't merged.

   Hugo.

> As metadata use can be intensive and some operations are known to be slow
> (such as backref walking), I'm under the (maybe wrong) impression that
> having a set of small ssd's just for the metadata would give quite a boost
> to a filesystem. Maybe even make qgroups more usable with volumes having 10
> snapshots?
> 
> This could just be a preference set on the allocator, so that a 6 disks
> raid1 FS with 4 spinning disks and 2 ssds prefer to allocate metadata on the
> ssd than on the slow drives (and falling back to spinning disks if ssds are
> full, with the possibility to rebalance later).
> 
> Would such a feature make sense?
> 

-- 
Hugo Mills             | Quantum Mechanics: the dreams stuff is made of.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
