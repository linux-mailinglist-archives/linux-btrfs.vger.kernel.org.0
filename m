Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28D2CA567
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 15:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgLAOR3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 09:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgLAOR3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Dec 2020 09:17:29 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C2C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Dec 2020 06:16:49 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kk6Sv-0006Fw-0M; Tue, 01 Dec 2020 14:17:13 +0000
Date:   Tue, 1 Dec 2020 14:17:12 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     James Courtier-Dutton <james.dutton@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: problem with btrfs snapshot delete
Message-ID: <20201201141712.GI1908@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        James Courtier-Dutton <james.dutton@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAAMvbhFCX5B124V26HzKziJpzMjoYzvhvjTgxeMiauoydGhycg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhFCX5B124V26HzKziJpzMjoYzvhvjTgxeMiauoydGhycg@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 01, 2020 at 02:00:21PM +0000, James Courtier-Dutton wrote:
> I do:
> btrfs subvolume list /foldername
> 
> This is a mounted external disk in folder /foldername
> 
> ID 257 gen 3455989 top level 5 path @
> ID 258 gen 3455995 top level 5 path @home
> ID 15214 gen 2317920 top level 5 path @apt-snapshot-2018-08-20_20:37:56
> ID 15296 gen 2317920 top level 5 path @apt-snapshot-2018-08-22_11:18:45
> ID 15297 gen 2317920 top level 5 path @apt-snapshot-2018-08-22_11:32:41
> ID 15398 gen 2317920 top level 5 path @apt-snapshot-2018-08-23_21:11:42
> 
> I try
> btrfs subvolume delete @apt-snapshot-2018-08-23_21:11:42
> but no luck.
> I don't understand. If the "btrfs subvolume list" has an option for
> path, why doesn't the btrfs subvolume delete?
> It seems that the
> btrfs subvolume delete @apt-snapshot-2018-08-23_21:11:42
> is only looking for subvolumes on root and not a within a folder or
> external disk.
> 
> Can anybody help me with deleting an apt-snapshot that is on an
> external disk, and thus not mounted as /   ?

   btrfs sub delete takes a path to a subvolume within the visible
filename tree (i.e. from /)

   The filesystem must therefore be mounted somewhere, and the
subvolume to be deleted must be visible under that mount. In your
case, the filesystem is mounted at /foldername, so:

   btrfs sub del /foldername/@apt-snapshot-2018-08-23_21:11:42

   If you think of subvolumes as directories with a few caveats and
special powers, then "btrfs sub del" is equivalent to "rm -rf", and
you'd use the same parameters in the same way for the same reason.

   Hugo.

-- 
Hugo Mills             | ... one ping(1) to rule them all, and in the
hugo@... carfax.org.uk | darkness bind(2) them.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                                Illiad
