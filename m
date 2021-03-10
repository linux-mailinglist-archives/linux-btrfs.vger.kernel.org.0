Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08EB3336D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 09:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhCJIAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 03:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCJIAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 03:00:00 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D23C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Mar 2021 23:59:59 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1lJtl7-0002rf-BI
        for linux-btrfs@vger.kernel.org; Wed, 10 Mar 2021 07:59:57 +0000
Date:   Wed, 10 Mar 2021 07:59:57 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: nfs subvolume access?
Message-ID: <20210310075957.GG22502@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs@vger.kernel.org
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310074620.GA2158@tik.uni-stuttgart.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 08:46:20AM +0100, Ulli Horlacher wrote:
> When I try to access a btrfs filesystem via nfs, I get the error:
> 
> root@tsmsrvi:~# mount tsmsrvj:/data/fex /nfs/tsmsrvj/fex
> root@tsmsrvi:~# time find /nfs/tsmsrvj/fex | wc -l
> find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.
> 1
> root@tsmsrvi:~# 
> 
> 
> 
> On tsmsrvj I have in /etc/exports:
> 
> /data/fex       tsmsrvi(rw,async,no_subtree_check,no_root_squash)
> 
> This is a btrfs subvolume with snapshots:
> 
> root@tsmsrvj:~# btrfs subvolume list /data
> ID 257 gen 35 top level 5 path fex
> ID 270 gen 36 top level 257 path fex/spool
> ID 271 gen 21 top level 270 path fex/spool/.snapshot/2021-03-07_1453.test
> ID 272 gen 23 top level 270 path fex/spool/.snapshot/2021-03-07_1531.test
> ID 273 gen 25 top level 270 path fex/spool/.snapshot/2021-03-07_1532.test
> ID 274 gen 27 top level 270 path fex/spool/.snapshot/2021-03-07_1718.test
> 
> root@tsmsrvj:~# find /data/fex | wc -l
> 489887
> root@tsmsrvj:~# 
> 
> What must I add to /etc/exports to enable subvolume access for the nfs
> client?
> 
> tsmsrvi and tsmsrvj (nfs client and server) both run Ubuntu 20.04 with
> btrfs-progs v5.4.1 

   I can't remember if this is why, but I've had to put a distinct
fsid field in each separate subvolume being exported:

/srv/nfs/home     -rw,async,fsid=0x1730,no_subtree_check,no_root_squash

   It doesn't matter what value you use, as long as each one's
different.

   Hugo.

-- 
Hugo Mills             | Alert status mauve ocelot: Slight chance of
hugo@... carfax.org.uk | brimstone. Be prepared to make a nice cup of tea.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
