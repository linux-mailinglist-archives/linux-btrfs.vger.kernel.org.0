Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0C42036C
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Oct 2021 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhJCSXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Oct 2021 14:23:36 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40322 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhJCSXg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Oct 2021 14:23:36 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4181CBA3FB6; Sun,  3 Oct 2021 14:21:48 -0400 (EDT)
Date:   Sun, 3 Oct 2021 14:21:48 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     brandonh@wolfram.com, linux-btrfs@vger.kernel.org
Subject: Re: btrfs metadata has reserved 1T of extra space and balances don't
 reclaim it
Message-ID: <20211003182148.GP29026@hungrycats.org>
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
 <ce9f317.4dc05cb0.17c3070258f@tnonline.net>
 <2117366261.1733598.1632926066120.JavaMail.zimbra@wolfram.com>
 <cda76e1b-b98a-4b13-19b1-2cf6ea8b4cf4@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda76e1b-b98a-4b13-19b1-2cf6ea8b4cf4@tnonline.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 03, 2021 at 01:26:24PM +0200, Forza wrote:
> 
> 
> On 2021-09-29 16:34, Brandon Heisner wrote:
> > No I do not use that option.  Also, because of btrfs not mounting individual subvolume options, I have the compression and nodatacow set with filesystem attributes on the directories that are btrfs subvolumes.
> > 
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra           btrfs   subvol=zimbra,defaults,discard,compress=lzo 0 0
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /var/log              btrfs   subvol=root-var-log,defaults,discard,compress=lzo 0 0
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/db        btrfs   subvol=db,defaults,discard,nodatacow 0 0
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/index     btrfs   subvol=index,defaults,discard,compress=lzo 0 0
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/store     btrfs   subvol=store,defaults,discard,compress=lzo 0 0
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/log       btrfs   subvol=log,defaults,discard,compress=lzo 0 0
> > UUID=ece150db-5817-4704-9e84-80f7d8a3b1da /opt/zimbra/snapshots btrfs   subvol=snapshots,defaults,discard,compress=lzo 0 0
> > 
> > 
> 
> It might be worth looking into discard=async (*) or setting up regular
> fstrim instead of doing the discard mount option.

Brandon's kernel (4.9.5 from 2017) is three years too old to have working
discard=async.

Upgrading the kernel would most likely fix the problems even without
changing mount options.

> * async discard:
> "mount -o discard=async" to enable it freed extents are not discarded
> immediatelly, but grouped together and trimmed later, with IO rate limiting
> * https://lore.kernel.org/lkml/cover.1580142284.git.dsterba@suse.com/
